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
	db_stmt = db_con.createStatement();

	Statement	db_stmt2	= db_con.createStatement();
	ResultSet	db_rs2		= null;
	int			i			= 0;
	int			j			= 0;
	JSONArray	children	= null;
	JSONObject	parent		= null;
	JSONObject	leaf		= null;

	db_q=" select	menu_name, menu_folder, menu_id, icon "
		+" from		__menu "
		+" where	menu_leaf = 0 "
		+" order by	menu_id ";

	db_rs = db_stmt.executeQuery(db_q);

	json_a = new JSONArray ();

	while (db_rs.next()) {
		parent = new JSONObject ();
		parent.put ("text", db_rs.getString ("menu_name"));
		parent.put ("id", db_rs.getString ("menu_folder"));
		parent.put ("iconCls", db_rs.getString ("icon"));

		db_q=" select distinct"
			+"	A.menu_id"
			+" ,	A.menu_name"
			+" ,	A.menu_folder"
			+" ,	A.menu_id"
			+" ,	A.icon"
			+" from		__menu		A"
			+" ,		__hak_akses	B"
			+" where	A.menu_id   	= B.menu_id"
			+" and		B.ha_level	>= 1"
			+" and		A.menu_parent	= "+ db_rs.getString("menu_id")
			+" and		B.id_grup   	in ("
			+"	select	id_grup"
			+"	from	__user_grup"
			+"	where	nipg = '"+ user_nipg +"'"
			+" )"
			+" order by	A.menu_id";

		db_rs2 = db_stmt2.executeQuery (db_q);

		if (!db_rs2.next()) {
			continue;
		}

		children = new JSONArray ();
		do {
			leaf = new JSONObject ();
			leaf.put ("text", db_rs2.getString ("menu_name"));
			leaf.put ("id", db_rs2.getString ("menu_folder"));
			leaf.put ("menu_id", db_rs2.getString ("menu_id"));
			leaf.put ("iconCls", db_rs2.getString ("icon"));
			leaf.put ("leaf", true);

			children.put (leaf);
		} while (db_rs2.next());

		parent.put ("children", children);
		json_a.put (parent);

		db_rs2.close();
	}

	db_rs.close ();

	out.print (json_a);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
