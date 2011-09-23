/*
 * Add columns koefisien_utama and koefisien_tambah to table T_CSM_PROYEK
 */
alter table T_CSM_PROYEK add
	KOEFISIEN_UTAMA		float not null default 0
,	KOEFISIEN_TAMBAH	float not null default 0
go


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_RANKING_MATRIX') and o.name = 'FK_R_RISK_FREQUENCY_R_RISK_RANKING_MATRIX')
alter table R_RISK_RANKING_MATRIX
   drop constraint FK_R_RISK_FREQUENCY_R_RISK_RANKING_MATRIX
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_FREQUENCY')
            and   type = 'U')
   drop table R_RISK_FREQUENCY
go

/*==============================================================*/
/* Table: R_RISK_FREQUENCY                                      */
/*==============================================================*/
create table R_RISK_FREQUENCY (
   FREQUENCY_CATEGORY   varchar(5)           not null,
   DESCRIPTION          varchar(256)         not null,
   FREQUENCY            varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_FREQUENCY primary key (FREQUENCY_CATEGORY)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'F1,F2,F3,...,Fn',
   'user', @CurrentUser, 'table', 'R_RISK_FREQUENCY', 'column', 'FREQUENCY_CATEGORY'
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_CONSEQUENCE_CATEGORY') and o.name = 'FK_R_RISK_CATEGORY_R_RISK_CONSEQUENCE_CATEGORY')
alter table R_RISK_CONSEQUENCE_CATEGORY
   drop constraint FK_R_RISK_CATEGORY_R_RISK_CONSEQUENCE_CATEGORY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_RANKING_MATRIX') and o.name = 'FK_R_RISK_CATEGORY_R_RISK_RANKING_MATRIX')
alter table R_RISK_RANKING_MATRIX
   drop constraint FK_R_RISK_CATEGORY_R_RISK_RANKING_MATRIX
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_CATEGORY')
            and   type = 'U')
   drop table R_RISK_CATEGORY
go

/*==============================================================*/
/* Table: R_RISK_CATEGORY                                       */
/*==============================================================*/
create table R_RISK_CATEGORY (
   CONSEQUENCE_CATEGORY varchar(5)           not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_CATEGORY primary key (CONSEQUENCE_CATEGORY)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'C1,C2,C3,...,Cn',
   'user', @CurrentUser, 'table', 'R_RISK_CATEGORY', 'column', 'CONSEQUENCE_CATEGORY'
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_RANKING_MATRIX') and o.name = 'FK_R_RISK_CATEGORY_R_RISK_RANKING_MATRIX')
alter table R_RISK_RANKING_MATRIX
   drop constraint FK_R_RISK_CATEGORY_R_RISK_RANKING_MATRIX
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_RANKING_MATRIX') and o.name = 'FK_R_RISK_DEFINITION_R_RISK_RANKING_MATRIX')
alter table R_RISK_RANKING_MATRIX
   drop constraint FK_R_RISK_DEFINITION_R_RISK_RANKING_MATRIX
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_RANKING_MATRIX') and o.name = 'FK_R_RISK_FREQUENCY_R_RISK_RANKING_MATRIX')
alter table R_RISK_RANKING_MATRIX
   drop constraint FK_R_RISK_FREQUENCY_R_RISK_RANKING_MATRIX
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_RISK_RANKING_MATRIX')
            and   name  = 'R_RISK_RANKING_MATRIX_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_RISK_RANKING_MATRIX.R_RISK_RANKING_MATRIX_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_RANKING_MATRIX')
            and   type = 'U')
   drop table R_RISK_RANKING_MATRIX
go

/*==============================================================*/
/* Table: R_RISK_RANKING_MATRIX                                 */
/*==============================================================*/
create table R_RISK_RANKING_MATRIX (
   FREQUENCY_CATEGORY   varchar(5)           not null,
   CONSEQUENCE_CATEGORY varchar(5)           not null,
   RISK_SCORE           varchar(5)           null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_RANKING_MATRIX primary key (FREQUENCY_CATEGORY, CONSEQUENCE_CATEGORY)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'F1,F2,F3,...,Fn',
   'user', @CurrentUser, 'table', 'R_RISK_RANKING_MATRIX', 'column', 'FREQUENCY_CATEGORY'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'C1,C2,C3,...,Cn',
   'user', @CurrentUser, 'table', 'R_RISK_RANKING_MATRIX', 'column', 'CONSEQUENCE_CATEGORY'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'I, II, III, IV',
   'user', @CurrentUser, 'table', 'R_RISK_RANKING_MATRIX', 'column', 'RISK_SCORE'
go

/*==============================================================*/
/* Index: R_RISK_RANKING_MATRIX_FK                              */
/*==============================================================*/
create index R_RISK_RANKING_MATRIX_FK on R_RISK_RANKING_MATRIX (
RISK_SCORE ASC
)
go

alter table R_RISK_RANKING_MATRIX
   add constraint FK_R_RISK_CATEGORY_R_RISK_RANKING_MATRIX foreign key (CONSEQUENCE_CATEGORY)
      references R_RISK_CATEGORY (CONSEQUENCE_CATEGORY)
go

alter table R_RISK_RANKING_MATRIX
   add constraint FK_R_RISK_DEFINITION_R_RISK_RANKING_MATRIX foreign key (RISK_SCORE)
      references R_RISK_DEFINITION (RISK_SCORE)
go

alter table R_RISK_RANKING_MATRIX
   add constraint FK_R_RISK_FREQUENCY_R_RISK_RANKING_MATRIX foreign key (FREQUENCY_CATEGORY)
      references R_RISK_FREQUENCY (FREQUENCY_CATEGORY)
go

if exists (select 1
          from sysobjects
          where id = object_id('R_RISK_FREQUENCY_AIR')
          and type = 'TR')
   drop trigger R_RISK_FREQUENCY_AIR
go

create trigger R_RISK_FREQUENCY_AIR
on R_RISK_FREQUENCY
after insert
as
begin
	declare	@frequency_category varchar(5)
	declare	@id_user	        varchar(20)
	
	select	@frequency_category	= (select FREQUENCY_CATEGORY	from    inserted)
    select  @id_user            = (select ID_USER               from    inserted)

    insert into R_RISK_RANKING_MATRIX (FREQUENCY_CATEGORY, CONSEQUENCE_CATEGORY, ID_USER)
    select  @frequency_category
        ,   CONSEQUENCE_CATEGORY
        ,   @id_user
    from    R_RISK_CATEGORY
end
go

if exists (select 1
          from sysobjects
          where id = object_id('R_RISK_CATEGORY_AIR')
          and type = 'TR')
   drop trigger R_RISK_CATEGORY_AIR
go

create trigger R_RISK_CATEGORY_AIR
on R_RISK_CATEGORY
after insert
as
begin
	declare	@consequence_category   varchar(5)
	declare	@id_user	            varchar(20)
	
	select	@consequence_category	= (select CONSEQUENCE_CATEGORY	from    inserted)
    select  @id_user                = (select ID_USER               from    inserted)

    insert into R_RISK_RANKING_MATRIX (FREQUENCY_CATEGORY, CONSEQUENCE_CATEGORY, ID_USER)
    select  FREQUENCY_CATEGORY
        ,   @consequence_category
        ,   @id_user
    from    R_RISK_FREQUENCY
end
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_CONSEQUENCE_CATEGORY') and o.name = 'FK_R_CONSEQUENCE_R_RISK_CONSEQUENCE_CATEGORY')
alter table R_RISK_CONSEQUENCE_CATEGORY
   drop constraint FK_R_CONSEQUENCE_R_RISK_CONSEQUENCE_CATEGORY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_CONSEQUENCE')
            and   type = 'U')
   drop table R_RISK_CONSEQUENCE
go

/*==============================================================*/
/* Table: R_RISK_CONSEQUENCE                                    */
/*==============================================================*/
create table R_RISK_CONSEQUENCE (
   CONSEQUENCE          varchar(128)         not null,
   NOTE                 varchar(1024)        null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_CONSEQUENCE primary key (CONSEQUENCE)
)
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_CONSEQUENCE_CATEGORY') and o.name = 'FK_R_CONSEQUENCE_R_RISK_CONSEQUENCE_CATEGORY')
alter table R_RISK_CONSEQUENCE_CATEGORY
   drop constraint FK_R_CONSEQUENCE_R_RISK_CONSEQUENCE_CATEGORY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_RISK_CONSEQUENCE_CATEGORY') and o.name = 'FK_R_RISK_CATEGORY_R_RISK_CONSEQUENCE_CATEGORY')
alter table R_RISK_CONSEQUENCE_CATEGORY
   drop constraint FK_R_RISK_CATEGORY_R_RISK_CONSEQUENCE_CATEGORY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_CONSEQUENCE_CATEGORY')
            and   type = 'U')
   drop table R_RISK_CONSEQUENCE_CATEGORY
go

/*==============================================================*/
/* Table: R_RISK_CONSEQUENCE_CATEGORY                           */
/*==============================================================*/
create table R_RISK_CONSEQUENCE_CATEGORY (
   CONSEQUENCE          varchar(128)         not null,
   CONSEQUENCE_CATEGORY varchar(5)           not null,
   DESCRIPTION          varchar(1024)        null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_CONSEQUENCE_CATEGORY primary key (CONSEQUENCE, CONSEQUENCE_CATEGORY)
)
go

alter table R_RISK_CONSEQUENCE_CATEGORY
   add constraint FK_R_CONSEQUENCE_R_RISK_CONSEQUENCE_CATEGORY foreign key (CONSEQUENCE)
      references R_RISK_CONSEQUENCE (CONSEQUENCE)
go

alter table R_RISK_CONSEQUENCE_CATEGORY
   add constraint FK_R_RISK_CATEGORY_R_RISK_CONSEQUENCE_CATEGORY foreign key (CONSEQUENCE_CATEGORY)
      references R_RISK_CATEGORY (CONSEQUENCE_CATEGORY)
go
