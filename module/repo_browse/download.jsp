<%--
 % Copyright 2012 - kilabit.org
 %
 % Author(s):
 %	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.DataInputStream" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%
ServletOutputStream	ostream = response.getOutputStream();
try {
	String	berkas_id	= request.getParameter ("id");
	String	name		= "";
	int		size		= 0;
	byte[]	content;

	db_stmt	= db_con.createStatement();

	db_q=" select	name, size, berkas"
		+" from		t_repo"
		+" where	id = "+ berkas_id;

	db_rs = db_stmt.executeQuery (db_q);

	if (! db_rs.next ()) {
		_return.put ("success", false);
		_return.put ("info", "Data berkas tidak didapat!");
		out.print (_return);
		db_rs.close ();
		return;
	}

	name	= db_rs.getString ("name");
	size	= db_rs.getInt ("size");
	content	= db_rs.getBytes ("berkas");

	db_rs.close ();

	response.setContentType ("application/octet-stream");
	response.setContentLength (content.length);
	response.setHeader("Content-Disposition","attachment;filename="+ name);

	ostream.write (content, 0, content.length);

	ostream.flush ();
	ostream.close ();
} catch (Exception e) {
	ostream.flush ();
	ostream.close ();

	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
