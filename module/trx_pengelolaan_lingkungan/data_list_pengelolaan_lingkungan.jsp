<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
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

	String q=" select	A.id_pengelolaan_lingkungan "
		+" ,		B.nama_wilayah "
		+" ,		replace(convert(varchar, A.tanggal_pengelolaan_lingkungan, 111), '/', '-') tanggal_pengelolaan_lingkungan "
		+" ,		A.lokasi_pengelolaan_lingkungan "
		+" ,		A.tipe_station "
		+" from		t_pengelolaan_lingkungan	A "
		+" ,		r_wilayah					B "
		+" where	B.id_wilayah	= A.id_wilayah "
		+" order by	A.id_pengelolaan_lingkungan ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("id_pengelolaan_lingkungan")
			+ "','"+ rs.getString("nama_wilayah")
			+ "','"+ rs.getString("tanggal_pengelolaan_lingkungan")
			+ "','"+ rs.getString("lokasi_pengelolaan_lingkungan")
			+ "','"+ rs.getString("tipe_station")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
