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
	String no_dokumen						= request.getParameter("no_dokumen");
	String revisi							= request.getParameter("revisi");
	String no_kontrak						= request.getParameter("no_kontrak");
	String nama_perusahaan					= request.getParameter("nama_perusahaan");
	String nama_proyek						= request.getParameter("nama_proyek");
	String nama_pic							= request.getParameter("nama_pic");
	String aktifitas_pekerjaan				= request.getParameter("aktifitas_pekerjaan");
	String tanggal_jsa						= request.getParameter("tanggal_jsa");
	String alat_pelindung_diri_digunakan	= request.getParameter("alat_pelindung_diri_digunakan");
	String id_user							= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_jsa (no_dokumen, revisi, no_kontrak, nama_perusahaan, nama_proyek, nama_pic, "
			+" aktifitas_pekerjaan, tanggal_jsa, alat_pelindung_diri_digunakan, id_user) "
			+" values ('"+ no_dokumen +"' ,'"+ revisi +"' ,'"+ no_kontrak +"' ,'"+ nama_perusahaan +"' ,'"+ nama_proyek +"' ,'"+ nama_pic +"' , "
			+" '"+ aktifitas_pekerjaan +"' ,'"+ tanggal_jsa +"' ,'"+ alat_pelindung_diri_digunakan +"' ,'"+ id_user +"' )";
		break;

	case 3:
		q	=" update	t_jsa "
			+" set		no_dokumen						= '"+ no_dokumen +"' "
			+" ,		revisi							= '"+ revisi +"' "
			+" ,		no_kontrak						= '"+ no_kontrak +"' "
			+" ,		nama_perusahaan					= '"+ nama_perusahaan +"' "
			+" ,		nama_proyek						= '"+ nama_proyek +"' "
			+" ,		nama_pic						= '"+ nama_pic +"' "
			+" ,		aktifitas_pekerjaan				= '"+ aktifitas_pekerjaan +"' "
			+" ,		tanggal_jsa						= '"+ tanggal_jsa +"' "
			+" ,		alat_pelindung_diri_digunakan	= '"+ alat_pelindung_diri_digunakan +"' "
			+" ,		id_user							= '"+ id_user +"' "
			+" ,		tanggal_akses					= getdate() "
			+" where	id_jsa							=  "+ id_jsa;
		break;

	case 4:
		q	=" delete from t_jsa "
			+" where  id_jsa =  "+ id_jsa;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
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
