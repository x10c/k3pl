DECLARE @v sql_variant 
SET @v = N'1 = CSM; 2 = PSSR; 3 = PHA; 4 = LINGKUNGAN; 5 = LAINNYA'
EXECUTE sp_updateextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'R_REPORT', N'COLUMN', N'KLASIFIKASI_REPORT'
GO

update	R_REPORT
set		KLASIFIKASI_REPORT	= 5
where	ID_REPORT			in (15,16,17,18,19)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Grafik Partisipasi RCA'
,	5
,	'doc'
,	'reports/grafik_performance_rca_partisipasi.jasper'
,	'year_1;year_2;year_3;month_1;month_2;month_3;id_dir;id_div'
,	'YEAR_1;YEAR_2;YEAR_3;MONTH_1;MONTH_2;MONTH_3;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Grafik Severity 4-5 RCA'
,	5
,	'doc'
,	'reports/grafik_performance_rca_severity.jasper'
,	'year_1;year_2;year_3;month_1;month_2;month_3;id_dir;id_div'
,	'YEAR_1;YEAR_2;YEAR_3;MONTH_1;MONTH_2;MONTH_3;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Grafik Tindak Lanjut Temuan 4-5 RCA'
,	5
,	'doc'
,	'reports/grafik_performance_rca_tl_temuan.jasper'
,	'year_1;year_2;year_3;month_1;month_2;month_3;id_dir;id_div'
,	'YEAR_1;YEAR_2;YEAR_3;MONTH_1;MONTH_2;MONTH_3;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Matriks Pelatihan'
,	5
,	'xls'
,	'reports/lap_pelatihan_matriks.jasper'
,	'id_dir;id_div'
,	'ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Pelatihan'
,	5
,	'xls'
,	'reports/lap_pelatihan.jasper'
,	'id_dir;id_div;id_dep;id_din;id_sek;nipg;start_date;end_date'
,	'ID_DIR;ID_DIV;ID_DEP;ID_DIN;ID_SEK;NIPG;START_DATE;END_DATE'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Severity'
,	5
,	'xls'
,	'reports/rca_lap_severity.jasper'
,	'is_in_org;year;month;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area'
,	'IS_IN_ORG;YEAR;MONTH;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performance RCA'
,	5
,	'xls'
,	'reports/rca_lap_performance.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi STOP Pegawai'
,	5
,	'xls'
,	'reports/obs_lap_partisipasi_pegawai.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi STOP Organisasi'
,	5
,	'xls'
,	'reports/obs_lap_partisipasi_organisasi.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP per Kategori'
,	5
,	'xls'
,	'reports/obs_lap_performansi_kategori.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP Safe Unsafe Index'
,	5
,	'xls'
,	'reports/obs_lap_performansi_index.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP Safe Unsafe Observasi per Hour'
,	5
,	'xls'
,	'reports/obs_lap_performansi_hour.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP'
,	5
,	'xls'
,	'reports/obs_lap_performansi_stop.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Hot Work Permit'
,	5
,	'doc'
,	'reports/lap_hwp.jasper'
,	'id_ptw'
,	'ID_PTW'
)
go
