UPDATE R_REPORT 
SET 
	WEB_PARAMS 		= 'id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;hide_inaktif'
,	REPORT_PARAMS	= 'ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;STATUS_USER'
WHERE
	ID_REPORT		= 15
go

UPDATE R_REPORT 
SET 
	WEB_PARAMS 		= 'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month;hide_inaktif'
,	REPORT_PARAMS	= 'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH;STATUS_USER'
WHERE
	ID_REPORT		= 19
go
