<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray	menu	= null;
	String		id_grup	= request.getParameter ("id_grup");
	String		menu_id	= "";

	db_stmt = db_con.createStatement ();
	db_q	=" select		B.menu_id"
			+" ,			B.menu_name"
			+" ,			C.menu_id +' - '+ C.menu_name 'menu_parent'"
			+" ,			isnull(A.ha_level, 0) 'ha_level'"
			+" from			__hak_akses		A"
			+" right join	__menu			B"
			+" on			A.menu_id		= B.menu_id"
			+" and			A.id_grup		= "+ id_grup
			+" ,			__menu			C"
			+" where 		B.menu_leaf		= '1'"
			+" and			B.menu_parent	= C.menu_id"
			+" order by     B.menu_id";
	db_rs	= db_stmt.executeQuery (db_q);

	json_a	= new JSONArray ();
	while (db_rs.next()) {
		menu_id = db_rs.getString ("menu_id");

		if ("01.04".equals (menu_id)
		||  "01.05".equals (menu_id)
		||  "01.08".equals (menu_id)) {
			if ("1".equals (user_group)) {
				menu = new JSONArray ();
				menu.put (db_rs.getString ("menu_parent"));
				menu.put (menu_id);
				menu.put (db_rs.getString ("menu_name"));
				menu.put (db_rs.getString ("ha_level"));
				menu.put (db_rs.getString ("ha_level"));
				json_a.put (menu);
			}
		} else {
			menu = new JSONArray ();
			menu.put (db_rs.getString ("menu_parent"));
			menu.put (menu_id);
			menu.put (db_rs.getString ("menu_name"));
			menu.put (db_rs.getString ("ha_level"));
			menu.put (db_rs.getString ("ha_level"));
			json_a.put (menu);
		}
	}

	out.print (json_a);

	db_rs.close();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
