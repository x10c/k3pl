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
	String		name	= request.getParameter("name");
	String		path	= config.getServletContext().getRealPath("/");
	String		repo_rca= "/repository/rca/";
	File		f;

	db_stmt = db_con.createStatement();

	path += repo_rca + id +"/"+ name;

	/* delete file from system */
	f = new File(path);

	if (f.isDirectory()) {
		String[] files = f.list();

		if (files.length > 0) {
			_return.put ("success", false);
			_return.put ("info", "Direktori memiliki isi, tidak dapat dihapus!");
			out.print (_return);
			return;
		}
	}

	if (f.exists()) {
		f.delete();
	}

	/* delete file from database */
	db_q=" delete from t_rca_images"
		+" where	id_rca		= "+ id
		+" and		image_name	= '"+ name +"'";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "'"+ name +"' telah dihapus!");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
