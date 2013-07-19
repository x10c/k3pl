/*
 * R_CSM_PROJECT_LEVEL: Tingkat penilaian proyek.
 */
if exists (
	select	1
	from	sysobjects
	where	id = object_id('R_CSM_PROJECT_WORK_LEVEL')
	and		type = 'U'
)
   drop table R_CSM_PROJECT_WORK_LEVEL
go

create table R_CSM_PROJECT_WORK_LEVEL (
	ID			int 			identity primary key
,	NILAI		float			not null default 0
,	KETERANGAN	varchar(256)	not null default ''
);

/*
 * Update T_CSM_PROYEK tambah kolom WORK_LEVEL
 */
alter table T_CSM_PROYEK add WORK_LEVEL int
	foreign key
	references R_CSM_PROJECT_WORK_LEVEL (ID);

/*
 * Update T_CSM_PROYEK tambah kolom PENGHARGAAN_SANKSI
 */
alter table T_CSM_PROYEK add PENGHARGAAN_SANKSI int default 1
	foreign key
	references R_CSM_PERF_EVAL_PS (ID);
