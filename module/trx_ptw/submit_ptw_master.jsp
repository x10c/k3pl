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
	Statement	db_stmt		= db_con.createStatement();	

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_jsa								= request.getParameter("id_jsa");
	String id_ptw								= (String) request.getParameter("id_ptw");
	String jenis_ptw							= request.getParameter("jenis_ptw");
	String nomor								= request.getParameter("nomor");
	String tgl_pengesahan						= request.getParameter("tgl_pengesahan");
	String masa_berlaku_awal					= request.getParameter("masa_berlaku_awal");
	String masa_berlaku_akhir					= request.getParameter("masa_berlaku_akhir");
	String lokasi_pekerjaan						= request.getParameter("lokasi_pekerjaan");
	String pelaksana_pekerjaan					= request.getParameter("pelaksana_pekerjaan");
	String uraian_pekerjaan						= request.getParameter("uraian_pekerjaan");
	String nama_perusahaan						= request.getParameter("nama_perusahaan");
	String no_lisensi							= request.getParameter("no_lisensi");
	String sumber_radioaktif					= request.getParameter("sumber_radioaktif");
	String proyektor							= request.getParameter("proyektor");
	String survey_meter							= request.getParameter("survey_meter");
	String tanggal_service						= request.getParameter("tanggal_service");
	String tanggal_kalibrasi					= request.getParameter("tanggal_kalibrasi");
	String nama_petugas_isolasi_listrik			= request.getParameter("nama_petugas_isolasi_listrik");
	String jabatan_petugas_isolasi_listrik		= request.getParameter("jabatan_petugas_isolasi_listrik");
	String nama_petugas_uji_kandungan_gas		= request.getParameter("nama_petugas_uji_kandungan_gas");
	String jabatan_petugas_uji_kandungan_gas	= request.getParameter("jabatan_petugas_uji_kandungan_gas");
	String nama_pelaksana_pekerjaan				= request.getParameter("nama_pelaksana_pekerjaan");
	String jabatan_pelaksana_pekerjaan			= request.getParameter("jabatan_pelaksana_pekerjaan");
	String nama_pejabat_berwenang				= request.getParameter("nama_pejabat_berwenang");
	String jabatan_pejabat_berwenang			= request.getParameter("jabatan_pejabat_berwenang");
	String catatan								= request.getParameter("catatan");
	String id_user								= (String) session.getAttribute("user.nipg");
	String id_divprosbu							= (String) session.getAttribute ("user.divprosbu");
	String id_direktorat						= (String) session.getAttribute ("user.direktorat");

	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_ptw (id_jsa, jenis_ptw, nomor, tgl_pengesahan, masa_berlaku_awal, masa_berlaku_akhir, "
			+" lokasi_pekerjaan, pelaksana_pekerjaan, uraian_pekerjaan, nama_perusahaan, no_lisensi, sumber_radioaktif,"
			+" proyektor, survey_meter, tanggal_service, tanggal_kalibrasi, nama_petugas_isolasi_listrik, jabatan_petugas_isolasi_listrik, "
			+" nama_petugas_uji_kandungan_gas, jabatan_petugas_uji_kandungan_gas, nama_pelaksana_pekerjaan, jabatan_pelaksana_pekerjaan, "
			+" nama_pejabat_berwenang, jabatan_pejabat_berwenang, catatan, id_user, id_divprosbu, id_direktorat) "
			+" values ('"+ id_jsa +"' ,'"+ jenis_ptw +"' ,'"+ nomor +"' ,'"+ tgl_pengesahan +"' ,'"+ masa_berlaku_awal +"' ,'"+ masa_berlaku_akhir +"' , "
			+" '"+ lokasi_pekerjaan +"' ,'"+ pelaksana_pekerjaan +"' ,'"+ uraian_pekerjaan +"' ,'"+ nama_perusahaan +"' ,'"+ no_lisensi +"' ,'"+ sumber_radioaktif +"' , "
			+" '"+ proyektor +"' ,'"+ survey_meter +"' ,'"+ tanggal_service +"' ,'"+ tanggal_kalibrasi +"' ,'"+ nama_petugas_isolasi_listrik +"' ,'"+ jabatan_petugas_isolasi_listrik +"' ,"
			+" '"+ nama_petugas_uji_kandungan_gas +"' ,'"+ jabatan_petugas_uji_kandungan_gas +"' ,'"+ nama_pelaksana_pekerjaan +"' ,'"+ jabatan_pelaksana_pekerjaan +"' ,"
			+" '"+ nama_pejabat_berwenang +"' ,'"+ jabatan_pejabat_berwenang +"' ,'"+ catatan +"' ,'"+ id_user +"' ," + id_divprosbu + " ," + id_direktorat + ")";
		break;

	case 3:
		q	=" update	t_ptw "
			+" set		id_jsa								= "+ id_jsa
			+" ,		nomor								= '"+ nomor +"' "
			+" ,		tgl_pengesahan						= '"+ tgl_pengesahan +"' "
			+" ,		masa_berlaku_awal					= '"+ masa_berlaku_awal +"' "
			+" ,		masa_berlaku_akhir					= '"+ masa_berlaku_akhir +"' "
			+" ,		lokasi_pekerjaan					= '"+ lokasi_pekerjaan +"' "
			+" ,		pelaksana_pekerjaan					= '"+ pelaksana_pekerjaan +"' "
			+" ,		uraian_pekerjaan					= '"+ uraian_pekerjaan +"' "
			+" ,		nama_perusahaan						= '"+ nama_perusahaan +"' "
			+" ,		no_lisensi							= '"+ no_lisensi +"' "
			+" ,		sumber_radioaktif					= '"+ sumber_radioaktif +"' "
			+" ,		proyektor							= '"+ proyektor +"' "
			+" ,		survey_meter						= '"+ survey_meter +"' "
			+" ,		tanggal_service						= '"+ tanggal_service +"' "
			+" ,		tanggal_kalibrasi					= '"+ tanggal_kalibrasi +"' "
			+" ,		nama_petugas_isolasi_listrik		= '"+ nama_petugas_isolasi_listrik +"' "
			+" ,		jabatan_petugas_isolasi_listrik		= '"+ jabatan_petugas_isolasi_listrik +"' "
			+" ,		nama_petugas_uji_kandungan_gas		= '"+ nama_petugas_uji_kandungan_gas +"' "
			+" ,		jabatan_petugas_uji_kandungan_gas	= '"+ jabatan_petugas_uji_kandungan_gas +"' "
			+" ,		nama_pelaksana_pekerjaan			= '"+ nama_pelaksana_pekerjaan +"' "
			+" ,		jabatan_pelaksana_pekerjaan			= '"+ jabatan_pelaksana_pekerjaan +"' "
			+" ,		nama_pejabat_berwenang				= '"+ nama_pejabat_berwenang +"' "
			+" ,		jabatan_pejabat_berwenang			= '"+ jabatan_pejabat_berwenang +"' "
			+" ,		catatan								= '"+ catatan +"' "
			+" ,		id_user								= '"+ id_user +"' "
			+" ,		id_divprosbu						=  "+ id_divprosbu
			+" ,		id_direktorat						=  "+ id_direktorat
			+" ,		tanggal_akses						= getdate() "
			+" where	id_ptw								=  "+ id_ptw;
		break;

	case 4:
		q	=" delete from t_ptw "
			+" where  id_ptw =  "+ id_ptw;
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
