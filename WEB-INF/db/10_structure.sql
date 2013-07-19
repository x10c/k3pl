if exists (select 1
          from sysobjects
          where id = object_id('R_MATERIAL_ADR')
          and type = 'TR')
   drop trigger R_MATERIAL_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('R_MATERIAL_AIR')
          and type = 'TR')
   drop trigger R_MATERIAL_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('R_MATERIAL_AUR')
          and type = 'TR')
   drop trigger R_MATERIAL_AUR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CHEMICAL_HAZARD') and o.name = 'FK_R_MATERIAL_T_CHEMICAL_HAZARD')
alter table T_CHEMICAL_HAZARD
   drop constraint FK_R_MATERIAL_T_CHEMICAL_HAZARD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CIM') and o.name = 'FK_R_MATERIAL_T_CIM')
alter table T_CIM
   drop constraint FK_R_MATERIAL_T_CIM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_CHEMICAL_HAZARD') and o.name = 'FK_R_MATERIAL_T_PHA_CHEMICAL_HAZARD')
alter table T_PHA_CHEMICAL_HAZARD
   drop constraint FK_R_MATERIAL_T_PHA_CHEMICAL_HAZARD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_MATERIAL')
            and   name  = 'R_MATERIAL_UK'
            and   indid > 0
            and   indid < 255)
   drop index R_MATERIAL.R_MATERIAL_UK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_MATERIAL')
            and   type = 'U')
   drop table R_MATERIAL
go

/*==============================================================*/
/* Table: R_MATERIAL                                            */
/*==============================================================*/
create table R_MATERIAL (
   ID_MATERIAL          smallint             identity,
   NAMA_MATERIAL        varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_MATERIAL primary key (ID_MATERIAL)
)
go

/*==============================================================*/
/* Index: R_MATERIAL_UK                                         */
/*==============================================================*/
create unique index R_MATERIAL_UK on R_MATERIAL (
NAMA_MATERIAL ASC
)
go


create trigger R_MATERIAL_ADR
on R_MATERIAL
after delete
as
begin
	declare	@id_material	smallint
	
    select	@id_material	= (select ID_MATERIAL	from    deleted)

	delete from R_MATERIAL_INTERACTION where ID_MATERIAL_INTERACTION = @id_material
end
go


create trigger R_MATERIAL_AIR
on R_MATERIAL
after insert
as
begin
	declare	@id_material	smallint
    declare	@nama_material  varchar(128)
	declare	@id_user	    varchar(20)
	
	select	@id_material	= (select ID_MATERIAL	from    inserted)
	select	@nama_material	= (select NAMA_MATERIAL	from    inserted)
    select  @id_user        = (select ID_USER       from    inserted)

	insert into R_MATERIAL_INTERACTION (ID_MATERIAL_INTERACTION, NAMA_MATERIAL_INTERACTION, ID_USER)
	values	(@id_material, @nama_material, @id_user)
    
    insert into T_CIM (ID_MATERIAL, ID_MATERIAL_INTERACTION, ID_USER)
    select  @id_material
        ,   ID_MATERIAL_INTERACTION
        ,   @id_user
    from    R_MATERIAL_INTERACTION
    
    insert into T_CHEMICAL_HAZARD (ID_MATERIAL, ID_PROPERTIES, ID_USER)
    select  @id_material
        ,   ID_PROPERTIES
        ,   @id_user
    from    R_PROPERTIES
end
go


create trigger R_MATERIAL_AUR
on R_MATERIAL
after update
as
begin
	declare	@id_material	smallint
    declare	@nama_material  varchar(128)
	declare	@id_user	    varchar(20)
	
    select	@id_material	= (select ID_MATERIAL	from    inserted)
	select	@nama_material  = (select NAMA_MATERIAL	from    inserted)
    select  @id_user        = (select ID_USER       from    inserted)

	update R_MATERIAL_INTERACTION set NAMA_MATERIAL_INTERACTION = @nama_material, ID_USER = @id_user
	where  ID_MATERIAL_INTERACTION = @id_material
end
go

/*=*/

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CIM') and o.name = 'FK_R_MATERIAL_INTERACTION_T_CIM')
alter table T_CIM
   drop constraint FK_R_MATERIAL_INTERACTION_T_CIM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_MATERIAL_INTERACTION')
            and   type = 'U')
   drop table R_MATERIAL_INTERACTION
go

/*==============================================================*/
/* Table: R_MATERIAL_INTERACTION                                */
/*==============================================================*/
create table R_MATERIAL_INTERACTION (
   ID_MATERIAL_INTERACTION smallint             not null,
   NAMA_MATERIAL_INTERACTION varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_MATERIAL_INTERACTION primary key (ID_MATERIAL_INTERACTION)
)
go

/*=*/

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CIM') and o.name = 'FK_R_MATERIAL_INTERACTION_T_CIM')
alter table T_CIM
   drop constraint FK_R_MATERIAL_INTERACTION_T_CIM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CIM') and o.name = 'FK_R_MATERIAL_T_CIM')
alter table T_CIM
   drop constraint FK_R_MATERIAL_T_CIM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CIM')
            and   type = 'U')
   drop table T_CIM
go

/*==============================================================*/
/* Table: T_CIM                                                 */
/*==============================================================*/
create table T_CIM (
   ID_MATERIAL          smallint             not null,
   ID_MATERIAL_INTERACTION smallint             not null,
   INTERACTION          varchar(1024)        null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_CIM primary key (ID_MATERIAL, ID_MATERIAL_INTERACTION)
)
go

alter table T_CIM
   add constraint FK_R_MATERIAL_INTERACTION_T_CIM foreign key (ID_MATERIAL_INTERACTION)
      references R_MATERIAL_INTERACTION (ID_MATERIAL_INTERACTION)
go

alter table T_CIM
   add constraint FK_R_MATERIAL_T_CIM foreign key (ID_MATERIAL)
      references R_MATERIAL (ID_MATERIAL)
go

/*=*/

if exists (select 1
          from sysobjects
          where id = object_id('R_PROPERTIES_AIR')
          and type = 'TR')
   drop trigger R_PROPERTIES_AIR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CHEMICAL_HAZARD') and o.name = 'FK_R_PROPERTIES_T_CHEMICAL_HAZARD')
alter table T_CHEMICAL_HAZARD
   drop constraint FK_R_PROPERTIES_T_CHEMICAL_HAZARD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_PROPERTIES')
            and   name  = 'R_PROPERTIES_UK'
            and   indid > 0
            and   indid < 255)
   drop index R_PROPERTIES.R_PROPERTIES_UK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_PROPERTIES')
            and   type = 'U')
   drop table R_PROPERTIES
go

/*==============================================================*/
/* Table: R_PROPERTIES                                          */
/*==============================================================*/
create table R_PROPERTIES (
   ID_PROPERTIES        smallint             identity,
   NAMA_PROPERTIES      varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_PROPERTIES primary key (ID_PROPERTIES)
)
go

/*==============================================================*/
/* Index: R_PROPERTIES_UK                                       */
/*==============================================================*/
create unique index R_PROPERTIES_UK on R_PROPERTIES (
NAMA_PROPERTIES ASC
)
go


create trigger R_PROPERTIES_AIR
on R_PROPERTIES
after insert
as
begin
	declare	@id_properties	smallint
	declare	@id_user	    varchar(20)
	
	select	@id_properties	= (select ID_PROPERTIES	from    inserted)
    select  @id_user        = (select ID_USER       from    inserted)

    insert into T_CHEMICAL_HAZARD (ID_MATERIAL, ID_PROPERTIES, ID_USER)
    select  ID_MATERIAL
        ,   @id_properties
        ,   @id_user
    from    R_MATERIAL
end
go

/*=*/

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CHEMICAL_HAZARD') and o.name = 'FK_R_MATERIAL_T_CHEMICAL_HAZARD')
alter table T_CHEMICAL_HAZARD
   drop constraint FK_R_MATERIAL_T_CHEMICAL_HAZARD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CHEMICAL_HAZARD') and o.name = 'FK_R_PROPERTIES_T_CHEMICAL_HAZARD')
alter table T_CHEMICAL_HAZARD
   drop constraint FK_R_PROPERTIES_T_CHEMICAL_HAZARD
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CHEMICAL_HAZARD')
            and   type = 'U')
   drop table T_CHEMICAL_HAZARD
go

/*==============================================================*/
/* Table: T_CHEMICAL_HAZARD                                     */
/*==============================================================*/
create table T_CHEMICAL_HAZARD (
   ID_MATERIAL          smallint             not null,
   ID_PROPERTIES        smallint             not null,
   DESCRIPTION          varchar(1024)        null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_CHEMICAL_HAZARD primary key (ID_MATERIAL, ID_PROPERTIES)
)
go

alter table T_CHEMICAL_HAZARD
   add constraint FK_R_MATERIAL_T_CHEMICAL_HAZARD foreign key (ID_MATERIAL)
      references R_MATERIAL (ID_MATERIAL)
go

alter table T_CHEMICAL_HAZARD
   add constraint FK_R_PROPERTIES_T_CHEMICAL_HAZARD foreign key (ID_PROPERTIES)
      references R_PROPERTIES (ID_PROPERTIES)
go
