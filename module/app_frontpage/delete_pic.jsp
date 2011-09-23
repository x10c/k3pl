<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.File"%>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	ResultSet	rs				= null;
	int			dml				= 0;
	String		realpath		= config.getServletContext().getRealPath("/");
	String		gallery_path	= "";
	String		id				= request.getParameter("id");
	String		filename		= request.getParameter("filename");
	File		fpic			= null;

	/* get gallery directory */
	q =" select gallery_path from r_k3pl";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false"
			+",info:'Tempat penyimpanan gambar (GALLERY_PATH) belum diset!'}");
		return;
	}

	gallery_path = rs.getString("gallery_path");

	if (gallery_path == null || gallery_path.equals("")) {
		out.print("{success:false"
			+",info:'Tempat penyimpanan gambar (GALLERY_PATH) belum diset!'}");
		return;
	}

	fpic = new File(realpath + gallery_path +"/"+ filename);

	log("fpic: "+ fpic.toString());

	if (fpic.exists()) {
		fpic.delete();
	}

	q	=" delete from	t_home_gallery"
		+" where		id = "+ id
		+"; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','4')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
