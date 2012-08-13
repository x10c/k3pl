<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%@ page import="java.util.Calendar" %>
<%
try {
	String		dir				= request.getParameter ("dir");
	String		div				= request.getParameter ("div");
	String		dep				= request.getParameter ("dep");
	String		dinas			= request.getParameter ("dinas");
	String		seksi			= request.getParameter ("seksi");
	int			year			= ServletUtilities.getIntParameter (request, "tahun", 0);
	int			year_before		= 0;
	int			month			= ServletUtilities.getIntParameter (request, "bulan", 0);
	int			month_before	= 0;
	Calendar	cal				= Calendar.getInstance();
	String		q_where			= "";

	if (year == 0) {
		out.print ("{}");
		return;
	}
	if (month == 0) {
		month = cal.get (Calendar.MONTH) + 1;
	}

	year_before	= year;
	if (month == 1) {
		year_before		= year_before - 1;
		month_before	= 12;
	} else {
		month_before	= month - 1;
	}

	if (! dir.equals ("0")) {
		q_where		=" and A.id_direktorat = "+ dir;
	}
	if (! div.equals ("0")) {
		q_where		+=" and A.id_divprosbu = "+ div;
	}

	db_stmt	= db_con.createStatement();
	db_q	=" select	UK.id"
			+" ,		UK.name"
			+" ,		UK.jml_tk_bulan_lalu"
			+" ,		UK.jml_tenaga_kerja"
			+" ,		UK.jml_jk_bulan_lalu"
			+" ,		UK.jml_jam_kerja"
			+" ,		INS.jml_kecelakaan"
			+" ,		INS.jml_korban_ringan"
			+" ,		INS.jml_korban_sedang"
			+" ,		INS.jml_korban_berat"
			+" ,		INS.jml_korban_mati"
			+" ,		INS.jml_korban_total"
			+" ,		INS.jml_hh_total"
			+" from "
			+"( select	Y.id_klasifikasi_pegawai	as id"
			+" ,		Y.nama_klasifikasi_pegawai	as name"
			+" ,		X.jml_tk_bulan_lalu			as jml_tk_bulan_lalu"
			+" ,		Y.jml_tk_bulan_skrg			as jml_tenaga_kerja"
			+" ,		X.jml_jk_bulan_lalu			as jml_jk_bulan_lalu"
			+" ,		Y.jml_jk_bulan_skrg			as jml_jam_kerja"
			+" from ("
			+" 	select	B.id_klasifikasi_pegawai"
			+" 	,		B.nama_klasifikasi_pegawai"
			+" 	,		isnull(A.tahun,"+ year_before +")	as tahun"
			+" 	,		isnull(A.bulan,"+ month_before +")	as bulan"
			+" 	,		isnull(A.jml_tenaga_kerja, 0)		as jml_tk_bulan_lalu"
			+" 	,		isnull(A.jml_jam_kerja, 0)			as jml_jk_bulan_lalu"
			+" 	from		t_unjuk_kerja			A"
			+" 	right join	r_klasifikasi_pegawai	B"
			+" 	on		A.id_klasifikasi_pegawai	= B.id_klasifikasi_pegawai"
			+" 	and		A.tahun						= "+ year_before
			+" 	and		A.bulan						= "+ month_before
			+ q_where
			+" ) X"
			+" right join ("
			+" 	select	B.id_klasifikasi_pegawai"
			+" 	,		B.nama_klasifikasi_pegawai"
			+" 	,		isnull(A.tahun,"+ year +")				as tahun"
			+" 	,		isnull(A.bulan,"+ month +")				as bulan"
			+" 	,		isnull(A.jml_tenaga_kerja, 0)			as jml_tk_bulan_skrg"
			+" 	,		isnull(A.jml_jam_kerja, 0)				as jml_jk_bulan_skrg"
			+"	from		t_unjuk_kerja			A"
			+" 	right join	r_klasifikasi_pegawai	B"
			+" 	on		A.id_klasifikasi_pegawai	= B.id_klasifikasi_pegawai"
			+" 	and		A.tahun						= "+ year
			+" 	and		A.bulan						= "+ month
			+ q_where
			+" ) Y"
			+" on X.id_klasifikasi_pegawai = Y.id_klasifikasi_pegawai"
			+") UK"
			+" right join ("
	 		+"	select	B.id_klasifikasi_pegawai"
	 		+"	,		B.nama_klasifikasi_pegawai"
			+"	,		isnull (A.jml_korban_mati, 0)			as jml_korban_mati"
	 		+"	,		isnull (A.jml_korban_berat, 0)			as jml_korban_berat"
			+"	,		isnull (A.jml_korban_sedang, 0)			as jml_korban_sedang"
			+"	,		isnull (A.jml_korban_medis, 0)"
			+"	+		isnull (A.jml_korban_p3k, 0)			as jml_korban_ringan"
			+"	,		isnull (A.jml_korban_mati, 0)"
			+"	+		isnull (A.jml_korban_berat, 0)"
			+"	+		isnull (A.jml_korban_sedang, 0)"
			+"	+		isnull (A.jml_korban_medis, 0)"
			+"	+		isnull (A.jml_korban_p3k, 0)			as jml_korban_total"
			+"	,		isnull (A.jml_kecelakaan_kendaraan, 0)	as jml_kecelakaan"
			+"	,		isnull (A.jml_hari_kerja_hilang, 0)		as jml_hh_total"
			+"	from		t_insiden					A"
	 		+"	right join	r_klasifikasi_pegawai		B"
			+"	on			A.id_klasifikasi_pegawai	= B.id_klasifikasi_pegawai"
			+"	and			A.tahun = "+ year
			+"	and			A.bulan = "+ month
			+ q_where
			+" ) INS"
			+" on UK.id = INS.id_klasifikasi_pegawai";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next ()) {
		json_o = new JSONObject ();

		json_o.put ("id"					, db_rs.getString ("id"));
		json_o.put ("name"					, db_rs.getString ("name"));
		json_o.put ("jml_tk_bulan_lalu"		, db_rs.getString ("jml_tk_bulan_lalu"));
		json_o.put ("jml_tenaga_kerja"		, db_rs.getString ("jml_tenaga_kerja"));
		json_o.put ("jml_jk_bulan_lalu"		, db_rs.getString ("jml_jk_bulan_lalu"));
		json_o.put ("jml_jam_kerja"			, db_rs.getString ("jml_jam_kerja"));

		json_o.put ("jml_kecelakaan"		, db_rs.getString ("jml_kecelakaan"));
		json_o.put ("jml_korban_ringan"		, db_rs.getString ("jml_korban_ringan"));
		json_o.put ("jml_korban_sedang"		, db_rs.getString ("jml_korban_sedang"));
		json_o.put ("jml_korban_berat"		, db_rs.getString ("jml_korban_berat"));
		json_o.put ("jml_korban_mati"		, db_rs.getString ("jml_korban_mati"));
		json_o.put ("jml_korban_total"		, db_rs.getString ("jml_korban_total"));
		json_o.put ("jml_hh_ringan"			, 0);
		json_o.put ("jml_hh_sedang"			, 0);
		json_o.put ("jml_hh_berat"			, 0);
		json_o.put ("jml_hh_mati"			, 0);
		json_o.put ("jml_hh_total"			, db_rs.getString ("jml_hh_total"));
		json_o.put ("ket"					, "-");

		json_a.put (json_o);
	}

	_return.put ("success", true);
	_return.put ("info", json_a);
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
