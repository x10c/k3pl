<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%@ page import="java.io.File" %>
<%
try {
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

	log ("rename: '"+ name_from +"' to '"+ name_to +"'");

	f_from	= new File(name_from);
	f_to	= new File(name_to);

	f_from.renameTo (f_to);

	db_stmt = db_con.createStatement();

	db_q=" update	t_repo"
		+" set		name		='"+ to +"'"
		+" ,		upload_date	= getdate()"
		+" where	id			= "+ id;

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Berkas '"+ name_from +"' telah diubah nama menjadi '"+ name_to +"'.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
