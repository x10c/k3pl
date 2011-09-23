<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
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
	String		pid		= request.getParameter("id");
	String		path	= request.getParameter("path");
	String		name	= request.getParameter("name");
	String		owner	= (String) session.getAttribute("user.nipg");
	String		dir		= config.getServletContext().getRealPath("/") + path +"/"+ name;

	q	=" insert into t_repo ("
		+"	 pid"
		+" , type"
		+" , name"
		+" , owner"
		+" , group_owner"
		+" , size"
		+" , perm"
		+" , uploader"
		+" , upload_date"
		+")"
		+" select "
		+	pid
		+" , 0"
		+" ,'"+ name +"'"
		+" ,'"+ owner +"'"
		+" , group_owner"
		+" , 0"
		+" , perm"
		+" ,'"+ owner +"'"
		+" , getdate()"
		+" from		t_repo"
		+" where	id = "+ pid;

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ owner +"','"
		+ session.getAttribute("menu.id") +"','2')";

	db_stmt.executeUpdate(q);

	File f = new File(dir);

	f.mkdir();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
