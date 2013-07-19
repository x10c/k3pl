/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     5/26/2011 3:10:37 PM                         */
/*==============================================================*/


if exists (select 1
          from sysobjects
          where id = object_id('T_PTW_AIR')
          and type = 'TR')
   drop trigger T_PTW_AIR
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_DEP_PART_MONTHLY')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_DEP_PART_MONTHLY
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_PEG_PART_MONTHLY')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_PEG_PART_MONTHLY
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_RCA_PARTISIPASI_ALL')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_RCA_PARTISIPASI_ALL
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_RCA_PARTISIPASI_DEP')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_RCA_PARTISIPASI_DEP
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_RCA_TARGET_ALL')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_RCA_TARGET_ALL
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_RCA_TARGET_DEP')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_RCA_TARGET_DEP
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_RCA_TARGET_YEAR')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_RCA_TARGET_YEAR
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_OBS_TIME_ALL')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_OBS_TIME_ALL
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_OBS_TIME_DEP')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_OBS_TIME_DEP
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_OBS_TIME_YEAR')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_OBS_TIME_YEAR
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_PARTISIPASI_ALL')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_PARTISIPASI_ALL
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_PARTISIPASI_DEP')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_PARTISIPASI_DEP
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_TARGET_ALL')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_TARGET_ALL
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_TARGET_DEP')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_TARGET_DEP
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_STOP_TARGET_YEAR')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_STOP_TARGET_YEAR
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_TEMUAN_45_ALL')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_TEMUAN_45_ALL
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_TEMUAN_45_DEP')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_TEMUAN_45_DEP
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_TEMUAN_45_YEAR')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_TEMUAN_45_YEAR
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_TEMUAN_ALL')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_TEMUAN_ALL
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_TEMUAN_DEP')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_TEMUAN_DEP
go

if exists (select 1
          from sysobjects
          where  id = object_id('FN_GET_TEMUAN_YEAR')
          and type in ('IF', 'FN', 'TF'))
   drop function FN_GET_TEMUAN_YEAR
go

if exists (select 1
          from sysobjects
          where  id = object_id('SP_HISTORY')
          and type in ('P','PC'))
   drop procedure SP_HISTORY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DETAIL_TIPE_OBSERVASI') and o.name = 'FK_R_TIPE_OBSERVASI_R_DETAIL_TIPE_OBSERVASI')
alter table R_DETAIL_TIPE_OBSERVASI
   drop constraint FK_R_TIPE_OBSERVASI_R_DETAIL_TIPE_OBSERVASI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_DINAS') and o.name = 'FK_R_DEPARTEMEN_R_DINAS')
alter table R_DINAS
   drop constraint FK_R_DEPARTEMEN_R_DINAS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_JABATAN_KOMITE_SUB_KOMITE') and o.name = 'FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE')
alter table R_JABATAN_KOMITE_SUB_KOMITE
   drop constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PEGAWAI') and o.name = 'FK_R_JABATAN_R_PEGAWAI')
alter table R_PEGAWAI
   drop constraint FK_R_JABATAN_R_PEGAWAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PEGAWAI') and o.name = 'FK_R_KLASIFIKASI_PEGAWAI_R_PEGAWAI')
alter table R_PEGAWAI
   drop constraint FK_R_KLASIFIKASI_PEGAWAI_R_PEGAWAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PEGAWAI') and o.name = 'FK_R_SEKSI_R_PEGAWAI')
alter table R_PEGAWAI
   drop constraint FK_R_SEKSI_R_PEGAWAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('R_PELATIHAN') and o.name = 'FK_R_PELATIHAN_KELOMPOK_R_PELATIHAN')
alter table R_PELATIHAN
   drop constraint FK_R_PELATIHAN_KELOMPOK_R_PELATIHAN
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
   where r.fkeyid = object_id('R_TIPE_OBSERVASI') and o.name = 'FK_R_KELOMPOK_TIPE_OBSERVASI_R_TIPE_OBSERVASI')
alter table R_TIPE_OBSERVASI
   drop constraint FK_R_KELOMPOK_TIPE_OBSERVASI_R_TIPE_OBSERVASI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_AREA_PERHATIAN_DETAIL') and o.name = 'FK_R_TIPE_AREA_PERHATIAN_T_AREA_PERHATIAN_DETAIL')
alter table T_AREA_PERHATIAN_DETAIL
   drop constraint FK_R_TIPE_AREA_PERHATIAN_T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_AREA_PERHATIAN_DETAIL') and o.name = 'FK_R_WILAYAH_T_AREA_PERHATIAN_DETAIL')
alter table T_AREA_PERHATIAN_DETAIL
   drop constraint FK_R_WILAYAH_T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_AREA_PERHATIAN_DETAIL') and o.name = 'FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL')
alter table T_AREA_PERHATIAN_DETAIL
   drop constraint FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_INSIDEN') and o.name = 'FK_R_KLASIFIKASI_PEGAWAI_T_INSIDEN')
alter table T_INSIDEN
   drop constraint FK_R_KLASIFIKASI_PEGAWAI_T_INSIDEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_INSIDEN') and o.name = 'FK_R_SEKSI_T_INSIDEN')
alter table T_INSIDEN
   drop constraint FK_R_SEKSI_T_INSIDEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_JSA_DETAIL') and o.name = 'FK_T_JSA_T_JSA_DETAIL')
alter table T_JSA_DETAIL
   drop constraint FK_T_JSA_T_JSA_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_KEGIATAN_DETAIL') and o.name = 'FK_R_TIPE_KEGIATAN_T_KEGIATAN_DETAIL')
alter table T_KEGIATAN_DETAIL
   drop constraint FK_R_TIPE_KEGIATAN_T_KEGIATAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_KEGIATAN_DETAIL') and o.name = 'FK_R_WILAYAH_T_KEGIATAN_DETAIL')
alter table T_KEGIATAN_DETAIL
   drop constraint FK_R_WILAYAH_T_KEGIATAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_KEGIATAN_DETAIL') and o.name = 'FK_T_KEGIATAN_T_KEGIATAN_DETAIL')
alter table T_KEGIATAN_DETAIL
   drop constraint FK_T_KEGIATAN_T_KEGIATAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PEGAWAI_KOMITE_SUB_KOMITE') and o.name = 'FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE')
alter table T_PEGAWAI_KOMITE_SUB_KOMITE
   drop constraint FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PEGAWAI_KOMITE_SUB_KOMITE') and o.name = 'FK_R_PEGAWAI_T_PEGAWAI_KOMITE')
alter table T_PEGAWAI_KOMITE_SUB_KOMITE
   drop constraint FK_R_PEGAWAI_T_PEGAWAI_KOMITE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PELATIHAN') and o.name = 'FK_R_PELATIHAN_T_PELATIHAN')
alter table T_PELATIHAN
   drop constraint FK_R_PELATIHAN_T_PELATIHAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PELATIHAN_PESERTA') and o.name = 'FK_R_PEGAWAI_T_PELATIHAN_PESERTA')
alter table T_PELATIHAN_PESERTA
   drop constraint FK_R_PEGAWAI_T_PELATIHAN_PESERTA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PELATIHAN_PESERTA') and o.name = 'FK_T_PELATIHAN_T_PELATIHAN_PESERTA')
alter table T_PELATIHAN_PESERTA
   drop constraint FK_T_PELATIHAN_T_PELATIHAN_PESERTA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PENGELOLAAN_LINGKUNGAN') and o.name = 'FK_R_WILAYAH_T_PENGELOLAAN_LINGKUNGAN')
alter table T_PENGELOLAAN_LINGKUNGAN
   drop constraint FK_R_WILAYAH_T_PENGELOLAAN_LINGKUNGAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PIC_RAPAT_MATERI') and o.name = 'FK_T_RAPAT_MATERI_T_PIC_RAPAT_MATERI')
alter table T_PIC_RAPAT_MATERI
   drop constraint FK_T_RAPAT_MATERI_T_PIC_RAPAT_MATERI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PIC_RAPAT_SUB_MATERI') and o.name = 'FK_T_RAPAT_SUB_MATERI_T_PIC_RAPAT_SUB_MATERI')
alter table T_PIC_RAPAT_SUB_MATERI
   drop constraint FK_T_RAPAT_SUB_MATERI_T_PIC_RAPAT_SUB_MATERI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW') and o.name = 'FK_T_JSA_T_PTW')
alter table T_PTW
   drop constraint FK_T_JSA_T_PTW
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_ALAT_PELINDUNG_DIRI') and o.name = 'FK_R_ALAT_PELINDUNG_DIRI_PTW')
alter table T_PTW_ALAT_PELINDUNG_DIRI
   drop constraint FK_R_ALAT_PELINDUNG_DIRI_PTW
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_ALAT_PELINDUNG_DIRI') and o.name = 'FK_T_PTW_T_PTW_ALAT_PELINDUNG_DIRI_PTW')
alter table T_PTW_ALAT_PELINDUNG_DIRI
   drop constraint FK_T_PTW_T_PTW_ALAT_PELINDUNG_DIRI_PTW
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_JENIS_PEKERJAAN') and o.name = 'FK_R_JENIS_PEKERJAAN_PTW_T_PTW_JENIS_PEKERJAAN')
alter table T_PTW_JENIS_PEKERJAAN
   drop constraint FK_R_JENIS_PEKERJAAN_PTW_T_PTW_JENIS_PEKERJAAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_JENIS_PEKERJAAN') and o.name = 'FK_T_PTW_T_PTW_JENIS_PEKERJAAN')
alter table T_PTW_JENIS_PEKERJAAN
   drop constraint FK_T_PTW_T_PTW_JENIS_PEKERJAAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_SAFETY_CHECKLIST') and o.name = 'FK_R_SAFETY_CHECKLIST_PTW_T_PTW_SAFETY_CHECKLIST')
alter table T_PTW_SAFETY_CHECKLIST
   drop constraint FK_R_SAFETY_CHECKLIST_PTW_T_PTW_SAFETY_CHECKLIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_SAFETY_CHECKLIST') and o.name = 'FK_T_PTW_T_PTW_SAFETY_CHECKLIST')
alter table T_PTW_SAFETY_CHECKLIST
   drop constraint FK_T_PTW_T_PTW_SAFETY_CHECKLIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_SBAK') and o.name = 'FK_R_SBAK_PTW_T_PTW_SBAK')
alter table T_PTW_SBAK
   drop constraint FK_R_SBAK_PTW_T_PTW_SBAK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_SBAK') and o.name = 'FK_T_PTW_T_PTW_SBAK')
alter table T_PTW_SBAK
   drop constraint FK_T_PTW_T_PTW_SBAK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_UJI_KANDUNGAN_GAS') and o.name = 'FK_R_UJI_KANDUNGAN_GAS_PTW_T_PTW_UJI_KANDUNGAN_GAS')
alter table T_PTW_UJI_KANDUNGAN_GAS
   drop constraint FK_R_UJI_KANDUNGAN_GAS_PTW_T_PTW_UJI_KANDUNGAN_GAS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_UJI_KANDUNGAN_GAS') and o.name = 'FK_T_PTW_T_PTW_UJI_KANDUNGAN_GAS')
alter table T_PTW_UJI_KANDUNGAN_GAS
   drop constraint FK_T_PTW_T_PTW_UJI_KANDUNGAN_GAS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_PTW_VALIDASI') and o.name = 'FK_T_PTW_T_PTW_VALIDASI')
alter table T_PTW_VALIDASI
   drop constraint FK_T_PTW_T_PTW_VALIDASI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT') and o.name = 'FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT')
alter table T_RAPAT
   drop constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE') and o.name = 'FK_T_PEGAWAI_KOMITE_T_RAPAT_ABSENSI_KOMITE')
alter table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE
   drop constraint FK_T_PEGAWAI_KOMITE_T_RAPAT_ABSENSI_KOMITE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE') and o.name = 'FK_T_RAPAT_T_RAPAT_ABSENSI_KOMITE')
alter table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE
   drop constraint FK_T_RAPAT_T_RAPAT_ABSENSI_KOMITE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT_MATERI') and o.name = 'FK_T_RAPAT_T_RAPAT_MATERI')
alter table T_RAPAT_MATERI
   drop constraint FK_T_RAPAT_T_RAPAT_MATERI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT_SUB_MATERI') and o.name = 'FK_T_RAPAT_MATERI_T_RAPAT_SUB_MATERI')
alter table T_RAPAT_SUB_MATERI
   drop constraint FK_T_RAPAT_MATERI_T_RAPAT_SUB_MATERI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RCA_AUDITOR') and o.name = 'FK_R_PEGAWAI_T_RCA_AUDITOR')
alter table T_RCA_AUDITOR
   drop constraint FK_R_PEGAWAI_T_RCA_AUDITOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RCA_AUDITOR') and o.name = 'FK_T_RCA_T_RCA_AUDITOR')
alter table T_RCA_AUDITOR
   drop constraint FK_T_RCA_T_RCA_AUDITOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RCA_DETAIL') and o.name = 'FK_R_SEVERITY_T_RCA_DETAIL')
alter table T_RCA_DETAIL
   drop constraint FK_R_SEVERITY_T_RCA_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RCA_DETAIL') and o.name = 'FK_T_RCA_T_RCA_DETAIL')
alter table T_RCA_DETAIL
   drop constraint FK_T_RCA_T_RCA_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RCA_TARGET_PEGAWAI') and o.name = 'FK_R_PEGAWAI_T_RCA_TARGET_PEGAWAI')
alter table T_RCA_TARGET_PEGAWAI
   drop constraint FK_R_PEGAWAI_T_RCA_TARGET_PEGAWAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP') and o.name = 'FK_R_PEGAWAI_T_STOP')
alter table T_STOP
   drop constraint FK_R_PEGAWAI_T_STOP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP') and o.name = 'FK_R_SEKSI_T_STOP')
alter table T_STOP
   drop constraint FK_R_SEKSI_T_STOP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP_DETAIL') and o.name = 'FK_R_DETAIL_TIPE_OBSERVASI_T_STOP_DETAIL')
alter table T_STOP_DETAIL
   drop constraint FK_R_DETAIL_TIPE_OBSERVASI_T_STOP_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP_DETAIL') and o.name = 'FK_T_STOP_T_STOP_DETAIL')
alter table T_STOP_DETAIL
   drop constraint FK_T_STOP_T_STOP_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_STOP_TARGET_PEGAWAI') and o.name = 'FK_R_PEGAWAI_T_STOP_TARGET_PEGAWAI')
alter table T_STOP_TARGET_PEGAWAI
   drop constraint FK_R_PEGAWAI_T_STOP_TARGET_PEGAWAI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_UNJUK_KERJA') and o.name = 'FK_R_KLASIFIKASI_PEGAWAI_T_UNJUK_KERJA')
alter table T_UNJUK_KERJA
   drop constraint FK_R_KLASIFIKASI_PEGAWAI_T_UNJUK_KERJA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('__HAK_AKSES') and o.name = 'FK___GRUP_USER___HAK_AKSES')
alter table __HAK_AKSES
   drop constraint FK___GRUP_USER___HAK_AKSES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('__HAK_AKSES') and o.name = 'FK___MENU___HAK_AKSES')
alter table __HAK_AKSES
   drop constraint FK___MENU___HAK_AKSES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('__LOG') and o.name = 'FK___USER___LOG')
alter table __LOG
   drop constraint FK___USER___LOG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('__USER') and o.name = 'FK_R_PEGAWAI___USER')
alter table __USER
   drop constraint FK_R_PEGAWAI___USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('__USER_GRUP') and o.name = 'FK___GRUP_USER___USER_GRUP')
alter table __USER_GRUP
   drop constraint FK___GRUP_USER___USER_GRUP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('__USER_GRUP') and o.name = 'FK___USER___USER_GRUP')
alter table __USER_GRUP
   drop constraint FK___USER___USER_GRUP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('V_SEVERITY')
            and   type = 'V')
   drop view V_SEVERITY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_ALAT_PELINDUNG_DIRI_PTW')
            and   type = 'U')
   drop table R_ALAT_PELINDUNG_DIRI_PTW
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DEPARTEMEN')
            and   type = 'U')
   drop table R_DEPARTEMEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_DETAIL_TIPE_OBSERVASI')
            and   name  = 'R_DETAIL_TIPE_OBSERVASI_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_DETAIL_TIPE_OBSERVASI.R_DETAIL_TIPE_OBSERVASI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_DETAIL_TIPE_OBSERVASI')
            and   type = 'U')
   drop table R_DETAIL_TIPE_OBSERVASI
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

if exists (select 1
            from  sysobjects
           where  id = object_id('R_JABATAN')
            and   type = 'U')
   drop table R_JABATAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_JABATAN_KOMITE_SUB_KOMITE')
            and   name  = 'R_JABATAN_KOMITE_SUB_KOMITE_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_JABATAN_KOMITE_SUB_KOMITE.R_JABATAN_KOMITE_SUB_KOMITE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_JABATAN_KOMITE_SUB_KOMITE')
            and   type = 'U')
   drop table R_JABATAN_KOMITE_SUB_KOMITE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_JENIS_PEKERJAAN_PTW')
            and   type = 'U')
   drop table R_JENIS_PEKERJAAN_PTW
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_K3PL')
            and   type = 'U')
   drop table R_K3PL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KELOMPOK_TIPE_OBSERVASI')
            and   type = 'U')
   drop table R_KELOMPOK_TIPE_OBSERVASI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KEL_JABATAN_KOMITE_SUB_KOMITE')
            and   type = 'U')
   drop table R_KEL_JABATAN_KOMITE_SUB_KOMITE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_KLASIFIKASI_PEGAWAI')
            and   type = 'U')
   drop table R_KLASIFIKASI_PEGAWAI
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
            from  sysindexes
           where  id    = object_id('R_PEGAWAI')
            and   name  = 'R_PEGAWAI_FK_R_JABATAN'
            and   indid > 0
            and   indid < 255)
   drop index R_PEGAWAI.R_PEGAWAI_FK_R_JABATAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_PEGAWAI')
            and   name  = 'R_PEGAWAI_FK_R_KLASIFIKASI_PEGAWAI'
            and   indid > 0
            and   indid < 255)
   drop index R_PEGAWAI.R_PEGAWAI_FK_R_KLASIFIKASI_PEGAWAI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_PEGAWAI')
            and   type = 'U')
   drop table R_PEGAWAI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_PELATIHAN')
            and   name  = 'R_PELATIHAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_PELATIHAN.R_PELATIHAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_PELATIHAN')
            and   type = 'U')
   drop table R_PELATIHAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_PELATIHAN_KELOMPOK')
            and   type = 'U')
   drop table R_PELATIHAN_KELOMPOK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_SAFETY_CHECKLIST_PTW')
            and   type = 'U')
   drop table R_SAFETY_CHECKLIST_PTW
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_SBAK_PTW')
            and   type = 'U')
   drop table R_SBAK_PTW
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

if exists (select 1
            from  sysobjects
           where  id = object_id('R_SEVERITY')
            and   type = 'U')
   drop table R_SEVERITY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_TIPE_AREA_PERHATIAN')
            and   type = 'U')
   drop table R_TIPE_AREA_PERHATIAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_TIPE_KEGIATAN')
            and   type = 'U')
   drop table R_TIPE_KEGIATAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('R_TIPE_OBSERVASI')
            and   name  = 'R_TIPE_OBSERVASI_FK'
            and   indid > 0
            and   indid < 255)
   drop index R_TIPE_OBSERVASI.R_TIPE_OBSERVASI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_TIPE_OBSERVASI')
            and   type = 'U')
   drop table R_TIPE_OBSERVASI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_UJI_KANDUNGAN_GAS_PTW')
            and   type = 'U')
   drop table R_UJI_KANDUNGAN_GAS_PTW
go

if exists (select 1
            from  sysobjects
           where  id = object_id('R_WILAYAH')
            and   type = 'U')
   drop table R_WILAYAH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_AREA_PERHATIAN_DETAIL')
            and   name  = 'T_AREA_PERHATIAN_DETAIL_FK_R_TIPE_AREA_PERHATIAN'
            and   indid > 0
            and   indid < 255)
   drop index T_AREA_PERHATIAN_DETAIL.T_AREA_PERHATIAN_DETAIL_FK_R_TIPE_AREA_PERHATIAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_AREA_PERHATIAN_DETAIL')
            and   name  = 'T_AREA_PERHATIAN_DETAIL_FK_T_KEGIATAN'
            and   indid > 0
            and   indid < 255)
   drop index T_AREA_PERHATIAN_DETAIL.T_AREA_PERHATIAN_DETAIL_FK_T_KEGIATAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_AREA_PERHATIAN_DETAIL')
            and   name  = 'T_AREA_PERHATIAN_DETAIL_FK_R_WILAYAH'
            and   indid > 0
            and   indid < 255)
   drop index T_AREA_PERHATIAN_DETAIL.T_AREA_PERHATIAN_DETAIL_FK_R_WILAYAH
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_AREA_PERHATIAN_DETAIL')
            and   type = 'U')
   drop table T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_HOME_GALLERY')
            and   type = 'U')
   drop table T_HOME_GALLERY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_HOME_NEWS')
            and   type = 'U')
   drop table T_HOME_NEWS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_INSIDEN')
            and   name  = 'T_INSIDEN_FK_R_KLASIFIKASI_PEGAWAI'
            and   indid > 0
            and   indid < 255)
   drop index T_INSIDEN.T_INSIDEN_FK_R_KLASIFIKASI_PEGAWAI
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
            from  sysobjects
           where  id = object_id('T_INSIDEN')
            and   type = 'U')
   drop table T_INSIDEN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_JSA')
            and   type = 'U')
   drop table T_JSA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_JSA_DETAIL')
            and   type = 'U')
   drop table T_JSA_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN')
            and   type = 'U')
   drop table T_KEGIATAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_KEGIATAN_DETAIL')
            and   name  = 'T_KEGIATAN_DETAIL_FK_R_TIPE_KEGIATAN'
            and   indid > 0
            and   indid < 255)
   drop index T_KEGIATAN_DETAIL.T_KEGIATAN_DETAIL_FK_R_TIPE_KEGIATAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_KEGIATAN_DETAIL')
            and   name  = 'T_KEGIATAN_DETAIL_FK_R_WILAYAH'
            and   indid > 0
            and   indid < 255)
   drop index T_KEGIATAN_DETAIL.T_KEGIATAN_DETAIL_FK_R_WILAYAH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_KEGIATAN_DETAIL')
            and   name  = 'T_KEGIATAN_DETAIL_FK_T_KEGIATAN'
            and   indid > 0
            and   indid < 255)
   drop index T_KEGIATAN_DETAIL.T_KEGIATAN_DETAIL_FK_T_KEGIATAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN_DETAIL')
            and   type = 'U')
   drop table T_KEGIATAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PEGAWAI_KOMITE_SUB_KOMITE')
            and   type = 'U')
   drop table T_PEGAWAI_KOMITE_SUB_KOMITE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PELATIHAN')
            and   name  = 'T_PELATIHAN_FK_R_PELATIHAN'
            and   indid > 0
            and   indid < 255)
   drop index T_PELATIHAN.T_PELATIHAN_FK_R_PELATIHAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PELATIHAN')
            and   type = 'U')
   drop table T_PELATIHAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PELATIHAN_PESERTA')
            and   type = 'U')
   drop table T_PELATIHAN_PESERTA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PENGELOLAAN_LINGKUNGAN')
            and   name  = 'T_PENGELOLAAN_LINGKUNGAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PENGELOLAAN_LINGKUNGAN.T_PENGELOLAAN_LINGKUNGAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PENGELOLAAN_LINGKUNGAN')
            and   type = 'U')
   drop table T_PENGELOLAAN_LINGKUNGAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PIC_RAPAT_MATERI')
            and   type = 'U')
   drop table T_PIC_RAPAT_MATERI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PIC_RAPAT_SUB_MATERI')
            and   type = 'U')
   drop table T_PIC_RAPAT_SUB_MATERI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PTW')
            and   name  = 'T_PTW_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PTW.T_PTW_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PTW')
            and   type = 'U')
   drop table T_PTW
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PTW_ALAT_PELINDUNG_DIRI')
            and   type = 'U')
   drop table T_PTW_ALAT_PELINDUNG_DIRI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PTW_JENIS_PEKERJAAN')
            and   type = 'U')
   drop table T_PTW_JENIS_PEKERJAAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PTW_SAFETY_CHECKLIST')
            and   type = 'U')
   drop table T_PTW_SAFETY_CHECKLIST
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PTW_SBAK')
            and   type = 'U')
   drop table T_PTW_SBAK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PTW_UJI_KANDUNGAN_GAS')
            and   type = 'U')
   drop table T_PTW_UJI_KANDUNGAN_GAS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_PTW_VALIDASI')
            and   name  = 'T_PTW_VALIDASI_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_PTW_VALIDASI.T_PTW_VALIDASI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_PTW_VALIDASI')
            and   type = 'U')
   drop table T_PTW_VALIDASI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_RAPAT')
            and   name  = 'T_RAPAT_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_RAPAT.T_RAPAT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_RAPAT')
            and   type = 'U')
   drop table T_RAPAT
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
           where  id = object_id('T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE')
            and   type = 'U')
   drop table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_RAPAT_MATERI')
            and   name  = 'T_RAPAT_MATERI_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_RAPAT_MATERI.T_RAPAT_MATERI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_RAPAT_MATERI')
            and   type = 'U')
   drop table T_RAPAT_MATERI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_RAPAT_SUB_MATERI')
            and   name  = 'T_RAPAT_SUB_MATERI_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_RAPAT_SUB_MATERI.T_RAPAT_SUB_MATERI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_RAPAT_SUB_MATERI')
            and   type = 'U')
   drop table T_RAPAT_SUB_MATERI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_RCA')
            and   type = 'U')
   drop table T_RCA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_RCA_AUDITOR')
            and   type = 'U')
   drop table T_RCA_AUDITOR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_RCA_DETAIL')
            and   name  = 'T_RCA_DETAIL_FK'
            and   indid > 0
            and   indid < 255)
   drop index T_RCA_DETAIL.T_RCA_DETAIL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_RCA_DETAIL')
            and   type = 'U')
   drop table T_RCA_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_RCA_TARGET_PEGAWAI')
            and   type = 'U')
   drop table T_RCA_TARGET_PEGAWAI
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
            from  sysindexes
           where  id    = object_id('T_STOP')
            and   name  = 'T_STOP_FK_R_PEGAWAI'
            and   indid > 0
            and   indid < 255)
   drop index T_STOP.T_STOP_FK_R_PEGAWAI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_STOP')
            and   type = 'U')
   drop table T_STOP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_STOP_DETAIL')
            and   type = 'U')
   drop table T_STOP_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_STOP_TARGET_PEGAWAI')
            and   type = 'U')
   drop table T_STOP_TARGET_PEGAWAI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_UNJUK_KERJA')
            and   type = 'U')
   drop table T_UNJUK_KERJA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('__GRUP_USER')
            and   type = 'U')
   drop table __GRUP_USER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('__HAK_AKSES')
            and   name  = '__HAK_AKSES_FK___MENU'
            and   indid > 0
            and   indid < 255)
   drop index __HAK_AKSES.__HAK_AKSES_FK___MENU
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('__HAK_AKSES')
            and   name  = '__HAK_AKSES_FK___GRUP_USER'
            and   indid > 0
            and   indid < 255)
   drop index __HAK_AKSES.__HAK_AKSES_FK___GRUP_USER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('__HAK_AKSES')
            and   type = 'U')
   drop table __HAK_AKSES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('__LOG')
            and   name  = '__LOG_FK'
            and   indid > 0
            and   indid < 255)
   drop index __LOG.__LOG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('__LOG')
            and   type = 'U')
   drop table __LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('__MENU')
            and   type = 'U')
   drop table __MENU
go

if exists (select 1
            from  sysobjects
           where  id = object_id('__USER')
            and   type = 'U')
   drop table __USER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('__USER_GRUP')
            and   type = 'U')
   drop table __USER_GRUP
go

/*==============================================================*/
/* Table: R_ALAT_PELINDUNG_DIRI_PTW                             */
/*==============================================================*/
create table R_ALAT_PELINDUNG_DIRI_PTW (
   ID_ALAT_PELINDUNG_DIRI_PTW smallint             identity,
   NAMA_ALAT_PELINDUNG_DIRI_PTW varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_ALAT_PELINDUNG_DIRI_PTW primary key (ID_ALAT_PELINDUNG_DIRI_PTW)
)
go

/*==============================================================*/
/* Table: R_DEPARTEMEN                                          */
/*==============================================================*/
create table R_DEPARTEMEN (
   ID_DEPARTEMEN        int                  identity,
   NAMA_DEPARTEMEN      varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DEPARTEMEN primary key (ID_DEPARTEMEN)
)
go

/*==============================================================*/
/* Table: R_DETAIL_TIPE_OBSERVASI                               */
/*==============================================================*/
create table R_DETAIL_TIPE_OBSERVASI (
   ID_DETAIL_TIPE_OBSERVASI int                  identity,
   ID_TIPE_OBSERVASI    int                  not null,
   ID_KEL_TIPE_OBSERVASI smallint             not null,
   NAMA_DETAIL_TIPE_OBSERVASI varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DETAIL_TIPE_OBSERVASI primary key (ID_DETAIL_TIPE_OBSERVASI, ID_TIPE_OBSERVASI, ID_KEL_TIPE_OBSERVASI)
)
go

/*==============================================================*/
/* Index: R_DETAIL_TIPE_OBSERVASI_FK                            */
/*==============================================================*/
create index R_DETAIL_TIPE_OBSERVASI_FK on R_DETAIL_TIPE_OBSERVASI (
ID_TIPE_OBSERVASI ASC,
ID_KEL_TIPE_OBSERVASI ASC
)
go

/*==============================================================*/
/* Table: R_DINAS                                               */
/*==============================================================*/
create table R_DINAS (
   ID_DINAS             int                  identity,
   ID_DEPARTEMEN        int                  not null,
   NAMA_DINAS           varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_DINAS primary key (ID_DINAS, ID_DEPARTEMEN)
)
go

/*==============================================================*/
/* Index: R_DINAS_FK                                            */
/*==============================================================*/
create index R_DINAS_FK on R_DINAS (
ID_DEPARTEMEN ASC
)
go

/*==============================================================*/
/* Table: R_JABATAN                                             */
/*==============================================================*/
create table R_JABATAN (
   ID_JABATAN           int                  identity,
   NAMA_JABATAN         varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_JABATAN primary key (ID_JABATAN)
)
go

/*==============================================================*/
/* Table: R_JABATAN_KOMITE_SUB_KOMITE                           */
/*==============================================================*/
create table R_JABATAN_KOMITE_SUB_KOMITE (
   ID_JABATAN_KOMITE    smallint             identity,
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint             null,
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
ID_KEL_JABATAN_KOMITE_SUB_KOMITE ASC
)
go

/*==============================================================*/
/* Table: R_JENIS_PEKERJAAN_PTW                                 */
/*==============================================================*/
create table R_JENIS_PEKERJAAN_PTW (
   ID_JENIS_PEKERJAAN_PTW smallint             identity,
   NAMA_JENIS_PEKERJAAN_PTW varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_JENIS_PEKERJAAN_PTW primary key (ID_JENIS_PEKERJAAN_PTW)
)
go

/*==============================================================*/
/* Table: R_K3PL                                                */
/*==============================================================*/
create table R_K3PL (
   TARGET_TSAF          float                not null default 0.0,
   TARGET_LTIF          float                not null default 0.0,
   RESET_JT_MIN_KECELAKAAN smallint             not null default 0,
   RESET_JT_MIN_NILAI_RUSAK decimal(12,2)        not null default 0,
   EMAIL_SERVER         varchar(256)         not null default '',
   EMAIL_SERVER_PORT    int                  not null default 0,
   EMAIL_USE_AUTH       tinyint              not null default 0,
   EMAIL_USERNAME       varchar(256)         not null default '',
   EMAIL_PASSWORD       varchar(256)         not null default '',
   EMAIL_STOP_NOTIF_ACTIVE tinyint              not null default 0,
   EMAIL_STOP_SENDER    varchar(256)         not null default '',
   EMAIL_STOP_SUBJECT   varchar(512)         not null default '',
   EMAIL_STOP_CONTENT   varchar(1024)        not null default '',
   EMAIL_RCA_NOTIF_ACTIVE tinyint              not null default 0,
   EMAIL_RCA_SENDER     varchar(256)         not null default '',
   EMAIL_RCA_SUBJECT    varchar(512)         not null default '',
   EMAIL_RCA_CONTENT    varchar(1024)        not null default '',
   EMAIL_RCA_SUBJECT_PJ varchar(512)         not null default '',
   EMAIL_RCA_CONTENT_PJ varchar(1024)        not null default '',
   GALLERY_PATH         varchar(255)         not null default '/images/gallery/',
   CHART_DELAY          int                  not null default 10,
   GALLERY_DELAY        int                  not null default 7
)
go

/*==============================================================*/
/* Table: R_KELOMPOK_TIPE_OBSERVASI                             */
/*==============================================================*/
create table R_KELOMPOK_TIPE_OBSERVASI (
   ID_KEL_TIPE_OBSERVASI smallint             identity,
   NAMA_KEL_TIPE_OBSERVASI varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KELOMPOK_TIPE_OBSERVASI primary key (ID_KEL_TIPE_OBSERVASI)
)
go

/*==============================================================*/
/* Table: R_KEL_JABATAN_KOMITE_SUB_KOMITE                       */
/*==============================================================*/
create table R_KEL_JABATAN_KOMITE_SUB_KOMITE (
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint             not null,
   NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KEL_JABATAN_KOMITE_SUB_KO primary key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
)
go

/*==============================================================*/
/* Table: R_KLASIFIKASI_PEGAWAI                                 */
/*==============================================================*/
create table R_KLASIFIKASI_PEGAWAI (
   ID_KLASIFIKASI_PEGAWAI smallint             identity,
   NAMA_KLASIFIKASI_PEGAWAI varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_KLASIFIKASI_PEGAWAI primary key (ID_KLASIFIKASI_PEGAWAI)
)
go

/*==============================================================*/
/* Table: R_PEGAWAI                                             */
/*==============================================================*/
create table R_PEGAWAI (
   NIPG                 varchar(20)          not null,
   ID_KLASIFIKASI_PEGAWAI smallint             not null,
   ID_JABATAN           int                  not null,
   ID_SEKSI             int                  not null,
   ID_DINAS             int                  not null,
   ID_DEPARTEMEN        int                  not null,
   NAMA_PEGAWAI         varchar(100)         not null,
   EMAIL                varchar(50)          null default '',
   STATUS_PEGAWAI       char(1)              not null default '1',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_PEGAWAI primary key (NIPG)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = tidak aktif
   1 = aktif',
   'user', @CurrentUser, 'table', 'R_PEGAWAI', 'column', 'STATUS_PEGAWAI'
go

/*==============================================================*/
/* Index: R_PEGAWAI_FK_R_KLASIFIKASI_PEGAWAI                    */
/*==============================================================*/
create index R_PEGAWAI_FK_R_KLASIFIKASI_PEGAWAI on R_PEGAWAI (
ID_KLASIFIKASI_PEGAWAI ASC
)
go

/*==============================================================*/
/* Index: R_PEGAWAI_FK_R_JABATAN                                */
/*==============================================================*/
create index R_PEGAWAI_FK_R_JABATAN on R_PEGAWAI (
ID_JABATAN ASC
)
go

/*==============================================================*/
/* Index: R_PEGAWAI_FK_R_SEKSI                                  */
/*==============================================================*/
create index R_PEGAWAI_FK_R_SEKSI on R_PEGAWAI (
ID_SEKSI ASC,
ID_DINAS ASC,
ID_DEPARTEMEN ASC
)
go

/*==============================================================*/
/* Table: R_PELATIHAN                                           */
/*==============================================================*/
create table R_PELATIHAN (
   ID_PELATIHAN         int                  identity,
   ID_PELATIHAN_KELOMPOK int                  not null,
   NAMA_PELATIHAN       varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_PELATIHAN primary key (ID_PELATIHAN)
)
go

/*==============================================================*/
/* Index: R_PELATIHAN_FK                                        */
/*==============================================================*/
create index R_PELATIHAN_FK on R_PELATIHAN (
ID_PELATIHAN_KELOMPOK ASC
)
go

/*==============================================================*/
/* Table: R_PELATIHAN_KELOMPOK                                  */
/*==============================================================*/
create table R_PELATIHAN_KELOMPOK (
   ID                   int                  identity,
   NAMA                 varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_PELATIHAN_KELOMPOK primary key (ID)
)
go

/*==============================================================*/
/* Table: R_SAFETY_CHECKLIST_PTW                                */
/*==============================================================*/
create table R_SAFETY_CHECKLIST_PTW (
   ID_SAFETY_CHECKLIST_PTW smallint             identity,
   NAMA_SAFETY_CHECKLIST_PTW varchar(200)         not null,
   JENIS_PTW            char(1)              not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_SAFETY_CHECKLIST_PTW primary key (ID_SAFETY_CHECKLIST_PTW)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 = hot work permit
   2 = cold work permit
   3 = confined space entry permit
   4 = radiographic work permit
   5 = electrical work permit
   6 = digging permit',
   'user', @CurrentUser, 'table', 'R_SAFETY_CHECKLIST_PTW', 'column', 'JENIS_PTW'
go

/*==============================================================*/
/* Table: R_SBAK_PTW                                            */
/*==============================================================*/
create table R_SBAK_PTW (
   ID_SBAK_PTW          smallint             identity,
   NAMA_SBAK_PTW        varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_SBAK_PTW primary key (ID_SBAK_PTW)
)
go

/*==============================================================*/
/* Table: R_SEKSI                                               */
/*==============================================================*/
create table R_SEKSI (
   ID_SEKSI             int                  identity,
   ID_DINAS             int                  not null,
   ID_DEPARTEMEN        int                  not null,
   ID_WILAYAH           int                  null,
   NAMA_SEKSI           varchar(250)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_SEKSI primary key (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
)
go

/*==============================================================*/
/* Index: R_SEKSI_FK                                            */
/*==============================================================*/
create index R_SEKSI_FK on R_SEKSI (
ID_DINAS ASC,
ID_DEPARTEMEN ASC
)
go

/*==============================================================*/
/* Index: R_SEKSI_FK_R_WILAYAH                                  */
/*==============================================================*/
create index R_SEKSI_FK_R_WILAYAH on R_SEKSI (
ID_WILAYAH ASC
)
go

/*==============================================================*/
/* Table: R_SEVERITY                                            */
/*==============================================================*/
create table R_SEVERITY (
   ID_SEVERITY          int                  identity,
   NAMA_SEVERITY        varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_SEVERITY primary key (ID_SEVERITY)
)
go

/*==============================================================*/
/* Table: R_TIPE_AREA_PERHATIAN                                 */
/*==============================================================*/
create table R_TIPE_AREA_PERHATIAN (
   ID_TIPE_AREA_PERHATIAN smallint             identity,
   NAMA_TIPE_AREA_PERHATIAN varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_TIPE_AREA_PERHATIAN primary key (ID_TIPE_AREA_PERHATIAN)
)
go

/*==============================================================*/
/* Table: R_TIPE_KEGIATAN                                       */
/*==============================================================*/
create table R_TIPE_KEGIATAN (
   ID_TIPE_KEGIATAN     smallint             identity,
   NAMA_TIPE_KEGIATAN   varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_TIPE_KEGIATAN primary key (ID_TIPE_KEGIATAN)
)
go

/*==============================================================*/
/* Table: R_TIPE_OBSERVASI                                      */
/*==============================================================*/
create table R_TIPE_OBSERVASI (
   ID_TIPE_OBSERVASI    int                  identity,
   ID_KEL_TIPE_OBSERVASI smallint             not null,
   NAMA_TIPE_OBSERVASI  varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_TIPE_OBSERVASI primary key (ID_TIPE_OBSERVASI, ID_KEL_TIPE_OBSERVASI)
)
go

/*==============================================================*/
/* Index: R_TIPE_OBSERVASI_FK                                   */
/*==============================================================*/
create index R_TIPE_OBSERVASI_FK on R_TIPE_OBSERVASI (
ID_KEL_TIPE_OBSERVASI ASC
)
go

/*==============================================================*/
/* Table: R_UJI_KANDUNGAN_GAS_PTW                               */
/*==============================================================*/
create table R_UJI_KANDUNGAN_GAS_PTW (
   ID_UJI_KANDUNGAN_GAS_PTW smallint             identity,
   NAMA_UJI_KANDUNGAN_GAS_PTW varchar(50)          not null,
   STANDARD             varchar(50)          null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_UJI_KANDUNGAN_GAS_PTW primary key (ID_UJI_KANDUNGAN_GAS_PTW)
)
go

/*==============================================================*/
/* Table: R_WILAYAH                                             */
/*==============================================================*/
create table R_WILAYAH (
   ID_WILAYAH           int                  identity,
   NAMA_WILAYAH         varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_R_WILAYAH primary key (ID_WILAYAH)
)
go

/*==============================================================*/
/* Table: T_AREA_PERHATIAN_DETAIL                               */
/*==============================================================*/
create table T_AREA_PERHATIAN_DETAIL (
   ID_AREA_PERHATIAN_DETAIL bigint               identity,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_AREA_PERHATIAN smallint             not null,
   NAMA_AREA_PERHATIAN  varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_AREA_PERHATIAN_DETAIL primary key (ID_AREA_PERHATIAN_DETAIL)
)
go

/*==============================================================*/
/* Index: T_AREA_PERHATIAN_DETAIL_FK_R_WILAYAH                  */
/*==============================================================*/
create index T_AREA_PERHATIAN_DETAIL_FK_R_WILAYAH on T_AREA_PERHATIAN_DETAIL (
ID_WILAYAH ASC
)
go

/*==============================================================*/
/* Index: T_AREA_PERHATIAN_DETAIL_FK_T_KEGIATAN                 */
/*==============================================================*/
create index T_AREA_PERHATIAN_DETAIL_FK_T_KEGIATAN on T_AREA_PERHATIAN_DETAIL (
TAHUN ASC,
BULAN ASC
)
go

/*==============================================================*/
/* Index: T_AREA_PERHATIAN_DETAIL_FK_R_TIPE_AREA_PERHATIAN      */
/*==============================================================*/
create index T_AREA_PERHATIAN_DETAIL_FK_R_TIPE_AREA_PERHATIAN on T_AREA_PERHATIAN_DETAIL (
ID_TIPE_AREA_PERHATIAN ASC
)
go

/*==============================================================*/
/* Table: T_HOME_GALLERY                                        */
/*==============================================================*/
create table T_HOME_GALLERY (
   ID                   int                  identity,
   DATE_UPLOADED        datetime             not null default getdate(),
   FILENAME             varchar(512)         not null,
   DESCRIPTION          varchar(512)         null default '',
   constraint PK_T_HOME_GALLERY primary key (ID)
)
go

/*==============================================================*/
/* Table: T_HOME_NEWS                                           */
/*==============================================================*/
create table T_HOME_NEWS (
   ID                   int                  identity,
   DATE_PUBLISHED       datetime             not null default getdate(),
   DATE_UPDATED         datetime             not null default getdate(),
   SUBJECT              varchar(255)         not null,
   URL                  varchar(512)         null default '',
   CONTENT              varchar(1024)        null default '',
   constraint PK_T_HOME_NEWS primary key (ID)
)
go

/*==============================================================*/
/* Table: T_INSIDEN                                             */
/*==============================================================*/
create table T_INSIDEN (
   ID_INSIDEN           bigint               not null,
   ID_AREA_DEPARTEMEN   int                  not null,
   ID_AREA_DINAS        int                  not null,
   ID_AREA_SEKSI        int                  not null,
   ID_KLASIFIKASI_PEGAWAI smallint             not null,
   TANGGAL              datetime             not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   URAIAN               varchar(1000)        null default '',
   JML_KORBAN_MATI      int                  not null default 0,
   JML_KORBAN_BERAT     int                  not null default 0,
   JML_KORBAN_SEDANG    int                  not null default 0,
   JML_HARI_KERJA_HILANG int                  not null default 0,
   JML_KORBAN_DAMPAK    int                  not null default 0,
   JML_KORBAN_MEDIS     int                  not null default 0,
   JML_KORBAN_P3K       int                  not null default 0,
   JML_HAMPIR_CELAKA    int                  not null default 0,
   JML_BAKAR_LEDAK_BOCOR int                  not null default 0,
   JML_RUSAK_JARINGAN   int                  not null default 0,
   JML_RUSAK_BANGUNAN   int                  not null default 0,
   JML_RUSAK_KENDARAAN  int                  not null default 0,
   JML_RUSAK_LAIN       int                  not null default 0,
   NILAI_RUSAK_JARINGAN decimal(12,2)        not null default 0.0,
   NILAI_RUSAK_BANGUNAN decimal(12,2)        not null default 0.0,
   NILAI_RUSAK_KENDARAAN decimal(12,2)        not null default 0.0,
   NILAI_RUSAK_LAIN     decimal(12,2)        not null default 0.0,
   JML_PENCEMARAN_LINGKUNGAN int                  not null default 0,
   JML_KECELAKAAN_KENDARAAN int                  not null default 0,
   JML_KEJADIAN_KEAMANAN int                  not null default 0,
   STATUS_RESET         smallint             not null default 0,
   STATUS_RESET_JARAK   smallint             not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_INSIDEN primary key (ID_INSIDEN)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1: jam kerja is being reset by this incident',
   'user', @CurrentUser, 'table', 'T_INSIDEN', 'column', 'STATUS_RESET'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1: jarak tempuh is being reset by this incident',
   'user', @CurrentUser, 'table', 'T_INSIDEN', 'column', 'STATUS_RESET_JARAK'
go

/*==============================================================*/
/* Index: T_INSIDEN_FK_R_SEKSI                                  */
/*==============================================================*/
create index T_INSIDEN_FK_R_SEKSI on T_INSIDEN (
ID_AREA_SEKSI ASC,
ID_AREA_DINAS ASC,
ID_AREA_DEPARTEMEN ASC
)
go

/*==============================================================*/
/* Index: T_INSIDEN_FK_R_KLASIFIKASI_PEGAWAI                    */
/*==============================================================*/
create index T_INSIDEN_FK_R_KLASIFIKASI_PEGAWAI on T_INSIDEN (
ID_KLASIFIKASI_PEGAWAI ASC
)
go

/*==============================================================*/
/* Table: T_JSA                                                 */
/*==============================================================*/
create table T_JSA (
   ID_JSA               int                  identity,
   NO_DOKUMEN           varchar(50)          not null,
   REVISI               varchar(5)           null,
   NO_KONTRAK           varchar(50)          null,
   NAMA_PERUSAHAAN      varchar(100)         null,
   NAMA_PROYEK          varchar(100)         null,
   NAMA_PIC             varchar(100)         null,
   AKTIFITAS_PEKERJAAN  varchar(500)         null,
   TANGGAL_JSA          datetime             null default getdate(),
   ALAT_PELINDUNG_DIRI_DIGUNAKAN varchar(200)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_JSA primary key (ID_JSA)
)
go

/*==============================================================*/
/* Table: T_JSA_DETAIL                                          */
/*==============================================================*/
create table T_JSA_DETAIL (
   ID_JSA               int                  not null,
   ID_JSA_DETAIL        int                  identity,
   URUTAN_LANGKAH_PEKERJAAN_DASAR varchar(200)         null,
   POTENSI_BAHAYA       varchar(200)         null,
   REKOMENDASI_AKSI     varchar(200)         null,
   PENANGGUNG_JAWAB     varchar(200)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_JSA_DETAIL primary key (ID_JSA, ID_JSA_DETAIL)
)
go

/*==============================================================*/
/* Table: T_KEGIATAN                                            */
/*==============================================================*/
create table T_KEGIATAN (
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN primary key (TAHUN, BULAN)
)
go

/*==============================================================*/
/* Table: T_KEGIATAN_DETAIL                                     */
/*==============================================================*/
create table T_KEGIATAN_DETAIL (
   ID_KEGIATAN_DETAIL   bigint               identity,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_KEGIATAN     smallint             not null,
   NAMA_KEGIATAN        varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN_DETAIL primary key (ID_KEGIATAN_DETAIL)
)
go

/*==============================================================*/
/* Index: T_KEGIATAN_DETAIL_FK_T_KEGIATAN                       */
/*==============================================================*/
create index T_KEGIATAN_DETAIL_FK_T_KEGIATAN on T_KEGIATAN_DETAIL (
TAHUN ASC,
BULAN ASC
)
go

/*==============================================================*/
/* Index: T_KEGIATAN_DETAIL_FK_R_WILAYAH                        */
/*==============================================================*/
create index T_KEGIATAN_DETAIL_FK_R_WILAYAH on T_KEGIATAN_DETAIL (
ID_WILAYAH ASC
)
go

/*==============================================================*/
/* Index: T_KEGIATAN_DETAIL_FK_R_TIPE_KEGIATAN                  */
/*==============================================================*/
create index T_KEGIATAN_DETAIL_FK_R_TIPE_KEGIATAN on T_KEGIATAN_DETAIL (
ID_TIPE_KEGIATAN ASC
)
go

/*==============================================================*/
/* Table: T_PEGAWAI_KOMITE_SUB_KOMITE                           */
/*==============================================================*/
create table T_PEGAWAI_KOMITE_SUB_KOMITE (
   NIPG                 varchar(20)          not null,
   ID_JABATAN_KOMITE    smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PEGAWAI_KOMITE_SUB_KOMITE primary key (NIPG, ID_JABATAN_KOMITE)
)
go

/*==============================================================*/
/* Table: T_PELATIHAN                                           */
/*==============================================================*/
create table T_PELATIHAN (
   ID                   bigint               not null,
   ID_PELATIHAN         int                  not null,
   PENYELENGGARA        varchar(200)         not null,
   TEMPAT               varchar(200)         not null,
   TANGGAL              datetime             not null,
   LAMA                 smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PELATIHAN primary key (ID)
)
go

/*==============================================================*/
/* Index: T_PELATIHAN_FK_R_PELATIHAN                            */
/*==============================================================*/
create index T_PELATIHAN_FK_R_PELATIHAN on T_PELATIHAN (
ID_PELATIHAN ASC
)
go

/*==============================================================*/
/* Table: T_PELATIHAN_PESERTA                                   */
/*==============================================================*/
create table T_PELATIHAN_PESERTA (
   ID                   bigint               not null,
   NIPG                 varchar(20)          not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PELATIHAN_PESERTA primary key (ID, NIPG)
)
go

/*==============================================================*/
/* Table: T_PENGELOLAAN_LINGKUNGAN                              */
/*==============================================================*/
create table T_PENGELOLAAN_LINGKUNGAN (
   ID_PENGELOLAAN_LINGKUNGAN bigint               not null,
   ID_WILAYAH           int                  not null,
   TANGGAL_PENGELOLAAN_LINGKUNGAN datetime             not null default getdate(),
   LOKASI_PENGELOLAAN_LINGKUNGAN varchar(100)         not null,
   TIPE_STATION         varchar(100)         not null,
   PARAMETER            varchar(100)         not null,
   SUMBER_DAMPAK        varchar(100)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PENGELOLAAN_LINGKUNGAN primary key (ID_PENGELOLAAN_LINGKUNGAN)
)
go

/*==============================================================*/
/* Index: T_PENGELOLAAN_LINGKUNGAN_FK                           */
/*==============================================================*/
create index T_PENGELOLAAN_LINGKUNGAN_FK on T_PENGELOLAAN_LINGKUNGAN (
ID_WILAYAH ASC
)
go

/*==============================================================*/
/* Table: T_PIC_RAPAT_MATERI                                    */
/*==============================================================*/
create table T_PIC_RAPAT_MATERI (
   ID_RAPAT_MATERI      bigint               not null,
   ID_RAPAT             bigint               not null,
   SEKSI_PELAKSANA      int                  not null,
   NIPG_PELAKSANA       varchar(20)          not null,
   DINAS_SUPERVISOR     int                  not null,
   NIPG_SUPERVISOR      varchar(20)          not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PIC_RAPAT_MATERI primary key nonclustered (ID_RAPAT_MATERI, ID_RAPAT)
)
go

/*==============================================================*/
/* Table: T_PIC_RAPAT_SUB_MATERI                                */
/*==============================================================*/
create table T_PIC_RAPAT_SUB_MATERI (
   ID_RAPAT_SUB_MATERI  bigint               not null,
   ID_RAPAT_MATERI      bigint               not null,
   ID_RAPAT             bigint               not null,
   SEKSI_PELAKSANA      int                  not null,
   NIPG_PELAKSANA       varchar(20)          not null,
   DINAS_SUPERVISOR     int                  not null,
   NIPG_SUPERVISOR      varchar(20)          not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PIC_RAPAT_SUB_MATERI primary key nonclustered (ID_RAPAT_SUB_MATERI, ID_RAPAT_MATERI, ID_RAPAT)
)
go

/*==============================================================*/
/* Table: T_PTW                                                 */
/*==============================================================*/
create table T_PTW (
   ID_PTW               int                  identity,
   ID_JSA               int                  not null,
   JENIS_PTW            char(1)              not null,
   NOMOR                varchar(50)          null,
   TGL_PENGESAHAN       datetime             null default getdate(),
   MASA_BERLAKU_AWAL    datetime             null,
   MASA_BERLAKU_AKHIR   datetime             null,
   LOKASI_PEKERJAAN     varchar(200)         null,
   PELAKSANA_PEKERJAAN  varchar(200)         null,
   URAIAN_PEKERJAAN     varchar(200)         null,
   NAMA_PERUSAHAAN      varchar(100)         null,
   NO_LISENSI           varchar(50)          null,
   SUMBER_RADIOAKTIF    varchar(100)         null,
   PROYEKTOR            varchar(100)         null,
   SURVEY_METER         varchar(100)         null,
   TANGGAL_SERVICE      datetime             null,
   TANGGAL_KALIBRASI    datetime             null,
   NAMA_PETUGAS_ISOLASI_LISTRIK varchar(50)          null,
   JABATAN_PETUGAS_ISOLASI_LISTRIK varchar(50)          null,
   NAMA_PETUGAS_UJI_KANDUNGAN_GAS varchar(50)          null,
   JABATAN_PETUGAS_UJI_KANDUNGAN_GAS varchar(50)          null,
   NAMA_PELAKSANA_PEKERJAAN varchar(50)          null,
   JABATAN_PELAKSANA_PEKERJAAN varchar(50)          null,
   NAMA_PEJABAT_BERWENANG varchar(50)          null,
   JABATAN_PEJABAT_BERWENANG varchar(50)          null,
   CATATAN              varchar(500)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PTW primary key (ID_PTW)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 = hot work permit
   2 = cold work permit
   3 = confined space entry permit
   4 = radiographic work permit
   5 = electrical work permit
   6 = digging permit',
   'user', @CurrentUser, 'table', 'T_PTW', 'column', 'JENIS_PTW'
go

/*==============================================================*/
/* Index: T_PTW_FK                                              */
/*==============================================================*/
create index T_PTW_FK on T_PTW (
ID_JSA ASC
)
go

/*==============================================================*/
/* Table: T_PTW_ALAT_PELINDUNG_DIRI                             */
/*==============================================================*/
create table T_PTW_ALAT_PELINDUNG_DIRI (
   ID_PTW               int                  not null,
   ID_ALAT_PELINDUNG_DIRI_PTW smallint             not null,
   KETERANGAN           varchar(100)         null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PTW_ALAT_PELINDUNG_DIRI primary key (ID_PTW, ID_ALAT_PELINDUNG_DIRI_PTW)
)
go

/*==============================================================*/
/* Table: T_PTW_JENIS_PEKERJAAN                                 */
/*==============================================================*/
create table T_PTW_JENIS_PEKERJAAN (
   ID_PTW               int                  not null,
   ID_JENIS_PEKERJAAN_PTW smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PTW_JENIS_PEKERJAAN primary key (ID_PTW, ID_JENIS_PEKERJAAN_PTW)
)
go

/*==============================================================*/
/* Table: T_PTW_SAFETY_CHECKLIST                                */
/*==============================================================*/
create table T_PTW_SAFETY_CHECKLIST (
   ID_PTW               int                  not null,
   ID_SAFETY_CHECKLIST_PTW smallint             not null,
   STATUS               char(1)              not null default '0',
   KETERANGAN           varchar(100)         null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PTW_SAFETY_CHECKLIST primary key (ID_PTW, ID_SAFETY_CHECKLIST_PTW)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = tidak
   1 = ya',
   'user', @CurrentUser, 'table', 'T_PTW_SAFETY_CHECKLIST', 'column', 'STATUS'
go

/*==============================================================*/
/* Table: T_PTW_SBAK                                            */
/*==============================================================*/
create table T_PTW_SBAK (
   ID_PTW               int                  not null,
   ID_SBAK_PTW          smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PTW_SBAK primary key (ID_PTW, ID_SBAK_PTW)
)
go

/*==============================================================*/
/* Table: T_PTW_UJI_KANDUNGAN_GAS                               */
/*==============================================================*/
create table T_PTW_UJI_KANDUNGAN_GAS (
   ID_PTW               int                  not null,
   ID_UJI_KANDUNGAN_GAS_PTW smallint             not null,
   HASIL                varchar(100)         null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PTW_UJI_KANDUNGAN_GAS primary key (ID_PTW, ID_UJI_KANDUNGAN_GAS_PTW)
)
go

/*==============================================================*/
/* Table: T_PTW_VALIDASI                                        */
/*==============================================================*/
create table T_PTW_VALIDASI (
   ID_PTW_VALIDASI      int                  identity,
   ID_PTW               int                  not null,
   HARI                 varchar(10)          null,
   WAKTU_MULAI          varchar(10)          null,
   WAKTU_SELESAI        varchar(10)          null,
   NAMA_PELAKSANA       varchar(100)         null,
   INISIAL_PELAKSANA    varchar(5)           null,
   NAMA_PENGAWAS        varchar(100)         null,
   INISIAL_PENGAWAS     varchar(5)           null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_PTW_VALIDASI primary key (ID_PTW_VALIDASI)
)
go

/*==============================================================*/
/* Index: T_PTW_VALIDASI_FK                                     */
/*==============================================================*/
create index T_PTW_VALIDASI_FK on T_PTW_VALIDASI (
ID_PTW ASC
)
go

/*==============================================================*/
/* Table: T_RAPAT                                               */
/*==============================================================*/
create table T_RAPAT (
   ID_RAPAT             bigint               not null,
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint             not null,
   NO_RAPAT             varchar(100)         null,
   JUDUL_RAPAT          varchar(100)         not null,
   TANGGAL_RAPAT        datetime             not null,
   LOKASI_RAPAT         varchar(100)         not null,
   NAMA_NOTULIS         varchar(50)          null,
   TANGGAL_NOTULEN      datetime             null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RAPAT primary key (ID_RAPAT)
)
go

/*==============================================================*/
/* Index: T_RAPAT_FK                                            */
/*==============================================================*/
create index T_RAPAT_FK on T_RAPAT (
ID_KEL_JABATAN_KOMITE_SUB_KOMITE ASC
)
go

/*==============================================================*/
/* Table: T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE                     */
/*==============================================================*/
create table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE (
   ID_RAPAT             bigint               not null,
   NIPG                 varchar(20)          null,
   NAMA_PESERTA         varchar(100)         not null,
   ID_JABATAN_KOMITE    smallint             null,
   STATUS_ABSENSI       char(1)              not null default '0',
   KETERANGAN_ABSENSI   varchar(100)         null,
   JML_HADIR            int                  null,
   JML_ABSEN            int                  null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RAPAT_ABSENSI_KOMITE_SUB_ primary key (ID_RAPAT, NAMA_PESERTA)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = tidak hadir
   1 = hadir',
   'user', @CurrentUser, 'table', 'T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE', 'column', 'STATUS_ABSENSI'
go

/*==============================================================*/
/* Index: T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE_FK                  */
/*==============================================================*/
create index T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE_FK on T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE (
NIPG ASC,
ID_JABATAN_KOMITE ASC
)
go

/*==============================================================*/
/* Table: T_RAPAT_MATERI                                        */
/*==============================================================*/
create table T_RAPAT_MATERI (
   ID_RAPAT_MATERI      bigint               not null,
   ID_RAPAT             bigint               not null,
   ISI_RAPAT_MATERI     varchar(1000)        not null,
   BATAS_WAKTU_MATERI   datetime             null,
   STATUS_MATERI        char(1)              not null default '0',
   KETERANGAN_MATERI    varchar(100)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RAPAT_MATERI primary key (ID_RAPAT_MATERI, ID_RAPAT)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = info
   1 = open
   2 = closed oleh pic
   3 = closed oleh penanggung jawab
   4 = finished',
   'user', @CurrentUser, 'table', 'T_RAPAT_MATERI', 'column', 'STATUS_MATERI'
go

/*==============================================================*/
/* Index: T_RAPAT_MATERI_FK                                     */
/*==============================================================*/
create index T_RAPAT_MATERI_FK on T_RAPAT_MATERI (
ID_RAPAT ASC
)
go

/*==============================================================*/
/* Table: T_RAPAT_SUB_MATERI                                    */
/*==============================================================*/
create table T_RAPAT_SUB_MATERI (
   ID_RAPAT_SUB_MATERI  bigint               not null,
   ID_RAPAT_MATERI      bigint               not null,
   ID_RAPAT             bigint               not null,
   ISI_RAPAT_SUB_MATERI varchar(1000)        not null,
   BATAS_WAKTU_SUB_MATERI datetime             null,
   STATUS_SUB_MATERI    char(1)              not null default '0',
   KETERANGAN_SUB_MATERI varchar(100)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RAPAT_SUB_MATERI primary key (ID_RAPAT_SUB_MATERI, ID_RAPAT_MATERI, ID_RAPAT)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = info
   1 = open
   2 = closed oleh pic
   3 = closed oleh penanggung jawab
   4 = finished',
   'user', @CurrentUser, 'table', 'T_RAPAT_SUB_MATERI', 'column', 'STATUS_SUB_MATERI'
go

/*==============================================================*/
/* Index: T_RAPAT_SUB_MATERI_FK                                 */
/*==============================================================*/
create index T_RAPAT_SUB_MATERI_FK on T_RAPAT_SUB_MATERI (
ID_RAPAT_MATERI ASC,
ID_RAPAT ASC
)
go

/*==============================================================*/
/* Table: T_RCA                                                 */
/*==============================================================*/
create table T_RCA (
   ID_RCA               bigint               not null,
   TANGGAL_RCA          datetime             not null default getdate(),
   AUDITOR_DEPARTEMEN   int                  not null,
   AUDITOR_DINAS        int                  not null,
   AUDITOR_SEKSI        int                  not null,
   NAMA_TEMPAT_RCA      varchar(100)         not null,
   PENANGGUNG_JAWAB_DEPARTEMEN int                  not null,
   PENANGGUNG_JAWAB_DINAS int                  not null,
   PENANGGUNG_JAWAB_SEKSI int                  not null,
   PENANGGUNG_JAWAB_NIPG varchar(20)          not null,
   WAKTU_AUDIT          varchar(20)          null,
   LAMA_AUDIT           int                  not null default 0,
   CUACA                varchar(30)          null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RCA primary key (ID_RCA)
)
go

/*==============================================================*/
/* Table: T_RCA_AUDITOR                                         */
/*==============================================================*/
create table T_RCA_AUDITOR (
   ID_RCA               bigint               not null,
   NIPG                 varchar(20)          not null,
   STATUS               smallint             not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RCA_AUDITOR primary key (ID_RCA, NIPG)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = not counted
   1 = periode 1
   2 = periode 2',
   'user', @CurrentUser, 'table', 'T_RCA_AUDITOR', 'column', 'STATUS'
go

/*==============================================================*/
/* Table: T_RCA_DETAIL                                          */
/*==============================================================*/
create table T_RCA_DETAIL (
   ID_RCA               bigint               not null,
   ID_RCA_DETAIL        bigint               identity,
   ID_SEVERITY          int                  not null,
   DESCRIPTION          varchar(100)         not null,
   GOOD_CITIZENS        int                  not null default 0,
   VIOLATORS            int                  not null default 0,
   NUMBER_OF_VIOLATIONS int                  not null default 0,
   VIOLATION_X_SEVERITY int                  not null default 0,
   LI_45                int                  not null default 0,
   LI_APD               int                  not null default 0,
   LI_HOUSEKEEPING      int                  not null default 0,
   LI_PROCESS_SAFETY    int                  not null default 0,
   LI_FIRE_SAFETY       int                  not null default 0,
   ACTIONS              varchar(100)         null,
   STATUS               char(1)              not null default '1',
   COMPLETION_DATE_TARGET datetime             null,
   COMPLETION_DATE_ACTUAL datetime             null,
   NOTE                 varchar(200)         null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RCA_DETAIL primary key (ID_RCA, ID_RCA_DETAIL)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 = open
   2 = process
   3 = closed',
   'user', @CurrentUser, 'table', 'T_RCA_DETAIL', 'column', 'STATUS'
go

/*==============================================================*/
/* Index: T_RCA_DETAIL_FK                                       */
/*==============================================================*/
create index T_RCA_DETAIL_FK on T_RCA_DETAIL (
ID_SEVERITY ASC
)
go

/*==============================================================*/
/* Table: T_RCA_TARGET_PEGAWAI                                  */
/*==============================================================*/
create table T_RCA_TARGET_PEGAWAI (
   NIPG                 varchar(20)          not null,
   YEAR                 smallint             not null,
   JAN                  smallint             not null default 0,
   FEB                  smallint             not null default 0,
   MAR                  smallint             not null default 0,
   APR                  smallint             not null default 0,
   MAY                  smallint             not null default 0,
   JUN                  smallint             not null default 0,
   JUL                  smallint             not null default 0,
   AUG                  smallint             not null default 0,
   SEP                  smallint             not null default 0,
   OCT                  smallint             not null default 0,
   NOV                  smallint             not null default 0,
   DEC                  smallint             not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_RCA_TARGET_PEGAWAI primary key (NIPG, YEAR)
)
go

/*==============================================================*/
/* Table: T_STOP                                                */
/*==============================================================*/
create table T_STOP (
   ID_STOP              bigint               not null,
   NIPG                 varchar(20)          not null,
   ID_DEPARTEMEN        int                  not null,
   ID_DINAS             int                  not null,
   ID_SEKSI             int                  not null,
   ID_AREA_DEPARTEMEN   int                  not null,
   ID_AREA_DINAS        int                  not null,
   ID_AREA_SEKSI        int                  not null,
   TANGGAL              datetime             not null,
   SITE                 varchar(100)         null,
   SHIFT                varchar(50)          null,
   LAMA_OBSERVASI       int                  null default 0,
   JML_ORG_OBSERVASI    smallint             not null,
   JML_ORG_DISKUSI      smallint             not null,
   TINDAKAN_AMAN_DIAMATI varchar(1000)        null,
   TINDAKAN_TIDAK_AMAN_DIAMATI varchar(1000)        null,
   YEAR                 smallint             not null,
   MONTH                smallint             not null,
   STATUS_AKTIF         char(1)              not null default '1',
   STATUS               smallint             not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_STOP primary key (ID_STOP)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = not counted
   1 = periode 1
   2 = periode 2',
   'user', @CurrentUser, 'table', 'T_STOP', 'column', 'STATUS'
go

/*==============================================================*/
/* Index: T_STOP_FK_R_PEGAWAI                                   */
/*==============================================================*/
create index T_STOP_FK_R_PEGAWAI on T_STOP (
NIPG ASC
)
go

/*==============================================================*/
/* Index: T_STOP_FK_R_SEKSI                                     */
/*==============================================================*/
create index T_STOP_FK_R_SEKSI on T_STOP (
ID_AREA_SEKSI ASC,
ID_AREA_DINAS ASC,
ID_AREA_DEPARTEMEN ASC
)
go

/*==============================================================*/
/* Table: T_STOP_DETAIL                                         */
/*==============================================================*/
create table T_STOP_DETAIL (
   ID_STOP              bigint               not null,
   ID_KEL_TIPE_OBSERVASI smallint             not null,
   ID_TIPE_OBSERVASI    int                  not null,
   ID_DETAIL_TIPE_OBSERVASI int                  not null,
   JUMLAH_SAFE          smallint             not null default 0,
   JUMLAH_UNSAFE        smallint             not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_STOP_DETAIL primary key (ID_STOP, ID_DETAIL_TIPE_OBSERVASI, ID_TIPE_OBSERVASI, ID_KEL_TIPE_OBSERVASI)
)
go

/*==============================================================*/
/* Table: T_STOP_TARGET_PEGAWAI                                 */
/*==============================================================*/
create table T_STOP_TARGET_PEGAWAI (
   NIPG                 varchar(20)          not null,
   YEAR                 smallint             not null,
   JAN                  smallint             not null default 0,
   FEB                  smallint             not null default 0,
   MAR                  smallint             not null default 0,
   APR                  smallint             not null default 0,
   MAY                  smallint             not null default 0,
   JUN                  smallint             not null default 0,
   JUL                  smallint             not null default 0,
   AUG                  smallint             not null default 0,
   SEP                  smallint             not null default 0,
   OCT                  smallint             not null default 0,
   NOV                  smallint             not null default 0,
   DEC                  smallint             not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_STOP_TARGET_PEGAWAI primary key (NIPG, YEAR)
)
go

/*==============================================================*/
/* Table: T_UNJUK_KERJA                                         */
/*==============================================================*/
create table T_UNJUK_KERJA (
   TANGGAL              datetime             not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_KLASIFIKASI_PEGAWAI smallint             not null,
   JML_TENAGA_KERJA     int                  not null default 0,
   JML_HARI_KERJA       int                  not null default 0,
   JML_HARI_ABSEN       int                  not null default 0,
   JML_JAM_KERJA        int                  not null default 0,
   JML_JARAK_TEMPUH     int                  not null default 0,
   JML_JARAK_TEMPUH_AMAN int                  not null default 0,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_UNJUK_KERJA primary key (TANGGAL, ID_KLASIFIKASI_PEGAWAI)
)
go

/*==============================================================*/
/* Table: __GRUP_USER                                           */
/*==============================================================*/
create table __GRUP_USER (
   ID_GRUP              int                  identity,
   NAMA_GRUP            varchar(100)         not null,
   KETERANGAN_GRUP      varchar(250)         null,
   constraint PK___GRUP_USER primary key (ID_GRUP)
)
go

/*==============================================================*/
/* Table: __HAK_AKSES                                           */
/*==============================================================*/
create table __HAK_AKSES (
   HA_ID                bigint               identity,
   ID_GRUP              int                  not null,
   MENU_ID              varchar(5)           not null,
   HA_LEVEL             smallint             not null default 0,
   constraint PK___HAK_AKSES primary key (HA_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '0 = tidak ada akses
   1 = view
   2 = insert
   3 = update
   4 = delete',
   'user', @CurrentUser, 'table', '__HAK_AKSES', 'column', 'HA_LEVEL'
go

/*==============================================================*/
/* Index: __HAK_AKSES_FK___GRUP_USER                            */
/*==============================================================*/
create index __HAK_AKSES_FK___GRUP_USER on __HAK_AKSES (
ID_GRUP ASC
)
go

/*==============================================================*/
/* Index: __HAK_AKSES_FK___MENU                                 */
/*==============================================================*/
create index __HAK_AKSES_FK___MENU on __HAK_AKSES (
MENU_ID ASC
)
go

/*==============================================================*/
/* Table: __LOG                                                 */
/*==============================================================*/
create table __LOG (
   TANGGAL              datetime             not null default getdate(),
   NIPG                 varchar(20)          not null,
   NAMA_MENU            varchar(100)         not null,
   STATUS_AKSES         char(1)              not null,
   constraint PK___LOG primary key (TANGGAL)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '2 = insert
   3 = update
   4 = delete
   5 = login',
   'user', @CurrentUser, 'table', '__LOG', 'column', 'STATUS_AKSES'
go

/*==============================================================*/
/* Index: __LOG_FK                                              */
/*==============================================================*/
create index __LOG_FK on __LOG (
NIPG ASC
)
go

/*==============================================================*/
/* Table: __MENU                                                */
/*==============================================================*/
create table __MENU (
   MENU_ID              varchar(5)           not null,
   MENU_NAME            varchar(100)         not null,
   MENU_FOLDER          varchar(100)         null,
   MENU_LEAF            char(1)              null default '1',
   MENU_LEVEL           smallint             null default 0,
   MENU_PARENT          varchar(100)         not null,
   ICON                 varchar(20)          null,
   constraint PK___MENU primary key (MENU_ID)
)
go

/*==============================================================*/
/* Table: __USER                                                */
/*==============================================================*/
create table __USER (
   NIPG                 varchar(20)          not null,
   PASSWORD             varchar(100)         not null,
   STATUS_USER          char(1)              not null default '1',
   constraint PK___USER primary key (NIPG)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 = aktif
   2 = tidak aktif',
   'user', @CurrentUser, 'table', '__USER', 'column', 'STATUS_USER'
go

/*==============================================================*/
/* Table: __USER_GRUP                                           */
/*==============================================================*/
create table __USER_GRUP (
   NIPG                 varchar(20)          not null,
   ID_GRUP              int                  not null,
   constraint PK___USER_GRUP primary key (NIPG, ID_GRUP)
)
go

/*==============================================================*/
/* View: V_SEVERITY                                             */
/*==============================================================*/
create view V_SEVERITY as
select	a.tanggal_rca
    ,   b.description
	,	b.id_severity 
	,	a.nama_tempat_rca 
	,	a.penanggung_jawab_seksi 
	,	a.penanggung_jawab_dinas 
	,	a.penanggung_jawab_departemen 
	,	replace(convert(varchar, b.completion_date_target, 111), '/', '-') as completion_date_target 
	,	b.status 
	,	b.note 
from	t_rca			as a 
	,	t_rca_detail	as b 
where	a.id_rca    = b.id_rca
go

alter table R_DETAIL_TIPE_OBSERVASI
   add constraint FK_R_TIPE_OBSERVASI_R_DETAIL_TIPE_OBSERVASI foreign key (ID_TIPE_OBSERVASI, ID_KEL_TIPE_OBSERVASI)
      references R_TIPE_OBSERVASI (ID_TIPE_OBSERVASI, ID_KEL_TIPE_OBSERVASI)
go

alter table R_DINAS
   add constraint FK_R_DEPARTEMEN_R_DINAS foreign key (ID_DEPARTEMEN)
      references R_DEPARTEMEN (ID_DEPARTEMEN)
go

alter table R_JABATAN_KOMITE_SUB_KOMITE
   add constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE foreign key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
      references R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
go

alter table R_PEGAWAI
   add constraint FK_R_JABATAN_R_PEGAWAI foreign key (ID_JABATAN)
      references R_JABATAN (ID_JABATAN)
go

alter table R_PEGAWAI
   add constraint FK_R_KLASIFIKASI_PEGAWAI_R_PEGAWAI foreign key (ID_KLASIFIKASI_PEGAWAI)
      references R_KLASIFIKASI_PEGAWAI (ID_KLASIFIKASI_PEGAWAI)
go

alter table R_PEGAWAI
   add constraint FK_R_SEKSI_R_PEGAWAI foreign key (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
go

alter table R_PELATIHAN
   add constraint FK_R_PELATIHAN_KELOMPOK_R_PELATIHAN foreign key (ID_PELATIHAN_KELOMPOK)
      references R_PELATIHAN_KELOMPOK (ID)
go

alter table R_SEKSI
   add constraint FK_R_DINAS_R_SEKSI foreign key (ID_DINAS, ID_DEPARTEMEN)
      references R_DINAS (ID_DINAS, ID_DEPARTEMEN)
go

alter table R_SEKSI
   add constraint FK_R_WILAYAH_R_SEKSI foreign key (ID_WILAYAH)
      references R_WILAYAH (ID_WILAYAH)
go

alter table R_TIPE_OBSERVASI
   add constraint FK_R_KELOMPOK_TIPE_OBSERVASI_R_TIPE_OBSERVASI foreign key (ID_KEL_TIPE_OBSERVASI)
      references R_KELOMPOK_TIPE_OBSERVASI (ID_KEL_TIPE_OBSERVASI)
go

alter table T_AREA_PERHATIAN_DETAIL
   add constraint FK_R_TIPE_AREA_PERHATIAN_T_AREA_PERHATIAN_DETAIL foreign key (ID_TIPE_AREA_PERHATIAN)
      references R_TIPE_AREA_PERHATIAN (ID_TIPE_AREA_PERHATIAN)
go

alter table T_AREA_PERHATIAN_DETAIL
   add constraint FK_R_WILAYAH_T_AREA_PERHATIAN_DETAIL foreign key (ID_WILAYAH)
      references R_WILAYAH (ID_WILAYAH)
go

alter table T_AREA_PERHATIAN_DETAIL
   add constraint FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL foreign key (TAHUN, BULAN)
      references T_KEGIATAN (TAHUN, BULAN)
go

alter table T_INSIDEN
   add constraint FK_R_KLASIFIKASI_PEGAWAI_T_INSIDEN foreign key (ID_KLASIFIKASI_PEGAWAI)
      references R_KLASIFIKASI_PEGAWAI (ID_KLASIFIKASI_PEGAWAI)
go

alter table T_INSIDEN
   add constraint FK_R_SEKSI_T_INSIDEN foreign key (ID_AREA_SEKSI, ID_AREA_DINAS, ID_AREA_DEPARTEMEN)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
go

alter table T_JSA_DETAIL
   add constraint FK_T_JSA_T_JSA_DETAIL foreign key (ID_JSA)
      references T_JSA (ID_JSA)
go

alter table T_KEGIATAN_DETAIL
   add constraint FK_R_TIPE_KEGIATAN_T_KEGIATAN_DETAIL foreign key (ID_TIPE_KEGIATAN)
      references R_TIPE_KEGIATAN (ID_TIPE_KEGIATAN)
go

alter table T_KEGIATAN_DETAIL
   add constraint FK_R_WILAYAH_T_KEGIATAN_DETAIL foreign key (ID_WILAYAH)
      references R_WILAYAH (ID_WILAYAH)
go

alter table T_KEGIATAN_DETAIL
   add constraint FK_T_KEGIATAN_T_KEGIATAN_DETAIL foreign key (TAHUN, BULAN)
      references T_KEGIATAN (TAHUN, BULAN)
go

alter table T_PEGAWAI_KOMITE_SUB_KOMITE
   add constraint FK_R_JABATAN_KOMITE_T_PEGAWAI_KOMITE foreign key (ID_JABATAN_KOMITE)
      references R_JABATAN_KOMITE_SUB_KOMITE (ID_JABATAN_KOMITE)
go

alter table T_PEGAWAI_KOMITE_SUB_KOMITE
   add constraint FK_R_PEGAWAI_T_PEGAWAI_KOMITE foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_PELATIHAN
   add constraint FK_R_PELATIHAN_T_PELATIHAN foreign key (ID_PELATIHAN)
      references R_PELATIHAN (ID_PELATIHAN)
go

alter table T_PELATIHAN_PESERTA
   add constraint FK_R_PEGAWAI_T_PELATIHAN_PESERTA foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_PELATIHAN_PESERTA
   add constraint FK_T_PELATIHAN_T_PELATIHAN_PESERTA foreign key (ID)
      references T_PELATIHAN (ID)
go

alter table T_PENGELOLAAN_LINGKUNGAN
   add constraint FK_R_WILAYAH_T_PENGELOLAAN_LINGKUNGAN foreign key (ID_WILAYAH)
      references R_WILAYAH (ID_WILAYAH)
go

alter table T_PIC_RAPAT_MATERI
   add constraint FK_T_RAPAT_MATERI_T_PIC_RAPAT_MATERI foreign key (ID_RAPAT_MATERI, ID_RAPAT)
      references T_RAPAT_MATERI (ID_RAPAT_MATERI, ID_RAPAT)
go

alter table T_PIC_RAPAT_SUB_MATERI
   add constraint FK_T_RAPAT_SUB_MATERI_T_PIC_RAPAT_SUB_MATERI foreign key (ID_RAPAT_SUB_MATERI, ID_RAPAT_MATERI, ID_RAPAT)
      references T_RAPAT_SUB_MATERI (ID_RAPAT_SUB_MATERI, ID_RAPAT_MATERI, ID_RAPAT)
go

alter table T_PTW
   add constraint FK_T_JSA_T_PTW foreign key (ID_JSA)
      references T_JSA (ID_JSA)
go

alter table T_PTW_ALAT_PELINDUNG_DIRI
   add constraint FK_R_ALAT_PELINDUNG_DIRI_PTW foreign key (ID_ALAT_PELINDUNG_DIRI_PTW)
      references R_ALAT_PELINDUNG_DIRI_PTW (ID_ALAT_PELINDUNG_DIRI_PTW)
go

alter table T_PTW_ALAT_PELINDUNG_DIRI
   add constraint FK_T_PTW_T_PTW_ALAT_PELINDUNG_DIRI_PTW foreign key (ID_PTW)
      references T_PTW (ID_PTW)
go

alter table T_PTW_JENIS_PEKERJAAN
   add constraint FK_R_JENIS_PEKERJAAN_PTW_T_PTW_JENIS_PEKERJAAN foreign key (ID_JENIS_PEKERJAAN_PTW)
      references R_JENIS_PEKERJAAN_PTW (ID_JENIS_PEKERJAAN_PTW)
go

alter table T_PTW_JENIS_PEKERJAAN
   add constraint FK_T_PTW_T_PTW_JENIS_PEKERJAAN foreign key (ID_PTW)
      references T_PTW (ID_PTW)
go

alter table T_PTW_SAFETY_CHECKLIST
   add constraint FK_R_SAFETY_CHECKLIST_PTW_T_PTW_SAFETY_CHECKLIST foreign key (ID_SAFETY_CHECKLIST_PTW)
      references R_SAFETY_CHECKLIST_PTW (ID_SAFETY_CHECKLIST_PTW)
go

alter table T_PTW_SAFETY_CHECKLIST
   add constraint FK_T_PTW_T_PTW_SAFETY_CHECKLIST foreign key (ID_PTW)
      references T_PTW (ID_PTW)
go

alter table T_PTW_SBAK
   add constraint FK_R_SBAK_PTW_T_PTW_SBAK foreign key (ID_SBAK_PTW)
      references R_SBAK_PTW (ID_SBAK_PTW)
go

alter table T_PTW_SBAK
   add constraint FK_T_PTW_T_PTW_SBAK foreign key (ID_PTW)
      references T_PTW (ID_PTW)
go

alter table T_PTW_UJI_KANDUNGAN_GAS
   add constraint FK_R_UJI_KANDUNGAN_GAS_PTW_T_PTW_UJI_KANDUNGAN_GAS foreign key (ID_UJI_KANDUNGAN_GAS_PTW)
      references R_UJI_KANDUNGAN_GAS_PTW (ID_UJI_KANDUNGAN_GAS_PTW)
go

alter table T_PTW_UJI_KANDUNGAN_GAS
   add constraint FK_T_PTW_T_PTW_UJI_KANDUNGAN_GAS foreign key (ID_PTW)
      references T_PTW (ID_PTW)
go

alter table T_PTW_VALIDASI
   add constraint FK_T_PTW_T_PTW_VALIDASI foreign key (ID_PTW)
      references T_PTW (ID_PTW)
go

alter table T_RAPAT
   add constraint FK_R_KEL_JABATAN_KOMITE_SUB_KOMITE_T_RAPAT foreign key (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
      references R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE)
go

alter table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE
   add constraint FK_T_PEGAWAI_KOMITE_T_RAPAT_ABSENSI_KOMITE foreign key (NIPG, ID_JABATAN_KOMITE)
      references T_PEGAWAI_KOMITE_SUB_KOMITE (NIPG, ID_JABATAN_KOMITE)
go

alter table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE
   add constraint FK_T_RAPAT_T_RAPAT_ABSENSI_KOMITE foreign key (ID_RAPAT)
      references T_RAPAT (ID_RAPAT)
go

alter table T_RAPAT_MATERI
   add constraint FK_T_RAPAT_T_RAPAT_MATERI foreign key (ID_RAPAT)
      references T_RAPAT (ID_RAPAT)
go

alter table T_RAPAT_SUB_MATERI
   add constraint FK_T_RAPAT_MATERI_T_RAPAT_SUB_MATERI foreign key (ID_RAPAT_MATERI, ID_RAPAT)
      references T_RAPAT_MATERI (ID_RAPAT_MATERI, ID_RAPAT)
go

alter table T_RCA_AUDITOR
   add constraint FK_R_PEGAWAI_T_RCA_AUDITOR foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_RCA_AUDITOR
   add constraint FK_T_RCA_T_RCA_AUDITOR foreign key (ID_RCA)
      references T_RCA (ID_RCA)
go

alter table T_RCA_DETAIL
   add constraint FK_R_SEVERITY_T_RCA_DETAIL foreign key (ID_SEVERITY)
      references R_SEVERITY (ID_SEVERITY)
go

alter table T_RCA_DETAIL
   add constraint FK_T_RCA_T_RCA_DETAIL foreign key (ID_RCA)
      references T_RCA (ID_RCA)
go

alter table T_RCA_TARGET_PEGAWAI
   add constraint FK_R_PEGAWAI_T_RCA_TARGET_PEGAWAI foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_STOP
   add constraint FK_R_PEGAWAI_T_STOP foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_STOP
   add constraint FK_R_SEKSI_T_STOP foreign key (ID_AREA_SEKSI, ID_AREA_DINAS, ID_AREA_DEPARTEMEN)
      references R_SEKSI (ID_SEKSI, ID_DINAS, ID_DEPARTEMEN)
go

alter table T_STOP_DETAIL
   add constraint FK_R_DETAIL_TIPE_OBSERVASI_T_STOP_DETAIL foreign key (ID_DETAIL_TIPE_OBSERVASI, ID_TIPE_OBSERVASI, ID_KEL_TIPE_OBSERVASI)
      references R_DETAIL_TIPE_OBSERVASI (ID_DETAIL_TIPE_OBSERVASI, ID_TIPE_OBSERVASI, ID_KEL_TIPE_OBSERVASI)
go

alter table T_STOP_DETAIL
   add constraint FK_T_STOP_T_STOP_DETAIL foreign key (ID_STOP)
      references T_STOP (ID_STOP)
go

alter table T_STOP_TARGET_PEGAWAI
   add constraint FK_R_PEGAWAI_T_STOP_TARGET_PEGAWAI foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table T_UNJUK_KERJA
   add constraint FK_R_KLASIFIKASI_PEGAWAI_T_UNJUK_KERJA foreign key (ID_KLASIFIKASI_PEGAWAI)
      references R_KLASIFIKASI_PEGAWAI (ID_KLASIFIKASI_PEGAWAI)
go

alter table __HAK_AKSES
   add constraint FK___GRUP_USER___HAK_AKSES foreign key (ID_GRUP)
      references __GRUP_USER (ID_GRUP)
go

alter table __HAK_AKSES
   add constraint FK___MENU___HAK_AKSES foreign key (MENU_ID)
      references __MENU (MENU_ID)
go

alter table __LOG
   add constraint FK___USER___LOG foreign key (NIPG)
      references __USER (NIPG)
go

alter table __USER
   add constraint FK_R_PEGAWAI___USER foreign key (NIPG)
      references R_PEGAWAI (NIPG)
go

alter table __USER_GRUP
   add constraint FK___GRUP_USER___USER_GRUP foreign key (ID_GRUP)
      references __GRUP_USER (ID_GRUP)
go

alter table __USER_GRUP
   add constraint FK___USER___USER_GRUP foreign key (NIPG)
      references __USER (NIPG)
go


create function FN_GET_DEP_PART_MONTHLY
(
    @id_departemen	varchar(20),
    @year			int
)
RETURNS varchar(100)
begin
DECLARE @result varchar(100);

select @result= cast(JAN.v as varchar) +','+
		cast(FEB.v as varchar) +','+
		cast(MAR.v as varchar) +','+
		cast(APR.v as varchar) +','+
		cast(MAY.v as varchar) +','+
		cast(JUN.v as varchar) +','+
		cast(JUL.v as varchar) +','+
		cast(AUG.v as varchar) +','+
		cast(SEP.v as varchar) +','+
		cast(OCT.v as varchar) +','+
		cast(NOV.v as varchar) +','+
		cast(DEC.v as varchar) +','+
		cast(TOTAL.v as varchar)
from
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 1
) JAN,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 2
) FEB,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 3
) MAR,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 4
) APR,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 5
) MAY,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 6
) JUN,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 7
) JUL,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 8
) AUG,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 9
) SEP,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 10
) OCT,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 11
) NOV,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
	and	month		= 12
) DEC,
(
	select	count(id_stop) v
	from	t_stop
	where	id_departemen	= @id_departemen
	and	status_aktif	= '1'
	and	year		= @year
) TOTAL;

	RETURN @result;
end
go


create function FN_GET_PEG_PART_MONTHLY 
(
	@nipg		varchar(20)
,	@year		int
,	@id_dep		int
,	@id_dinas	int
,	@id_seksi	int
)
RETURNS varchar(100)
begin
	DECLARE @result varchar(100);

	select @result= cast(JAN.v as varchar) +','+
			cast(FEB.v as varchar) +','+
			cast(MAR.v as varchar) +','+
			cast(APR.v as varchar) +','+
			cast(MAY.v as varchar) +','+
			cast(JUN.v as varchar) +','+
			cast(JUL.v as varchar) +','+
			cast(AUG.v as varchar) +','+
			cast(SEP.v as varchar) +','+
			cast(OCT.v as varchar) +','+
			cast(NOV.v as varchar) +','+
			cast(DEC.v as varchar) +','+
			cast(TOTAL.v as varchar)
	from
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 1
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) JAN,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 2
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) FEB,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 3
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) MAR,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 4
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) APR,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 5
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) MAY,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 6
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) JUN,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 7
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) JUL,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 8
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) AUG,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 9
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) SEP,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 10
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) OCT,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 11
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) NOV,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		month		= 12
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) DEC,
	(
		select	count(id_stop) v
		from	t_stop
		where	nipg			= @nipg
		and		status_aktif	= '1'
		and		year		= @year
		and		id_departemen	= @id_dep
		and		id_dinas	= @id_dinas
		and		id_seksi	= @id_seksi
	) TOTAL;

	RETURN @result;
end
go


create function FN_GET_RCA_PARTISIPASI_ALL
(
    @bulan          int
,   @tahun          int
)
RETURNS int
begin
    declare @result int;
    
    select  @result = count(b.nipg)
    from    t_rca           as a
        ,   t_rca_auditor   as b
        ,   r_pegawai       as c
    where   a.id_rca                = b.id_rca
    and     month(a.tanggal_rca)    = @bulan
    and     year(a.tanggal_rca)     = @tahun
    and     b.nipg                  = c.nipg
    and     c.status_pegawai        = '1'
    and     b.status                in (1,2)
    
    return  @result;
end
go


create function FN_GET_RCA_PARTISIPASI_DEP
(
    @id_departemen  int
,   @bulan          int
,   @tahun          int
)
RETURNS int
begin
    declare @result int;
    
    select  @result = count(b.nipg)
    from    t_rca           as a
        ,   t_rca_auditor   as b
        ,   r_pegawai       as c
    where   a.id_rca                = b.id_rca
    and     a.auditor_departemen    = @id_departemen
    and     month(a.tanggal_rca)    = @bulan
    and     year(a.tanggal_rca)     = @tahun
    and     b.nipg                  = c.nipg
    and     c.status_pegawai        = '1'
    and     b.status                in (1,2)
    
    return  @result;
end
go


create function FN_GET_RCA_TARGET_ALL
(
    @bulan          int
,   @tahun          int
)
RETURNS int
begin
    DECLARE @result int;
    
    
    select  @result = 
            case    @bulan
                when    1   then    sum(a.jan)
                when    2   then    sum(a.feb)
                when    3   then    sum(a.mar)
                when    4   then    sum(a.apr)
                when    5   then    sum(a.may)
                when    6   then    sum(a.jun)
                when    7   then    sum(a.jul)
                when    8   then    sum(a.aug)
                when    9   then    sum(a.sep)
                when   10   then    sum(a.oct)
                when   11   then    sum(a.nov)
                else                sum(a.dec)
            end
    from    t_rca_target_pegawai    as a
    ,       r_pegawai               as b
    where   a.nipg                  = b.nipg
    and     a.year                  = @tahun
    and     b.status_pegawai        = '1';
    
    return  @result;
end
go


create function FN_GET_RCA_TARGET_DEP
(
    @id_departemen  int
,   @bulan          int
,   @tahun          int
)
RETURNS int
begin
    DECLARE @result int;
    
    
    select  @result = 
            case    @bulan
                when    1   then    sum(a.jan)
                when    2   then    sum(a.feb)
                when    3   then    sum(a.mar)
                when    4   then    sum(a.apr)
                when    5   then    sum(a.may)
                when    6   then    sum(a.jun)
                when    7   then    sum(a.jul)
                when    8   then    sum(a.aug)
                when    9   then    sum(a.sep)
                when   10   then    sum(a.oct)
                when   11   then    sum(a.nov)
                else                sum(a.dec)
            end
    from    t_rca_target_pegawai    as a
    ,       r_pegawai               as b
    where   a.nipg                  = b.nipg
    and     a.year                  = @tahun
    and     b.status_pegawai        = '1'
    and     b.id_departemen         = @id_departemen;
    
    return  @result;
end
go


create function FN_GET_RCA_TARGET_YEAR
(
    @bulan  int
,   @tahun  int
)
RETURNS int
begin
    DECLARE @result int;
    
    select  @result =   
            case    @bulan
                when    1   then    sum(a.jan)
                when    2   then    sum(a.jan) + sum(a.feb)
                when    3   then    sum(a.jan) + sum(a.feb) + sum(a.mar)
                when    4   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr)
                when    5   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may)
                when    6   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun)
                when    7   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul)
                when    8   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug)
                when    9   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep)
                when   10   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep) + sum(a.oct)
                when   11   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep) + sum(a.oct) + sum(a.nov)
                else                sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep) + sum(a.oct) + sum(a.nov) + sum(a.dec)
            end
    from    t_rca_target_pegawai    as a
    ,       r_pegawai               as b
    where   a.nipg                  = b.nipg
    and     a.year                  = @tahun
    and     b.status_pegawai        = '1';
    
    return  @result;
end
go


create function FN_GET_STOP_OBS_TIME_ALL
(
    @bulan      int
,   @tahun      int
)
RETURNS bigint
begin
    DECLARE @result bigint;
    
    select  @result = sum(lama_observasi)
    from    t_stop
    where   month           = @bulan
    and     year            = @tahun
    and     status_aktif    = '1';
    
    return  @result;
end
go


create function FN_GET_STOP_OBS_TIME_DEP
(
    @id_departemen  int
,   @bulan          int
,   @tahun          int
)
RETURNS bigint
begin
    DECLARE @result bigint;
    
    select  @result = sum(lama_observasi)
    from    t_stop
    where   id_area_departemen  = @id_departemen
    and     month               = @bulan
    and     year                = @tahun
    and     status_aktif        = '1';
    
    return  @result;
end
go


create function FN_GET_STOP_OBS_TIME_YEAR
(
    @bulan      int
,   @tahun      int
)
RETURNS bigint
begin
    DECLARE @result bigint;
    
    select  @result = sum(lama_observasi)
    from    t_stop
    where   year            = @tahun
    and     month          <= @bulan
    and     status_aktif    = '1';
    
    return  @result;
end
go


create function FN_GET_STOP_PARTISIPASI_ALL
(
    @bulan          int
,   @tahun          int
)
RETURNS int
begin
    declare @result int;
    
    select  @result = count(nipg)
    from    t_stop
    where   month           = @bulan
    and     year            = @tahun
    and     status_aktif    = '1'
    return  @result;
end
go


create function FN_GET_STOP_PARTISIPASI_DEP
(
    @id_departemen  int
,   @bulan          int
,   @tahun          int
)
RETURNS int
begin
    declare @result int;
    
    select  @result = count(nipg)
    from    t_stop
    where   id_departemen   = @id_departemen
    and     month           = @bulan
    and     year            = @tahun
    and     status_aktif    = '1'
    return  @result;
end
go


create function FN_GET_STOP_TARGET_ALL
(
    @bulan          int
,   @tahun          int
)
RETURNS int
begin
    DECLARE @result int;
    
    
    select  @result = 
            case    @bulan
                when    1   then    sum(a.jan)
                when    2   then    sum(a.feb)
                when    3   then    sum(a.mar)
                when    4   then    sum(a.apr)
                when    5   then    sum(a.may)
                when    6   then    sum(a.jun)
                when    7   then    sum(a.jul)
                when    8   then    sum(a.aug)
                when    9   then    sum(a.sep)
                when   10   then    sum(a.oct)
                when   11   then    sum(a.nov)
                else                sum(a.dec)
            end
    from    t_stop_target_pegawai    as a
    ,       r_pegawai               as b
    where   a.nipg                  = b.nipg
    and     a.year                  = @tahun
    and     b.status_pegawai        = '1';
    
    return  @result;
end
go


create function FN_GET_STOP_TARGET_DEP
(
    @id_departemen  int
,   @bulan          int
,   @tahun          int
)
RETURNS int
begin
    DECLARE @result int;
    
    
    select  @result = 
            case    @bulan
                when    1   then    sum(a.jan)
                when    2   then    sum(a.feb)
                when    3   then    sum(a.mar)
                when    4   then    sum(a.apr)
                when    5   then    sum(a.may)
                when    6   then    sum(a.jun)
                when    7   then    sum(a.jul)
                when    8   then    sum(a.aug)
                when    9   then    sum(a.sep)
                when   10   then    sum(a.oct)
                when   11   then    sum(a.nov)
                else                sum(a.dec)
            end
    from    t_stop_target_pegawai   as a
    ,       r_pegawai               as b
    where   a.nipg                  = b.nipg
    and     a.year                  = @tahun
    and     b.status_pegawai        = '1'
    and     b.id_departemen         = @id_departemen;
    
    return  @result;
end
go


create function FN_GET_STOP_TARGET_YEAR
(
    @bulan  int
,   @tahun  int
)
RETURNS int
begin
    DECLARE @result int;
    
    
    select  @result =   
            case    @bulan
                when    1   then    sum(a.jan)
                when    2   then    sum(a.jan) + sum(a.feb)
                when    3   then    sum(a.jan) + sum(a.feb) + sum(a.mar)
                when    4   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr)
                when    5   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may)
                when    6   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun)
                when    7   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul)
                when    8   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug)
                when    9   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep)
                when   10   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep) + sum(a.oct)
                when   11   then    sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep) + sum(a.oct) + sum(a.nov)
                else                sum(a.jan) + sum(a.feb) + sum(a.mar) + sum(a.apr) + sum(a.may) + sum(a.jun) + sum(a.jul) + sum(a.aug) + sum(a.sep) + sum(a.oct) + sum(a.nov) + sum(a.dec)
            end
    from    t_stop_target_pegawai   as a
    ,       r_pegawai               as b
    where   a.nipg                  = b.nipg
    and     a.year                  = @tahun
    and     b.status_pegawai        = '1';
    
    return  @result;
end
go


create function FN_GET_TEMUAN_45_ALL
(
    @tahun          int,
    @bulan          smallint
)
RETURNS int
begin
    DECLARE @result int;
    
    select  @result = isnull(count(*),0)
    from    t_rca_detail    as a,
            t_rca           as b
    where   a.id_rca                = b.id_rca
    and     year(b.tanggal_rca)     = @tahun
    and     month(b.tanggal_rca)    = @bulan
    and     a.id_severity           in (4,5);
    
    return  @result;
end
go


create function FN_GET_TEMUAN_45_DEP
(
    @tahun          int,
    @bulan          smallint,
    @id_departemen  int
)
RETURNS int
begin
    DECLARE @result int;
    
    select  @result = isnull(count(*),0)
    from    t_rca_detail    as a,
            t_rca           as b
    where   a.id_rca                        = b.id_rca
    and     year(b.tanggal_rca)             = @tahun
    and     month(b.tanggal_rca)            = @bulan
    and     a.id_severity                   in (4,5)
    and     b.penanggung_jawab_departemen   = @id_departemen;
    
    return  @result;
end
go


create function FN_GET_TEMUAN_45_YEAR
(
    @tahun          int
,   @bulan          smallint
)
RETURNS int
begin
    DECLARE @result int;
    
    select  @result = isnull(count(*),0)
    from    t_rca_detail    as a,
            t_rca           as b
    where   a.id_rca                        = b.id_rca
    and     year(b.tanggal_rca)             = @tahun
    and     month(b.tanggal_rca)           <= @bulan
    and     a.id_severity                   in (4,5);
    
    return  @result;
end
go


create function FN_GET_TEMUAN_ALL
(
    @tahun          int,
    @bulan          smallint
)
RETURNS int
begin
    DECLARE @result int;
    
    select  @result = isnull(count(*),0)
    from    t_rca_detail    as a,
            t_rca           as b
    where   a.id_rca                = b.id_rca
    and     year(b.tanggal_rca)     = @tahun
    and     month(b.tanggal_rca)    = @bulan;
    
    return  @result;
end
go


create function FN_GET_TEMUAN_DEP
(
    @tahun          int,
    @bulan          smallint,
    @id_departemen  int
)
RETURNS int
begin
    DECLARE @result int;
    
    select  @result = isnull(count(*),0)
    from    t_rca_detail    as a,
            t_rca           as b
    where   a.id_rca                        = b.id_rca
    and     year(b.tanggal_rca)             = @tahun
    and     month(b.tanggal_rca)            = @bulan
    and     b.penanggung_jawab_departemen   = @id_departemen;
    
    return  @result;
end
go


create function FN_GET_TEMUAN_YEAR
(
    @tahun          int
,   @bulan          int
)
RETURNS int
begin
    DECLARE @result int;
    
    select  @result = isnull(count(*),0)
    from    t_rca_detail    as a,
            t_rca           as b
    where   a.id_rca                = b.id_rca
    and     year(b.tanggal_rca)     = @tahun
    and     month(b.tanggal_rca)   <= @bulan;
    
    return  @result;
end
go


create procedure SP_HISTORY
    @nipg varchar(20),
    @nama_menu varchar(100),
    @status_akses char(1)
as
begin
    insert into __LOG (NIPG, NAMA_MENU, STATUS_AKSES)
    values (@nipg, @nama_menu, @status_akses)
end
go


create trigger T_PTW_AIR
on T_PTW
after insert
as
begin
    set NOCOUNT on;
    
    declare @jenis_ptw  char(1)
    declare @id_ptw     int
    declare @id_user    varchar(20)
    
    select @jenis_ptw   = (select jenis_ptw from inserted)
    select @id_ptw      = (select id_ptw    from inserted)
    select @id_user     = (select id_user   from inserted)
    
    insert into T_PTW_ALAT_PELINDUNG_DIRI (id_ptw, id_alat_pelindung_diri_ptw, id_user)
    select  @id_ptw
        ,   id_alat_pelindung_diri_ptw
        ,   @id_user
    from    r_alat_pelindung_diri_ptw
    
    insert into T_PTW_SAFETY_CHECKLIST (id_ptw, id_safety_checklist_ptw, id_user)
    select  @id_ptw
        ,   id_safety_checklist_ptw
        ,   @id_user
    from    r_safety_checklist_ptw
    where   jenis_ptw = @jenis_ptw
    
    if (@jenis_ptw in ('1','3','5'))
    begin
        insert into T_PTW_UJI_KANDUNGAN_GAS(id_ptw, id_uji_kandungan_gas_ptw, id_user)
        select  @id_ptw
            ,   id_uji_kandungan_gas_ptw
            ,   @id_user
        from    r_uji_kandungan_gas_ptw
    end
end
go

