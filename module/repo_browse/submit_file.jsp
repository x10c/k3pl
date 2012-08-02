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
		out.print("{success:false,info:'Data kosong!'}");
		return;
	}

	String				rpath	= config.getServletContext().getRealPath("/");

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
	long				filesize=0;

	db_stmt	= db_con.createStatement();

	/* parse request */
	while (itr.hasNext()) {
		item = (FileItem) itr.next();
		if (item.isFormField()) {
			k = item.getFieldName();
			v = item.getString();

			if (k.equals("id")) {
				id = v;
			} else if (k.equals("path")) {
				path = v;
			} else if (k.equals("name")) {
				name = v;
			}
		} else {
			item_up		= item;
			filesize	= item.getSize();
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
		+" , "+ filesize
		+" ,'"+ user_nipg +"'"
		+" , ?"
		+" from		t_repo"
		+" where	id = "+ id
	);

	pstmt.setBinaryStream (1, ins);

	pstmt.executeUpdate ();

	ins.close ();

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"+ session.getAttribute("menu.id") +"','2')";

	db_stmt.executeUpdate (db_q);

	out.print("{success:true,info:'File telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
