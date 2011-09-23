<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya(prasetya.yanuar@googlemail.com)
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

	String		id_kate	= request.getParameter("id_kat");
	String		id_item	= request.getParameter("id_item");

	String q=" select	id_item_detail_pssr "
		+" ,		nama_item_detail_pssr "
		+" from		r_item_detail_pssr "
		+" where	id_kategori_item_pssr	= "+ id_kate
		+" and		id_item_pssr	= "+ id_item
		+" order by	id_item_detail_pssr ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data	+="[ '"+ rs.getString("id_item_detail_pssr") +"' "
			+ ", '"+ rs.getString("nama_item_detail_pssr") +"' ]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
