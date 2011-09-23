<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %
 % TODO: replace with a single query.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
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
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	ResultSet	rs		= null;
	String		data;
	JSONArray	childs	= null;
	JSONObject	node	= new JSONObject();
	int			id		= 1;

	q	=" select repo_path from r_k3pl";
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false,info:'Direktori repositori belum di set!'}");
		return;
	}

	node.put("id", id);
	node.put("pid", 0);
	node.put("text", rs.getString("repo_path"));
	node.put("iconCls", "dir16");

	rs.close();

	childs = get_list_dir(id, db_con);

	if (childs.length() <= 0) {
		node.put("leaf", "true");
	} else {
		node.put("children", childs);
	}

	out.print("["+ node +"]");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
