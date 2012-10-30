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
	String		id_rca	= request.getParameter("id_rca");
	String		name	= request.getParameter("name");
	String		path	= config.getServletContext().getRealPath("/");
	String		repo_rca= "/repository/rca/";
	File		f;

	path += repo_rca + id_rca +"/"+ name;

	/* delete file from system */
	f = new File(path);

	if (f.exists()) {
		f.delete();
	} else {
		_return.put ("success", false);
		_return.put ("info", "File '"+ path +"' tidak ditemukan di server!");
		out.print (_return);
		return;
	}

	/* delete file from database */
	db_q=" delete from t_rca_images"
		+" where	id			= "+ id;

	db_stmt = db_con.createStatement();
	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "'"+ name +"' telah dihapus!");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
