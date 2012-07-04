<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String unjuk_kerja
="[{"
+"  name:'Kematian'"
+", id	:'jml_korban_mati'"
+"},{"
+"  name:'Kecelakaan Berat (Cacat Permanen)'"
+", id	:'jml_korban_berat'"
+"},{"
+"  name:'Kecelakaan Sedang'"
+", id	:'jml_korban_sedang'"
+"},{"
+"  name:'Total LTI'"
+", id	:'total_lti'"
+"},{"
+"  name:'Hari Kerja Hilang'"
+", id	:'jml_hari_kerja_hilang'"
+"},{"
+"  name:'Frekuensi LTI'"
+", id	:'ltif'"
+"},{"
+"  name:'Tingkat Keparahan'"
+", id	:'tingkat_keparahan'"
+"},{"
+"  name:'Kasus Keparahan'"
+", id	:'kasus_keparahan'"
+"},{"
+"  name:'Jumlah Kejadian Dampak Akibat Kecelakaan'"
+", id	:'jml_korban_dampak'"
+"},{"
+"  name:'Jumlah Pengobatan Medis'"
+", id	:'jml_korban_medis'"
+"},{"
+"  name:'Total Kecelakaan Ringan'"
+", id	:'total_kecelakaan_ringan'"
+"},{"
+"  name:'Laporan Kecelakaan'"
+", id	:'laporan_kecelakaan'"
+"},{"
+"  name:'Pertolongan Pertama Pada Kecelakaan (P3K)'"
+", id	:'jml_korban_p3k'"
+"},{"
+"  name:'Hampir Celaka'"
+", id	:'jml_hampir_celaka'"
+"},{"
+"  name:'Kebakaran / Ledakan / Kebocoran'"
+", id	:'jml_bakar_ledak_bocor'"
+"},{"
+"  name:'Kerusakan Properti Minor (<= 50 juta)'"
+", id	:'jml_nilai_rusak'"
+"},{"
+"  name:'Kerusakan Properti Major (> 50 juta)'"
+", id	:'jml_pencemaran_lingkungan'"
+"},{"
+"  name:'Kecelakaan Kendaraan'"
+", id	:'jml_kecelakaan_kendaraan'"
+"},{"
+"  name:'Total Jarak Tempuh (km)'"
+", id	:'jml_jarak_tempuh'"
+"},{"
+"  name:'Total Jarak Berkendaraan Aman (km)'"
+", id	:'jml_jarak_tempuh_aman'"
+"},{"
+"  name:'Frekuensi Kecelakaan Kendaraan (per 100,000 km)'"
+", id	:'frek_kecelakaan'"
+"},{"
+"  name:'Kejadian Keamanan'"
+", id	:'jml_kejadian_keamanan'"
+"},{"
+"  name:'Total Ketidakhadiran Karena Sakit (TSA)'"
+", id	:'jml_hari_absen'"
+"},{"
+"  name:'Frekuensi Total Ketidakhadiran Karena Sakit (TSAF)'"
+", id	:'tsaf'"
+"},{"
+"  name:'Total Karyawan Aktual'"
+", id	:'jml_tenaga_kerja'"
+"},{"
+"  name:'Total Hari Kerja'"
+", id	:'jml_hari_kerja'"
+"},{"
+"  name:'Jam Kerja Aman'"
+", id	:'jml_jam_kerja'"
+"}]";

String q_select_all
=" select"
+"	TI.*"
+" ,	TUK.*"
+" ,	((TI.total_lti / isnull(nullif(TUK.jml_jam_kerja,0),1)) * 1000000)						as ltif"
+" ,	((TI.jml_hari_kerja_hilang / isnull(nullif(TUK.jml_jam_kerja, 0), 1)) * 1000000)		as tingkat_keparahan"
+" ,	(TI.jml_hari_kerja_hilang / isnull(nullif(TI.total_lti, 0), 1))							as kasus_keparahan"
+" ,	(TI.jml_korban_dampak + TI.jml_korban_medis)											as total_kecelakaan_ringan"
+" ,	(TI.total_lti + TI.jml_korban_dampak)													as laporan_kecelakaan"
+" ,	((TI.jml_kecelakaan_kendaraan / isnull(nullif(TUK.jml_jarak_tempuh, 0), 1)) * 100000)	as frek_kecelakaan"
+" ,	((TUK.jml_hari_absen / isnull(nullif(TUK.jml_hari_kerja, 0), 1)) / 100)					as tsaf";

String q_select_insiden
=" select	isnull(sum(jml_korban_mati),0)		as jml_korban_mati"
+" 	,	isnull(sum(jml_korban_berat),0)			as jml_korban_berat"
+" 	,	isnull(sum(jml_korban_sedang),0)		as jml_korban_sedang"

+"	,	(isnull(sum(jml_korban_mati),0)"
+" 	+	isnull(sum(jml_korban_berat),0)"
+" 	+	isnull(sum(jml_korban_sedang),0))		as total_lti"

+" 	,	isnull(sum(jml_hari_kerja_hilang),0)	as jml_hari_kerja_hilang"
+" 	,	isnull(sum(jml_korban_dampak),0)		as jml_korban_dampak"
+" 	,	isnull(sum(jml_korban_medis),0)			as jml_korban_medis"
+" 	,	isnull(sum(jml_korban_p3k),0)			as jml_korban_p3k"
+" 	,	isnull(sum(jml_hampir_celaka),0)		as jml_hampir_celaka"
+" 	,	isnull(sum(jml_bakar_ledak_bocor),0)	as jml_bakar_ledak_bocor"
+" 	,	isnull(sum(jml_rusak_jaringan),0)		as jml_rusak_jaringan"
+" 	,	isnull(sum(jml_rusak_bangunan),0)		as jml_rusak_bangunan"
+" 	,	isnull(sum(jml_rusak_kendaraan),0)		as jml_rusak_kendaraan"
+" 	,	isnull(sum(jml_rusak_lain),0)			as jml_rusak_lain"
+" 	,	(isnull(sum(nilai_rusak_jaringan),0)"
+" 	+	isnull(sum(nilai_rusak_bangunan),0)"
+" 	+	isnull(sum(nilai_rusak_kendaraan),0)"
+" 	+	isnull(sum(nilai_rusak_lain),0))			as jml_nilai_rusak"
+" 	,	isnull(sum(jml_pencemaran_lingkungan),0)	as jml_pencemaran_lingkungan"
+" 	,	isnull(sum(jml_kecelakaan_kendaraan),0)		as jml_kecelakaan_kendaraan"
+" 	,	isnull(sum(jml_kejadian_keamanan),0)		as jml_kejadian_keamanan"
+" 	from	t_insiden";

String q_select_uk
=" 	select	isnull(sum(jml_hari_absen),0)		as jml_hari_absen"
+" 	,	isnull(sum(jml_tenaga_kerja),0)			as jml_tenaga_kerja"
+" 	,	isnull(sum(jml_hari_kerja),0)			as jml_hari_kerja"
+" 	,	isnull(sum(jml_jam_kerja),0)			as jml_jam_kerja"
+"	,	isnull(sum(jml_jarak_tempuh),0)			as jml_jarak_tempuh"
+"	,	isnull(sum(jml_jarak_tempuh_aman),0)	as jml_jarak_tempuh_aman"
+"  	from	t_unjuk_kerja";

try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt	= db_con.createStatement();

	String		year	= (String) request.getParameter("year");
	String		month	= (String) request.getParameter("month");

	JSONArray	uk_all	= new JSONArray(unjuk_kerja);
	JSONObject	uk;

	ResultSet	rs;
	String		q, klas, v;
	int			i, a;

	for (i = 1; i <= 3; i++) {
		switch (i) {
		case 1:
			klas = "teknik";
			break;
		case 2:
			klas = "servis";
			break;
		default:
			klas = "kontrak";
			break;
		}

		/* 1st query: get monthly data */
		q
		= q_select_all
		+" from"
		+" ("
		+ q_select_insiden
		+" 	where	id_klasifikasi_pegawai	= "+ i
		+" 	and		tahun					= "+ year
		+" 	and		bulan					= "+ month
		+"	and		id_divprosbu			= "+ user_div
		+" ) TI,"
		+" ("
		+ q_select_uk
		+" 	where	id_klasifikasi_pegawai	= "+ i
		+" 	and		tahun					= "+ year
		+" 	and		bulan					= "+ month
		+"	and		id_divprosbu			= "+ user_div
		+" ) TUK";

		rs = db_stmt.executeQuery(q);

		if (!rs.next()) {
			rs.close();
			continue;
		}

		for (a = 0; a < uk_all.length(); a++) {
			uk	= uk_all.getJSONObject(a);
			v	= rs.getString(uk.getString("id"));
			uk.put(klas+"_bulan", v);
		}

		rs.close();

		/* 2nd query: get yearly data */
		q
		= q_select_all
		+" from"
		+" ("
		+ q_select_insiden
		+" 	where	id_klasifikasi_pegawai	= "+ i
		+" 	and		tahun					= "+ year
		+"	and		id_divprosbu			= "+ user_div
		+" ) TI,"
		+" ("
		+ q_select_uk
		+" 	where	id_klasifikasi_pegawai	= "+ i
		+" 	and		tahun					= "+ year
		+"	and		id_divprosbu			= "+ user_div
		+" ) TUK";

		rs = db_stmt.executeQuery(q);

		if (!rs.next()) {
			rs.close();
			continue;
		}

		for (a = 0; a < uk_all.length(); a++) {
			uk	= uk_all.getJSONObject(a);
			v	= rs.getString(uk.getString("id"));
			uk.put(klas+"_tahun", v);
		}

		rs.close();

		/* 3rd: get cumulative data */
		q
		= q_select_all
		+" from"
		+" ("
		+ q_select_insiden
		+" 	where	id_klasifikasi_pegawai	= "+ i
		+"	and		id_divprosbu			= "+ user_div
		+" ) TI,"
		+" ("
		+ q_select_uk
		+" 	where	id_klasifikasi_pegawai	= "+ i
		+"	and		id_divprosbu			= "+ user_div
		+" ) TUK";

		rs = db_stmt.executeQuery(q);

		if (!rs.next()) {
			rs.close();
			continue;
		}

		for (a = 0; a < uk_all.length(); a++) {
			uk	= uk_all.getJSONObject(a);
			v	= rs.getString(uk.getString("id"));
			uk.put(klas+"_kumul", v);
		}

		rs.close();
	}

	/* cumulative 1: get monthly data */
	q
	= q_select_all
	+" from"
	+" ("
	+ q_select_insiden
	+" 	where 	tahun			= "+ year
	+" 	and		bulan			= "+ month
	+"	and		id_divprosbu	= "+ user_div
	+" ) TI,"
	+" ("
	+ q_select_uk
	+" 	where	tahun			= "+ year
	+" 	and		bulan			= "+ month
	+"	and		id_divprosbu	= "+ user_div
	+" ) TUK";

	rs = db_stmt.executeQuery(q);

	if (rs.next()) {
		for (a = 0; a < uk_all.length(); a++) {
			uk	= uk_all.getJSONObject(a);
			v	= rs.getString(uk.getString("id"));
			uk.put("kum_bulan", v);
		}
	}

	rs.close();

	/* cumulative 2: get yearly data */
	q
	= q_select_all
	+" from"
	+" ("
	+ q_select_insiden
	+" 	where	tahun			= "+ year
	+"	and		id_divprosbu	= "+ user_div
	+" ) TI,"
	+" ("
	+ q_select_uk
	+" 	where	tahun			= "+ year
	+"	and		id_divprosbu	= "+ user_div
	+" ) TUK";

	rs = db_stmt.executeQuery(q);

	if (rs.next()) {
		for (a = 0; a < uk_all.length(); a++) {
			uk	= uk_all.getJSONObject(a);
			v	= rs.getString(uk.getString("id"));
			uk.put("kum_tahun", v);
		}
	}

	rs.close();

	/* 3rd: get cumulative data */
	q
	= q_select_all
	+" from"
	+" ("
	+ q_select_insiden
	+"	where id_divprosbu	= "+ user_div
	+" ) TI,"
	+" ("
	+ q_select_uk
	+"	where id_divprosbu	= "+ user_div
	+" ) TUK";

	rs = db_stmt.executeQuery(q);

	if (rs.next()) {
		for (a = 0; a < uk_all.length(); a++) {
			uk	= uk_all.getJSONObject(a);
			v	= rs.getString(uk.getString("id"));
			uk.put("kum_kumul", v);
		}
	}

	rs.close();

	out.print(uk_all);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
