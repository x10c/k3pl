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

	Statement	db_stmt = db_con.createStatement();
	ResultSet	rs		= null;
	String		q;
	String		id		= request.getParameter("id");
	String		pid		= request.getParameter("pid");
	String		data;

 	q	=" select	id"
		+" ,		type"
		+" ,		name"
		+" ,		owner"
		+" ,		group_owner"
		+" ,		size"
		+" ,		perm"
		+" ,		uploader"
		+" ,		replace(convert(varchar, upload_date, 120), '/', '-') upload_date"
		+" from		t_repo"
		+" where	pid		= "+ id
		+" order by type asc";

	rs = db_stmt.executeQuery(q);

	data	="{data:[{"
			+" 	id		: "+ pid
			+", type	: 0"
			+", name	:'..'"
			+"}";

	while (rs.next()) {
		data	+=",{"
				+ "	id			: "+ rs.getString("id")
				+ ",type		: "+ rs.getString("type")
				+ ",pid			: "+ id
				+ ",name		:'"+ rs.getString("name") +"'"
				+ ",owner		: "+ rs.getString("owner")
				+ ",group_owner	: "+ rs.getString("group_owner")
				+ ",size		: "+ rs.getString("size")
				+ ",perm		: "+ rs.getString("perm")
				+ ",uploader	: "+ rs.getString("uploader")
				+ ",upload_date	:'"+ rs.getString("upload_date") +"'"
				+ "}";
	}

	data += "]}";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
