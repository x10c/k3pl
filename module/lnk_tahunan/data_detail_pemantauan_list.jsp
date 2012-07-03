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
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt 				= db_con.createStatement();
	String		id_lingkungan_tahunan	= request.getParameter("id_lingkungan_tahunan");
	
	String q
		=" select	a.id_lingkungan_tahunan "
		+" ,		a.id_komponen_lingkungan "
		+" ,		b.nama_komponen_lingkungan "
		+" from		t_lingkungan_detail		as a "
		+" ,		r_komponen_lingkungan	as b "
		+" where	a.id_komponen_lingkungan	= b.id_komponen_lingkungan "
		+" and		a.id_lingkungan_tahunan 	= "+ id_lingkungan_tahunan
		+" order by	a.id_lingkungan_tahunan, a.id_komponen_lingkungan ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data+="["+ rs.getString("id_lingkungan_tahunan")
			+ ","+ rs.getString("id_komponen_lingkungan")
			+ ",'"+ rs.getString("nama_komponen_lingkungan")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
