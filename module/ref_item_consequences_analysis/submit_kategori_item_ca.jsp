<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Agus Sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}
	
	Statement	db_stmt = db_con.createStatement();

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String id_user					= (String) session.getAttribute("user.nipg");
	String id_kategori_item_ca		= request.getParameter("id_kategori_item_ca");
	String nama_kategori_item_ca	= request.getParameter("nama_kategori_item_ca");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_kategori_item_ca ("
			+"	nama_kategori_item_ca "
			+" ,	id_user "
			+" ) values ("
			+" '"+ nama_kategori_item_ca +"' "
			+",'"+ id_user +"')";
		break;
	case 3:
		q	=" update	r_kategori_item_ca "
			+" set		nama_kategori_item_ca	= '"+ nama_kategori_item_ca +"' "
			+" ,		id_user	= '"+ id_user +"' "
			+" where	id_kategori_item_ca	= "+ id_kategori_item_ca;
		break;
	case 4:
		q	=" delete from	r_kategori_item_ca "
			+" where	id_kategori_item_ca = "+ id_kategori_item_ca;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
