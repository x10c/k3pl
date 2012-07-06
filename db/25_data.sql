insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi RCA Pegawai'
,	'xls'
,	'reports/rca_lap_partisipasi_pegawai.jasper'
,	'id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go
