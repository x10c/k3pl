<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_kel_jabatan_komite	= request.getParameter("id_kel");

	if ( id_kel_jabatan_komite.equals("0")
		|| id_kel_jabatan_komite.equals("")) {
		id_kel_jabatan_komite ="0 or 1 = 1 ";
	}

	String q=" select	A.nipg "
		+" ,		B.nama_pegawai "
		+" ,		A.id_jabatan_komite "
		+" ,		C.nama_jabatan_komite "
		+" from		t_pegawai_komite_sub_komite		A "
		+" left join "
		+" 		r_pegawai	B on A.nipg = B.nipg "
		+" left join "
		+" 		r_jabatan_komite_sub_komite	C on A.id_jabatan_komite = C.id_jabatan_komite "
		+" where C.id_kel_jabatan_komite_sub_komite = "+ id_kel_jabatan_komite
		+" order by	A.nipg";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "{ rows: [";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ nipg			: '"+ rs.getString("nipg") +"' "
			+ ", nama_pegawai	: '"+ rs.getString("nama_pegawai") +"' "
			+ ", id_jabatan_komite			: '"+ rs.getString("id_jabatan_komite") +"' "
			+ ", nama_jabatan_komite		: '"+ rs.getString("nama_jabatan_komite") +"' "
			+  "}";
	}

	data += "]}";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
