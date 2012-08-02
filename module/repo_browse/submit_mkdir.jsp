<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%@ page import="java.io.File" %>
<%
try {
	String		pid		= request.getParameter("id");
	String		path	= request.getParameter("path");
	String		name	= request.getParameter("name");
	String		dir		= config.getServletContext().getRealPath("/") + path +"/"+ name;

	/* create directory in file system */
	File f = new File(dir);

	f.mkdir();

	/* insert directory name to database */
	db_stmt = db_con.createStatement();

	db_q=" insert into t_repo ("
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
		+" ,'"+ user_nipg +"'"
		+" , group_owner"
		+" , 0"
		+" , perm"
		+" ,'"+ user_nipg +"'"
		+" , getdate()"
		+" from		t_repo"
		+" where	id = "+ pid;

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','2')";

	db_stmt.executeUpdate (db_q);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
