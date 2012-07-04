if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE') and o.name = 'FK_T_PEGAWAI_KOMITE_T_RAPAT_ABSENSI_KOMITE')
alter table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE
   drop constraint FK_T_PEGAWAI_KOMITE_T_RAPAT_ABSENSI_KOMITE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE')
            and   name  = 'T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE.T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN_TEMP')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN_TEMP
go

create table T_LINGKUNGAN_BULANAN_TEMP (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   PEKERJAAN            varchar(512)         not null default '',
   LOKASI_PROYEK        varchar(512)         not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_BULANAN_TEMP primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

alter table T_LINGKUNGAN_BULANAN_TEMP
   add constraint FK_R_DIVPROSBU_T_LINGKUNGAN_BULANAN_TEMP foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

insert into T_LINGKUNGAN_BULANAN_TEMP
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	PEKERJAAN
	,	LOKASI_PROYEK
	,	ID_USER
	,	TANGGAL_AKSES
from	T_LINGKUNGAN_BULANAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN_BULANAN_DETAIL') and o.name = 'FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL')
alter table T_LINGKUNGAN_BULANAN_DETAIL
   drop constraint FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN
go

create table T_LINGKUNGAN_BULANAN (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   PEKERJAAN            varchar(512)         not null default '',
   LOKASI_PROYEK        varchar(512)         not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_BULANAN primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

alter table T_LINGKUNGAN_BULANAN
   add constraint FK_R_DIVPROSBU_T_LINGKUNGAN_BULANAN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN_DETAIL_TEMP')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN_DETAIL_TEMP
go

create table T_LINGKUNGAN_BULANAN_DETAIL_TEMP (
   ID_LINGKUNGAN_BULANAN_DETAIL bigint       not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   TIPE_KEGIATAN        tinyint              not null default 1,
   NAMA_KEGIATAN        varchar(512)         not null default '',
   TANGGAL_AWAL         datetime             not null default getdate(),
   TANGGAL_AKHIR        datetime             not null default getdate(),
   URAIAN_KEGIATAN      varchar(1024)        not null default '',
   KETERANGAN           varchar(512)         null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_BULANAN_DETAIL_TEMP primary key (ID_LINGKUNGAN_BULANAN_DETAIL)
)
go

insert into T_LINGKUNGAN_BULANAN_DETAIL_TEMP
select	ID_LINGKUNGAN_BULANAN_DETAIL
	,	3
	,	1
	,	TAHUN
	,	BULAN
	,	TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	TANGGAL_AWAL
	,	TANGGAL_AKHIR
	,	URAIAN_KEGIATAN
	,	KETERANGAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_LINGKUNGAN_BULANAN_DETAIL

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN_DETAIL')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN_DETAIL
go

create table T_LINGKUNGAN_BULANAN_DETAIL (
   ID_LINGKUNGAN_BULANAN_DETAIL bigint       not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   TIPE_KEGIATAN        tinyint              not null default 1,
   NAMA_KEGIATAN        varchar(512)         not null default '',
   TANGGAL_AWAL         datetime             not null default getdate(),
   TANGGAL_AKHIR        datetime             not null default getdate(),
   URAIAN_KEGIATAN      varchar(1024)        not null default '',
   KETERANGAN           varchar(512)         null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_BULANAN_DETAIL primary key (ID_LINGKUNGAN_BULANAN_DETAIL)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 : Kegiatan Pengelolaan Lingkungan
   2 : Kegiatan TJSL',
   'user', @CurrentUser, 'table', 'T_LINGKUNGAN_BULANAN_DETAIL', 'column', 'TIPE_KEGIATAN'
go

create index T_LINGKUNGAN_BULANAN_DETAIL_FK on T_LINGKUNGAN_BULANAN_DETAIL (
ID_DIREKTORAT ASC,
ID_DIVPROSBU ASC,
TAHUN ASC,
BULAN ASC
)
go

alter table T_LINGKUNGAN_BULANAN_DETAIL
   add constraint FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL foreign key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
      references T_LINGKUNGAN_BULANAN (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
go

insert into T_LINGKUNGAN_BULANAN
select	*
from	T_LINGKUNGAN_BULANAN_TEMP

insert into T_LINGKUNGAN_BULANAN_DETAIL
select	*
from	T_LINGKUNGAN_BULANAN_DETAIL_TEMP

drop table T_LINGKUNGAN_BULANAN_TEMP
go

drop table T_LINGKUNGAN_BULANAN_DETAIL_TEMP
go
