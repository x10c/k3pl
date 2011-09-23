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

	String		id_pengelolaan_lingkungan = (String) request.getParameter("id_pengelolaan_lingkungan");
	ResultSet	rs;
	String		q;
	String		data;
	int		i	= 0;

	q=" select	id_wilayah "
	+" ,		replace(convert(varchar, tanggal_pengelolaan_lingkungan, 111), '/', '-') tanggal_pengelolaan_lingkungan "
	+" ,		lokasi_pengelolaan_lingkungan "
	+" ,		tipe_station "
	+" ,		parameter "
	+" ,		sumber_dampak "
	+" from		t_pengelolaan_lingkungan "
	+" where	id_pengelolaan_lingkungan	= "+ id_pengelolaan_lingkungan;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Pengelolaan Lingkungan tidak ditemukan!'}");
		return;
	}

	data	="{  id_pengelolaan_lingkungan	: '"+ id_pengelolaan_lingkungan
		+"', id_wilayah						: '"+ rs.getString("id_wilayah")
		+"', tanggal_pengelolaan_lingkungan	: '"+ rs.getString("tanggal_pengelolaan_lingkungan")
		+"', lokasi_pengelolaan_lingkungan	: '"+ rs.getString("lokasi_pengelolaan_lingkungan")
		+"', tipe_station					: '"+ rs.getString("tipe_station")
		+"', parameter						: '"+ rs.getString("parameter")
		+"', sumber_dampak					: '"+ rs.getString("sumber_dampak")+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
