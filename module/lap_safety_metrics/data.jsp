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
	String 		year	= request.getParameter("year");
	String 		month	= request.getParameter("month");

	int			tahun	= 0;
	int			bulan	= 0;

	String 		prev_year	= "";
	String 		prev_month	= "";

	if(month.equals("1")){
		tahun		= Integer.parseInt(year) - 1;
		prev_month	= "12";
		prev_year	= "" + tahun;
	} else {
		bulan		= Integer.parseInt(month) - 1;
		prev_month	= "" + bulan;
		prev_year	= year;
	}

	String q = " "
	+"	select	1							as no_urut "
	+"		,	'Insiden'					as tipe_item "
	+"		,	'Jumlah Insiden - Cidera'	as item "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan		= " + prev_month
	+"				and		a.tahun		= " + prev_year
	+"			)	as prev_month "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 2 "
	+"			)	as operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 4 "
	+"			)	as enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 1 "
	+"			)	as penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 6 "
	+"			)	as logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 3 "
	+"			)	as integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 5 "
	+"			)	as keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"			)	as total_sbu "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_korban_mati)		+ "
	+"									sum(a.jml_korban_berat)		+ "
	+"									sum(a.jml_korban_sedang)	+ "
	+"									sum(a.jml_korban_dampak)	+ "
	+"									sum(a.jml_korban_medis)		+ "
	+"									sum(a.jml_korban_p3k)		+ "
	+"									sum(a.jml_hampir_celaka)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan	   <= " + month
	+"				and		a.tahun		= " + year
	+"			)	as ytd "
	+"		,	'0'	as target "
	+"	union "
	+"	select	2							as no_urut "
	+"		,	''							as tipe_item "
	+"		,	'Jumlah Insiden - Jaringan'	as item "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + prev_month
	+"				and		a.tahun					= " + prev_year
	+"			)	as prev_month "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 2 "
	+"			)	as operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 4 "
	+"			)	as enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 1 "
	+"			)	as penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 6 "
	+"			)	as logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 3 "
	+"			)	as integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 5 "
	+"			)	as keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"			)	as total_sbu "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_bakar_ledak_bocor)	+ "
	+"									sum(a.jml_rusak_jaringan)		, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan	   <= " + month
	+"				and		a.tahun		= " + year
	+"			)	as ytd "
	+"		,	'11'	as target "
	+"	union "
	+"	select	3							as no_urut "
	+"		,	''							as tipe_item "
	+"		,	'Jumlah Insiden - Trafik'	as item "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + prev_month
	+"				and		a.tahun					= " + prev_year
	+"			)	as prev_month "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 2 "
	+"			)	as operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 4 "
	+"			)	as enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 1 "
	+"			)	as penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+  "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 6 "
	+"			)	as logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 3 "
	+"			)	as integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"				and		a.id_area_departemen	= 5 "
	+"			)	as keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan					= " + month
	+"				and		a.tahun					= " + year
	+"			)	as total_sbu "
	+"		,	( "
	+"				select	cast(isnull(sum(a.jml_rusak_kendaraan)		+ "
	+"									sum(a.jml_kecelakaan_kendaraan)	, 0) as varchar) "
	+"				from	t_insiden	as a "
	+"				where	a.bulan	   <= " + month
	+"				and		a.tahun		= " + year
	+"			)	as ytd "
	+"		,	'12'	as target "
	+"	union "
	+"	select	4					as no_urut "
	+"		,	'Risk Containment'	as tipe_item "
	+"		,	'% Partisipasi'		as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_ALL](" + prev_month + "," + prev_year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + prev_month
	+"				and		year(a.tanggal_rca)		= " + prev_year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		b.status				in (1,2) "
	+"			)	as prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_DEP](2," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		c.id_departemen			= 2 "
	+"				and		b.status				in (1,2) "
	+"			)	as operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_DEP](4," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		c.id_departemen			= 4 "
	+"				and		b.status				in (1,2) "
	+"			)	as enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_DEP](1," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		c.id_departemen			= 1 "
	+"				and		b.status				in (1,2) "
	+"			)	as penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_DEP](6," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		c.id_departemen			= 6 "
	+"				and		b.status				in (1,2) "
	+"			)	as logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_DEP](3," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		c.id_departemen			= 3 "
	+"				and		b.status				in (1,2) "
	+"			)	as integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_DEP](5," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		c.id_departemen			= 5 "
	+"				and		b.status				in (1,2) "
	+"			)	as keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_ALL](" + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)	= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		b.status				in (1,2) "
	+"			)	as total_sbu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(b.nipg) = 0 then 0 else (1.0 * (count(b.nipg) * 100) / [k3pl].[dbo].[FN_GET_RCA_TARGET_YEAR](" + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_rca			as a "
	+"					,	t_rca_auditor	as b "
	+"					,	r_pegawai		as c "
	+"				where	month(a.tanggal_rca)   <= " + month
	+"				and		year(a.tanggal_rca)		= " + year
	+"				and		a.id_rca				= b.id_rca "
	+"				and		b.nipg					= c.nipg "
	+"				and		b.status				in (1,2) "
	+"			)	as ytd "
	+"		,	'100%'	as target "
	+"	union "
	+"	select	5			as no_urut "
	+"		,	''			as tipe_item "
	+"		,	'Violation'	as item "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + prev_month
	+"				and		year(b.tanggal_rca)				= " + prev_year
	+"				and		a.id_rca						= b.id_rca "
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"				and		b.penanggung_jawab_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"				and		b.penanggung_jawab_departemen	= 4 "
	+"			)	as	enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"				and		b.penanggung_jawab_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"				and		b.penanggung_jawab_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"				and		b.penanggung_jawab_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"				and		b.penanggung_jawab_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"			)	as	total_sbu "
	+"		,	( "
	+"				select	cast(isnull(sum(a.number_of_violations),0) as varchar) "
	+"				from	t_rca_detail	as a "
	+"					,	t_rca			as b "
	+"				where	month(b.tanggal_rca)		   <= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		a.id_rca						= b.id_rca "
	+"			)	as	ytd "
	+"		,	'-'	as target "
	+"	union "
	+"	select	6		as no_urut "
	+"		,	''		as tipe_item "
	+"		,	'% 4/5'	as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + prev_month
	+"				and		year(b.tanggal_rca)				= " + prev_year
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 4 "
	+"			)	as	enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"			)	as	total_sbu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.li_45) is null then 0 else (1.0 * (sum(a.li_45) * 100) / isnull(sum(a.number_of_violations),1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)		   <= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"			)	as	ytd "
	+"		,	'20%'	as target "
	+"	union "
	+"	select	7					as no_urut "
	+"		,	''					as tipe_item "
	+"		,	'% Perbaikan 4/5'	as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_ALL](" + prev_year + "," + prev_month + ")) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + prev_month
	+"						and		year(b.tanggal_rca)				= " + prev_year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_DEP](" + year + "," + month + ",2)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_DEP](" + year + "," + month + ",4)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 4 "
	+"			)	as	enjiniring_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_DEP](" + year + "," + month + ",1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_DEP](" + year + "," + month + ",6)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_DEP](" + year + "," + month + ",3)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_DEP](" + year + "," + month + ",5)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_ALL](" + year + "," + month + ")) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"			)	as	total_abu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_45_YEAR](" + year + "," + month + ")) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)		   <= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.id_severity					in (4,5) "
	+"						and		a.status						in ('3') "
	+"			)	as	ytd "
	+"		,	'80%'	as target "
	+"	union "
	+"	select	8						as no_urut "
	+"		,	''						as tipe_item "
	+"		,	'Average of Severity'	as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + prev_month
	+"				and		year(b.tanggal_rca)				= " + prev_year
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 4 "
	+"			)	as	enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"				and		b.penanggung_jawab_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)			= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"			)	as	total_sbu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.violation_x_severity) is null then 0 else (1.0 * sum(a.violation_x_severity) / isnull(sum(a.number_of_violations),1)) end) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"				where	a.id_rca						= b.id_rca "
	+"				and		month(b.tanggal_rca)		   <= " + month
	+"				and		year(b.tanggal_rca)				= " + year
	+"			)	as	ytd "
	+"		,	'-'	as target "
	+"	union "
	+"	select	9				as no_urut "
	+"		,	'Observasi'		as tipe_item "
	+"		,	'% Partisipasi'	as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_ALL](" + prev_month + "," + prev_year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + prev_month
	+"				and		a.year			= " + prev_year
	+"				and		a.status_aktif	= '1' "
	+"			)	as prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_DEP](2," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"				and		a.id_departemen	= 2 "
	+"			)	as operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_DEP](4," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"				and		a.id_departemen	= 4 "
	+"			)	as enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_DEP](1," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"				and		a.id_departemen	= 1 "
	+"			)	as penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_DEP](6," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"				and		a.id_departemen	= 6 "
	+"			)	as logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_DEP](3," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"				and		a.id_departemen	= 3 "
	+"			)	as integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_DEP](5," + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"				and		a.id_departemen	= 5 "
	+"			)	as keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_ALL](" + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month			= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"			)	as total_sbu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.nipg) = 0 then 0 else (1.0 * (count(a.nipg) * 100) / [k3pl].[dbo].[FN_GET_STOP_TARGET_YEAR](" + month + "," + year + ")) end) as varchar) + '%' "
	+"				from	t_stop			as a "
	+"				,		r_pegawai		as b "
	+"				where	a.nipg			= b.nipg "
	+" 				and		status			in (1,2)"
	+"				and		a.month		   <= " + month
	+"				and		a.year			= " + year
	+"				and		a.status_aktif	= '1' "
	+"			)	as ytd "
	+"		,	'100%'	as target "
	+"	union "
	+"	select	10						as no_urut "
	+"		,	''						as tipe_item "
	+"		,	'Unsafe Act per Hour'	as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_ALL](" + prev_month + "," + prev_year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + prev_month
	+"				and		b.year					= " + prev_year
	+"				and		b.status_aktif			= '1' "
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_DEP](2," + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_DEP](4," + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 4 "
	+"			)	as	enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_DEP](1," + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_DEP](6," + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_DEP](3," + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_DEP](5," + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_ALL](" + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"			)	as	total_sbu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * sum(a.jumlah_unsafe) / isnull([k3pl].[dbo].[FN_GET_STOP_OBS_TIME_YEAR](" + month + "," + year + "),1)) end) as varchar) "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month				   <= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"			)	as	ytd "
	+"		,	'-'	as target "
	+"	union "
	+"	select	11					as no_urut "
	+"		,	''					as tipe_item "
	+"		,	'Unsafe Act Index'	as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + prev_month
	+"				and		b.year					= " + prev_year
	+"				and		b.status_aktif			= '1' "
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 4 "
	+"			)	as	enjiniring_dan_pembangunan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"				and		b.id_area_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month					= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"			)	as	total_sbu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when sum(a.jumlah_unsafe) is null then 0 else (1.0 * (sum(a.jumlah_unsafe) * 100) / isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) end) as varchar) + '%' "
	+"				from	t_stop_detail			as a "
	+"				,		t_stop					as b "
	+"				where	a.id_stop				= b.id_stop "
	+"				and		b.month				   <= " + month
	+"				and		b.year					= " + year
	+"				and		b.status_aktif			= '1' "
	+"			)	as	ytd "
	+"		,	'-'	as target "
	+"	union "
	+"	select	12							as no_urut "
	+"		,	'Improvement'				as tipe_item "
	+"		,	'Jumlah Tindak Lanjut RCA'	as item "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + prev_month
	+"						and		year(b.tanggal_rca)				= " + prev_year
	+"						and		a.status						in ('2','3') "
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"						and		b.penanggung_jawab_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"						and		b.penanggung_jawab_departemen	= 4 "
	+"			)	as	enjiniring_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"						and		b.penanggung_jawab_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"						and		b.penanggung_jawab_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"						and		b.penanggung_jawab_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"						and		b.penanggung_jawab_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"			)	as	total_abu "
	+"		,	( "
	+"				select	cast(count(a.id_rca) as varchar) "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)		   <= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('2','3') "
	+"			)	as	ytd "
	+"		,	'-'	as target "
	+"	union "
	+"	select	13							as no_urut "
	+"		,	''							as tipe_item "
	+"		,	'% Tindak Lanjut Selesai'	as item "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_ALL](" + prev_year + "," + prev_month + ")) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + prev_month
	+"						and		year(b.tanggal_rca)				= " + prev_year
	+"						and		a.status						in ('3') "
	+"			)	as	prev_month "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_DEP](" + year + "," + month + ",2)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 2 "
	+"			)	as	operasi_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_DEP](" + year + "," + month + ",4)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 4 "
	+"			)	as	enjiniring_dan_pemeliharaan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_DEP](" + year + "," + month + ",1)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 1 "
	+"			)	as	penjualan_dan_layanan "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_DEP](" + year + "," + month + ",6)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 6 "
	+"			)	as	logistik_dan_administrasi_umum "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_DEP](" + year + "," + month + ",3)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 3 "
	+"			)	as	integritas_jaringan_dan_k3pl "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_DEP](" + year + "," + month + ",5)) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"						and		b.penanggung_jawab_departemen	= 5 "
	+"			)	as	keuangan_dan_sdm "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_ALL](" + year + "," + month + ")) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)			= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"			)	as	total_abu "
	+"		,	( "
	+"				select	cast(convert(decimal(18,2), case when count(a.id_rca) = 0 then 0 else (1.0 * (count(a.id_rca) * 100) / [k3pl].[dbo].[FN_GET_TEMUAN_YEAR](" + year + "," + month + ")) end) as varchar) + '%' "
	+"				from	t_rca_detail	as a "
	+"				,		t_rca			as b "
	+"						where	a.id_rca						= b.id_rca "
	+"						and		month(b.tanggal_rca)		   <= " + month
	+"						and		year(b.tanggal_rca)				= " + year
	+"						and		a.status						in ('3') "
	+"			)	as	ytd "
	+"		,	'80%'	as target ";

	ResultSet	rs 		= db_stmt.executeQuery(q);
	int			i 		= 0;
	String		data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data	+= "[ '"+ rs.getString("no_urut") +"' "
			+  ", '"+ rs.getString("tipe_item") +"' "
			+  ", '"+ rs.getString("item") +"' "
			+  ", '"+ rs.getString("prev_month") +"' "
			+  ", '"+ rs.getString("operasi_dan_pemeliharaan") +"' "
			+  ", '"+ rs.getString("enjiniring_dan_pembangunan") +"' "
			+  ", '"+ rs.getString("penjualan_dan_layanan") +"' "
			+  ", '"+ rs.getString("logistik_dan_administrasi_umum") +"' "
			+  ", '"+ rs.getString("integritas_jaringan_dan_k3pl") +"' "
			+  ", '"+ rs.getString("keuangan_dan_sdm") +"' "
			+  ", '"+ rs.getString("total_sbu") +"' "
			+  ", '"+ rs.getString("ytd") +"' "
			+  ", '"+ rs.getString("target") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
