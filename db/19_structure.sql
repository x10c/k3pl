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
   NAMA_KEL_JABATAN_CSC varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KEL_JABATAN_CSC primary key (ID_KEL_JABATAN_CSC)
)
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
   NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KEL_JABATAN_KOMITE_SUB_KOMITE primary key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC)
)
go

alter table R_KEL_JABATAN_KOMITE_SUB_KOMITE
   add constraint FK_R_KEL_JABATAN_CSC_R_KEL_JABATAN_KOMITE_SUB_KOMITE foreign key (ID_KEL_JABATAN_CSC)
      references R_KEL_JABATAN_CSC (ID_KEL_JABATAN_CSC)
go

insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC, NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_USER)
select	ID_KEL_JABATAN_KOMITE_SUB_KOMITE
	,	5
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
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint             null,
   ID_KEL_JABATAN_CSC   smallint             not null,
   NAMA_JABATAN_KOMITE  varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_JABATAN_KOMITE_SUB_KOMITE primary key (ID_JABATAN_KOMITE)
)
go

/*==============================================================*/
/* Index: R_JABATAN_KOMITE_SUB_KOMITE_FK                        */
/*==============================================================*/
create index R_JABATAN_KOMITE_SUB_KOMITE_FK on R_JABATAN_KOMITE_SUB_KOMITE (
ID_KEL_JABATAN_KOMITE_SUB_KOMITE ASC,
ID_KEL_JABATAN_CSC ASC
)
go

alter table R_JABATAN_KOMITE_SUB_KOMITE
   add constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE foreign key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC)
      references R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC)
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

alter table T_RAPAT
   add constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT foreign key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC)
      references R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_KEL_JABATAN_CSC)
go

drop table R_KEL_JABATAN_KOMITE_SUB_KOMITE_TEMP
go

drop table R_JABATAN_KOMITE_SUB_KOMITE_TEMP
go
