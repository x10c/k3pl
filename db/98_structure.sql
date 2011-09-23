if exists (
	select	1
	from	sysobjects
	where	id = object_id('R_CSM_PENILAIAN_DETAIL')
	and		type = 'U'
)
	drop table R_CSM_PENILAIAN_DETAIL
go

if exists (
	select	1
	from	sysobjects
	where	id = object_id('T_CSM_PROYEK_KONT_NILAI')
	and		type = 'U'
)
	drop table T_CSM_PROYEK_KONT_NILAI
go

if exists (
	select	1
	from	sysobjects
	where	id = object_id('R_CSM_PENILAIAN')
	and		type = 'U'
)
	drop table R_CSM_PENILAIAN
go

/*
 * R_CSM_PENILAIAN: recreate table, drop column nilai_a, nilai_b, nilai_c,
 * and nilai_d.
 */
create table R_CSM_PENILAIAN (
	ID			int				identity primary key
,	ID_FAKTOR	int				not null foreign key references R_CSM_FAKTOR_PENILAIAN (ID)
,	KETERANGAN	varchar(1024)	not null
)
go

create table T_CSM_PROYEK_KONT_NILAI (
   ID_PROJECT           bigint               not null,
   ID_KONTRAKTOR        bigint               not null,
   ID_PENILAIAN         int                  not null,
   NILAI                int                  not null default 0,
   KETERANGAN           varchar(512)         not null default '',
   constraint PK_T_CSM_PROYEK_KONT_NILAI primary key (ID_PROJECT, ID_KONTRAKTOR, ID_PENILAIAN)
)
go

/*
 * R_CSM_PENILAIAN_DETAIL: new table, nilai dan keterangan dari penilaian.
 */
create table R_CSM_PENILAIAN_DETAIL (
	ID				int				identity primary key
,	ID_PENILAIAN	int				not null foreign key references R_CSM_PENILAIAN (ID)
,	NILAI			int				not null
,	KETERANGAN		varchar(1024)	not null
)
go
