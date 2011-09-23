<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
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

	String q=" select	A.id_insiden"
		+" ,		B.nama_seksi as nama_area"
		+" ,		D.nama_klasifikasi_pegawai"
		+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal"
		+" from		t_insiden		A"
		+" ,		r_seksi			B"
		+" ,		r_klasifikasi_pegawai	D"
		+" where	A.id_area_seksi			= B.id_seksi"
		+" and		A.id_klasifikasi_pegawai	= D.id_klasifikasi_pegawai"
		+" order by	A.id_insiden";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("id_insiden")
			+ "','"+ rs.getString("tanggal")
			+ "','"+ rs.getString("nama_area")
			+ "','"+ rs.getString("nama_klasifikasi_pegawai")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
