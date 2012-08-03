<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%
try {
	boolean is_multipart = ServletFileUpload.isMultipartContent(request);
	if (!is_multipart) {
		_return.put ("success", false);
		_return.put ("info", "Data kosong!");
		out.print (_return);
		return;
	}

	String				rpath	= config.getServletContext().getRealPath("/");
	int					content_length	= Integer.parseInt (request.getHeader ("Content-Length"));

	FileItemFactory		factory	= new DiskFileItemFactory();
	ServletFileUpload	upload	= new ServletFileUpload(factory);
	List				items	= upload.parseRequest(request);
	Iterator			itr		= items.iterator();

	FileItem			item	= null;
	FileItem			item_up	= null;
	String				k		= null;
	String				v		= null;
	String				id		="";
	String				path	="";
	String				name	="";
	long				file_sz	=0;
	long				max_sz	=0;

	/* check file size */
	db_stmt	= db_con.createStatement();
	db_q	=" select	repo_max_file_size"
			+" from		r_k3pl";
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		max_sz	= db_rs.getInt ("repo_max_file_size") * 1024 * 1024;
	} else {
		max_sz	= 10 * 1024 * 1024;
	}

	db_rs.close ();

	if (content_length > max_sz) {
		_return.put ("success", false);
		_return.put ("info", "Ukuran berkas melampaui batas. Maksimum "+ max_sz +" MB.");
		out.print (_return);
		return;
	}

	/* parse request */
	while (itr.hasNext()) {
		item = (FileItem) itr.next();
		if (item.isFormField()) {
			k = item.getFieldName();
			v = item.getString();

			if (k.equals("id")) {
				id = v;
			} else if (k.equals("name")) {
				name = v;
			}
		} else {
			item_up		= item;
			file_sz		= item.getSize();
		}
	}

	InputStream ins = item_up.getInputStream ();

	/* save file attribute to database */
	PreparedStatement pstmt = db_con.prepareStatement (
		" insert into t_repo ("
		+"		pid"
		+" ,	type"
		+" ,	name"
		+" ,	owner"
		+" ,	group_owner"
		+" ,	size"
		+" ,	uploader"
		+" ,	berkas"
		+" ) select "
		+		id
		+" ,	1"
		+" ,'"+	name +"'"
		+" ,'"+ user_nipg +"'"
		+" , group_owner"
		+" , "+ file_sz
		+" ,'"+ user_nipg +"'"
		+" , ?"
		+" from		t_repo"
		+" where	id = "+ id
	);

	pstmt.setBinaryStream (1, ins);

	pstmt.executeUpdate ();

	ins.close ();

	db_q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
			+ user_nipg +"','"+ session.getAttribute("menu.id") +"','2')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "File '"+ name +"' telah tersimpan.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
