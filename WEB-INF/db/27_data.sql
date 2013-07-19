insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Rangkuman Kegiatan K3PL'
,	'doc'
,	'reports/lap_rangkuman_keg.jasper'
,	'month;year;id_divprosbu'
,	'MONTH;YEAR;ID_DIVPROSBU'
)
go
