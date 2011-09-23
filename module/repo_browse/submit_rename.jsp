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
	String		id		= request.getParameter("id");
	String		path	= request.getParameter("path");
	String		from	= request.getParameter("from");
	String		to		= request.getParameter("to");
	String		rpath	= config.getServletContext().getRealPath("/");
	String		name_from;
	String		name_to;
	File		f_from	= null;
	File		f_to	= null;

	name_from	= rpath +"/"+ path +"/"+ from;
	name_to		= rpath +"/"+ path +"/"+ to;

	log("rename: '"+ name_from +"' to '"+ name_to +"'");

	f_from	= new File(name_from);
	f_to	= new File(name_to);

	f_from.renameTo(f_to);

	q	=" update	t_repo"
		+" set		name		='"+ to +"'"
		+" ,		upload_date	= getdate()"
		+" where	id			= "+ id;

	db_stmt.executeUpdate(q);

} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
