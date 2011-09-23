<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya(prasetya.yanuar@googlemail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_user = (String) session.getAttribute("user.nipg");

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_kat	= request.getParameter("id_kat");
	String id_item	= request.getParameter("id_item");
	String id	= request.getParameter("id");
	String name	= request.getParameter("name");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_item_detail_pssr ("
			+"	id_kategori_item_pssr "
			+",	id_item_pssr "
			+",	nama_item_detail_pssr "
			+",	id_user "
			+" ) values ("
			+ id_kat +", "
			+ id_item +", '"
			+ name +"', '"
			+ id_user +"' )";
		break;
	case 3:
		q	=" update	r_item_detail_pssr "
			+" set		nama_item_detail_pssr	= '"+ name +"' "
			+" ,		id_user				= '"+ id_user +"' "
			+" ,		tanggal_akses			= getdate() "
			+" where	id_kategori_item_pssr		= "+ id_kat
			+" and		id_item_pssr		= "+ id_item
			+" and		id_item_detail_pssr	= "+ id;
		break;
	case 4:
		q	=" delete	from r_item_detail_pssr "
			+" where	id_kategori_item_pssr		= "+ id_kat
			+" and		id_item_pssr		= "+ id_item
			+" and		id_item_detail_pssr	= "+ id;
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
