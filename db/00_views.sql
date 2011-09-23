if exists (select 1
            from  sysobjects
           where  id = object_id('V_SEVERITY')
            and   type = 'V')
   drop view V_SEVERITY
go

/*==============================================================*/
/* View: V_SEVERITY                                             */
/*==============================================================*/
create view V_SEVERITY as
select	a.tanggal_rca
    ,   b.description
	,	b.id_severity 
	,	a.nama_tempat_rca 
	,	a.penanggung_jawab_seksi 
	,	a.penanggung_jawab_dinas 
	,	a.penanggung_jawab_departemen 
	,	replace(convert(varchar, b.completion_date_target, 111), '/', '-') as completion_date_target 
	,	b.status 
	,	b.note 
from	t_rca			as a 
	,	t_rca_detail	as b 
where	a.id_rca    = b.id_rca
go
