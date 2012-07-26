alter table R_DIVPROSBU add STATUS_DIVPROSBU tinyint not null default 3
go

update	R_DIVPROSBU
set		STATUS_DIVPROSBU	= 1
where	ID_DIVPROSBU		= 2
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1=Divisi; 2=Proyek; 3=SBU',
   'user', @CurrentUser, 'table', 'R_DIVPROSBU', 'column', 'STATUS_DIVPROSBU'
go

alter table R_PROJECT add ID_DIVPROSBU int not null default 1
go

alter table R_PROJECT add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PROJECT') and o.name = 'FK_R_DIVPROSBU_R_PROJECT')
alter table R_PROJECT
   drop constraint FK_R_DIVPROSBU_R_PROJECT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_PROJECT')
            and   name  = 'R_PROJECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_PROJECT.R_PROJECT_FK
go

/*==============================================================*/
/* Index: R_PROJECT_FK                                          */
/*==============================================================*/
create index R_PROJECT_FK on R_PROJECT (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table R_PROJECT
   add constraint FK_R_DIVPROSBU_R_PROJECT foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_UNJUK_KERJA add ID_DIVPROSBU int not null default 1
go

alter table T_UNJUK_KERJA add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_UNJUK_KERJA') and o.name = 'FK_R_DIVPROSBU_T_UNJUK_KERJA')
alter table T_UNJUK_KERJA
   drop constraint FK_R_DIVPROSBU_T_UNJUK_KERJA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_UNJUK_KERJA')
            and   name  = 'T_UNJUK_KERJA_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index T_UNJUK_KERJA.T_UNJUK_KERJA_FK_R_DIVPROSBU
go

/*==============================================================*/
/* Index: T_UNJUK_KERJA_FK_R_DIVPROSBU                          */
/*==============================================================*/
create index T_UNJUK_KERJA_FK_R_DIVPROSBU on T_UNJUK_KERJA (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_UNJUK_KERJA
   add constraint FK_R_DIVPROSBU_T_UNJUK_KERJA foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_KEGIATAN add ID_DIVPROSBU int not null default 1
go

alter table T_KEGIATAN add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_KEGIATAN') and o.name = 'FK_R_DIVPROSBU_T_KEGIATAN')
alter table T_KEGIATAN
   drop constraint FK_R_DIVPROSBU_T_KEGIATAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_KEGIATAN')
            and   name  = 'T_KEGIATAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_KEGIATAN.T_KEGIATAN_FK
go

/*==============================================================*/
/* Index: T_KEGIATAN_FK                                         */
/*==============================================================*/
create index T_KEGIATAN_FK on T_KEGIATAN (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_KEGIATAN
   add constraint FK_R_DIVPROSBU_T_KEGIATAN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_INSIDEN add ID_DIVPROSBU int not null default 1
go

alter table T_INSIDEN add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_INSIDEN') and o.name = 'FK_R_DIVPROSBU_T_INSIDEN')
alter table T_INSIDEN
   drop constraint FK_R_DIVPROSBU_T_INSIDEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_INSIDEN')
            and   name  = 'T_INSIDEN_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index T_INSIDEN.T_INSIDEN_FK_R_DIVPROSBU
go

/*==============================================================*/
/* Index: T_INSIDEN_FK_R_DIVPROSBU                              */
/*==============================================================*/
create index T_INSIDEN_FK_R_DIVPROSBU on T_INSIDEN (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_INSIDEN
   add constraint FK_R_DIVPROSBU_T_INSIDEN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_JSA add ID_DIVPROSBU int not null default 1
go

alter table T_JSA add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_JSA') and o.name = 'FK_R_DIVPROSBU_T_JSA')
alter table T_JSA
   drop constraint FK_R_DIVPROSBU_T_JSA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_JSA')
            and   name  = 'T_JSA_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_JSA.T_JSA_FK
go

/*==============================================================*/
/* Index: T_JSA_FK                                              */
/*==============================================================*/
create index T_JSA_FK on T_JSA (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_JSA
   add constraint FK_R_DIVPROSBU_T_JSA foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_PTW add ID_DIVPROSBU int not null default 1
go

alter table T_PTW add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW') and o.name = 'FK_R_DIVPROSBU_T_PTW')
alter table T_PTW
   drop constraint FK_R_DIVPROSBU_T_PTW
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PTW')
            and   name  = 'T_PTW_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index T_PTW.T_PTW_FK_R_DIVPROSBU
go

/*==============================================================*/
/* Index: T_PTW_FK_R_DIVPROSBU                                  */
/*==============================================================*/
create index T_PTW_FK_R_DIVPROSBU on T_PTW (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_PTW
   add constraint FK_R_DIVPROSBU_T_PTW foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_PELATIHAN add ID_DIVPROSBU int not null default 1
go

alter table T_PELATIHAN add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PELATIHAN') and o.name = 'FK_R_DIVPROSBU_T_PELATIHAN')
alter table T_PELATIHAN
   drop constraint FK_R_DIVPROSBU_T_PELATIHAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PELATIHAN')
            and   name  = 'T_PELATIHAN_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index T_PELATIHAN.T_PELATIHAN_FK_R_DIVPROSBU
go

/*==============================================================*/
/* Index: T_PELATIHAN_FK_R_DIVPROSBU                            */
/*==============================================================*/
create index T_PELATIHAN_FK_R_DIVPROSBU on T_PELATIHAN (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_PELATIHAN
   add constraint FK_R_DIVPROSBU_T_PELATIHAN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_LINGKUNGAN_BULANAN add ID_DIVPROSBU int not null default 1
go

alter table T_LINGKUNGAN_BULANAN add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN_BULANAN') and o.name = 'FK_R_DIVPROSBU_T_LINGKUNGAN_BULANAN')
alter table T_LINGKUNGAN_BULANAN
   drop constraint FK_R_DIVPROSBU_T_LINGKUNGAN_BULANAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_LINGKUNGAN_BULANAN')
            and   name  = 'T_LINGKUNGAN_BULANAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_LINGKUNGAN_BULANAN.T_LINGKUNGAN_BULANAN_FK
go

/*==============================================================*/
/* Index: T_LINGKUNGAN_BULANAN_FK                               */
/*==============================================================*/
create index T_LINGKUNGAN_BULANAN_FK on T_LINGKUNGAN_BULANAN (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_LINGKUNGAN_BULANAN
   add constraint FK_R_DIVPROSBU_T_LINGKUNGAN_BULANAN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_CSM_PROYEK add ID_DIVPROSBU int not null default 1
go

alter table T_CSM_PROYEK add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK') and o.name = 'FK_R_DIVPROSBU_T_CSM_PROYEK')
alter table T_CSM_PROYEK
   drop constraint FK_R_DIVPROSBU_T_CSM_PROYEK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_CSM_PROYEK')
            and   name  = 'T_CSM_PROYEK_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index T_CSM_PROYEK.T_CSM_PROYEK_FK_R_DIVPROSBU
go

/*==============================================================*/
/* Index: T_CSM_PROYEK_FK_R_DIVPROSBU                           */
/*==============================================================*/
create index T_CSM_PROYEK_FK_R_DIVPROSBU on T_CSM_PROYEK (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_CSM_PROYEK
   add constraint FK_R_DIVPROSBU_T_CSM_PROYEK foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_PSSR add ID_DIVPROSBU int not null default 1
go

alter table T_PSSR add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR') and o.name = 'FK_R_DIVPROSBU_T_PSSR')
alter table T_PSSR
   drop constraint FK_R_DIVPROSBU_T_PSSR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PSSR')
            and   name  = 'T_PSSR_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index T_PSSR.T_PSSR_FK_R_DIVPROSBU
go

/*==============================================================*/
/* Index: T_PSSR_FK_R_DIVPROSBU                                 */
/*==============================================================*/
create index T_PSSR_FK_R_DIVPROSBU on T_PSSR (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_PSSR
   add constraint FK_R_DIVPROSBU_T_PSSR foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_PHA add ID_DIVPROSBU int not null default 1
go

alter table T_PHA add ID_DIREKTORAT int not null default 3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA') and o.name = 'FK_R_DIVPROSBU_T_PHA')
alter table T_PHA
   drop constraint FK_R_DIVPROSBU_T_PHA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA')
            and   name  = 'T_PHA_FK_R_DIVPROSBU'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA.T_PHA_FK_R_DIVPROSBU
go

/*==============================================================*/
/* Index: T_PHA_FK_R_DIVPROSBU                                  */
/*==============================================================*/
create index T_PHA_FK_R_DIVPROSBU on T_PHA (
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_PHA
   add constraint FK_R_DIVPROSBU_T_PHA foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

alter table T_REPO add BERKAS varbinary(Max)
go
