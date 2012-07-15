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
