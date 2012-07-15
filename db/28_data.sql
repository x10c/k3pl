insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Safety Metrics'
,	'xls'
,	'reports/lap_safety_metrics.jasper'
,	'prev_year;prev_month;year;month;id_dir;id_div'
,	'PREV_YEAR;PREV_MONTH;YEAR;MONTH;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan JSA'
,	'doc'
,	'reports/lap_jsa.jasper'
,	'id_jsa'
,	'ID_JSA'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi RCA Organisasi'
,	'xls'
,	'reports/rca_lap_partisipasi_organisasi.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go
