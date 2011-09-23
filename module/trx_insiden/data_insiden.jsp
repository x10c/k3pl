<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - m.shulhan (ms@kilabit.org)
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

	String		id = (String) request.getParameter("id");
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	id_area_seksi"
	+" ,		id_klasifikasi_pegawai"
	+" ,		replace(convert(varchar, tanggal, 111), '/', '-') tanggal"
	+" ,		uraian"
	+" ,		jml_korban_mati"
	+" ,		jml_korban_berat"
	+" ,		jml_korban_sedang"
	+" ,		jml_hari_kerja_hilang"
	+" ,		jml_korban_dampak"
	+" ,		jml_korban_medis"
	+" ,		jml_korban_p3k"
	+" ,		jml_hampir_celaka"
	+" ,		jml_bakar_ledak_bocor"
	+" ,		jml_rusak_jaringan"
	+" ,		jml_rusak_bangunan"
	+" ,		jml_rusak_kendaraan"
	+" ,		jml_rusak_lain"
	+" ,		nilai_rusak_jaringan"
	+" ,		nilai_rusak_bangunan"
	+" ,		nilai_rusak_kendaraan"
	+" ,		nilai_rusak_lain"
	+" ,		jml_pencemaran_lingkungan"
	+" ,		jml_kecelakaan_kendaraan"
	+" ,		jml_kejadian_keamanan"
	+" from		t_insiden"
	+" where	id_insiden = "+ id;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false"
		+", info:'Data insiden tidak ditemukan!'}");
		return;
	}

	data	="{  id_insiden				: '"+ id
		+"', id_area_seksi			: '"+ rs.getString("id_area_seksi")
		+"', id_klasifikasi_pegawai		: '"+ rs.getString("id_klasifikasi_pegawai")
		+"', tanggal				: '"+ rs.getString("tanggal")
		+"', uraian				: '"+ rs.getString("uraian")
		+"', jml_korban_mati			: '"+ rs.getString("jml_korban_mati")
		+"', jml_korban_berat			: '"+ rs.getString("jml_korban_berat")
		+"', jml_korban_sedang			: '"+ rs.getString("jml_korban_sedang")
		+"', jml_hari_kerja_hilang		: '"+ rs.getString("jml_hari_kerja_hilang")
		+"', jml_korban_dampak			: '"+ rs.getString("jml_korban_dampak")
		+"', jml_korban_medis			: '"+ rs.getString("jml_korban_medis")
		+"', jml_korban_p3k			: '"+ rs.getString("jml_korban_p3k")
		+"', jml_hampir_celaka			: '"+ rs.getString("jml_hampir_celaka")
		+"', jml_bakar_ledak_bocor		: '"+ rs.getString("jml_bakar_ledak_bocor")
		+"', jml_rusak_jaringan			: '"+ rs.getString("jml_rusak_jaringan")
		+"', jml_rusak_bangunan			: '"+ rs.getString("jml_rusak_bangunan")
		+"', jml_rusak_kendaraan		: '"+ rs.getString("jml_rusak_kendaraan")
		+"', jml_rusak_lain			: '"+ rs.getString("jml_rusak_lain")
		+"', nilai_rusak_jaringan		: '"+ rs.getString("nilai_rusak_jaringan")
		+"', nilai_rusak_bangunan		: '"+ rs.getString("nilai_rusak_bangunan")
		+"', nilai_rusak_kendaraan		: '"+ rs.getString("nilai_rusak_kendaraan")
		+"', nilai_rusak_lain			: '"+ rs.getString("nilai_rusak_lain")
		+"', jml_pencemaran_lingkungan		: '"+ rs.getString("jml_pencemaran_lingkungan")
		+"', jml_kecelakaan_kendaraan		: '"+ rs.getString("jml_kecelakaan_kendaraan")
		+"', jml_kejadian_keamanan		: '"+ rs.getString("jml_kejadian_keamanan")
		+"'}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
