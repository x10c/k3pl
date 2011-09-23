<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q	= "";
String q2	= "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	Statement	db_stmt2	= db_con.createStatement();
	ResultSet	rs;
	ResultSet	rs2;

	String	gid	= request.getParameter("id");
	String	peserta;
	String	id;
	String	o;
	int	i = 0;
	int	j = 0;

	q	=" select	A.id"
		+" ,		A.id_pelatihan"
		+" ,		A.penyelenggara"
		+" ,		A.tempat"
		+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal"
		+" ,		A.lama"
		+" from		t_pelatihan	A";

	if (gid != null && !gid.equals("")) {
		q += " where	A.id = "+ gid;
	}

	q	+=" order by	A.tanggal	DESC"
		 +" ,		A.id_pelatihan	ASC";

	rs = db_stmt.executeQuery(q);

	o = "{rows:[";
	while (rs.next()) {
		if (i > 0) {
			o += ",";
		} else {
			i = 1;
		}

		id	= rs.getString("id");

		peserta = "[";
		if (gid != null && !gid.equals("")) {
			q2	=" select	nipg"
				+" from		t_pelatihan_peserta"
				+" where	id = "+ id;

			rs2 = db_stmt2.executeQuery(q2);

			j = 0;
			while (rs2.next()) {
				if (j > 0) {
					peserta += ",";
				} else {
					j = 1;
				}

				peserta += "['"+ rs2.getString("nipg") +"']";
			}
			rs2.close();
		}
		peserta += "]";

		o	+="{id			:"+ id
			+ ",id_pelatihan	:"+ rs.getString("id_pelatihan")
			+ ",penyelenggara	:\""+ rs.getString("penyelenggara") +"\""
			+ ",tempat		:\""+ rs.getString("tempat") +"\""
			+ ",tanggal		:\""+ rs.getString("tanggal") +"\""
			+ ",lama		:"+ rs.getString("lama")
			+ ",peserta		:"+ peserta
			+ "}";
	}
	o += "]}";

	rs.close();

	out.print(o);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
