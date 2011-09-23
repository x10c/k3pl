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

	Statement	db_stmt = db_con.createStatement();
	ResultSet	rs		= null;
	String		data	="[";

	q	=" select	id, name, dbo.fn_repo_get_path(pid, name) as path"
		+" from		t_repo"
		+" where	pid		= 3"
		+" and		type	= 1";

	rs = db_stmt.executeQuery(q);

	int i = 0;
	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}

		data+="[ "+ rs.getString("id")
			+ ",'"+ rs.getString("name").replace("'","\\'") +"'"
			+" ,'"+ rs.getString("path") +"'"
			+ "]";
	}

	data +="]";

	rs.close();
	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
