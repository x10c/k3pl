if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_PHR_ADR')
          and type = 'TR')
   drop trigger T_PHA_PHR_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_PHR_AIR')
          and type = 'TR')
   drop trigger T_PHA_PHR_AIR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_PHR') and o.name = 'FK_R_RISK_CATEGORY_T_PHA_PHR')
alter table T_PHA_PHR
   drop constraint FK_R_RISK_CATEGORY_T_PHA_PHR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_PHR') and o.name = 'FK_R_RISK_DEFINITION_T_PHA_PHR')
alter table T_PHA_PHR
   drop constraint FK_R_RISK_DEFINITION_T_PHA_PHR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_PHR') and o.name = 'FK_R_RISK_FREQUENCY_T_PHA_PHR')
alter table T_PHA_PHR
   drop constraint FK_R_RISK_FREQUENCY_T_PHA_PHR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_PHR') and o.name = 'FK_T_PHA_T_PHA_PHR')
alter table T_PHA_PHR
   drop constraint FK_T_PHA_T_PHA_PHR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_PHR_RECOMMENDATION') and o.name = 'FK_T_PHA_PHR_T_PHA_PHR_RECOMMENDATION')
alter table T_PHA_PHR_RECOMMENDATION
   drop constraint FK_T_PHA_PHR_T_PHA_PHR_RECOMMENDATION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_PHR')
            and   name  = 'T_PHA_PHR_FK_R_RISK_DEFINITION'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_PHR.T_PHA_PHR_FK_R_RISK_DEFINITION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_PHR')
            and   name  = 'T_PHA_PHR_FK_R_RISK_CATEGORY'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_PHR.T_PHA_PHR_FK_R_RISK_CATEGORY
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_PHR')
            and   name  = 'T_PHA_PHR_FK_R_RISK_FREQUENCY'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_PHR.T_PHA_PHR_FK_R_RISK_FREQUENCY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_PHR')
            and   type = 'U')
   drop table T_PHA_PHR
go

/*==============================================================*/
/* Table: T_PHA_PHR                                             */
/*==============================================================*/
create table T_PHA_PHR (
   ID_PHA_PHR           bigint               not null,
   ID_PHA               bigint               not null,
   PROCESS_STEP         varchar(256)         not null,
   WHAT_IF              varchar(512)         not null,
   CONSEQUENCE          varchar(512)         not null,
   PROTECTION_NOW       varchar(256)         null default '',
   FREQUENCY_CATEGORY   varchar(5)           not null,
   CONSEQUENCE_CATEGORY varchar(5)           not null,
   RISK_SCORE           varchar(5)           not null,
   RESP                 varchar(512)         null default '',
   STATUS_OF_QUESTION   varchar(512)         null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_PHR primary key (ID_PHA_PHR, ID_PHA)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'F1,F2,F3,...,Fn',
   'user', @CurrentUser, 'table', 'T_PHA_PHR', 'column', 'FREQUENCY_CATEGORY'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'C1,C2,C3,...,Cn',
   'user', @CurrentUser, 'table', 'T_PHA_PHR', 'column', 'CONSEQUENCE_CATEGORY'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'I, II, III, IV,...n',
   'user', @CurrentUser, 'table', 'T_PHA_PHR', 'column', 'RISK_SCORE'
go

/*==============================================================*/
/* Index: T_PHA_PHR_FK_R_RISK_FREQUENCY                         */
/*==============================================================*/
create index T_PHA_PHR_FK_R_RISK_FREQUENCY on T_PHA_PHR (
FREQUENCY_CATEGORY ASC
)
go

/*==============================================================*/
/* Index: T_PHA_PHR_FK_R_RISK_CATEGORY                          */
/*==============================================================*/
create index T_PHA_PHR_FK_R_RISK_CATEGORY on T_PHA_PHR (
CONSEQUENCE_CATEGORY ASC
)
go

/*==============================================================*/
/* Index: T_PHA_PHR_FK_R_RISK_DEFINITION                        */
/*==============================================================*/
create index T_PHA_PHR_FK_R_RISK_DEFINITION on T_PHA_PHR (
RISK_SCORE ASC
)
go

alter table T_PHA_PHR
   add constraint FK_R_RISK_CATEGORY_T_PHA_PHR foreign key (CONSEQUENCE_CATEGORY)
      references R_RISK_CATEGORY (CONSEQUENCE_CATEGORY)
go

alter table T_PHA_PHR
   add constraint FK_R_RISK_DEFINITION_T_PHA_PHR foreign key (RISK_SCORE)
      references R_RISK_DEFINITION (RISK_SCORE)
go

alter table T_PHA_PHR
   add constraint FK_R_RISK_FREQUENCY_T_PHA_PHR foreign key (FREQUENCY_CATEGORY)
      references R_RISK_FREQUENCY (FREQUENCY_CATEGORY)
go

alter table T_PHA_PHR
   add constraint FK_T_PHA_T_PHA_PHR foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go


create trigger T_PHA_PHR_ADR
on T_PHA_PHR
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_PHR
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 9
    end
end
go


create trigger T_PHA_PHR_AIR
on T_PHA_PHR
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 9
end
go
