if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN') and o.name = 'FK_R_SEKSI_T_LINGKUNGAN')
alter table T_LINGKUNGAN
   drop constraint FK_R_SEKSI_T_LINGKUNGAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_LINGKUNGAN')
            and   name  = 'T_LINGKUNGAN_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index T_LINGKUNGAN.T_LINGKUNGAN_FK_R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_INSIDEN') and o.name = 'FK_R_SEKSI_T_INSIDEN')
alter table T_INSIDEN
   drop constraint FK_R_SEKSI_T_INSIDEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_INSIDEN')
            and   name  = 'T_INSIDEN_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index T_INSIDEN.T_INSIDEN_FK_R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP') and o.name = 'FK_R_SEKSI_T_STOP')
alter table T_STOP
   drop constraint FK_R_SEKSI_T_STOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_STOP')
            and   name  = 'T_STOP_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index T_STOP.T_STOP_FK_R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PEGAWAI') and o.name = 'FK_R_SEKSI_R_PEGAWAI')
alter table R_PEGAWAI
   drop constraint FK_R_SEKSI_R_PEGAWAI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_PEGAWAI')
            and   name  = 'R_PEGAWAI_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index R_PEGAWAI.R_PEGAWAI_FK_R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_SEKSI') and o.name = 'FK_R_DINAS_R_SEKSI')
alter table R_SEKSI
   drop constraint FK_R_DINAS_R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_SEKSI') and o.name = 'FK_R_WILAYAH_R_SEKSI')
alter table R_SEKSI
   drop constraint FK_R_WILAYAH_R_SEKSI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_SEKSI')
            and   name  = 'R_SEKSI_FK_R_WILAYAH'
            and   indid > 0
            and   indid < 255)
   drop index R_SEKSI.R_SEKSI_FK_R_WILAYAH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_SEKSI')
            and   name  = 'R_SEKSI_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_SEKSI.R_SEKSI_FK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DINAS') and o.name = 'FK_R_DEPARTEMEN_R_DINAS')
alter table R_DINAS
   drop constraint FK_R_DEPARTEMEN_R_DINAS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_DINAS')
            and   name  = 'R_DINAS_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_DINAS.R_DINAS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DEPARTEMEN_TEMP')
            and   type = 'U')
   drop table R_DEPARTEMEN_TEMP
go

/*==============================================================*/
/* Table: R_DEPARTEMEN_TEMP                                     */
/*==============================================================*/
create table R_DEPARTEMEN_TEMP (
   ID_DEPARTEMEN        int                  not null,
   NAMA_DEPARTEMEN      varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DEPARTEMEN_TEMP primary key (ID_DEPARTEMEN)
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DINAS_TEMP')
            and   type = 'U')
   drop table R_DINAS_TEMP
go

/*==============================================================*/
/* Table: R_DINAS_TEMP                                          */
/*==============================================================*/
create table R_DINAS_TEMP (
   ID_DINAS             int                  not null,
   ID_DEPARTEMEN        int                  not null,
   NAMA_DINAS           varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DINAS_TEMP primary key (ID_DINAS, ID_DEPARTEMEN)
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_SEKSI_TEMP')
            and   type = 'U')
   drop table R_SEKSI_TEMP
go

/*==============================================================*/
/* Table: R_SEKSI_TEMP                                          */
/*==============================================================*/
create table R_SEKSI_TEMP (
   ID_SEKSI             int                  not null,
   ID_DINAS             int                  not null,
   ID_DEPARTEMEN        int                  not null,
   ID_WILAYAH           int                  null,
   NAMA_SEKSI           varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_SEKSI_TEMP primary key (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
)
go

insert into R_DEPARTEMEN_TEMP select * from R_DEPARTEMEN
go
insert into R_DINAS_TEMP select * from R_DINAS
go
insert into R_SEKSI_TEMP select * from R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DIVPROSBU') and o.name = 'FK_R_DIREKTORAT_R_DIVPROSBU')
alter table R_DIVPROSBU
   drop constraint FK_R_DIREKTORAT_R_DIVPROSBU
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DIREKTORAT')
            and   type = 'U')
   drop table R_DIREKTORAT
go

/*==============================================================*/
/* Table: R_DIREKTORAT                                          */
/*==============================================================*/
create table R_DIREKTORAT (
   ID_DIREKTORAT        int                  identity,
   NAMA_DIREKTORAT      varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DIREKTORAT primary key (ID_DIREKTORAT)
)
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DEPARTEMEN') and o.name = 'FK_R_DIVPROSBU_R_DEPARTEMEN')
alter table R_DEPARTEMEN
   drop constraint FK_R_DIVPROSBU_R_DEPARTEMEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DIVPROSBU') and o.name = 'FK_R_DIREKTORAT_R_DIVPROSBU')
alter table R_DIVPROSBU
   drop constraint FK_R_DIREKTORAT_R_DIVPROSBU
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DIVPROSBU')
            and   type = 'U')
   drop table R_DIVPROSBU
go

/*==============================================================*/
/* Table: R_DIVPROSBU                                           */
/*==============================================================*/
create table R_DIVPROSBU (
   ID_DIVPROSBU         int                  identity,
   ID_DIREKTORAT        int                  not null,
   NAMA_DIVPROSBU       varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DIVPROSBU primary key (ID_DIVPROSBU, ID_DIREKTORAT)
)
go

alter table R_DIVPROSBU
   add constraint FK_R_DIREKTORAT_R_DIVPROSBU foreign key (ID_DIREKTORAT)
      references R_DIREKTORAT (ID_DIREKTORAT)
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DEPARTEMEN') and o.name = 'FK_R_DIVPROSBU_R_DEPARTEMEN')
alter table R_DEPARTEMEN
   drop constraint FK_R_DIVPROSBU_R_DEPARTEMEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DINAS') and o.name = 'FK_R_DEPARTEMEN_R_DINAS')
alter table R_DINAS
   drop constraint FK_R_DEPARTEMEN_R_DINAS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DEPARTEMEN')
            and   type = 'U')
   drop table R_DEPARTEMEN
go

/*==============================================================*/
/* Table: R_DEPARTEMEN                                          */
/*==============================================================*/
create table R_DEPARTEMEN (
   ID_DEPARTEMEN        int                  identity,
   ID_DIVPROSBU         int                  not null,
   ID_DIREKTORAT        int                  not null,
   NAMA_DEPARTEMEN      varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DEPARTEMEN primary key (ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
)
go

alter table R_DEPARTEMEN
   add constraint FK_R_DIVPROSBU_R_DEPARTEMEN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DINAS') and o.name = 'FK_R_DEPARTEMEN_R_DINAS')
alter table R_DINAS
   drop constraint FK_R_DEPARTEMEN_R_DINAS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_SEKSI') and o.name = 'FK_R_DINAS_R_SEKSI')
alter table R_SEKSI
   drop constraint FK_R_DINAS_R_SEKSI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_DINAS')
            and   name  = 'R_DINAS_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_DINAS.R_DINAS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DINAS')
            and   type = 'U')
   drop table R_DINAS
go

/*==============================================================*/
/* Table: R_DINAS                                               */
/*==============================================================*/
create table R_DINAS (
   ID_DINAS             int                  identity,
   ID_DEPARTEMEN        int                  not null,
   ID_DIVPROSBU         int                  not null,
   ID_DIREKTORAT        int                  not null,
   NAMA_DINAS           varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DINAS primary key (ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
)
go

/*==============================================================*/
/* Index: R_DINAS_FK                                            */
/*==============================================================*/
create index R_DINAS_FK on R_DINAS (
ID_DEPARTEMEN ASC,
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table R_DINAS
   add constraint FK_R_DEPARTEMEN_R_DINAS foreign key (ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DEPARTEMEN (ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PEGAWAI') and o.name = 'FK_R_SEKSI_R_PEGAWAI')
alter table R_PEGAWAI
   drop constraint FK_R_SEKSI_R_PEGAWAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_SEKSI') and o.name = 'FK_R_DINAS_R_SEKSI')
alter table R_SEKSI
   drop constraint FK_R_DINAS_R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_SEKSI') and o.name = 'FK_R_WILAYAH_R_SEKSI')
alter table R_SEKSI
   drop constraint FK_R_WILAYAH_R_SEKSI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_INSIDEN') and o.name = 'FK_R_SEKSI_T_INSIDEN')
alter table T_INSIDEN
   drop constraint FK_R_SEKSI_T_INSIDEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN') and o.name = 'FK_R_SEKSI_T_LINGKUNGAN')
alter table T_LINGKUNGAN
   drop constraint FK_R_SEKSI_T_LINGKUNGAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP') and o.name = 'FK_R_SEKSI_T_STOP')
alter table T_STOP
   drop constraint FK_R_SEKSI_T_STOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_SEKSI')
            and   name  = 'R_SEKSI_FK_R_WILAYAH'
            and   indid > 0
            and   indid < 255)
   drop index R_SEKSI.R_SEKSI_FK_R_WILAYAH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_SEKSI')
            and   name  = 'R_SEKSI_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_SEKSI.R_SEKSI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_SEKSI')
            and   type = 'U')
   drop table R_SEKSI
go

/*==============================================================*/
/* Table: R_SEKSI                                               */
/*==============================================================*/
create table R_SEKSI (
   ID_SEKSI             int                  identity,
   ID_DINAS             int                  not null,
   ID_DEPARTEMEN        int                  not null,
   ID_DIVPROSBU         int                  not null,
   ID_DIREKTORAT        int                  not null,
   ID_WILAYAH           int                  null,
   NAMA_SEKSI           varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_SEKSI primary key (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
)
go

/*==============================================================*/
/* Index: R_SEKSI_FK                                            */
/*==============================================================*/
create index R_SEKSI_FK on R_SEKSI (
ID_DINAS ASC,
ID_DEPARTEMEN ASC,
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

/*==============================================================*/
/* Index: R_SEKSI_FK_R_WILAYAH                                  */
/*==============================================================*/
create index R_SEKSI_FK_R_WILAYAH on R_SEKSI (
ID_WILAYAH ASC
)
go

alter table R_SEKSI
   add constraint FK_R_DINAS_R_SEKSI foreign key (ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DINAS (ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table R_SEKSI
   add constraint FK_R_WILAYAH_R_SEKSI foreign key (ID_WILAYAH)
      references R_WILAYAH (ID_WILAYAH)
go

insert into R_DIREKTORAT (NAMA_DIREKTORAT, ID_USER) values ('Direktorat Utama', '1')
go
insert into R_DIREKTORAT (NAMA_DIREKTORAT, ID_USER) values ('Direktorat Teknologi Dan Pengembangan', '1')
go
insert into R_DIREKTORAT (NAMA_DIREKTORAT, ID_USER) values ('Direktorat Pengusahaan', '1')
go
insert into R_DIREKTORAT (NAMA_DIREKTORAT, ID_USER) values ('Direktorat Keuangan', '1')
go
insert into R_DIREKTORAT (NAMA_DIREKTORAT, ID_USER) values ('Direktorat SDM Dan Umum', '1')
go
insert into R_DIREKTORAT (NAMA_DIREKTORAT, ID_USER) values ('Direktorat Perencanaan Investasi Dan Manajemen Risiko', '1')
go

insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, ID_USER) values (3, 'SBU-1', '1')
go

insert	into R_DEPARTEMEN (ID_DIVPROSBU, ID_DIREKTORAT, NAMA_DEPARTEMEN, ID_USER)
select	1
	,	3
	,	NAMA_DEPARTEMEN
	,	ID_USER
from	R_DEPARTEMEN_TEMP
go

insert	into R_DINAS (ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT, NAMA_DINAS, ID_USER)
select	ID_DEPARTEMEN
	,	1
	,	3
	,	NAMA_DINAS
	,	ID_USER
from	R_DINAS_TEMP
go

insert	into R_SEKSI (ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT, ID_WILAYAH, NAMA_SEKSI, ID_USER)
select	ID_DINAS
	,	ID_DEPARTEMEN
	,	1
	,	3
	,	ID_WILAYAH
	,	NAMA_SEKSI
	,	ID_USER
from	R_SEKSI_TEMP
go

alter table R_PEGAWAI add ID_DIVPROSBU int
go
alter table R_PEGAWAI add ID_DIREKTORAT int
go

update	R_PEGAWAI
set		ID_DIVPROSBU	= 1
	,	ID_DIREKTORAT	= 3
go

alter table R_PEGAWAI alter column ID_DIVPROSBU int not null
go
alter table R_PEGAWAI alter column ID_DIREKTORAT int not null
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PEGAWAI') and o.name = 'FK_R_SEKSI_R_PEGAWAI')
alter table R_PEGAWAI
   drop constraint FK_R_SEKSI_R_PEGAWAI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_PEGAWAI')
            and   name  = 'R_PEGAWAI_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index R_PEGAWAI.R_PEGAWAI_FK_R_SEKSI
go

/*==============================================================*/
/* Index: R_PEGAWAI_FK_R_SEKSI                                  */
/*==============================================================*/
create index R_PEGAWAI_FK_R_SEKSI on R_PEGAWAI (
ID_SEKSI ASC,
ID_DINAS ASC,
ID_DEPARTEMEN ASC,
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table R_PEGAWAI
   add constraint FK_R_SEKSI_R_PEGAWAI foreign key (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_STOP add ID_DIVPROSBU int
go
alter table T_STOP add ID_DIREKTORAT int
go
alter table T_STOP add ID_AREA_DIVPROSBU int
go
alter table T_STOP add ID_AREA_DIREKTORAT int
go

update	T_STOP
set		ID_DIVPROSBU	= 1
	,	ID_DIREKTORAT	= 3
go

alter table T_STOP alter column ID_DIVPROSBU int not null
go
alter table T_STOP alter column ID_DIREKTORAT int not null
go

update	T_STOP
set		ID_AREA_DIVPROSBU	= 1
	,	ID_AREA_DIREKTORAT	= 3
go

alter table T_STOP alter column ID_AREA_DIVPROSBU int not null
go
alter table T_STOP alter column ID_AREA_DIREKTORAT int not null
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP') and o.name = 'FK_R_SEKSI_T_STOP')
alter table T_STOP
   drop constraint FK_R_SEKSI_T_STOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_STOP')
            and   name  = 'T_STOP_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index T_STOP.T_STOP_FK_R_SEKSI
go

/*==============================================================*/
/* Index: T_STOP_FK_R_SEKSI                                     */
/*==============================================================*/
create index T_STOP_FK_R_SEKSI on T_STOP (
ID_AREA_SEKSI ASC,
ID_AREA_DINAS ASC,
ID_AREA_DEPARTEMEN ASC,
ID_AREA_DIVPROSBU ASC,
ID_AREA_DIREKTORAT ASC
)
go

alter table T_STOP
   add constraint FK_R_SEKSI_T_STOP foreign key (ID_AREA_SEKSI, ID_AREA_DINAS, ID_AREA_DEPARTEMEN, ID_AREA_DIVPROSBU, ID_AREA_DIREKTORAT)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_INSIDEN add ID_AREA_DIVPROSBU int
go
alter table T_INSIDEN add ID_AREA_DIREKTORAT int
go

update	T_INSIDEN
set		ID_AREA_DIVPROSBU	= 1
	,	ID_AREA_DIREKTORAT	= 3
go

alter table T_INSIDEN alter column ID_AREA_DIVPROSBU int not null
go
alter table T_INSIDEN alter column ID_AREA_DIREKTORAT int not null
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_INSIDEN') and o.name = 'FK_R_SEKSI_T_INSIDEN')
alter table T_INSIDEN
   drop constraint FK_R_SEKSI_T_INSIDEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_INSIDEN')
            and   name  = 'T_INSIDEN_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index T_INSIDEN.T_INSIDEN_FK_R_SEKSI
go

/*==============================================================*/
/* Index: T_INSIDEN_FK_R_SEKSI                                  */
/*==============================================================*/
create index T_INSIDEN_FK_R_SEKSI on T_INSIDEN (
ID_AREA_SEKSI ASC,
ID_AREA_DINAS ASC,
ID_AREA_DEPARTEMEN ASC,
ID_AREA_DIVPROSBU ASC,
ID_AREA_DIREKTORAT ASC
)
go

alter table T_INSIDEN
   add constraint FK_R_SEKSI_T_INSIDEN foreign key (ID_AREA_SEKSI, ID_AREA_DINAS, ID_AREA_DEPARTEMEN, ID_AREA_DIVPROSBU, ID_AREA_DIREKTORAT)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_RCA add AUDITOR_DIREKTORAT int
go

alter table T_RCA add AUDITOR_DIVPROSBU int
go

alter table T_RCA add PENANGGUNG_JAWAB_DIREKTORAT int
go

alter table T_RCA add PENANGGUNG_JAWAB_DIVPROSBU int
go

update	T_RCA
set		AUDITOR_DIREKTORAT			= 3
	,	AUDITOR_DIVPROSBU			= 1
	,	PENANGGUNG_JAWAB_DIREKTORAT	= 3
	,	PENANGGUNG_JAWAB_DIVPROSBU	= 1
go

alter table T_RCA alter column AUDITOR_DIREKTORAT int not null
go

alter table T_RCA alter column AUDITOR_DIVPROSBU int not null
go

alter table T_RCA alter column PENANGGUNG_JAWAB_DIREKTORAT int not null
go

alter table T_RCA alter column PENANGGUNG_JAWAB_DIVPROSBU int not null
go

alter table T_LINGKUNGAN add ID_DIVPROSBU int
go
alter table T_LINGKUNGAN add ID_DIREKTORAT int
go

update	T_LINGKUNGAN
set		ID_DIVPROSBU	= 1
	,	ID_DIREKTORAT	= 3
go

alter table T_LINGKUNGAN alter column ID_DIVPROSBU int not null
go
alter table T_LINGKUNGAN alter column ID_DIREKTORAT int not null
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN') and o.name = 'FK_R_SEKSI_T_LINGKUNGAN')
alter table T_LINGKUNGAN
   drop constraint FK_R_SEKSI_T_LINGKUNGAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_LINGKUNGAN')
            and   name  = 'T_LINGKUNGAN_FK_R_SEKSI'
            and   indid > 0
            and   indid < 255)
   drop index T_LINGKUNGAN.T_LINGKUNGAN_FK_R_SEKSI
go

/*==============================================================*/
/* Index: T_LINGKUNGAN_FK_R_SEKSI                               */
/*==============================================================*/
create index T_LINGKUNGAN_FK_R_SEKSI on T_LINGKUNGAN (
ID_SEKSI ASC,
ID_DINAS ASC,
ID_DEPARTEMEN ASC,
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_LINGKUNGAN
   add constraint FK_R_SEKSI_T_LINGKUNGAN foreign key (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
go

drop table R_DEPARTEMEN_TEMP
go
drop table R_DINAS_TEMP
go
drop table R_SEKSI_TEMP
go
