<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Agus Sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String q=" select	id_kategori_item_ca "
		+" ,		id_item_ca "
		+" ,		nama_item_ca "
		+" from		r_item_ca "
		+" order by	id_item_ca, id_kategori_item_ca";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="["+ rs.getString("id_kategori_item_ca")
			+ ","+ rs.getString("id_item_ca")
			+ ",'"+ rs.getString("nama_item_ca") +"'"
			+ "]";
	}
	data += "]";

	out.print(data);

	rs.close();
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
