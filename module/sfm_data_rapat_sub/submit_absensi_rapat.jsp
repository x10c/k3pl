<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - Prasetya Yanuar (mieh100freak@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Statement	db_stmt = db_con.createStatement();

	String dml			= request.getParameter("dml_type");
	String id_rapat	= request.getParameter("id_rapat");
	String nipg		= request.getParameter("nipg");
	String nama_pegawai	= request.getParameter("nama_pegawai");
	String id_jabatan_komite	= request.getParameter("id_jabatan_komite");
	String status_absensi		= request.getParameter("status_absensi");
	String keterangan_absensi	= request.getParameter("keterangan_absensi");
	String jml_hadir	= request.getParameter("jml_hadir");
	String jml_absen	= request.getParameter("jml_absen");
	String nipg_old	= request.getParameter("nipg_old");
	String nama_peserta	= request.getParameter("nama_peserta");
	String id_user			= (String) session.getAttribute("user.nipg");
	String q;

	if (dml.equals("insert")) {
		q	=" insert into t_rapat_absensi_komite_sub_komite ("
			+"		id_rapat "
			+" ,	nipg "
			+" ,	nama_peserta "
			+" ,	id_jabatan_komite "
			+" ,	status_absensi "
			+" ,	keterangan_absensi "
			+" ,	jml_hadir "
			+" ,	jml_absen "
			+" ,	id_user "
			+" ) values ('"
			+ id_rapat +"', '"
			+ nipg +"', '"
			+ nama_pegawai +"', '"
			+ id_jabatan_komite +"', '"
			+ status_absensi +"', '"
			+ keterangan_absensi +"', "
			+ jml_hadir +", "
			+ jml_absen +", '"
			+ id_user +"' )";

	} else if (dml.equals("update")) {
		q	=" update	t_rapat_absensi_komite_sub_komite "
			+" set		nipg	= '"+ nipg +"' "
			+" ,		nama_peserta			= '"+ nama_pegawai +"' "
			+" ,		id_jabatan_komite			= '"+ id_jabatan_komite +"' "
			+" ,		status_absensi			= '"+ status_absensi +"' "
			+" ,		keterangan_absensi			= '"+ keterangan_absensi +"' "
			+" ,		jml_hadir			= '"+ jml_hadir +"' "
			+" ,		jml_absen			= '"+ jml_absen +"' "
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_rapat	=  "+ id_rapat +" and nipg = '"+ nipg_old +"'";

	} else if (dml.equals("delete")) {
		q	=" delete from	t_rapat_absensi_komite_sub_komite "
			+" where	id_rapat   =  "+ id_rapat +" and nipg = "+ nipg ;
	} else {
		out.print("{ success:false"
			+ ", info   :'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{ success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{ success:false, info:'"+ e +"'}");
}
%>
