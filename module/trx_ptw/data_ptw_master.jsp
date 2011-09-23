<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
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
	String		id_ptw 	= (String) request.getParameter("id_ptw");

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	id_ptw "
	+" ,		id_jsa "
	+" ,		jenis_ptw "
	+" ,		nomor "
	+" ,		replace(convert(varchar, tgl_pengesahan, 111), '/', '-') tgl_pengesahan "
	+" ,		replace(convert(varchar, masa_berlaku_awal, 111), '/', '-') masa_berlaku_awal "
	+" ,		replace(convert(varchar, masa_berlaku_akhir, 111), '/', '-') masa_berlaku_akhir "
	+" ,		lokasi_pekerjaan "
	+" ,		pelaksana_pekerjaan "
	+" ,		uraian_pekerjaan "
	+" ,		nama_perusahaan "
	+" ,		no_lisensi "
	+" ,		sumber_radioaktif "
	+" ,		proyektor "
	+" ,		survey_meter "
	+" ,		replace(convert(varchar, tanggal_service, 111), '/', '-') tanggal_service "
	+" ,		replace(convert(varchar, tanggal_kalibrasi, 111), '/', '-') tanggal_kalibrasi "
	+" ,		nama_petugas_isolasi_listrik "
	+" ,		jabatan_petugas_isolasi_listrik "
	+" ,		nama_petugas_uji_kandungan_gas "
	+" ,		jabatan_petugas_uji_kandungan_gas "
	+" ,		nama_pelaksana_pekerjaan "
	+" ,		jabatan_pelaksana_pekerjaan "
	+" ,		nama_pejabat_berwenang "
	+" ,		jabatan_pejabat_berwenang "
	+" ,		catatan "
	+" from		t_ptw "
	+" where	id_ptw = " + id_ptw;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data PTW tidak ditemukan!'}");
		return;
	}

	data	="{  id_ptw	: "+ id_ptw
		+", id_jsa : "+ rs.getString("id_jsa")
		+", jenis_ptw : '"+ rs.getString("jenis_ptw")
		+"', nomor : '"+ rs.getString("nomor")
		+"', tgl_pengesahan : '"+ rs.getString("tgl_pengesahan")
		+"', masa_berlaku_awal : '"+ rs.getString("masa_berlaku_awal")
		+"', masa_berlaku_akhir : '"+ rs.getString("masa_berlaku_akhir")
		+"', lokasi_pekerjaan : '"+ rs.getString("lokasi_pekerjaan")
		+"', pelaksana_pekerjaan : '"+ rs.getString("pelaksana_pekerjaan")
		+"', uraian_pekerjaan : '"+ rs.getString("uraian_pekerjaan")
		+"', nama_perusahaan : '"+ rs.getString("nama_perusahaan")
		+"', no_lisensi : '"+ rs.getString("no_lisensi")
		+"', sumber_radioaktif : '"+ rs.getString("sumber_radioaktif")
		+"', proyektor : '"+ rs.getString("proyektor")
		+"', survey_meter : '"+ rs.getString("survey_meter")
		+"', tanggal_service : '"+ rs.getString("tanggal_service")
		+"', tanggal_kalibrasi : '"+ rs.getString("tanggal_kalibrasi")
		+"', nama_petugas_isolasi_listrik : '"+ rs.getString("nama_petugas_isolasi_listrik")
		+"', jabatan_petugas_isolasi_listrik : '"+ rs.getString("jabatan_petugas_isolasi_listrik")
		+"', nama_petugas_uji_kandungan_gas : '"+ rs.getString("nama_petugas_uji_kandungan_gas")
		+"', jabatan_petugas_uji_kandungan_gas : '"+ rs.getString("jabatan_petugas_uji_kandungan_gas")
		+"', nama_pelaksana_pekerjaan : '"+ rs.getString("nama_pelaksana_pekerjaan")
		+"', jabatan_pelaksana_pekerjaan : '"+ rs.getString("jabatan_pelaksana_pekerjaan")
		+"', nama_pejabat_berwenang : '"+ rs.getString("nama_pejabat_berwenang")
		+"', jabatan_pejabat_berwenang : '"+ rs.getString("jabatan_pejabat_berwenang")
		+"', catatan : '"+ rs.getString("catatan")+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
