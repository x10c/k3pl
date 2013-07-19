/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     6/24/2011 10:07:46 AM                        */
/*==============================================================*/


if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_AIR')
          and type = 'TR')
   drop trigger T_PHA_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_CA_ADR')
          and type = 'TR')
   drop trigger T_PHA_CA_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_CA_AIR')
          and type = 'TR')
   drop trigger T_PHA_CA_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_CHEMICAL_HAZARD_ADR')
          and type = 'TR')
   drop trigger T_PHA_CHEMICAL_HAZARD_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_CHEMICAL_HAZARD_AIR')
          and type = 'TR')
   drop trigger T_PHA_CHEMICAL_HAZARD_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_FACILITY_SITTING_ADR')
          and type = 'TR')
   drop trigger T_PHA_FACILITY_SITTING_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_FACILITY_SITTING_AIR')
          and type = 'TR')
   drop trigger T_PHA_FACILITY_SITTING_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_FIELD_TOUR_ADR')
          and type = 'TR')
   drop trigger T_PHA_FIELD_TOUR_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_FIELD_TOUR_AIR')
          and type = 'TR')
   drop trigger T_PHA_FIELD_TOUR_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_HAZARD_PRESSURE_ADR')
          and type = 'TR')
   drop trigger T_PHA_HAZARD_PRESSURE_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_HAZARD_PRESSURE_AIR')
          and type = 'TR')
   drop trigger T_PHA_HAZARD_PRESSURE_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_HAZARD_PROCESS_ADR')
          and type = 'TR')
   drop trigger T_PHA_HAZARD_PROCESS_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_HAZARD_PROCESS_AIR')
          and type = 'TR')
   drop trigger T_PHA_HAZARD_PROCESS_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_HUMAN_FACTOR_ADR')
          and type = 'TR')
   drop trigger T_PHA_HUMAN_FACTOR_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_HUMAN_FACTOR_AIR')
          and type = 'TR')
   drop trigger T_PHA_HUMAN_FACTOR_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_KEANGGOTAAN_ADR')
          and type = 'TR')
   drop trigger T_PHA_KEANGGOTAAN_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_KEANGGOTAAN_AIR')
          and type = 'TR')
   drop trigger T_PHA_KEANGGOTAAN_AIR
go

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
          from sysobjects
          where id = object_id('T_PHA_REFERENCE_ADR')
          and type = 'TR')
   drop trigger T_PHA_REFERENCE_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_REFERENCE_AIR')
          and type = 'TR')
   drop trigger T_PHA_REFERENCE_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_RENCANA_KERJA_ADR')
          and type = 'TR')
   drop trigger T_PHA_RENCANA_KERJA_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_RENCANA_KERJA_AIR')
          and type = 'TR')
   drop trigger T_PHA_RENCANA_KERJA_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_STORM_ADR')
          and type = 'TR')
   drop trigger T_PHA_STORM_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_STORM_AIR')
          and type = 'TR')
   drop trigger T_PHA_STORM_AIR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_WSFCA_ADR')
          and type = 'TR')
   drop trigger T_PHA_WSFCA_ADR
go

if exists (select 1
          from sysobjects
          where id = object_id('T_PHA_WSFCA_AIR')
          and type = 'TR')
   drop trigger T_PHA_WSFCA_AIR
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_REPO_GET_PATH')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_REPO_GET_PATH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_CSM_PENILAIAN') and o.name = 'FK_R_CSM_FAKTOR_PENILAIAN_R_CSM_PENILAIAN')
alter table R_CSM_PENILAIAN
   drop constraint FK_R_CSM_FAKTOR_PENILAIAN_R_CSM_PENILAIAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_ITEM_CA') and o.name = 'FK_R_KATEGORI_ITEM_CA_R_ITEM_CA')
alter table R_ITEM_CA
   drop constraint FK_R_KATEGORI_ITEM_CA_R_ITEM_CA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_ITEM_DETAIL_PSSR') and o.name = 'FK_R_ITEM_PSSR_R_ITEM_DETAIL_PSSR')
alter table R_ITEM_DETAIL_PSSR
   drop constraint FK_R_ITEM_PSSR_R_ITEM_DETAIL_PSSR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_ITEM_PSSR') and o.name = 'FK_R_KATEGORI_ITEM_PSSR_R_ITEM_PSSR')
alter table R_ITEM_PSSR
   drop constraint FK_R_KATEGORI_ITEM_PSSR_R_ITEM_PSSR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR') and o.name = 'FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR')
alter table R_KONTRAKTOR
   drop constraint FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR') and o.name = 'FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR2')
alter table R_KONTRAKTOR
   drop constraint FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR') and o.name = 'FK_R_KONTRAKTOR_TIPE_R_KONTRAKTOR')
alter table R_KONTRAKTOR
   drop constraint FK_R_KONTRAKTOR_TIPE_R_KONTRAKTOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_JUL') and o.name = 'FK_R_KONTRAKTOR_R_KONTRAKTOR_JUL')
alter table R_KONTRAKTOR_JUL
   drop constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_JUL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_KLM') and o.name = 'FK_R_KONTRAKTOR_R_KONTRAKTOR_KLM')
alter table R_KONTRAKTOR_KLM
   drop constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_KLM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_KLM') and o.name = 'FK_T_REPO_R_KONTRAKTOR_KLM')
alter table R_KONTRAKTOR_KLM
   drop constraint FK_T_REPO_R_KONTRAKTOR_KLM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_PIM') and o.name = 'FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR_PIM')
alter table R_KONTRAKTOR_PIM
   drop constraint FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR_PIM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_PIM') and o.name = 'FK_R_KONTRAKTOR_R_KONTRAKTOR_PIM')
alter table R_KONTRAKTOR_PIM
   drop constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PIM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_PSD') and o.name = 'FK_R_KONTRAKTOR_R_KONTRAKTOR_PSD')
alter table R_KONTRAKTOR_PSD
   drop constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PSD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_PTD') and o.name = 'FK_R_KONTRAKTOR_R_KONTRAKTOR_PTD')
alter table R_KONTRAKTOR_PTD
   drop constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PTD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_KONTRAKTOR_PUL') and o.name = 'FK_R_KONTRAKTOR_R_KONTRAKTOR_PUL')
alter table R_KONTRAKTOR_PUL
   drop constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PUL
go

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
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK') and o.name = 'FK_R_KONTRAKTOR_T_CSM_PROYEK')
alter table T_CSM_PROYEK
   drop constraint FK_R_KONTRAKTOR_T_CSM_PROYEK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK') and o.name = 'FK_R_PROJECT_T_CSM_PROYEK')
alter table T_CSM_PROYEK
   drop constraint FK_R_PROJECT_T_CSM_PROYEK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONTRAKTOR') and o.name = 'FK_R_KONTRAKTOR_T_CSM_PROYEK_KONTRAKTOR')
alter table T_CSM_PROYEK_KONTRAKTOR
   drop constraint FK_R_KONTRAKTOR_T_CSM_PROYEK_KONTRAKTOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONTRAKTOR') and o.name = 'FK_T_CSM_PROYEK_T_CSM_PROYEK_KONTRAKTOR')
alter table T_CSM_PROYEK_KONTRAKTOR
   drop constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONTRAKTOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONT_EVAL') and o.name = 'FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_EVAL')
alter table T_CSM_PROYEK_KONT_EVAL
   drop constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_EVAL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONT_EVAL_NILAI') and o.name = 'FK_R_CSM_PERF_EVAL_T_CSM_PROYEK_KONT_EVAL_NILAI')
alter table T_CSM_PROYEK_KONT_EVAL_NILAI
   drop constraint FK_R_CSM_PERF_EVAL_T_CSM_PROYEK_KONT_EVAL_NILAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONT_EVAL_NILAI') and o.name = 'FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_EVAL_NILAI')
alter table T_CSM_PROYEK_KONT_EVAL_NILAI
   drop constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_EVAL_NILAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONT_NILAI') and o.name = 'FK_R_CSM_PENILAIAN_T_CSM_PROYEK_KONT_NILAI')
alter table T_CSM_PROYEK_KONT_NILAI
   drop constraint FK_R_CSM_PENILAIAN_T_CSM_PROYEK_KONT_NILAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONT_NILAI') and o.name = 'FK_R_KONTRAKTOR_T_CSM_PROYEK_KONT_NILAI')
alter table T_CSM_PROYEK_KONT_NILAI
   drop constraint FK_R_KONTRAKTOR_T_CSM_PROYEK_KONT_NILAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_CSM_PROYEK_KONT_NILAI') and o.name = 'FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_NILAI')
alter table T_CSM_PROYEK_KONT_NILAI
   drop constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_NILAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN') and o.name = 'FK_R_SEKSI_T_LINGKUNGAN')
alter table T_LINGKUNGAN
   drop constraint FK_R_SEKSI_T_LINGKUNGAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN_BULANAN_DETAIL') and o.name = 'FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL')
alter table T_LINGKUNGAN_BULANAN_DETAIL
   drop constraint FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN_DETAIL') and o.name = 'FK_R_KOMPONEN_LINGKUNGAN_T_LINGKUNGAN_DETAIL')
alter table T_LINGKUNGAN_DETAIL
   drop constraint FK_R_KOMPONEN_LINGKUNGAN_T_LINGKUNGAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN_DETAIL') and o.name = 'FK_T_LINGKUNGAN_T_LINGKUNGAN_DETAIL')
alter table T_LINGKUNGAN_DETAIL
   drop constraint FK_T_LINGKUNGAN_T_LINGKUNGAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA') and o.name = 'FK_R_PROJECT_T_PHA')
alter table T_PHA
   drop constraint FK_R_PROJECT_T_PHA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_CA') and o.name = 'FK_R_ITEM_CA_T_PHA_CA')
alter table T_PHA_CA
   drop constraint FK_R_ITEM_CA_T_PHA_CA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_CA') and o.name = 'FK_T_PHA_T_PHA_CA')
alter table T_PHA_CA
   drop constraint FK_T_PHA_T_PHA_CA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_CHEMICAL_HAZARD') and o.name = 'FK_R_MATERIAL_T_PHA_CHEMICAL_HAZARD')
alter table T_PHA_CHEMICAL_HAZARD
   drop constraint FK_R_MATERIAL_T_PHA_CHEMICAL_HAZARD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_CHEMICAL_HAZARD') and o.name = 'FK_T_PHA_T_PHA_CHEMICAL_HAZARD')
alter table T_PHA_CHEMICAL_HAZARD
   drop constraint FK_T_PHA_T_PHA_CHEMICAL_HAZARD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_FACILITY_SITTING') and o.name = 'FK_T_PHA_T_PHA_FACILITY_SITTING')
alter table T_PHA_FACILITY_SITTING
   drop constraint FK_T_PHA_T_PHA_FACILITY_SITTING
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_FIELD_TOUR') and o.name = 'FK_T_PHA_T_PHA_FIELD_TOUR')
alter table T_PHA_FIELD_TOUR
   drop constraint FK_T_PHA_T_PHA_FIELD_TOUR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_HAZARD_PRESSURE') and o.name = 'FK_R_HAZARD_PRESSURE_T_PHA_HAZARD_PRESSURE')
alter table T_PHA_HAZARD_PRESSURE
   drop constraint FK_R_HAZARD_PRESSURE_T_PHA_HAZARD_PRESSURE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_HAZARD_PRESSURE') and o.name = 'FK_T_PHA_T_PHA_HAZARD_PRESSURE')
alter table T_PHA_HAZARD_PRESSURE
   drop constraint FK_T_PHA_T_PHA_HAZARD_PRESSURE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_HAZARD_PROCESS') and o.name = 'FK_R_HAZARD_PROCESS_T_PHA_HAZARD_PROCESS')
alter table T_PHA_HAZARD_PROCESS
   drop constraint FK_R_HAZARD_PROCESS_T_PHA_HAZARD_PROCESS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_HAZARD_PROCESS') and o.name = 'FK_T_PHA_T_PHA_HAZARD_PROCESS')
alter table T_PHA_HAZARD_PROCESS
   drop constraint FK_T_PHA_T_PHA_HAZARD_PROCESS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_HUMAN_FACTOR') and o.name = 'FK_T_PHA_T_PHA_HUMAN_FACTOR')
alter table T_PHA_HUMAN_FACTOR
   drop constraint FK_T_PHA_T_PHA_HUMAN_FACTOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_KEANGGOTAAN') and o.name = 'FK_R_JABATAN_PHA_T_PHA_KEANGGOTAAN')
alter table T_PHA_KEANGGOTAAN
   drop constraint FK_R_JABATAN_PHA_T_PHA_KEANGGOTAAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_KEANGGOTAAN') and o.name = 'FK_R_PEGAWAI_T_PHA_KEANGGOTAAN')
alter table T_PHA_KEANGGOTAAN
   drop constraint FK_R_PEGAWAI_T_PHA_KEANGGOTAAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_KEANGGOTAAN') and o.name = 'FK_T_PHA_T_PHA_KEANGGOTAAN')
alter table T_PHA_KEANGGOTAAN
   drop constraint FK_T_PHA_T_PHA_KEANGGOTAAN
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
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_REFERENCE') and o.name = 'FK_T_PHA_T_PHA_REFERENCES')
alter table T_PHA_REFERENCE
   drop constraint FK_T_PHA_T_PHA_REFERENCES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_RENCANA_KERJA') and o.name = 'FK_T_PHA_T_PHA_RENCANA_KERJA')
alter table T_PHA_RENCANA_KERJA
   drop constraint FK_T_PHA_T_PHA_RENCANA_KERJA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_STORM') and o.name = 'FK_R_RISK_DEFINITION_T_PHA_STORM')
alter table T_PHA_STORM
   drop constraint FK_R_RISK_DEFINITION_T_PHA_STORM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_STORM') and o.name = 'FK_T_PHA_T_PHA_STORM')
alter table T_PHA_STORM
   drop constraint FK_T_PHA_T_PHA_STORM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_WORK_STEPS') and o.name = 'FK_R_WORK_STEPS_T_PHA_WORK_STEPS')
alter table T_PHA_WORK_STEPS
   drop constraint FK_R_WORK_STEPS_T_PHA_WORK_STEPS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_WORK_STEPS') and o.name = 'FK_T_PHA_T_PHA_WORK_STEPS')
alter table T_PHA_WORK_STEPS
   drop constraint FK_T_PHA_T_PHA_WORK_STEPS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PHA_WSFCA') and o.name = 'FK_T_PHA_T_PHA_WSFCA')
alter table T_PHA_WSFCA
   drop constraint FK_T_PHA_T_PHA_WSFCA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR') and o.name = 'FK_R_PROJECT_T_PSSR')
alter table T_PSSR
   drop constraint FK_R_PROJECT_T_PSSR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR_DETAIL') and o.name = 'FK_R_ITEM_DETAIL_PSSR_T_PSSR_DETAIL')
alter table T_PSSR_DETAIL
   drop constraint FK_R_ITEM_DETAIL_PSSR_T_PSSR_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR_DETAIL') and o.name = 'FK_T_PSSR_T_PSSR_DETAIL')
alter table T_PSSR_DETAIL
   drop constraint FK_T_PSSR_T_PSSR_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR_KEANGGOTAAN') and o.name = 'FK_R_JABATAN_PSSR_T_PSSR_KEANGGOTAAN')
alter table T_PSSR_KEANGGOTAAN
   drop constraint FK_R_JABATAN_PSSR_T_PSSR_KEANGGOTAAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR_KEANGGOTAAN') and o.name = 'FK_R_PEGAWAI_T_PSSR_KEANGGOTAAN')
alter table T_PSSR_KEANGGOTAAN
   drop constraint FK_R_PEGAWAI_T_PSSR_KEANGGOTAAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR_KEANGGOTAAN') and o.name = 'FK_T_PSSR_T_PSSR_KEANGGOTAAN')
alter table T_PSSR_KEANGGOTAAN
   drop constraint FK_T_PSSR_T_PSSR_KEANGGOTAAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PSSR_REFERENCE') and o.name = 'FK_T_PSSR_T_PSSR_REFERENCE')
alter table T_PSSR_REFERENCE
   drop constraint FK_T_PSSR_T_PSSR_REFERENCE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_REPO') and o.name = 'FK___GRUP_USER_T_REPO')
alter table T_REPO
   drop constraint FK___GRUP_USER_T_REPO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_REPO') and o.name = 'FK___USER_T_REPO')
alter table T_REPO
   drop constraint FK___USER_T_REPO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_REPO') and o.name = 'FK___USER_T_REPO2')
alter table T_REPO
   drop constraint FK___USER_T_REPO2
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_CSM_FAKTOR_PENILAIAN')
            and   type = 'U')
   drop table R_CSM_FAKTOR_PENILAIAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_CSM_PENILAIAN')
            and   name  = 'R_CSM_PENILAIAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_CSM_PENILAIAN.R_CSM_PENILAIAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_CSM_PENILAIAN')
            and   type = 'U')
   drop table R_CSM_PENILAIAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_CSM_PERF_EVAL')
            and   type = 'U')
   drop table R_CSM_PERF_EVAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_CSM_PERF_EVAL_PS')
            and   type = 'U')
   drop table R_CSM_PERF_EVAL_PS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_CSM_PERF_EVAL_SI')
            and   type = 'U')
   drop table R_CSM_PERF_EVAL_SI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_HAZARD_PRESSURE')
            and   type = 'U')
   drop table R_HAZARD_PRESSURE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_HAZARD_PROCESS')
            and   type = 'U')
   drop table R_HAZARD_PROCESS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_ITEM_CA')
            and   type = 'U')
   drop table R_ITEM_CA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_ITEM_DETAIL_PSSR')
            and   type = 'U')
   drop table R_ITEM_DETAIL_PSSR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_ITEM_PSSR')
            and   type = 'U')
   drop table R_ITEM_PSSR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_JABATAN_PHA')
            and   type = 'U')
   drop table R_JABATAN_PHA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_JABATAN_PSSR')
            and   type = 'U')
   drop table R_JABATAN_PSSR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KATEGORI_ITEM_CA')
            and   type = 'U')
   drop table R_KATEGORI_ITEM_CA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KATEGORI_ITEM_PSSR')
            and   type = 'U')
   drop table R_KATEGORI_ITEM_PSSR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KOMPONEN_LINGKUNGAN')
            and   type = 'U')
   drop table R_KOMPONEN_LINGKUNGAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR')
            and   name  = 'R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB2'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR.R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR')
            and   name  = 'R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR.R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR')
            and   name  = 'R_KONTRAKTOR_FK_R_KONTRAKTOR_TIPE'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR.R_KONTRAKTOR_FK_R_KONTRAKTOR_TIPE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR')
            and   type = 'U')
   drop table R_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_JAB')
            and   type = 'U')
   drop table R_KONTRAKTOR_JAB
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_JUL')
            and   name  = 'R_KONTRAKTOR_JUL_FK_R_KONTRAKTOR'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_JUL.R_KONTRAKTOR_JUL_FK_R_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_JUL')
            and   type = 'U')
   drop table R_KONTRAKTOR_JUL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_KLM')
            and   name  = 'R_KONTRAKTOR_KLM_FK_T_REPO'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_KLM.R_KONTRAKTOR_KLM_FK_T_REPO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_KLM')
            and   name  = 'R_KONTRAKTOR_KLM_FK_R_KONTRAKTOR'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_KLM.R_KONTRAKTOR_KLM_FK_R_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_KLM')
            and   type = 'U')
   drop table R_KONTRAKTOR_KLM
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_PIM')
            and   name  = 'R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR_JAB'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_PIM.R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR_JAB
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_PIM')
            and   name  = 'R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_PIM.R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_PIM')
            and   type = 'U')
   drop table R_KONTRAKTOR_PIM
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_PSD')
            and   name  = 'R_KONTRAKTOR_PSD_FK_R_KONTRAKTOR'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_PSD.R_KONTRAKTOR_PSD_FK_R_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_PSD')
            and   type = 'U')
   drop table R_KONTRAKTOR_PSD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_PTD')
            and   name  = 'R_KONTRAKTOR_PTD_FK_R_KONTRAKTOR'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_PTD.R_KONTRAKTOR_PTD_FK_R_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_PTD')
            and   type = 'U')
   drop table R_KONTRAKTOR_PTD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_KONTRAKTOR_PUL')
            and   name  = 'R_KONTRAKTOR_PUL_FK_R_KONTRAKTOR'
            and   indid > 0
            and   indid < 255)
   drop index R_KONTRAKTOR_PUL.R_KONTRAKTOR_PUL_FK_R_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_PUL')
            and   type = 'U')
   drop table R_KONTRAKTOR_PUL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KONTRAKTOR_TIPE')
            and   type = 'U')
   drop table R_KONTRAKTOR_TIPE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_MATERIAL')
            and   type = 'U')
   drop table R_MATERIAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_MATERIAL_INTERACTION')
            and   type = 'U')
   drop table R_MATERIAL_INTERACTION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_PROJECT')
            and   type = 'U')
   drop table R_PROJECT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_PROPERTIES')
            and   type = 'U')
   drop table R_PROPERTIES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_REPORT')
            and   type = 'U')
   drop table R_REPORT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_CONSEQUENCE')
            and   type = 'U')
   drop table R_RISK_CONSEQUENCE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_DEFINITION')
            and   type = 'U')
   drop table R_RISK_DEFINITION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_FREQUENCY')
            and   type = 'U')
   drop table R_RISK_FREQUENCY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_RISK_RANKING_MATRIX')
            and   type = 'U')
   drop table R_RISK_RANKING_MATRIX
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_WORK_STEPS')
            and   type = 'U')
   drop table R_WORK_STEPS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CHEMICAL_HAZARD')
            and   type = 'U')
   drop table T_CHEMICAL_HAZARD
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CIM')
            and   type = 'U')
   drop table T_CIM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CSM_PROYEK')
            and   type = 'U')
   drop table T_CSM_PROYEK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CSM_PROYEK_KONTRAKTOR')
            and   type = 'U')
   drop table T_CSM_PROYEK_KONTRAKTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CSM_PROYEK_KONT_EVAL')
            and   type = 'U')
   drop table T_CSM_PROYEK_KONT_EVAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CSM_PROYEK_KONT_EVAL_NILAI')
            and   type = 'U')
   drop table T_CSM_PROYEK_KONT_EVAL_NILAI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_CSM_PROYEK_KONT_NILAI')
            and   type = 'U')
   drop table T_CSM_PROYEK_KONT_NILAI
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
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN')
            and   type = 'U')
   drop table T_LINGKUNGAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_LINGKUNGAN_BULANAN_DETAIL')
            and   name  = 'T_LINGKUNGAN_BULANAN_DETAIL_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_LINGKUNGAN_BULANAN_DETAIL.T_LINGKUNGAN_BULANAN_DETAIL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN_DETAIL')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_DETAIL')
            and   type = 'U')
   drop table T_LINGKUNGAN_DETAIL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA')
            and   name  = 'T_PHA_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA.T_PHA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA')
            and   type = 'U')
   drop table T_PHA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_CA')
            and   type = 'U')
   drop table T_PHA_CA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_CHEMICAL_HAZARD')
            and   type = 'U')
   drop table T_PHA_CHEMICAL_HAZARD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_FACILITY_SITTING')
            and   name  = 'T_PHA_FACILITY_SITTING_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_FACILITY_SITTING.T_PHA_FACILITY_SITTING_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_FACILITY_SITTING')
            and   type = 'U')
   drop table T_PHA_FACILITY_SITTING
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_FIELD_TOUR')
            and   name  = 'T_PHA_FIELD_TOUR_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_FIELD_TOUR.T_PHA_FIELD_TOUR_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_FIELD_TOUR')
            and   type = 'U')
   drop table T_PHA_FIELD_TOUR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_HAZARD_PRESSURE')
            and   type = 'U')
   drop table T_PHA_HAZARD_PRESSURE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_HAZARD_PROCESS')
            and   type = 'U')
   drop table T_PHA_HAZARD_PROCESS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_HUMAN_FACTOR')
            and   name  = 'T_PHA_HUMAN_FACTOR_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_HUMAN_FACTOR.T_PHA_HUMAN_FACTOR_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_HUMAN_FACTOR')
            and   type = 'U')
   drop table T_PHA_HUMAN_FACTOR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_KEANGGOTAAN')
            and   name  = 'T_PHA_KEANGGOTAAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_KEANGGOTAAN.T_PHA_KEANGGOTAAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_KEANGGOTAAN')
            and   type = 'U')
   drop table T_PHA_KEANGGOTAAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_PHR')
            and   type = 'U')
   drop table T_PHA_PHR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_PHR_RECOMMENDATION')
            and   name  = 'T_PHA_PHR_RECOMMENDATION_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_PHR_RECOMMENDATION.T_PHA_PHR_RECOMMENDATION_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_PHR_RECOMMENDATION')
            and   type = 'U')
   drop table T_PHA_PHR_RECOMMENDATION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_REFERENCE')
            and   name  = 'T_PHA_REFERENCE_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_REFERENCE.T_PHA_REFERENCE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_REFERENCE')
            and   type = 'U')
   drop table T_PHA_REFERENCE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_RENCANA_KERJA')
            and   name  = 'T_PHA_RENCANA_KERJA_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_RENCANA_KERJA.T_PHA_RENCANA_KERJA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_RENCANA_KERJA')
            and   type = 'U')
   drop table T_PHA_RENCANA_KERJA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_STORM')
            and   name  = 'T_PHA_STORM_FK_R_RISK_DEFINITION'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_STORM.T_PHA_STORM_FK_R_RISK_DEFINITION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_STORM')
            and   name  = 'T_PHA_STORM_FK_T_PHA'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_STORM.T_PHA_STORM_FK_T_PHA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_STORM')
            and   type = 'U')
   drop table T_PHA_STORM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_WORK_STEPS')
            and   type = 'U')
   drop table T_PHA_WORK_STEPS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PHA_WSFCA')
            and   name  = 'T_PHA_WSFCA_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PHA_WSFCA.T_PHA_WSFCA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PHA_WSFCA')
            and   type = 'U')
   drop table T_PHA_WSFCA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PSSR')
            and   name  = 'T_PSSR_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PSSR.T_PSSR_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PSSR')
            and   type = 'U')
   drop table T_PSSR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PSSR_DETAIL')
            and   type = 'U')
   drop table T_PSSR_DETAIL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PSSR_KEANGGOTAAN')
            and   name  = 'T_PSSR_KEANGGOTAAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PSSR_KEANGGOTAAN.T_PSSR_KEANGGOTAAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PSSR_KEANGGOTAAN')
            and   type = 'U')
   drop table T_PSSR_KEANGGOTAAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PSSR_REFERENCE')
            and   name  = 'T_PSSR_REFERENCE_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PSSR_REFERENCE.T_PSSR_REFERENCE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PSSR_REFERENCE')
            and   type = 'U')
   drop table T_PSSR_REFERENCE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_REPO')
            and   name  = 'T_REPO_FK___GRUP_USER'
            and   indid > 0
            and   indid < 255)
   drop index T_REPO.T_REPO_FK___GRUP_USER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_REPO')
            and   name  = 'T_REPO_FK___USER2'
            and   indid > 0
            and   indid < 255)
   drop index T_REPO.T_REPO_FK___USER2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_REPO')
            and   name  = 'T_REPO_FK___USER1'
            and   indid > 0
            and   indid < 255)
   drop index T_REPO.T_REPO_FK___USER1
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_REPO')
            and   type = 'U')
   drop table T_REPO
go

/*==============================================================*/
/* Table: R_CSM_FAKTOR_PENILAIAN                                */
/*==============================================================*/
create table R_CSM_FAKTOR_PENILAIAN (
   ID                   int                  not null,
   KETERANGAN           varchar(512)         not null,
   KOEFISIEN            float                not null,
   constraint PK_R_CSM_FAKTOR_PENILAIAN primary key (ID)
)
go

/*==============================================================*/
/* Table: R_CSM_PENILAIAN                                       */
/*==============================================================*/
create table R_CSM_PENILAIAN (
   ID                   int                  identity,
   ID_FAKTOR            int                  not null,
   KETERANGAN           varchar(512)         not null,
   NILAI_A              smallint             not null,
   NILAI_B              smallint             not null,
   NILAI_C              smallint             not null,
   NILAI_D              smallint             not null,
   constraint PK_R_CSM_PENILAIAN primary key (ID)
)
go

/*==============================================================*/
/* Index: R_CSM_PENILAIAN_FK                                    */
/*==============================================================*/
create index R_CSM_PENILAIAN_FK on R_CSM_PENILAIAN (
ID_FAKTOR ASC
)
go

/*==============================================================*/
/* Table: R_CSM_PERF_EVAL                                       */
/*==============================================================*/
create table R_CSM_PERF_EVAL (
   ID                   int                  identity,
   WEIGHT_FACTOR        float                not null,
   ELEMENT              varchar(1024)        not null,
   constraint PK_R_CSM_PERF_EVAL primary key (ID)
)
go

/*==============================================================*/
/* Table: R_CSM_PERF_EVAL_PS                                    */
/*==============================================================*/
create table R_CSM_PERF_EVAL_PS (
   ID                   int                  identity,
   NILAI_MIN            float                not null default 0,
   NILAI_MAX            float                not null default 0,
   KETERANGAN           varchar(512)         not null default '',
   constraint PK_R_CSM_PERF_EVAL_PS primary key (ID)
)
go

/*==============================================================*/
/* Table: R_CSM_PERF_EVAL_SI                                    */
/*==============================================================*/
create table R_CSM_PERF_EVAL_SI (
   ID                   int                  identity,
   SCORE                int                  not null,
   KETERANGAN           varchar(512)         not null,
   constraint PK_R_CSM_PERF_EVAL_SI primary key (ID)
)
go

/*==============================================================*/
/* Table: R_HAZARD_PRESSURE                                     */
/*==============================================================*/
create table R_HAZARD_PRESSURE (
   ID_HAZARD_PRESSURE   int                  identity,
   NAMA_HAZARD_PRESSURE varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_HAZARD_PRESSURE primary key (ID_HAZARD_PRESSURE)
)
go

/*==============================================================*/
/* Table: R_HAZARD_PROCESS                                      */
/*==============================================================*/
create table R_HAZARD_PROCESS (
   ID_HAZARD_PROCESS    int                  identity,
   NAMA_HAZARD_PROCESS  varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_HAZARD_PROCESS primary key (ID_HAZARD_PROCESS)
)
go

/*==============================================================*/
/* Table: R_ITEM_CA                                             */
/*==============================================================*/
create table R_ITEM_CA (
   ID_ITEM_CA           int                  identity,
   ID_KATEGORI_ITEM_CA  int                  not null,
   NAMA_ITEM_CA         varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_ITEM_CA primary key (ID_ITEM_CA, ID_KATEGORI_ITEM_CA)
)
go

/*==============================================================*/
/* Table: R_ITEM_DETAIL_PSSR                                    */
/*==============================================================*/
create table R_ITEM_DETAIL_PSSR (
   ID_ITEM_DETAIL_PSSR  int                  identity,
   ID_ITEM_PSSR         int                  not null,
   ID_KATEGORI_ITEM_PSSR int                  not null,
   NAMA_ITEM_DETAIL_PSSR varchar(512)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_ITEM_DETAIL_PSSR primary key (ID_ITEM_DETAIL_PSSR, ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR)
)
go

/*==============================================================*/
/* Table: R_ITEM_PSSR                                           */
/*==============================================================*/
create table R_ITEM_PSSR (
   ID_ITEM_PSSR         int                  identity,
   ID_KATEGORI_ITEM_PSSR int                  not null,
   NAMA_ITEM_PSSR       varchar(512)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_ITEM_PSSR primary key (ID_KATEGORI_ITEM_PSSR, ID_ITEM_PSSR)
)
go

/*==============================================================*/
/* Table: R_JABATAN_PHA                                         */
/*==============================================================*/
create table R_JABATAN_PHA (
   ID_JABATAN_PHA       int                  identity,
   NAMA_JABATAN_PHA     varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_JABATAN_PHA primary key (ID_JABATAN_PHA)
)
go

/*==============================================================*/
/* Table: R_JABATAN_PSSR                                        */
/*==============================================================*/
create table R_JABATAN_PSSR (
   ID_JABATAN_PSSR      int                  identity,
   NAMA_JABATAN_PSSR    varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_JABATAN_PSSR primary key (ID_JABATAN_PSSR)
)
go

/*==============================================================*/
/* Table: R_KATEGORI_ITEM_CA                                    */
/*==============================================================*/
create table R_KATEGORI_ITEM_CA (
   ID_KATEGORI_ITEM_CA  int                  identity,
   NAMA_KATEGORI_ITEM_CA varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KATEGORI_ITEM_CA primary key (ID_KATEGORI_ITEM_CA)
)
go

/*==============================================================*/
/* Table: R_KATEGORI_ITEM_PSSR                                  */
/*==============================================================*/
create table R_KATEGORI_ITEM_PSSR (
   ID_KATEGORI_ITEM_PSSR int                  identity,
   NAMA_KATEGORI_ITEM_PSSR varchar(256)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KATEGORI_ITEM_PSSR primary key (ID_KATEGORI_ITEM_PSSR)
)
go

/*==============================================================*/
/* Table: R_KOMPONEN_LINGKUNGAN                                 */
/*==============================================================*/
create table R_KOMPONEN_LINGKUNGAN (
   ID_KOMPONEN_LINGKUNGAN int                  identity,
   NAMA_KOMPONEN_LINGKUNGAN varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KOMPONEN_LINGKUNGAN primary key (ID_KOMPONEN_LINGKUNGAN)
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR                                          */
/*==============================================================*/
create table R_KONTRAKTOR (
   ID                   bigint               not null,
   TIPE                 int                  not null default 1,
   NAMA                 varchar(256)         not null default '',
   ALAMAT               varchar(512)         not null default '',
   TELP                 varchar(64)          null default '',
   FAX                  varchar(64)          null default '',
   PEMILIK_NAMA         varchar(128)         not null default '',
   PEMILIK_ALAMAT       varchar(512)         not null default '',
   ASURANSI_STATUS      tinyint              not null default 0,
   ASURANSI_PJ          varchar(128)         not null default '',
   ASURANSI_ALAMAT      varchar(512)         null default '',
   ASURANSI_TELP        varchar(64)          null default '',
   PENAWAR_NAMA         varchar(128)         not null default '',
   PENAWAR_JAB          int                  not null default 1,
   PENAWAR_TELP         varchar(64)          null default '',
   PENAWAR_FAX          varchar(64)          null default '',
   PENGISI_NAMA         varchar(128)         not null default '',
   PENGISI_JAB          int                  not null default 1,
   PENGISI_TELP         varchar(64)          null default '',
   PENGISI_FAX          varchar(64)          null default '',
   KLAIM_STATUS         tinyint              not null default 0,
   BANGKRUT_STATUS      tinyint              not null default 0,
   BANGKRUT_DETAIL      varchar(1024)        null default '',
   constraint PK_R_KONTRAKTOR primary key (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : tidak
   1 : ya',
   'user', @CurrentUser, 'table', 'R_KONTRAKTOR', 'column', 'ASURANSI_STATUS'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : tidak
   1 : ya',
   'user', @CurrentUser, 'table', 'R_KONTRAKTOR', 'column', 'KLAIM_STATUS'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : tidak
   1 : ya',
   'user', @CurrentUser, 'table', 'R_KONTRAKTOR', 'column', 'BANGKRUT_STATUS'
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_FK_R_KONTRAKTOR_TIPE                     */
/*==============================================================*/
create index R_KONTRAKTOR_FK_R_KONTRAKTOR_TIPE on R_KONTRAKTOR (
TIPE ASC
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB                      */
/*==============================================================*/
create index R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB on R_KONTRAKTOR (
PENAWAR_JAB ASC
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB2                     */
/*==============================================================*/
create index R_KONTRAKTOR_FK_R_KONTRAKTOR_JAB2 on R_KONTRAKTOR (
PENGISI_JAB ASC
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_JAB                                      */
/*==============================================================*/
create table R_KONTRAKTOR_JAB (
   ID                   int                  identity,
   NAME                 varchar(128)         not null,
   constraint PK_R_KONTRAKTOR_JAB primary key (ID)
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_JUL                                      */
/*==============================================================*/
create table R_KONTRAKTOR_JUL (
   ID                   bigint               identity,
   ID_KONTRAKTOR        bigint               not null,
   KET                  varchar(512)         null default '',
   constraint PK_R_KONTRAKTOR_JUL primary key (ID)
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_JUL_FK_R_KONTRAKTOR                      */
/*==============================================================*/
create index R_KONTRAKTOR_JUL_FK_R_KONTRAKTOR on R_KONTRAKTOR_JUL (
ID_KONTRAKTOR ASC
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_KLM                                      */
/*==============================================================*/
create table R_KONTRAKTOR_KLM (
   ID                   bigint               identity,
   ID_KONTRAKTOR        bigint               not null,
   ID_REPO              int                  not null,
   constraint PK_R_KONTRAKTOR_KLM primary key (ID)
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_KLM_FK_R_KONTRAKTOR                      */
/*==============================================================*/
create index R_KONTRAKTOR_KLM_FK_R_KONTRAKTOR on R_KONTRAKTOR_KLM (
ID_KONTRAKTOR ASC
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_KLM_FK_T_REPO                            */
/*==============================================================*/
create index R_KONTRAKTOR_KLM_FK_T_REPO on R_KONTRAKTOR_KLM (
ID_REPO ASC
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_PIM                                      */
/*==============================================================*/
create table R_KONTRAKTOR_PIM (
   ID                   bigint               identity,
   ID_KONTRAKTOR        bigint               not null,
   ID_JAB               int                  not null,
   NAMA                 varchar(128)         not null,
   LAMA_BEKERJA         tinyint              not null,
   constraint PK_R_KONTRAKTOR_PIM primary key (ID)
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR                      */
/*==============================================================*/
create index R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR on R_KONTRAKTOR_PIM (
ID_KONTRAKTOR ASC
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR_JAB                  */
/*==============================================================*/
create index R_KONTRAKTOR_PIM_FK_R_KONTRAKTOR_JAB on R_KONTRAKTOR_PIM (
ID_JAB ASC
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_PSD                                      */
/*==============================================================*/
create table R_KONTRAKTOR_PSD (
   ID                   bigint               identity,
   ID_KONTRAKTOR        bigint               not null,
   TEMPAT               varchar(256)         null default '',
   JENIS                varchar(128)         null default '',
   NILAI                varchar(32)          null default '',
   constraint PK_R_KONTRAKTOR_PSD primary key (ID)
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_PSD_FK_R_KONTRAKTOR                      */
/*==============================================================*/
create index R_KONTRAKTOR_PSD_FK_R_KONTRAKTOR on R_KONTRAKTOR_PSD (
ID_KONTRAKTOR ASC
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_PTD                                      */
/*==============================================================*/
create table R_KONTRAKTOR_PTD (
   ID                   bigint               identity,
   ID_KONTRAKTOR        bigint               not null,
   TEMPAT               varchar(256)         null default '',
   JENIS                varchar(128)         null default '',
   NILAI                varchar(32)          null default '',
   constraint PK_R_KONTRAKTOR_PTD primary key (ID)
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_PTD_FK_R_KONTRAKTOR                      */
/*==============================================================*/
create index R_KONTRAKTOR_PTD_FK_R_KONTRAKTOR on R_KONTRAKTOR_PTD (
ID_KONTRAKTOR ASC
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_PUL                                      */
/*==============================================================*/
create table R_KONTRAKTOR_PUL (
   ID                   bigint               identity,
   ID_KONTRAKTOR        bigint               not null,
   NAMA                 varchar(256)         not null,
   ALAMAT               varchar(512)         null,
   TELP                 varchar(64)          null,
   constraint PK_R_KONTRAKTOR_PUL primary key (ID)
)
go

/*==============================================================*/
/* Index: R_KONTRAKTOR_PUL_FK_R_KONTRAKTOR                      */
/*==============================================================*/
create index R_KONTRAKTOR_PUL_FK_R_KONTRAKTOR on R_KONTRAKTOR_PUL (
ID_KONTRAKTOR ASC
)
go

/*==============================================================*/
/* Table: R_KONTRAKTOR_TIPE                                     */
/*==============================================================*/
create table R_KONTRAKTOR_TIPE (
   ID                   int                  identity,
   NAME                 varchar(128)         not null,
   constraint PK_R_KONTRAKTOR_TIPE primary key (ID)
)
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
/* Table: R_MATERIAL_INTERACTION                                */
/*==============================================================*/
create table R_MATERIAL_INTERACTION (
   ID_MATERIAL_INTERACTION smallint             identity,
   NAMA_MATERIAL_INTERACTION varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_MATERIAL_INTERACTION primary key (ID_MATERIAL_INTERACTION)
)
go

/*==============================================================*/
/* Table: R_PROJECT                                             */
/*==============================================================*/
create table R_PROJECT (
   ID_PROJECT           bigint               identity,
   NO_PROJECT           varchar(50)          not null,
   NAMA_PROJECT         varchar(512)         not null,
   TANGGAL_MULAI        datetime             not null default getdate(),
   DURASI               int                  null default 0,
   KETERANGAN           varchar(1024)        null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_PROJECT primary key (ID_PROJECT)
)
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
/* Table: R_REPORT                                              */
/*==============================================================*/
create table R_REPORT (
   ID_REPORT            int                  identity,
   NAMA_REPORT          varchar(128)         not null,
   KLASIFIKASI_REPORT   tinyint              not null default 1,
   TIPE_REPORT          varchar(3)           not null default 'pdf',
   FILE_LOCATION        varchar(512)         not null default '',
   WEB_PARAMS           varchar(128)         null,
   REPORT_PARAMS        varchar(128)         null,
   constraint PK_R_REPORT primary key (ID_REPORT)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 : CSM
   2 : PSSR
   3 : PHA
   4 : LINGKUNGAN',
   'user', @CurrentUser, 'table', 'R_REPORT', 'column', 'KLASIFIKASI_REPORT'
go

/*==============================================================*/
/* Table: R_RISK_CONSEQUENCE                                    */
/*==============================================================*/
create table R_RISK_CONSEQUENCE (
   ID_RISK_CONSEQUENCE  int                  identity,
   CONSEQUENCE_CATEGORY varchar(128)         not null,
   C1                   varchar(1024)        not null,
   C2                   varchar(1024)        not null,
   C3                   varchar(1024)        not null,
   C4                   varchar(1024)        not null,
   NOTE                 varchar(1024)        null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_CONSEQUENCE primary key (ID_RISK_CONSEQUENCE)
)
go

/*==============================================================*/
/* Table: R_RISK_DEFINITION                                     */
/*==============================================================*/
create table R_RISK_DEFINITION (
   RISK_SCORE           varchar(5)           not null,
   DESCRIPTION          varchar(64)          not null,
   NOTE                 varchar(256)         not null,
   ACTION_REQUIRED      varchar(1024)        not null,
   PHA_RECOMMENDATION   varchar(1024)        not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_DEFINITION primary key (RISK_SCORE)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'I, II, III, IV',
   'user', @CurrentUser, 'table', 'R_RISK_DEFINITION', 'column', 'RISK_SCORE'
go

/*==============================================================*/
/* Table: R_RISK_FREQUENCY                                      */
/*==============================================================*/
create table R_RISK_FREQUENCY (
   ID_RISK_FREQUENCY    smallint             identity,
   DESCRIPTION          varchar(256)         not null,
   FREQUENCY            varchar(128)         not null,
   FREQUENCY_CATEGORY   varchar(5)           not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_FREQUENCY primary key (ID_RISK_FREQUENCY)
)
go

/*==============================================================*/
/* Table: R_RISK_RANKING_MATRIX                                 */
/*==============================================================*/
create table R_RISK_RANKING_MATRIX (
   F                    tinyint              not null,
   C                    tinyint              not null,
   RR                   tinyint              not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_RISK_RANKING_MATRIX primary key (F, C)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : -
   1 : F1
   2 : F2
   3 : F3
   4 : F4',
   'user', @CurrentUser, 'table', 'R_RISK_RANKING_MATRIX', 'column', 'F'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : -
   1 : C1
   2 : C2
   3 : C3
   4 : C4',
   'user', @CurrentUser, 'table', 'R_RISK_RANKING_MATRIX', 'column', 'C'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : -
   1 : I
   2 : II
   3 : III
   4 : IV',
   'user', @CurrentUser, 'table', 'R_RISK_RANKING_MATRIX', 'column', 'RR'
go

/*==============================================================*/
/* Table: R_WORK_STEPS                                          */
/*==============================================================*/
create table R_WORK_STEPS (
   ID_WORK_STEPS        int                  identity,
   NAMA_WORK_STEPS      varchar(256)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_WORK_STEPS primary key (ID_WORK_STEPS)
)
go

/*==============================================================*/
/* Table: T_CHEMICAL_HAZARD                                     */
/*==============================================================*/
create table T_CHEMICAL_HAZARD (
   ID_MATERIAL          smallint             not null,
   ID_PROPERTIES        smallint             not null,
   DESCRIPTION          varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_CHEMICAL_HAZARD primary key (ID_MATERIAL, ID_PROPERTIES)
)
go

/*==============================================================*/
/* Table: T_CIM                                                 */
/*==============================================================*/
create table T_CIM (
   ID_MATERIAL          smallint             not null,
   ID_MATERIAL_INTERACTION smallint             not null,
   INTERACTION          varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_CIM primary key (ID_MATERIAL, ID_MATERIAL_INTERACTION)
)
go

/*==============================================================*/
/* Table: T_CSM_PROYEK                                          */
/*==============================================================*/
create table T_CSM_PROYEK (
   ID_PROJECT           bigint               not null,
   ID_KONTRAKTOR        bigint               null default null,
   EVAL_RAW_SCORE       int                  null default 0,
   EVAL_WEIGHTED_SCORE  float                null default 0.0,
   constraint PK_T_CSM_PROYEK primary key (ID_PROJECT)
)
go

/*==============================================================*/
/* Table: T_CSM_PROYEK_KONTRAKTOR                               */
/*==============================================================*/
create table T_CSM_PROYEK_KONTRAKTOR (
   ID_PROJECT           bigint               not null,
   ID_KONTRAKTOR        bigint               not null,
   TOTAL_NILAI          float                not null default 0.0,
   constraint PK_T_CSM_PROYEK_KONTRAKTOR primary key (ID_PROJECT, ID_KONTRAKTOR)
)
go

/*==============================================================*/
/* Table: T_CSM_PROYEK_KONT_EVAL                                */
/*==============================================================*/
create table T_CSM_PROYEK_KONT_EVAL (
   ID_PROJECT           bigint               not null,
   TANGGAL              datetime             not null default getdate(),
   TEAM                 varchar(128)         not null default '',
   WORK_AREA            varchar(128)         not null default '',
   constraint PK_T_CSM_PROYEK_KONT_EVAL primary key (ID_PROJECT)
)
go

/*==============================================================*/
/* Table: T_CSM_PROYEK_KONT_EVAL_NILAI                          */
/*==============================================================*/
create table T_CSM_PROYEK_KONT_EVAL_NILAI (
   ID_PROJECT           bigint               not null,
   ID_EVALUASI          int                  not null,
   NILAI                smallint             not null,
   constraint PK_T_CSM_PROYEK_KONT_EVAL_NILA primary key (ID_PROJECT, ID_EVALUASI)
)
go

/*==============================================================*/
/* Table: T_CSM_PROYEK_KONT_NILAI                               */
/*==============================================================*/
create table T_CSM_PROYEK_KONT_NILAI (
   ID_PROJECT           bigint               not null,
   ID_KONTRAKTOR        bigint               not null,
   ID_PENILAIAN         int                  not null,
   NILAI                int                  not null default 0,
   KETERANGAN           varchar(512)         not null default '',
   constraint PK_T_CSM_PROYEK_KONT_NILAI primary key (ID_PROJECT, ID_KONTRAKTOR, ID_PENILAIAN)
)
go

/*==============================================================*/
/* Table: T_LINGKUNGAN                                          */
/*==============================================================*/
create table T_LINGKUNGAN (
   ID_LINGKUNGAN_TAHUNAN bigint               not null,
   ID_SEKSI             int                  not null,
   ID_DINAS             int                  not null,
   ID_DEPARTEMEN        int                  not null,
   TIPE_KEGIATAN_LINGKUNGAN tinyint              not null default 1,
   PROYEK_KEGIATAN_AKTIFITAS varchar(512)         not null default '',
   DIKOMPILASI_OLEH     varchar(128)         not null default '',
   TANGGAL_KOMPILASI    datetime             not null default getdate(),
   DISETUJUI_OLEH       varchar(128)         not null default '',
   TANGGAL_DISETUJUI    datetime             not null default getdate(),
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN primary key (ID_LINGKUNGAN_TAHUNAN)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 : Pemantauan Lingkungan
   2 : Pengelolaan Lingkungan',
   'user', @CurrentUser, 'table', 'T_LINGKUNGAN', 'column', 'TIPE_KEGIATAN_LINGKUNGAN'
go

/*==============================================================*/
/* Index: T_LINGKUNGAN_FK_R_SEKSI                               */
/*==============================================================*/
create index T_LINGKUNGAN_FK_R_SEKSI on T_LINGKUNGAN (
ID_SEKSI ASC,
ID_DINAS ASC,
ID_DEPARTEMEN ASC
)
go

/*==============================================================*/
/* Table: T_LINGKUNGAN_BULANAN                                  */
/*==============================================================*/
create table T_LINGKUNGAN_BULANAN (
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   PEKERJAAN            varchar(512)         not null default '',
   LOKASI_PROYEK        varchar(512)         not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_BULANAN primary key (TAHUN, BULAN)
)
go

/*==============================================================*/
/* Table: T_LINGKUNGAN_BULANAN_DETAIL                           */
/*==============================================================*/
create table T_LINGKUNGAN_BULANAN_DETAIL (
   ID_LINGKUNGAN_BULANAN_DETAIL bigint               not null,
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

/*==============================================================*/
/* Index: T_LINGKUNGAN_BULANAN_DETAIL_FK                        */
/*==============================================================*/
create index T_LINGKUNGAN_BULANAN_DETAIL_FK on T_LINGKUNGAN_BULANAN_DETAIL (
TAHUN ASC,
BULAN ASC
)
go

/*==============================================================*/
/* Table: T_LINGKUNGAN_DETAIL                                   */
/*==============================================================*/
create table T_LINGKUNGAN_DETAIL (
   ID_LINGKUNGAN_TAHUNAN bigint               not null,
   ID_KOMPONEN_LINGKUNGAN int                  not null,
   LOKASI_DAMPAK        varchar(256)         null default '',
   JENIS_DAMPAK         varchar(256)         null default '',
   SUMBER_DAMPAK        varchar(256)         null default '',
   PARAMETER_PEMANTAUAN varchar(128)         null default '',
   BAKU_MUTU_PEMANTAUAN varchar(128)         null default '',
   PERIODE_PEMANTAUAN   varchar(256)         null default '',
   HASIL_PEMANTAUAN     varchar(1024)        null default '',
   METODE_PENGELOLAAN   varchar(256)         null default '',
   PERIODE_PENGELOLAAN  varchar(256)         null default '',
   HASIL_PENGELOLAAN    varchar(256)         null default '',
   PENANGGUNG_JAWAB     varchar(20)          null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_DETAIL primary key (ID_LINGKUNGAN_TAHUNAN, ID_KOMPONEN_LINGKUNGAN)
)
go

/*==============================================================*/
/* Table: T_PHA                                                 */
/*==============================================================*/
create table T_PHA (
   ID_PHA               bigint               not null,
   ID_PROJECT           bigint               not null,
   LOKASI               varchar(50)          not null,
   TANGGAL              datetime             not null default getdate(),
   PROSES_PHR           varchar(256)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA primary key (ID_PHA)
)
go

/*==============================================================*/
/* Index: T_PHA_FK                                              */
/*==============================================================*/
create index T_PHA_FK on T_PHA (
ID_PROJECT ASC
)
go

/*==============================================================*/
/* Table: T_PHA_CA                                              */
/*==============================================================*/
create table T_PHA_CA (
   ID_PHA               bigint               not null,
   ID_ITEM_CA           int                  not null,
   ID_KATEGORI_ITEM_CA  int                  not null,
   KETERANGAN           varchar(128)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_CA primary key (ID_PHA, ID_ITEM_CA, ID_KATEGORI_ITEM_CA)
)
go

/*==============================================================*/
/* Table: T_PHA_CHEMICAL_HAZARD                                 */
/*==============================================================*/
create table T_PHA_CHEMICAL_HAZARD (
   ID_PHA               bigint               not null,
   ID_MATERIAL          smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_CHEMICAL_HAZARD primary key (ID_PHA, ID_MATERIAL)
)
go

/*==============================================================*/
/* Table: T_PHA_FACILITY_SITTING                                */
/*==============================================================*/
create table T_PHA_FACILITY_SITTING (
   ID_PHA_FACILITY_SITTING bigint               not null,
   ID_PHA               bigint               not null,
   CATEGORY             varchar(512)         not null,
   DESCRIPTION          varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_FACILITY_SITTING primary key (ID_PHA_FACILITY_SITTING)
)
go

/*==============================================================*/
/* Index: T_PHA_FACILITY_SITTING_FK                             */
/*==============================================================*/
create index T_PHA_FACILITY_SITTING_FK on T_PHA_FACILITY_SITTING (
ID_PHA ASC
)
go

/*==============================================================*/
/* Table: T_PHA_FIELD_TOUR                                      */
/*==============================================================*/
create table T_PHA_FIELD_TOUR (
   ID_PHA_FIELD_TOUR    bigint               not null,
   ID_PHA               bigint               not null,
   KETERANGAN           varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_FIELD_TOUR primary key (ID_PHA_FIELD_TOUR)
)
go

/*==============================================================*/
/* Index: T_PHA_FIELD_TOUR_FK                                   */
/*==============================================================*/
create index T_PHA_FIELD_TOUR_FK on T_PHA_FIELD_TOUR (
ID_PHA ASC
)
go

/*==============================================================*/
/* Table: T_PHA_HAZARD_PRESSURE                                 */
/*==============================================================*/
create table T_PHA_HAZARD_PRESSURE (
   ID_PHA               bigint               not null,
   ID_HAZARD_PRESSURE   int                  not null,
   DESCRIPTION          varchar(512)         not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_HAZARD_PRESSURE primary key (ID_PHA, ID_HAZARD_PRESSURE)
)
go

/*==============================================================*/
/* Table: T_PHA_HAZARD_PROCESS                                  */
/*==============================================================*/
create table T_PHA_HAZARD_PROCESS (
   ID_PHA               bigint               not null,
   ID_HAZARD_PROCESS    int                  not null,
   DESCRIPTION          varchar(512)         null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_HAZARD_PROCESS primary key (ID_PHA, ID_HAZARD_PROCESS)
)
go

/*==============================================================*/
/* Table: T_PHA_HUMAN_FACTOR                                    */
/*==============================================================*/
create table T_PHA_HUMAN_FACTOR (
   ID_PHA_HUMAN_FACTOR  bigint               not null,
   ID_PHA               bigint               not null,
   CATEGORY             varchar(256)         not null,
   DESCRIPTION          varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_HUMAN_FACTOR primary key (ID_PHA_HUMAN_FACTOR)
)
go

/*==============================================================*/
/* Index: T_PHA_HUMAN_FACTOR_FK                                 */
/*==============================================================*/
create index T_PHA_HUMAN_FACTOR_FK on T_PHA_HUMAN_FACTOR (
ID_PHA ASC
)
go

/*==============================================================*/
/* Table: T_PHA_KEANGGOTAAN                                     */
/*==============================================================*/
create table T_PHA_KEANGGOTAAN (
   ID_PHA               bigint               not null,
   NIPG                 varchar(20)          not null,
   ID_JABATAN_PHA       int                  not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_KEANGGOTAAN primary key (ID_PHA, NIPG)
)
go

/*==============================================================*/
/* Index: T_PHA_KEANGGOTAAN_FK                                  */
/*==============================================================*/
create index T_PHA_KEANGGOTAAN_FK on T_PHA_KEANGGOTAAN (
ID_JABATAN_PHA ASC
)
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
   F                    tinyint              null default 0,
   C                    tinyint              null default 0,
   RR                   tinyint              null default 0,
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
   '0 : -
   1 : F1
   2 : F2
   3 : F3
   4 : F4',
   'user', @CurrentUser, 'table', 'T_PHA_PHR', 'column', 'F'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : -
   1 : C1
   2 : C2
   3 : C3
   4 : C4',
   'user', @CurrentUser, 'table', 'T_PHA_PHR', 'column', 'C'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : -
   1 : I
   2 : II
   3 : III
   4 : IV',
   'user', @CurrentUser, 'table', 'T_PHA_PHR', 'column', 'RR'
go

/*==============================================================*/
/* Table: T_PHA_PHR_RECOMMENDATION                              */
/*==============================================================*/
create table T_PHA_PHR_RECOMMENDATION (
   ID_PHA_PHR_RECOMMENDATION bigint               not null,
   ID_PHA_PHR           bigint               not null,
   ID_PHA               bigint               not null,
   RECOMMENDATION       varchar(1024)        not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_PHR_RECOMMENDATION primary key (ID_PHA_PHR_RECOMMENDATION)
)
go

/*==============================================================*/
/* Index: T_PHA_PHR_RECOMMENDATION_FK                           */
/*==============================================================*/
create index T_PHA_PHR_RECOMMENDATION_FK on T_PHA_PHR_RECOMMENDATION (
ID_PHA_PHR ASC,
ID_PHA ASC
)
go

/*==============================================================*/
/* Table: T_PHA_REFERENCE                                       */
/*==============================================================*/
create table T_PHA_REFERENCE (
   ID_PHA_REFERENCE     bigint               not null,
   ID_PHA               bigint               not null,
   REFERENCE            varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_REFERENCE primary key (ID_PHA_REFERENCE)
)
go

/*==============================================================*/
/* Index: T_PHA_REFERENCE_FK                                    */
/*==============================================================*/
create index T_PHA_REFERENCE_FK on T_PHA_REFERENCE (
ID_PHA ASC
)
go

/*==============================================================*/
/* Table: T_PHA_RENCANA_KERJA                                   */
/*==============================================================*/
create table T_PHA_RENCANA_KERJA (
   ID_PHA_RENCANA_KERJA bigint               not null,
   ID_PHA               bigint               not null,
   WAKTU                datetime             not null default getdate(),
   AKTIFITAS            varchar(1024)        not null,
   KETERANGAN           varchar(512)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_RENCANA_KERJA primary key (ID_PHA_RENCANA_KERJA)
)
go

/*==============================================================*/
/* Index: T_PHA_RENCANA_KERJA_FK                                */
/*==============================================================*/
create index T_PHA_RENCANA_KERJA_FK on T_PHA_RENCANA_KERJA (
ID_PHA ASC
)
go

/*==============================================================*/
/* Table: T_PHA_STORM                                           */
/*==============================================================*/
create table T_PHA_STORM (
   ID_PHA_STORM         bigint               not null,
   ID_PHA               bigint               not null,
   RISK_SCORE           varchar(5)           not null,
   RECOMMENDATION       varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_STORM primary key (ID_PHA_STORM)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'I, II, III, IV',
   'user', @CurrentUser, 'table', 'T_PHA_STORM', 'column', 'RISK_SCORE'
go

/*==============================================================*/
/* Index: T_PHA_STORM_FK_T_PHA                                  */
/*==============================================================*/
create index T_PHA_STORM_FK_T_PHA on T_PHA_STORM (
ID_PHA ASC
)
go

/*==============================================================*/
/* Index: T_PHA_STORM_FK_R_RISK_DEFINITION                      */
/*==============================================================*/
create index T_PHA_STORM_FK_R_RISK_DEFINITION on T_PHA_STORM (
RISK_SCORE ASC
)
go

/*==============================================================*/
/* Table: T_PHA_WORK_STEPS                                      */
/*==============================================================*/
create table T_PHA_WORK_STEPS (
   ID_PHA               bigint               not null,
   ID_WORK_STEPS        int                  not null,
   STATUS               tinyint              not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_WORK_STEPS primary key (ID_PHA, ID_WORK_STEPS)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : not done
   1 : done',
   'user', @CurrentUser, 'table', 'T_PHA_WORK_STEPS', 'column', 'STATUS'
go

/*==============================================================*/
/* Table: T_PHA_WSFCA                                           */
/*==============================================================*/
create table T_PHA_WSFCA (
   ID_PHA_WSFCA         bigint               not null,
   ID_PHA               bigint               not null,
   HAZARD               varchar(512)         not null,
   HAZARD_EVENT         varchar(1024)        not null,
   QTY_RELEASE          varchar(128)         null default '',
   IMPACT               varchar(256)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PHA_WSFCA primary key (ID_PHA_WSFCA)
)
go

/*==============================================================*/
/* Index: T_PHA_WSFCA_FK                                        */
/*==============================================================*/
create index T_PHA_WSFCA_FK on T_PHA_WSFCA (
ID_PHA ASC
)
go

/*==============================================================*/
/* Table: T_PSSR                                                */
/*==============================================================*/
create table T_PSSR (
   ID_PSSR              bigint               not null,
   ID_PROJECT           bigint               not null,
   LOKASI               varchar(255)         not null,
   TANGGAL              datetime             not null default getdate(),
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PSSR primary key (ID_PSSR)
)
go

/*==============================================================*/
/* Index: T_PSSR_FK                                             */
/*==============================================================*/
create index T_PSSR_FK on T_PSSR (
ID_PROJECT ASC
)
go

/*==============================================================*/
/* Table: T_PSSR_DETAIL                                         */
/*==============================================================*/
create table T_PSSR_DETAIL (
   ID_PSSR              bigint               not null,
   ID_ITEM_DETAIL_PSSR  int                  not null,
   ID_ITEM_PSSR         int                  not null,
   ID_KATEGORI_ITEM_PSSR int                  not null,
   APPLICABLE           tinyint              not null,
   CONFIRM_OK           tinyint              not null,
   PUNCHLIST            tinyint              not null,
   KETERANGAN           varchar(512)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PSSR_DETAIL primary key (ID_PSSR, ID_ITEM_DETAIL_PSSR, ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : no
   1 : yes',
   'user', @CurrentUser, 'table', 'T_PSSR_DETAIL', 'column', 'APPLICABLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : no
   1 : yes',
   'user', @CurrentUser, 'table', 'T_PSSR_DETAIL', 'column', 'CONFIRM_OK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 : minor
   1 : major',
   'user', @CurrentUser, 'table', 'T_PSSR_DETAIL', 'column', 'PUNCHLIST'
go

/*==============================================================*/
/* Table: T_PSSR_KEANGGOTAAN                                    */
/*==============================================================*/
create table T_PSSR_KEANGGOTAAN (
   ID_PSSR              bigint               not null,
   NIPG                 varchar(20)          not null,
   ID_JABATAN_PSSR      int                  not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PSSR_KEANGGOTAAN primary key (ID_PSSR, NIPG)
)
go

/*==============================================================*/
/* Index: T_PSSR_KEANGGOTAAN_FK                                 */
/*==============================================================*/
create index T_PSSR_KEANGGOTAAN_FK on T_PSSR_KEANGGOTAAN (
ID_JABATAN_PSSR ASC
)
go

/*==============================================================*/
/* Table: T_PSSR_REFERENCE                                      */
/*==============================================================*/
create table T_PSSR_REFERENCE (
   ID_PSSR_REFERENCE    bigint               not null,
   ID_PSSR              bigint               not null,
   REFERENCE            varchar(1024)        not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PSSR_REFERENCE primary key (ID_PSSR_REFERENCE)
)
go

/*==============================================================*/
/* Index: T_PSSR_REFERENCE_FK                                   */
/*==============================================================*/
create index T_PSSR_REFERENCE_FK on T_PSSR_REFERENCE (
ID_PSSR ASC
)
go

/*==============================================================*/
/* Table: T_REPO                                                */
/*==============================================================*/
create table T_REPO (
   ID                   int                  identity,
   PID                  int                  not null default 0,
   TYPE                 tinyint              not null,
   NAME                 varchar(512)         not null,
   OWNER                varchar(20)          not null,
   GROUP_OWNER          int                  not null,
   SIZE                 int                  not null,
   PERM                 smallint             not null default 700,
   UPLOADER             varchar(20)          not null,
   UPLOAD_DATE          datetime             not null default getdate(),
   constraint PK_T_REPO primary key (ID)
)
go

/*==============================================================*/
/* Index: T_REPO_FK___USER1                                     */
/*==============================================================*/
create index T_REPO_FK___USER1 on T_REPO (
OWNER ASC
)
go

/*==============================================================*/
/* Index: T_REPO_FK___USER2                                     */
/*==============================================================*/
create index T_REPO_FK___USER2 on T_REPO (
UPLOADER ASC
)
go

/*==============================================================*/
/* Index: T_REPO_FK___GRUP_USER                                 */
/*==============================================================*/
create index T_REPO_FK___GRUP_USER on T_REPO (
GROUP_OWNER ASC
)
go

alter table R_CSM_PENILAIAN
   add constraint FK_R_CSM_FAKTOR_PENILAIAN_R_CSM_PENILAIAN foreign key (ID_FAKTOR)
      references R_CSM_FAKTOR_PENILAIAN (ID)
go

alter table R_ITEM_CA
   add constraint FK_R_KATEGORI_ITEM_CA_R_ITEM_CA foreign key (ID_KATEGORI_ITEM_CA)
      references R_KATEGORI_ITEM_CA (ID_KATEGORI_ITEM_CA)
go

alter table R_ITEM_DETAIL_PSSR
   add constraint FK_R_ITEM_PSSR_R_ITEM_DETAIL_PSSR foreign key (ID_KATEGORI_ITEM_PSSR, ID_ITEM_PSSR)
      references R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, ID_ITEM_PSSR)
go

alter table R_ITEM_PSSR
   add constraint FK_R_KATEGORI_ITEM_PSSR_R_ITEM_PSSR foreign key (ID_KATEGORI_ITEM_PSSR)
      references R_KATEGORI_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR)
go

alter table R_KONTRAKTOR
   add constraint FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR foreign key (PENAWAR_JAB)
      references R_KONTRAKTOR_JAB (ID)
go

alter table R_KONTRAKTOR
   add constraint FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR2 foreign key (PENGISI_JAB)
      references R_KONTRAKTOR_JAB (ID)
go

alter table R_KONTRAKTOR
   add constraint FK_R_KONTRAKTOR_TIPE_R_KONTRAKTOR foreign key (TIPE)
      references R_KONTRAKTOR_TIPE (ID)
go

alter table R_KONTRAKTOR_JUL
   add constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_JUL foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table R_KONTRAKTOR_KLM
   add constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_KLM foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table R_KONTRAKTOR_KLM
   add constraint FK_T_REPO_R_KONTRAKTOR_KLM foreign key (ID_REPO)
      references T_REPO (ID)
go

alter table R_KONTRAKTOR_PIM
   add constraint FK_R_KONTRAKTOR_JAB_R_KONTRAKTOR_PIM foreign key (ID_JAB)
      references R_KONTRAKTOR_JAB (ID)
go

alter table R_KONTRAKTOR_PIM
   add constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PIM foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table R_KONTRAKTOR_PSD
   add constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PSD foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table R_KONTRAKTOR_PTD
   add constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PTD foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table R_KONTRAKTOR_PUL
   add constraint FK_R_KONTRAKTOR_R_KONTRAKTOR_PUL foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table T_CHEMICAL_HAZARD
   add constraint FK_R_MATERIAL_T_CHEMICAL_HAZARD foreign key (ID_MATERIAL)
      references R_MATERIAL (ID_MATERIAL)
go

alter table T_CHEMICAL_HAZARD
   add constraint FK_R_PROPERTIES_T_CHEMICAL_HAZARD foreign key (ID_PROPERTIES)
      references R_PROPERTIES (ID_PROPERTIES)
go

alter table T_CIM
   add constraint FK_R_MATERIAL_INTERACTION_T_CIM foreign key (ID_MATERIAL_INTERACTION)
      references R_MATERIAL_INTERACTION (ID_MATERIAL_INTERACTION)
go

alter table T_CIM
   add constraint FK_R_MATERIAL_T_CIM foreign key (ID_MATERIAL)
      references R_MATERIAL (ID_MATERIAL)
go

alter table T_CSM_PROYEK
   add constraint FK_R_KONTRAKTOR_T_CSM_PROYEK foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table T_CSM_PROYEK
   add constraint FK_R_PROJECT_T_CSM_PROYEK foreign key (ID_PROJECT)
      references R_PROJECT (ID_PROJECT)
go

alter table T_CSM_PROYEK_KONTRAKTOR
   add constraint FK_R_KONTRAKTOR_T_CSM_PROYEK_KONTRAKTOR foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table T_CSM_PROYEK_KONTRAKTOR
   add constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONTRAKTOR foreign key (ID_PROJECT)
      references T_CSM_PROYEK (ID_PROJECT)
go

alter table T_CSM_PROYEK_KONT_EVAL
   add constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_EVAL foreign key (ID_PROJECT)
      references T_CSM_PROYEK (ID_PROJECT)
go

alter table T_CSM_PROYEK_KONT_EVAL_NILAI
   add constraint FK_R_CSM_PERF_EVAL_T_CSM_PROYEK_KONT_EVAL_NILAI foreign key (ID_EVALUASI)
      references R_CSM_PERF_EVAL (ID)
go

alter table T_CSM_PROYEK_KONT_EVAL_NILAI
   add constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_EVAL_NILAI foreign key (ID_PROJECT)
      references T_CSM_PROYEK (ID_PROJECT)
go

alter table T_CSM_PROYEK_KONT_NILAI
   add constraint FK_R_CSM_PENILAIAN_T_CSM_PROYEK_KONT_NILAI foreign key (ID_PENILAIAN)
      references R_CSM_PENILAIAN (ID)
go

alter table T_CSM_PROYEK_KONT_NILAI
   add constraint FK_R_KONTRAKTOR_T_CSM_PROYEK_KONT_NILAI foreign key (ID_KONTRAKTOR)
      references R_KONTRAKTOR (ID)
go

alter table T_CSM_PROYEK_KONT_NILAI
   add constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_NILAI foreign key (ID_PROJECT)
      references T_CSM_PROYEK (ID_PROJECT)
go

alter table T_LINGKUNGAN
   add constraint FK_R_SEKSI_T_LINGKUNGAN foreign key (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
go

alter table T_LINGKUNGAN_BULANAN_DETAIL
   add constraint FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL foreign key (TAHUN, BULAN)
      references T_LINGKUNGAN_BULANAN (TAHUN, BULAN)
go

alter table T_LINGKUNGAN_DETAIL
   add constraint FK_R_KOMPONEN_LINGKUNGAN_T_LINGKUNGAN_DETAIL foreign key (ID_KOMPONEN_LINGKUNGAN)
      references R_KOMPONEN_LINGKUNGAN (ID_KOMPONEN_LINGKUNGAN)
go

alter table T_LINGKUNGAN_DETAIL
   add constraint FK_T_LINGKUNGAN_T_LINGKUNGAN_DETAIL foreign key (ID_LINGKUNGAN_TAHUNAN)
      references T_LINGKUNGAN (ID_LINGKUNGAN_TAHUNAN)
go

alter table T_PHA
   add constraint FK_R_PROJECT_T_PHA foreign key (ID_PROJECT)
      references R_PROJECT (ID_PROJECT)
go

alter table T_PHA_CA
   add constraint FK_R_ITEM_CA_T_PHA_CA foreign key (ID_ITEM_CA, ID_KATEGORI_ITEM_CA)
      references R_ITEM_CA (ID_ITEM_CA, ID_KATEGORI_ITEM_CA)
go

alter table T_PHA_CA
   add constraint FK_T_PHA_T_PHA_CA foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_CHEMICAL_HAZARD
   add constraint FK_R_MATERIAL_T_PHA_CHEMICAL_HAZARD foreign key (ID_MATERIAL)
      references R_MATERIAL (ID_MATERIAL)
go

alter table T_PHA_CHEMICAL_HAZARD
   add constraint FK_T_PHA_T_PHA_CHEMICAL_HAZARD foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_FACILITY_SITTING
   add constraint FK_T_PHA_T_PHA_FACILITY_SITTING foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_FIELD_TOUR
   add constraint FK_T_PHA_T_PHA_FIELD_TOUR foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_HAZARD_PRESSURE
   add constraint FK_R_HAZARD_PRESSURE_T_PHA_HAZARD_PRESSURE foreign key (ID_HAZARD_PRESSURE)
      references R_HAZARD_PRESSURE (ID_HAZARD_PRESSURE)
go

alter table T_PHA_HAZARD_PRESSURE
   add constraint FK_T_PHA_T_PHA_HAZARD_PRESSURE foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_HAZARD_PROCESS
   add constraint FK_R_HAZARD_PROCESS_T_PHA_HAZARD_PROCESS foreign key (ID_HAZARD_PROCESS)
      references R_HAZARD_PROCESS (ID_HAZARD_PROCESS)
go

alter table T_PHA_HAZARD_PROCESS
   add constraint FK_T_PHA_T_PHA_HAZARD_PROCESS foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_HUMAN_FACTOR
   add constraint FK_T_PHA_T_PHA_HUMAN_FACTOR foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_KEANGGOTAAN
   add constraint FK_R_JABATAN_PHA_T_PHA_KEANGGOTAAN foreign key (ID_JABATAN_PHA)
      references R_JABATAN_PHA (ID_JABATAN_PHA)
go

alter table T_PHA_KEANGGOTAAN
   add constraint FK_R_PEGAWAI_T_PHA_KEANGGOTAAN foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_PHA_KEANGGOTAAN
   add constraint FK_T_PHA_T_PHA_KEANGGOTAAN foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_PHR
   add constraint FK_T_PHA_T_PHA_PHR foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_PHR_RECOMMENDATION
   add constraint FK_T_PHA_PHR_T_PHA_PHR_RECOMMENDATION foreign key (ID_PHA_PHR, ID_PHA)
      references T_PHA_PHR (ID_PHA_PHR, ID_PHA)
go

alter table T_PHA_REFERENCE
   add constraint FK_T_PHA_T_PHA_REFERENCES foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_RENCANA_KERJA
   add constraint FK_T_PHA_T_PHA_RENCANA_KERJA foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_STORM
   add constraint FK_R_RISK_DEFINITION_T_PHA_STORM foreign key (RISK_SCORE)
      references R_RISK_DEFINITION (RISK_SCORE)
go

alter table T_PHA_STORM
   add constraint FK_T_PHA_T_PHA_STORM foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_WORK_STEPS
   add constraint FK_R_WORK_STEPS_T_PHA_WORK_STEPS foreign key (ID_WORK_STEPS)
      references R_WORK_STEPS (ID_WORK_STEPS)
go

alter table T_PHA_WORK_STEPS
   add constraint FK_T_PHA_T_PHA_WORK_STEPS foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PHA_WSFCA
   add constraint FK_T_PHA_T_PHA_WSFCA foreign key (ID_PHA)
      references T_PHA (ID_PHA)
go

alter table T_PSSR
   add constraint FK_R_PROJECT_T_PSSR foreign key (ID_PROJECT)
      references R_PROJECT (ID_PROJECT)
go

alter table T_PSSR_DETAIL
   add constraint FK_R_ITEM_DETAIL_PSSR_T_PSSR_DETAIL foreign key (ID_ITEM_DETAIL_PSSR, ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR)
      references R_ITEM_DETAIL_PSSR (ID_ITEM_DETAIL_PSSR, ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR)
go

alter table T_PSSR_DETAIL
   add constraint FK_T_PSSR_T_PSSR_DETAIL foreign key (ID_PSSR)
      references T_PSSR (ID_PSSR)
go

alter table T_PSSR_KEANGGOTAAN
   add constraint FK_R_JABATAN_PSSR_T_PSSR_KEANGGOTAAN foreign key (ID_JABATAN_PSSR)
      references R_JABATAN_PSSR (ID_JABATAN_PSSR)
go

alter table T_PSSR_KEANGGOTAAN
   add constraint FK_R_PEGAWAI_T_PSSR_KEANGGOTAAN foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_PSSR_KEANGGOTAAN
   add constraint FK_T_PSSR_T_PSSR_KEANGGOTAAN foreign key (ID_PSSR)
      references T_PSSR (ID_PSSR)
go

alter table T_PSSR_REFERENCE
   add constraint FK_T_PSSR_T_PSSR_REFERENCE foreign key (ID_PSSR)
      references T_PSSR (ID_PSSR)
go

alter table T_REPO
   add constraint FK___GRUP_USER_T_REPO foreign key (GROUP_OWNER)
      references __GRUP_USER (ID_GRUP)
go

alter table T_REPO
   add constraint FK___USER_T_REPO foreign key (OWNER)
      references __USER (NIPG)
go

alter table T_REPO
   add constraint FK___USER_T_REPO2 foreign key (UPLOADER)
      references __USER (NIPG)
go


create function FN_REPO_GET_PATH
(
    @id     int
,   @path   varchar(1024)
)
RETURNS varchar(1024)
begin
	while @id != 0
	begin
		select	@path	= name +'/'+ @path
		,		@id		= pid
		from	t_repo
		where	id		= @id;
	end;

	return @path;
end
go


create trigger T_PHA_AIR
on T_PHA 
after insert
as
begin
	set NOCOUNT on;

	declare	@id_pha		bigint
	declare	@id_user	varchar(20)
    declare @status     tinyint
	
	select	@id_pha		= (select ID_PHA	from  inserted)
	select	@id_user	= (select ID_USER	from  inserted)
    select  @status     = 0

	insert into T_PHA_WORK_STEPS (ID_PHA, ID_WORK_STEPS, STATUS, ID_USER)
	select	@id_pha
		,	ID_WORK_STEPS
        ,   @status
		,	@id_user
	from	R_WORK_STEPS
end
go


create trigger T_PHA_CA_ADR
on T_PHA_CA
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_CA
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 8
    end
end
go


create trigger T_PHA_CA_AIR
on T_PHA_CA
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 8
end
go


create trigger T_PHA_CHEMICAL_HAZARD_ADR
on T_PHA_CHEMICAL_HAZARD
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_CHEMICAL_HAZARD
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 6
    end
end
go


create trigger T_PHA_CHEMICAL_HAZARD_AIR
on T_PHA_CHEMICAL_HAZARD
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 6
end
go


create trigger T_PHA_FACILITY_SITTING_ADR
on T_PHA_FACILITY_SITTING
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_FACILITY_SITTING
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 10
    end
end
go


create trigger T_PHA_FACILITY_SITTING_AIR
on T_PHA_FACILITY_SITTING
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 10
end
go


create trigger T_PHA_FIELD_TOUR_ADR
on T_PHA_FIELD_TOUR
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_FIELD_TOUR
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 5
    end
end
go


create trigger T_PHA_FIELD_TOUR_AIR
on T_PHA_FIELD_TOUR
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 5
end
go


create trigger T_PHA_HAZARD_PRESSURE_ADR
on T_PHA_HAZARD_PRESSURE
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_HAZARD_PRESSURE
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 4
    end
end
go


create trigger T_PHA_HAZARD_PRESSURE_AIR
on T_PHA_HAZARD_PRESSURE
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 4
end
go


create trigger T_PHA_HAZARD_PROCESS_ADR
on T_PHA_HAZARD_PROCESS
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_HAZARD_PROCESS
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 3
    end
end
go


create trigger T_PHA_HAZARD_PROCESS_AIR
on T_PHA_HAZARD_PROCESS
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 3
end
go


create trigger T_PHA_HUMAN_FACTOR_ADR
on T_PHA_HUMAN_FACTOR
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_HUMAN_FACTOR
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 11
    end
end
go


create trigger T_PHA_HUMAN_FACTOR_AIR
on T_PHA_HUMAN_FACTOR
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 11
end
go


create trigger T_PHA_KEANGGOTAAN_ADR
on T_PHA_KEANGGOTAAN
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_KEANGGOTAAN
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 2
    end
end
go


create trigger T_PHA_KEANGGOTAAN_AIR
on T_PHA_KEANGGOTAAN
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 2
end
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


create trigger T_PHA_REFERENCE_ADR
on T_PHA_REFERENCE
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_REFERENCE
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 13
    end
end
go


create trigger T_PHA_REFERENCE_AIR
on T_PHA_REFERENCE
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 13
end
go


create trigger T_PHA_RENCANA_KERJA_ADR
on T_PHA_RENCANA_KERJA
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_RENCANA_KERJA
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 1
    end
end
go


create trigger T_PHA_RENCANA_KERJA_AIR
on T_PHA_RENCANA_KERJA
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 1
end
go


create trigger T_PHA_STORM_ADR
on T_PHA_STORM
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_STORM
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 12
    end
end
go


create trigger T_PHA_STORM_AIR
on T_PHA_STORM
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 12
end
go


create trigger T_PHA_WSFCA_ADR
on T_PHA_WSFCA
after delete
as
begin
    declare @id_pha bigint
    declare @jumlah int
    
    select  @id_pha = (select ID_PHA from deleted)
    
    select  @jumlah = count(*)
    from    T_PHA_WSFCA
    where   ID_PHA  = @id_pha
    
    if (@jumlah = 0)
    begin
        update  T_PHA_WORK_STEPS
        set     STATUS = 0
        where   ID_PHA          = @id_pha
        and     ID_WORK_STEPS   = 7
    end
end
go


create trigger T_PHA_WSFCA_AIR
on T_PHA_WSFCA
after insert
as
begin
    declare @id_pha bigint
    
    select  @id_pha = (select ID_PHA from inserted)
    
    update  T_PHA_WORK_STEPS
    set     STATUS = 1
    where   ID_PHA          = @id_pha
    and     ID_WORK_STEPS   = 7
end
go

