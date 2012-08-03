<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %
 % TODO: replace with a single query.
--%>
<%@ include file="../modinit.jsp" %>
<%!
public JSONArray get_list_dir(int id, Connection db_con)
{
	JSONArray	nodes	= new JSONArray();
try {
	Statement	db_stmt = db_con.createStatement();
	ResultSet	rs;
	String		q;
	String		name;
	JSONArray	childs	= null;
	JSONObject	node;

	q	=" select	id"
		+" ,		pid"
		+" ,		type"
		+" ,		name"
		+" ,		owner"
		+" ,		group_owner"
		+" ,		size"
		+" ,		perm"
		+" ,		uploader"
		+" ,		upload_date"
		+" from		t_repo"
		+" where	pid		= "+ id
		+" and		type	= 0";

	rs = db_stmt.executeQuery(q);

	while (rs.next()) {
		node	= new JSONObject();
		name	= rs.getString("name");
		id		= Integer.parseInt(rs.getString("id"));

		node.put("id", id);
		node.put("pid", rs.getString("pid"));
		node.put("text", name);
		node.put("owner", rs.getString("owner"));
		node.put("group_owner", rs.getString("group_owner"));
		node.put("perm", rs.getString("perm"));
		node.put("iconCls", "dir16");

		childs = get_list_dir(id, db_con);

		if (childs.length() <= 0) {
			node.put("leaf", "true");
		} else {
			node.put("children", childs);
		}

		nodes.put(node);
	}

	rs.close();

	return nodes;
} catch (Exception e) {
	log("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
	return nodes;
}}
%>
<%
try {
	int id = 1;

	json_o = new JSONObject();
	json_o.put("id", id);
	json_o.put("pid", 0);
	json_o.put("text", "Repository");
	json_o.put("iconCls", "dir16");

	json_a = get_list_dir (id, db_con);

	if (json_a.length() <= 0) {
		json_o.put("leaf", "true");
	} else {
		json_o.put("children", json_a);
	}

	out.print("["+ json_o +"]");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
