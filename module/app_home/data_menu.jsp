<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	db_stmt = db_con.createStatement();

	db_q
	=" select"
	+" 			menu_id"
	+" ,		menu_name"
	+" from		__menu"
	+" order by	menu_id";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	JSONArray menu = null;

	while (db_rs.next()) {
		menu = new JSONArray ();
		menu.put (db_rs.getString ("menu_id"));
		menu.put (db_rs.getString ("menu_name"));

		json_a.put (menu);
	}

	out.print (json_a);

	db_rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
