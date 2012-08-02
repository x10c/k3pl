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
	Statement	db_stmt2= db_con.createStatement();
	ResultSet	rs2		= null;
	String		id_stop = (String) request.getParameter("id_stop");
	String		safe;
	String		unsafe;
	JSONObject	detail;
	int			i	= 0;

	db_stmt = db_con.createStatement();

	db_q=" select	A.nipg "
	+" ,		B.nama_pegawai "
	+" ,		A.id_area_seksi "
	+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal "
	+" ,		A.site "
	+" ,		A.shift "
	+" ,		A.lama_observasi "
	+" ,		A.jml_org_observasi "
	+" ,		A.jml_org_diskusi "
	+" ,		A.tindakan_aman_diamati "
	+" ,		A.tindakan_tidak_aman_diamati "
	+" ,		A.status_aktif "
	+" from		t_stop		A "
	+" ,		r_pegawai	B "
	+" where	A.nipg		= B.nipg "
	+" and		A.id_stop	= "+ id_stop;

	db_rs = db_stmt.executeQuery (db_q);

	if (! db_rs.next()) {
		out.print("{ success: false"
		+", info:'Data observasi tidak ditemukan!'}");
		return;
	}

	db_q=" select	id_kel_tipe_observasi"
	+" ,		id_tipe_observasi"
	+" ,		id_detail_tipe_observasi"
	+" ,		jumlah_safe"
	+" ,		jumlah_unsafe"
	+" from		t_stop_detail"
	+" where	id_stop = "+ id_stop;

	rs2 = db_stmt2.executeQuery (db_q);

	json_a = new JSONArray ();
	while (rs2.next()) {
		detail	= new JSONObject();

		detail.put ("kel_id", rs2.getString ("id_kel_tipe_observasi"));
		detail.put ("tipe_id", rs2.getString ("id_tipe_observasi"));
		detail.put ("detail_id", rs2.getString ("id_detail_tipe_observasi"));
		detail.put ("safe", rs2.getString ("jumlah_safe"));
		detail.put ("unsafe", rs2.getString ("jumlah_unsafe"));

		json_a.put(detail);
	}

	json_o	= new JSONObject ();
	json_o.put ("id_stop", id_stop);
	json_o.put ("nipg", db_rs.getString ("nipg"));
	json_o.put ("nama_pegawai", db_rs.getString ("nama_pegawai"));
	json_o.put ("id_area_seksi", db_rs.getString ("id_area_seksi"));
	json_o.put ("tanggal", db_rs.getString ("tanggal"));
	json_o.put ("site", db_rs.getString ("site"));
	json_o.put ("shift", db_rs.getString ("shift"));
	json_o.put ("lama_observasi", db_rs.getString ("lama_observasi"));
	json_o.put ("jml_org_observasi", db_rs.getString ("jml_org_observasi"));
	json_o.put ("jml_org_diskusi", db_rs.getString ("jml_org_diskusi"));
	json_o.put ("safe", db_rs.getString ("tindakan_aman_diamati"));
	json_o.put ("unsafe", db_rs.getString ("tindakan_tidak_aman_diamati"));
	json_o.put ("status_aktif", db_rs.getString ("status_aktif"));
	json_o.put ("details", json_a);

	out.print (json_o);

	rs2.close();
	db_rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
