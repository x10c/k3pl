<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

	q	=" select"
		+" 			menu_id"
		+" ,		menu_name"
		+" from		__menu"
		+" order by	menu_id";

	ResultSet	rs		= db_stmt.executeQuery(q);
	String		data	= "[";
	int			i		= 0;

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		data+= "['"+ rs.getString("menu_id") +"'"
			+  ",\""+ rs.getString("menu_name") +"\""
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
