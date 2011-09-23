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
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

	String id_grup = request.getParameter("id_grup");

	String q =
		 " select	B.menu_id"
		+" ,		B.menu_name"
		+" ,		C.menu_id +' - '+ C.menu_name 'menu_parent'"
		+" ,		isnull(A.ha_level, 0) 'ha_level'"
		+" from		__hak_akses	A"
		+" right join	__menu		B"
		+" on	A.menu_id		= B.menu_id"
		+" and	A.id_grup		= "+ id_grup
		+" ,		__menu		C"
		+" where 	B.menu_leaf	= '1'"
		+" and		B.menu_parent	= C.menu_id"
		+" order by     B.menu_id";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="['"+ rs.getString("menu_parent") +"'"
			+ ",'"+ rs.getString("menu_id") +"'"
			+ ",'"+ rs.getString("menu_name") +"'"
			+ ",'"+ rs.getString("ha_level") +"'"
			+ ",'"+ rs.getString("ha_level") +"'"
			+ "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
