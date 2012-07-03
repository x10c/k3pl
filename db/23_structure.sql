if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT') and o.name = 'FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT')
alter table T_RAPAT
   drop constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_JABATAN_KOMITE_SUB_KOMITE') and o.name = 'FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE')
alter table R_JABATAN_KOMITE_SUB_KOMITE
   drop constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PEGAWAI_KOMITE_SUB_KOMITE') and o.name = 'FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE')
alter table T_PEGAWAI_KOMITE_SUB_KOMITE
   drop constraint FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP')
            and   type = 'U')
   drop table R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP
go

/*==============================================================*/
/* Table: R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP                  */
/*==============================================================*/
create table R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP (
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint             not null,
   NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP primary key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_JABATAN_KOMITE_SUB_KOMITE_TEMP')
            and   type = 'U')
   drop table R_JABATAN_KOMITE_SUB_KOMITE_TEMP
go

/*==============================================================*/
/* Table: R_JABATAN_KOMITE_SUB_KOMITE_TEMP                      */
/*==============================================================*/
create table R_JABATAN_KOMITE_SUB_KOMITE_TEMP (
   ID_JABATAN_KOMITE    smallint             not null,
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint             null,
   NAMA_JABATAN_KOMITE  varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_JABATAN_KOMITE_SUB_KOMITE_TEMP primary key (ID_JABATAN_KOMITE)
)
go

insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP select * from R_KEL_JABATAN_KOMITE_SUB_KOMITE
go

insert into R_JABATAN_KOMITE_SUB_KOMITE_TEMP select * from R_JABATAN_KOMITE_SUB_KOMITE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KEL_JABATAN_CSC') and o.name = 'FK_R_DIVPROSBU_R_KEL_JABATAN_CSC')
alter table R_KEL_JABATAN_CSC
   drop constraint FK_R_DIVPROSBU_R_KEL_JABATAN_CSC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KEL_JABATAN_CSC')
            and   name  = 'R_KEL_JABATAN_CSC_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_KEL_JABATAN_CSC.R_KEL_JABATAN_CSC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KEL_JABATAN_CSC')
            and   type = 'U')
   drop table R_KEL_JABATAN_CSC
go

/*==============================================================*/
/* Table: R_KEL_JABATAN_CSC                                     */
/*==============================================================*/
create table R_KEL_JABATAN_CSC (
   ID_KEL_JABATAN_CSC   smallint             identity,
   ID_DIVPROSBU         int                  null,
   ID_DIREKTORAT        int                  null,
   NAMA_KEL_JABATAN_CSC varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KEL_JABATAN_CSC primary key (ID_KEL_JABATAN_CSC)
)
go

/*==============================================================*/
/* Index: R_KEL_JABATAN_CSC_FK                                  */
/*==============================================================*/
create index R_KEL_JABATAN_CSC_FK on R_KEL_JABATAN_CSC (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table R_KEL_JABATAN_CSC
   add constraint FK_R_DIVPROSBU_R_KEL_JABATAN_CSC foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC, ID_USER) values ('ECSC', '1')
go
insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC, ID_USER) values ('CSC DIRTEKBANG', '1')
go
insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC, ID_USER) values ('CSC PROYEK', '1')
go
insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC, ID_USER) values ('CSC DIRUS', '1')
go
insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC, ID_USER) values ('CSC SBU-1', '1')
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KEL_JABATAN_KOMITE_SUB_KOMITE')
            and   name  = 'R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index R_KEL_JABATAN_KOMITE_SUB_KOMITE.R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_DIVPROSBU
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KEL_JABATAN_KOMITE_SUB_KOMITE')
            and   name  = 'R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_CSC'
            and   indid > 0
            and   indid < 255)
   drop index R_KEL_JABATAN_KOMITE_SUB_KOMITE.R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_CSC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KEL_JABATAN_KOMITE_SUB_KOMITE')
            and   type = 'U')
   drop table R_KEL_JABATAN_KOMITE_SUB_KOMITE
go

/*==============================================================*/
/* Table: R_KEL_JABATAN_KOMITE_SUB_KOMITE                       */
/*==============================================================*/
create table R_KEL_JABATAN_KOMITE_SUB_KOMITE (
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint             not null,
   ID_KEL_JABATAN_CSC   smallint             not null,
   ID_DIVPROSBU         int                  null,
   ID_DIREKTORAT        int                  null,
   NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KEL_JABATAN_KOMITE_SUB_KO primary key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
)
go

/*==============================================================*/
/* Index: R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_CSC  */
/*==============================================================*/
create index R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_CSC on R_KEL_JABATAN_KOMITE_SUB_KOMITE (
ID_KEL_JABATAN_CSC ASC
)
go

/*==============================================================*/
/* Index: R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_DIVPROSBU        */
/*==============================================================*/
create index R_KEL_JABATAN_KOMITE_SUB_KOMITE_FK_R_DIVPROSBU on R_KEL_JABATAN_KOMITE_SUB_KOMITE (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table R_KEL_JABATAN_KOMITE_SUB_KOMITE
   add constraint FK_R_DIVPROSBU_R_KEL_JABATAN_KOMITE_SUB_KOMITE foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table R_KEL_JABATAN_KOMITE_SUB_KOMITE
   add constraint FK_R_KEL_JABATAN_CSC_R_KEL_JABATAN_KOMITE_SUB_KOMITE foreign key (ID_KEL_JABATAN_CSC)
      references R_KEL_JABATAN_CSC (ID_KEL_JABATAN_CSC)
go

insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC, ID_DIVPROSBU, ID_DIREKTORAT, NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_USER)
select	ID_KEL_JABATAN_KOMITE_SUB_KOMITE
	,	5
	,	1
	,	3
	,	NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE
	,	ID_USER
from	R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_JABATAN_KOMITE_SUB_KOMITE')
            and   type = 'U')
   drop table R_JABATAN_KOMITE_SUB_KOMITE
go

/*==============================================================*/
/* Table: R_JABATAN_KOMITE_SUB_KOMITE                           */
/*==============================================================*/
create table R_JABATAN_KOMITE_SUB_KOMITE (
   ID_JABATAN_KOMITE    smallint             identity,
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint null,
   ID_KEL_JABATAN_CSC   smallint             null,
   NAMA_JABATAN_KOMITE  varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_JABATAN_KOMITE_SUB_KOMITE primary key (ID_JABATAN_KOMITE)
)
go

/*=======================================================================*/
/* Index: R_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE */
/*=======================================================================*/
create index R_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE on R_JABATAN_KOMITE_SUB_KOMITE (
ID_KEL_JABATAN_KOMITE_SUB_KOMITE ASC
)
go

/*==============================================================*/
/* Index: R_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_CSC      */
/*==============================================================*/
create index R_JABATAN_KOMITE_SUB_KOMITE_FK_R_KEL_JABATAN_CSC on R_JABATAN_KOMITE_SUB_KOMITE (
ID_KEL_JABATAN_CSC ASC
)
go

alter table R_JABATAN_KOMITE_SUB_KOMITE
   add constraint FK_R_KEL_JABATAN_CSC_R_JABATAN_KOMITE_SUB_KOMITE foreign key (ID_KEL_JABATAN_CSC)
      references R_KEL_JABATAN_CSC (ID_KEL_JABATAN_CSC)
go

alter table R_JABATAN_KOMITE_SUB_KOMITE
   add constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_R_JABATAN_KOMITE_SUB_KOMITE foreign key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
      references R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
go

insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC, NAMA_JABATAN_KOMITE, ID_USER)
select	ID_KEL_JABATAN_KOMITE_SUB_KOMITE
	,	5
	,	NAMA_JABATAN_KOMITE
	,	ID_USER
from	R_JABATAN_KOMITE_SUB_KOMITE_TEMP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PEGAWAI_KOMITE_SUB_KOMITE') and o.name = 'FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE')
alter table T_PEGAWAI_KOMITE_SUB_KOMITE
   drop constraint FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE
go

alter table T_PEGAWAI_KOMITE_SUB_KOMITE
   add constraint FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE foreign key (ID_JABATAN_KOMITE)
      references R_JABATAN_KOMITE_SUB_KOMITE (ID_JABATAN_KOMITE)
go

alter table T_RAPAT alter column ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint
go
alter table T_RAPAT add ID_KEL_JABATAN_CSC smallint
go

update T_RAPAT set ID_KEL_JABATAN_CSC = 5
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT') and o.name = 'FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT')
alter table T_RAPAT
   drop constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_RAPAT')
            and   name  = 'T_RAPAT_FK_R_KEL_JABATAN_CSC'
            and   indid > 0
            and   indid < 255)
   drop index T_RAPAT.T_RAPAT_FK_R_KEL_JABATAN_CSC
go

/*==============================================================*/
/* Index: T_RAPAT_FK_R_KEL_JABATAN_CSC                          */
/*==============================================================*/
create index T_RAPAT_FK_R_KEL_JABATAN_CSC on T_RAPAT (
ID_KEL_JABATAN_CSC ASC
)
go

alter table T_RAPAT
   add constraint FK_R_KEL_JABATAN_CSC_T_RAPAT foreign key (ID_KEL_JABATAN_CSC)
      references R_KEL_JABATAN_CSC (ID_KEL_JABATAN_CSC)
go

alter table T_RAPAT
   add constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT foreign key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
      references R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
go

drop table R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP
go

drop table R_JABATAN_KOMITE_SUB_KOMITE_TEMP
go

alter table R_JABATAN_KOMITE_SUB_KOMITE add NOTULEN tinyint default 0
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1=true; 0=false',
   'user', @CurrentUser, 'table', 'R_JABATAN_KOMITE_SUB_KOMITE', 'column', 'NOTULEN'
go
