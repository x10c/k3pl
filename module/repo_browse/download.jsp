<%--
 % Copyright 2012 - kilabit.org
 %
 % Author(s):
 %	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.DataInputStream" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%
ServletOutputStream	ostream = response.getOutputStream();
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement			db_stmt		= db_con.createStatement();
	ResultSet			rs			= null;
	String				berkas_id	= request.getParameter ("id");
	String				q			= "";
	String				name		= "";
	int					size		= 0;
	byte[]				content;

	q	=" select	name, size, berkas"
		+" from		t_repo"
		+" where	id = "+ berkas_id;

	rs = db_stmt.executeQuery (q);

	if (! rs.next ()) {
		out.print ("{success:false,info:'Data berkas tidak didapat!'}");
		return;
	}

	name	= rs.getString ("name");
	size	= rs.getInt ("size");
	content	= rs.getBytes ("berkas");

	response.setContentType ("application/octet-stream");
	response.setContentLength (content.length);
	response.setHeader("Content-Disposition","attachment;filename="+ name);

	ostream.write (content, 0, content.length);

	ostream.flush ();
	ostream.close ();
} catch (Exception e) {
	out.print ("{success:false,info:'"
			+ e.toString ().replace ("'","\\'").replace ("\"","\\\"") +"'}");
	ostream.flush ();
	ostream.close ();
}
%>
