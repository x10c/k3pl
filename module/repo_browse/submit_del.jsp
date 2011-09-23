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
	String		name	= request.getParameter("name");
	String		path	= config.getServletContext().getRealPath("/");
	int			type	= Integer.parseInt(request.getParameter("type"));
	File		f;

	/* REJECT "Kontraktor/Dokumen Klaim" deletion */
	if (id.equals("3")) {
			out.print("{success:false"
				+",info:'Direktori ini tidak dapat dihapus karena digunakan"
				+" oleh referensi Kontraktor!'}");
			return;
	}

	path += request.getParameter("path") +"/"+ name;

	log("delete:"+ path);

	/* delete file from system */
	f = new File(path);

	if (f.isDirectory()) {
		String[] files = f.list();

		if (files.length > 0) {
			out.print("{success:false"
				+",info:'Direktori memiliki isi, tidak dapat dihapus!'}");
			return;
		}
	}

	if (f.exists()) {
		f.delete();
	}

	/* delete file from database */
	q	=" delete from t_repo"
		+" where id = "+ id;

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'\""+ name +"\" telah dihapus!'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
