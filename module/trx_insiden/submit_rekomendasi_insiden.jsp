<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();

	Statement	db_stmt		= db_con.createStatement();	

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String id_insiden				= request.getParameter("id_insiden");
	String id_insiden_rekomendasi	= request.getParameter("id_insiden_rekomendasi");
	String rekomendasi				= request.getParameter("rekomendasi");
	String penanggung_jawab			= request.getParameter("penanggung_jawab");
	String tanggal_selesai			= request.getParameter("tanggal_selesai");
	String id_user					= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_insiden_rekomendasi(id_insiden, rekomendasi, penanggung_jawab, tanggal_selesai, id_user) "
			+" values ("
			+ id_insiden +", '"
			+ rekomendasi +"', '"
			+ penanggung_jawab +"', '"
			+ tanggal_selesai +"', '"
			+ id_user +"') ";
		break;

	case 3:
		q	=" update	t_insiden_rekomendasi "
			+" set		rekomendasi				= '"+ rekomendasi +"' "
			+" ,		penanggung_jawab		= '"+ penanggung_jawab +"' "
			+" ,		tanggal_selesai			= '"+ tanggal_selesai +"' "
			+" ,		id_user					= '"+ id_user +"' "
			+" ,		tanggal_akses			= getdate() "
			+" where	id_insiden				= "+ id_insiden
			+" and		id_insiden_rekomendasi	= "+ id_insiden_rekomendasi;
		break;

	case 4:
		q	=" delete from	t_insiden_rekomendasi "
			+" where	id_insiden				= "+ id_insiden
			+" and		id_insiden_rekomendasi	= "+ id_insiden_rekomendasi;
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
