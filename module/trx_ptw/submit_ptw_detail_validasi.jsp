<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();	

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_ptw				= request.getParameter("id_ptw");
	String id_ptw_validasi		= request.getParameter("id_ptw_validasi");
	String hari					= request.getParameter("hari");
	String waktu_mulai			= request.getParameter("waktu_mulai");
	String waktu_selesai		= request.getParameter("waktu_selesai");
	String nama_pelaksana		= request.getParameter("nama_pelaksana");
	String inisial_pelaksana	= request.getParameter("inisial_pelaksana");
	String nama_pengawas		= request.getParameter("nama_pengawas");
	String inisial_pengawas		= request.getParameter("inisial_pengawas");
	String id_user				= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_ptw_validasi(id_ptw, hari, waktu_mulai, waktu_selesai, nama_pelaksana, inisial_pelaksana, nama_pengawas, inisial_pengawas, id_user) "
			+" values ("
			+ id_ptw +", '"
			+ hari +"', '"
			+ waktu_mulai +"', '"
			+ waktu_selesai +"', '"
			+ nama_pelaksana +"', '"
			+ inisial_pelaksana +"', '"
			+ nama_pengawas +"', '"
			+ inisial_pengawas +"', '"
			+ id_user +"') ";
		break;
	case 3:
		q	=" update	t_ptw_validasi "
			+" set		hari				= "+ hari +" "
			+" ,		waktu_mulai			= '"+ waktu_mulai +"' "
			+" ,		waktu_selesai		= '"+ waktu_selesai +"' "
			+" ,		nama_pelaksana		= '"+ nama_pelaksana +"' "
			+" ,		inisial_pelaksana	= '"+ inisial_pelaksana +"' "
			+" ,		nama_pengawas		= '"+ nama_pengawas +"' "
			+" ,		inisial_pengawas	= '"+ inisial_pengawas +"' "
			+" ,		id_user				= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_ptw				= "+ id_ptw
			+" and		id_ptw_validasi		= "+ id_ptw_validasi;
		break;
	case 4:
		q	=" delete from	t_ptw_validasi "
			+" where	id_ptw			= "+ id_ptw
			+" and		id_ptw_validasi	= "+ id_ptw_validasi;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{ success: true, info:'Data telah tersimpan.' }");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
