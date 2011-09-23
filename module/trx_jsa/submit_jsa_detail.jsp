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
	String id_jsa							= request.getParameter("id_jsa");
	String id_jsa_detail					= request.getParameter("id_jsa_detail");
	String urutan_langkah_pekerjaan_dasar	= request.getParameter("urutan_langkah_pekerjaan_dasar");
	String potensi_bahaya					= request.getParameter("potensi_bahaya");
	String rekomendasi_aksi					= request.getParameter("rekomendasi_aksi");
	String penanggung_jawab					= request.getParameter("penanggung_jawab");
	String id_user							= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_jsa_detail(id_jsa, urutan_langkah_pekerjaan_dasar, potensi_bahaya, "
			+" rekomendasi_aksi, penanggung_jawab, id_user) "
			+" values ("
			+ id_jsa +", '"
			+ urutan_langkah_pekerjaan_dasar +"', '"
			+ potensi_bahaya +"', '"
			+ rekomendasi_aksi +"', '"
			+ penanggung_jawab +"', '"
			+ id_user +"') ";
		break;

	case 3:
		q	=" update	t_jsa_detail "
			+" set		urutan_langkah_pekerjaan_dasar	= '"+ urutan_langkah_pekerjaan_dasar +"' "
			+" ,		potensi_bahaya					= '"+ potensi_bahaya +"' "
			+" ,		rekomendasi_aksi				= '"+ rekomendasi_aksi +"' "
			+" ,		penanggung_jawab				= '"+ penanggung_jawab +"' "
			+" ,		id_user							= '"+ id_user +"' "
			+" ,		tanggal_akses					= getdate() "
			+" where	id_jsa							= "+ id_jsa
			+" and		id_jsa_detail					= "+ id_jsa_detail;
		break;

	case 4:
		q	=" delete from	t_jsa_detail "
			+" where	id_jsa			= "+ id_jsa
			+" and		id_jsa_detail	= "+ id_jsa_detail;
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
