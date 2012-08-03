alter table T_INSIDEN add NO_INSIDEN varchar(50)
go
alter table T_INSIDEN add WAKTU varchar(20)
go
alter table T_INSIDEN add BAGIAN_FUNGSI varchar(100)
go
alter table T_INSIDEN add PEKERJAAN_DILAKUKAN varchar(1000)
go
alter table T_INSIDEN add TINDAKAN_DILAKUKAN varchar(1000)
go
alter table T_INSIDEN add DIKELUARKAN varchar(100)
go
alter table T_INSIDEN add RINGKASAN_INSIDEN varchar(1000)
go
alter table T_INSIDEN add TEMUAN_INVESTIGASI varchar(1000)
go
alter table T_INSIDEN add AKAR_MASALAH varchar(1000)
go
alter table T_INSIDEN add SISTEM_PERLU_DIPERKUAT varchar(1000)
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_INSIDEN_REKOMENDASI') and o.name = 'FK_T_INSIDEN_T_INSIDEN_REKOMENDASI')
alter table T_INSIDEN_REKOMENDASI
   drop constraint FK_T_INSIDEN_T_INSIDEN_REKOMENDASI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_INSIDEN_REKOMENDASI')
            and   name  = 'T_INSIDEN_REKOMENDASI_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_INSIDEN_REKOMENDASI.T_INSIDEN_REKOMENDASI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_INSIDEN_REKOMENDASI')
            and   type = 'U')
   drop table T_INSIDEN_REKOMENDASI
go

create table T_INSIDEN_REKOMENDASI (
   ID_INSIDEN_REKOMENDASI bigint               identity,
   ID_INSIDEN           bigint               not null,
   REKOMENDASI          varchar(1000)        not null,
   PENANGGUNG_JAWAB     varchar(100)         not null,
   TANGGAL_SELESAI      datetime             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_INSIDEN_REKOMENDASI primary key (ID_INSIDEN_REKOMENDASI)
)
go

create index T_INSIDEN_REKOMENDASI_FK on T_INSIDEN_REKOMENDASI (
ID_INSIDEN ASC
)
go

alter table T_INSIDEN_REKOMENDASI
   add constraint FK_T_INSIDEN_T_INSIDEN_REKOMENDASI foreign key (ID_INSIDEN)
      references T_INSIDEN (ID_INSIDEN)
go


alter table R_K3PL drop constraint DF__R_K3PL__REPO_PAT__65F62111
go

alter table R_K3PL drop column REPO_PATH
go

alter table R_K3PL add REPO_MAX_FILE_SIZE int not null default 10
go

insert into __MENU values ('01.08', 'Pengaturan Repository', 'app_repository', '1', 2, '01', '');
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.08',4);
