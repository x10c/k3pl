<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
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
	String		id				= "";
	String		date_uploaded	= "";
	String		filename		= "";
	String		description		= "";

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

	/* parse request */
	boolean is_multipart = ServletFileUpload.isMultipartContent(request);
	if (!is_multipart) {
		out.print("{success:false,info:'Data kosong!'}");
		return;
	}

	FileItemFactory		factory	= new DiskFileItemFactory();
	ServletFileUpload	upload	= new ServletFileUpload(factory);
	List				items	= upload.parseRequest(request);
	Iterator			itr		= items.iterator();
	File				fpic	= null;
	FileItem			item	= null;
	FileItem			item_p	= null;
	String				k		= null;
	String				v		= null;

	while (itr.hasNext()) {
		item = (FileItem) itr.next();
		if (item.isFormField()) {
			k = item.getFieldName();
			v = item.getString();

			if (k.equals("dml_type")) {
				dml = Integer.parseInt(v);
			} else if (k.equals("id")) {
				id = v;
			} else if (k.equals("filename")) {
				filename = v;
			} else if (k.equals("description")) {
				description = v;
			}
		} else {
			item_p = item;
		}
	}

	switch (dml) {
	case 2:
		filename = item_p.getName();

		if (filename != null || !filename.equals("")) {
			fpic = new File(realpath + gallery_path +"/"+ filename);

			log("file write: "+ fpic.toString());

			item_p.write(fpic);
		}

		q	=" insert into t_home_gallery ("
			+"	 date_uploaded"
			+" , filename"
			+" , description"
			+" ) values ("
			+"	getdate()"
			+" ,'"+ filename +"'"
			+" ,'"+ description +"'"
			+" )";
		break;

	case 3:
		q	=" update	t_home_gallery"
			+" set		description	= '"+ description +"'"
			+" where	id = "+ id;
		break;

	case 4:
		fpic = new File(realpath + gallery_path +"/"+ filename);

		log("fpic: "+ fpic.toString());

		if (fpic.exists()) {
			fpic.delete();
		}

		q	=" delete from	t_home_gallery"
			+" where		id = "+ id;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
