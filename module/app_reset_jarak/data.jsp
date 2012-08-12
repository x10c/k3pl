<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray insiden = null;
	db_stmt	= db_con.createStatement();

	db_q	=" select	A.id_insiden"
		+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal"
		+" ,		B.nama_seksi as nama_area"
		+" ,		D.nama_klasifikasi_pegawai"
		+" ,		A.jml_kecelakaan_kendaraan"
		+" ,		A.status_reset_jarak"
		+" from		t_insiden		A"
		+" ,		r_seksi			B"
		+" ,		r_klasifikasi_pegawai	D"
		+" where	A.jml_kecelakaan_kendaraan	> 0"
		+" and		A.nilai_rusak_kendaraan		>= 10000000"
		+" and		A.id_area_seksi				= B.id_seksi"
		+" and		A.id_klasifikasi_pegawai	= D.id_klasifikasi_pegawai"
		+" and		A.id_divprosbu				= "+ user_div
		+" order by	A.tanggal desc ";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next()) {
		insiden = new JSONArray ();
		insiden.put (db_rs.getString ("id_insiden"));
		insiden.put (db_rs.getString ("tanggal"));
		insiden.put (db_rs.getString ("nama_area"));
		insiden.put (db_rs.getString ("nama_klasifikasi_pegawai"));
		insiden.put (db_rs.getString ("jml_kecelakaan_kendaraan"));
		insiden.put (db_rs.getString ("status_reset_jarak"));

		json_a.put (insiden);
	}

	out.print (json_a);

	db_rs.close ();
	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
