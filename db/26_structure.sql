if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN_TEMP')
            and   type = 'U')
   drop table T_KEGIATAN_TEMP
go

create table T_KEGIATAN_TEMP (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN_TEMP primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

insert	into T_KEGIATAN_TEMP
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_KEGIATAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_AREA_PERHATIAN_DETAIL') and o.name = 'FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL')
alter table T_AREA_PERHATIAN_DETAIL
   drop constraint FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_KEGIATAN_DETAIL') and o.name = 'FK_T_KEGIATAN_T_KEGIATAN_DETAIL')
alter table T_KEGIATAN_DETAIL
   drop constraint FK_T_KEGIATAN_T_KEGIATAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN')
            and   type = 'U')
   drop table T_KEGIATAN
go

create table T_KEGIATAN (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

alter table T_KEGIATAN
   add constraint FK_R_DIVPROSBU_T_KEGIATAN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_AREA_PERHATIAN_DETAIL_TEMP')
            and   type = 'U')
   drop table T_AREA_PERHATIAN_DETAIL_TEMP
go

create table T_AREA_PERHATIAN_DETAIL_TEMP (
   ID_AREA_PERHATIAN_DETAIL bigint           not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_AREA_PERHATIAN smallint           not null,
   NAMA_AREA_PERHATIAN  varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_AREA_PERHATIAN_DETAIL_TEMP primary key (ID_AREA_PERHATIAN_DETAIL)
)
go

insert	into T_AREA_PERHATIAN_DETAIL_TEMP
select	ID_AREA_PERHATIAN_DETAIL
	,	3
	,	1
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_AREA_PERHATIAN
	,	NAMA_AREA_PERHATIAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_AREA_PERHATIAN_DETAIL')
            and   type = 'U')
   drop table T_AREA_PERHATIAN_DETAIL
go

create table T_AREA_PERHATIAN_DETAIL (
   ID_AREA_PERHATIAN_DETAIL bigint           identity,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_AREA_PERHATIAN smallint           not null,
   NAMA_AREA_PERHATIAN  varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_AREA_PERHATIAN_DETAIL primary key (ID_AREA_PERHATIAN_DETAIL)
)
go

create index T_AREA_PERHATIAN_DETAIL_FK_T_KEGIATAN on T_AREA_PERHATIAN_DETAIL (
ID_DIREKTORAT ASC,
ID_DIVPROSBU ASC,
TAHUN ASC,
BULAN ASC
)
go

create index T_AREA_PERHATIAN_DETAIL_FK_R_WILAYAH on T_AREA_PERHATIAN_DETAIL (
ID_WILAYAH ASC
)
go

create index T_AREA_PERHATIAN_DETAIL_FK_R_TIPE_AREA_PERHATIAN on T_AREA_PERHATIAN_DETAIL (
ID_TIPE_AREA_PERHATIAN ASC
)
go

alter table T_AREA_PERHATIAN_DETAIL
   add constraint FK_R_TIPE_AREA_PERHATIAN_T_AREA_PERHATIAN_DETAIL foreign key (ID_TIPE_AREA_PERHATIAN)
      references R_TIPE_AREA_PERHATIAN (ID_TIPE_AREA_PERHATIAN)
go

alter table T_AREA_PERHATIAN_DETAIL
   add constraint FK_R_WILAYAH_T_AREA_PERHATIAN_DETAIL foreign key (ID_WILAYAH)
      references R_WILAYAH (ID_WILAYAH)
go

alter table T_AREA_PERHATIAN_DETAIL
   add constraint FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL foreign key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
      references T_KEGIATAN (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN_DETAIL_TEMP')
            and   type = 'U')
   drop table T_KEGIATAN_DETAIL_TEMP
go

create table T_KEGIATAN_DETAIL_TEMP (
   ID_KEGIATAN_DETAIL   bigint               not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_KEGIATAN     smallint             not null,
   NAMA_KEGIATAN        varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN_DETAIL_TEMP primary key (ID_KEGIATAN_DETAIL)
)
go

insert	into T_KEGIATAN_DETAIL_TEMP
select	ID_KEGIATAN_DETAIL
	,	3
	,	1
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_KEGIATAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN_DETAIL')
            and   type = 'U')
   drop table T_KEGIATAN_DETAIL
go

create table T_KEGIATAN_DETAIL (
   ID_KEGIATAN_DETAIL   bigint               identity,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_KEGIATAN     smallint             not null,
   NAMA_KEGIATAN        varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN_DETAIL primary key (ID_KEGIATAN_DETAIL)
)
go

create index T_KEGIATAN_DETAIL_FK_T_KEGIATAN on T_KEGIATAN_DETAIL (
ID_DIREKTORAT ASC,
ID_DIVPROSBU ASC,
TAHUN ASC,
BULAN ASC
)
go

create index T_KEGIATAN_DETAIL_FK_R_WILAYAH on T_KEGIATAN_DETAIL (
ID_WILAYAH ASC
)
go

create index T_KEGIATAN_DETAIL_FK_R_TIPE_KEGIATAN on T_KEGIATAN_DETAIL (
ID_TIPE_KEGIATAN ASC
)
go

alter table T_KEGIATAN_DETAIL
   add constraint FK_R_TIPE_KEGIATAN_T_KEGIATAN_DETAIL foreign key (ID_TIPE_KEGIATAN)
      references R_TIPE_KEGIATAN (ID_TIPE_KEGIATAN)
go

alter table T_KEGIATAN_DETAIL
   add constraint FK_R_WILAYAH_T_KEGIATAN_DETAIL foreign key (ID_WILAYAH)
      references R_WILAYAH (ID_WILAYAH)
go

alter table T_KEGIATAN_DETAIL
   add constraint FK_T_KEGIATAN_T_KEGIATAN_DETAIL foreign key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
      references T_KEGIATAN (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
go

insert	into T_KEGIATAN
select	*
from	T_KEGIATAN_TEMP
go

insert	into T_AREA_PERHATIAN_DETAIL(
		ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_AREA_PERHATIAN
	,	NAMA_AREA_PERHATIAN
	,	ID_USER
	,	TANGGAL_AKSES
)
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_AREA_PERHATIAN
	,	NAMA_AREA_PERHATIAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_AREA_PERHATIAN_DETAIL_TEMP
go

insert	into T_KEGIATAN_DETAIL(
		ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	ID_USER
	,	TANGGAL_AKSES
)
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_KEGIATAN_DETAIL_TEMP
go

drop table T_KEGIATAN_TEMP
go

drop table T_AREA_PERHATIAN_DETAIL_TEMP
go

drop table T_KEGIATAN_DETAIL_TEMP
go
