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
	int			type	= Integer.parseInt(request.getParameter("type"));
	File		f;

	db_stmt = db_con.createStatement();

	/* REJECT "Kontraktor/Dokumen Klaim" deletion */
	if (id.equals("3")) {
			out.print("{success:false"
				+",info:'Direktori ini tidak dapat dihapus karena digunakan oleh referensi Kontraktor!'}");
			return;
	}

	/* check if document is used in ref. kontraktor */
	db_q	=" select	1"
			+" from		r_kontraktor_klm"
			+" where	id_repo = "+ id;

	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
			out.print("{success:false"
				+",info:'Berkas ini dipakai pada Referensi Kontraktor!'}");
			db_rs.close ();
			return;
	}

	path += request.getParameter("path") +"/"+ name;

	log ("delete:"+ path);

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
	db_q=" delete from t_repo"
		+" where id = "+ id;

	db_stmt.executeUpdate (db_q);

	out.print("{success:true,info:'\""+ name +"\" telah dihapus!'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
