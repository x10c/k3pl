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


if exists (select 1
            from  sysobjects
           where  id = object_id('V_SEVERITY')
            and   type = 'V')
   drop view V_SEVERITY
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

delete __HAK_AKSES;
delete __MENU;
delete R_JABATAN_KOMITE_SUB_KOMITE;
delete R_KEL_JABATAN_KOMITE_SUB_KOMITE;
delete R_TIPE_KEGIATAN;
delete R_UJI_KANDUNGAN_GAS_PTW;
delete R_ALAT_PELINDUNG_DIRI_PTW;
delete R_SBAK_PTW;
delete R_JENIS_PEKERJAAN_PTW;
delete R_PELATIHAN;
delete R_PELATIHAN_KELOMPOK;
delete R_DETAIL_TIPE_OBSERVASI;
delete R_TIPE_OBSERVASI;
delete R_KELOMPOK_TIPE_OBSERVASI;
delete __USER_GRUP;
delete __USER;
delete __GRUP_USER;
delete R_PEGAWAI;
delete R_KLASIFIKASI_PEGAWAI;
delete R_JABATAN;
delete R_SEKSI;
delete R_DINAS;
delete R_DEPARTEMEN;
delete R_WILAYAH;

insert into R_WILAYAH (id_user, nama_wilayah) values ('1', 'Jakarta');
insert into R_WILAYAH (id_user, nama_wilayah) values ('1', 'Bekasi');
insert into R_WILAYAH (id_user, nama_wilayah) values ('1', 'Karawang');
insert into R_WILAYAH (id_user, nama_wilayah) values ('1', 'Cirebon');
insert into R_WILAYAH (id_user, nama_wilayah) values ('1', 'Bogor');
insert into R_WILAYAH (id_user, nama_wilayah) values ('1', 'Banten');
insert into R_WILAYAH (id_user, nama_wilayah) values ('1', 'Palembang');

insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Departemen Penjualan dan Layanan');
insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Departemen Operasi dan Pemeliharaan');
insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Departemen Integritas Jaringan dan K3PL');
insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Departemen Enjiniring dan Pembangunan');
insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Departemen Keuangan dan SDM');
insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Departemen Logistik dan Administrasi Umum');
insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Hukum dan Humas');
insert into R_DEPARTEMEN (id_user, nama_departemen) values ('1', 'Pengendalian Kinerja');

insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 1, 'Dinas Dispatching Center');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 1, 'Dinas Perencanaan Penjualan');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 1, 'Dinas Penjualan dan Layanan Area Banten');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 1, 'Dinas Penjualan dan Layanan Area Jakarta-Bogor');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 1, 'Dinas Penjualan dan Layanan Area Bekasi-Karawang');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 1, 'Dinas Penjualan dan Layanan Area Cirebon');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 1, 'Dinas Penjualan dan Layanan Area Palembang');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 2, 'Dinas Sistem Manajemen Gas');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 2, 'Dinas Operasi dan Pemeliharaan Wilayah I');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 2, 'Dinas Operasi dan Pemeliharaan Wilayah II');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 2, 'Dinas Workshop');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 3, 'Dinas Integritas Jaringan');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 3, 'Dinas K3PL');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 4, 'Dinas Perencanaan dan Layanan Enjiniring');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 4, 'Dinas Pembangunan');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 5, 'Dinas Keuangan');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 5, 'Dinas Sumber Daya Manusia');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 6, 'Dinas Logistik');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 6, 'Dinas Administrasi Umum');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 7, 'Hukum');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 7, 'Humas');
insert into R_DINAS (id_user, id_departemen, nama_dinas) values ('1', 8, 'Pengendalian Kinerja');

insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  1, 1, 'Dispacthing Center');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  2, 1, 'Perencanaan Penjualan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  3, 6, 'Penjualan dan Layanan Area Banten Timur');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  3, 6, 'Penjualan dan Layanan Area Banten Barat');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  4, 1, 'Penjualan dan Layanan Area Jakarta');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  4, 5, 'Penjualan dan Layanan Area Bogor');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  5, 2, 'Penjualan dan Layanan Area Bekasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  5, 3, 'Penjualan dan Layanan Area Karawang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  6, 4, 'Penjualan dan Layanan Area Cirebon');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 1,  7, 7, 'Penjualan dan Layanan Area Palembang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2,  8, 1, 'Perencanaan dan Pengendalian Penyaluran Gas');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2,  8, 1, 'Operasi dan Pemeliharaan Scada & Telekomunikasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2,  9, 1, 'Operasi dan Pemeliharaan Sub Wilayah Jakarta');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2,  9, 5, 'Operasi dan Pemeliharaan Sub Wilayah Bogor');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2,  9, 6, 'Operasi dan Pemeliharaan Sub Wilayah Banten Timur');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2,  9, 6, 'Operasi dan Pemeliharaan Sub Wilayah Banten Barat');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2, 10, 2, 'Operasi dan Pemeliharaan Sub Wilayah Bekasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2, 10, 3, 'Operasi dan Pemeliharaan Sub Wilayah Karawang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2, 10, 4, 'Operasi dan Pemeliharaan Sub Wilayah Cirebon');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2, 10, 7, 'Operasi dan Pemeliharaan Sub Wilayah Palembang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 2, 11, 1, 'Workshop Klender');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 3, 12, 1, 'Manajemen Informasi Jaringan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 3, 12, 1, 'Assessmen Jaringan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 3, 13, 1, 'Keselamatan dan Kesehatan Kerja');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 3, 13, 1, 'Pengelolaan Lingkungan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 14, 1, 'Perencanaan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 14, 1, 'Layanan Enjiniring');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 1, 'Perencanaan Pembangunan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 1, 'Pengendalian Pembangunan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 1, 'Pembangunan Jakarta');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 2, 'Pembangunan Bekasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 3, 'Pembangunan Karawang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 4, 'Pembangunan Cirebon');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 5, 'Pembangunan Bogor');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 6, 'Pembangunan Banten');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 4, 15, 7, 'Pembangunan Palembang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 5, 16, 1, 'Anggaran');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 5, 16, 1, 'Perbendaharaan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 5, 16, 1, 'Akuntansi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 5, 16, 1, 'Pajak');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 5, 17, 1, 'Pembinaan SDM dan Hubungan Industrial');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 5, 17, 1, 'Pengembangan SDM');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 5, 17, 1, 'Renumerisasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 1, 'Kelompok Pengadaan');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 1, 'Administrasi Logistik');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 1, 'Persediaan (Gudang) Jakarta');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 1, 'Layanan Umum Jakarta');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 1, 'Teknologi Informasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 7, 20, 1, 'Hukum');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 7, 21, 1, 'Humas');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 8, 22, 1, 'Pengendalian Kinerja');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 6, 'Persediaan (Gudang) Banten');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 2, 'Persediaan (Gudang) Bekasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 5, 'Persediaan (Gudang) Bogor');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 4, 'Persediaan (Gudang) Cirebon');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 3, 'Persediaan (Gudang) Karawang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 18, 7, 'Persediaan (Gudang) Palembang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 6, 'Layanan Umum Banten');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 2, 'Layanan Umum Bekasi');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 5, 'Layanan Umum Bogor');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 4, 'Layanan Umum Cirebon');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 3, 'Layanan Umum Karawang');
insert into R_SEKSI (id_user, id_departemen, id_dinas, id_wilayah, nama_seksi) values('1', 6, 19, 7, 'Layanan Umum Palembang');


insert into R_JABATAN(id_user, nama_jabatan) values('1','Senior Staff');
insert into R_JABATAN(id_user, nama_jabatan) values('1','General Manager');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Kepala Dinas');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Pelaksana');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Staff');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Kepala Departemen');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Kepala Seksi');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Operator');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Specialist');
insert into R_JABATAN(id_user, nama_jabatan) values('1','Account Executive');

insert into R_KLASIFIKASI_PEGAWAI (id_user, nama_klasifikasi_pegawai) values('1', 'Teknik');
insert into R_KLASIFIKASI_PEGAWAI (id_user, nama_klasifikasi_pegawai) values('1', 'Service');
insert into R_KLASIFIKASI_PEGAWAI (id_user, nama_klasifikasi_pegawai) values('1', 'Kontrak');

insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1','Administrator',1,1,1,1,1,'','1','1');

insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Administrator', 'Sistem Administrator');
insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Pelaksana Observasi', 'Sistem Observasi');
insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Central Committee', 'Sistem Safety Central Committee Meeting');
insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Sub Committee', 'Sistem Safety Sub Committee Meeting');
insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Pelaksana RCA', 'Sistem RCA');
insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Entri Laporan Bulanan', 'Sistem Laporan Bulanan');
insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Audit Laporan Bulanan', 'Sistem Laporan Bulanan');
insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Management', 'View Applikasi');

insert into __USER (nipg, password, status_user) values ('1', '4d75f9dbdfad8802a02230c7cacf18431eed015050bae8dbee22cf2cef8e0b5f', '1');

insert into __USER_GRUP (nipg, id_grup) values ('1', '1');

insert into R_KELOMPOK_TIPE_OBSERVASI (id_user, nama_kel_tipe_observasi) values('1', 'Tindakan');
insert into R_KELOMPOK_TIPE_OBSERVASI (id_user, nama_kel_tipe_observasi) values('1', 'Kondisi');

insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 1, 'Reaksi Orang');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 1, 'Alat Pelindung Diri');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 1, 'Posisi Orang');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 1, 'Peralatan dan Perlengkapan');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 1, 'Prosedur');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 1, 'Kerapihan');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 2, 'Peralatan dan Perlengkapan');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 2, 'Struktur dan Area Kerja');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 2, 'Lingkungan');
insert into R_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, nama_tipe_observasi) values('1', 2, 'Kerapihan');

insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  1, 'Menyesuaikan Alat Pelindung Diri');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  1, 'Mengubah Posisi');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  1, 'Mengatur Ulang Pekerjaan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  1, 'Menghentikan Pekerjaan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  1, 'Memasang Kabel Ground');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  1, 'Memasang Alat Pengunci');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  2, 'Kepala');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  2, 'Mata dan Muka');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  2, 'Telinga');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  2, 'Sistem Pernafasan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  2, 'Lengan dan Tangan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  2, 'Tubuh');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  2, 'Kaki dan Telapak Kaki');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Menabrak atau Tertabrak Benda');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Terperangkap di Dalam, di Atas atau di Antara Benda');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Terjatuh');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Terkena Suhu yang Ekstrim');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Tersengat Arus Listrik');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Menghirup, Menyerap, Menelan Zat-zat Berbahaya');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Gerakan Berulang');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  3, 'Posisi Tubuh yang Janggal/Statis');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  4, 'Sesuai untuk Pekerjaan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  4, 'Digunakan dengan Benar');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  4, 'Dalam Kondisi Aman');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  5, 'Tersedia');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  5, 'Memadai');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  5, 'Diketahui');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  5, 'Dimengerti');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  5, 'Diikuti');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  6, 'Diketahui');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  6, 'Dimengerti');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  1,  6, 'Diikuti');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  7, 'Sesuai untuk Pekerjaan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  7, 'Dalam Kondisi Aman');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  8, 'Bersih');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  8, 'Rapi');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  8, 'Sesuai untuk Pekerjaan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  8, 'Dalam Kondisi Aman');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  9, 'Bersih');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  9, 'Rapi');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2,  9, 'Sesuai untuk Pekerjaan');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2, 10, 'Tersedia');
insert into R_DETAIL_TIPE_OBSERVASI (id_user, id_kel_tipe_observasi, id_tipe_observasi, nama_detail_tipe_observasi) values('1',  2, 10, 'Memadai');

insert into R_PELATIHAN_KELOMPOK (id_user, nama) values ('1', 'Mandatory');
insert into R_PELATIHAN_KELOMPOK (id_user, nama) values ('1', 'Fungsional');
insert into R_PELATIHAN_KELOMPOK (id_user, nama) values ('1', 'Operasional');

insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 1, 'Safety Management');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 1, 'STOP');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 1, 'AECT');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 1, 'Office Safety');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 1, 'First-Aid Training');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 2, 'RCA');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 2, 'Emergency Response');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 2, 'Investigation Incident');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 2, 'CSM');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 2, 'Safety Driving');
insert into R_PELATIHAN (id_user, id_pelatihan_kelompok, nama_pelatihan) values('1', 3, 'Procedure Critical');

insert into R_JENIS_PEKERJAAN_PTW (id_user, nama_jenis_pekerjaan_ptw) values ('1', 'Menimbulkan Api');
insert into R_JENIS_PEKERJAAN_PTW (id_user, nama_jenis_pekerjaan_ptw) values ('1', 'Menimbulkan Bunga Api');
insert into R_JENIS_PEKERJAAN_PTW (id_user, nama_jenis_pekerjaan_ptw) values ('1', 'Mesin Gerinda/Alat Potong');
insert into R_JENIS_PEKERJAAN_PTW (id_user, nama_jenis_pekerjaan_ptw) values ('1', 'Hot Tapping');
insert into R_JENIS_PEKERJAAN_PTW (id_user, nama_jenis_pekerjaan_ptw) values ('1', 'Menyalakan Flare');

insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Listrik');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Gas');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Ergonomi');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Blasting');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Radiografi');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Lifting');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Hot Cutting');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Alat Listrik');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Bahan Kimia');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Bertekanan');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Penggalian');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Pada Ketinggian');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Drilling');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Bongkar Muat');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Moving Part');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Bising');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Mudah Terbakar');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Hot Tapping');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Pilling');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Blow-down');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Power Brushing');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Crane');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Kejatuhan');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Biologi');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Pengelasan');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Ruang Terbatas');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Uji Bertekanan');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Interlock Bypass');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Generator/Compressor');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Media Panas/Dingin');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Grinding');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Pigging');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Junction Box Opening');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Penggunaan Bahan Kimia');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Pengecatan');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Cold Cutting');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Kalibrasi');
insert into R_SBAK_PTW (id_user, nama_sbak_ptw) values ('1', 'Lainnya');

insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Kepala');
insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Wajah');
insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Pernafasan');
insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Telinga');
insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Tangan');
insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Badan');
insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Kaki');
insert into R_ALAT_PELINDUNG_DIRI_PTW (id_user, nama_alat_pelindung_diri_ptw) values ('1', 'Pada Ketinggian');

insert into R_UJI_KANDUNGAN_GAS_PTW (id_user, nama_uji_kandungan_gas_ptw, standard) values ('1', 'O2', '19.5% - 22%');
insert into R_UJI_KANDUNGAN_GAS_PTW (id_user, nama_uji_kandungan_gas_ptw, standard) values ('1', 'Toxic', 'Not More Than PEL');
insert into R_UJI_KANDUNGAN_GAS_PTW (id_user, nama_uji_kandungan_gas_ptw, standard) values ('1', 'Combustible', '< 10% LEL');

insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah dibebaskan dari tekanan', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah dikosongkan atau drain', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan blanking', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan dilepas', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan kerangan dikunci', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan diberi label', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah didorong atau flush dengan air', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah steaming out or purging', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diinginkan secara alamiah atau mekanis', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua saluran, drain dan kerangan pada jarak 15m, dan tempat pekerjaan telah ditutup', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Bahan mudah terbakar diamankan', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Alat pemadam kebakaran siap sedia', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Petugas pemadam kebakaran siap sedia', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua peralatan las telah diamankan', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Pekerjaan harus terus dibasahi dengan air', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Perlu dengan ijin kerja yang lain', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua mesin: diesel, kompressor dll. telah diamankan', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua pekerjaan telah disetujui untuk penggalian', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua penggerak utama peralatan listrik telah diisolasi dan diberi label', '1');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua penggerak utama peralatan listrik telah perlu pemeriksaan ulang', '1');

insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah dibebaskan dari tekanan', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah dikosongkan atau drain', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan blanking', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan dilepas', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan kerangan dikunci', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dengan diberi label', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah didorong atau flush dengan air', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah steaming out or purging', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diinginkan secara alamiah atau mekanis', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua pekerjaan telah disetujui untuk penggalian', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Perlu dengan ijin kerja yang lain', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Perlu dilakukan uji kandungan gas', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua penggerak utama peralatan listrik telah diisolasi dan diberi label', '2');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua penggerak utama peralatan listrik telah perlu pemeriksaan ulang', '2');

insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Ruang terbatas tersebut sesungguhnya telah dibebaskan dari tekanan', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Ruang terbatas tersebut sesungguhnya telah dikosongkan atau drain', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Ruang terbatas tersebut sesungguhnya telah diisolasi dengan blanking', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua sambungan listrik/hidrolik diluar dan didalam ruangan terbatas telah aman', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Aman dari kandungan gas beracun dan mudah terbakar', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Kandungan oksigen mencukupi', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Ventilasi udara pembantu tersedia', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Apakah terdapat kerja panas disekitar ruangan terbatas', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Apakah terdapat pekerjaan radiografi disekitar ruangan terbatas', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Perlu dengan ijin kerja yang lain', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Peringatan bahaya dan tanda batas tersedia', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua alat kerja penunjang aman untuk digunakan', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua pekerja terlatih untuk masuk ke ruangan terbatas', '3');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua pekerja telah lengkap alat pelindung diri', '3');

insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Peralatan dapat dioperasikan jarak jauh', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Petugas pemadam kebakaran siap sedia', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Penghalang dan tanda bahaya radiasi siap tersedia', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Daerah bebas dari orang tidak berkepentingan', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Hubungan radio hanya dengan CCR', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalan keluar dan masuk aman dari sumber radiasi', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua peralatan las telah diamankan', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Pembacaan hasil pengukuran pada pagar penghalang tidak boleh lebih dari 0.75 mR/jam diudara', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Alat pemadam api siap sedia', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Perlu dengan ijin kerja yang lain', '4');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Semua pekerja telah lengkap alat pelindung diri', '4');

insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah dibebaskan dari aliran listrik', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah peralatan yang terkait telah aman', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah pemasangan kabel', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah peralatan dalam keadaan bergeerak', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah diisolasi dari sumber listrik', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut sesungguhnya telah peralatan dalam keadaan panas', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Tersedia jalan masuk dan keluar yang layak', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Bahan mudah terbakar diamankan', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Alat pemadam kebakaran siap sedia', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Petugas pemadam kebakaran siap sedia', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Pekerjaan pada ketinggian yang membahayakan', '5');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Perlu dengan ijin kerja yang lain', '5');

insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut telah bebas dari kabel listrik bawah tanah', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut telah bebas dari kabel telepon bawah tanah', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut telah bebas dari kabel instrument bawah tanah', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut telah bebas dari gorong-gorong bawah tanah', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Jalur tersebut telah bebas dari pipa air/gas/minyak bawah tanah', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Dinding penggalian perlu di topang', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Rambu peringatan telah terpasang', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Lokasi telah di beri batas/pengalang', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Lokasi bebas dari area mudah terbakar', '6');
insert into R_SAFETY_CHECKLIST_PTW(id_user, nama_safety_checklist_ptw, jenis_ptw) values ('1', 'Perlu dengan ijin kerja yang lain', '6');

insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Audit');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Pelatihan/Induksi');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Rapat');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Inspeksi');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'JSA/HAZOP/Safety Review');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Institusi Pemerintah');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Investigasi Kecelakaan');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Pemantauan');
insert into R_TIPE_KEGIATAN(id_user, nama_tipe_kegiatan) values ('1', 'Lainnya');

insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Perilaku Tidak Aman');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Kurang Pengawasan/Supervisi');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Kurang Pengetahuan/Kesadaran');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Tidak Memenuhi Peraturan Perundang-undangan');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Kurang Komunikasi/Tanggung Jawab Tidak Jelas');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Kurang Sumber Daya/Kompetensi');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Kurang Tekad');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Kurang Prosedur');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Kondisi Tidak Aman');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Pelanggaran');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Housekeeping Kurang');
insert into R_TIPE_AREA_PERHATIAN(id_user, nama_tipe_area_perhatian) values ('1', 'Lainnya');

insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (id_kel_jabatan_komite_sub_komite,nama_kel_jabatan_komite_sub_komite,id_user) values (1,'central safety committee','1');
insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (id_kel_jabatan_komite_sub_komite,nama_kel_jabatan_komite_sub_komite,id_user) values (2,'sub committee rule and procedure','1');
insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (id_kel_jabatan_komite_sub_komite,nama_kel_jabatan_komite_sub_komite,id_user) values (3,'sub committee audit and observation','1');
insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (id_kel_jabatan_komite_sub_komite,nama_kel_jabatan_komite_sub_komite,id_user) values (4,'sub committee emergency and response','1');
insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (id_kel_jabatan_komite_sub_komite,nama_kel_jabatan_komite_sub_komite,id_user) values (5,'sub committee incident investigation','1');
insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (id_kel_jabatan_komite_sub_komite,nama_kel_jabatan_komite_sub_komite,id_user) values (6,'sub committee process safety management','1');
insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (id_kel_jabatan_komite_sub_komite,nama_kel_jabatan_komite_sub_komite,id_user) values (7,'sub committee contractor safety management','1');

insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (3,'Ketua (Chairman)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (3,'Sekretaris','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (3,'Anggota (Member)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (5,'Ketua (Chairman)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (5,'Sekretaris','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (5,'Anggota (Member)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (6,'Ketua (Chairman)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (6,'Sekretaris','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (6,'Anggota (Member)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (7,'Ketua (Chairman)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (7,'Sekretaris','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (7,'Anggota (Member)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (4,'Ketua (Chairman)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (4,'Sekretaris','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (4,'Anggota (Member)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (1,'Ketua (Chairman)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (1,'Sekretaris','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (1,'Anggota (Member)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (2,'Ketua (Chairman)','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (2,'Sekretaris','1');
insert into R_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_KOMITE_SUB_KOMITE,NAMA_JABATAN_KOMITE,ID_USER) values (2,'Anggota (Member)','1');

insert into R_SEVERITY(ID_USER, NAMA_SEVERITY) values ('1', 'Untidy area minor issues sets pool example');
insert into R_SEVERITY(ID_USER, NAMA_SEVERITY) values ('1', 'Restricated access, unacceptable trash, disorderly');
insert into R_SEVERITY(ID_USER, NAMA_SEVERITY) values ('1', 'Rule or procedure violation, potential injury');
insert into R_SEVERITY(ID_USER, NAMA_SEVERITY) values ('1', 'Unsafe condition, serious injury potential');
insert into R_SEVERITY(ID_USER, NAMA_SEVERITY) values ('1', 'Immediate serious injury potential, stop activity immediately and correct');

insert into R_K3PL values (
  0.5
, 1.2
, 1
, 10000000
, ''
, 0
, 0
, ''
, ''
, 0
, ''
, 'Notifikasi Input Data Observasi'
, 'Terima kasih telah melakukan input Observasi.'
, 0
, ''
, 'Notifikasi Input Data RCA'
, 'Terima kasih telah melakukan input RCA.'
, 'Notifikasi Penanggung Jawab Data RCA'
, 'Pegawai dengan NIPG %s telah menginputkan data RCA. Silahkan login untuk melakukan tindak lanjut.'
, '/images/gallery/'
, 10
, 7
);

insert into T_HOME_GALLERY (filename) values ('1.jpg');
insert into T_HOME_GALLERY (filename) values ('2.jpg');
insert into T_HOME_GALLERY (filename) values ('3.jpg');
insert into T_HOME_GALLERY (filename) values ('4.jpg');

insert into __MENU values ('01'		,'Aplikasi'									,'app'							,'0',1,'00','app');
insert into __MENU values ('01.01'	,'Home'										,'app_home'						,'1',2,'01','');
insert into __MENU values ('01.02'	,'Pengaturan User'							,'app_adm_user'					,'1',2,'01','');
insert into __MENU values ('01.03'	,'Pengaturan Hak Akses'						,'app_adm'						,'1',2,'01','');
insert into __MENU values ('01.04'	,'Pengaturan Halaman Depan'					,'app_frontpage'				,'1',2,'01','');
insert into __MENU values ('01.05'	,'Notifikasi Email'							,'app_notif'					,'1',2,'01','');
insert into __MENU values ('01.06'	,'Reset Jam Kerja'							,'app_reset_jam_kerja'			,'1',2,'01','refresh16');
insert into __MENU values ('01.07'	,'Reset Jarak Tempuh'						,'app_reset_jarak'				,'1',2,'01','refresh16');

insert into __MENU values ('02'		,'Referensi Data'							,'menu_ref'						,'0',1,'00','module');
insert into __MENU values ('02.01'	,'Wilayah - Area'							,'ref_area'						,'1',2,'02','');
insert into __MENU values ('02.02'	,'Organisasi'								,'ref_organisasi'				,'1',2,'02','');
insert into __MENU values ('02.03'	,'Jabatan'									,'ref_jabatan'					,'1',2,'02','');
insert into __MENU values ('02.04'	,'Jabatan Komite/Sub-Komite'				,'ref_jabatan_komite'			,'1',2,'02','');
insert into __MENU values ('02.05'	,'Pendaftaran Pegawai Komite'				,'ref_pegawai_komite'			,'1',2,'02','');
insert into __MENU values ('02.06'	,'Klasifikasi Pegawai'						,'ref_klas_pegawai'				,'1',2,'02','');
insert into __MENU values ('02.07'	,'Observasi'								,'ref_observasi'				,'1',2,'02','');
insert into __MENU values ('02.08'	,'Pegawai'									,'ref_pegawai'					,'1',2,'02','');
insert into __MENU values ('02.09'	,'Tipe Pelatihan'							,'ref_pelatihan'				,'1',2,'02','');
insert into __MENU values ('02.10'	,'Work Permit'								,'ref_work_permit'				,'1',2,'02','');

insert into __MENU values ('03'		,'Risk Containment Audit'					,'rca'							,'0',1,'00','module');
insert into __MENU values ('03.01'	,'Target RCA'								,'rca_target_pegawai'			,'1',2,'03','');
insert into __MENU values ('03.02'	,'Entri Data RCA'							,'trx_rca'						,'1',2,'03','');
insert into __MENU values ('03.03'	,'Laporan Partisipasi RCA'					,'rca_lap_partisipasi'			,'1',2,'03','report');
insert into __MENU values ('03.04'	,'Laporan Performansi RCA'					,'rca_lap_performance'			,'1',2,'03','report');
insert into __MENU values ('03.05'	,'Laporan Severity RCA'						,'rca_lap_severity'				,'1',2,'03','report');
insert into __MENU values ('03.06'	,'Grafik Performansi RCA'					,'rca_grafik_performance'		,'1',2,'03','report');

insert into __MENU values ('04'		,'Observasi'								,'obs'							,'0',1,'00','module');
insert into __MENU values ('04.01'	,'Target Observasi'							,'obs_target_pegawai'			,'1',2,'04','');
insert into __MENU values ('04.02'	,'Entri Data Observasi'						,'obs_input_stop'				,'1',2,'04','');
insert into __MENU values ('04.03'	,'Laporan Partisipasi'						,'obs_lap_partisipasi'			,'1',2,'04','report');
insert into __MENU values ('04.04'	,'Laporan Performansi'						,'obs_lap_performansi'			,'1',2,'04','report');

insert into __MENU values ('05'		,'Safety Meeting'							,'sfm'							,'0',1,'00','module');
insert into __MENU values ('05.01'	,'Pencatatan Rapat Central'					,'sfm_data_rapat_central'		,'1',2,'05','');
insert into __MENU values ('05.02'	,'Pencatatan Rapat Sub Komite'				,'sfm_data_rapat_sub'			,'1',2,'05','');
insert into __MENU values ('05.03'	,'Status Pekerjaan'							,'sfm_task_progress'			,'1',2,'05','');
insert into __MENU values ('05.04'	,'Status Pekerjaan (Supervisor)'			,'sfm_task_progress_sup'		,'1',2,'05','');
insert into __MENU values ('05.05'	,'MoM Komite'								,'sfm_mom_komite'				,'1',2,'05','report');
insert into __MENU values ('05.06'	,'MoM Sub-Komite'							,'sfm_mom_sub_komite'			,'1',2,'05','report');

insert into __MENU values ('06'		,'JSA & PTW'								,'jsa_ptw'						,'0',1,'00','module');
insert into __MENU values ('06.01'	,'Job Safety Analysis'						,'trx_jsa'						,'1',2,'06','');
insert into __MENU values ('06.02'	,'Hot Work Permit'							,'trx_ptw_hot'					,'1',2,'06','');
insert into __MENU values ('06.03'	,'Cold Work Permit'							,'trx_ptw_cold'					,'1',2,'06','');
insert into __MENU values ('06.04'	,'Confined Space Entry Permit'				,'trx_ptw_cse'					,'1',2,'06','');
insert into __MENU values ('06.05'	,'Radiographic Work Permit'					,'trx_ptw_radiographic'			,'1',2,'06','');
insert into __MENU values ('06.06'	,'Electrical Work Permit'					,'trx_ptw_electrical'			,'1',2,'06','');
insert into __MENU values ('06.07'	,'Digging Work Permit'						,'trx_ptw_digging'				,'1',2,'06','');

insert into __MENU values ('07'		,'Laporan Bulanan'							,'lap'							,'0',1,'00','module');
insert into __MENU values ('07.01'	,'Pengaturan Unjuk Kerja'					,'luk_var'						,'1',2,'07','');
insert into __MENU values ('07.02'	,'Entri Data Unjuk Kerja'					,'luk_entri'					,'1',2,'07','');
insert into __MENU values ('07.03'	,'Entri Data Kegiatan K3PL'					,'trx_kegiatan_k3pl'			,'1',2,'07','');
insert into __MENU values ('07.04'	,'Entri Data Insiden'						,'trx_insiden'					,'1',2,'07','');
insert into __MENU values ('07.05'	,'Laporan Unjuk Kerja K3PL'					,'luk_lap_unjuk_kerja'			,'1',2,'07','report');
insert into __MENU values ('07.06'	,'Laporan Rangkuman Kegiatan K3PL'			,'lap_rangkuman_keg'			,'1',2,'07','report');
insert into __MENU values ('07.07'	,'Laporan Safety Metrics'					,'lap_safety_metrics'			,'1',2,'07','report');

insert into __MENU values ('08'		,'Pelatihan K3PL'							,'trn'							,'0',1,'00','module');
insert into __MENU values ('08.01'	,'Entri Pelatihan'							,'trn_entri'					,'1',2,'08','');
insert into __MENU values ('08.02'	,'Laporan Pelatihan'						,'trn_lap'						,'1',2,'08','report');

insert into __MENU values ('09'		,'Pengelolaan Lingkungan'					,'lnk'							,'0',1,'00','module');
insert into __MENU values ('09.01'	,'Entri Data Pengelolaan Lingkungan'		,'trx_pengelolaan_lingkungan'	,'1',2,'09','');
insert into __MENU values ('09.02'	,'Laporan Pengelolaan Lingkungan'			,'lap_pengelolaan_lingkungan'	,'1',2,'09','report');

/* Hak akses untuk grup Administrator */
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'01.07',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.07',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.08',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.09',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.10',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'03.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'03.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'03.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'03.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'03.05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'03.06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'04.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'04.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'04.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'04.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05.05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05.06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06.05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06.06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'06.07',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07.05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07.06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'07.07',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'08',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'08.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'08.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'09',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'09.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'09.02',4);

/* Hak akses untuk grup observasi */
insert into __hak_akses (id_grup, menu_id, ha_level) values (2,'01.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (2,'04',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (2,'04.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (2,'04.02',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (2,'04.03',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (2,'04.04',3);

/* Hak akses untuk grup Committee */
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'01.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05.02',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05.03',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05.04',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05.05',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05.06',3);

/* Hak akses untuk grup sub Committee */
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'01.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05.02',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05.03',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05.04',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05.05',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05.06',3);

/* Hak akses untuk grup pelaksana RCA */
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'01.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'03',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'03.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'03.02',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'03.03',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'03.04',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'03.05',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (5,'03.06',3);

/* Hak akses untuk grup entri laporan bulanan */
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'01.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07.01',1);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07.05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07.06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (6,'07.07',2);

/* Hak akses untuk grup audit laporan bulanan */
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'01.01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07.02',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07.03',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07.04',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07.05',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07.06',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (7,'07.07',4);

/* Hak akses untuk grup Manajemen */
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01',3);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01.05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01.06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'01.07',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.07',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.08',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.09',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'02.10',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'03.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'03.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'03.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'03.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'03.05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'03.06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'04.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'04.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'04.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'04.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'05.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'05.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'05.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'05.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'05.05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'05.06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06.05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06.06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'06.07',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07.03',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07.04',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07.05',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07.06',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'07.07',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'08',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'08.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'08.02',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'09',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'09.01',2);
insert into __hak_akses (id_grup, menu_id, ha_level) values (8,'09.02',2);

insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001751814','Sheila Merlianty',1,3,7,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001751815','Limar Suci Rahayu',2,7,41,17,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001761826','Heny Purwati',1,10,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001761830','Achmad Junaidi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001761831','Herry Gunawan',1,3,21,11,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001761833','Feronica Yula Wardhani',1,6,25,13,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001771835','Amanarita',2,7,51,22,8,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001781840','Imron',1,7,15,9,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001791842','Ahmad Cahyadi',1,7,10,7,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0001791843','Yohanes Chandra',1,7,11,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0003741878','Sandi Hardi',1,9,29,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0003751882','Iwan Yuli Widyastanto',1,10,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0003761886','Mula Prasetyawan Senja',1,1,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0003771887','Ali Fahrudin',1,7,22,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0003771891','Richard Napitupulu',1,6,42,17,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0003771896','Mega Pratiwi',2,9,45,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0003791907','Darmoko Anggar Setyadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004631997','Dapot Tambunan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004631998','Jhon Helmon Manurung',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004761918','Kusnasriawan Nugroho Santoso',1,7,12,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004771921','Wuriana Irawati',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004771922','Ridian Junata',1,10,9,6,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004771955','Ita Nalurita',2,9,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004781924','Amin Hidayat',1,7,17,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004781925','Donna Hasibuan Lumban Tobing. SE',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004781927','Eva Ameilia',1,10,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004781960','Asri Retno Wahyuningsih',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004791934','Nazlya Intan Sari',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004811947','Sonny Rahmawan Abdi. A.Md',1,10,8,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004811973','Imelda Fitri',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004811974','Azhar Noor Habieb',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004821948','Heriansyah',1,4,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0004821949','Farah Tri Astiniah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005792113','Barlian Kahuripan Utomo',2,9,51,22,8,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005802078','Feri Arif Hidayat',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005802080','Galuh Kusumaningtyas',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005802121','Anang Susanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005802123','Gunawan Cahyo Nugroho',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005802126','Rusdi Tommy',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812084','Yenni Ratna Kusuma Dewi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812086','Panji Bagus Pamungkas',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812089','Eka Subandriani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812095','Mukhamad Rifai Sidi. ST',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812131','Rhomy Adhy Prastiyo',1,4,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812133','Nor Aklis',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812134','Beni Yudhanta',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812135','Ichsan Priambodo',1,7,14,9,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812137','George Leonard Dale',1,9,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005812140','Igung Aris Hermanu',1,4,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005822097','Febri Mohammad Kautsar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005822105','Natasya ID Saiman',1,4,2,2,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005822106','Yanuar Yudha A.P',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005822144','Retno Kusumaningrum',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005822150','Ariel Sharon',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005822154','Haryo Priantomo',2,4,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005832108','Purwanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005832156','Yane Maulina',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005832162','Widya Kurnia Puteri',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0005832167','Ade Aryani Raisia',2,4,39,16,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007802278','Herdi Qoharrudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007802279','Herry Rachmadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007802281','Hendro Waskito',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007812286','Fitria Agristina Wijaya',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007822292','Muhammad Rusdy Sanny',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007832303','Siti Aisah',1,5,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007842313','Sondang Aryanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007842315','Insan Kamil',2,1,25,13,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007842323','Yusdi Mubarok',2,1,24,13,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0007842324','David Ade Saputra',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0077560828','Ferdinand Kosam',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0081590891','Noverisma',1,7,6,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0086621056','Sumarsony',1,3,41,17,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0087591076','Nugroho Pandu',1,6,47,19,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0087641079','Nismawati',1,7,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0087641112','Supriyadi',2,6,37,16,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0087651080','Endang Murtiani',2,7,54,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0087651118','Wasanan Saepudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088581201','Bukti Tamba',1,3,26,14,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088581202','Yulius H Hutabarat',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088581206','Joko Prasetyo',1,3,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088591136','Aryandra',1,9,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088601138','Amri Abdullah',1,6,22,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088601217','Cahyo Triyogo',1,6,11,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088601219','Dwi Suwono Harto',1,3,6,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088601220','Toto Purnomo',1,6,37,16,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088611140','Agus Suryono',2,6,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088611235','Rudiatmoko',1,6,1,1,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088611237','Daniel Hamonangan S Hutahuruk',1,6,26,14,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088621247','As`ad',2,3,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088631150','Yuwono',1,3,13,9,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088641262','Jobi Triananda Hasjim',1,2,1,1,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0088681166','Bambang Purwanto',1,3,9,6,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089551387','Syahrudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089561399','Madanlal R',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089571391','Hamami',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089571400','Askesatria Achmad',1,7,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089591324','Hermansyah',1,3,24,13,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089591358','Dedy Achdiat',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089601336','Mushar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089611393','Sutaryo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089611401','Maman Kasiman',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089611402','Jacobus Gunawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089621328','Hendy Kusnadi',1,2,11,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089631404','Kastoni',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089631405','Utin Syarifudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089641396','Saji',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089651373','Benny',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089651407','Afan Rukman',1,4,17,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089661408','Zulkarim Jihar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089661409','Rachmat Gunawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089681350','Anak Agung Raka Haryana',1,3,37,16,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089691353','Ojak Lumban Tobing',1,3,1,1,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089691410','Tata Nuranta',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0089691411','Benhur Wahyudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092601439','Embang Adiwinata',2,9,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092611425','Dasik',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092631441','Kustriyono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092631496','Adia Purna Sulistya',2,7,48,19,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092651426','Ahmad Ruskandi',1,4,13,9,2,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092651430','Hardi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092651431','Hendri',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092651432','Kusnandar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092661446','Wawan Syarif Ridwan',1,5,7,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092661447','Makmuri',1,10,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092681433','Asna Suala',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092681449','Rudi Handoko',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092691434','Dindin Komarudin',1,9,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092691436','Hermansyah Cahaya',1,2,25,13,3,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092691451','Saepudin',1,10,7,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0092701437','Setia Adi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0093681502','Hari Pudjiastuti',1,10,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0094651522','Maryanto',1,7,13,9,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0094661528','Noverdi',2,7,46,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0094711542','Taat Udjianto',1,7,4,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0094711543','Nurdiansyah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0095621568','Mulyadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0095691576','Agus Sukriya',1,7,23,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0095731589','Aji Tunggul Purbomiluhung',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0095761591','Aryo Wicaksono',1,7,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0096591660','Karwin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0096671628','Dwika Agustianto',1,3,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0096681632','Kapon Okpilas',1,3,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0096691635','Danu Priambodo',1,6,22,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0096711648','Irwan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0097681695','Suko Hartono',1,6,11,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0097701689','Lintong Sopar MS',1,3,22,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0097721701','Chaedar',1,6,37,16,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0097731706','Rachmat Hutama',2,3,49,20,7,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0098691729','Etanto Heiliano Wijayanto',1,3,17,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0098731737','Siti Yanti Mulyanti',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0098761738','Lely Malini',1,7,26,14,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099512189','Iwan Darmatsyah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099552192','Sukari',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099572193','Adun Suminta',1,4,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099592195','Djakaria',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099622197','Arnata',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099632182','Rosidi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099662183','Baryadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099662184','Subiyanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099672201','Supandi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099682185','Muhasyim',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099702186','Syahrudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099702202','Achmad Hidayat',1,4,17,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099712188','Nurdin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099712203','Waluyo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099721767','Henry Gunawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('0099731779','Rangga Radji',1,7,7,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005792022','R Brian Dwiputranto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005802024','Andi Budiansyah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005802025','Charles Parulian Bakara',1,4,26,14,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005802026','Asep Saepul Bahri',1,4,11,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005812028','Kristiar Bintang Caroko',1,4,2,2,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005812029','Laurina Dewinta Ivanna Razak',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005812030','Lusi Latifunnur',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005812031','Fauzan Novianto Nugroho',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005812045','Agus Muhammad Merzi',1,4,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005812046','Zul Amri',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005822033','Erwin Gitarisyana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005822034','Ela Nurlaila, SE',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005822035','Rikhi Narang',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005822036','Dhanni Watrika Prihatina Rassari',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005822037','Agus Muhammad Mirza',1,4,10,7,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005822038','Jefryanto Pasaribu',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005822168','Mikael Wieda Dwiarka',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005832039','Arinta Indah Sulistiawati',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005832040','Firsta Melyana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005832041','Anisa Muzzamil',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005832042','Erik Taufan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005832047','Rahayu Laila Fitriati',1,6,38,16,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005842043','Hernita Pratiwi Setyani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005842048','Dhitta Ayu Maulidya',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005842170','Adi Saputra',1,4,22,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005852049','R Endah Adinda Bestari',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1005862044','Ingelora Loudia Anggita',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007732204','Ade Rusmana',1,4,23,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007812207','Siti Nuraida',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007812209','Viktor Leonardo Siahaan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007812210','Bayu Putra Du Indarto',1,4,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007822211','Adi Mulawarman',1,4,23,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007822213','Magresa Hendariawan. A.Md',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007822214','Ade Ihwana Kurniawan',2,4,44,18,6,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007822215','Muhammad Riyad',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007822216','Rika Narulita',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007822217','Dedy Wibowo SE',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007822252','Yudi Ariyanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007832218','Sulchan Fadholi',1,4,11,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007832219','Hendy Priatna',1,4,26,14,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007832221','Tutus Kurniawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007832253','Nurlelasari',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007842222','Kusuma Wishnu Wardhana SE',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007842223','Roy Gamma',1,4,26,14,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007842224','Sari Handayani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007842225','Nur Afni Indah S',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007842226','Winda Wati',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007842254','Devy Puspasari S.',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007852255','Haris Budiman',1,4,1,1,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007862227','Ferry Ahmad Nurjaman',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007862228','Agustian Lukman Hakim',1,4,22,12,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1007882256','R Vanni Aprilia',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008552340','Ridwan Sutisna',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008562342','Suhadir',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008622345','Yono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008782375','Yuli Priyanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008792346','Moniek Trilaksmi Uliani Dewi',1,4,1,1,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008812347','Suprayogi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008812374','Irfan Kurniawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008822348','Bahar Adnan Baihaky',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008822349','Erwan Omar Mukhtar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008822350','Edwin Prioneanto',1,4,2,2,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008822351','Deasy Chairunnisa',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008832353','Jomaren Tuah Saragih',2,4,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008832354','Agung Tri Kuncoro Wicaksono',2,4,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008842355','Sugiyanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008842356','Rully Andrians',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008842357','Andi Irawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008852360','Arief Marzuki',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008852361','Muharijal',1,4,1,1,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008852372','Adhitya Bimantoro',1,4,27,14,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008862362','Rd. Yusman Wismarna',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008862363','Reesha Veninda Wardhana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008862365','Indah Irwanti',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008872366','Hapiz Maulana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008872367','Bobby Bayu Mahardika',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008872373','Amarendra Dharmmestha Wicesa',1,4,18,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008882368','Yusep Mandani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008882369','Izza Ubaidilah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008892370','Andriansyah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1008892371','Johannes Reybli Manurung',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1074540801','Sukadir',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1074540820','Syamsul Harahap',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1074550788','Sunarko',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1074560784','Sudarto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1074560785','Suyoso',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1074560823','Amin',1,4,5,4,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079540837','Usman Djayusman',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079540842','Tarya',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079540844','Rukmantoro',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079550845','Syafe`i',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079550847','Mulyadi B K',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079550860','Sirno',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079550862','Saswani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079560841','Paridjo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079570848','Muhidin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079570853','Djamhari',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079570854','Tjetjep Aan S',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1079580861','Sugiharto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1085540996','Rochaidi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1085590998','Achmad Fauzi',1,4,13,9,2,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1085600999','Saprudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1085601000','M Syafei',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1085621001','Canisius Nay',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1085631002','Saimin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1086561007','Ayu Inne Dinarlia',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1086611008','Supriyadi',1,6,37,16,5,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1086621009','Richard Hamelberg',1,10,10,7,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087591095','Izaak Hursepuny',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087621097','Panji Sastrawijaya',1,10,6,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087621098','Eko Purnomo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087631099','Suparto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087641101','Sri Suminarti',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087651104','Rumwinarni',1,7,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087651105','Enny Mulyani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087651106','Dwi Prawanti Nina Wulan',1,7,8,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087651107','Selviana Muchtar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1087651109','Nur Inayati',1,10,8,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088581172','Suhanda Guntara',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088591173','Siyono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088591174','Setia Budi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088591175','Amin Adiguna',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088621176','Kemal Salim',1,10,6,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088621177','Soedarwanto',1,7,16,9,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088631178','Victor Kolin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088631180','Sainan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088631181','Budi Susanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088631182','Dwi Topan Irianto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088641183','Binuril Mustofa',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088641184','Sriyono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088641186','Amsar',1,4,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088641187','Mahmudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088641188','Chairiah Mustafa',1,10,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088641264','Neneng Sabeni',2,7,46,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088651189','Partiono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088651190','Sugiarto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088661191','Umdana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088661192','Nurhasan',1,4,8,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1088671194','Syamsul Bahri',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089561308','Supardjo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089601310','Daori',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089611311','M Sidik',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089631312','Heri Supriatna',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089631313','Endang Irianto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089631314','Darmawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089641315','Chaerullah Atmaja',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089651316','Halid Sjarief',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089651317','Nahrowi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089651318','Achmad Chaerudin',1,4,13,9,2,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089661319','Joni Isman',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1089691322','Irfan Alamsyah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092601455','Setu Setiawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092601456','Sutrisna',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092631458','Eddy Syafianto',1,4,8,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092631459','Henry Arys Djuanda',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092631460','Sarwono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092631461','Mugiyanto',1,7,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092631490','Sugito',1,3,11,8,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092641462','Jumadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092641463','Tarmidi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092641464','Erwin Noor',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092651466','Paryono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092651467','Farid Muchtar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092651468','Marijo. A.Md',1,7,20,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092651469','Edi Supandi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092651470','Rojali',1,9,29,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092671471','Suparmono',1,4,32,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092671472','Harry Safary',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092671473','Erman Susilo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092671474','Rifca Delywera',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092671475','Budihardjo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092681476','Yetti Supartini',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092681477','Widodo Djoko Susilo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092681478','Abdul Azis Syahroni',2,4,46,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092681479','Aminudin',1,4,13,9,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092681481','Ana Untari',2,4,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092681482','Gugun Satmoko',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092691483','Supriyanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092701484','Eddy Slamet',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092701485','M Rizal',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1092711486','Ahmad Nazi',1,4,18,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1095691577','Priyo Hutomo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1095691578','Akur Pariaman',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1095711582','Berman Sianipar',2,1,25,13,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1095711584','Ronny Sastrawijaya',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096701598','Maman Rusmana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096701599','Achmad Syuhada',1,4,30,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096701600','Ina Herlina',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096711601','Isnandar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096711602','Hakim Wijaya',1,4,29,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096711603','Iwan Iskandar',1,6,3,3,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096711604','Sadewo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096711605','Supardi',1,4,16,9,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096721606','M Waspin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096721607','Septodita Musfa Sabi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096731608','Kardiyanta',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096731609','Ifan Hendriawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096741613','Sopyan Zamhuri',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096751616','Liestya Heryani Devi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096761615','Yasir Arafat',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096761617','Endang Suratna',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096761618','Ade Musfarullah',2,4,42,17,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096761619','Dede Priatna',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096771620','Sigit Prayitno',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096771621','Dian Kuncoro',1,3,2,2,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1096771622','Supratman',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1573540726','Mansyur Syah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1575540760','Sukma WIjaya',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1575540761','Achmad Sunardi',1,4,34,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1575550762','Mumuh Muhidin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1575560763','Syarief',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1575560764','Sarino',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1582620914','Lolah Wiarsih',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1582620915','Sofiah Achmad',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1582630916','Damar Riyanti',1,7,7,5,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583560923','Zaenal Arifin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583570924','Nurdjo',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583570925','Cahya Nugraha',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583580926','M Soleh Jamali',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583580936','Agus Mulyana',1,4,54,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583580941','Suryadi Syafei',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583590927','Ferry Dominggus Lisapaly',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583590928','Dedi Iswanto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583600929','Wawan Gunawan',1,9,29,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583610937','Arien Rustiyani',2,7,60,19,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583610944','Enok Suhaemi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583620931','Moch Husen',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583620932','Rita Yulianita',1,10,9,6,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583620934','Pujimin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583620938','Jayadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583620939','Cana Bana',2,9,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583640946','Risbandi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1583650935','Paimin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1584590959','Aay Supriadi',2,4,46,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1584600960','Aep M Saepudin',1,4,60,19,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1587551126','Amir Suparman',1,4,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1587571127','Husein',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1587591129','Taufik Hidayat',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1587641131','Ujang Ishak',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1587651133','Suwanto',1,10,6,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1587661134','Dewi Sukmawati',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1587671135','Rahman Suryana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588621270','Prasojo Budi Santoso. SE',1,7,38,16,5,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588621271','Juarsa',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588631272','Syahuri',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588631273','Condong Hartaji',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588631274','Fachrudin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588641277','Gito Prayitno',2,9,44,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588651278','Tohandi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588651279','Yanto Kusdamayanto, A. Md',1,6,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588651280','Janim Susanto',1,7,18,10,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1588651281','Anas Muhidin',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1596711639','Lala Kumalawati',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1596711640','Heri Hermawan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1596721641','Hari Mukhamad Al Fitrah',1,4,1,1,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1596721642','Siti Itaningrum',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1596721644','Joni Ristianto',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1596731645','Saut Freddy Halomoan Ari Tonang',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1596741647','Ade Sutisna',1,4,5,4,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1674540721','Sutrisno',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1674550722','Rogana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1674550723','Sudjana',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1675550774','Didi Undi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1675560771','Sanima',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1675560773','Sumarno',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1675570728','Kunaedi Rasjid',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1677560832','Sunardi',1,7,21,11,2,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1682580899','Suganda',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1683610949','Satu Salim',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1684590967','Rusnamiyati',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1684600968','Sutiah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1686611046','Salima',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1686631047','Sarnido',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1686651048','Badaria',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1687591128','Ismunandar',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1687651132','Satori',1,10,9,6,1,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1688641275','Sarwadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1693601504','Achmad Husein',2,4,61,19,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1693611505','Mulani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1693651507','Moch Ridwan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1693661508','Khairani',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1693661509','Udi Setiono',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1693691510','Sukardji',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1699731762','Andi L Dullah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1874540799','Adi Wirono',1,4,54,18,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('1887601081','Iyan Supiyan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('2091641423','Entong Setiyono, A.Md',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('2580560880','Hamzah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('2584560953','Gafarudin',2,4,47,19,6,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('2584620954','Darmadi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('2589631364','Ridwan',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('2589641368','La Budi',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('3004791984','Teguh Imansyah',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('3004801989','Panondang Rudi Pernando',1,6,1,1,1,'','0','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('3086651074','Bahman Efendi',1,6,28,15,4,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('3097741719','Lebiner Sinaga',2,7,24,13,3,'','1','1');
insert into R_PEGAWAI (NIPG,NAMA_PEGAWAI, ID_KLASIFIKASI_PEGAWAI, ID_JABATAN, ID_SEKSI, ID_DINAS, ID_DEPARTEMEN, EMAIL, STATUS_PEGAWAI, ID_USER) values ('3097771725','Syafran Siregar',1,7,17,10,2,'','1','1');

insert into __USER(nipg, password, status_user) values('0001751814','42bc66261abbb79828ec648027fa5ca9834a9a162aac9b7ea1e911046486a188','1');
insert into __USER(nipg, password, status_user) values('0001751815','1e26210fd2118e598395eb04f6b01f2c0c597e267ed879abad26242e7e9a0365','1');
insert into __USER(nipg, password, status_user) values('0001761826','48ca2ccdb455e350ccb143f01bc3f78bd6065f5df315a1748209fc660a07b597','1');
insert into __USER(nipg, password, status_user) values('0001761830','445a5b767abfae27ce42369edc2725e2aa36d4943770b9b3a9131bdf6f8917ec','1');
insert into __USER(nipg, password, status_user) values('0001761831','1a4dfa5dcbe39fc86abb21c520eec863e5257f5aa98ea1c20a14ee3fd22f02cf','1');
insert into __USER(nipg, password, status_user) values('0001761833','6d61d261d9a916d47e5be8848102cc8809558464532a43d60d24a271b9a519bc','1');
insert into __USER(nipg, password, status_user) values('0001771835','7db30cd4ed4490bb1b0dce35fcebde5ca73e03b3b59e0b85ced2dcf8780f2e26','1');
insert into __USER(nipg, password, status_user) values('0001781840','f8a6101e824ade3a71172a18ed78928a2e176e1431dc616a136bc9ca7addfd55','1');
insert into __USER(nipg, password, status_user) values('0001791842','0f60c84809a78b1132690647a14a3af723683e4fb428a49c37bd434a11569bda','1');
insert into __USER(nipg, password, status_user) values('0001791843','25d593cd7e74d6197e1f15456a4f5f8220c6c00db48b062411b89d9ff3b1e277','1');
insert into __USER(nipg, password, status_user) values('0003741878','b6a8d5eed092f0c1f297ff1697f99c54130b2616f3e58e5b03b1d9f31179e177','1');
insert into __USER(nipg, password, status_user) values('0003751882','1cab3f315e1c30c9266bd42cf4dfeaa924f0c3fbd26a53dc47e21180b76878d3','1');
insert into __USER(nipg, password, status_user) values('0003761886','16ba6335d663b718d0e53333df181408501f840b5240c2a12efdbc03f5530db5','1');
insert into __USER(nipg, password, status_user) values('0003771887','0924fd55fc4d2d9b8da1df75aecc7ede376adb27dd98579cd736a2e5c200cae7','1');
insert into __USER(nipg, password, status_user) values('0003771891','1b877961aa10a72d60f128a6a0095758129a9ae542e8c9ba5d9e9c5d2d965f7e','1');
insert into __USER(nipg, password, status_user) values('0003771896','98a54ecc9593ad3bf610e7014fd94c089c347766f3152ece48189b6ac2e85168','1');
insert into __USER(nipg, password, status_user) values('0003791907','7d4fd30e6e6e32b756b0093159478ed77b375cfc50f315232d4cbbf33f794fcd','1');
insert into __USER(nipg, password, status_user) values('0004631997','f39cf7d929e285906a5b97459dc1742b0dd3bc9c8e3383c40b52196d17e0b0bd','1');
insert into __USER(nipg, password, status_user) values('0004631998','62b8b001bcb48426bec6104a1e6420843ec2443e6b9338909afc03aeb8048ccb','1');
insert into __USER(nipg, password, status_user) values('0004761918','c80ed7241fdbbfe93492417db1d67b7cb15c3dc65dc085d5f771a660c016a947','1');
insert into __USER(nipg, password, status_user) values('0004771921','d1cdb55a56b68a843ca1824e30c9f1b7d0e83a4af59d1722584e3822dba892f5','1');
insert into __USER(nipg, password, status_user) values('0004771922','e98b9f2f6db2ab9a4b013f10176cc0cde222675e0e1308f868b66d1a95bb6172','1');
insert into __USER(nipg, password, status_user) values('0004771955','4eff4bae96f5ab6ebcf503eedb457bfce0a57904f781b0f21ff89d057e3513a9','1');
insert into __USER(nipg, password, status_user) values('0004781924','c5694b10f7a551a50622a51789df187894cb038606b107966cdfcfddb61b1083','1');
insert into __USER(nipg, password, status_user) values('0004781925','ab95caa2a8d32ade6caf61d2a22cc8d1458158412ec88aaa5a7efc80e4908e8b','1');
insert into __USER(nipg, password, status_user) values('0004781927','0cdfd47918d1d10f2c25254203b26da6010c2aafba7321c1310b83ad9c7d53a9','1');
insert into __USER(nipg, password, status_user) values('0004781960','cb6e6a0f5b3875a9d99253d775a00ddbd9c90f71f2db7de502cd772a0cad0324','1');
insert into __USER(nipg, password, status_user) values('0004791934','a5f7a455969d97de29bb3ca36ccd1ddd5a9eec288ada04aed8650a10e5421d19','1');
insert into __USER(nipg, password, status_user) values('0004811947','c2aaed9167c4b785f07dd6f4cf988123d7d220a88aad7ac43be0d9903ebd4dc3','1');
insert into __USER(nipg, password, status_user) values('0004811973','b3b6850519e539cbe49c26b4e714217cb058a29801a2bd8d1c924edcf80362cf','1');
insert into __USER(nipg, password, status_user) values('0004811974','6e70b9778f1aa63d1071a999132e982eb36d00b4591a7179d88f38df54a35b4a','1');
insert into __USER(nipg, password, status_user) values('0004821948','8aac7488a7278de500e9f74ba9b4bea99d6a70a53fa4dbac6a8c9fc602f417e8','1');
insert into __USER(nipg, password, status_user) values('0004821949','e19227cf33f67a34dd9ae14fb75503e699c4d8c3359015a45875590e3d166dc7','1');
insert into __USER(nipg, password, status_user) values('0005792113','11a2b95d0f5ec249fe86799e36e64fe90180512ab1f5e830dc3d8333290aced6','1');
insert into __USER(nipg, password, status_user) values('0005802078','308731927d96929aba46c19bbed747c12f101bb22e99213228e8bd5148bf227c','1');
insert into __USER(nipg, password, status_user) values('0005802080','e21ce4b84dafd5c71bc01168124519bbb9d8ff67f2932323561c810f059c86b2','1');
insert into __USER(nipg, password, status_user) values('0005802121','5536bd64e4dbabf19a31f82a687acd6f6f0ac59604473b2549887ba96fca6045','1');
insert into __USER(nipg, password, status_user) values('0005802123','cc71d172b075768ef2d93f9727483997d181b2baf579259e25b9d10e924e0443','1');
insert into __USER(nipg, password, status_user) values('0005802126','e0dcc613a8297ff487faf588a7375f05184453b10e6227ed2efc1712d5434535','1');
insert into __USER(nipg, password, status_user) values('0005812084','8cd72dd39c7079c4c68ebd71adac852b2020ea1800a4adb0fdd48224bad06bd3','1');
insert into __USER(nipg, password, status_user) values('0005812086','ddb8ca2684fa37270f63a74de25efa8d8ffb0d54235728c90e8d35850be0776c','1');
insert into __USER(nipg, password, status_user) values('0005812089','aa162b6ffdb8cf424d6b7a2c76383134aad9ea58ecad0302f2de5f13cbfdb6f8','1');
insert into __USER(nipg, password, status_user) values('0005812095','e34de35bcd3d5d3a9d52f5ab93b202bd743bdf30f439537e21bcf402248e2d30','1');
insert into __USER(nipg, password, status_user) values('0005812131','a86da0a4565806450c053146142455406db7b2439982f331ce0498981c151e0a','1');
insert into __USER(nipg, password, status_user) values('0005812133','12fc203eea30db1613503c9aae6c95af87e14c8732f2dd048a08f5a3897c7575','1');
insert into __USER(nipg, password, status_user) values('0005812134','48600ab48349a26bea1de25a0269810146f5a33b36490b78be28b7e61bbfe015','1');
insert into __USER(nipg, password, status_user) values('0005812135','89386e71667bedc3b8bb7a375e26a433fef2fb959f178eeed28bb6f510949fa7','1');
insert into __USER(nipg, password, status_user) values('0005812137','21538f2d485f6cf91d78920dcdb2d43c350f20e5068d30d96c8f1d3274eb81ad','1');
insert into __USER(nipg, password, status_user) values('0005812140','11cd7451e23324f7e0e447a2377d49fdc0faad66d7d493be8871eda1d3ddf614','1');
insert into __USER(nipg, password, status_user) values('0005822097','de475a5bedafee2d5ab735740caa7f935a4b8c374ba989eb155cbe94a270e409','1');
insert into __USER(nipg, password, status_user) values('0005822105','d49af90b8bde9ba639547f3cda47478be053e54612bb7e5c732bb0757f1b9052','1');
insert into __USER(nipg, password, status_user) values('0005822106','5383262454229247ac78d302862cb5f28847b53f21f487b15057e5ae70c4d20f','1');
insert into __USER(nipg, password, status_user) values('0005822144','d036d09bc0c5c0792dbf2ac277deffb715e52d10fb04e7cce760a3ba7a0946f1','1');
insert into __USER(nipg, password, status_user) values('0005822150','70b89efda84f8ee0547a69025c525933197d5374e807412d75233df89fae2e24','1');
insert into __USER(nipg, password, status_user) values('0005822154','2adea3cd5ce9be6638309abc5ba10c7b0be1f9c0127a0e694c37c15176de4f90','1');
insert into __USER(nipg, password, status_user) values('0005832108','3e0875115d4837545aef3428ebad32139fcefee43e63ea6332200e465d5eda5b','1');
insert into __USER(nipg, password, status_user) values('0005832156','5d1158ff5a4c33e8c0a3a67f2664b7e4be5b6a6671dbd6237f53a914d1a77460','1');
insert into __USER(nipg, password, status_user) values('0005832162','6a1302f590b5ca0cfa66ba11555308132d7fa46f692b782aca70eb3bb9375416','1');
insert into __USER(nipg, password, status_user) values('0005832167','e788d6db611df90201be28b6f4cf220254bae70f5ae272b05e7c5a95c9c82db6','1');
insert into __USER(nipg, password, status_user) values('0007802278','855b010ac62435332fded4bfef25e07735bfb486973dd300d3ea68a8ef4fb1a7','1');
insert into __USER(nipg, password, status_user) values('0007802279','4a7451d7556fa516b65f6224a2a14c47bdcfc6fe69840e4d8fb70cbcfb80d102','1');
insert into __USER(nipg, password, status_user) values('0007802281','de98edd28ced552ca36b73f18bd48e43f9bbada10828a6a877817e0b896b2295','1');
insert into __USER(nipg, password, status_user) values('0007812286','13ce59270929ffccbcc96aa03e5cda8c186375a956c6a70febb1fa3fdf86d974','1');
insert into __USER(nipg, password, status_user) values('0007822292','0538d8f022c500e6c066d311de14495bea535f94b920f2eb1813d42a1c1467de','1');
insert into __USER(nipg, password, status_user) values('0007832303','0fa80dc659502d2af36912b5150056ea575cca2438cec913a98059d4087f22a6','1');
insert into __USER(nipg, password, status_user) values('0007842313','5026940cd9515fc0d2e736b50c8d2f1ba6a74116e54472c5ad3302d842b21b53','1');
insert into __USER(nipg, password, status_user) values('0007842315','3277f7fb9652c0b9e3527147d7da6136be15537da812750be8a3d2e9c01883a8','1');
insert into __USER(nipg, password, status_user) values('0007842323','b444dd5566bf372cbab52e278e0eefd1777961656c508d116cf24c9464b5a544','1');
insert into __USER(nipg, password, status_user) values('0007842324','6828e762fe0a1427f0dddcbaf59a06aff5f45a4e6ec43a8ea235a11d0e689788','1');
insert into __USER(nipg, password, status_user) values('0077560828','c8325bd3e174f386cbd9c164bfec6a61ca5db9629be6f04d34ace0bcdb93548d','1');
insert into __USER(nipg, password, status_user) values('0081590891','5113010f50a0a41b34260c1d937b2b70205e63a3f2bf0e5b0b6494b1b5616ec8','1');
insert into __USER(nipg, password, status_user) values('0086621056','78dad5acf6f1ef6d4289a13b298da3fda5aaf56106e08f236d2195fae21a41a5','1');
insert into __USER(nipg, password, status_user) values('0087591076','99d2a9702bd99602f2213e0e61231ec8d6b9b040cbbb10c86dc25dd016577748','1');
insert into __USER(nipg, password, status_user) values('0087641079','0e932f97d17ae0e5ab0132932caef767d40fb8148527377181f0a3c065943d3a','1');
insert into __USER(nipg, password, status_user) values('0087641112','ab694aceb2da9fc9a114e34ee4f8c26bafa6bdbc6c8c1637c572b91a88c215ad','1');
insert into __USER(nipg, password, status_user) values('0087651080','2ad7b7ecaf6175629a710da539b0c2e3f801c8ab18bec830df38c58892833b63','1');
insert into __USER(nipg, password, status_user) values('0087651118','4e123490bada1bdc24d33ec2fb0c2e2f86745994bf9e71de90580aa05d207317','1');
insert into __USER(nipg, password, status_user) values('0088581201','34f35eb15448fd2d059839804dcc36087472698b685a06ec6da5bcb786881ff3','1');
insert into __USER(nipg, password, status_user) values('0088581202','3cbb62a666107bc9e84a3b510552e1b90b66adf51f53fe6a9fcc10a5b75224bb','1');
insert into __USER(nipg, password, status_user) values('0088581206','07d03a83424acdb71a3192046a0efdeb983962d2d9fb5d281ea4c9ac4f346b39','1');
insert into __USER(nipg, password, status_user) values('0088591136','dd0c566f89fd2be9541d519b54c48e5e7be74ad39ea563445fc848850ed60750','1');
insert into __USER(nipg, password, status_user) values('0088601138','77d56de08f96b7c714a4f3180658e7dd1b092231ec61328c0cedd38061e42519','1');
insert into __USER(nipg, password, status_user) values('0088601217','d68eebd921788f25d41bf289a9ffc17ef50a2c946fa7e1a63f1020bdf011f024','1');
insert into __USER(nipg, password, status_user) values('0088601219','6de2b085aefccecdc230b3f97a5f34b22a33cda68154381aaef4af57c3bcbe6a','1');
insert into __USER(nipg, password, status_user) values('0088601220','14b47529a12b08f17e5bc9360c405410c07402c3fcc37a12dcd8c24290e8d41f','1');
insert into __USER(nipg, password, status_user) values('0088611140','ced1b1e2e91e087dd652ca5bc9cf090bd228429d480cbfe2a242350a36ccfb27','1');
insert into __USER(nipg, password, status_user) values('0088611235','bf84a4de0946ccdfb66b00e20d5d0dbbab842edb7731162e219e498e87fcd2ce','1');
insert into __USER(nipg, password, status_user) values('0088611237','d3969d40344b0b51f9c814803579bbe297d3ad6727448b64489d2debea047941','1');
insert into __USER(nipg, password, status_user) values('0088621247','fdc10fc0bb78ff20c7d10f6be33fb21187a1c5385d82327183ab9d4c9a15c5a1','1');
insert into __USER(nipg, password, status_user) values('0088631150','9ef0b377a6ac251b603e786d30af769d7bba25adde07bcfbac147f8bf5311ea8','1');
insert into __USER(nipg, password, status_user) values('0088641262','bfebaf1c2cf46b15f1de9dff526ebcde19b37ee98e86ab05f19050038ba91f38','1');
insert into __USER(nipg, password, status_user) values('0088681166','9bc9c959beaac97bf2f741172b02a7058c362f5161d4c63880a67f61935c3c62','1');
insert into __USER(nipg, password, status_user) values('0089551387','c77f6267adc09727fb6a8c17a6dd6100ef6f46242e5f95c48cc3876841b532ef','1');
insert into __USER(nipg, password, status_user) values('0089561399','93ebbf75a2d43577dd02b2c240f83c895e9e74d6c2388e0acd98072fd8a7ce39','1');
insert into __USER(nipg, password, status_user) values('0089571391','0bf68b834011bc074ab691bd9cd6db28f0a47abef3d5d8d8cd3dcecb3005c209','1');
insert into __USER(nipg, password, status_user) values('0089571400','2cbc99e3a2ea8f2569f80ce5edb1e2cd6c1bd73d1b718bfa15a1906101e3b9c5','1');
insert into __USER(nipg, password, status_user) values('0089591324','757fe64390d473091dde98a0c6ff42c1c56801d7c2583b5407264a2a06dce532','1');
insert into __USER(nipg, password, status_user) values('0089591358','f28606dfc71dff946597dd7b943674a44fe04a1e8eefa02d58ddec4660a940c8','1');
insert into __USER(nipg, password, status_user) values('0089601336','80f74ae5d7a5c9de2a75df880e08428e27d297d851b94d0dce3ddf9d47c31f85','1');
insert into __USER(nipg, password, status_user) values('0089611393','0e72a9e0e52b499d2966240da8f82d87617afeed968bb1a130d0f016801830db','1');
insert into __USER(nipg, password, status_user) values('0089611401','5bb1fc1371d80f9022b43bd2a9fed513640208ecdfeba8fb883715c68c624296','1');
insert into __USER(nipg, password, status_user) values('0089611402','8c111ba9cd5cf6e0cfde6f50a850b6b99635799ae4a9822d82593e2aea1da5a4','1');
insert into __USER(nipg, password, status_user) values('0089621328','e3ec7998d7a16116c6b5ee11806c6d902f2d1d70768def03f8407f4ae100e9b0','1');
insert into __USER(nipg, password, status_user) values('0089631404','46a4bf63fd3e3c6525aa15b9df242945b9198b523eaa5a950777d5e78bae2ce8','1');
insert into __USER(nipg, password, status_user) values('0089631405','5e4bcc18d4196de864cfed8a3560fab1ae0e3460eeb020f418d30c995bf93640','1');
insert into __USER(nipg, password, status_user) values('0089641396','be8171de50b5fe9b80cf571272aa3c2272b53351373c81e45907ac6254a0759b','1');
insert into __USER(nipg, password, status_user) values('0089651373','25cf8133c7df1ebffc322c77d1603a95733aaacb333b5a926780c190f79abd37','1');
insert into __USER(nipg, password, status_user) values('0089651407','4f517417c8499ef10e74e920827ff22a7bc18aa82861f0de5270f00ab4b66592','1');
insert into __USER(nipg, password, status_user) values('0089661408','549bf8adf2963260cf6dcf86d15da352272235b2bd1eb555e601d990f72ed541','1');
insert into __USER(nipg, password, status_user) values('0089661409','615575ece4f217ab697972ac2d8e675ae57f9ab2c7396daa06da92e7be2f994a','1');
insert into __USER(nipg, password, status_user) values('0089681350','487771431de526af7ff792c2d13a0163b6a8d2b682d7b8681011abdfe60ca832','1');
insert into __USER(nipg, password, status_user) values('0089691353','87fc36ffbe935563c4352bd101a67679feec26a123969a8c4c26fd6b7f57d432','1');
insert into __USER(nipg, password, status_user) values('0089691410','bc09dcc18b3d0fe37c26133ebbb9ae95ff2b490a01b3427fcf924e7bac58ec3e','1');
insert into __USER(nipg, password, status_user) values('0089691411','fb39967eebc69b14cd3b2660734a07dd6d5a853e1c090ec02d4a2796e5940686','1');
insert into __USER(nipg, password, status_user) values('0092601439','dda2817ba88746faccf2f57efa4dced32ae4d8b2515c28ce9648baee9c2ecbe3','1');
insert into __USER(nipg, password, status_user) values('0092611425','8a97b69a7d99dd1490922b4034fa525a41a787463bbfa03e7f3f0bd9e407c21a','1');
insert into __USER(nipg, password, status_user) values('0092631441','7e49fdf8fc3c8136a21ac29bd1d164367b889d6585fc555ebd420c7db6781407','1');
insert into __USER(nipg, password, status_user) values('0092631496','6c80ef983d5d3c5d91df1e63c92597e6cb218c505605e1bbf6cbd65a4b96c5c3','1');
insert into __USER(nipg, password, status_user) values('0092651426','5ac5ad1d3dfaf38dab5df1d45b59a8751e18c0c79988575afb847b8b80767ac0','1');
insert into __USER(nipg, password, status_user) values('0092651430','a895dcbc738c7e3396bfb4f78e0a1e5c50eec9b18d983cd9deb853b574d3cf81','1');
insert into __USER(nipg, password, status_user) values('0092651431','04bb081bcf7603b31ce0d42b66194ab881ae6afb1dd95d4d359a2397ad22c647','1');
insert into __USER(nipg, password, status_user) values('0092651432','111586bb007e1feebcf8750be9628dcf8bab7a06562c9526e3c48447dce8c8b3','1');
insert into __USER(nipg, password, status_user) values('0092661446','af4be36ad9213cd72b792a2074599f30b0c348ae9aee94ed4bbc32b7ef774e6c','1');
insert into __USER(nipg, password, status_user) values('0092661447','1d57b05844156db7ba7ea30c3228eecbbf6d3238309b38a90c74732393862f35','1');
insert into __USER(nipg, password, status_user) values('0092681433','b2978cbbfa5ea2be05e64f0e1c804527dfcd1d6cb0e07e3652e6ce1db9a77c80','1');
insert into __USER(nipg, password, status_user) values('0092681449','da055e514bf2dd18f947c41c53cbd83faa465432018bc65fa6b6f6cc181eee13','1');
insert into __USER(nipg, password, status_user) values('0092691434','89a2eddb608840c19bcf910abb4330427960aa49fe5a4a543dfbf241151ddf61','1');
insert into __USER(nipg, password, status_user) values('0092691436','3d2989f53762797f53af8d05e7ecc3cfc7ba0fdc3145e665ef9819a7e37cc72f','1');
insert into __USER(nipg, password, status_user) values('0092691451','5b9c412fa3579909ed1c7b20bfd9aff9beb0dcfa2ee279e7afac7c9f02193f8f','1');
insert into __USER(nipg, password, status_user) values('0092701437','c5fccf1029c87f206c07fd2b76a4f64b0ed9dc512a507104deb20d9a25274981','1');
insert into __USER(nipg, password, status_user) values('0093681502','209278b1ef58002e3989f1b1d8132c58b78e023b7ea705a4aaffd33b6dffe297','1');
insert into __USER(nipg, password, status_user) values('0094651522','900540b01be2a8ad8f9248f64bc657362ca6f03f010e565dcc4c91ceaf617782','1');
insert into __USER(nipg, password, status_user) values('0094661528','ca35e48714b6394dcc0d84197d4d3eb284bb990a3d09ace705e7feab464ee9c3','1');
insert into __USER(nipg, password, status_user) values('0094711542','7514d0723c029dbe2d7506bff1cdfa19fd56c0afee0af76d53a76a3f37d76677','1');
insert into __USER(nipg, password, status_user) values('0094711543','32cc0aebc21ff440e04fc771cfa5fb1e3ab64a4e631308d040c9b666ba05cfea','1');
insert into __USER(nipg, password, status_user) values('0095621568','91701f5e288666a35319e8defa5f29c9a17508ce5d7fc10ccb265c2b240ebc12','1');
insert into __USER(nipg, password, status_user) values('0095691576','d820dc006cff889ed94b316f5febdcdb4bdff4a2b1191972d233e44627d96a32','1');
insert into __USER(nipg, password, status_user) values('0095731589','abf9f4378e95a2aa7a99051c1f8316e5b7cd610b0b59690c3141acc587da4af6','1');
insert into __USER(nipg, password, status_user) values('0095761591','033191eeee40d26bf2cfae94fb43b16081fc4c258883fbe40ab77f123203126a','1');
insert into __USER(nipg, password, status_user) values('0096591660','cdca4a63f7fa7362a697754dcd34e87ee048e9939304cfd26f826631423e55cf','1');
insert into __USER(nipg, password, status_user) values('0096671628','316536c8a2967ad5d72297892586f9c952fed8e3acb366110b64ad2b7561318c','1');
insert into __USER(nipg, password, status_user) values('0096681632','b4e5bc53899bbdb6083e0f3e8d2be1abe2d43003b249228cf5748a1b5ba71188','1');
insert into __USER(nipg, password, status_user) values('0096691635','7de9cd5e17527bdc8799c036db34e84099708c0fdb881ddc1adeaff2417c1060','1');
insert into __USER(nipg, password, status_user) values('0096711648','8cb0c49bf670cb8064182cc76bb2dc460776b4397c7fa2afcb0111accfcff080','1');
insert into __USER(nipg, password, status_user) values('0097681695','48a562491a5b5bee145039db6a2255aeefcd94f3e501fbbe88f53667e042b88b','1');
insert into __USER(nipg, password, status_user) values('0097701689','3659d4448f0f4c49710bd97ac797d2e6792e90d79e5e05ad6ee37a910ffbeb33','1');
insert into __USER(nipg, password, status_user) values('0097721701','029990cc67abedda6df6376a9c528a9312b0933772f969f9da4be1bcfdd79f43','1');
insert into __USER(nipg, password, status_user) values('0097731706','f60e83c2c6c83fbf5c2348e603bb49e2de3f2e778511852afe13a1bd6feece84','1');
insert into __USER(nipg, password, status_user) values('0098691729','40f1a464c8284b23a6ed590b441fce56904908b7131f3b6d335a21aa3c4f2fd4','1');
insert into __USER(nipg, password, status_user) values('0098731737','7684e9f305a85f9e2190baa56d24848259edcfcd70ce2610c20ece5aafcdea9b','1');
insert into __USER(nipg, password, status_user) values('0098761738','f322fe8804a519265c622d7781661894285c996f94dfb4c02af2a20be1d2c2a8','1');
insert into __USER(nipg, password, status_user) values('0099512189','ab8636d95f57db41582ccd6940951fe467e30dfd056231b7a49ca5435f74623e','1');
insert into __USER(nipg, password, status_user) values('0099552192','6f3dc40a2a9cf9a43013de3d321275221064af1e7ead786a22e70fd2c9535027','1');
insert into __USER(nipg, password, status_user) values('0099572193','c63787129ac5afa0c135fcf4f6fd5dce771ecb1622c00288555cb425b91dd22f','1');
insert into __USER(nipg, password, status_user) values('0099592195','d942e4acdabd6be8589766e4ec6c8e752d579aee7039267d89378c94107938a7','1');
insert into __USER(nipg, password, status_user) values('0099622197','540ec5fbbf03a8e9c6783dad8fd317a014a6866e9d08656a7280cf5da8d283ae','1');
insert into __USER(nipg, password, status_user) values('0099632182','6a8719d8bb85b8d3108dd4f685ba18026c9ada5d387b9279fc4207aea6e49c41','1');
insert into __USER(nipg, password, status_user) values('0099662183','6833040181b707969ce8d76aa6351c0dc3e83918f2108687a4a9e68765098601','1');
insert into __USER(nipg, password, status_user) values('0099662184','50b052d35fe7452a93d45cedc2e86725d3a7c6f2815897d43358e380f49a5b8f','1');
insert into __USER(nipg, password, status_user) values('0099672201','324aaa653696344e3c4d8f1e43832d6cee4e6c8b4745388b4fbb9214089fc842','1');
insert into __USER(nipg, password, status_user) values('0099682185','0c05b402a051d8893ebca626fc7142ccad9f233978688e581cbcaa1a00ec320f','1');
insert into __USER(nipg, password, status_user) values('0099702186','63a44a000b520883d745d1976f6c3de5485938a24ef845ee8b7911e2bf29e831','1');
insert into __USER(nipg, password, status_user) values('0099702202','eaaa42dea5727e798079c2ef3420f830f8e4453369eed35eded09eefa8038cf0','1');
insert into __USER(nipg, password, status_user) values('0099712188','3cfb46791d55ad2e8f28d651d8958c222d5c88f32b039613944a3c9014f2700a','1');
insert into __USER(nipg, password, status_user) values('0099712203','eb29e87228c1876d143808b1c24e9d5fc2d96d128c0eaeef9ba86cb9a4fbbc14','1');
insert into __USER(nipg, password, status_user) values('0099721767','470f3d5b74825f748ad694db04e1eb22b7d88c6301185d9a30bf2dffce53d5bd','1');
insert into __USER(nipg, password, status_user) values('0099731779','c31853208d659b07a0d908d96f7ada707dfdad3b8e5fca5053cde3868a7c6246','1');
insert into __USER(nipg, password, status_user) values('1005792022','d84c98a425789a20d8c70369000ee2e50919a11ab498efcb720125dd2edbf1a9','1');
insert into __USER(nipg, password, status_user) values('1005802024','9038e052a172eb200086d2ebd0c87f043e10ddc956cc568711e6910f837baafe','1');
insert into __USER(nipg, password, status_user) values('1005802025','66276d26c7aa7b1805de76720400984231898dee36cc76fdacc49e931558816a','1');
insert into __USER(nipg, password, status_user) values('1005802026','0cb8ed059283348479760bcdf5c2aca092cbb8f7f799849ab25c4e19a6f9cf1d','1');
insert into __USER(nipg, password, status_user) values('1005812028','a82c5ff7d4e53bea5f4e5049ecd195d57d11f88c0b52faa0dfdbd17539ddcb7d','1');
insert into __USER(nipg, password, status_user) values('1005812029','bde0601b19288ca883414b21876bc33b3e8cb23df86b588198e611a7ab80339b','1');
insert into __USER(nipg, password, status_user) values('1005812030','d91ae569ceddebd4a903e2cf084a7e759e730d02928c2e058243ec610f1f499d','1');
insert into __USER(nipg, password, status_user) values('1005812031','fc3f0ad28bd996c7758e084d27ea8370e519da9213dae3573d5593155f2f299e','1');
insert into __USER(nipg, password, status_user) values('1005812045','f587980ad59edc1e1b5f4585caf960fededac1ca9d781c7074910d42c90fa09c','1');
insert into __USER(nipg, password, status_user) values('1005812046','af18d9a343fa7d91e5499361811154e2687fdfcca524a07e44f847dc550e19de','1');
insert into __USER(nipg, password, status_user) values('1005822033','dca937ce526e12f776ac5767500ddd003c6b5282386500123db78f16edb90ba0','1');
insert into __USER(nipg, password, status_user) values('1005822034','595a4570bd965509cbcddb95616f1a060ebf104db0fd9081f9956611583f0df9','1');
insert into __USER(nipg, password, status_user) values('1005822035','d32e12c9081661739c15709ab5fa650c653e364563c15ba3284f249838139933','1');
insert into __USER(nipg, password, status_user) values('1005822036','e213f84367da8f402beedcc1ac572497f31b8e3587bdbdd878c2d9e5d97cbe29','1');
insert into __USER(nipg, password, status_user) values('1005822037','853295121f0618d8351fdb8656f0987f210db26da0cbaa544b99f5446636db53','1');
insert into __USER(nipg, password, status_user) values('1005822038','ab322eadb8f0d65aaf82f40593c386fe0449a66866919b67dd27d832f0455374','1');
insert into __USER(nipg, password, status_user) values('1005822168','eab1f4da2d782d4db423507d8b67d228b966984f717c9c4392f88a5237a9450b','1');
insert into __USER(nipg, password, status_user) values('1005832039','c06950abe4a879f9ba62c9f1b6aa8d5442e03eecad515aa24649490e90c0f8da','1');
insert into __USER(nipg, password, status_user) values('1005832040','51ff2439b94302d6b95d46dc65cf661755b04265234660e3721337eaeffbde84','1');
insert into __USER(nipg, password, status_user) values('1005832041','dfe692dee742cdbc63b60a65b9f32f19104498fc97301bffa3c5e17cb0d8b8ac','1');
insert into __USER(nipg, password, status_user) values('1005832042','071cfda3ee0123dbfb553fad23e6166f06bbc1ac084de2c3214e8c48e538696b','1');
insert into __USER(nipg, password, status_user) values('1005832047','56058f45796451d27ffb33be62437d4ede7c928dd691352acbe224abd1d29ef1','1');
insert into __USER(nipg, password, status_user) values('1005842043','2a1a18d51fd4640926d4616992b4198d53fa0996a91a75e4a22bb19ee6e9056c','1');
insert into __USER(nipg, password, status_user) values('1005842048','3cdd2142d73db08fda7a033596fd5be904238cf51dbe7b71dd31d4fbb703c196','1');
insert into __USER(nipg, password, status_user) values('1005842170','4489db3247f70e5883acfa6668a5957841f12b5c578bbcab6507f9af1ed4ac05','1');
insert into __USER(nipg, password, status_user) values('1005852049','216a711b2aff72659ac54f18fe6c690dc5abef57150c3bd9e332c0f1db90c3b4','1');
insert into __USER(nipg, password, status_user) values('1005862044','2f79f03a3832d84797763427a4cc2f2db70ec8f176ee700d7b7136822bbf2fe2','1');
insert into __USER(nipg, password, status_user) values('1007732204','a68a20a606413b6a5843ec7980fcab8da9cd7b52342b0af80acc1f0bd9de540d','1');
insert into __USER(nipg, password, status_user) values('1007812207','23fca3d737f82e406d1347eef08b767da23ebd01fdb4f49c3b41a5b87d7e14c5','1');
insert into __USER(nipg, password, status_user) values('1007812209','51f5bb94e9cd04a963b7053c2a063e582779618ee0b6ca72c62e6d83e76ce4ce','1');
insert into __USER(nipg, password, status_user) values('1007812210','a7bf751e4e9d30e46ae616d82f8495768304fb5b91fe5fe8b399171660bce909','1');
insert into __USER(nipg, password, status_user) values('1007822211','1854717c906321219a74b3ec47f781b7bdd4bfe407a256c08c6f4a733216811b','1');
insert into __USER(nipg, password, status_user) values('1007822213','526217d4cf472e0ee3f362fac3345f27a9e8ac23d6e8e94bf60fd7236cbcae9d','1');
insert into __USER(nipg, password, status_user) values('1007822214','007a0ebd09155f67eae3b0d74a70b40af404c80bcd010638bc604ca0787b8f6a','1');
insert into __USER(nipg, password, status_user) values('1007822215','4ba7c8c826432d9a143a909bd3cd6e6bba26809777694c97206ed4f023a2013f','1');
insert into __USER(nipg, password, status_user) values('1007822216','01fdbc29eb23f08ef6605eb1a37304a14e7616323029691ad0279bf5717ae60e','1');
insert into __USER(nipg, password, status_user) values('1007822217','54e3c1a3efb3c847813f9b934404ec4063f4091c5ed9e0cd09b7df48f85df297','1');
insert into __USER(nipg, password, status_user) values('1007822252','0fdc050fd159eb9df4be55522746c1bedf0f4a574dff28c0bdad18ca91663ee0','1');
insert into __USER(nipg, password, status_user) values('1007832218','2404f500edc175974df9a7f71bd8503115d821c27594b0863966db311d7e606b','1');
insert into __USER(nipg, password, status_user) values('1007832219','bf7bb4d1e695b70f8937c5cb28b23da47cac6d27a2a81cb7a422532288937c07','1');
insert into __USER(nipg, password, status_user) values('1007832221','75d1940a879561fd810883de190bd2cc1f0154bf7119c5740c18df5a0a052df2','1');
insert into __USER(nipg, password, status_user) values('1007832253','6c5c85c9c7d2fcec89ce405fba9fba90b571dbbac196df41660d03cd0a830f5a','1');
insert into __USER(nipg, password, status_user) values('1007842222','3a09f17bb41fbec2bba78720aaf4698bc9afca1c860835008f16904ec2065fcc','1');
insert into __USER(nipg, password, status_user) values('1007842223','de19a222c09fca7837f0c06358d0f517dbb7d27d101e45e33556562649cde09c','1');
insert into __USER(nipg, password, status_user) values('1007842224','97e04b0743093f6e25c85fba7d2158c5bc7865e1f2b667e522b38acf2ef02819','1');
insert into __USER(nipg, password, status_user) values('1007842225','94be511ebac0a1c69fb342df046727628c20da1e6b6390541efaaac729bca6aa','1');
insert into __USER(nipg, password, status_user) values('1007842226','081b77cabf38adc8cca7ddbb55e76ae86137c21653492ddfbfae314af8fc85fa','1');
insert into __USER(nipg, password, status_user) values('1007842254','429f5808e543cb98656d48d6e5b7497cdeb61564c7770fe03a34767d8a57deb7','1');
insert into __USER(nipg, password, status_user) values('1007852255','f1f339817ea43ee7388e3c73179fca9d2f8fb090ef0f92d10046709f235a69d7','1');
insert into __USER(nipg, password, status_user) values('1007862227','c30cf0fb23bed4a29c5f3dcc6987082be93fe852a7cf3c44dc14702ac8f28320','1');
insert into __USER(nipg, password, status_user) values('1007862228','11fe0baa47d32f1be98ababcfbe27b81517c0e3070f0cce53d4e252007648449','1');
insert into __USER(nipg, password, status_user) values('1007882256','42187d97a8a553ca6fa9b0e7a7bc5340943dff596ba46eabbfb99b4f5a430941','1');
insert into __USER(nipg, password, status_user) values('1008552340','312342662fc2ea5cac5b87fc24a2a9d40ca25fc181f4c2bd3b9e8eb5e8ff31b1','1');
insert into __USER(nipg, password, status_user) values('1008562342','abd85a85367f8f9a808088abc75c8e5f5446c8e0e46180df8e340b36d012918e','1');
insert into __USER(nipg, password, status_user) values('1008622345','1a31a845b4736bf0d3184a4bcfe0c56dea7ab7889a94abb20b41e95d37c83e24','1');
insert into __USER(nipg, password, status_user) values('1008782375','9b0912ec2c29079ec79d3c347b9236c4c093bf55547abfb459bda396929d2e12','1');
insert into __USER(nipg, password, status_user) values('1008792346','b52b886e1223f6be4866e08f424c2eaedb5b225f61beb4f6cd6ef5b81f4b815d','1');
insert into __USER(nipg, password, status_user) values('1008812347','edf202ffd9d52d14670f3f17fdbc44eed7733f4560bff7fa9c16189e55e06a76','1');
insert into __USER(nipg, password, status_user) values('1008812374','428c6aacacaa3c1866b12d35cb7033938465d22a34709dba9f1463e2de209916','1');
insert into __USER(nipg, password, status_user) values('1008822348','a4351d9b947416165ee80df82b7ca08308c68acc8f59afb58e3235e66afbbdd3','1');
insert into __USER(nipg, password, status_user) values('1008822349','d893712eefa5b63b1855c11a5f084df3ae93d5de30c224eaf1e55e5bed87eec6','1');
insert into __USER(nipg, password, status_user) values('1008822350','931e75ed02ab3f8a31166bd371d68fe86fb4b483edf3c8f545ea73b552dfd37b','1');
insert into __USER(nipg, password, status_user) values('1008822351','86732dab12b1e5759480a50b56e217bf46142dfbe998ae739d50e079ca6ad0f9','1');
insert into __USER(nipg, password, status_user) values('1008832353','73c0290bbfb0b7161075e432df6241342690360197420665b00c786f4fcca669','1');
insert into __USER(nipg, password, status_user) values('1008832354','e69631611d3692bd530f78ab17c8580aca7220df4da2b15f26baac802a7ef9ea','1');
insert into __USER(nipg, password, status_user) values('1008842355','26035df428b0a9be988cfbccbb43fa796ae9be776a138c1f0505d8036b13d25c','1');
insert into __USER(nipg, password, status_user) values('1008842356','66b2861688c5395776781ae6d304a4a806743a884e6392f5056b711ce5898306','1');
insert into __USER(nipg, password, status_user) values('1008842357','3741aa42053088bf940a124ec54aa30194cac178497c6c0e4d04e02f71ee8b37','1');
insert into __USER(nipg, password, status_user) values('1008852360','2ba295395736b7e137e687052fcd7d4e763d30f44c8d0c383430fa660a3202bc','1');
insert into __USER(nipg, password, status_user) values('1008852361','150eced8c4c0496d5f04f3f3635fcb4df3745a25091e75d964125bfdb2a58e94','1');
insert into __USER(nipg, password, status_user) values('1008852372','1095e840ff3258bca442877d013c8ad980ca64cda19129640efc2874a194a093','1');
insert into __USER(nipg, password, status_user) values('1008862362','2030a6cf3d0591bfc5061cce8796d40348fe6657bf8ea05c668bbaf857fcc8ef','1');
insert into __USER(nipg, password, status_user) values('1008862363','994fab56504ea278d3a922f8deca363fd19cd9795c4136bf98c5af600cf166c1','1');
insert into __USER(nipg, password, status_user) values('1008862365','af3462d6cf36c409024d40547d545a6c9feab800a374471fd2d146325287f812','1');
insert into __USER(nipg, password, status_user) values('1008872366','86770c8e7ae00a5c5962c92ea484a47a39f1f67425bab6f2b8b74402b178d22b','1');
insert into __USER(nipg, password, status_user) values('1008872367','0d1adffe68f0836a1d4285bcffc0cb7289c479fbc6c79cae4919f1de247d7b0a','1');
insert into __USER(nipg, password, status_user) values('1008872373','9852d1ae0f33df985c957cba06c8d757a9bf4b9a06868642abf7830f1f25788d','1');
insert into __USER(nipg, password, status_user) values('1008882368','90467df38ec3edb78da0b3ca83f47f1cb8dbca18437c7919e92cef9ebb0e5d28','1');
insert into __USER(nipg, password, status_user) values('1008882369','d55a1d4f54c424c4f035691b3c0d7168fbb6bf3590fa77a5e24fd8b7484a37be','1');
insert into __USER(nipg, password, status_user) values('1008892370','59d448e02454c452037b5804914c7d928d7b7969aa7184a7e548cb89400056c2','1');
insert into __USER(nipg, password, status_user) values('1008892371','a39097b4ad545301e69566e2806413f0eb5bb0f66c524dd11f1ee5bd393d464b','1');
insert into __USER(nipg, password, status_user) values('1074540801','cf6a34b2508c2bf8d61012fcbb9586270a0bd1399dcd526611d4bb2f40fc19d3','1');
insert into __USER(nipg, password, status_user) values('1074540820','3877d1a85331f731d6a0d9b4be218d7b8794fe87ce7f737c0f8d61271f58eb16','1');
insert into __USER(nipg, password, status_user) values('1074550788','0db8acef36c8724eab3c0e914206737138fedaf87b7a5a2c71c7f3f62a752817','1');
insert into __USER(nipg, password, status_user) values('1074560784','dda0e49f34bf0eee5352e9494812209059b4f85ea4c2eb460afbafcc2bc15fa5','1');
insert into __USER(nipg, password, status_user) values('1074560785','8448394b5faaa53e3c6834daf749d6d272e71515d6755f1df0b8aea78acc272b','1');
insert into __USER(nipg, password, status_user) values('1074560823','349c7f723bbd12a35de6beee7ebe79b25b3dadb9e790f965214910e2006605cd','1');
insert into __USER(nipg, password, status_user) values('1079540837','0788fbc857a29a6284b6456ebd78b13c81e9c9f3c57b24a4e96da82dd49b87f7','1');
insert into __USER(nipg, password, status_user) values('1079540842','b535c09a01e8311e03fe3789fd3999e72852f9e654c2ac0f9cc2beac9d76f60c','1');
insert into __USER(nipg, password, status_user) values('1079540844','6bb5e262261d1d59e6964632a8e2d8aabdda7871d79b89a2a138c06fa9dd27e5','1');
insert into __USER(nipg, password, status_user) values('1079550845','7c594ab3c4d1b8f3d59ecd220c0b6b1d46359e2b6beb6196bf2b27bf2895ca66','1');
insert into __USER(nipg, password, status_user) values('1079550847','2fb4d23d23bbe3c6e17a0f690f1fd8172312d9ebea8ab76aad2cca6523b384c6','1');
insert into __USER(nipg, password, status_user) values('1079550860','15be950e4a700f32f9f55575aed06e9f63788d8560d8815610db11ae9b993e1c','1');
insert into __USER(nipg, password, status_user) values('1079550862','b238b6a910d3fff14947f482454af5305ebf2b9e877da0d841958c7a35e501fd','1');
insert into __USER(nipg, password, status_user) values('1079560841','a1baea8b6f3ed7c72af1bd2cc9a27dfe57e651a2a95cab438530ab1137f334ee','1');
insert into __USER(nipg, password, status_user) values('1079570848','23f05f626a2f65816503e7f3ca759a88b5c40fa0e0ee20e5ecdbaef9029129c3','1');
insert into __USER(nipg, password, status_user) values('1079570853','ec27c7833c43a45763ab042fdc0c91f72eb73b8321ca29605bf4629fcfc962c1','1');
insert into __USER(nipg, password, status_user) values('1079570854','966d07cba1408bd67fbb7e728930cfe06a0cdb2bc6c9653710c0e585957e5f89','1');
insert into __USER(nipg, password, status_user) values('1079580861','5bff85cd628806de2454b66c46fdf4e4310a4e7854ce7f9d524b757d80177fdd','1');
insert into __USER(nipg, password, status_user) values('1085540996','a02d2e9cb1665468ef8beb5b7f78cb97b30e5f0be8003fa98eddad54a8cd038a','1');
insert into __USER(nipg, password, status_user) values('1085590998','1c8c3d7df39b3bd0d371628cf8391fcce4d0174c405e3a36480d482d7af6fc6d','1');
insert into __USER(nipg, password, status_user) values('1085600999','085cf204b4758de2d85ffe39fa54400e009357ea414494a0fe1e71cd34032ef8','1');
insert into __USER(nipg, password, status_user) values('1085601000','f30b6b750dd589a9368116d19bf3e5dd4b1a307007753f34947d5a136e0ca31b','1');
insert into __USER(nipg, password, status_user) values('1085621001','baecfcf42cb8e7be97b7baa6d5d27762c6d50136781b3b8a629697ffd65a1291','1');
insert into __USER(nipg, password, status_user) values('1085631002','921a01e68be8becb7859263b1fb6217500add32bb367586de79ff3855f01f97b','1');
insert into __USER(nipg, password, status_user) values('1086561007','b568626f008307b27b884d4845400caf1ca832d23e2dfe1f8b169a77541fb015','1');
insert into __USER(nipg, password, status_user) values('1086611008','3e63f6f7b6e4231569d5df5dc15a3dabd58254cd5304e1e2c0954f8be69f92c6','1');
insert into __USER(nipg, password, status_user) values('1086621009','3cb32df7977d88e3252697154b868f0e0506ee96e716493923a2e701cc96521e','1');
insert into __USER(nipg, password, status_user) values('1087591095','347580156c84a6ac828b3bf689e18de4b619c2a408a7f3120bc0b08976a3c0c3','1');
insert into __USER(nipg, password, status_user) values('1087621097','66f828f9828715e67ec1e3101958facac3dc16a9ed996d6fb7a734a6d4ba7494','1');
insert into __USER(nipg, password, status_user) values('1087621098','75d8441f8073cd314469381ecfc3d97f8443f76a6b9cda8e06c2258c7694665e','1');
insert into __USER(nipg, password, status_user) values('1087631099','9618d1e4d140144f919e0b16e93967fabcb8cfc68c3aa0b7e205c795fc5d346b','1');
insert into __USER(nipg, password, status_user) values('1087641101','2e5c0bd6b63fcc4731cbecbf84e09ea0b8c3574369bc70235c9e71bc816451b8','1');
insert into __USER(nipg, password, status_user) values('1087651104','3c8870e5cb5c79b10a855a4ff57b560406dcaaec72c8fb22ce78a76cd7f9ec93','1');
insert into __USER(nipg, password, status_user) values('1087651105','dfbe017f79b32c810f9564ffcf7c72206b6cf25592068a9697778d7f803ab670','1');
insert into __USER(nipg, password, status_user) values('1087651106','f1c2f0d0bb16de99bebb4755954bf09120d01d762b95b7c908ca0c78ba3d37b3','1');
insert into __USER(nipg, password, status_user) values('1087651107','d5794993f9d1092fb5ae85293aa7bfe773ed1345c70b186919a549252deb60a8','1');
insert into __USER(nipg, password, status_user) values('1087651109','8d13edc76803734b0f3e831278917a8eed1336c1c70551ff4c37de5c37b4ce3f','1');
insert into __USER(nipg, password, status_user) values('1088581172','1d96a6fcafb5d4113a6290d99d3ab3b9198eef9acb1bb8d56b204d3029f76290','1');
insert into __USER(nipg, password, status_user) values('1088591173','63e2107eb20e243e03f1b9af96d279eb8bfee3de297f0c517565fc4ba7a23781','1');
insert into __USER(nipg, password, status_user) values('1088591174','f6447bd04199195f30754c290f177f3ad422630009e1a67a28d3f313a34af07c','1');
insert into __USER(nipg, password, status_user) values('1088591175','d66138c108304e631ed0224ca28a3d84ecc7ac940ca177bd2da0d5e74fb5208c','1');
insert into __USER(nipg, password, status_user) values('1088621176','3d59b4280d1a9dd97f5eddc05d4900adcc4880d84087d45de8d2400830f000de','1');
insert into __USER(nipg, password, status_user) values('1088621177','5787a59ea00217be4009f2d5f0f52d7dc20f4b26a1443387cc385a10de2d7283','1');
insert into __USER(nipg, password, status_user) values('1088631178','15ab63dd90fc9053d754406adde3819b925b2ef0a3618aeab493aadea7206bb4','1');
insert into __USER(nipg, password, status_user) values('1088631180','cf14b0376b2a08691bc0b0fe4f658e39d6abeb88a0971d9a4c903c6543dba3f3','1');
insert into __USER(nipg, password, status_user) values('1088631181','c23b7fc11a26b39c6e1307f4d7e1d80df2aad5b28807b65109def799aefff6eb','1');
insert into __USER(nipg, password, status_user) values('1088631182','d6bdf7eaf7937ab7ede9cd73bbd727eb1c924e1c6f450d441509feeb4d3aa200','1');
insert into __USER(nipg, password, status_user) values('1088641183','7c75f4dab9765de226b717f912c039375dc6e5e9ab85d7dacde3dd95030a8852','1');
insert into __USER(nipg, password, status_user) values('1088641184','b3ed9d86b320a1612dffb4a8dab9f9d8ce51e2f132e3bbe1e398a752ee7d6c4b','1');
insert into __USER(nipg, password, status_user) values('1088641186','8cf8cb4251ffb3ef8811d3105fd88a82da6dad723a797478f9108b91d852b902','1');
insert into __USER(nipg, password, status_user) values('1088641187','f0836e05866e230aa541adefa221bef1ab598288398e213e9e60ab9609393dcb','1');
insert into __USER(nipg, password, status_user) values('1088641188','caaf3f161db8df40749bfb5007dc77df0a494e27e14d3792090f14b71cce0d0d','1');
insert into __USER(nipg, password, status_user) values('1088641264','06681afe0996e03388c6dd051d9ac33f451af095fa61d7a917414cb67bf9fa71','1');
insert into __USER(nipg, password, status_user) values('1088651189','e1b604d10d16059a02f5bb5f87e196cef55c7a170cd23dd5937fdcb5eb18df96','1');
insert into __USER(nipg, password, status_user) values('1088651190','257d3c6b4da3aecc504f265e99e31fb3baf23e2201acd652e2fd6194feb7f47e','1');
insert into __USER(nipg, password, status_user) values('1088661191','2554d94fa7cc28cc09d40a55912ef2986224fcd95d8533c896d7de1bb4ae626a','1');
insert into __USER(nipg, password, status_user) values('1088661192','f780d464312587eb291ee5a3fa26dccefa667080d2d0a3ea751f93432f5590c6','1');
insert into __USER(nipg, password, status_user) values('1088671194','a09556b4c831a38d9867504b4c9281290ba46521839f70c3f6bcb63d2f157e4c','1');
insert into __USER(nipg, password, status_user) values('1089561308','52563719ed3edfdce322f66ad9aac2a0b1d83ec46bbf9680698b84055031a4e9','1');
insert into __USER(nipg, password, status_user) values('1089601310','90ddfe14cb6b44806e3be7a8a89520dca9966121322c07b067ba17d8baa9e021','1');
insert into __USER(nipg, password, status_user) values('1089611311','3e7798b6a4f5409a396e4a137298a804b5271f0b689b9f290d63542b02ea440c','1');
insert into __USER(nipg, password, status_user) values('1089631312','7946920ea700383a75d0070ea1253b62d48cf38bdd525e43319292f47aae224d','1');
insert into __USER(nipg, password, status_user) values('1089631313','0dc457115d523c0afa256218833f874bf271512b53fa51de867bee29afac46fb','1');
insert into __USER(nipg, password, status_user) values('1089631314','49ce7abe877942a735a3af0fa894855c05c81cb127633d3daa2aead6e2a13b79','1');
insert into __USER(nipg, password, status_user) values('1089641315','daa8fcbe461dc90731ce841fae3a6a88f8cd0a24d8c072d69874c39feebe81ec','1');
insert into __USER(nipg, password, status_user) values('1089651316','3c4a5d31bc07ac24d98d640ce29aa73338724629412d434b0f701033424a384b','1');
insert into __USER(nipg, password, status_user) values('1089651317','c9204d03d64a904358e4a7a92c65e70383bcd8935a1a00ad00b3806c6204d10e','1');
insert into __USER(nipg, password, status_user) values('1089651318','77a88df44516a92184add8a1afe3758fea8e5b1d4f465c6dce28ede914306a6d','1');
insert into __USER(nipg, password, status_user) values('1089661319','413196635f016814bf9b091240ce64066c5fd6a0cff70954daf79c764e91d5b9','1');
insert into __USER(nipg, password, status_user) values('1089691322','b9d3e521b878aa4f796a316010e86366805acf3bdb3768b2fe9075097535f84d','1');
insert into __USER(nipg, password, status_user) values('1092601455','beda603ffd1c4e4ae59abf20e1bb6847040e0cd5f529e1ae7c08b462d998005b','1');
insert into __USER(nipg, password, status_user) values('1092601456','f6d3e9920ffc6a4266546d82cfd72f9e1367075fa2651bed509768d04d472c6f','1');
insert into __USER(nipg, password, status_user) values('1092631458','09433c66aa933187ac2488e2ed2ef41da22c4b1b1377711df134dc22cfa3ac68','1');
insert into __USER(nipg, password, status_user) values('1092631459','db6f19382d58d7011f78214b95e4e320eede330e60e94aa1c78f7aa702ae3c1d','1');
insert into __USER(nipg, password, status_user) values('1092631460','ad19a3b2467f4d7f109eb08a1e376593e31deb9855623028b85473d128280bc8','1');
insert into __USER(nipg, password, status_user) values('1092631461','a53d7fb961d22edf622c13ab881d6b160270533e4e26cdfaa8ef7b2065798f2c','1');
insert into __USER(nipg, password, status_user) values('1092631490','218e93522cd1c6d1500617e153921764558d305f0fe0733682a97b764d07d951','1');
insert into __USER(nipg, password, status_user) values('1092641462','290e23e1862152716fed8a4ea79ec75dd2b3476c798a39893339b9939cdd3b8d','1');
insert into __USER(nipg, password, status_user) values('1092641463','8ef4a8d6e0e80e103f33d9a74284fb7bc5353c499e12bddd7e6b44c36f143f5e','1');
insert into __USER(nipg, password, status_user) values('1092641464','b9d154bb51293fa90c7a36b4917269c585538ed9da7f5e347a76d27ca2668c9a','1');
insert into __USER(nipg, password, status_user) values('1092651466','66c458ee6c658e1a254e619ce3283d23197d04d49689fa0561f0835a13a25891','1');
insert into __USER(nipg, password, status_user) values('1092651467','c40b2fb794fcfe4bd1d205537802538ad9ab83b90ccb427c5347152fb1dc39b6','1');
insert into __USER(nipg, password, status_user) values('1092651468','988146632369170c5cabae1c6b57ddfbbf10429bb2fb99e18a601d0e98877115','1');
insert into __USER(nipg, password, status_user) values('1092651469','73a1b1814a380aa1a6529fea85e756759a2f614b8d87e40b61ba744006d1bdcf','1');
insert into __USER(nipg, password, status_user) values('1092651470','376d88eb3ed750854ee968c95f5169376f48f070761f9223d7dd99f7d5ece803','1');
insert into __USER(nipg, password, status_user) values('1092671471','71ea0e3bc415d94c888b86387a1c66c91907b7980652c4dc90a0c621089fb17b','1');
insert into __USER(nipg, password, status_user) values('1092671472','c202395e70fc64e43444746ec8c8347f970785fb2aa85f9eecea7b7b06c84b72','1');
insert into __USER(nipg, password, status_user) values('1092671473','ebe0e2498e8cf0f7dd784760fefdfcb6082d626e99ebf181bf86e31e0a780e08','1');
insert into __USER(nipg, password, status_user) values('1092671474','9841a2249d4a0a506ec6fdc309e62c7d2b9b534788dd4c9b35a5dc42c794c274','1');
insert into __USER(nipg, password, status_user) values('1092671475','7e51ee6f40ff7858fcc02911b19541c11f192e286f6f4fe1bf1883aa537736a8','1');
insert into __USER(nipg, password, status_user) values('1092681476','e75a148951dd74eb9adc74d9a746e682608dc36a33f134d151f8e691fbe3331b','1');
insert into __USER(nipg, password, status_user) values('1092681477','90bb2a4ba6a8123c744728ba41a7c753463e3542f756a4350cafac8848f6baab','1');
insert into __USER(nipg, password, status_user) values('1092681478','3141ea6d0abaef3e2d6bbb95786660740af8d995479a739e77489091ad856e13','1');
insert into __USER(nipg, password, status_user) values('1092681479','3be6ef5bc1de61b521d3f038c46ba048a2d6aba5c2ec445d41934d93b41b11c4','1');
insert into __USER(nipg, password, status_user) values('1092681481','f2e9d64223a79a6b45ef0d87cf2a2bbd75c86c6cc247b3733582e66c33a758ba','1');
insert into __USER(nipg, password, status_user) values('1092681482','3272c737832194d62824c9250a65a13105ce9fb5cdab29c7f07b857f586a2376','1');
insert into __USER(nipg, password, status_user) values('1092691483','b2d7885308dc1bda01d3d8b994a27f4ff3ae53a9785ca6d48d6a8873485b57f9','1');
insert into __USER(nipg, password, status_user) values('1092701484','89e717770713de40a56130e4c97fc8bc6de49012aa2f78c661f76a4b9875fe1c','1');
insert into __USER(nipg, password, status_user) values('1092701485','e4c24623e62294b2d35d625180745c474e40ec805e1cb6369c3eb5366cdb6f51','1');
insert into __USER(nipg, password, status_user) values('1092711486','c8279347d0215d95974a31803607c8eaa7b3dcd7be40014d15909d3200273646','1');
insert into __USER(nipg, password, status_user) values('1095691577','890c572fb3f683235af254321766b4bc4065705cbfb5486a9bcaafc6e9cb7efc','1');
insert into __USER(nipg, password, status_user) values('1095691578','e620857ea0c2ee0e10f7b7fa5b065c91d7baadb1f2ecfc530368498cf50cc0ad','1');
insert into __USER(nipg, password, status_user) values('1095711582','2c8432066a8ce15576ecb969d1dbdc69eb6857ce0520035c84659828dd6f3846','1');
insert into __USER(nipg, password, status_user) values('1095711584','80cef06cfa99cb18cb80b57468e51e3ba67e3ea3cd09528b2d921c2e2f37005e','1');
insert into __USER(nipg, password, status_user) values('1096701598','790093a7cbe30e6577f29e3af6fd4483ddf20f0b5256185fb87ecb93fad69e56','1');
insert into __USER(nipg, password, status_user) values('1096701599','7be27e494b82cd6fe2ab92499adc444d8a42da4415dcf5edfb86bc4651ac9312','1');
insert into __USER(nipg, password, status_user) values('1096701600','da19596287c987ed0ba0f32224970dcbdac26e79538139718b75bb50f4d151f1','1');
insert into __USER(nipg, password, status_user) values('1096711601','cf666178bd5e16a06a1002546f16859f285da77dc3e34de8075394dc4fecc000','1');
insert into __USER(nipg, password, status_user) values('1096711602','94f0222d26c2bca0c9c8735365457610f9819cb8a6af14cf6f6eb60d543d9e04','1');
insert into __USER(nipg, password, status_user) values('1096711603','7dd1cadfe543a8ac52e7eea505638bfa7d14ade28fd79def545d031192bb1a71','1');
insert into __USER(nipg, password, status_user) values('1096711604','00c6ebc4cd33a1e48d7022f61f79cdf509ba0c16c8e6e7623d186f7fa5753154','1');
insert into __USER(nipg, password, status_user) values('1096711605','8431bae93c766c416c9483305abf3f1c0ecef6b9fe46c239c6ae0ea952d20753','1');
insert into __USER(nipg, password, status_user) values('1096721606','1abf215eeddb37ddfd8240cce56558cd9928265c43f70b08f8cf96e6b1aded46','1');
insert into __USER(nipg, password, status_user) values('1096721607','cf00f60d0cfb4cd15bf0566ca30cbac4d986e736dbc6b536f4b531d858de4fdc','1');
insert into __USER(nipg, password, status_user) values('1096731608','558ff0d7427cd7c6034ca4391beed70cd1307fe9921f49b634b0c206d0b7074d','1');
insert into __USER(nipg, password, status_user) values('1096731609','3cb7c35b80f829a5dbb9ca279e7bade1dd38f58e08fddbcec474f6cd1da7da35','1');
insert into __USER(nipg, password, status_user) values('1096741613','4b055d255a072f840c7aa7bf8e89134b0ef5bb44101f8bacb4c5c0c34d8c5472','1');
insert into __USER(nipg, password, status_user) values('1096751616','5559784eeadbe61d8b066a5a61f6a92809112550f8a275bff0a09ab75f4c7932','1');
insert into __USER(nipg, password, status_user) values('1096761615','d04e83334ddd698dd3cc8466f46651b6833512a13e0456dc52ea0aaaeeb9c776','1');
insert into __USER(nipg, password, status_user) values('1096761617','2152ba994f5bef39aafe95ea4e8a8abd06186f4f3eb2d41f1bc53d6972943c39','1');
insert into __USER(nipg, password, status_user) values('1096761618','58446075cf9dd46ddd0fe0ee1f8287126af88cc902057f05855619fe338def36','1');
insert into __USER(nipg, password, status_user) values('1096761619','4f552fa28323bcb6d4620913ebcd597c1da6be4f33476ffd46663fb2031bac1d','1');
insert into __USER(nipg, password, status_user) values('1096771620','d1479f091bb8ecc55b8f912e7957e064538bc030f6b0762c43318b141ac164c8','1');
insert into __USER(nipg, password, status_user) values('1096771621','edf502ed0b3cf5c6668f5463ab6cf1337b7cdf0d0096fbfcd2715b7db6b640b8','1');
insert into __USER(nipg, password, status_user) values('1096771622','4a622d622b6700159a324a1cb1bf6b3295db4f8d324c0d911ac8e849ab0fb08d','1');
insert into __USER(nipg, password, status_user) values('1573540726','23de7446301fbfdfa8c528b5953752157ae89dba99cd1c2db3f30358804fda3c','1');
insert into __USER(nipg, password, status_user) values('1575540760','1ab4366fa7cdac0a74e729f88178ac9199a4982d8170356005dc03b362baf462','1');
insert into __USER(nipg, password, status_user) values('1575540761','5de4e381c83f7599aaf62c97bf059aec7d61697750169e95d45659647e387ae9','1');
insert into __USER(nipg, password, status_user) values('1575550762','1533dd1f83d71a7e3243d32f4ad40a7105094f8ced86a7c485fb9f547a6d9d5c','1');
insert into __USER(nipg, password, status_user) values('1575560763','f946fca67949093faaf3496071fb4c68e4042df584b2b6e9af6aa535b0c2e8e8','1');
insert into __USER(nipg, password, status_user) values('1575560764','789886fb7c938e90a32ad9eeddc5bc38bffa51246a14b016808d26e1d349b344','1');
insert into __USER(nipg, password, status_user) values('1582620914','977eaf37a83e8d4a618d6c8d94a54bfcaa49188c063641eec0fec86b60db7fab','1');
insert into __USER(nipg, password, status_user) values('1582620915','845d2f591357b71be1c9070675a25c62fcb88e2090450dde78816863e9c57e5b','1');
insert into __USER(nipg, password, status_user) values('1582630916','ce19e34acee05a285f1bb284d0fe8188c9903d00e03719903d680eb27db99d0f','1');
insert into __USER(nipg, password, status_user) values('1583560923','2040d40c1476623f7025e3f7d5f81285f4ca4dd491a4017ca74b8c7e20196405','1');
insert into __USER(nipg, password, status_user) values('1583570924','44ba1ddc87913cda013b831f2158204e8dae556fe2c5d6a6786709fa856b9c73','1');
insert into __USER(nipg, password, status_user) values('1583570925','99c07c2a36eab1e93313d336fcdae79afb91170aa4c63f938ff4137920a8c53a','1');
insert into __USER(nipg, password, status_user) values('1583580926','e300b2cc3215cea63380c5c7d4cdbff4ce09fe43086af23620b4cc94da7ee32a','1');
insert into __USER(nipg, password, status_user) values('1583580936','02766be529d2e35d0fbb3e9d2aa1555bf9725cb197a7e7b7cac763ec8580c2e5','1');
insert into __USER(nipg, password, status_user) values('1583580941','1c8a5cdebdb51df12fb2910d828ebde2c3e55f872270d82994265f2151cd8aee','1');
insert into __USER(nipg, password, status_user) values('1583590927','2f3df1843427301e927a01e2ba41fc00f89a1aa9950aafc800bc2a8cd608119c','1');
insert into __USER(nipg, password, status_user) values('1583590928','2abbd53c77cb65b0bf2e744c7b2e27442486122edbe4a6c9380592500359910e','1');
insert into __USER(nipg, password, status_user) values('1583600929','2b891a8b5dea3300c92179749b58a504fa7e16502e49f428690a8a7ed5e3f7e9','1');
insert into __USER(nipg, password, status_user) values('1583610937','453173c65e1f5e6d84c612a82f17b7b3d6b631eec051b6cba50b41763145e954','1');
insert into __USER(nipg, password, status_user) values('1583610944','cd9c9331b7a70a224c7c63805e80a783892f7a951730cee807d037ef6a146fe1','1');
insert into __USER(nipg, password, status_user) values('1583620931','926e2b6398a7ba49f9536e5ec36f6eb55dcc7a301118808cc5ff7c8071ac2e50','1');
insert into __USER(nipg, password, status_user) values('1583620932','cd5b931355f479317cb93ed3ca99532ceaf1c721eb899a8be368fc56dc131bfc','1');
insert into __USER(nipg, password, status_user) values('1583620934','6c9280a95cea5ac1844908c9adb457475d7c7662f37586b545b1bc0bf1444367','1');
insert into __USER(nipg, password, status_user) values('1583620938','6088bc3703441d38276d8fabdf1a8ab67d65b440c842d1a515dc274f9451099d','1');
insert into __USER(nipg, password, status_user) values('1583620939','c769cdf3318135f77f13b3a6ad0fbaf4673441b2c6033819b1097459c904feb4','1');
insert into __USER(nipg, password, status_user) values('1583640946','c7ec11be7476effb972cc3794969c9cc11624788aa4753a638f49c71b3b95d7a','1');
insert into __USER(nipg, password, status_user) values('1583650935','54ca706d16a3eb145012b854fccad5840188fea6054099a16cc32751cacabe12','1');
insert into __USER(nipg, password, status_user) values('1584590959','01918e2b6cb40750bb15db65180758b7cd76cd514a76ea7f8522da92e98832ff','1');
insert into __USER(nipg, password, status_user) values('1584600960','b59cfd2c8150989a93959bddafb15526aaebac38fedc2abb2fc57a9967d046df','1');
insert into __USER(nipg, password, status_user) values('1587551126','5cc65cee74f84dac3c657299120031914ef5662818a84b58278a565a19bf763d','1');
insert into __USER(nipg, password, status_user) values('1587571127','7647800d09d406436ca45310216a6b2e74ebc5a647af8c0ad84952fec94404b8','1');
insert into __USER(nipg, password, status_user) values('1587591129','154a04b7229fb6f28b7b18e6889984864ddefdf158a2c582da7a62d08a7ee3f0','1');
insert into __USER(nipg, password, status_user) values('1587641131','4f0be3a29afb4377d3281e24f3a00a8db7bc043fe2e54b8788110d51d77f81e0','1');
insert into __USER(nipg, password, status_user) values('1587651133','8cbf09f3dfcf32b0adaf1d9459fe5df9e9b1b5f5b22b7a63735b3926a66ed795','1');
insert into __USER(nipg, password, status_user) values('1587661134','3cdd83e38114b2c26de41fea35ba42fbb4ece7861dcd49ce88565a4c4bcc6075','1');
insert into __USER(nipg, password, status_user) values('1587671135','6e5689473935ff4667a8f561c779d468f4a23217705cbaa44ddb7b3fc5b30dd2','1');
insert into __USER(nipg, password, status_user) values('1588621270','69d066c24770b9ebebecbd32451e18a2b91c1621077afc3cc98e7eea5c51f8c2','1');
insert into __USER(nipg, password, status_user) values('1588621271','5d6599aec545760a987cc0b516f339c64c74498ba7c29c65b59cbc11eef7ae90','1');
insert into __USER(nipg, password, status_user) values('1588631272','741e948540996937b8f75a587ce4996bd47c990dc45127073263e6981da87a3d','1');
insert into __USER(nipg, password, status_user) values('1588631273','74849907466855b313d2f92f266656f886cf4414bc2f5f72a8d791c86cfb4f79','1');
insert into __USER(nipg, password, status_user) values('1588631274','c381dc2876499fd6482750f65b339e95a4fdc2c43e7e9ed6c29ca809e58b675f','1');
insert into __USER(nipg, password, status_user) values('1588641277','28dffc95ed6f54482883ee87bc6bb3afdf3548a321eab5dc77e0a17f5ffd2f49','1');
insert into __USER(nipg, password, status_user) values('1588651278','2154a695d6b8a57c7ed91805c7d1fcc294ee165631bb77dc3fb66814fe804cba','1');
insert into __USER(nipg, password, status_user) values('1588651279','383b2f59bfd5ae9928ab2d017aa7b08b79fbc0eaebbe60d5dbfcd1f6091e810d','1');
insert into __USER(nipg, password, status_user) values('1588651280','526d1f6470b0f22ce082a120af35fd00b577076fb99819021f2bed81de868713','1');
insert into __USER(nipg, password, status_user) values('1588651281','5e4b16540e655c7d97421afe15e82fb2ebbf69614de4e132ebce7293c43d56fc','1');
insert into __USER(nipg, password, status_user) values('1596711639','6be0de177655f8a96da5e9c1635c3134fe9afe710cfb0a1847eaeee710e5b35b','1');
insert into __USER(nipg, password, status_user) values('1596711640','ca43030cc38e2566c14e73412dda317a89289569d1378441cc86dbbf86ad2aa6','1');
insert into __USER(nipg, password, status_user) values('1596721641','ae11912f5b300505fad301af72cfc8b3b5ce4a261c4c913a6e5043d23e839187','1');
insert into __USER(nipg, password, status_user) values('1596721642','ee1d5257bfcf9ab39bdd6924f71dcf79348fde9238deb1b6ba76be0b68e869e9','1');
insert into __USER(nipg, password, status_user) values('1596721644','f7025c9ef9a1800df96a7e847fcc46f71ab7a4c8c1ea173a3b3e67e0e1ed639d','1');
insert into __USER(nipg, password, status_user) values('1596731645','8bf5ed54cbe5d2b26b3db01388bb6e7391d8f24e5a59f41be25eaeebebfa4403','1');
insert into __USER(nipg, password, status_user) values('1596741647','7468997ab447cefe5729f4eea53c54c52a79de597fc84d7ad06e49bf490d8a34','1');
insert into __USER(nipg, password, status_user) values('1674540721','259c8bd98be47b823f901b211acede642911af61f008cc23fb464f0884affb6b','1');
insert into __USER(nipg, password, status_user) values('1674550722','01410f2bcaee151d7a10dd231b3c50734a0720b4300230b182532acdf2438e99','1');
insert into __USER(nipg, password, status_user) values('1674550723','d0c2690511e24563bbbc3fb5f531bd4a542bcd63ace866d33d9b3a833c323e60','1');
insert into __USER(nipg, password, status_user) values('1675550774','13aa58d92ef8703651fbf829fb28e0d0c533e5cd711069d0b5e3bb750d50709b','1');
insert into __USER(nipg, password, status_user) values('1675560771','ed38fdce0bbad290e8f48e48325d3e39a199900b2b9e60ff8b8f064ab18dcc80','1');
insert into __USER(nipg, password, status_user) values('1675560773','e0d7575613c2fca0cef8dc89b8f50d1924b476fcef10fdab19dbb176c7c91cf8','1');
insert into __USER(nipg, password, status_user) values('1675570728','3a4425c463bd1af3999fe2884ea3c5dcf5df9af5a6773ebe22a2afd8a5e14de0','1');
insert into __USER(nipg, password, status_user) values('1677560832','bc9487ed18b5087bb90b4fe8812e27a0eef62162b524cae931fff7ba43a11757','1');
insert into __USER(nipg, password, status_user) values('1682580899','a2095f215c7fa3aaffee7cbb7270f465185b1e469b0739f68636d9483762ad03','1');
insert into __USER(nipg, password, status_user) values('1683610949','e1165cf2eeae08b847c9d0badb94fe9359b92b82a9a44c9b9b78409fe2486186','1');
insert into __USER(nipg, password, status_user) values('1684590967','1ec8885677708c20120da121cd5e9ee617ac2993979ce4251256f3b0e13cec03','1');
insert into __USER(nipg, password, status_user) values('1684600968','706bd5e7030db0be7f8f335a9fd453931ae4243d145ad2e6bab34ba164bba843','1');
insert into __USER(nipg, password, status_user) values('1686611046','3a0ad68f7e5ed4173242cf5bd3a18ec4beb0d3b9314a11326611c60080ccff88','1');
insert into __USER(nipg, password, status_user) values('1686631047','8448053fc5a774f864522ea5a02620443140a383e32bf991a287960764d553c7','1');
insert into __USER(nipg, password, status_user) values('1686651048','12aa65d0bef80198a94cd7135fd9b1b9575648b6b0845888561157bcc345a994','1');
insert into __USER(nipg, password, status_user) values('1687591128','9a55d0e4620cbfd627dcd671e88ea6fdc848fb08a3cba23d7bff377e0a8fbc5d','1');
insert into __USER(nipg, password, status_user) values('1687651132','ed1f330bfdbe3b1786d7cd8a320f801f770c612864bd4431d72c9faba2265f5e','1');
insert into __USER(nipg, password, status_user) values('1688641275','2d42f998c2c0f0358472d0a8aa4fda5f6c9b5fb3ebdeabf5910f0f1b6232fdda','1');
insert into __USER(nipg, password, status_user) values('1693601504','97a8a4cc4345fb2e488eee0957d2035269142d52d32859c9d706607d83971210','1');
insert into __USER(nipg, password, status_user) values('1693611505','766a3eec56942b105bf845c54bad8bae1293a36223761d7b65dfda47faaf7b99','1');
insert into __USER(nipg, password, status_user) values('1693651507','35030289e9e162a022485d6cf1ea4e3322f3d1d875ed1e503512eca1cd040d24','1');
insert into __USER(nipg, password, status_user) values('1693661508','decfe34714ed1ec90fb0c441db6baf19f3dca2cc3ab6d3f0ec6c8e8227cb8e47','1');
insert into __USER(nipg, password, status_user) values('1693661509','92a4ee4c3518fcab13995ee0c7446e4e998ec694d4b2bc03a2ce113e5b56a31a','1');
insert into __USER(nipg, password, status_user) values('1693691510','545399d33ee24e1bd3f615ad7604abd5364c5c591e2ce716f0513560fe30dea7','1');
insert into __USER(nipg, password, status_user) values('1699731762','40e5f2dcee47356f6fd07d151feefffc76dd75ed128d1878950fca5844f776b7','1');
insert into __USER(nipg, password, status_user) values('1874540799','ffe80a85aa362f4bd306103783ffbe634dd92b08da106f01fa8813371ca3ffc2','1');
insert into __USER(nipg, password, status_user) values('1887601081','d2c6e3988bb081b40d1ca5d30401853d5940c59d6c14a13af556d8c072dda4c2','1');
insert into __USER(nipg, password, status_user) values('2091641423','bb5256f279bf7524049c14b4e36ca5c8b568a07284a7591a1cea80d85a7b0911','1');
insert into __USER(nipg, password, status_user) values('2580560880','e4055fa6bfb0543e193560cb38c6f1419cff188fc8f409f758567c47ee6f1f93','1');
insert into __USER(nipg, password, status_user) values('2584560953','f1899053cafc3a5699fd6c736adfb0d9e4410a0b121815747fd9513b180b7f95','1');
insert into __USER(nipg, password, status_user) values('2584620954','4c5866fa7775cf0e86b8295e1d5bbd6ae98b100488e6c6028389174f62f4e854','1');
insert into __USER(nipg, password, status_user) values('2589631364','933d079965f7b3606cc8f72a026485c99388a0efa4959a17a28b031a5b3c60d6','1');
insert into __USER(nipg, password, status_user) values('2589641368','8188d6c355110a75bd650fb3f5b2f13ddec80e5effe519d8a68b28567916e93e','1');
insert into __USER(nipg, password, status_user) values('3004791984','b712aee65da07e6aeb83fecd76ae89c987b0d996508b7d8ab1ed7dc250520995','1');
insert into __USER(nipg, password, status_user) values('3004801989','696a8acf9489038d1a81a892739b983df43b7b55b2fa2a3c1559e41e74d6ab7c','1');
insert into __USER(nipg, password, status_user) values('3086651074','6c85668f6ec3929e59ad49c7cd7b2e557e0657722eb9b98f6b610a4ba67d4ead','1');
insert into __USER(nipg, password, status_user) values('3097741719','2d45e55b5906dd85557329fd724646183918036305b4d11c9531c5a4a5ed32bf','1');
insert into __USER(nipg, password, status_user) values('3097771725','251387460af95b364e451bb06991bd4a2bc234586d16cb46fe35668bc29e83ac','1');

insert into __USER_GRUP(nipg,id_grup) values('1007822214',2);
insert into __USER_GRUP(nipg,id_grup) values('1008852372',2);
insert into __USER_GRUP(nipg,id_grup) values('0092631496',2);
insert into __USER_GRUP(nipg,id_grup) values('1008832354',2);
insert into __USER_GRUP(nipg,id_grup) values('1005812045',2);
insert into __USER_GRUP(nipg,id_grup) values('0088611140',2);
insert into __USER_GRUP(nipg,id_grup) values('0001791842',2);
insert into __USER_GRUP(nipg,id_grup) values('0003771887',2);
insert into __USER_GRUP(nipg,id_grup) values('0004781924',2);
insert into __USER_GRUP(nipg,id_grup) values('0089681350',2);
insert into __USER_GRUP(nipg,id_grup) values('1583610937',2);
insert into __USER_GRUP(nipg,id_grup) values('0088591136',2);
insert into __USER_GRUP(nipg,id_grup) values('0095761591',2);
insert into __USER_GRUP(nipg,id_grup) values('0088621247',2);
insert into __USER_GRUP(nipg,id_grup) values('0089571400',2);
insert into __USER_GRUP(nipg,id_grup) values('0088681166',2);
insert into __USER_GRUP(nipg,id_grup) values('1007812210',2);
insert into __USER_GRUP(nipg,id_grup) values('1095711582',2);
insert into __USER_GRUP(nipg,id_grup) values('0088581201',2);
insert into __USER_GRUP(nipg,id_grup) values('1583620939',2);
insert into __USER_GRUP(nipg,id_grup) values('1088641188',2);
insert into __USER_GRUP(nipg,id_grup) values('1005802025',2);
insert into __USER_GRUP(nipg,id_grup) values('1582630916',2);
insert into __USER_GRUP(nipg,id_grup) values('0088611237',2);
insert into __USER_GRUP(nipg,id_grup) values('0089591358',2);
insert into __USER_GRUP(nipg,id_grup) values('1096771621',2);
insert into __USER_GRUP(nipg,id_grup) values('0092691434',2);
insert into __USER_GRUP(nipg,id_grup) values('1087651106',2);
insert into __USER_GRUP(nipg,id_grup) values('0088601219',2);
insert into __USER_GRUP(nipg,id_grup) values('0092601439',2);
insert into __USER_GRUP(nipg,id_grup) values('0087651080',2);
insert into __USER_GRUP(nipg,id_grup) values('0004781927',2);
insert into __USER_GRUP(nipg,id_grup) values('0001761833',2);
insert into __USER_GRUP(nipg,id_grup) values('2584560953',2);
insert into __USER_GRUP(nipg,id_grup) values('0005812137',2);
insert into __USER_GRUP(nipg,id_grup) values('1588641277',2);
insert into __USER_GRUP(nipg,id_grup) values('1096711602',2);
insert into __USER_GRUP(nipg,id_grup) values('1596721641',2);
insert into __USER_GRUP(nipg,id_grup) values('0093681502',2);
insert into __USER_GRUP(nipg,id_grup) values('1007852255',2);
insert into __USER_GRUP(nipg,id_grup) values('0005822154',2);
insert into __USER_GRUP(nipg,id_grup) values('1007832219',2);
insert into __USER_GRUP(nipg,id_grup) values('0001761826',2);
insert into __USER_GRUP(nipg,id_grup) values('0004821948',2);
insert into __USER_GRUP(nipg,id_grup) values('0001761831',2);
insert into __USER_GRUP(nipg,id_grup) values('0005812140',2);
insert into __USER_GRUP(nipg,id_grup) values('0001781840',2);
insert into __USER_GRUP(nipg,id_grup) values('0004771955',2);
insert into __USER_GRUP(nipg,id_grup) values('1588651280',2);
insert into __USER_GRUP(nipg,id_grup) values('0088581206',2);
insert into __USER_GRUP(nipg,id_grup) values('1008832353',2);
insert into __USER_GRUP(nipg,id_grup) values('0096681632',2);
insert into __USER_GRUP(nipg,id_grup) values('1088621176',2);
insert into __USER_GRUP(nipg,id_grup) values('1005812028',2);
insert into __USER_GRUP(nipg,id_grup) values('0004761918',2);
insert into __USER_GRUP(nipg,id_grup) values('3097741719',2);
insert into __USER_GRUP(nipg,id_grup) values('0098761738',2);
insert into __USER_GRUP(nipg,id_grup) values('0001751815',2);
insert into __USER_GRUP(nipg,id_grup) values('0092661447',2);
insert into __USER_GRUP(nipg,id_grup) values('1092651468',2);
insert into __USER_GRUP(nipg,id_grup) values('0094651522',2);
insert into __USER_GRUP(nipg,id_grup) values('0003771896',2);
insert into __USER_GRUP(nipg,id_grup) values('1092631461',2);
insert into __USER_GRUP(nipg,id_grup) values('0003761886',2);
insert into __USER_GRUP(nipg,id_grup) values('0005822105',2);
insert into __USER_GRUP(nipg,id_grup) values('1088641264',2);
insert into __USER_GRUP(nipg,id_grup) values('0087641079',2);
insert into __USER_GRUP(nipg,id_grup) values('0094661528',2);
insert into __USER_GRUP(nipg,id_grup) values('0081590891',2);
insert into __USER_GRUP(nipg,id_grup) values('0087591076',2);
insert into __USER_GRUP(nipg,id_grup) values('0089691353',2);
insert into __USER_GRUP(nipg,id_grup) values('1087621097',2);
insert into __USER_GRUP(nipg,id_grup) values('1588621270',2);
insert into __USER_GRUP(nipg,id_grup) values('0099731779',2);
insert into __USER_GRUP(nipg,id_grup) values('0005812131',2);
insert into __USER_GRUP(nipg,id_grup) values('1086621009',2);
insert into __USER_GRUP(nipg,id_grup) values('0004771922',2);
insert into __USER_GRUP(nipg,id_grup) values('1583620932',2);
insert into __USER_GRUP(nipg,id_grup) values('1092651470',2);
insert into __USER_GRUP(nipg,id_grup) values('0088611235',2);
insert into __USER_GRUP(nipg,id_grup) values('1087651104',2);
insert into __USER_GRUP(nipg,id_grup) values('0092691451',2);
insert into __USER_GRUP(nipg,id_grup) values('0003741878',2);
insert into __USER_GRUP(nipg,id_grup) values('1687651132',2);
insert into __USER_GRUP(nipg,id_grup) values('1096721607',2);
insert into __USER_GRUP(nipg,id_grup) values('0001751814',2);
insert into __USER_GRUP(nipg,id_grup) values('1088621177',2);
insert into __USER_GRUP(nipg,id_grup) values('0004811947',2);
insert into __USER_GRUP(nipg,id_grup) values('1096711605',2);
insert into __USER_GRUP(nipg,id_grup) values('1092671471',2);
insert into __USER_GRUP(nipg,id_grup) values('1583600929',2);
insert into __USER_GRUP(nipg,id_grup) values('1588651279',2);
insert into __USER_GRUP(nipg,id_grup) values('0001791843',2);
insert into __USER_GRUP(nipg,id_grup) values('0088631150',2);
insert into __USER_GRUP(nipg,id_grup) values('1007832218',2);
insert into __USER_GRUP(nipg,id_grup) values('1005802026',2);

insert into __user_grup (nipg,id_grup) values('0004631997',6)
insert into __user_grup (nipg,id_grup) values('1583650935',6)
insert into __user_grup (nipg,id_grup) values('1092681482',6)
insert into __user_grup (nipg,id_grup) values('0092651432',6)

insert into __user_grup values ('0007842315',7)
insert into __user_grup values ('0007842323',7)
insert into __user_grup values ('0089591324',7)
insert into __user_grup values ('1095711582',7)
insert into __user_grup values ('3097741719',7)

/* data  user grup  centrall committee */
insert into __USER_GRUP (nipg,id_grup) values('0089621328',3);
insert into __USER_GRUP (nipg,id_grup) values('3097741719',3);
insert into __USER_GRUP (nipg,id_grup) values('0088611235',3);
insert into __USER_GRUP (nipg,id_grup) values('0087641112',3);
insert into __USER_GRUP (nipg,id_grup) values('0097681695',3);
insert into __USER_GRUP (nipg,id_grup) values('0096691635',3);
insert into __USER_GRUP (nipg,id_grup) values('0088611237',3);
insert into __USER_GRUP (nipg,id_grup) values('0088611140',3);

/* data  user grup  Sub Committee */
insert into __user_grup (nipg,id_grup) values('0001751814',4);
insert into __user_grup (nipg,id_grup) values('0001761833',4);
insert into __user_grup (nipg,id_grup) values('0001781840',4);
insert into __user_grup (nipg,id_grup) values('0001791843',4);
insert into __user_grup (nipg,id_grup) values('0003741878',4);
insert into __user_grup (nipg,id_grup) values('0003751882',4);
insert into __user_grup (nipg,id_grup) values('0003771887',4);
insert into __user_grup (nipg,id_grup) values('0004761918',4);
insert into __user_grup (nipg,id_grup) values('0004771955',4);
insert into __user_grup (nipg,id_grup) values('0004781924',4);
insert into __user_grup (nipg,id_grup) values('0005792113',4);
insert into __user_grup (nipg,id_grup) values('0005812135',4);
insert into __user_grup (nipg,id_grup) values('0005822154',4);
insert into __user_grup (nipg,id_grup) values('0007842315',4);
insert into __user_grup (nipg,id_grup) values('0007842323',4);
insert into __user_grup (nipg,id_grup) values('0087591076',4);
insert into __user_grup (nipg,id_grup) values('0088581201',4);
insert into __user_grup (nipg,id_grup) values('0088581206',4);
insert into __user_grup (nipg,id_grup) values('0088591136',4);
insert into __user_grup (nipg,id_grup) values('0088621247',4);
insert into __user_grup (nipg,id_grup) values('0088631150',4);
insert into __user_grup (nipg,id_grup) values('0089571400',4);
insert into __user_grup (nipg,id_grup) values('0089591324',4);
insert into __user_grup (nipg,id_grup) values('0089681350',4);
insert into __user_grup (nipg,id_grup) values('0089691353',4);
insert into __user_grup (nipg,id_grup) values('0092601439',4);
insert into __user_grup (nipg,id_grup) values('0092631496',4);
insert into __user_grup (nipg,id_grup) values('0092691434',4);
insert into __user_grup (nipg,id_grup) values('0094651522',4);
insert into __user_grup (nipg,id_grup) values('0094711542',4);
insert into __user_grup (nipg,id_grup) values('0095691576',4);
insert into __user_grup (nipg,id_grup) values('0095761591',4);
insert into __user_grup (nipg,id_grup) values('0096681632',4);
insert into __user_grup (nipg,id_grup) values('0097701689',4);
insert into __user_grup (nipg,id_grup) values('0097731706',4);
insert into __user_grup (nipg,id_grup) values('0098691729',4);
insert into __user_grup (nipg,id_grup) values('0098761738',4);
insert into __user_grup (nipg,id_grup) values('1007842223',4);
insert into __user_grup (nipg,id_grup) values('1007852255',4);
insert into __user_grup (nipg,id_grup) values('1092631490',4);
insert into __user_grup (nipg,id_grup) values('1092651470',4);
insert into __user_grup (nipg,id_grup) values('1095711582',4);
insert into __user_grup (nipg,id_grup) values('1096771621',4);
insert into __user_grup (nipg,id_grup) values('1588621270',4);
insert into __user_grup (nipg,id_grup) values('1588651280',4);

/*data user grup RCA*/
insert into __user_grup (nipg, id_grup) values ('1096701599',5);
insert into __user_grup (nipg, id_grup) values ('1096761618',5);
insert into __user_grup (nipg, id_grup) values ('1007822211',5);
insert into __user_grup (nipg, id_grup) values ('1005842170',5);
insert into __user_grup (nipg, id_grup) values ('1008832354',5);
insert into __user_grup (nipg, id_grup) values ('0003771887',5);
insert into __user_grup (nipg, id_grup) values ('0004781924',5);
insert into __user_grup (nipg, id_grup) values ('1092681481',5);
insert into __user_grup (nipg, id_grup) values ('0089681350',5);
insert into __user_grup (nipg, id_grup) values ('1699731762',5);
insert into __user_grup (nipg, id_grup) values ('1583610937',5);
insert into __user_grup (nipg, id_grup) values ('0088591136',5);
insert into __user_grup (nipg, id_grup) values ('0089571400',5);
insert into __user_grup (nipg, id_grup) values ('0089691411',5);
insert into __user_grup (nipg, id_grup) values ('1095711582',5);
insert into __user_grup (nipg, id_grup) values ('1583620939',5);
insert into __user_grup (nipg, id_grup) values ('1088641188',5);
insert into __user_grup (nipg, id_grup) values ('1582630916',5);
insert into __user_grup (nipg, id_grup) values ('0088611237',5);
insert into __user_grup (nipg, id_grup) values ('0004631997',5);
insert into __user_grup (nipg, id_grup) values ('1096771621',5);
insert into __user_grup (nipg, id_grup) values ('1087651106',5);
insert into __user_grup (nipg, id_grup) values ('1088631182',5);
insert into __user_grup (nipg, id_grup) values ('0092601439',5);
insert into __user_grup (nipg, id_grup) values ('0087651080',5);
insert into __user_grup (nipg, id_grup) values ('0001761833',5);
insert into __user_grup (nipg, id_grup) values ('0004821949',5);
insert into __user_grup (nipg, id_grup) values ('0005802078',5);
insert into __user_grup (nipg, id_grup) values ('1588641277',5);
insert into __user_grup (nipg, id_grup) values ('1092681482',5);
insert into __user_grup (nipg, id_grup) values ('0005802123',5);
insert into __user_grup (nipg, id_grup) values ('1096711602',5);
insert into __user_grup (nipg, id_grup) values ('0092651430',5);
insert into __user_grup (nipg, id_grup) values ('0093681502',5);
insert into __user_grup (nipg, id_grup) values ('0007802278',5);
insert into __user_grup (nipg, id_grup) values ('0007802279',5);
insert into __user_grup (nipg, id_grup) values ('0001761831',5);
insert into __user_grup (nipg, id_grup) values ('0001781840',5);
insert into __user_grup (nipg, id_grup) values ('0007842315',5);
insert into __user_grup (nipg, id_grup) values ('1687591128',5);
insert into __user_grup (nipg, id_grup) values ('1096711601',5);
insert into __user_grup (nipg, id_grup) values ('0004771955',5);
insert into __user_grup (nipg, id_grup) values ('1588651280',5);
insert into __user_grup (nipg, id_grup) values ('1005822038',5);
insert into __user_grup (nipg, id_grup) values ('0096681632',5);
insert into __user_grup (nipg, id_grup) values ('1693661508',5);
insert into __user_grup (nipg, id_grup) values ('0092651432',5);
insert into __user_grup (nipg, id_grup) values ('3097741719',5);
insert into __user_grup (nipg, id_grup) values ('0098761738',5);
insert into __user_grup (nipg, id_grup) values ('0001751815',5);
insert into __user_grup (nipg, id_grup) values ('0097701689',5);
insert into __user_grup (nipg, id_grup) values ('1089611311',5);
insert into __user_grup (nipg, id_grup) values ('1088641187',5);
insert into __user_grup (nipg, id_grup) values ('0089611401',5);
insert into __user_grup (nipg, id_grup) values ('1092651468',5);
insert into __user_grup (nipg, id_grup) values ('0094651522',5);
insert into __user_grup (nipg, id_grup) values ('0003771896',5);
insert into __user_grup (nipg, id_grup) values ('1092631461',5);
insert into __user_grup (nipg, id_grup) values ('1088641264',5);
insert into __user_grup (nipg, id_grup) values ('0094661528',5);
insert into __user_grup (nipg, id_grup) values ('0087591076',5);
insert into __user_grup (nipg, id_grup) values ('1087651109',5);
insert into __user_grup (nipg, id_grup) values ('1007832253',5);
insert into __user_grup (nipg, id_grup) values ('0089691353',5);
insert into __user_grup (nipg, id_grup) values ('1583650935',5);
insert into __user_grup (nipg, id_grup) values ('0089661409',5);
insert into __user_grup (nipg, id_grup) values ('0099731779',5);
insert into __user_grup (nipg, id_grup) values ('0004771922',5);
insert into __user_grup (nipg, id_grup) values ('1092671474',5);
insert into __user_grup (nipg, id_grup) values ('1583640946',5);
insert into __user_grup (nipg, id_grup) values ('1092651470',5);
insert into __user_grup (nipg, id_grup) values ('1095711584',5);
insert into __user_grup (nipg, id_grup) values ('0088611235',5);
insert into __user_grup (nipg, id_grup) values ('1087651104',5);
insert into __user_grup (nipg, id_grup) values ('0005802126',5);
insert into __user_grup (nipg, id_grup) values ('0092691451',5);
insert into __user_grup (nipg, id_grup) values ('0003741878',5);
insert into __user_grup (nipg, id_grup) values ('1096721607',5);
insert into __user_grup (nipg, id_grup) values ('1088621177',5);
insert into __user_grup (nipg, id_grup) values ('0004811947',5);
insert into __user_grup (nipg, id_grup) values ('1092671471',5);
insert into __user_grup (nipg, id_grup) values ('1087631099',5);
insert into __user_grup (nipg, id_grup) values ('0089691410',5);
insert into __user_grup (nipg, id_grup) values ('1587591129',5);
insert into __user_grup (nipg, id_grup) values ('1007832221',5);
insert into __user_grup (nipg, id_grup) values ('0089631405',5);
insert into __user_grup (nipg, id_grup) values ('1088631178',5);
insert into __user_grup (nipg, id_grup) values ('1583600929',5);
insert into __user_grup (nipg, id_grup) values ('0004771921',5);
insert into __user_grup (nipg, id_grup) values ('1588651279',5);
insert into __user_grup (nipg, id_grup) values ('0005812084',5);
insert into __user_grup (nipg, id_grup) values ('1092681476',5);
insert into __user_grup (nipg, id_grup) values ('0007842323',5);
insert into __user_grup (nipg, id_grup) values ('0088631150',5);
insert into __user_grup (nipg, id_grup) values ('1583560923',5);


/*data user grup management */
insert into __user_grup (nipg,id_grup) values('0089621328',8);
insert into __user_grup (nipg,id_grup) values('0088611235',8);
insert into __user_grup (nipg,id_grup) values('0087641112',8);
insert into __user_grup (nipg,id_grup) values('0097681695',8);
insert into __user_grup (nipg,id_grup) values('0096691635',8);
insert into __user_grup (nipg,id_grup) values('0088611237',8);
insert into __user_grup (nipg,id_grup) values('0088611140',8);
/*
 * Update table T_RCA_DETAIL modified field DESCRIPTION, ACTION, and NOTE
 */
alter table T_RCA_DETAIL
alter column DESCRIPTION varchar(1024) not null;

alter table T_RCA_DETAIL
alter column ACTIONS varchar(1024);

alter table T_RCA_DETAIL
alter column NOTE varchar(1024);

/*
 * Update table R_K3PL add field REPO_PATH
 */
alter table R_K3PL
add REPO_PATH varchar(512) not null default '/repository';


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


insert into __MENU values ('02.11'	,'Project'		,'ref_project'		,'1',2,'02','');
insert into __MENU values ('02.12'	,'Kontraktor'	,'ref_kontraktor'	,'1',2,'02','');
insert into __MENU values ('02.13'	,'CSM'			,'ref_csm'			,'1',2,'02','');
insert into __MENU values ('02.14'	,'Referensi Item PSSR'		,'ref_item_pssr'		,'1',2,'02','');
insert into __MENU values ('02.15'	,'Referensi Jabatan PSSR'		,'ref_jab_pssr'		,'1',2,'02','');
insert into __MENU values ('02.16'	,'Referensi PHA'		,'ref_pha'		,'1',2,'02','');
insert into __MENU values ('02.17'	,'Komponen Lingkungan'		,'ref_komponen_lingkungan'		,'1',2,'02','');

insert into __MENU values ('23'		,'CSM' 			,'csm'	,'0',1,'00','module');
insert into __MENU values ('23.01'	,'Penilaian'	,'csm_project'	,'0',2,'23','');
insert into __MENU values ('23.02'	,'Evaluasi'		,'csm_evaluasi'	,'0',2,'23','');

insert into __MENU values ('24'		,'PSSR'			,'pssr'			,'0',1,'00','module');
insert into __MENU values ('24.01'	,'Entry PSSR'	,'pssr_entry'	,'0',2,'24','');
insert into __MENU values ('24.02'	,'Laporan PSSR' ,'pssr_laporan'	,'0',2,'24','report');

insert into __MENU values ('25'		,'PHA'			,'pha'			,'0',1,'00','module');
insert into __MENU values ('25.01'	,'Entry PHA'	,'pha_input'	,'0',2,'25','');
insert into __MENU values ('25.02'	,'Laporan PHA'	,'pha_laporan'	,'0',2,'25','report');

insert into __MENU values ('26'		,'Repository'	,'repo'			,'0',1,'00','module');
insert into __MENU values ('26.01'	,'Browse'		,'repo_browse'	,'0',2,'26','');

insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.11',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.12',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.13',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.14',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.15',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.16',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'02.17',4);

insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'23'		,4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'23.01'	,4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'23.02'	,4);

insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'24',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'24.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'24.02',4);

insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'25',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'25.01',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'25.02',4);

insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'26',4);
insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'26.01',4);

update __MENU set MENU_NAME = 'Pengelolaan Lingkungan Tahunan', MENU_FOLDER = 'lnk_tahunan' where MENU_ID = '09.01';
update __MENU set MENU_NAME = 'Pengelolaan Lingkungan Bulanan', MENU_FOLDER = 'lnk_bulanan',ICON = '' where MENU_ID = '09.02';

update __MENU set MENU_NAME = 'RCA' where MENU_ID = '03';

insert into T_REPO values (0	,0	,'/'			,'1'	,1	,0	,770	,'1'	,getdate());

insert into R_KONTRAKTOR_TIPE values ('Firma');
insert into R_KONTRAKTOR_TIPE values ('CV');
insert into R_KONTRAKTOR_TIPE values ('PT');

insert into R_KONTRAKTOR_JAB values ('Direktur');
insert into R_KONTRAKTOR_JAB values ('Wakil Direktur');

insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Rencana Kerja', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Keanggotaan', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Hazard Process', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Hazard Pressure', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Field Tour', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Chemical Hazard', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Worst Scenario', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Consequences Analysis', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('What-If', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Facility Siting', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Human Factor', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('Other Recommendation', '1');
insert into R_WORK_STEPS (NAMA_WORK_STEPS, ID_USER) values ('References', '1');

insert into R_CSM_PERF_EVAL_SI values (1, 'Di bawah Standar - <= 55');
insert into R_CSM_PERF_EVAL_SI values (2, 'Cukup Memenuhi Standar - 55 s/d <= 75');
insert into R_CSM_PERF_EVAL_SI values (3, 'Memenuhi Standar - > 75');

insert into R_CSM_PERF_EVAL values (0.15, 'Kerapihan Peralatan dan Fasilitas Umum Proyek');
insert into R_CSM_PERF_EVAL values (0.15, 'Kelengkapan Alat Pelindung Diri (APD)');
insert into R_CSM_PERF_EVAL values (0.10, 'Safety Induction/Training/Safety talks/Tool Box meetings compliance');
insert into R_CSM_PERF_EVAL values (0.15, 'Metode Kerja yang Memperhatikan Prinsip-Prinsip Keselamatan dan Efektifitas Penggunaan Peralatan Kerja');
insert into R_CSM_PERF_EVAL values (0.05, 'Efektifitas team K3PL');
insert into R_CSM_PERF_EVAL values (0.15, 'Komitmen dan Kemampuan Tim Proyek Atas Pelaksanaan K3PL di Lapangan');
insert into R_CSM_PERF_EVAL values (0.05,
	'Perencanaan / Tindakan Pencegahan terhadap temuan audit K3PL mingguan <br/><br/>'
	+'1. Jumlah Insiden <br/>'
	+'2. Recordable Insiden Frequency Rate <br/>'
	+'3. LTI Frequency Rate');
insert into R_CSM_PERF_EVAL values (0.10,
	'Perencanaan / Tindakan Pencegahan terhadap temuan severity 4 & 5 <br/><br/>'
	+'1. Severity 4 & 5 Violation <br/>'
	+'2. Average Severity of Violation <br/>'
	+'3. RCA Done');
insert into R_CSM_PERF_EVAL values (0.05, 'Inisiatif Baru terhadap Sistem Internal & Proses Safety');
insert into R_CSM_PERF_EVAL values (0.05, 'Kebutuhan kesehatan pekerja: Toilet, Air Minum dll');

insert into R_CSM_FAKTOR_PENILAIAN values (1, 'Faktor Utama', 0.8);
insert into R_CSM_FAKTOR_PENILAIAN values (2, 'Faktor Penambah/Pelengkap', 0.2);

insert into R_CSM_PENILAIAN values (1	,'Pernyataan kebijakan dalam K3 dan kesesuaian'		,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Prosedur tanggap gawat, kesesuai implementasi'	,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Manual K3 dan hasil implementasi lapangan'		,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Prosedur pelaporan kecelakaan'					,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Program orientasi setiap pegawai baru'			,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Program rutin rapak K3'							,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Program pelatihan K3'								,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Program inspeksi K3, audit K3 dan temuan'			,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Kelengkapan alat pelindung diri'					,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (1	,'Manajemen peralatan dan perlengkapan'				,0	,3	,7	,10);

insert into R_CSM_PENILAIAN values (2	,'Bantuan tenaga professional K3'						,0	,5	,11	,15);
insert into R_CSM_PENILAIAN values (2	,'Faktor kesehatan dalam pelaksanaan aktivitas pekerja'	,0	,6	,14	,20);
insert into R_CSM_PENILAIAN values (2	,'Lingkungan'											,0	,6	,14	,20);
insert into R_CSM_PENILAIAN values (2	,'Statistik dan data pengelolaan'						,0	,3	,7	,10);
insert into R_CSM_PENILAIAN values (2	,'Investigasi kecelakaan'								,0	,5	,11	,15);
insert into R_CSM_PENILAIAN values (2	,'Sub kontraktor'										,0	,6	,14	,20);

insert into R_JABATAN_PSSR (NAMA_JABATAN_PSSR, ID_USER) values ('Ketua', '1');
insert into R_JABATAN_PSSR (NAMA_JABATAN_PSSR, ID_USER) values ('Sekretaris', '1');
insert into R_JABATAN_PSSR (NAMA_JABATAN_PSSR, ID_USER) values ('Anggota', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('ORGANISASI DAN PERSONIL','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (1, 'Struktur Organisasi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Apakah jumlah personil mencukupi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Apakah pihak terkait sudah terlibat dan bertanggung  jawab sesuai fungsinya', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Apakah sudah ada pembagian tugas di dalam tim dan di pahami', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Apakah sudah tersedia daftar nomer telepon yang dapat di hubungi', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (1, 'Personil Pendukung', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah Petugas Pemadam Kebakaran', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah Tenaga Medis', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Apakah melibatkan petugas keamanan, bila iya sebutkan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah kontraktor yang dilibatkan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Apakah disaksikan oleh perwakilan dari Migas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Apakah ada PMC', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('FISIK DAN PERALATAN','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (2, 'FISIK', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Bak Valve, Apakah kondisi semua bak valve baik, dapat diakses dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Test Box, apakah kondisinya baik dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Marker Post, apakah ada dan kondisinya baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Jembatan, apakah ada dan kondisinya baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Patok Gas, apakah ada dan kondisinya baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Venting Valve, apakah sudah diinstal sesuai dengan kebutuhan untuk gas in dan apakah kondisinya baik', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (2, 'PERALATAN', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Multi Gas Detector', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Genset', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Lampu Penerangan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Pompa Air', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Tool Set Non Spark', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Spool set untuk venting', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Exhaust Fan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Tangga', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Alat Komunikasi (Radio)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Apakah tersedia dan berfungsi Pressure Gauge', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('FIRE DAN SAFETY','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (3, 'FIRE', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah gas inlet berdekatan dengan sumber api', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah gas outlet berdekatan dengan sumber api', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah ada pengaman/isolasi dari sumber api', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Sudahkan disediakan Alat Pemadam APAR', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Sudahkan disediakan Alat Pemadam Mobil Pemadam', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Sudahkan disediakan Alat Pemadam Hydrant', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Sudahkan dilakukan koordinasi dengan otoritas pemadam kebakaran setempat Fungsi Fire Safety Pelanggan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Sudahkan dilakukan koordinasi dengan otoritas pemadam kebakaran setempat Dinas Pemadam Kebakaran', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (3, 'SAFETY', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'APD Personil', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Sudahkah disediakan rambu-rambu pengaman Barikade', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Sudahkah disediakan rambu-rambu pengaman Traffic Cone', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Sudahkah disediakan rambu-rambu pengaman Traffic Lamp', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Sudahkah disediakan rambu-rambu pengaman Marker Line', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Sudahkah disediakan rambu-rambu pengaman Rambu Gas In', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('SYSTEM','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Sudahkan dilakukan koordinasi dengan GMC', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (7, 4, 'Sebelum Gas In / Hottaping', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (7, 4, 'Proses Gas In / Hottaping', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (7, 4, 'Sesudah Gas In / Hottaping', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah tersedia Dokumen Teknis', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'As Built Drawing / Gambar Kerja', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'SAT Report ( Site Acceptance Test)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Pengujian Proteksi Katodik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Berita Acara Hydrotest', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'NDT Report', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Holiday Test Report', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Berita Acara N2 Purging', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'MOC', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'PHA', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Wall Thickness Test', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'MIGAS Approval', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'MR/S Acceptance Test Report (baru/lama)', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Sudahkan disiapkan Prosedur Gas In / Hottaping', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (9, 4, 'Sudahkan disiapkan Prosedur Gas In / Hottaping', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Sudahkan tersedia ERP (Emergency Respons Plan)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (10, 4, 'Sudahkan tersedia ERP (Emergency Respons Plan)', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Sudahkah dibuat JSA ( Job Safety Analisys )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (11, 4, 'Sudahkah dibuat JSA ( Job Safety Analisys )', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah sudah dibuatkan Izin Kerja', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Panas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Dingin', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Memasuki Ruang Terbatas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Galian', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'SIMI ( Surat Izin Masuk Instalasi )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (13, 4, 'SIMI ( Surat Izin Masuk Instalasi )', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('ADDITIONAL CHECKLIST (diperiksa ketersediaannya dan kondisinya)','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'PROSES', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'Design Basis', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'P & ID', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'MOC', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'PHA ( Process Hazard Analysis )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'ESD Function ( Emergency Shut Down )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'Venting sistem', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'MECHANICAL', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Bolt and Nut', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Tagging', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'LOTO', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Piping Support', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Plat form', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Ladder', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Painting piping', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'ELECTRICAL', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Cable Tray', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Junction Box', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Grounding', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Wiring Diagram', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Wiring system ( Instrumentation and Electrical )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Cable Gland', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Lighting', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Lightning Protection', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'CIVIL', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Pondasi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Bak Valve', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Road ( Escape Path )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Gate / Door', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Muster Point', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Lighting', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Kios / Rumah MRS', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Bangunan', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('INSTALASI PELANGGAN','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah Pelanggan mempunyai PSSR', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (18, 6, 'Apakah Pelanggan mempunyai PSSR', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Sudahkan disediakan Prosedur Gas In', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (19, 6, 'Sudahkan disediakan Prosedur Gas In', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Sudahkan dibuat JSA ( Job Safety Analysis )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (20, 6, 'Sudahkan dibuat JSA ( Job Safety Analysis )', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah Tersedia Dokumen Teknis', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'Berita Acara Pemeriksaan Material', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'Laporan Harian, Mingguan, Bulanan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'NDT Report', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'Berita Acara Pengujian Ball Valve', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'Berita Acara Pengetesan Pipa Instalasi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'Berita Acara Flushing', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'Berita Acara Pengisian Nitrogen', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'As Built Drawing', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah sudah tersedia peralatan Gas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Peralatan dual Fuel System', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Peralatan Single Fuel System', '1');

insert into R_JABATAN_PHA (NAMA_JABATAN_PHA, ID_USER) values ('Ketua', '1');
insert into R_JABATAN_PHA (NAMA_JABATAN_PHA, ID_USER) values ('Sekretaris', '1');
insert into R_JABATAN_PHA (NAMA_JABATAN_PHA, ID_USER) values ('Anggota', '1');

insert into R_HAZARD_PROCESS (NAMA_HAZARD_PROCESS, ID_USER) values ('Explosion', '1');
insert into R_HAZARD_PROCESS (NAMA_HAZARD_PROCESS, ID_USER) values ('Fire', '1');

insert into R_HAZARD_PRESSURE (NAMA_HAZARD_PRESSURE, ID_USER) values ('Compressible Fluid', '1');

insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Air', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Natural Gas', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Grease', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Water', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Carbon Steel', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Tetra Hydro Tiophane (THT)', '1');

insert into R_MATERIAL_INTERACTION (NAMA_MATERIAL_INTERACTION, ID_USER) values ('Air', '1');
insert into R_MATERIAL_INTERACTION (NAMA_MATERIAL_INTERACTION, ID_USER) values ('Natural Gas', '1');
insert into R_MATERIAL_INTERACTION (NAMA_MATERIAL_INTERACTION, ID_USER) values ('Grease', '1');
insert into R_MATERIAL_INTERACTION (NAMA_MATERIAL_INTERACTION, ID_USER) values ('Water', '1');
insert into R_MATERIAL_INTERACTION (NAMA_MATERIAL_INTERACTION, ID_USER) values ('Carbon Steel', '1');
insert into R_MATERIAL_INTERACTION (NAMA_MATERIAL_INTERACTION, ID_USER) values ('Tetra Hydro Tiophane (THT)', '1');

insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('MSDS', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Flammable', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Toxicity', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Reactive', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Skin or Eye Irritant', '1');

insert into R_KATEGORI_ITEM_CA (NAMA_KATEGORI_ITEM_CA, ID_USER) values ('SITE DATA', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (1, 'Location', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (1, 'Building Air Exchanges Per Hour', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (1, 'Time', '1');
insert into R_KATEGORI_ITEM_CA (NAMA_KATEGORI_ITEM_CA, ID_USER) values ('CHEMICAL DATA', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (2, 'Chemical Name', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (2, 'Molecular Weight', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (2, 'TEEL-1', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (2, 'LEL', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (2, 'Ambient Boiling Point', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (2, 'Vapor Pressure at Ambient Temperature', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (2, 'Ambient Saturation Concentration', '1');
insert into R_KATEGORI_ITEM_CA (NAMA_KATEGORI_ITEM_CA, ID_USER) values ('ATMOSPHERIC DATA (MANUAL INPUT OF DATA)', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (3, 'Wind', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (3, 'Ground Roughness', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (3, 'Cloud Cover', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (3, 'Air Temperature', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (3, 'Stability Class', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (3, 'No Inversion Height', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (3, 'Relative Humidity', '1');
insert into R_KATEGORI_ITEM_CA (NAMA_KATEGORI_ITEM_CA, ID_USER) values ('SOURCE STRENGTH', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Flammable gas is burning as it escapes from pipe', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Pipe Diameter', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Pipe Length', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Unbroken end of the pipe is connected to an infinite source', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Pipe Roughness', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Hole Area', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Pipe Press', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Pipe Temperature', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Max Flame Length', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Burn Duration', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Max Burn Rate', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (4, 'Total Amount Burned', '1');
insert into R_KATEGORI_ITEM_CA (NAMA_KATEGORI_ITEM_CA, ID_USER) values ('THREAT ZONE', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (5, 'Threat Modeled', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (5, 'Red', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (5, 'Orange', '1');
insert into R_ITEM_CA (ID_KATEGORI_ITEM_CA, NAMA_ITEM_CA, ID_USER) values (5, 'Yellow', '1');

insert into R_RISK_FREQUENCY (DESCRIPTION, FREQUENCY, FREQUENCY_CATEGORY, ID_USER) values ('Very Likely to Occur', '1 to 10-1', 'F-1', '1');
insert into R_RISK_FREQUENCY (DESCRIPTION, FREQUENCY, FREQUENCY_CATEGORY, ID_USER) values ('May occur once in the lifetime of process', '10-1 to 10-2', 'F-2', '1');
insert into R_RISK_FREQUENCY (DESCRIPTION, FREQUENCY, FREQUENCY_CATEGORY, ID_USER) values ('Unlikely to occur once in the lifetime of process', '10-2 to 10-3', 'F-3', '1');
insert into R_RISK_FREQUENCY (DESCRIPTION, FREQUENCY, FREQUENCY_CATEGORY, ID_USER) values ('Very Unlikely, not realistacally expected to occur', '10-3 to 10-5', 'F-4', '1');

insert into R_RISK_CONSEQUENCE (CONSEQUENCE_CATEGORY, C1, C2, C3, C4, NOTE, ID_USER) values ('Safety', 'No Injury or healtheffects', 'Minor injury or reversible health effects', 'Injury or moderate health effects', 'Death or irreversiblehealth effects', '', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE_CATEGORY, C1, C2, C3, C4, NOTE, ID_USER) values ('Environmental', 'tolerance noise, under  55 dB (<55 dB)', 'Unsual Noise, between 56-70 dB', 'Significant Noise ( between 71-85 dB )', 'Seriuos Noise effect ( > 85 dB )', 'KEPMEN KLH 48/96', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE_CATEGORY, C1, C2, C3, C4, NOTE, ID_USER) values ('Liability & Property Damage', '< 100 jt', '100 jt - 5M', '5 - 50M', '50M', '', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE_CATEGORY, C1, C2, C3, C4, NOTE, ID_USER) values ('Company Image', 'Minor Publicity, Local TV/Press', 'Significant Local Pubicity, Interviews', 'Considerable Local Publicity, Some National Publicity', 'Headline Locally, Nationally & Internationally', '', '1');

insert into R_RISK_DEFINITION (RISK_SCORE, DESCRIPTION, NOTE, ACTION_REQUIRED, PHA_RECOMMENDATION, ID_USER) values ('I', 'Intoreable', 'Develop recommendations to reduce risk to category III', 'Should be mitigated with engineering and/or administrative controls to a risk ranking of III or less within a specified time period, such as six months', 'Yes', '1');
insert into R_RISK_DEFINITION (RISK_SCORE, DESCRIPTION, NOTE, ACTION_REQUIRED, PHA_RECOMMENDATION, ID_USER) values ('II', 'Undesirable', 'Develop recommendations to reduce risk to category III', 'Should be mitigated with engineering and/or administrative controls to a risk ranking of III or less within a specified time period, such as 12 months', 'Yes', '1');
insert into R_RISK_DEFINITION (RISK_SCORE, DESCRIPTION, NOTE, ACTION_REQUIRED, PHA_RECOMMENDATION, ID_USER) values ('III', 'Tolerable with Controls', 'Team may make recommendations to reduce risk', 'Should verify that procedures and controls are in place, establish emphasis that they are maintained', 'Case-by-case evaluation. Evaluateadequacy of existing controls', '1');
insert into R_RISK_DEFINITION (RISK_SCORE, DESCRIPTION, NOTE, ACTION_REQUIRED, PHA_RECOMMENDATION, ID_USER) values ('IV', 'Tolerable as is', 'Opportunity for improvement', 'No mitigation required', 'No. Consider an improvementopportunity (outside the PHA), ifappropriate', '1');

insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (0, 0, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (0, 1, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (0, 2, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (0, 3, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (0, 4, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (1, 0, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (1, 1, 4, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (1, 2, 2, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (1, 3, 1, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (1, 4, 1, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (2, 0, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (2, 1, 4, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (2, 2, 3, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (2, 3, 2, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (2, 4, 1, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (3, 0, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (3, 1, 4, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (3, 2, 4, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (3, 3, 3, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (3, 4, 2, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (4, 0, 0, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (4, 1, 4, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (4, 2, 4, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (4, 3, 4, '1');
insert into R_RISK_RANKING_MATRIX (F, C, RR, ID_USER) values (4, 4, 3, '1');

insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kualitas udara', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kebisingan', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kualitas air tanah', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kualitas air permukaan', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Bahan kimia berbahaya dan beracun', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Limbah bahan berbahaya dan beracun (B3)', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kondisi hidrologi', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kondisi tanah', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Estetika ruang dan lahan', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kondisi flora', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Kondisi fauna', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Sosial ekonomi budaya', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Perkembangan lingkungan sekitar', '1');
insert into R_KOMPONEN_LINGKUNGAN (NAMA_KOMPONEN_LINGKUNGAN, ID_USER) values ('Lainnya', '1');

insert into R_REPORT values ('Penilaian CSM', 1, 'doc', 'reports/CSM_01.jasper', 'id_project;id_kontraktor', 'ID_PROJECT;ID_KONTRAKTOR');
insert into R_REPORT values ('Evaluasi CSM', 1, 'doc', 'reports/CSM_02.jasper', 'id_project', 'ID_PROJECT');
insert into R_REPORT values ('Check List PSSR', 2, 'xls', 'reports/CheckListPSSRFinal_4PPT.jasper', 'id_pssr', 'ID_PSSR');
insert into R_REPORT values ('Charter PHA', 3, 'doc', 'reports/01_CharterPHA.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('Hazard Identification', 3, 'doc', 'reports/02_HazardIdentification.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('Consequences Analysis', 3, 'doc', 'reports/03_ConsequenceAnalysis.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('PHR What-If Risk Matriks', 3, 'xls', 'reports/04_PHR_What-If_Risk-Matrix.jasper;reports/04_PHR_What-If_Risk-Matrix02.jasper;reports/04_PHR_What-If_Risk-Matrix03.jasper;reports/04_PHR_What-If_Risk-Matrix04.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('Facility Sitting', 3, 'doc', 'reports/05_FacilitySitting.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('Human Factor', 3, 'doc', 'reports/06_HumanFactor.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('STORM', 3, 'xls', 'reports/07_STORM.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('List References Used', 3, 'doc', 'reports/09_ListReferencesUsed.jasper', 'id_pha', 'ID_PHA');
insert into R_REPORT values ('Pengelolaan Lingkungan Tahunan', 4, 'xls', 'reports/PelaporanLingkungan.jasper', 'id_lt', 'ID_LINGKUNGAN_TAHUNAN');
insert into R_REPORT values ('Pengelolaan Lingkungan Bulanan', 4, 'xls', 'reports/07_LapLingkunganBulanan.jasper', 'tahun;bulan', 'TAHUN;BULAN');

insert into R_CSM_PERF_EVAL_PS values (0.0, 1.0, 'Black list selama 2 tahun');
insert into R_CSM_PERF_EVAL_PS values (1.1, 3.0, 'Surat teguran dan Pembinaan Safety');
insert into R_CSM_PERF_EVAL_PS values (3.1, 4.0, 'Certificate of Compliance');
insert into R_CSM_PERF_EVAL_PS values (4.1, 5.0, 'Penghargaan');

/*
 * R_CSM_PROJECT_LEVEL: Tingkat penilaian proyek.
 */
if exists (
	select	1
	from	sysobjects
	where	id = object_id('R_CSM_PROJECT_WORK_LEVEL')
	and		type = 'U'
)
   drop table R_CSM_PROJECT_WORK_LEVEL
go

create table R_CSM_PROJECT_WORK_LEVEL (
	ID			int 			identity primary key
,	NILAI		float			not null default 0
,	KETERANGAN	varchar(256)	not null default ''
);

/*
 * Update T_CSM_PROYEK tambah kolom WORK_LEVEL
 */
alter table T_CSM_PROYEK add WORK_LEVEL int
	foreign key
	references R_CSM_PROJECT_WORK_LEVEL (ID);

/*
 * Update T_CSM_PROYEK tambah kolom PENGHARGAAN_SANKSI
 */
alter table T_CSM_PROYEK add PENGHARGAAN_SANKSI int default 1
	foreign key
	references R_CSM_PERF_EVAL_PS (ID);

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

insert into R_CSM_PROJECT_WORK_LEVEL values (30, 'Low');
insert into R_CSM_PROJECT_WORK_LEVEL values (50, 'Medium');
insert into R_CSM_PROJECT_WORK_LEVEL values (80, 'High');

insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('MSDS', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Flammable', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Toxicity', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Reactive', '1');
insert into R_PROPERTIES (NAMA_PROPERTIES, ID_USER) values ('Skin or Eye Irritant', '1');

insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Air', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Natural Gas', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Grease', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Water', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Carbon Steel', '1');
insert into R_MATERIAL (NAMA_MATERIAL, ID_USER) values ('Tetra Hydro Tiophane (THT)', '1');

insert into R_REPORT values ('Charter PSSR', 2, 'doc', 'reports/CharterPSSR.jasper', 'id_pssr', 'ID_PSSR');

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

insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F1', 'Very Likely to Occur', '1 to 10-1', '1');
insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F2', 'May occur once in the lifetime of process', '10-1 to 10-2', '1');
insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F3', 'Unlikely to occur once in the lifetime of process', '10-2 to 10-3', '1');
insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F4', 'Very Unlikely, not realistacally expected to occur', '10-3 to 10-5', '1');

insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C1', '1');
insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C2', '1');
insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C3', '1');
insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C4', '1');

insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Safety', '', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Environmental', 'KEPMEN KLH 48/96', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Liability & Property Damage', '', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Company Image', '', '1');

insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C1', 'No Injury or healtheffects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C2', 'Minor injury or reversible health effects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C3', 'Injury or moderate health effects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C4', 'Death or irreversiblehealth effects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C1', 'tolerance noise, under  55 dB (<55 dB)', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C2', 'Unsual Noise, between 56-70 dB', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C3', 'Significant Noise ( between 71-85 dB )', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C4', 'Seriuos Noise effect ( > 85 dB )', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C1', '< 100 jt', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C2', '100 jt - 5M', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C3', '5 - 50M', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C4', '50M', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C1', 'Minor Publicity, Local TV/Press', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C2', 'Significant Local Pubicity, Interviews', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C3', 'Considerable Local Publicity, Some National Publicity', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C4', 'Headline Locally, Nationally & Internationally', '1');

insert into T_REPO values (1	,0	,'Kontraktor'	,'1'	,1	,0	,770	,'1'	,getdate());
insert into T_REPO values (2	,0	,'Dokumen Klaim','1'	,1	,0	,770	,'1'	,getdate());

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

if exists (
	select	1
	from	sysobjects
	where	id = object_id('R_CSM_PENILAIAN_DETAIL')
	and		type = 'U'
)
	drop table R_CSM_PENILAIAN_DETAIL
go

if exists (
	select	1
	from	sysobjects
	where	id = object_id('T_CSM_PROYEK_KONT_NILAI')
	and		type = 'U'
)
	drop table T_CSM_PROYEK_KONT_NILAI
go

if exists (
	select	1
	from	sysobjects
	where	id = object_id('R_CSM_PENILAIAN')
	and		type = 'U'
)
	drop table R_CSM_PENILAIAN
go

/*
 * R_CSM_PENILAIAN: recreate table, drop column nilai_a, nilai_b, nilai_c,
 * and nilai_d.
 */
create table R_CSM_PENILAIAN (
	ID			int				identity primary key
,	ID_FAKTOR	int				not null foreign key references R_CSM_FAKTOR_PENILAIAN (ID)
,	KETERANGAN	varchar(1024)	not null
)
go

create table T_CSM_PROYEK_KONT_NILAI (
   ID_PROJECT           bigint               not null,
   ID_KONTRAKTOR        bigint               not null,
   ID_PENILAIAN         int                  not null,
   NILAI                int                  not null default 0,
   KETERANGAN           varchar(512)         not null default '',
   constraint PK_T_CSM_PROYEK_KONT_NILAI primary key (ID_PROJECT, ID_KONTRAKTOR, ID_PENILAIAN)
)
go

/*
 * R_CSM_PENILAIAN_DETAIL: new table, nilai dan keterangan dari penilaian.
 */
create table R_CSM_PENILAIAN_DETAIL (
	ID				int				identity primary key
,	ID_PENILAIAN	int				not null foreign key references R_CSM_PENILAIAN (ID)
,	NILAI			int				not null
,	KETERANGAN		varchar(1024)	not null
)
go

insert into R_CSM_PENILAIAN values (1	,'Pernyataan kebijakan dalam K3 dan kesesuaian');
insert into R_CSM_PENILAIAN values (1	,'Prosedur tanggap gawat, kesesuai implementasi');
insert into R_CSM_PENILAIAN values (1	,'Manual K3 dan hasil implementasi lapangan');
insert into R_CSM_PENILAIAN values (1	,'Prosedur pelaporan kecelakaan');
insert into R_CSM_PENILAIAN values (1	,'Program orientasi setiap pegawai baru');
insert into R_CSM_PENILAIAN values (1	,'Program rutin rapak K3');
insert into R_CSM_PENILAIAN values (1	,'Program pelatihan K3');
insert into R_CSM_PENILAIAN values (1	,'Program inspeksi K3, audit K3 dan temuan');
insert into R_CSM_PENILAIAN values (1	,'Kelengkapan alat pelindung diri');
insert into R_CSM_PENILAIAN values (1	,'Manajemen peralatan dan perlengkapan');

insert into R_CSM_PENILAIAN values (2	,'Bantuan tenaga professional K3');
insert into R_CSM_PENILAIAN values (2	,'Faktor kesehatan dalam pelaksanaan aktivitas pekerja');
insert into R_CSM_PENILAIAN values (2	,'Lingkungan');
insert into R_CSM_PENILAIAN values (2	,'Statistik dan data pengelolaan');
insert into R_CSM_PENILAIAN values (2	,'Investigasi kecelakaan');
insert into R_CSM_PENILAIAN values (2	,'Sub kontraktor');

/* faktor utama */
insert into R_CSM_PENILAIAN_DETAIL values (1	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (1	,3	,'Ada pernyataan kebijakan tertulis');
insert into R_CSM_PENILAIAN_DETAIL values (1	,7	,'Kebijakan menetapkan kewajiban dan tanggung jawab kontraktor akan K3');
insert into R_CSM_PENILAIAN_DETAIL values (1	,10	,'Kebijakan menetapkan kewajiban dan tanggung jawab kontraktor disebarluaskan kepada pekerja');

insert into R_CSM_PENILAIAN_DETAIL values (2	,0	,'Tidak ada prosedur kerja tertulis untuk pekerjaan tertentu.');
insert into R_CSM_PENILAIAN_DETAIL values (2	,3	,'Prosedur kerja tertulis belum dibakukan');
insert into R_CSM_PENILAIAN_DETAIL values (2	,7	,'Prosedur kerja tertulis telah dibakukan, tapi belum ada pengawasan');
insert into R_CSM_PENILAIAN_DETAIL values (2	,10	,'Dilakukan pengawasan dilapangan untuk memastikan prosedur kerja dan tanggap darurat dipatuhi');

insert into R_CSM_PENILAIAN_DETAIL values (3	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (3	,3	,'Manual K3 ada tapi belum diimplementasikan');
insert into R_CSM_PENILAIAN_DETAIL values (3	,7	,'Manual K3 ada dan diimplementasikan, tapi belum ada pengawasan');
insert into R_CSM_PENILAIAN_DETAIL values (3	,10	,'Manual K3 ada dan diimplementasikan dengan pengawasan');

insert into R_CSM_PENILAIAN_DETAIL values (4	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (4	,3	,'Ada prosedur komunikasi pelaporan kecelakaan');
insert into R_CSM_PENILAIAN_DETAIL values (4	,7	,'Prosedur kerja tertulis mewajibkan melaporkan kecelakaan kepada pemberi kerja');
insert into R_CSM_PENILAIAN_DETAIL values (4	,10	,'Prosedur mengisyaratkan pelaporan dan penyelidikan kecelakaan didokumentasikan');

insert into R_CSM_PENILAIAN_DETAIL values (5	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (5	,3	,'Orientasi masih dalam bentuk instruksi lisan');
insert into R_CSM_PENILAIAN_DETAIL values (5	,7	,'Orientasi tertulis dengan bimbingan, tapi belum ada observas dan evaluasi');
insert into R_CSM_PENILAIAN_DETAIL values (5	,10	,'Orientasi terencana dan terobservasi');

insert into R_CSM_PENILAIAN_DETAIL values (6	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (6	,3	,'Ada tapi belum lengkap');
insert into R_CSM_PENILAIAN_DETAIL values (6	,7	,'Ada tetapi tidak rutin');
insert into R_CSM_PENILAIAN_DETAIL values (6	,10	,'Ada dan rutin dilakukan');

insert into R_CSM_PENILAIAN_DETAIL values (7	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (7	,3	,'Hanya ada pelatihan dasar');
insert into R_CSM_PENILAIAN_DETAIL values (7	,7	,'Ada pelatihan K3 dan pekerja khusus bersertifikat');
insert into R_CSM_PENILAIAN_DETAIL values (7	,10	,'Semau pelatihan dan penyelenggaraan K3 telah dijadualkan');

insert into R_CSM_PENILAIAN_DETAIL values (8	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (8	,3	,'Inspeksi K3 dilakukan tidak terarah');
insert into R_CSM_PENILAIAN_DETAIL values (8	,7	,'Ada program inspeksi K3 dan tindak lanjut perbaikan');
insert into R_CSM_PENILAIAN_DETAIL values (8	,10	,'Rekomendasi dan tindak lanjut inspeksi K3 dilaporkan dan didokumentasikan');

insert into R_CSM_PENILAIAN_DETAIL values (9	,0	,'Belum semua pekerja diberi APD yang tepat');
insert into R_CSM_PENILAIAN_DETAIL values (9	,3	,'Semua pekerja diberi APD yang tepat, tapi belum ada pengawasan');
insert into R_CSM_PENILAIAN_DETAIL values (9	,7	,'Pengawasan dilakukan untuk memastikan APD dipakai dan dipelihara');
insert into R_CSM_PENILAIAN_DETAIL values (9	,10	,'Dilakukan pelatihan penggunaan dan pemeliharaan APD');

insert into R_CSM_PENILAIAN_DETAIL values (10	,0	,'Tidak ada program pemeriksaan peralatan dan material');
insert into R_CSM_PENILAIAN_DETAIL values (10	,3	,'Inspeksi dilakukan tidak terarah');
insert into R_CSM_PENILAIAN_DETAIL values (10	,7	,'Ada program pemeriksaan tetapi belum konsisten');
insert into R_CSM_PENILAIAN_DETAIL values (10	,10	,'Program dilakukan sesuai rencana dan didokumentasikan');

/* faktor tambahan */
insert into R_CSM_PENILAIAN_DETAIL values (11	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (11	,5	,'Ada tetapi tidak terjadwal');
insert into R_CSM_PENILAIAN_DETAIL values (11	,11	,'Ada dan terjadwal');
insert into R_CSM_PENILAIAN_DETAIL values (11	,15	,'Tenaga profesional K3 selalu berada dilokasi');

insert into R_CSM_PENILAIAN_DETAIL values (12	,0	,'Tidak ada peraturan pemeliharaan kebersihan di tempat kerja');
insert into R_CSM_PENILAIAN_DETAIL values (12	,6	,'Ada peraturan tentang kebersihan dan kesehatan');
insert into R_CSM_PENILAIAN_DETAIL values (12	,14	,'Peraturan disosialisaikan kepada pekerja');
insert into R_CSM_PENILAIAN_DETAIL values (12	,20	,'Program diawasi oleh mandor dan safety leader');

insert into R_CSM_PENILAIAN_DETAIL values (13	,0	,'Belum ada kebijakan pengelolaan lingkungan');
insert into R_CSM_PENILAIAN_DETAIL values (13	,6	,'Ada kebijakan tetapi belum punya prosedur pengelolaan lingkungan');
insert into R_CSM_PENILAIAN_DETAIL values (13	,14	,'Ada prosedur tapi belum ada pengawasan');
insert into R_CSM_PENILAIAN_DETAIL values (13	,20	,'Program lingkungan sesuai prosedur dan diawasi');

insert into R_CSM_PENILAIAN_DETAIL values (14	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (14	,3	,'Ada tetapi tidak lengkap');
insert into R_CSM_PENILAIAN_DETAIL values (14	,7	,'Ada dan sesuai prosedur');
insert into R_CSM_PENILAIAN_DETAIL values (14	,10	,'Ada, sesuai prosedur dan didokumentasikan');

insert into R_CSM_PENILAIAN_DETAIL values (15	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (15	,5	,'Ada prosedur investigasi');
insert into R_CSM_PENILAIAN_DETAIL values (15	,11	,'Prosedur investigasi mewajibkan pelaporan kepada pemberi kerja');
insert into R_CSM_PENILAIAN_DETAIL values (15	,15	,'Prosedur investigasi dilaporkan dan didokumentasikan');

insert into R_CSM_PENILAIAN_DETAIL values (16	,0	,'Tidak ada');
insert into R_CSM_PENILAIAN_DETAIL values (16	,6	,'Ada');
insert into R_CSM_PENILAIAN_DETAIL values (16	,14	,'Ada dan diawasi');
insert into R_CSM_PENILAIAN_DETAIL values (16	,20	,'Ada, dilaporkan, dan diawasi');

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

insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, ID_USER) values (1, 'Satuan Pengawasan Intern', '1')
go

insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 2, 'Auditor Utama Bidang K3PL Dan Teknik', '1')
go

insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 9, 'Auditor Bidang K3PL', '1')
go

insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 9, 23, 1, 'Audit K3PL', '1')
go


if exists (select 1
            from  sysobjects
           where  id = object_id('V_SEVERITY')
            and   type = 'V')
   drop view V_SEVERITY
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
    ,   a.penanggung_jawab_divprosbu
    ,   a.penanggung_jawab_direktorat
	,	replace(convert(varchar, b.completion_date_target, 111), '/', '-') as completion_date_target 
	,	b.status 
	,	b.note 
from	t_rca			as a 
	,	t_rca_detail	as b 
where	a.id_rca    = b.id_rca
go


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

alter table T_UNJUK_KERJA add ID_DEPARTEMEN int
go

alter table T_UNJUK_KERJA add ID_DIVPROSBU int
go

alter table T_UNJUK_KERJA add ID_DIREKTORAT int
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_UNJUK_KERJA') and o.name = 'FK_R_DEPARTEMEN_T_UNJUK_KERJA')
alter table T_UNJUK_KERJA
   drop constraint FK_R_DEPARTEMEN_T_UNJUK_KERJA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('T_UNJUK_KERJA')
            and   name  = 'T_UNJUK_KERJA_FK_R_DEPARTEMEN'
            and   indid > 0
            and   indid < 255)
   drop index T_UNJUK_KERJA.T_UNJUK_KERJA_FK_R_DEPARTEMEN
go

create index T_UNJUK_KERJA_FK_R_DEPARTEMEN on T_UNJUK_KERJA (
ID_DEPARTEMEN ASC,
ID_DIVPROSBU ASC,
ID_DIREKTORAT ASC
)
go

alter table T_UNJUK_KERJA
   add constraint FK_R_DEPARTEMEN_T_UNJUK_KERJA foreign key (ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DEPARTEMEN (ID_DEPARTEMEN, ID_DIVPROSBU, ID_DIREKTORAT)
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
   ID_KEL_JABATAN_KOMITE_SUB_KOMITE smallint identity,
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

insert into R_KEL_JABATAN_KOMITE_SUB_KOMITE (ID_KEL_JABATAN_CSC, ID_DIVPROSBU, ID_DIREKTORAT, NAMA_KEL_JABATAN_KOMITE_SUB_KOMITE, ID_USER)
select	5
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

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE') and o.name = 'FK_T_PEGAWAI_KOMITE_T_RAPAT_ABSENSI_KOMITE')
alter table T_RAPAT_ABSENSI_KOMITE_SUB_KOMITE
   drop constraint FK_T_PEGAWAI_KOMITE_T_RAPAT_ABSENSI_KOMITE
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
           where  id = object_id('T_LINGKUNGAN_BULANAN_TEMP')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN_TEMP
go

create table T_LINGKUNGAN_BULANAN_TEMP (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   PEKERJAAN            varchar(512)         not null default '',
   LOKASI_PROYEK        varchar(512)         not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_BULANAN_TEMP primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

alter table T_LINGKUNGAN_BULANAN_TEMP
   add constraint FK_R_DIVPROSBU_T_LINGKUNGAN_BULANAN_TEMP foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

insert into T_LINGKUNGAN_BULANAN_TEMP
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	PEKERJAAN
	,	LOKASI_PROYEK
	,	ID_USER
	,	TANGGAL_AKSES
from	T_LINGKUNGAN_BULANAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_LINGKUNGAN_BULANAN_DETAIL') and o.name = 'FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL')
alter table T_LINGKUNGAN_BULANAN_DETAIL
   drop constraint FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN
go

create table T_LINGKUNGAN_BULANAN (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   PEKERJAAN            varchar(512)         not null default '',
   LOKASI_PROYEK        varchar(512)         not null default '',
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_LINGKUNGAN_BULANAN primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

alter table T_LINGKUNGAN_BULANAN
   add constraint FK_R_DIVPROSBU_T_LINGKUNGAN_BULANAN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN_DETAIL_TEMP')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN_DETAIL_TEMP
go

create table T_LINGKUNGAN_BULANAN_DETAIL_TEMP (
   ID_LINGKUNGAN_BULANAN_DETAIL bigint       not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
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
   constraint PK_T_LINGKUNGAN_BULANAN_DETAIL_TEMP primary key (ID_LINGKUNGAN_BULANAN_DETAIL)
)
go

insert into T_LINGKUNGAN_BULANAN_DETAIL_TEMP
select	ID_LINGKUNGAN_BULANAN_DETAIL
	,	3
	,	1
	,	TAHUN
	,	BULAN
	,	TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	TANGGAL_AWAL
	,	TANGGAL_AKHIR
	,	URAIAN_KEGIATAN
	,	KETERANGAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_LINGKUNGAN_BULANAN_DETAIL

if exists (select 1
            from  sysobjects
           where  id = object_id('T_LINGKUNGAN_BULANAN_DETAIL')
            and   type = 'U')
   drop table T_LINGKUNGAN_BULANAN_DETAIL
go

create table T_LINGKUNGAN_BULANAN_DETAIL (
   ID_LINGKUNGAN_BULANAN_DETAIL bigint       not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
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

create index T_LINGKUNGAN_BULANAN_DETAIL_FK on T_LINGKUNGAN_BULANAN_DETAIL (
ID_DIREKTORAT ASC,
ID_DIVPROSBU ASC,
TAHUN ASC,
BULAN ASC
)
go

alter table T_LINGKUNGAN_BULANAN_DETAIL
   add constraint FK_T_LINGKUNGAN_BULANAN_T_LINGKUNGAN_BULANAN_DETAIL foreign key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
      references T_LINGKUNGAN_BULANAN (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
go

insert into T_LINGKUNGAN_BULANAN
select	*
from	T_LINGKUNGAN_BULANAN_TEMP
go

insert into T_LINGKUNGAN_BULANAN_DETAIL
select	*
from	T_LINGKUNGAN_BULANAN_DETAIL_TEMP
go

drop table T_LINGKUNGAN_BULANAN_TEMP
go

drop table T_LINGKUNGAN_BULANAN_DETAIL_TEMP
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi RCA Pegawai'
,	'xls'
,	'reports/rca_lap_partisipasi_pegawai.jasper'
,	'id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN_TEMP')
            and   type = 'U')
   drop table T_KEGIATAN_TEMP
go

create table T_KEGIATAN_TEMP (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN_TEMP primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

insert	into T_KEGIATAN_TEMP
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_KEGIATAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_AREA_PERHATIAN_DETAIL') and o.name = 'FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL')
alter table T_AREA_PERHATIAN_DETAIL
   drop constraint FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('T_KEGIATAN_DETAIL') and o.name = 'FK_T_KEGIATAN_T_KEGIATAN_DETAIL')
alter table T_KEGIATAN_DETAIL
   drop constraint FK_T_KEGIATAN_T_KEGIATAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN')
            and   type = 'U')
   drop table T_KEGIATAN
go

create table T_KEGIATAN (
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN primary key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
)
go

alter table T_KEGIATAN
   add constraint FK_R_DIVPROSBU_T_KEGIATAN foreign key (ID_DIVPROSBU, ID_DIREKTORAT)
      references R_DIVPROSBU (ID_DIVPROSBU, ID_DIREKTORAT)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_AREA_PERHATIAN_DETAIL_TEMP')
            and   type = 'U')
   drop table T_AREA_PERHATIAN_DETAIL_TEMP
go

create table T_AREA_PERHATIAN_DETAIL_TEMP (
   ID_AREA_PERHATIAN_DETAIL bigint           not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_AREA_PERHATIAN smallint           not null,
   NAMA_AREA_PERHATIAN  varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_AREA_PERHATIAN_DETAIL_TEMP primary key (ID_AREA_PERHATIAN_DETAIL)
)
go

insert	into T_AREA_PERHATIAN_DETAIL_TEMP
select	ID_AREA_PERHATIAN_DETAIL
	,	3
	,	1
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_AREA_PERHATIAN
	,	NAMA_AREA_PERHATIAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_AREA_PERHATIAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_AREA_PERHATIAN_DETAIL')
            and   type = 'U')
   drop table T_AREA_PERHATIAN_DETAIL
go

create table T_AREA_PERHATIAN_DETAIL (
   ID_AREA_PERHATIAN_DETAIL bigint           identity,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_AREA_PERHATIAN smallint           not null,
   NAMA_AREA_PERHATIAN  varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_AREA_PERHATIAN_DETAIL primary key (ID_AREA_PERHATIAN_DETAIL)
)
go

create index T_AREA_PERHATIAN_DETAIL_FK_T_KEGIATAN on T_AREA_PERHATIAN_DETAIL (
ID_DIREKTORAT ASC,
ID_DIVPROSBU ASC,
TAHUN ASC,
BULAN ASC
)
go

create index T_AREA_PERHATIAN_DETAIL_FK_R_WILAYAH on T_AREA_PERHATIAN_DETAIL (
ID_WILAYAH ASC
)
go

create index T_AREA_PERHATIAN_DETAIL_FK_R_TIPE_AREA_PERHATIAN on T_AREA_PERHATIAN_DETAIL (
ID_TIPE_AREA_PERHATIAN ASC
)
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
   add constraint FK_T_KEGIATAN_T_AREA_PERHATIAN_DETAIL foreign key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
      references T_KEGIATAN (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN_DETAIL_TEMP')
            and   type = 'U')
   drop table T_KEGIATAN_DETAIL_TEMP
go

create table T_KEGIATAN_DETAIL_TEMP (
   ID_KEGIATAN_DETAIL   bigint               not null,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
   TAHUN                int                  not null,
   BULAN                smallint             not null,
   ID_WILAYAH           int                  not null,
   ID_TIPE_KEGIATAN     smallint             not null,
   NAMA_KEGIATAN        varchar(200)         not null,
   ID_USER              varchar(20)          not null,
   TANGGAL_AKSES        datetime             not null default getdate(),
   constraint PK_T_KEGIATAN_DETAIL_TEMP primary key (ID_KEGIATAN_DETAIL)
)
go

insert	into T_KEGIATAN_DETAIL_TEMP
select	ID_KEGIATAN_DETAIL
	,	3
	,	1
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_KEGIATAN_DETAIL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('T_KEGIATAN_DETAIL')
            and   type = 'U')
   drop table T_KEGIATAN_DETAIL
go

create table T_KEGIATAN_DETAIL (
   ID_KEGIATAN_DETAIL   bigint               identity,
   ID_DIREKTORAT        int                  not null,
   ID_DIVPROSBU         int                  not null,
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

create index T_KEGIATAN_DETAIL_FK_T_KEGIATAN on T_KEGIATAN_DETAIL (
ID_DIREKTORAT ASC,
ID_DIVPROSBU ASC,
TAHUN ASC,
BULAN ASC
)
go

create index T_KEGIATAN_DETAIL_FK_R_WILAYAH on T_KEGIATAN_DETAIL (
ID_WILAYAH ASC
)
go

create index T_KEGIATAN_DETAIL_FK_R_TIPE_KEGIATAN on T_KEGIATAN_DETAIL (
ID_TIPE_KEGIATAN ASC
)
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
   add constraint FK_T_KEGIATAN_T_KEGIATAN_DETAIL foreign key (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
      references T_KEGIATAN (ID_DIREKTORAT, ID_DIVPROSBU, TAHUN, BULAN)
go

insert	into T_KEGIATAN
select	*
from	T_KEGIATAN_TEMP
go

insert	into T_AREA_PERHATIAN_DETAIL(
		ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_AREA_PERHATIAN
	,	NAMA_AREA_PERHATIAN
	,	ID_USER
	,	TANGGAL_AKSES
)
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_AREA_PERHATIAN
	,	NAMA_AREA_PERHATIAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_AREA_PERHATIAN_DETAIL_TEMP
go

insert	into T_KEGIATAN_DETAIL(
		ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	ID_USER
	,	TANGGAL_AKSES
)
select	ID_DIREKTORAT
	,	ID_DIVPROSBU
	,	TAHUN
	,	BULAN
	,	ID_WILAYAH
	,	ID_TIPE_KEGIATAN
	,	NAMA_KEGIATAN
	,	ID_USER
	,	TANGGAL_AKSES
from	T_KEGIATAN_DETAIL_TEMP
go

drop table T_KEGIATAN_TEMP
go

drop table T_AREA_PERHATIAN_DETAIL_TEMP
go

drop table T_KEGIATAN_DETAIL_TEMP
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Rangkuman Kegiatan K3PL'
,	'doc'
,	'reports/lap_rangkuman_keg.jasper'
,	'month;year;id_divprosbu'
,	'MONTH;YEAR;ID_DIVPROSBU'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Safety Metrics'
,	'xls'
,	'reports/lap_safety_metrics.jasper'
,	'prev_year;prev_month;year;month;id_dir;id_div'
,	'PREV_YEAR;PREV_MONTH;YEAR;MONTH;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan JSA'
,	'doc'
,	'reports/lap_jsa.jasper'
,	'id_jsa'
,	'ID_JSA'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi RCA Organisasi'
,	'xls'
,	'reports/rca_lap_partisipasi_organisasi.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

DECLARE @v sql_variant 
SET @v = N'1 = CSM; 2 = PSSR; 3 = PHA; 4 = LINGKUNGAN; 5 = LAINNYA'
EXECUTE sp_updateextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'R_REPORT', N'COLUMN', N'KLASIFIKASI_REPORT'
GO

update	R_REPORT
set		KLASIFIKASI_REPORT	= 5
where	ID_REPORT			in (15,16,17,18,19)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Grafik Partisipasi RCA'
,	5
,	'doc'
,	'reports/grafik_performance_rca_partisipasi.jasper'
,	'year_1;year_2;year_3;month_1;month_2;month_3;id_dir;id_div'
,	'YEAR_1;YEAR_2;YEAR_3;MONTH_1;MONTH_2;MONTH_3;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Grafik Severity 4-5 RCA'
,	5
,	'doc'
,	'reports/grafik_performance_rca_severity.jasper'
,	'year_1;year_2;year_3;month_1;month_2;month_3;id_dir;id_div'
,	'YEAR_1;YEAR_2;YEAR_3;MONTH_1;MONTH_2;MONTH_3;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Grafik Tindak Lanjut Temuan 4-5 RCA'
,	5
,	'doc'
,	'reports/grafik_performance_rca_tl_temuan.jasper'
,	'year_1;year_2;year_3;month_1;month_2;month_3;id_dir;id_div'
,	'YEAR_1;YEAR_2;YEAR_3;MONTH_1;MONTH_2;MONTH_3;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Matriks Pelatihan'
,	5
,	'xls'
,	'reports/lap_pelatihan_matriks.jasper'
,	'id_dir;id_div'
,	'ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Pelatihan'
,	5
,	'xls'
,	'reports/lap_pelatihan.jasper'
,	'id_dir;id_div;id_dep;id_din;id_sek;nipg;start_date;end_date'
,	'ID_DIR;ID_DIV;ID_DEP;ID_DIN;ID_SEK;NIPG;START_DATE;END_DATE'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Severity'
,	5
,	'xls'
,	'reports/rca_lap_severity.jasper'
,	'is_in_org;year;month;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area'
,	'IS_IN_ORG;YEAR;MONTH;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performance RCA'
,	5
,	'xls'
,	'reports/rca_lap_performance.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi STOP Pegawai'
,	5
,	'xls'
,	'reports/obs_lap_partisipasi_pegawai.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Partisipasi STOP Organisasi'
,	5
,	'xls'
,	'reports/obs_lap_partisipasi_organisasi.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP per Kategori'
,	5
,	'xls'
,	'reports/obs_lap_performansi_kategori.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP Safe Unsafe Index'
,	5
,	'xls'
,	'reports/obs_lap_performansi_index.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP Safe Unsafe Observasi per Hour'
,	5
,	'xls'
,	'reports/obs_lap_performansi_hour.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Performansi STOP'
,	5
,	'xls'
,	'reports/obs_lap_performansi_stop.jasper'
,	'is_in_org;id_dir;id_div;id_dep;id_dinas;id_seksi;id_wilayah;id_area;year;month'
,	'IS_IN_ORG;ID_DIR;ID_DIV;ID_DEP;ID_DINAS;ID_SEKSI;ID_WILAYAH;ID_AREA;YEAR;MONTH'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Insiden'
,	5
,	'doc'
,	'reports/lap_invest_insiden.jasper'
,	'id_insiden'
,	'ID_INSIDEN'
)
go

insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 9, 'Auditor Bidang Teknik', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 9, 24, 1, 'Audit Perencanaan dan Pembangunan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 9, 24, 1, 'Audit Teknologi Informasi dan Komunikasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 2, 'Auditor Utama Bidang Operasi dan Pemasaran', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 10, 'Auditor Bidang Operasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 10, 25, 1, 'Audit Operasi dan Pasokan Gas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 10, 25, 1, 'Audit Pemeliharaan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 10, 'Auditor Bidang Pemasaran', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 10, 26, 1, 'Audit Penjualan dan Layanan Pelanggan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 2, 'Auditor Utama Bidang Keuangan dan Administrasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 11, 'Auditor Bidang Keuangan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 11, 27, 1, 'Audit Keuangan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 11, 27, 1, 'Audit Akuntansi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 11, 'Auditor Bidang Administrasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 11, 28, 1, 'Audit Logistik', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 11, 28, 1, 'Audit SDM dan Organisasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 11, 28, 1, 'Audit Umum', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 2, 'Departemen Sekretariat SPI', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 12, 'Dinas Sekretariat SPI', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 12, 29, 1, 'Seksi Penyusunan dan Pelaporan Kegiatan Audit', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 12, 29, 1, 'Seksi Pengembangan Sistem Infomasi Audit dan Pengendalian Status Tindak Lanjut', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (1, 'Biro Hukum Korporat', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 3, 'Departemen Kelompok Hukum Korporasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 3, 13, 'Dinas Kelompok Hukum Korporasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 3, 13, 30, 1, 'Seksi Kelompok Hukum Korporasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 3, 'Departemen Hukum Kontrak', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 3, 14, 'Dinas Hukum Kontrak', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 3, 14, 31, 1, 'Seksi Kontrak Komersial', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 3, 14, 31, 1, 'Seksi Kontrak Kerjasama', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 3, 'Departemen Kelompok Bantuan Hukum dan Litigasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 3, 15, 'Dinas Kelompok Bantuan Hukum dan Litigasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 3, 15, 32, 1, 'Seksi Kelompok Bantuan Hukum dan Litigasi', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (1, 'Sekretaris Perusahaan', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 4, 'Departemen Komunikasi Korporat', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 4, 16, 'Kelompok Komunikasi Korporat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 4, 16, 33, 1, 'Seksi Kelompok Komunikasi Korporat', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 4, 'Departemen Hubungan Kelembagaan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 4, 17, 'Kelompok Hubungan Kelembagaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 4, 17, 34, 1, 'Seksi Kelompok Hubungan Kelembagaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 4, 'Departemen Hubungan Investor', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 4, 18, 'Dinas Komunikasi Investor', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 4, 18, 35, 1, 'Seksi Komunikasi Investor', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 4, 18, 'Dinas Analisa dan Pelaporan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 4, 18, 36, 1, 'Seksi Analisa dan Pelaporan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 4, 'Departemen Sekretariat Direksi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 4, 19, 'Dinas Sekretariat Direksi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 4, 19, 37, 1, 'Seksi Rumah Tangga Direksi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 4, 19, 37, 1, 'Seksi Manajemen Perkantoran Direksi', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (2, 'Divisi Riset dan Pengembangan Teknologi', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 5, 'Departemen Teknologi Eksisting', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 5, 20, 'Dinas Teknologi Eksisting', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 5, 20, 38, 1, 'Seksi Teknologi Eksisting', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 5, 'Departemen Teknologi Baru', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 5, 21, 'Dinas Teknologi Baru', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 5, 21, 39, 1, 'Seksi Teknologi Baru', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (2, 'Divisi Enjiniring', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 6, 'Departemen Perencanaan dan Pengendalian Enjiniring', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 6, 22, 'Dinas Perencanaan dan Pengendalian Enjiniring', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 22, 40, 1, 'Seksi Perencanaan Umum dan Tekno Ekonomi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 22, 40, 1, 'Seksi Pengendalian Perencanaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 6, 'Departemen Rekayasa Teknik', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 6, 23, 'Dinas Rekayasa Teknik', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Process Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Onshore Pipeline Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Offshore Pipeline Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Mechanical Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Instrument Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Electrical Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Telecommunication Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Civil Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Corrosion Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Cost Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Piping Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Survey Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi HSE Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi QA/QC Engineer', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 6, 23, 41, 1, 'Seksi Contract Engineer', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (2, 'Divisi Pembangunan', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 7, 'Departemen Pengendalian Konstruksi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 7, 24, 'Dinas Pengendalian Konstruksi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 7, 24, 42, 1, 'Seksi Pengendalian Pelaksanaan Pembangunan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 7, 24, 42, 1, 'Seksi Pengendalian Administrasi Pembangunan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 7, 'Departemen Pengendalian Mutu Pembangunan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 7, 25, 'Dinas Pengendalian Mutu Pembangunan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 7, 25, 43, 1, 'Seksi Kelompok Pengendalian Mutu Pembangunan', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (2, 'Divisi Teknologi Informasi dan Komunikasi', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 8, 'Departemen Teknologi Informasi dan Komunikasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 8, 26, 'Dinas Pengembangan Sistem Informasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 26, 44, 1, 'Seksi Analisa Sistem', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 26, 44, 1, 'Seksi Analisa Pemrograman', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 26, 44, 1, 'Seksi Pengendalian Sistem dan Aplikasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 8, 'Departemen Jaringan Komputer dan Komunikasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 8, 27, 'Dinas Jaringan Komputer dan Komunikasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 27, 45, 1, 'Seksi Jaringan Komputer dan Komunikasi Data', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 27, 45, 1, 'Seksi Keamanan Jaringan dan Sistem', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 27, 45, 1, 'Seksi Dukungan Layanan Teknis', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (2, 8, 'Departemen Sistem Pusat Data', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (2, 8, 28, 'Dinas Sistem Pusat Data', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 28, 46, 1, 'Seksi Pengembangan Pusat Data', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 28, 46, 1, 'Seksi Operasional Pusat Data', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (2, 8, 28, 46, 1, 'Seksi Pengembangan dan Pengawasan Telemetering', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'Divisi Pemasaran', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 9, 'Departemen Pengembangan Pasar', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 9, 29, 'Dinas Pengembangan Pasar', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 9, 29, 47, 1, 'Seksi Strategi dan Analisa Pemasaran', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 9, 29, 47, 1, 'Seksi Perencanaan Pasar', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 9, 'Departemen Sales & Marketing Assurance', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 9, 30, 'Dinas Sales dan Marketing Assurance', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 9, 30, 48, 1, 'Seksi Technical Service', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 9, 30, 48, 1, 'Seksi Customer Service', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 9, 30, 48, 1, 'Seksi Pengelolaan Data Pelanggan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 9, 30, 48, 1, 'Seksi Pengendalian Pendapatan', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'Divisi Penjualan Korporat', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 10, 'Departemen Penjualan Korporat Pelanggan Power', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 10, 31, 'Dinas Penjualan Korporat Pelanggan Power', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 10, 31, 49, 1, 'Seksi Penjualan Korporat Pelanggan Power PLN', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 10, 31, 49, 1, 'Seksi Penjualan Korporat Pelanggan Power Non PLN', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 10, 'Departemen Penjualan Korporat Pelanggan Non Power', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 10, 32, 'Dinas Penjualan Korporat Pelanggan Non Power', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 10, 32, 50, 1, 'Seksi Penjualan Korporat Pelanggan Non Power I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 10, 32, 50, 1, 'Seksi Penjualan Korporat Pelanggan Non Power II', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'Divisi Pasokan Gas', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 11, 'Departemen Kelompok Pasokan Gas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 11, 33, 'Dinas Kelompok Pasokan Gas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 11, 33, 51, 1, 'Seksi Kelompok Pasokan Gas', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'Divisi Operasi', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 12, 'Departemen Operasi dan Integritas Jaringan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 12, 34, 'Dinas Operasi dan Integritas Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 12, 34, 52, 1, 'Seksi Operasi Jaringan dan Fasilitas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 12, 34, 52, 1, 'Seksi Manajemen Integritas Jaringan Transmisi dan Distribusi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 12, 'Departemen Manajemen Aset Operasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 12, 35, 'Dinas Manajemen Aset Operasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 12, 35, 53, 1, 'Seksi Sistem Manajemen Gas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 12, 35, 53, 1, 'Seksi Manajemen Jaringan dan Fasilitas', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'Divisi K3PL', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 13, 'Departemen Keselamatan dan Kesehatan Kerja', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 13, 36, 'Dinas Keselamatan dan Kesehatan Kerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 13, 36, 54, 1, 'Seksi Kelompok Keselamatan dan Kesehatan Kerja', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 13, 'Departemen Pengelolaan Lingkungan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 13, 37, 'Dinas Pengelolaan Lingkungan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 13, 37, 55, 1, 'Seksi Kelompok Pengelolaan Lingkungan', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (4, 'Divisi Anggaran', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 14, 'Departemen Penyusunan dan Penetapan Anggaran', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 14, 38, 'Dinas Penyusunan dan Penetapan Anggaran', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 14, 38, 56, 1, 'Seksi Penyusunan dan Penetapan Anggaran Operasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 14, 38, 56, 1, 'Seksi Penyusunan dan Penetapan Anggaran Investasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 14, 'Departemen Pengendalian dan Pelaporan Anggaran', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 14, 39, 'Dinas Pengendalian dan Pelaporan Anggaran', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 14, 39, 57, 1, 'Seksi Pengendalian dan Pelaporan Anggaran Operasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 14, 39, 57, 1, 'Seksi Pengendalian dan Pelaporan Anggaran Investasi', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (4, 'Divisi Perbendaharaan', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (4, 'Divisi Akuntansi', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (4, 'Divisi Keuangan Perusahaan', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (4, 'Divisi Tanggung Jawab Sosial dan Lingkungan', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (5, 'Divisi Organisasi dan Proses Bisnis', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (5, 'Divisi Sumber Daya Manusia', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (5, 'Divisi Logistik', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (5, 'Divisi Layanan Umum dan Pengamanan Perusahaan', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (5, 'Divisi Manajemen Aset', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (6, 'Divisi Perencanaan Strategis', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (6, 'Divisi Pengembangan Bisnis dan Pengendalian Portofolio', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (6, 'Divisi Transformasi dan Pengendalian Kerja', 1, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (6, 'Divisi Manajemen Risiko', 1, '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 15, 'Departemen Operasional Dana', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 15, 'Departemen Pendanaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 16, 'Departemen Sistem Akuntansi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 16, 'Departemen Kebijakan dan Prosedur Akuntansi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 16, 'Departemen Sistem Informasi Akuntansi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 16, 'Departemen Akuntansi Keuangan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 16, 'Departemen Perpajakan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 16, 'Departemen Manajemen Data', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 17, 'Departemen Strategi Keuangan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 17, 'Departemen Manajemen Keuangan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 18, 'Departemen Operasi Tanggung Jawab Sosial dan Lingkungan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (4, 18, 'Departemen Administrasi Tanggung Jawab Sosial dan Lingkungan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 19, 'Departemen Pengembangan Organisasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 19, 'Departemen Pengembangan Sistem Manajemen', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 19, 'Departemen Kelompok GCG dan Budaya Perusahaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 20, 'Departemen Pengembangan SDM', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 20, 'Departemen Pengembangan Kompetensi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 20, 'Departemen Pendidikan dan Pelatihan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 20, 'Departemen Remunerasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 21, 'Departemen Kelompok Pengadaan Barang dan Jasa', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 21, 'Departemen Pengendalian Pengadaan dan Persediaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 21, 'Departemen Sistem Kelogistikan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 22, 'Departemen Administrasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 22, 'Departemen Fasilitas dan Layanan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 22, 'Departemen Pengamanan Perusahaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 23, 'Departemen Perencanaan dan Penilaian Aset', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 23, 'Departemen Pengelolaan Aset', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (5, 23, 'Departemen Administrasi Aset', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 24, 'Departemen Perencanaan Korporat', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 24, 'Departemen Strategi Bisnis', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 25, 'Departemen Pengembangan Bisnis I', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 25, 'Departemen Pengembangan Bisnis II', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 25, 'Departemen Pengendalian Portofolio', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 26, 'Departemen Transformasi Bisnis', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 26, 'Departemen Pengendalian Kinerja', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 27, 'Departemen Pengelolaan Risiko I', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (6, 27, 'Departemen Pengelolaan Risiko II', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 15, 40, 'Dinas Operasional Dana', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 15, 41, 'Dinas Pendanaan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 16, 42, 'Dinas Sistem Akuntansi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 16, 43, 'Dinas Kebijakan dan Prosedur Akuntansi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 16, 44, 'Dinas Sistem Informasi Akuntansi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 16, 45, 'Dinas Akuntansi Keuangan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 16, 46, 'Dinas Perpajakan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 16, 47, 'Dinas Manajemen Data', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 17, 48, 'Dinas Strategi Keuangan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 17, 49, 'Dinas Manajemen Keuangan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 18, 50, 'Dinas Operasi Tanggung Jawab Sosial dan Lingkungan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (4, 18, 51, 'Dinas Administrasi Tanggung Jawab Sosial dan Lingkungan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 19, 52, 'Dinas Pengembangan Organisasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 19, 53, 'Dinas Pengembangan Sistem Manajemen', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 19, 54, 'Dinas Kelompok GCG dan Budaya Perusahaan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 20, 55, 'Dinas Pengembangan SDM', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 20, 56, 'Dinas Pengembangan Kompetensi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 20, 57, 'Dinas Pendidikan dan Pelatihan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 20, 58, 'Dinas Remunerasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 21, 59, 'Dinas Kelompok Pengadaan Barang dan Jasa', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 21, 60, 'Dinas Pengendalian Pengadaan dan Persediaan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 21, 61, 'Dinas Sistem Kelogistikan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 22, 62, 'Dinas Administrasi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 22, 63, 'Dinas Fasilitas dan Layanan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 22, 64, 'Dinas Pengamanan Perusahaan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 23, 65, 'Dinas Perencanaan dan Penilaian Aset', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 23, 66, 'Dinas Pengelolaan Aset', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (5, 23, 67, 'Dinas Administrasi Aset', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 24, 68, 'Dinas Perencanaan Korporat', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 24, 69, 'Dinas Strategi Bisnis', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 25, 70, 'Dinas Pengembangan Bisnis I', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 25, 71, 'Dinas Pengembangan Bisnis II', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 25, 72, 'Dinas Pengendalian Portofolio', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 26, 73, 'Dinas Transformasi Bisnis', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 26, 74, 'Dinas Pengendalian Kinerja', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 27, 75, 'Dinas Pengelolaan Risiko I', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (6, 27, 76, 'Dinas Pengelolaan Risiko II', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 15, 40, 58, 1, 'Seksi Operasional Dana Kantor Pusat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 15, 40, 58, 1, 'Seksi Operasional Dana Perusahaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 15, 41, 59, 1, 'Seksi Administrasi Pinjaman Perusahaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 15, 41, 59, 1, 'Seksi Pengendalian Pendanaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 42, 60, 1, 'Seksi Sistem Akuntansi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 43, 61, 1, 'Seksi Kebijakan dan Prosedur Akuntansi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 44, 62, 1, 'Seksi Sistem Informasi Akuntansi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 45, 63, 1, 'Seksi Akuntansi Kantor Pusat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 45, 63, 1, 'Seksi Pelaporan Keuangan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 46, 64, 1, 'Seksi Perencanaan Perpajakan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 46, 64, 1, 'Seksi Administrasi Perpajakan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 16, 47, 65, 1, 'Seksi Kelompok Manajemen Data', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 17, 48, 66, 1, 'Seksi Kelompok Strategi Keuangan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 17, 49, 67, 1, 'Seksi Pendanaan dan Asuransi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 17, 49, 67, 1, 'Seksi Hedging dan Investasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 18, 50, 68, 1, 'Seksi Operasi Program Kemitraan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 18, 50, 68, 1, 'Seksi Operasi Program Bina Lingkungan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 18, 51, 69, 1, 'Seksi Administrasi Program Kemitraan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (4, 18, 51, 69, 1, 'Seksi Administrasi Program Bina Lingkungan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 19, 52, 70, 1, 'Seksi Organisasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 19, 52, 70, 1, 'Seksi Tata Laksana Organisasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 19, 53, 71, 1, 'Seksi Pengembangan Sistem', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 19, 53, 71, 1, 'Seksi Pengendalian Sistem', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 19, 54, 72, 1, 'Seksi Kelompok GCG dan Budaya Perusahaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 55, 73, 1, 'Seksi Perencanaan dan Rekrutmen', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 55, 73, 1, 'Seksi Pengembangan SDM', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 55, 73, 1, 'Seksi Pembinaan SDM', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 56, 74, 1, 'Seksi Perencanaan Sistem Karir dan Kompetensi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 56, 74, 1, 'Seksi Pemetaan dan Perencanaan Pengembangan Kompetensi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 57, 75, 1, 'Seksi Perencanaan Diklat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 57, 75, 1, 'Seksi Penyelenggaraan Diklat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 57, 75, 1, 'Seksi Evaluasi Diklat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 58, 76, 1, 'Seksi Sistem Remunerasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 58, 76, 1, 'Seksi Administrasi Remunerasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 58, 76, 1, 'Seksi Hubungan Industrial', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 20, 58, 76, 1, 'Seksi Sistem Informasi SDM', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 21, 59, 77, 1, 'Seksi Kelompok Pengadaan Barang dan Jasa', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 21, 60, 78, 1, 'Seksi Pengendalian Pengadaan dan Persediaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 21, 60, 78, 1, 'Seksi Administrasi Kontrak', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 21, 61, 79, 1, 'Seksi Tata Laksana Material', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 21, 61, 79, 1, 'Seksi Sistem Pengadaan Barang dan Jasa', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 62, 80, 1, 'Seksi Administrasi Umum', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 62, 80, 1, 'Seksi Kesekretariatan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 62, 80, 1, 'Seksi Kelompok Pengadaan Operasional Kantor Pusat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 63, 81, 1, 'Seksi Perencanaan Gedung dan Fasilitas Kantor Pusat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 63, 81, 1, 'Seksi Pengelolaan Gedung dan Fasilitas Kantor Pusat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 63, 81, 1, 'Seksi Layanan Kantor Pusat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 64, 82, 1, 'Seksi Pembinaan dan Pengelolaan Pengamanan Perusahaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 22, 64, 82, 1, 'Seksi Pengamanan dan K3 Kantor Pusat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 23, 65, 83, 1, 'Seksi Perencanaan Aset', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 23, 65, 83, 1, 'Seksi Penilaian Aset', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 23, 66, 84, 1, 'Seksi Pemeliharaan dan Pengendalian Aset', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 23, 66, 84, 1, 'Seksi Pemanfaatan Aset', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 23, 67, 85, 1, 'Seksi Sertifikasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (5, 23, 67, 85, 1, 'Seksi Administrasi Aset', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 24, 68, 86, 1, 'Seksi Kelompok Perencanaan Korporat', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 24, 69, 87, 1, 'Seksi Kelompok Strategi Bisnis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 25, 70, 88, 1, 'Seksi Kelompok Pengembangan Bisnis I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 25, 71, 89, 1, 'Seksi Kelompok Pengembangan Bisnis II', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 25, 72, 90, 1, 'Seksi Kelompok Pengendalian Portofolio', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 26, 73, 91, 1, 'Seksi Kelompok Transformasi Bisnis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 26, 74, 92, 1, 'Seksi Kelompok Pengendalian Kinerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 27, 75, 93, 1, 'Seksi Kelompok Pengelolaan Risiko I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (6, 27, 76, 94, 1, 'Seksi Kelompok Pengelolaan Risiko II', '1')
go

insert into R_DIREKTORAT (NAMA_DIREKTORAT, ID_USER) values ('Tidak Diketahui', '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (7, 'Tidak Diketahui', 1, '1')
go
insert into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (7, 28, 'Tidak Diketahui', '1')
go
insert into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (7, 28, 77, 'Tidak Diketahui', '1')
go
insert into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (7, 28, 77, 95, 1, 'Tidak Diketahui', '1')
go

insert into R_PEGAWAI values ('0004701951',1,1,203,95,77,'Ridha Ababil','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087631077',1,1,203,95,77,'Supriyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095721585',1,1,203,95,77,'Janter Halasan S.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094701541',1,1,203,95,77,'Achmad Mulyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0008812378',1,1,203,95,77,'Irna Amalia Lubis','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842554',1,1,203,95,77,'Rauminar Estikasari ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012822647',1,1,203,95,77,'I Ketut Arta Gede Nesa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872653',1,1,203,95,77,'Norma Fransisca Yulianty','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097711693',1,1,203,95,77,'Tisan Sobichah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099751794',1,1,203,95,77,'Raden Mohamad Edwin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812132',1,1,203,95,77,'Appie Yudana Antono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802119',1,1,203,95,77,'Fathurahman P. NG. J.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822297',1,1,203,95,77,'Suryadi Wijaya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010832408',1,1,203,95,77,'Murdani Wijaya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862520',1,1,203,95,77,'Shabhi Mahmashani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842508',1,1,203,95,77,'Atika Indra Dhewanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882536',1,1,203,95,77,'Agung Harum Prasetyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092621440',1,1,203,95,77,'Wijayanti Ratna Lestari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094621517',1,1,203,95,77,'Sujatmiko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872687',1,1,203,95,77,'Hidayat Anshori','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003721875',1,1,203,95,77,'Marie Siti Mariana Massie','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004671950',1,1,203,95,77,'Desima E. Siahaan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792066',1,1,203,95,77,'Sulthani Adil Mangatur','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012852664',1,1,203,95,77,'Fitra Yuda','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012792655',1,1,203,95,77,'Hendri Susilo Pramono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0002711856',1,1,203,95,77,'Vietor Heglind Tobing','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1693701512',1,1,203,95,77,'Warkunah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802077',1,1,203,95,77,'Krisdyan Widagdo Adhi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086591027',1,1,203,95,77,'Hari Pratoyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089621332',1,1,203,95,77,'Djoko Saputro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086621055',1,1,203,95,77,'Erning Laksmi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088591209',1,1,203,95,77,'Thohir Nur Ilhami','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0084560972',1,1,203,95,77,'Erlangga','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611234',1,1,203,95,77,'Komarudin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088601218',1,1,203,95,77,'Mangatas Panjaitan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086581033',1,1,203,95,77,'Bambang Ismartono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088581200',1,1,203,95,77,'Timbul Pramono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0085580995',1,1,203,95,77,'Annas S. Wangsadipura','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086631057',1,1,203,95,77,'Liza Soenar Windarti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086581032',1,1,203,95,77,'Triyono Heriyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086581026',1,1,203,95,77,'Iwan Heryawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094651521',1,1,203,95,77,'Gamal Imam Santoso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012812646',1,1,203,95,77,'Katamsi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012842651',1,1,203,95,77,'Dikot Hasibuan Adika  Sampurna','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097711692',1,1,203,95,77,'Eri Surya Kelana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0098711734',1,1,203,95,77,'Diana Yulianty','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097751708',1,1,203,95,77,'Siti Yanti Mulyanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001751819',1,1,203,95,77,'Enro Situmorang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092601488',1,1,203,95,77,'Irzal Alizar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001751813',1,1,203,95,77,'Emung Indriastanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792061',1,1,203,95,77,'Prihardy Bakry','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001771836',1,1,203,95,77,'Erli Soemarliana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087662638',1,1,203,95,77,'Dian Savitri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781963',1,1,203,95,77,'Asri Wahyuningsih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822101',1,1,203,95,77,'Jovitha Salea Battu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822103',1,1,203,95,77,'Leli Mulyani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882539',1,1,203,95,77,'Putri Wahyu Andarini','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872454',1,1,203,95,77,'Ria Brahmanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872530',1,1,203,95,77,'Septi Mulyani       ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852420',1,1,203,95,77,'Miftakh Arkhan Zein Taptozani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012882697',1,1,203,95,77,'Adhitya Virtus','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792063',1,1,203,95,77,'Rinaldi Jan Darmawan P','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088621158',1,1,203,95,77,'Noor Diana Prasetyawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001731807',1,1,203,95,77,'Ariadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099751792',1,1,203,95,77,'Ihda Maftuhah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812139',1,1,203,95,77,'Ade Firman Hayatul Kalam','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007802277',1,1,203,95,77,'Hetty Kusuma Waty','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802122',1,1,203,95,77,'Erny Sugiarti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872529',1,1,203,95,77,'Leony Wesvalia      ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882534',1,1,203,95,77,'Risma Vanessa Prameswari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088641265',1,1,203,95,77,'Dedi Suryadinata','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012772643',1,1,203,95,77,'Hendra Frayudi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012862674',1,1,203,95,77,'Surya Dwi Kurniawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872685',1,1,203,95,77,'Arif Budhianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088601221',1,1,203,95,77,'Sulistyo Elly H.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731775',1,1,203,95,77,'Tatit Sri Jayendra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792059',1,1,203,95,77,'Suseno','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792069',1,1,203,95,77,'Mohammad Rasyid Ridha','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001751816',1,1,203,95,77,'Agung Prasetyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005772053',1,1,203,95,77,'Marlon Riolan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802081',1,1,203,95,77,'Andi Krishna Arinaldi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791965',1,1,203,95,77,'Raka Haryo Indro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862519',1,1,203,95,77,'Rangga Yadi Putra   ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792075',1,1,203,95,77,'Diki Hasanudin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012852660',1,1,203,95,77,'Baroqah Anton Sulaiman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012862672',1,1,203,95,77,'Dewi Wulandari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872678',1,1,203,95,77,'Hatgi Noer Ramandito','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872688',1,1,203,95,77,'Anas Asy Syifa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012882690',1,1,203,95,77,'Anindya Rizki Santika','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012882693',1,1,203,95,77,'Awang Bhaswara','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892700',1,1,203,95,77,'Satriya Galih Wismawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892710',1,1,203,95,77,'Arief Setiawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892714',1,1,203,95,77,'Ni Made Dwi Ryaumariastini','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007812287',1,1,203,95,77,'Kurnia Permasari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781962',1,1,203,95,77,'Adityo Triwinarko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792072',1,1,203,95,77,'Usep Indra Haruman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802082',1,1,203,95,77,'Iqbal Fuady','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095631569',1,1,203,95,77,'Dwisa Kartinia','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0098701731',1,1,203,95,77,'Nofrizal','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0008752376',1,1,203,95,77,'Muhammad Irwan Santoso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0008782377',1,1,203,95,77,'Joice Hotma Erlian Juliana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088581153',1,1,203,95,77,'Busrani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088651165',1,1,203,95,77,'Apriyadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822294',1,1,203,95,77,'Santi Hairunissa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872455',1,1,203,95,77,'Seto Agung Putranto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010802497',1,1,203,95,77,'Foury Krisyunanto   ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751681',1,1,203,95,77,'Moh. Khoirul Huda','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097721704',1,1,203,95,77,'Wibisono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011652627',1,1,203,95,77,'Rozani Ismail','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792074',1,1,203,95,77,'Sigit Waluyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004821979',1,1,203,95,77,'Syahril Malik','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004741917',1,1,203,95,77,'Yunan Fajar Ariyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094651545',1,1,203,95,77,'Mukimin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012842659',1,1,203,95,77,'Arif Perdananto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872679',1,1,203,95,77,'Rina Widarustanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006772176',1,1,203,95,77,'Ronald Andre P. Hutagalung','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088621243',1,1,203,95,77,'Wahyu Irianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0084630955',1,1,203,95,77,'Susy Hermawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088621239',1,1,203,95,77,'Iwan Hendarwan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094651519',1,1,203,95,77,'Pantas Lumban Tobing','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099721772',1,1,203,95,77,'Tina Lestari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099771801',1,1,203,95,77,'Arie Kusmayadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096681631',1,1,203,95,77,'Efi Muzdalifah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1096671597',1,1,203,95,77,'Rudi Kuswandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092641497',1,1,203,95,77,'Vincensia Sri Lestari N.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0085641003',1,1,203,95,77,'Rini Restumi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089651342',1,1,203,95,77,'Sofie Sofiana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089601360',1,1,203,95,77,'Supandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097731712',1,1,203,95,77,'Bode Verry F.Sitorus','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1096741610',1,1,203,95,77,'Kristomi Mardiman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095731588',1,1,203,95,77,'Machmudin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095721587',1,1,203,95,77,'Wawan Hermawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832157',1,1,203,95,77,'Agung Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094651520',1,1,203,95,77,'Eggy Muharram','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842504',1,1,203,95,77,'Titis Wulandari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852511',1,1,203,95,77,'Rahadyan Kusumo Syailendra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088641164',1,1,203,95,77,'Rentalin Sihite','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087651108',1,1,203,95,77,'Cicih Warcih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092631427',1,1,203,95,77,'Ridwan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095671595',1,1,203,95,77,'Dedy Riadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095681596',1,1,203,95,77,'Sukardi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1584560958',1,1,203,95,77,'Oembeng','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096601661',1,1,203,95,77,'Suparno','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099582194',1,1,203,95,77,'Siyo Santoso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099592196',1,1,203,95,77,'Taufikurrahman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089651397',1,1,203,95,77,'Wira','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089651398',1,1,203,95,77,'Sanusi B','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096711667',1,1,203,95,77,'Idrul','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092601498',1,1,203,95,77,'Dedy Riansyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007722262',1,1,203,95,77,'Nixon Simanjuntak','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2589621363',1,1,203,95,77,'Abdulah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096711666',1,1,203,95,77,'Karya Rismaya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099672181',1,1,203,95,77,'Zainal Abidin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096581659',1,1,203,95,77,'Rachmat','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1008572343',1,1,203,95,77,'Sakuwan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1008562341',1,1,203,95,77,'Katiman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089561390',1,1,203,95,77,'Supardi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096661664',1,1,203,95,77,'Asep Suwarsa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096671665',1,1,203,95,77,'Sukemi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792068',1,1,203,95,77,'Eka Perkasa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004782009',1,1,203,95,77,'Andriansyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089631333',1,1,203,95,77,'Ismet Syariful Alamsyah Pane','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088601223',1,1,203,95,77,'Budiarto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094661526',1,1,203,95,77,'M. Hidayat Setiaputra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097721703',1,1,203,95,77,'Agus Kresnowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086611051',1,1,203,95,77,'Moch. Sugeng Riyadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089621339',1,1,203,95,77,'Rosmawati Naiborhu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631257',1,1,203,95,77,'Danu Kusumo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099761797',1,1,203,95,77,'Hendar Purnomo Susanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801944',1,1,203,95,77,'Weny Ayu Hapsari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099761803',1,1,203,95,77,'Zulfahmi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001751820',1,1,203,95,77,'Dyah Fitria Prabaningrum','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731780',1,1,203,95,77,'Dhian Widuri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005782057',1,1,203,95,77,'Cahyo Sudarto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005782112',1,1,203,95,77,'Mahfud Fauzi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001771838',1,1,203,95,77,'Adriyan Alexandra Gobel','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092651444',1,1,203,95,77,'Elizabeth Maria Narua','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007792274',1,1,203,95,77,'Yosa Arfika','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007792275',1,1,203,95,77,'Danang Eko Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832165',1,1,203,95,77,'Syah Abimoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010812405',1,1,203,95,77,'Ade Subhan          ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852515',1,1,203,95,77,'Dyah Nurhayati      ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852510',1,1,203,95,77,'Erlina Midah Naibaho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095641592',1,1,203,95,77,'Januarizal','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842319',1,1,203,95,77,'Siska Nurdiani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088581204',1,1,203,95,77,'Joki Eko Y. Hadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802076',1,1,203,95,77,'Muhammad Rais Efendi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611225',1,1,203,95,77,'Syafrudin Lubis','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001761834',1,1,203,95,77,'Krisdian Kusuma','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001761832',1,1,203,95,77,'Suryandari Wandewi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611157',1,1,203,95,77,'Suprijanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086581025',1,1,203,95,77,'Rosichin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094681535',1,1,203,95,77,'Hadiminola','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092681494',1,1,203,95,77,'Roevlyanto Roezien','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731781',1,1,203,95,77,'Ardi Viryawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781961',1,1,203,95,77,'Rachmadi Bagus Murdhono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089681348',1,1,203,95,77,'Hartati Sulistyowati ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097721705',1,1,203,95,77,'Retno Sri Setiyastiti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004761919',1,1,203,95,77,'Martas Bony Setyawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842320',1,1,203,95,77,'Jernih Deborah Sinaga','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012862671',1,1,203,95,77,'Mohammad Zanuddin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088601155',1,1,203,95,77,'Harimanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094691538',1,1,203,95,77,'Agus Arifin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088591137',1,1,203,95,77,'Sasongko Yulian P.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731778',1,1,203,95,77,'M. Alfiannor','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812085',1,1,203,95,77,'Bondan Christiandinata','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872684',1,1,203,95,77,'Silvi Oktavia Zennita','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862521',1,1,203,95,77,'Faris Arianto Aji   ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086601030',1,1,203,95,77,'Uji Subroto Santoso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097711700',1,1,203,95,77,'Yoga Trihono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822107',1,1,203,95,77,'Agung Rahmat Kurniansyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1096741612',1,1,203,95,77,'Muhamad Samhan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832305',1,1,203,95,77,'Jauhar Gama Kurniawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852421',1,1,203,95,77,'Furqanul Fikri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011902630',1,1,203,95,77,'Dea Amelia','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099741786',1,1,203,95,77,'Anak Agung Putu Bagus. P. T.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088591207',1,1,203,95,77,'Surjadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087611117',1,1,203,95,77,'Mira Adipurna Adin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088651266',1,1,203,95,77,'Amy Dalifah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611238',1,1,203,95,77,'Yohanes Mardi Irianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001781841',1,1,203,95,77,'Johannes Parlindungan S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003721874',1,1,203,95,77,'Meidy Aryaldi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003771890',1,1,203,95,77,'Laura Gultom','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001721855',1,1,203,95,77,'Teguh Yuwono ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802128',1,1,203,95,77,'Dimaz Haryunantyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611229',1,1,203,95,77,'Erna Herdiani K.Y.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822146',1,1,203,95,77,'Wulandari ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882535',1,1,203,95,77,'Novita Hidayati     ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0098701730',1,1,203,95,77,'Primaningayu Endah Wardani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088591210',1,1,203,95,77,'Melanton Ganap','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099741787',1,1,203,95,77,'Patricia Dwi Putri Panca Sakti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096671629',1,1,203,95,77,'Listio Sambono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801943',1,1,203,95,77,'Sulistianingsih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822296',1,1,203,95,77,'Oktavianus Lede Mude R','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832110',1,1,203,95,77,'Maldi Zakki Carmendi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862518',1,1,203,95,77,'Armynas Handyas Wijayatma          ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003781903',1,1,203,95,77,'Jannes Pandapotan S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086581024',1,1,203,95,77,'Herman Usman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1088631249',1,1,203,95,77,'Nurul Rozana Hosen','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097721694',1,1,203,95,77,'Ari Armay Syah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003801914',1,1,203,95,77,'Houstina Dewi Aggraini','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003781904',1,1,203,95,77,'Maisalina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611226',1,1,203,95,77,'Afridanur','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006812179',1,1,203,95,77,'Adi Munandir','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812142',1,1,203,95,77,'Widhi Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010832501',1,1,203,95,77,'Mas Agung Hamzari Akbar Habibie','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0083600922',1,1,203,95,77,'Dwi Atmoko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088641263',1,1,203,95,77,'Dumaria Sintauli','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801946',1,1,203,95,77,'Rosa Permata Sari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792062',1,1,203,95,77,'Faried Yahya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096771658',1,1,203,95,77,'Sunanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095751590',1,1,203,95,77,'Joana Dyah Tinuk D. Y.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842502',1,1,203,95,77,'A Azis Kurniawan    ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842506',1,1,203,95,77,'Puji Arman          ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011892628',1,1,203,95,77,'Kurniawan Agung Pambudi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012852663',1,1,203,95,77,'Tri Gendro Waskito Adi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012852665',1,1,203,95,77,'Harry Patria','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892711',1,1,203,95,77,'Adwitiya N Wityasmoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012902721',1,1,203,95,77,'Rossa Fadilla','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086601050',1,1,203,95,77,'Sri Budi Mayaningsih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096691634',1,1,203,95,77,'Talhah Tamia Shahab','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001731808',1,1,203,95,77,'Hedi Hedianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812143',1,1,203,95,77,'Aditya Damawan M.P.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007802283',1,1,203,95,77,'Bimala Augustryani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872528',1,1,203,95,77,'Lia Rahmania        ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842505',1,1,203,95,77,'Danny Prameswari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087571113',1,1,203,95,77,'Subanendra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097751720',1,1,203,95,77,'Sabaruddin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882537',1,1,203,95,77,'Indra Triaswati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852516',1,1,203,95,77,'Angga Mahendra      ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792064',1,1,203,95,77,'Reza Maghraby','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631258',1,1,203,95,77,'Dadang Gandara','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611232',1,1,203,95,77,'Sitti Nurhafni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099741788',1,1,203,95,77,'Chandra Putra Imanuel S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094681536',1,1,203,95,77,'Purnamawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0002711858',1,1,203,95,77,'Jalu Krishna Bayu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089681351',1,1,203,95,77,'Arniwaty','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832306',1,1,203,95,77,'Dian Restiyani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832164',1,1,203,95,77,'Wisnu Muhharyadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832163',1,1,203,95,77,'Andini Saraswati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882538',1,1,203,95,77,'Rozalita Asriati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099712187',1,1,203,95,77,'Ade Zulkarnaen','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872601',1,1,203,95,77,'Puteri Ayuningtyas  ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842553',1,1,203,95,77,'Devi Rizki Herdiyanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832158',1,1,203,95,77,'Lini Amy Berlian Tampubolon ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872683',1,1,203,95,77,'Md. Ilham Negara H','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088671163',1,1,203,95,77,'Asih Haryasih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099721769',1,1,203,95,77,'Rezki Anindhito','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0002711857',1,1,203,95,77,'Hertyasmawan Ery Fitriadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792060',1,1,203,95,77,'Dimas Haryo Dito','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012842658',1,1,203,95,77,'Sandi Sifananda','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892719',1,1,203,95,77,'Zulfikar Sani Putra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892713',1,1,203,95,77,'Gde Wahyu Utama','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089631334',1,1,203,95,77,'R. Arman Widhymarmanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001751818',1,1,203,95,77,'Sophan Sophian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094671530',1,1,203,95,77,'Fetrian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801945',1,1,203,95,77,'Bayu Kusumanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812130',1,1,203,95,77,'Taufan Zamzami','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842503',1,1,203,95,77,'Mohammad Harris Iswahyudi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862524',1,1,203,95,77,'Esty Maulidyasti Farestiana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842507',1,1,203,95,77,'Muhammad Irfan Lubis     ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097701691',1,1,203,95,77,'Baskara Agung Wibawa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731774',1,1,203,95,77,'Aristeus Ligamen Saleppang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089661344',1,1,203,95,77,'Achmad Mirza','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087611115',1,1,203,95,77,'Titi Mihartati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004771958',1,1,203,95,77,'Nurwulan Eka Wahyuni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781931',1,1,203,95,77,'Ardhimas Indrawidhi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099751791',1,1,203,95,77,'Adhi Lingga Harymurti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822153',1,1,203,95,77,'Asep Herlambang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0091611422',1,1,203,95,77,'Linda Saragih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003781902',1,1,203,95,77,'Devi Damayanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092681450',1,1,203,95,77,'Euis Mulyani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097781727',1,1,203,95,77,'Ris Haryono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822288',1,1,203,95,77,'Sigit Tri Hartanto Sukamto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087621116',1,1,203,95,77,'Lisna Wahijawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010822499',1,1,203,95,77,'Ufi Fatuhrahmah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882541',1,1,203,95,77,'Karlina Mustika Destianti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882540',1,1,203,95,77,'Adelina Artikasani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1007832220',1,1,203,95,77,'Edi Hidayat','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842312',1,1,203,95,77,'Selo Purna Atmani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007852328',1,1,203,95,77,'Rini Sukmana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872599',1,1,203,95,77,'Eko Yunianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004842017',1,1,203,95,77,'Fajar Rudiyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092681493',1,1,203,95,77,'Etiko Kusjatmiko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005782111',1,1,203,95,77,'Wahyu Wicaksono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781959',1,1,203,95,77,'Femin Puspitasari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012812656',1,1,203,95,77,'Nova Putri Widianingrum','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012832657',1,1,203,95,77,'Sekar Paramita','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012862676',1,1,203,95,77,'Aditya Danurwendo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872689',1,1,203,95,77,'Hari Wiryawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096661624',1,1,203,95,77,'Joko Heru Sutopo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086611054',1,1,203,95,77,'Enik Indriastuti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001761824',1,1,203,95,77,'Kemas Lukmanul Hakim','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004771956',1,1,203,95,77,'Destri Rusi Widiasari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004771923',1,1,203,95,77,'Tubagus Nurcholis','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089651370',1,1,203,95,77,'Purwoto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004681996',1,1,203,95,77,'R. Hanny Setiawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1596721643',1,1,203,95,77,'Herlina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010892543',1,1,203,95,77,'Romario Drajad      ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095721586',1,1,203,95,77,'Elvira Widosari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882616',1,1,203,95,77,'Ade Rusdiyati       ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012862668',1,1,203,95,77,'Andriyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089671347',1,1,203,95,77,'Endang Suryadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092661492',1,1,203,95,77,'M. Zaini Dahlan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001761828',1,1,203,95,77,'M. Andi Irawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631149',1,1,203,95,77,'Djoko Suripto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089701354',1,1,203,95,77,'Tety Aryanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097731707',1,1,203,95,77,'Kemas Hasyim Azhari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802083',1,1,203,95,77,'Cecep Yudi Subiantoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006792171',1,1,203,95,77,'Retnoningsih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792065',1,1,203,95,77,'Zulfikar Ali Imran','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832109',1,1,203,95,77,'Reza Yusandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095661571',1,1,203,95,77,'Eko Widagdo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781928',1,1,203,95,77,'Subandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792073',1,1,203,95,77,'Budi Prasetyaningtyas','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003781901',1,1,203,95,77,'Teguh Umar Dhanu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862446',1,1,203,95,77,'Riandy Arizon','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852569',1,1,203,95,77,'Firdah Tia Yuliana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862583',1,1,203,95,77,'Rahmi Nuzuliyah     ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099761798',1,1,203,95,77,'Adhi Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003811915',1,1,203,95,77,'Suluh Widyo Laksono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822099',1,1,203,95,77,'Rahadiyah Niken Damarjati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832160',1,1,203,95,77,'Asri Mumpuni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812088',1,1,203,95,77,'Moh. Nur Alim','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812091',1,1,203,95,77,'Hendi Novianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089621330',1,1,203,95,77,'Willy Roswaldi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088621246',1,1,203,95,77,'Endang Nadina I.W.C.D','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004741954',1,1,203,95,77,'Gita Noviyanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099691765',1,1,203,95,77,'Yohanes Eka Sujana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004811976',1,1,203,95,77,'Andrie Oktafauzan Lubis','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852565',1,1,203,95,77,'Indra Gunawan       ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088591208',1,1,203,95,77,'Yuniarsih Sani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092651491',1,1,203,95,77,'Ibnu Azka','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001751822',1,1,203,95,77,'Dani Arief Permana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822291',1,1,203,95,77,'Herman Hartanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012862669',1,1,203,95,77,'Rahmat Akbar Muttaqin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0002761863',1,1,203,95,77,'Irlita Findyasari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731776',1,1,203,95,77,'Grace Theresia Widyani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094641518',1,1,203,95,77,'Suranta','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086611052',1,1,203,95,77,'Arief Junaedi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088601213',1,1,203,95,77,'Agus Saptono Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092561487',1,1,203,95,77,'Debby Erika Sianipar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001761827',1,1,203,95,77,'Irpan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801940',1,1,203,95,77,'Herlina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089691352',1,1,203,95,77,'Hafifah Taharudin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007802337',1,1,203,95,77,'Widia Indrawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792071',1,1,203,95,77,'Heru Cahyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087601114',1,1,203,95,77,'Irawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099721771',1,1,203,95,77,'Ahmad Arief Rivai','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094661527',1,1,203,95,77,'Adi Ekawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088691167',1,1,203,95,77,'Miftahudin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099761799',1,1,203,95,77,'Jeffry Hotman Simanjuntak','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097701699',1,1,203,95,77,'Sahat Parlindungan S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094681534',1,1,203,95,77,'Yosviandri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092681495',1,1,203,95,77,'Lita Sriwulandari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094691537',1,1,203,95,77,'Danasworo Nurprasetyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1583630940',1,1,203,95,77,'Rahayu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089681349',1,1,203,95,77,'Sutaryo Suparjo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097681688',1,1,203,95,77,'Syafrudin Harahap','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611231',1,1,203,95,77,'Bekti Wicaksono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791966',1,1,203,95,77,'Dewi Nursetyaningrum','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003751883',1,1,203,95,77,'Rikrik Gantina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791968',1,1,203,95,77,'Muhammad Hardiansyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1088631179',1,1,203,95,77,'Dedih Supriadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801971',1,1,203,95,77,'Siti Nurmaya Rahmayani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781926',1,1,203,95,77,'Andi Sangga Prasetia','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004731953',1,1,203,95,77,'Erwin Ch. Simandjuntak','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802125',1,1,203,95,77,'Resi Aseanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812141',1,1,203,95,77,'Hadiyaksa Utama','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004811975',1,1,203,95,77,'Wahyu Nurhayanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005782056',1,1,203,95,77,'Dwi Maryono Ari Wibowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812093',1,1,203,95,77,'Noris Subekti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1086631012',1,1,203,95,77,'Fintje Hamelberg','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0098731736',1,1,203,95,77,'Tri Setyo Utomo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802079',1,1,203,95,77,'Joko Rusmartono Jati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005782058',1,1,203,95,77,'Kurnia Setio Wibowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792115',1,1,203,95,77,'Widi Pancana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1583600930',1,1,203,95,77,'Atang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792070',1,1,203,95,77,'Jul Indra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812090',1,1,203,95,77,'Aris Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005772054',1,1,203,95,77,'Sigit Dewantoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791938',1,1,203,95,77,'Rahmawati KA','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092691452',1,1,203,95,77,'Gitoyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003781899',1,1,203,95,77,'Prishy Ratrisadewi Suwarso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2488651146',1,1,203,95,77,'Hari Nurcahyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0002731860',1,1,203,95,77,'Ferry Imron Andreas S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004811977',1,1,203,95,77,'Aris Hartono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094671532',1,1,203,95,77,'Harry Ruswandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095711583',1,1,203,95,77,'Aris Lolon Rian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006812178',1,1,203,95,77,'Nita Widyasumanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004771957',1,1,203,95,77,'Fujianti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004821978',1,1,203,95,77,'Samson Sony','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0083560948',1,1,203,95,77,'Lies Hermaniati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094691540',1,1,203,95,77,'Sularti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095671573',1,1,203,95,77,'Achmad Fahruzaman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781930',1,1,203,95,77,'Khairuzzadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096741680',1,1,203,95,77,'Trio Dedy Kusuma','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007812285',1,1,203,95,77,'Haryoga Aditya Wardhana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007802282',1,1,203,95,77,'Bayu Lambang Pamungkas','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092691435',1,1,203,95,77,'Rosidin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096761656',1,1,203,95,77,'Beni Pramono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095711554',1,1,203,95,77,'Budhijanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791939',1,1,203,95,77,'Mukhamad Andi Rahman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832159',1,1,203,95,77,'Febry Komala Uli','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822145',1,1,203,95,77,'Nanny Atika','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792117',1,1,203,95,77,'Novita Anggraeni Siregar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822102',1,1,203,95,77,'Fransiska','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005792116',1,1,203,95,77,'Mardeni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802124',1,1,203,95,77,'Setifana Bambang Pranowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010832407',1,1,203,95,77,'Cokorda Bagus Purnama Dwisa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862522',1,1,203,95,77,'Rahmat Zamzami      ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852513',1,1,203,95,77,'Wening Ngesthi Darmastuti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010822498',1,1,203,95,77,'Anik Rurin Purwaningsih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010822500',1,1,203,95,77,'Faiz Fairussani Albananiy','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812129',1,1,203,95,77,'Muhammad Brajaka Kusuma','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842549',1,1,203,95,77,'Aan Fatoni          ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099642198',1,1,203,95,77,'Supriatna','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842550',1,1,203,95,77,'Debora Kristina Silalahi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882624',1,1,203,95,77,'Irma Indriani       ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862586',1,1,203,95,77,'Pipit Agustiyanti Mulyadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0087671119',1,1,203,95,77,'Ardi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852557',1,1,203,95,77,'Yogo Oka Prima      ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006812172',1,1,203,95,77,'Vaticano Walflomanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096641662',1,1,203,95,77,'Eddy Mulyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004732004',1,1,203,95,77,'Heru Budi Setiawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004772007',1,1,203,95,77,'Chandrani Kurnianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004681999',1,1,203,95,77,'Muhammad Ramdani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004732005',1,1,203,95,77,'Fahrizal','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004782010',1,1,203,95,77,'Suladi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089621331',1,1,203,95,77,'Doddy Adianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1096751614',1,1,203,95,77,'Agung Kusbiantoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801942',1,1,203,95,77,'Adam Nur Bawono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003771897',1,1,203,95,77,'Desy Anggia Wulandari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872681',1,1,203,95,77,'Andhika Yuristiana Putra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0083560947',1,1,203,95,77,'Suhartono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088621142',1,1,203,95,77,'Henky Karmanu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0085570976',1,1,203,95,77,'Bambang Wahyu Riyadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086581034',1,1,203,95,77,'Agus Dihardjo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088591154',1,1,203,95,77,'Ramli Manurung','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088641160',1,1,203,95,77,'Nasihin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094671531',1,1,203,95,77,'Hadyan Ardi Bhusana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097701690',1,1,203,95,77,'Hendri Joniansyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631255',1,1,203,95,77,'Achmad Yulianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631256',1,1,203,95,77,'R. Wahyono Prasetyo T.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0098711733',1,1,203,95,77,'Ista Andayani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003771889',1,1,203,95,77,'Elise','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088571198',1,1,203,95,77,'Listeria Panjaitan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089671346',1,1,203,95,77,'Sri Supiah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089651341',1,1,203,95,77,'Hari Muladi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088651161',1,1,203,95,77,'Achmad Ikbaludin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842322',1,1,203,95,77,'Rika Sulastri Panjaitan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1588641276',1,1,203,95,77,'Elda Sutarda','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087661093',1,1,203,95,77,'Wahyudi Agustinus','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096641623',1,1,203,95,77,'Hidayat Akman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092621489',1,1,203,95,77,'Budi Hartono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2078570870',1,1,203,95,77,'Sarnyata','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089681380',1,1,203,95,77,'Saeful Hadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3088631250',1,1,203,95,77,'Herry Yusuf','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1583620933',1,1,203,95,77,'Pantja Wahyu Pribadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087651092',1,1,203,95,77,'Djanurianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087591083',1,1,203,95,77,'Moh. Basori','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095661549',1,1,203,95,77,'Sentot Suhartono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791964',1,1,203,95,77,'Wahyu Wijaya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0098731735',1,1,203,95,77,'Edi Armawiria','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087611088',1,1,203,95,77,'David J Willemsen','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099721773',1,1,203,95,77,'Suhaini Muhamad Aslamayani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096721674',1,1,203,95,77,'Hamalsyahan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095711555',1,1,203,95,77,'Irene Joeliawardhani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003801912',1,1,203,95,77,'Budi Priswanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085620983',1,1,203,95,77,'Margiyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2486611031',1,1,203,95,77,'Edy Sukamto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1087601096',1,1,203,95,77,'Daryanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2485590990',1,1,203,95,77,'Sri Sudarsini','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001741811',1,1,203,95,77,'Fri Wazanati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096731646',1,1,203,95,77,'Tutik Miladiah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095751564',1,1,203,95,77,'Hary Sukartono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095751565',1,1,203,95,77,'Agus Budi Prasetyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087650191',1,1,203,95,77,'Subandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751682',1,1,203,95,77,'Heri Frastiono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751655',1,1,203,95,77,'Achmad Hidayat','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096771687',1,1,203,95,77,'Suseno Salim','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096731676',1,1,203,95,77,'Sucipto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087621090',1,1,203,95,77,'Sumidjan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095711553',1,1,203,95,77,'Sutarno TW','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2081570897',1,1,203,95,77,'Endang Susilowati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095701551',1,1,203,95,77,'M. Munari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751654',1,1,203,95,77,'Agus Mustofa Hadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092651443',1,1,203,95,77,'Agus Mufriadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096761657',1,1,203,95,77,'Misbachul Munir','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095721556',1,1,203,95,77,'Merry Wahyu Endah Tj','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751653',1,1,203,95,77,'Achmad Anas','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096721650',1,1,203,95,77,'Moh. Makki Nuruddin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095701552',1,1,203,95,77,'M. Yusni Thamrin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088661162',1,1,203,95,77,'Jana Budijana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751652',1,1,203,95,77,'Faisal Arief','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099771754',1,1,203,95,77,'Hadi Sucipto Kusuma','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761746',1,1,203,95,77,'Mochamad Arief','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096731651',1,1,203,95,77,'Eko Cahyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096721673',1,1,203,95,77,'Mai Setiyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096711670',1,1,203,95,77,'Juniar Kartika Sari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003771888',1,1,203,95,77,'Riko Teguh Wibisono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832310',1,1,203,95,77,'Raymond Sondang Maruli T','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2487611121',1,1,203,95,77,'Sugiyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003761885',1,1,203,95,77,'Trisaksana Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092601438',1,1,203,95,77,'Agung Arianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099771756',1,1,203,95,77,'Ria Sari Yuliati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095681550',1,1,203,95,77,'Nur Hidayati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096741679',1,1,203,95,77,'Selamet Tri Welasono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095741563',1,1,203,95,77,'Rr. Ami Mawarti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099771755',1,1,203,95,77,'Wahyudi Eko Prasetyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001791849',1,1,203,95,77,'Agus Hermawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095741562',1,1,203,95,77,'Alif Pramudiya Riza','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096741678',1,1,203,95,77,'Dyah Retno Suryani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751684',1,1,203,95,77,'Agung Rochman Solichi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099781759',1,1,203,95,77,'Sunardi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095761566',1,1,203,95,77,'Totok Eliyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089701386',1,1,203,95,77,'Minda Tati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001791848',1,1,203,95,77,'Braman Setyoko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751685',1,1,203,95,77,'Ririn Novi Purwanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096721671',1,1,203,95,77,'Suyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822151',1,1,203,95,77,'Arief Nurrachman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2487671124',1,1,203,95,77,'Imam Supriyadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761748',1,1,203,95,77,'Sukiswanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001811853',1,1,203,95,77,'Dedy Tulus Pambudi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099751742',1,1,203,95,77,'Atang Sudjani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095671567',1,1,203,95,77,'Hary Siswanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872463',1,1,203,95,77,'Thoriq Ganang Prakoso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862443',1,1,203,95,77,'Kristophorus Kanaprio Ola','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007832233',1,1,203,95,77,'Denny Hariyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002821868',1,1,203,95,77,'Imam Musyafa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862444',1,1,203,95,77,'Kabul Sucipto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002791865',1,1,203,95,77,'Anis Nurhidayat','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872468',1,1,203,95,77,'Aldo Marino','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099791760',1,1,203,95,77,'Arif Wijaya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002821867',1,1,203,95,77,'Dwi Andriani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852429',1,1,203,95,77,'Yogi Alex Prabowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852417',1,1,203,95,77,'Dickha Rizky Maulana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096711669',1,1,203,95,77,'Rina Indra  Wijayani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001811850',1,1,203,95,77,'Yanuar Triani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2487651123',1,1,203,95,77,'Ahmad Nasukha','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002821869',1,1,203,95,77,'Emil Sugiarto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099751743',1,1,203,95,77,'Agus Riyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2078580871',1,1,203,95,77,'Affandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2081570896',1,1,203,95,77,'Slamet Hariyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2078580874',1,1,203,95,77,'Darminto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761751',1,1,203,95,77,'Wawan Pujiono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087601085',1,1,203,95,77,'Teguh Hartoni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095721558',1,1,203,95,77,'Ichwan Fauzi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872458',1,1,203,95,77,'Ferman Hakiki','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001821854',1,1,203,95,77,'Rizal Yuniarto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099771757',1,1,203,95,77,'Dawud Mustopa','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007822230',1,1,203,95,77,'Heri Wibowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852424',1,1,203,95,77,'Sinung Sedya Utomo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862439',1,1,203,95,77,'Zanuar Kriswanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002831872',1,1,203,95,77,'Freddy Setiawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095641547',1,1,203,95,77,'Budiarto Isnaeni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882474',1,1,203,95,77,'Nanda Prawita','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852435',1,1,203,95,77,'Havid Noviasto Wahyudi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852427',1,1,203,95,77,'Ilham Anjaryadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862448',1,1,203,95,77,'Fivin Ari Suwandhana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099751745',1,1,203,95,77,'Nurdiansa Regnanto ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822149',1,1,203,95,77,'Faisal Arif','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812138',1,1,203,95,77,'Yuniar Kusrini Mutinanta','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832155',1,1,203,95,77,'Aulia Parmawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085610982',1,1,203,95,77,'Priadi Lesman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2078570868',1,1,203,95,77,'Kustoyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761747',1,1,203,95,77,'Nur Kholis ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001791847',1,1,203,95,77,'Nito Rahmadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002821870',1,1,203,95,77,'Sugianto Eko Cahyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761752',1,1,203,95,77,'Wiwit Ariyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005812136',1,1,203,95,77,'Salim Tribuana Wahyuni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095731561',1,1,203,95,77,'Yulwin Nora Kalalo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099751744',1,1,203,95,77,'Ika Sukmawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002791864',1,1,203,95,77,'Eko Septyawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096721649',1,1,203,95,77,'Joko Prijanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832161',1,1,203,95,77,'Afilia Purwaningrum','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882473',1,1,203,95,77,'Narulita Kusuma Hasyim','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761750',1,1,203,95,77,'Siftiatil Faisah Lede','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002821866',1,1,203,95,77,'Dhani Amannatur','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007832260',1,1,203,95,77,'Faisal Reza Imahendra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001811852',1,1,203,95,77,'Aman Setiadji','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096731675',1,1,203,95,77,'Eko Suprayitno','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007832235',1,1,203,95,77,'Hadid Azelea','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007822231',1,1,203,95,77,'Setyo Deny Hudaya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001811851',1,1,203,95,77,'Deddy Efendi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007822232',1,1,203,95,77,'Baried Nurcahyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842412',1,1,203,95,77,'Fajar Muhammad Sidiq','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2002831871',1,1,203,95,77,'Reni Nur Anggraeni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872467',1,1,203,95,77,'Akmaluddin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852432',1,1,203,95,77,'Tyas Aryo Willyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007832236',1,1,203,95,77,'Bramantya Pradana Saputra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761753',1,1,203,95,77,'Dwi Handoko Sandhi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096731677',1,1,203,95,77,'Endang Sri Rahayu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096761686',1,1,203,95,77,'Asep Tatang Purnomo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099761749',1,1,203,95,77,'Agus Arif Pramudihanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001781846',1,1,203,95,77,'Mohamad Ishaq','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007812229',1,1,203,95,77,'Bagus Fernata','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010892481',1,1,203,95,77,'Dita Nugrahaeni Putri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007872261',1,1,203,95,77,'Indria Swesti Wardhani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007852237',1,1,203,95,77,'Achmad Mirza','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004822012',1,1,203,95,77,'Heru Setiawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011902635',1,1,203,95,77,'Dini Septiani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004842018',1,1,203,95,77,'Eko Sujarwadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852564',1,1,203,95,77,'Teni Vitanggi       ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852560',1,1,203,95,77,'Metya Dwi Putri Marsetiana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852556',1,1,203,95,77,'Eva Y Tambunan      ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2079570876',1,1,203,95,77,'Ngadjib','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862579',1,1,203,95,77,'Yudi Adhi Widodo    ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011902631',1,1,203,95,77,'Jauhari Wicaksono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085590980',1,1,203,95,77,'Ariyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087661094',1,1,203,95,77,'Yuniar Heru Yuwono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004832014',1,1,203,95,77,'Taufan Setiarso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882620',1,1,203,95,77,'Agus Hartadi        ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004842019',1,1,203,95,77,'Heru Prasetiyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882617',1,1,203,95,77,'Dwiyoso Pramono     ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852559',1,1,203,95,77,'Ferry Wihardi       ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087611087',1,1,203,95,77,'Marto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085581004',1,1,203,95,77,'Sri Pangastuti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095721557',1,1,203,95,77,'Supriyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004842016',1,1,203,95,77,'Yuniar Iswari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085630986',1,1,203,95,77,'Sutrisno D.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872594',1,1,203,95,77,'Fuad Hasan          ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882609',1,1,203,95,77,'Michael Edigia Wizard','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852558',1,1,203,95,77,'Nurhadi Sujatmoko   ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087611089',1,1,203,95,77,'Sudadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085620985',1,1,203,95,77,'Samiran','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872592',1,1,203,95,77,'Fourikha Budi Sulistyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007832234',1,1,203,95,77,'Hendy Prima Kurniawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007862238',1,1,203,95,77,'Lulun Cholisoh','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2007882239',1,1,203,95,77,'Arie Indra Prasetya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085630988',1,1,203,95,77,'Slamet Suyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872596',1,1,203,95,77,'Ayu Tri Wijayanti   ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011902637',1,1,203,95,77,'Lindra Aulia Rachman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004822013',1,1,203,95,77,'Tri Laksono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004852021',1,1,203,95,77,'R. Bagus Windianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852563',1,1,203,95,77,'Ratna Dian Suminar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2004852020',1,1,203,95,77,'Muhamad Feqih Fadjri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085570979',1,1,203,95,77,'Erwanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2085600981',1,1,203,95,77,'Edi Prayitno','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862580',1,1,203,95,77,'Febrian Nur Ardiwinata','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2009732402',1,1,203,95,77,'Astuti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099642199',1,1,203,95,77,'Sumarto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099672200',1,1,203,95,77,'Mulyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2009822403',1,1,203,95,77,'Edi Sulistyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2087581082',1,1,203,95,77,'Seger','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2074560754',1,1,203,95,77,'Effendi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095731560',1,1,203,95,77,'Sudarmo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012652639',1,1,203,95,77,'Sutopo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012772642',1,1,203,95,77,'R. Victor Purboristanto Tetrano','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012792654',1,1,203,95,77,'Ari Arnold Vergouw','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872677',1,1,203,95,77,'Bima Satria Agung','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012882698',1,1,203,95,77,'Gilang Hermawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892704',1,1,203,95,77,'Azhari Ramdhani Sambas','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892715',1,1,203,95,77,'Rudy Setyawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892717',1,1,203,95,77,'Rifki Bagus Pradipta','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892718',1,1,203,95,77,'Devita Sari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012902722',1,1,203,95,77,'Achmad Afandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089621338',1,1,203,95,77,'Sri Supriyantini','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822152',1,1,203,95,77,'Elia Andriyani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088591212',1,1,203,95,77,'Joko P. Gunawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631253',1,1,203,95,77,'Mugiono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088561197',1,1,203,95,77,'Setin Damanik','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097701697',1,1,203,95,77,'Timbul Duffy B. Aritonang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094661523',1,1,203,95,77,'Muklis','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3088581205',1,1,203,95,77,'Banggas Tambunan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1086631011',1,1,203,95,77,'Arif Yunizar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089621340',1,1,203,95,77,'Wibowo ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097701698',1,1,203,95,77,'Afdal','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791937',1,1,203,95,77,'Andri Oscarianto Ginting ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086641068',1,1,203,95,77,'Usman ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3082610912',1,1,203,95,77,'Sukarman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3082590910',1,1,203,95,77,'Jansen Situmorang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003791910',1,1,203,95,77,'Agoeng Pratomo Noegroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3082560906',1,1,203,95,77,'Mahadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801970',1,1,203,95,77,'Heru Indriatno','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089641292',1,1,203,95,77,'Kastam','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801969',1,1,203,95,77,'Hendra Halim','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088601139',1,1,203,95,77,'Djoko Satrijadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089611283',1,1,203,95,77,'Sutrisno','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089631289',1,1,203,95,77,'Dalrusidi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097781728',1,1,203,95,77,'Aldiansyah Idham','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097741715',1,1,203,95,77,'Rusliman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651295',1,1,203,95,77,'Rommel Manurung ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089621285',1,1,203,95,77,'Ponimin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089661302',1,1,203,95,77,'Yusnani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3090671415',1,1,203,95,77,'Santoso Priyo Pratomo ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089561357',1,1,203,95,77,'Soebarmo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097771723',1,1,203,95,77,'Musanif  ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099751793',1,1,203,95,77,'Dian Heryanti Handayani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089681307',1,1,203,95,77,'Hidayani Agustina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086581059',1,1,203,95,77,'Sugihartono ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004781929',1,1,203,95,77,'Eka Hari Setiawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007802284',1,1,203,95,77,'Yudhiasny Saragih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086601062',1,1,203,95,77,'Sri Sulastry','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089691381',1,1,203,95,77,'Solorida','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089661304',1,1,203,95,77,'Lis Sulaikawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3082580909',1,1,203,95,77,'Zulfan Lubis','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089691385',1,1,203,95,77,'Sri Haryati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089661301',1,1,203,95,77,'Dewi Rusdianti ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088641152',1,1,203,95,77,'Endang Sopian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001761829',1,1,203,95,77,'Kartini Tetty Pandiangan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089661300',1,1,203,95,77,'Yusmawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096721672',1,1,203,95,77,'Hery Purwanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006782177',1,1,203,95,77,'Tito Bintoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086621066',1,1,203,95,77,'Mukhrin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089561356',1,1,203,95,77,'Astober Simanjuntak ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3088591168',1,1,203,95,77,'Petrus Christial H. Pohan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097721709',1,1,203,95,77,'Victor Sahala M','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089631290',1,1,203,95,77,'Linda Nauli','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089671376',1,1,203,95,77,'Sumadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097741718',1,1,203,95,77,'Pangondian Manihuruk ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089611361',1,1,203,95,77,'Indiyarti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089671306',1,1,203,95,77,'Candrawati Kusumayekti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097761722',1,1,203,95,77,'Wendi Purwanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097751721',1,1,203,95,77,'Selly Elizabeth','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651374',1,1,203,95,77,'Rema Sinaga','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822148',1,1,203,95,77,'Meilina Mutiara ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097741716',1,1,203,95,77,'Azhar Wijaya ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651297',1,1,203,95,77,'Azwardi ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095671572',1,1,203,95,77,'Andi Firdaus ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097771726',1,1,203,95,77,'Muhd. Kahfi ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089641294',1,1,203,95,77,'Erliana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822096',1,1,203,95,77,'Yatmoko Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005802127',1,1,203,95,77,'Agus Kurniawan ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003731876',1,1,203,95,77,'Jonson Mardongan S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089671305',1,1,203,95,77,'Kamarussaman Nasution','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089621286',1,1,203,95,77,'Nyoto Waluyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089631288',1,1,203,95,77,'Tohar ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651298',1,1,203,95,77,'Suwito','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882479',1,1,203,95,77,'Vivian Wongistani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089581282',1,1,203,95,77,'Suroso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089661303',1,1,203,95,77,'Udin Depari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089631287',1,1,203,95,77,'Suyono  ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3090671416',1,1,203,95,77,'Della Siregar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862517',1,1,203,95,77,'Ratih Sukma Juwita','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089681379',1,1,203,95,77,'Sri Sukarsih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862523',1,1,203,95,77,'Santi Susiloputri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086641071',1,1,203,95,77,'Resdianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086611063',1,1,203,95,77,'Effendi ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005832166',1,1,203,95,77,'Ardita Novianti ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097741714',1,1,203,95,77,'Marlina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089691384',1,1,203,95,77,'Ratna Dewi Siregar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3090611412',1,1,203,95,77,'Purwo Edi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3082570908',1,1,203,95,77,'Sugiadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086601061',1,1,203,95,77,'Sahadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086591060',1,1,203,95,77,'Sugiarto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086641070',1,1,203,95,77,'Ngumban Tarigan ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086651072',1,1,203,95,77,'Asril','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007772240',1,1,203,95,77,'Poppy Simorangkir','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086651073',1,1,203,95,77,'Osbal Lumban Tobing','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651369',1,1,203,95,77,'Supriyadi 2','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089631291',1,1,203,95,77,'Van Richolf Sihombing ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086641069',1,1,203,95,77,'Suwardi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3082600911',1,1,203,95,77,'Sugianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089671377',1,1,203,95,77,'Sudarjak','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089691383',1,1,203,95,77,'Amril','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872485',1,1,203,95,77,'Mohamad Rifqi Al-Yusebqi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007842246',1,1,203,95,77,'Ahmad Abrar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862452',1,1,203,95,77,'Wahyu Al Fashshi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3090631413',1,1,203,95,77,'Roster Hutagalung ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007832245',1,1,203,95,77,'Gusti Hadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007842247',1,1,203,95,77,'Charly Simanullang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097721710',1,1,203,95,77,'Henri Herbert Panjaitan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651299',1,1,203,95,77,'Harman Edi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097741717',1,1,203,95,77,'Feron Edyka Putra S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007802242',1,1,203,95,77,'Tengku Rifki Fauzan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862442',1,1,203,95,77,'Aditya Eka Wijaya','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007832244',1,1,203,95,77,'Tampil Lumbantoruan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852568',1,1,203,95,77,'Yandi Azhari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004851994',1,1,203,95,77,'Andyan Borisman S','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007802241',1,1,203,95,77,'Febi Hartanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651296',1,1,203,95,77,'Ridwan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004791986',1,1,203,95,77,'Riza Buana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004811990',1,1,203,95,77,'Popi Indriati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004791987',1,1,203,95,77,'Riki Yazwardi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004781982',1,1,203,95,77,'Hamidah Armaini','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007712257',1,1,203,95,77,'Aisyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007812243',1,1,203,95,77,'Ahmadsyah Nasution','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007852248',1,1,203,95,77,'Rodiah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3092711454',1,1,203,95,77,'Lisye Meida Rosintan. P','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004811992',1,1,203,95,77,'Pitria Romadhon','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004781983',1,1,203,95,77,'Budi Cahyadi Ginting','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004811991',1,1,203,95,77,'Irvan Panusunan L Tobing','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3086621064',1,1,203,95,77,'Edy Prianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007732258',1,1,203,95,77,'Rommel Simanjuntak','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852577',1,1,203,95,77,'Tri Hartanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3090671414',1,1,203,95,77,'Sukardi  2','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004781981',1,1,203,95,77,'Hasbi Sidiq','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007852249',1,1,203,95,77,'Umam Prabowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089621284',1,1,203,95,77,'Yuliawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011902632',1,1,203,95,77,'Prabandaru Cahyo Anggoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007872251',1,1,203,95,77,'Hakim Gunawan Lbn Tobing','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089641366',1,1,203,95,77,'Edi Santoso','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004791985',1,1,203,95,77,'Gindo Edward Nobel P','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882615',1,1,203,95,77,'Fitria Ratna Yuniarti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004781980',1,1,203,95,77,'Eva Marito Daulay','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011902629',1,1,203,95,77,'Adil Wahyudin Anwar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862584',1,1,203,95,77,'Mursal','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0011902633',1,1,203,95,77,'Zulkarnaen','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007872250',1,1,203,95,77,'Syahputra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3004841993',1,1,203,95,77,'Lamhotma Parulian Siboro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882614',1,1,203,95,77,'Parlin Simatupang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3007862259',1,1,203,95,77,'Roni Wibowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872605',1,1,203,95,77,'Rini Devi Andari    ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012882692',1,1,203,95,77,'Suharmat','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892702',1,1,203,95,77,'Abirul Trison Syahputra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892708',1,1,203,95,77,'Cholifah Indah Permatasari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892709',1,1,203,95,77,'Anisya Nesiyanti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892712',1,1,203,95,77,'Yenni Andriani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832301',1,1,203,95,77,'Febrillian Hindarto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088621245',1,1,203,95,77,'Kris Handono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631254',1,1,203,95,77,'Manangap Napitupulu','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0086611053',1,1,203,95,77,'Hermin Indayati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094621515',1,1,203,95,77,'Darmodjo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0002721859',1,1,203,95,77,'Ibnu Asturrachman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731782',1,1,203,95,77,'Posma L. Sirait','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088611224',1,1,203,95,77,'Handijoko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001761825',1,1,203,95,77,'Eko Posmanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099721770',1,1,203,95,77,'Arie Susanto Tjahyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088621242',1,1,203,95,77,'Heru Susapto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094611513',1,1,203,95,77,'Oman Rochmana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096681630',1,1,203,95,77,'Samtoner Tamba','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094661524',1,1,203,95,77,'Yuliandri Royke','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1588601216',1,1,203,95,77,'Harry Arnesus Picauly','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003751884',1,1,203,95,77,'Bunyamin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0097721702',1,1,203,95,77,'Diana Legirorina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005782055',1,1,203,95,77,'Seno Supriadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001741812',1,1,203,95,77,'Iis Elisah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822147',1,1,203,95,77,'Ary Maulana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731784',1,1,203,95,77,'Boby Susilo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001741809',1,1,203,95,77,'Fuadsyah Reza','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003751881',1,1,203,95,77,'Budi Junias Sinaga','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099731741',1,1,203,95,77,'Anisyah Roestantien','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0084610951',1,1,203,95,77,'Reny Triana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0094691539',1,1,203,95,77,'Jeffri Sianturi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004801972',1,1,203,95,77,'Santika Budhi Utami','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089611337',1,1,203,95,77,'Mulyono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0005822104',1,1,203,95,77,'Leonardo Dapot Hasiholan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001771839',1,1,203,95,77,'Pahala Baringbing','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1096741611',1,1,203,95,77,'Siswanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095691579',1,1,203,95,77,'Dody Tusandy','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007802280',1,1,203,95,77,'Kokoh Parlindungan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092671448',1,1,203,95,77,'Bambang Budiono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2096751683',1,1,203,95,77,'Hendhi Trihadmoko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0001741810',1,1,203,95,77,'Mona Veronika','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095701581',1,1,203,95,77,'Daryanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2095721559',1,1,203,95,77,'Anang Wahyudi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097721711',1,1,203,95,77,'Juvinus Sembiring','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097731713',1,1,203,95,77,'Taufik Barus','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1699781763',1,1,203,95,77,'Heriyana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006772175',1,1,203,95,77,'Boyke Lumban Tobing','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003821916',1,1,203,95,77,'Elfan Triawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822293',1,1,203,95,77,'Astrid Taruli Debora','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2099781758',1,1,203,95,77,'Andaya Endy Saputra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1693701511',1,1,203,95,77,'Rusli Mulyana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('2001771845',1,1,203,95,77,'Oki Imam Muttaqim','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004681995',1,1,203,95,77,'Boedijanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3089651371',1,1,203,95,77,'Tauhid Safari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('3097771724',1,1,203,95,77,'Tonny Hartono Hutagalung','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089651406',1,1,203,95,77,'Tasrifudin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862450',1,1,203,95,77,'Oktobyanto Tri Raharjo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842414',1,1,203,95,77,'Muhammad Ardian Arifin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010832409',1,1,203,95,77,'Irsyad Aini','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010812404',1,1,203,95,77,'Tomi Dian Putra','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842509',1,1,203,95,77,'Abdur Rasyid','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872533',1,1,203,95,77,'Arindra Irtonugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852512',1,1,203,95,77,'Detie Maulina','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872459',1,1,203,95,77,'Chandra Warman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872526',1,1,203,95,77,'Suprapto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872461',1,1,203,95,77,'Chandra Nur Silaban','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852423',1,1,203,95,77,'Gatot Ari Fitri Pramita','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009852391',1,1,203,95,77,'Luthfianto Ardhi Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872464',1,1,203,95,77,'Koenthi Purnama Ningtyas','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010892496',1,1,203,95,77,'Gayuh Wulandari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007852330',1,1,203,95,77,'Anindito','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007882268',1,1,203,95,77,'Aris Rahmaprilianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007882269',1,1,203,95,77,'Mochammad Haryo Pramantyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007882270',1,1,203,95,77,'Karisnda Rahmadani','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007882272',1,1,203,95,77,'Wahyu Dwiagasta','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007882267',1,1,203,95,77,'Ingenura Maarti Hutami','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842413',1,1,203,95,77,'Septiaji Muhammad Ibnu Salam','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862441',1,1,203,95,77,'Pri Endi Ariawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832307',1,1,203,95,77,'Herlenika','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009842386',1,1,203,95,77,'Muhammad Fikrie Farhan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832304',1,1,203,95,77,'Boby Aditya Cahya Ananda','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007862336',1,1,203,95,77,'Sony Achmad','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007852326',1,1,203,95,77,'Genius NJ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842314',1,1,203,95,77,'Erwin Perdana Romadhian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009852394',1,1,203,95,77,'Purnawan Tirta Yuwana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842318',1,1,203,95,77,'Agung Kusuma Wardana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089691382',1,1,203,95,77,'Marthalena Luciana ','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0095641570',1,1,203,95,77,'Hasanah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822290',1,1,203,95,77,'Novi Firmansyah Koswara','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009842385',1,1,203,95,77,'Muhammad Alwi Huda','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822289',1,1,203,95,77,'Ida Fortuna Dewi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009842388',1,1,203,95,77,'Annis Sofia','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832299',1,1,203,95,77,'Citra Pranandar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009862398',1,1,203,95,77,'Arfan Agung Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852433',1,1,203,95,77,'Nova Kristian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842317',1,1,203,95,77,'Intan R Yulianti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872469',1,1,203,95,77,'Ary Budiman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832309',1,1,203,95,77,'Didiet Pradityo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009852389',1,1,203,95,77,'Ihdina Adli','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009852395',1,1,203,95,77,'Mohamad Yogi Novianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010892495',1,1,203,95,77,'Valandra Leonardo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009832381',1,1,203,95,77,'Arif Istiadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009872399',1,1,203,95,77,'Rizki Wijanarto  Budiman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862449',1,1,203,95,77,'Rendiyansa Agustian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010892492',1,1,203,95,77,'Brian Permana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007852333',1,1,203,95,77,'Mahar Prasetyo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007852329',1,1,203,95,77,'Yusron Firmansyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852426',1,1,203,95,77,'Eko Haris Siswanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010892491',1,1,203,95,77,'Wira Anom Wibowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009862397',1,1,203,95,77,'Henki Rizuliyanta','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009872400',1,1,203,95,77,'Arnal Diansah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852437',1,1,203,95,77,'Dedi Saputra Sirait','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009852393',1,1,203,95,77,'Nanda Aditya Pradana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007852332',1,1,203,95,77,'Niken Astria Safitri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009852390',1,1,203,95,77,'Soesatyo Bimo Tri Amboro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007862334',1,1,203,95,77,'Akrom Akhmadi Wibowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842321',1,1,203,95,77,'Abdul Rosyid','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882477',1,1,203,95,77,'Firman Riantus','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007872264',1,1,203,95,77,'Edwin Alfani Soleh','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009842382',1,1,203,95,77,'Bintang Maratur Sianturi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009862396',1,1,203,95,77,'Sanghiang Bikeu Hejang','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('1008852358',1,1,203,95,77,'Rikky Mokodompit','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872462',1,1,203,95,77,'Septi Lusia Indah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0092631442',1,1,203,95,77,'Tutung Benyamin','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009832401',1,1,203,95,77,'Sundung Jadiaman Silaban','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007852327',1,1,203,95,77,'Mira Fatmawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0006762173',1,1,203,95,77,'Jonli Simanjuntak','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007862335',1,1,203,95,77,'Firman Budiman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832302',1,1,203,95,77,'Pramono Setiya Purwanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007842325',1,1,203,95,77,'Obrin Ambari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007872265',1,1,203,95,77,'Pradipta Ardhi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007882271',1,1,203,95,77,'Ardith Wedha Sudana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882487',1,1,203,95,77,'Arif Hidayaturochman','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007872266',1,1,203,95,77,'Muhammad Sanne','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009842383',1,1,203,95,77,'Iwhan Agung Wibowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009782380',1,1,203,95,77,'I Made Yudi Artama','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822298',1,1,203,95,77,'Ridwan Muharam','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007882273',1,1,203,95,77,'Agung Dwi Hasdianto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007872263',1,1,203,95,77,'Didin Afandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007822295',1,1,203,95,77,'Hari Satria Aribowo','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009852392',1,1,203,95,77,'Hendra Saputra Dunggio','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009842384',1,1,203,95,77,'Pandu Pradana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832311',1,1,203,95,77,'Rahmat Hidayat','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832300',1,1,203,95,77,'Akhmad Afandi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0009842387',1,1,203,95,77,'Moh. Said Setya Amdi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872456',1,1,203,95,77,'Zetra Adhiarsih','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010842552',1,1,203,95,77,'Riptian Suryo Anggoro','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010832547',1,1,203,95,77,'Ferry','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862588',1,1,203,95,77,'Mahrimawati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004772008',1,1,203,95,77,'Rosdiana','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872602',1,1,203,95,77,'Muhamad Ali Fikri','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862587',1,1,203,95,77,'Achmad Aftoni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852576',1,1,203,95,77,'Denny Eko Listiono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010872597',1,1,203,95,77,'Indra Gunawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882612',1,1,203,95,77,'Moch. Asrul Afrizal','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004762006',1,1,203,95,77,'Wahyu Hardian','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004782011',1,1,203,95,77,'Dodo Darsono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004732002',1,1,203,95,77,'Siswanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852561',1,1,203,95,77,'Rini Meilany Munthe','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862581',1,1,203,95,77,'Viet Ronald Tampubolon','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010862585',1,1,203,95,77,'Danang Setyo Nugroho','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010882621',1,1,203,95,77,'Lukman Ferdiyanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010852572',1,1,203,95,77,'Khairul Khitam','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004732003',1,1,203,95,77,'Ninik Sunarti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004702001',1,1,203,95,77,'Tridarty Rame Tulus Tambunan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088641151',1,1,203,95,77,'Endang Suhanda','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012752641',1,1,203,95,77,'Melki Ambarita Escola','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012822648',1,1,203,95,77,'Hadi Sucipto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012832649',1,1,203,95,77,'Afan Azrullah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012832650',1,1,203,95,77,'Adi Martono','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012852652',1,1,203,95,77,'Achmad Refandi.','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012862675',1,1,203,95,77,'Tommy Arbiwijaya Suherlan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012872682',1,1,203,95,77,'Azwar Oktaviansyah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012882691',1,1,203,95,77,'Emi Heru Hermanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012882694',1,1,203,95,77,'Nur Saidah','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892701',1,1,203,95,77,'Raden Roro Listya Paramita Widhyasari','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892705',1,1,203,95,77,'Laelia Afrisanthi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0012892720',1,1,203,95,77,'Elvan Achmadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089611327',1,1,203,95,77,'Bahri Sinulingga','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631252',1,1,203,95,77,'Heri Yusup','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096711638',1,1,203,95,77,'Santiaji Gunawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088631248',1,1,203,95,77,'Nella Andaryati','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099651761',1,1,203,95,77,'Agus Iskandar','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0088601214',1,1,203,95,77,'Harri Siswadi','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0089651343',1,1,203,95,77,'Sri Wahyuni','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0099731777',1,1,203,95,77,'Antonius Aris Sudjatmiko','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0004791936',1,1,203,95,77,'Widhi Astuti','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0003771895',1,1,203,95,77,'Meutia Prima','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0096711668',1,1,203,95,77,'Agung Hari Setiawan','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0007832308',1,1,203,95,77,'Melanton August Rahmanto','-','1','1',getdate(),28,7)
go
insert into R_PEGAWAI values ('0010832548',1,1,203,95,77,'Markus Aditya','-','1','1',getdate(),28,7)
go

insert into	__USER
select	NIPG
	,	'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b'
	,	'1'
from	R_PEGAWAI
where	ID_DIREKTORAT	= 7
go
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

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Grafik Tindak Lanjut Temuan Non 4-5 RCA'
,	5
,	'doc'
,	'reports/grafik_performance_rca_tl_temuan_non.jasper'
,	'year_1;year_2;year_3;month_1;month_2;month_3;id_dir;id_div'
,	'YEAR_1;YEAR_2;YEAR_3;MONTH_1;MONTH_2;MONTH_3;ID_DIR;ID_DIV'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'MoM Komite'
,	5
,	'doc'
,	'reports/mom_komite.jasper'
,	'id_rapat'
,	'ID_RAPAT'
)
go

insert into R_REPORT (
	NAMA_REPORT
,	KLASIFIKASI_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'MoM Sub Komite'
,	5
,	'doc'
,	'reports/mom_subkomite.jasper'
,	'id_rapat'
,	'ID_RAPAT'
)
go

update R_CSM_PERF_EVAL_SI set KETERANGAN = 'Di bawah Standar - <= 55' where ID = 1
go
update R_CSM_PERF_EVAL_SI set KETERANGAN = 'Cukup Memenuhi Standar - 55 s/d <= 75' where ID = 2
go
update R_CSM_PERF_EVAL_SI set KETERANGAN = 'Memenuhi Standar - > 75' where ID = 3
go
delete from R_CSM_PERF_EVAL_SI where ID = 4
go
delete from R_CSM_PERF_EVAL_SI where ID = 5
go

update R_CSM_PERF_EVAL_PS set NILAI_MIN = 0.0, NILAI_MAX = 55.0 where ID = 1
go
update R_CSM_PERF_EVAL_PS set NILAI_MIN = 55.1, NILAI_MAX = 75.0, KETERANGAN = 'Sertifikat Keterangan Baik' where ID = 2
go
update R_CSM_PERF_EVAL_PS set NILAI_MIN = 75.1, NILAI_MAX = 100.0, KETERANGAN = 'Penghargaan' where ID = 3
go
delete from R_CSM_PERF_EVAL_PS where ID = 4
go

alter table T_CSM_PROYEK drop constraint FK__T_CSM_PRO__WORK___46D27B73
go
alter table T_CSM_PROYEK drop column WORK_LEVEL
go

drop table R_CSM_PROJECT_WORK_LEVEL
go

drop table T_CSM_PROYEK_KONT_EVAL_NILAI
go

drop table R_CSM_PERF_EVAL
go

drop table R_CSM_PERF_EVAL_SI
go

create table R_CSM_PERF_EVAL_SI(
	ID                   int                  identity,
	MIN                  float                not null default 0.0,
	MAX                  float                not null default 0.0,
	KETERANGAN           varchar(512)         not null,
	constraint PK_R_CSM_PERF_EVAL_SI primary key (ID)
)
go

alter table T_CSM_PROYEK drop constraint DF__T_CSM_PRO__EVAL___6991A7CB
go
alter table T_CSM_PROYEK drop column EVAL_WEIGHTED_SCORE
go
alter table T_CSM_PROYEK drop constraint DF__T_CSM_PRO__EVAL___689D8392
go
alter table T_CSM_PROYEK drop column EVAL_RAW_SCORE
go
alter table T_CSM_PROYEK add EVAL_SCORE float not null default 0.0
go

create table T_CSM_PROYEK_KONT_EVAL_NILAI(
	ID_PROJECT           bigint               not null,
	ID_PENILAIAN         int                  not null,
	NILAI                smallint             not null,
	KETERANGAN           varchar(512)         not null,
	constraint PK_T_CSM_PROYEK_KONT_EVAL_NILA primary key (ID_PROJECT, ID_PENILAIAN)
)
go

alter table T_CSM_PROYEK_KONT_EVAL_NILAI
	add constraint FK_T_CSM_PROYEK_T_CSM_PROYEK_KONT_EVAL_NILAI foreign key (ID_PROJECT)
		references T_CSM_PROYEK (ID_PROJECT)
go

alter table T_CSM_PROYEK_KONT_EVAL_NILAI
	add constraint FK_R_CSM_PENILAIAN_T_CSM_PROYEK_KONT_EVAL_NILAI foreign key (ID_PENILAIAN)
		references R_CSM_PENILAIAN (ID)
go

update __MENU set MENU_NAME = 'Status Pekerjaan (Komite)', MENU_FOLDER = 'sfm_task_progress_kom', ICON = '' where MENU_ID = '05.05'
go
update __MENU set MENU_NAME = 'MoM Komite', MENU_FOLDER = 'sfm_mom_komite' where MENU_ID = '05.06'
go
insert into __MENU values ('05.07', 'MoM Sub-Komite', 'sfm_mom_sub_komite', '1', 2, '05', 'report')
go

insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC,ID_DIREKTORAT,ID_DIVPROSBU, ID_USER) values ('CSC SBU-2',3,null, '1')
go
insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC,ID_DIREKTORAT,ID_DIVPROSBU, ID_USER) values ('CSC SBU-3',3,null, '1')
go
insert into R_KEL_JABATAN_CSC (NAMA_KEL_JABATAN_CSC,ID_DIREKTORAT,ID_DIVPROSBU, ID_USER) values ('CSC SBU TSJ',3,null, '1')
go

insert into __GRUP_USER (nama_grup, keterangan_grup) values ('Grup Administrator Divisi/Proyek/SBU', 'Administrator Divisi/Proyek/SBU')
go

insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.04',0)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.05',0)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.06',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.07',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'01.08',0)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.04',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.05',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.06',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.07',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.08',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.09',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.10',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.11',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.12',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.13',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.14',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.15',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.16',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'02.17',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'03.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'03.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'03.03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'03.04',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'03.05',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'03.06',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'04',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'04.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'04.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'04.03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'04.04',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05.03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05.04',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05.05',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05.06',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'05.07',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06.03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06.04',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06.05',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06.06',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'06.07',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07.03',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07.04',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07.05',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07.06',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'07.07',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'08',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'08.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'08.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'09',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'09.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'09.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'23',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'23.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'23.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'24',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'24.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'24.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'25',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'25.01',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'25.02',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'26',4)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (9,'26.01',4)
go

insert into __hak_akses (id_grup, menu_id, ha_level) values (1,'05.07',4)
go

insert into __hak_akses (id_grup, menu_id, ha_level) values (3,'05.07',3)
go
insert into __hak_akses (id_grup, menu_id, ha_level) values (4,'05.07',3)
go

insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'Koordinator Pelaksana Proyek', 2, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'SBU II', 3, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'SBU III', 3, '1')
go
insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, STATUS_DIVPROSBU, ID_USER) values (3, 'SBU Transmisi Sumatera-Jawa', 3, '1')
go

insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 29, 'Bagian Pengendalian Kerja', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 29, 'Kelompok Hukum', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 29, 'Proyek 1', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 29, 'Proyek 2', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 29, 'Proyek 3', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 29, 'Keuangan dan Administrasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 30, 'Pengendalian Kinerja dan Hukum', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 30, 'Penjualan dan Layanan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 30, 'Operasi dan Pemeliharaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 30, 'Integritas Jaringan dan K3PL', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 30, 'Enjiniring dan Pembangunan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 30, 'Keuangan dan SDM', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 30, 'Logistik dan Administrasi Umum', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 31, 'Penjualan dan Layanan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 31, 'Operasi dan Pemeliharaan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 31, 'Integritas Jaringan dan K3PL', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 31, 'Enjiniring dan Pembangunan', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 31, 'Keuangan dan SDM', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 31, 'Logistik dan Administrasi Umum', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 31, 'Pengendalian Kinerja dan Hukum', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 32, 'K3PL', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 32, 'Pengendalian Kinerja dan Hukum', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 32, 'Operasi', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 32, 'Enjiniring', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 32, 'Keuangan dan SDM', '1')
go
insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (3, 32, 'Logistik dan Administrasi Umum', '1')
go

insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 78, 'Dinas Bagian Pengendalian Kerja', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 79, 'Dinas Kelompok Hukum', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 80, 'Dinas Konstruksi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 80, 'Dinas QA-QC dan K3PL', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 80, 'Dinas Administrasi Kontrak', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 80, 'Dinas Perizinan dan Pertahanan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 81, 'Dinas Konstruksi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 81, 'Dinas QA-QC dan K3PL', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 81, 'Dinas Administrasi Kontrak', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 81, 'Dinas Perizinan dan Pertahanan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 82, 'Dinas Konstruksi', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 82, 'Dinas QA-QC dan K3PL', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 82, 'Dinas Administrasi Kontrak', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 82, 'Dinas Perizinan dan Pertahanan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 83, 'Dinas Keuangan dan Administrasi Proyek 1', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 83, 'Dinas Keuangan dan Administrasi Proyek 2', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 29, 83, 'Dinas Keuangan dan Administrasi Proyek 3', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 84, 'Pengendalian Kinerja', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 84, 'Hukum dan Humas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 85, 'Dispatching Center', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 85, 'Perencanaan Penjualan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 85, 'Penjualan dan Layanan Area Surabaya', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 85, 'Penjualan dan Layanan Area Sidoarjo-Mojokerto', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 85, 'Penjualan dan Layanan Area Pasuruan-Probolinggo', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 86, 'Sistem Manajemen Gas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 86, 'Operasi dan Pemeliharaan Wilayah I', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 86, 'Operasi dan Pemeliharaan Wilayah II', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 86, 'Workshop', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 87, 'Integritas Jaringan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 87, 'K3PL', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 88, 'Perencanaan dan Layanan Enjiniring', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 88, 'Pembangunan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 89, 'Keuangan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 89, 'SDM', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 90, 'Logistik', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 30, 90, 'Administrasi Umum', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 91, 'Dispatching Center', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 91, 'Perencanaan Penjualan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 91, 'Penjualan dan Layanan Area Medan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 91, 'Penjualan dan Layanan Area Batam', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 91, 'Penjualan dan Layanan Area Pekanbaru', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 92, 'Sistem Manajemen Gas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 92, 'Operasi dan Pemeliharaan Wilayah I', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 92, 'Operasi dan Pemeliharaan Wilayah II', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 92, 'Workshop', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 93, 'Integritas Jaringan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 93, 'K3PL', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 94, 'Perencanaan dan Layanan Enjiniring', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 94, 'Pembangunan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 95, 'Keuangan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 95, 'SDM', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 96, 'Logistik', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 96, 'Administrasi Umum', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 97, 'Pengendalian Kinerja', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 31, 97, 'Hukum dan Humas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 98, 'Keselamatan dan Kesehatan Kerja', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 98, 'Pengelolaan Lingkungan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 99, 'Pengendalian Kinerja', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 99, 'Hukum dan Humas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 100, 'Manajemen Transportasi Gas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 100, 'Operasi dan Pemeliharaan Wilayah I', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 100, 'Operasi dan Pemeliharaan Wilayah II', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 100, 'Operasi dan Pemeliharaan Wilayah III', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 101, 'Perencanaan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 101, 'Integritas Jaringan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 101, 'Integritas Fasilitas', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 102, 'Keuangan', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 102, 'SDM', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 103, 'Logistik', '1')
go
insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (3, 32, 103, 'Administrasi Umum', '1')
go

insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 78, 96, 1, 'Seksi Bagian Pengendalian Kinerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 79, 97, 1, 'Seksi Kelompok Hukum', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 80, 98, 1, 'Seksi Konstruksi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 80, 99, 1, 'Seksi QA-QC dan K3PL', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 80, 100, 1, 'Seksi Administrasi Kontrak', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 80, 101, 1, 'Seksi Perizinan dan Pertahanan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 81, 102, 1, 'Seksi Konstruksi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 81, 103, 1, 'Seksi QA-QC dan K3PL', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 81, 104, 1, 'Seksi Administrasi Kontrak', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 81, 105, 1, 'Seksi Perizinan dan Pertahanan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 82, 106, 1, 'Seksi Konstruksi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 82, 107, 1, 'Seksi QA-QC dan K3PL', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 82, 108, 1, 'Seksi Administrasi Kontrak', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 82, 109, 1, 'Seksi Perizinan dan Pertahanan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 83, 110, 1, 'Seksi Keuangan dan Administrasi Proyek 1', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 83, 111, 1, 'Seksi Keuangan dan Administrasi Proyek 2', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 29, 83, 112, 1, 'Seksi Keuangan dan Administrasi Proyek 3', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 84, 113, null, 'Seksi Pengendalian Kinerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 84, 114, null, 'Seksi Hukum dan Humas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 115, null, 'Seksi Dispatching Center', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 116, null, 'Seksi Perencanaan Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 117, null, 'Account Executive Rumah Tangga dan Komersial', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 117, null, 'Account Executive Industri', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 117, null, 'Layanan Teknis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 117, null, 'Administrasi Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 118, null, 'Account Executive Rumah Tangga dan Komersial', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 118, null, 'Account Executive Industri', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 118, null, 'Layanan Teknis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 118, null, 'Administrasi Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 119, null, 'Account Executive', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 119, null, 'Layanan Teknis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 85, 119, null, 'Administrasi Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 86, 120, null, 'Seksi Sistem Manajemen Gas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 86, 121, null, 'Operasi dan Pemeliharaan Sub-Wil. Surabaya I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 86, 121, null, 'Operasi dan Pemeliharaan Sub-Wil. Surabaya II', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 86, 122, null, 'Operasi dan Pemeliharaan Sub-Wil. Sidoarjo-Mojokerto', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 86, 122, null, 'Operasi dan Pemeliharaan Sub-Wil. Pasuruan-Probolinggo', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 86, 123, null, 'Seksi Workshop', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 87, 124, null, 'Manajemen Informasi Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 87, 124, null, 'Assesmen Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 87, 125, null, 'Keselamatan dan Kesehatan Kerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 87, 125, null, 'Pengelolaan Lingkungan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 88, 126, null, 'Perencanaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 88, 126, null, 'Layanan Enjiniring', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 88, 127, null, 'Kelompok Pelaksanaan Pembangunan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 88, 127, null, 'Pengendalian Pembangunan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 89, 128, null, 'Anggaran', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 89, 128, null, 'Perbendaharaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 89, 128, null, 'Akuntansi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 89, 129, null, 'Pembinaan dan Pengembangan SDM', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 89, 129, null, 'Renumerasi dan Hubungan Industrial', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 90, 130, null, 'Kelompok Pengadaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 90, 130, null, 'Administrasi Logistik', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 90, 130, null, 'Persediaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 90, 131, null, 'Layanan Umum dan Pengamanan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 30, 90, 131, null, 'Teknologi Informasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 132, null, 'Seksi Dispatching Center', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 133, null, 'Seksi Perencanaan Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 134, null, 'Account Executive Rumah Tangga dan Komersial I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 134, null, 'Account Executive Rumah Tangga dan Komersial II', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 134, null, 'Account Executive Industri I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 134, null, 'Account Executive Industri II', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 134, null, 'Layanan Teknis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 134, null, 'Administrasi Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 135, null, 'Account Executive I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 135, null, 'Account Executive II', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 135, null, 'Layanan Teknis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 135, null, 'Administrasi Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 136, null, 'Layanan Teknis', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 91, 136, null, 'Administrasi Penjualan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 92, 137, null, 'Seksi Sistem Manajemen Gas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 92, 138, null, 'Operasi dan Pemeliharaan Sub-Wil. Medan I', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 92, 138, null, 'Operasi dan Pemeliharaan Sub-Wil. Medan II', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 92, 139, null, 'Operasi dan Pemeliharaan Sub-Wil. Batam', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 92, 139, null, 'Operasi dan Pemeliharaan Sub-Wil. Pekanbaru', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 92, 140, null, 'Seksi Workshop', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 93, 141, null, 'Manajemen Informasi Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 93, 141, null, 'Asesmen Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 93, 142, null, 'Keselamatan dan Kesehatan Kerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 93, 142, null, 'Pengelolaan Lingkungan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 94, 143, null, 'Perencanaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 94, 144, null, 'Kelompok Pelaksanaan Pembangunan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 94, 144, null, 'Pengendalian Pembangunan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 95, 145, null, 'Anggaran', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 95, 145, null, 'Perbendaharaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 95, 145, null, 'Akuntansi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 95, 146, null, 'Pembinaan dan Pengembangan SDM', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 95, 146, null, 'Remunerisasi dan Hubungan Industrial', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 96, 147, null, 'Kelompok Pengadaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 96, 147, null, 'Administrasi Logistik', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 96, 147, null, 'Persediaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 96, 148, null, 'Layanan Umum dan Pengamanan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 96, 148, null, 'Teknologi Informasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 97, 149, null, 'Seksi Pengendalian Kerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 31, 97, 150, null, 'Seksi Hukum dan Humas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 98, 151, null, 'Seksi K3PL', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 98, 152, null, 'Seksi Pengelolaan Lingkungan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 99, 153, null, 'Seksi Pengendalian Kinerja', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 99, 154, null, 'Seksi Hukum dan Humas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 155, null, 'Manajemen Data', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 155, null, 'Scada dan Telekomunikasi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 155, null, 'Gas Kontrol', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 156, null, 'Operasi dan Pemeliharaan Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 156, null, 'Operasi dan Pemeliharaan Fasilitas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 156, null, 'Kompresor', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 156, null, 'Layanan Umum', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 157, null, 'Operasi dan Pemeliharaan Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 157, null, 'Operasi dan Pemeliharaan Fasilitas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 157, null, 'Layanan Umum', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 158, null, 'Operasi dan Pemeliharaan Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 158, null, 'Operasi dan Pemeliharaan Fasilitas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 100, 158, null, 'Layanan Umum', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 101, 159, null, 'Perencanaa Umum', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 101, 159, null, 'Pengendalian Perencanaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 101, 160, null, 'Enjiniring Jaringan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 101, 160, null, 'Jasa Teknik', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 101, 161, null, 'Enjiniring Fasilitas', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 101, 161, null, 'Enjiniring Kompresor', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 102, 162, null, 'Anggaran', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 102, 162, null, 'Perbendaharaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 102, 162, null, 'Akuntansi', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 102, 163, null, 'Pembinaan dan Pengembangan SDM', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 102, 163, null, 'Remunerasi dan Hubungan Industrial', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 103, 164, null, 'Kelompok Pengadaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 103, 164, null, 'Administrasi Logistik', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 103, 164, null, 'Persediaan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 103, 165, null, 'Layanan Umum dan Pengamanan', '1')
go
insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (3, 32, 103, 165, null, 'Teknologi Informasi', '1')
go

insert into R_REPORT (
	NAMA_REPORT
,	TIPE_REPORT
,	FILE_LOCATION
,	WEB_PARAMS
,	REPORT_PARAMS
)
values (
	'Laporan Unjuk Kerja'
,	'xls'
,	'reports/lap_unjuk_kerja.jasper'
,	'month;year;id_dir;id_div'
,	'MONTH;YEAR;ID_DIR;ID_DIV'
)
go

delete from T_PSSR_REFERENCE;
delete from T_PSSR_KEANGGOTAAN;
delete from T_PSSR_DETAIL;
delete from T_PSSR;

delete R_ITEM_DETAIL_PSSR where ID_ITEM_DETAIL_PSSR is not null;
delete R_ITEM_PSSR where ID_ITEM_PSSR is not null;
delete R_KATEGORI_ITEM_PSSR where ID_KATEGORI_ITEM_PSSR is not null;

DBCC CHECKIDENT('R_ITEM_DETAIL_PSSR', RESEED, 0);
DBCC CHECKIDENT('R_ITEM_PSSR', RESEED, 0);
DBCC CHECKIDENT('R_KATEGORI_ITEM_PSSR', RESEED, 0);

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('ORGANISASI DAN PERSONIL','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (1, 'Struktur Organisasi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Adakah jumlah personil mencukupi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Adakah pihak terkait sudah terlibat dan bertanggung  jawab sesuai fungsinya', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Adakah pembagian tugas di dalam tim dan dipahami', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (1, 1, 'Adakah daftar nomor telepon yang dapat dihubungi', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (1, 'Personil Pendukung', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah Petugas Pemadam Kebakaran', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah Tenaga Medis', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah melibatkan Petugas Keamanan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah saksi oleh perwakilan dari Migas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (2, 1, 'Adakah PMC', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('FISIK DAN PERALATAN','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (2, 'FISIK', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah kondisi Test Box baik dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Sistem Proteksi Katodik berfungsi dengan baik (min -850 mVolt)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Insulating Joint pipa cabang berkondisi baik dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Marker Post lengkap dan kondisinya baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Jembatan ada dan kondisinya baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Patok Gas ada dan kondisinya baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Venting Valve sudah dipasang sesuai dengan kebutuhan untuk gas in dan apakah kondisinya baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Regulator MR/S kondisinya baik dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah filter kondisinya baik dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah shut off valve kondisinya baik dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah relief valve MR/S sudah terpasang sesuai dengan kebutuhan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah check valve MR/S sudah terpasang dan berfungsi dengan baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah instrumentasi (manometer, meter dan volume corrector, dll.) berfungsi dengan baik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Insulating Joint MR/S kondisinya baik dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah Valve kondisinya baik (tidak bocor) dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (3, 2, 'Apakah bak valve pada kondisi yang baik dan sesuai standar', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (2, 'PERALATAN', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Multi Gas Detector tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Genset tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Lampu Penerangan tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Pompa Air tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Tool Set Non Spark tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Spool set untuk venting tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Exhaust Fan tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Alat Komunikasi (Radio) tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Pressure Gauge tersedia dan berfungsi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (4, 2, 'Adakah Tang Ampere tersedia dan berfungsi', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('FIRE DAN SAFETY','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (3, 'FIRE', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah gas inlet berdekatan dengan sumber api', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah gas outlet berdekatan dengan sumber api', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah ada pengaman/isolasi dari sumber api', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah tersedia Alat Pemadam: APAR', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah tersedia Alat Pemadam: Mobil Pemadam', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah sudah dilakukan koordinasi dengan otoritas pemadam kebakaran setempat: Fungsi Fire Safety Pelanggan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (5, 3, 'Apakah sudah dilakukan koordinasi dengan otoritas pemadam kebakaran setempat: Dinas Pemadam Kebakaran', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (3, 'SAFETY', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Apakah APD Personil tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Apakah Ambulance tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Apakah sudah disediakan rambu-rambu pengaman: Barikade', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Apakah sudah disediakan rambu-rambu pengaman: Traffic Cone', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Apakah sudah disediakan rambu-rambu pengaman: Traffic Lamp', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Apakah sudah disediakan rambu-rambu pengaman: Marker Line', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (6, 3, 'Apakah sudah disediakan rambu-rambu pengaman: Rambu Gas In', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('SYSTEM','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah sudah dilakukan koordinasi dengan GMC', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (7, 4, 'Sebelum Gas In / Hottaping', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (7, 4, 'Proses Gas In / Hottaping', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (7, 4, 'Sesudah Gas In / Hottaping', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah tersedia Dokumen Teknis sebagai berikut', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'As Built Drawing / Gambar Kerja', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'SAT MR/S dan Valve Report (Site Acceptance Test)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'BA Pengujian Proteksi Katodik', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Sertifikat Insulating Joint', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Sertifikat Test Valve', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Berita Acara Hydrotest', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'NDT Report', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Holiday Test Report', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Berita Acara N2 Purging', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'MOC', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'PHA', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Wall Thickness Test dalam rangka Hot Tapping', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'MIGAS Approval dalam rangka Hot Tapping', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'WPS', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Sertifikat Welder', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (8, 4, 'Sertifikat pabrikan MR/S', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah Prosedur Gas In / Hottaping tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (9, 4, 'Apakah Prosedur Gas In / Hottaping tersedia', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah ERP (Emergency Respons Plan) tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (10, 4, 'Apakah ERP (Emergency Respons Plan) tersedia', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah JSA (Job Safety Analisys) tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (11, 4, 'Apakah JSA (Job Safety Analisys) tersedia', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah Izin Kerja tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Panas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Dingin', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Memasuki Ruang Terbatas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (12, 4, 'Izin Kerja Galian', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (4, 'Apakah SIMI (Surat Izin Masuk Instalasi) tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (13, 4, 'Apakah SIMI (Surat Izin Masuk Instalasi) tersedia', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('ADDITIONAL CHECKLIST (diperiksa ketersediaannya dan kondisinya)','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'PROSES', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'Design Basis', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'P & ID', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'MOC', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'PHA (Process Hazard Analysis)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'ESD Function (Emergency Shut Down)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (14, 5, 'Venting sistem', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'MECHANICAL', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Bolt and Nut', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Tagging', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'LOTO', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Piping Support', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Plat form', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Tangga', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (15, 5, 'Cat Pipa', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'ELECTRICAL', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Cable Tray', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Junction Box', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Grounding', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Wiring Diagram', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Wiring system ( Instrumentation and Electrical )', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Cable Gland', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Lighting', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (16, 5, 'Lightning Protection', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (5, 'CIVIL', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Pondasi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Bak Valve', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Road (Escape Path)', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Gate / Door', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Muster Point', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Lighting Protection', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Kios / Rumah MRS', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (17, 5, 'Bangunan', '1');

insert into R_KATEGORI_ITEM_PSSR (NAMA_KATEGORI_ITEM_PSSR, ID_USER) values ('INSTALASI PELANGGAN','1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah Pelanggan mempunyai PSSR', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (18, 6, 'Apakah Pelanggan mempunyai PSSR', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah Prosedur Gas In tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (19, 6, 'Apakah Prosedur Gas In tersedia', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah Prosedur ERP tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (20, 6, 'Apakah Prosedur ERP tersedia', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah JSA (Job Safety Analysis) tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (21, 6, 'Apakah JSA (Job Safety Analysis) tersedia', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah Dokumen Teknis tersedia', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Berita Acara Pemeriksaan Material', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Laporan Harian, Mingguan, Bulanan', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'NDT Report', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Berita Acara Pengujian Ball Valve', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Berita Acara Pengetesan Pipa Instalasi', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Berita Acara Flushing', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'Berita Acara Pengisian Nitrogen', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (22, 6, 'As Built Drawing', '1');
insert into R_ITEM_PSSR (ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_PSSR, ID_USER) values (6, 'Apakah sudah tersedia peralatan Gas', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (23, 6, 'Peralatan dual Fuel System', '1');
insert into R_ITEM_DETAIL_PSSR (ID_ITEM_PSSR, ID_KATEGORI_ITEM_PSSR, NAMA_ITEM_DETAIL_PSSR, ID_USER) values (23, 6, 'Peralatan Single Fuel System', '1');

create table R_CSM_PENILAIAN2 (
	ID		int identity (1,1)	not null
,	ELEMEN	varchar (1024)		not null
,	NILAI	int					not null default 0
,	constraint R_CSM_PENILAIAN2_PK primary key (id)
);

create table R_CSM_PENILAIAN2_DETAIL (
	ID				int identity (1,1)	not null
,	ID_PENILAIAN	int					not null
,	ELEMEN			varchar (1024)		default '-'
,	constraint r_cms_penilaian2_detail_pk primary key (id)
,	constraint r_csm_penilaian2_detail_fk_csm_penilaian foreign key (id_penilaian) references r_csm_penilaian2 (id)
);

create table R_CSM_PENILAIAN2_DETAIL2 (
	ID				int identity (1,1)	not null
,	ID_PENILAIAN	int					not null
,	ID_DETAIL		int					not null
,	ELEMEN			varchar (1024) default '-'
,	constraint r_csm_penilaian2_detail2_pk primary key (id)
,	constraint r_csm_penilaian2_detail2_fk_csm_penilaian2 foreign key (id_penilaian) references r_csm_penilaian2 (id)
,	constraint r_csm_penilaian2_detail2_fk_penilaian2_detail foreign key (id_detail) references r_csm_penilaian2_detail (id)
);

create table R_CSM_PENILAIAN2_PENILAIAN (
	ID				int identity (1,1)	not null
,	ID_PENILAIAN	int					not null
,	ID_DETAIL		int					not null
,	ID_DETAIL2		int					not null
,	PENILAIAN		varchar (1024)		not null
,	NILAI			int					not null default 0
,	constraint r_csm_penilaian2_penilaian_pk primary key (id)
,	constraint r_csm_penilaian2_penilaian_fk_csm_penilaian2 foreign key (id_penilaian) references r_csm_penilaian2 (id)
,	constraint r_csm_penilaian2_penilaian_fk_penilaian2_detail foreign key (id_detail) references r_csm_penilaian2_detail (id)
,	constraint r_csm_penilaian2_penilaian_fk_penilaian2_detail2 foreign key (id_detail2) references r_csm_penilaian2_detail2 (id)
);

create table T_CSM_PROYEK_KONTRAKTOR2 (
	ID_PROJECT			bigint
,	ID_KONTRAKTOR		bigint
,	TANGGAL				date default current_timestamp
,	JENIS_PEKERJAAN		varchar (512) not null default ''
,	TEMPAT_KONSTRUKSI	varchar (512) not null default ''
,	TOTAL_NILAI			float not null default 0.0
,	KETERANGAN			varchar (64) not null default 'Tidak Lulus'
,	constraint t_csm_proyek_kontraktor2_pk primary key (id_project)
,	constraint t_csm_proyek_kontraktor2_fk_csm_proyek foreign key (id_project) references t_csm_proyek (id_project)
,	constraint t_csm_proyek_kontraktor2_fk_kontraktor foreign key (id_kontraktor) references r_kontraktor (id)
);

/* add columne PASSING_GRADE to table T_CSM_PROYEK */
alter table t_csm_proyek add PASSING_GRADE float not null default 50;

delete R_CSM_PENILAIAN2_PENILAIAN where ID is not null;
delete R_CSM_PENILAIAN2_DETAIL2 where ID is not null;
delete R_CSM_PENILAIAN2_DETAIL where ID is not null;
delete R_CSM_PENILAIAN2 where ID is not null;

DBCC CHECKIDENT('R_CSM_PENILAIAN2_PENILAIAN', RESEED, 0);
DBCC CHECKIDENT('R_CSM_PENILAIAN2_DETAIL2', RESEED, 0);
DBCC CHECKIDENT('R_CSM_PENILAIAN2_DETAIL', RESEED, 0);
DBCC CHECKIDENT('R_CSM_PENILAIAN2', RESEED, 0);

insert into R_CSM_PENILAIAN2			values ('IMPLEMENTASI DAN PEMANTAUAN KINERJA K3 PERUSAHAAN', 10);
insert into R_CSM_PENILAIAN2_DETAIL		values (1, '-');
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Apakah tersedia data kinerja K3 Kontraktor untuk 3 tahun terakhir?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 1, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 1, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Data jumlah jam kerja pegawai');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 2, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 2, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Data jumlah kilometer kendaraan yang dipakai');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 3, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 3, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Data jumlah kematian karena kecelakaan kerja');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 4, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 4, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Data jumlah kecelakaan yang menyebabkan kehilangan hari kerja');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 5, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 5, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Data jumlah kecelakaan yang tercatat');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 6, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 6, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Data jumlah kecelakaan kendaraan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 7, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 7, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (1, 1, 'Apakah Perusahaan anda pernah dituntut atau sedang dituntut pengadilan terkait dengan insiden K3 atau tidak mematuhi ketentuan K3?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 8, 'Ya', 0);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (1, 1, 8, 'Tidak', 1);

insert into R_CSM_PENILAIAN2			values ('ORGANISASI DAN KOMITMEN', 10);
insert into R_CSM_PENILAIAN2_DETAIL		values (2, '-');
insert into R_CSM_PENILAIAN2_DETAIL2	values (2, 2, 'Bentuk pelaporan tugas dan tanggung jawab K3');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 9, 'Langsung kepada BOD', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 9, 'Tidak bertanggung jawab langsung kepada BOD', 1);
insert into R_CSM_PENILAIAN2_DETAIL2	values (2, 2, 'Bentuk visi dan misi K3 dalam Perusahaan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 10, 'Ada bentuk pernyataan', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 10, 'Tidak ada bentuk pernyataan', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (2, 2, 'Cara internalisasi K3 dalam Perusahaan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 11, 'Hari K3', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 11, 'Poster K3', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 11, 'HSE Board', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 11, 'Penghargaan K3', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 11, 'Warning Sign', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 11, 'Banner K3', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (2, 2, 11, 'Komitmen bersama', 1);

insert into R_CSM_PENILAIAN2			values ('PROGRAM KERJA SECARA TERTULIS', 7);
insert into R_CSM_PENILAIAN2_DETAIL		values (3, '-');
insert into R_CSM_PENILAIAN2_DETAIL2	values (3, 3, 'Metodologi K3 pekerjaan spesifik');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 12, 'Lengkap', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 12, 'Kurang Lengkap', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 12, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (3, 3, 'Implementasi pelaksanaan pekerjaan sesuai dengan analisa keselamatan kerja dan izin kerja');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 13, 'Lengkap', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 13, 'Kurang Lengkap', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 13, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (3, 3, 'Pengawasan terhadap pelaksanaan pekerjaan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 14, 'Baik', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 14, 'Tidak Baik', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (3, 3, 'Koordinasi pelaksanaan pekerjaan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 15, 'Baik', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 15, 'Tidak Baik', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (3, 3, 'Pengelolaan Lingkungan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 16, 'Baik', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 16, 'Tidak Baik', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (3, 3, 'Pelaporan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 17, 'Lengkap', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 17, 'Kurang Lengkap', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (3, 3, 17, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2			values ('SUMBER DAYA MANUSIA, STANDAR DAN DOKUMENTASI', 15);
insert into R_CSM_PENILAIAN2_DETAIL		values (4, 'A. Tenaga Profesional');
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 4, 'Ketersediaan tenaga profesional dalam pelaksanaan pekerjaan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 18, 'Cukup', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 18, 'Kurang', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 18, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 4, 'Status kepegawaian dari tenaga profesional');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 19, 'Tetap', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 19, 'Tidak Tetap', 1);
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 4, 'Pengalaman kerja tenaga profesional (dalam 3 tahun terakhir)');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 20, 'Ada (Lampirkan Riwayat Kerja)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 20, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 4, 'Sertifikasi keteknikan yang dimiliki');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 21, 'Ada (Sebutkan masa berlakunya)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 21, 'Tidak Ada', 0);
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 4, 'Sertifikasi khusus Pelatihan Managerial');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 22, 'Ada (Lampirkan sertifikat)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 4, 22, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2_DETAIL		values (4, 'B. Kompetensi dan Pelatihan pada Manager/Supervisor/Staf/Penasehat K3PL');
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 5, 'Rencana pelatihan yang akan diberikan sebelum melaksanakan pekerjaan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 5, 23, 'Ada (Lampirkan silabus)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 5, 23, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 5, 'Apakah ada kebijakan K3 Perusahaan dalam pelaksanaan pekerjaan yang akan dilakukan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 5, 24, 'Ada', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 5, 24, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 5, 'Bagaimana implementasi kebijakan K3 Perusahaan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 5, 25, 'Ada (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 5, 25, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2_DETAIL		values (4, 'C. Pelatihan Khusus');
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 6, 'Apakah sebelum pelaksanaan pekerjaan dilakukan pelatihan identifikasi bahaya?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 6, 26, 'Ya (Lampirkan daftar / list bahaya)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 6, 26, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 6, 'Apakah para pekerja diberikan pelatihan analisa keselamatan kerja terhadap identifikasi bahaya sebelum melaksanakan pekerjaan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 6, 27, 'Ya (Lampirkan bukti pelatihan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 6, 27, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 6, 'Apakah Perusahaan anda memberikan pelatihan tambahan kepada para pekerja?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 6, 28, 'Fire fighting', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 6, 28, 'First Aid', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 6, 28, 'Lainya (Sebutkan)', 1);

insert into R_CSM_PENILAIAN2_DETAIL		values (4, 'D. Standar Yang Digunakan');
insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 7, 'Bagaimana metode Perusahaan untuk memenuhi standar pekerjaan yang akan dilakukan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 29, 'Ada (Jelaskan metode yang digunakan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 29, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 7, 'Cara yang digunakan oleh Perusahaan untuk memastikan standar-standar dipenuhi dan diperiksa?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 30, 'Observasi', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 30, 'Inspeksi yang dilakukan', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 30, 'Check list', 1);

insert into R_CSM_PENILAIAN2_DETAIL2	values (4, 7, 'Bagaimana cara Perusahaan memastikan bahwa standar yang digunakan dipahami oleh para pekerja?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 31, 'Surat edaran', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 31, 'Email', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 31, 'Pelatihan', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 31, 'Rapat / tool box meeting', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (4, 7, 31, 'Diskusi formal', 1);

insert into R_CSM_PENILAIAN2			values ('PROSEDUR OPERASI (PO) DAN INSTRUKSI KERJA (IK) K3', 10);
insert into R_CSM_PENILAIAN2_DETAIL		values (5, '-');
insert into R_CSM_PENILAIAN2_DETAIL2	values (5, 8, 'Metode yang digunakan Perusahaan untuk memastikan bahwa  PO dan IK yang digunakan oleh pekerja di lapangan konsisten dengan Izin Kerja yang diberikan? (lampirkan formulir masing-masing yang sudah diterapkan)');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 32, 'Observasi', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 32, 'Audit', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 32, 'Pengawasan secara berkala', 1);

insert into R_CSM_PENILAIAN2_DETAIL2	values (5, 8, 'Apakah Perusahaan mempunyai buku panduan K3 dalam pelaksanaan pekerjaan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 33, 'Ya (Lampirkan dokumen)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 33, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (5, 8, 'Bagaimana Perusahaan memastikan bahwa PO dan IK sesuai dengan pekerjaan yang akan dilaksanakan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 34, 'Perbaikan secara berkala', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 34, 'Mengikuti standar edisi terakhir', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 34, 'Internalisasi secara berkala', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 34, 'Pemeriksaan ketersediaan dokumen', 1);

insert into R_CSM_PENILAIAN2_DETAIL2	values (5, 8, 'Apakah Perusahaan mempunyai metode untuk perubahan terhadap dokumen PO dan IK?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 35, 'Ada (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (5, 8, 35, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2			values ('PERALATAN DAN PERLENGKAPAN', 10);
insert into R_CSM_PENILAIAN2_DETAIL		values (6, 'A. Pengawasan dan Perawatan Peralatan');
insert into R_CSM_PENILAIAN2_DETAIL2	values (6, 9, 'Apakah Perusahaan memiliki metode untuk memastikan bahwa peralatan yang digunakan di wilayah kerja didaftarkan dan disertifikasi?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 36, 'Ada (Lampirkan dokumen traceability)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 36, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (6, 9, 'Bagaimana Perusahaan memastikan bahwa peralatan yang akan digunakan terawat dengan benar dan siap untuk digunakan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 37, 'Jadwal Pemeliharaan', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 37, 'Sejarah Pemeliharaan', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 37, 'Stok suku cadang penggantian', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 37, 'Teknisi pekerja tersedia', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 37, 'Tersedia tools pemeliharaan', 1);

insert into R_CSM_PENILAIAN2_DETAIL2	values (6, 9, 'Apakah Perusahaan mempunyai pengawasan atas penggunaan peralatan dalam pelaksanaan pekerjaan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 38, 'Ya (Lampirkan format pengawasan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 38, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (6, 9, 'Bagaimana bentuk kepemilikan peralatan dalam pelaksanaan pekerjaan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 39, 'Seluruhnya milik sendiri', 3);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 39, 'Sebagian milik sendiri', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 9, 39, 'Seluruhnya sewa', 1);

insert into R_CSM_PENILAIAN2_DETAIL		values (6, 'B. Penanganan dan Perawatan Keselamatan Transportasi');
insert into R_CSM_PENILAIAN2_DETAIL2	values (6, 10, 'Apakah Perusahaan mempunyai aturan keselamatan dalam hal berkendaraan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 10, 40, 'Ada (Lampirkan dokumen)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 10, 40, 'Tidak Ada', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (6, 10, 'Apakah Perusahaan mempunyai metode perawatan berkala terhadap alat transportasi?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 10, 41, 'Ya (Lampirkan dokumen)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 10, 41, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (6, 10, 'Bagaimana bentuk kepemilikan alat transportasi dalam pelaksanaan pekerjaan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 10, 42, 'Seluruhnya milik sendiri', 3);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 10, 42, 'Sebagian milik sendiri', 2);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (6, 10, 42, 'Seluruhnya sewa', 1);

insert into R_CSM_PENILAIAN2			values ('PELAKSANAAN PEKERJAAN KHUSUS DAN SPESIFIK', 14);
insert into R_CSM_PENILAIAN2_DETAIL		values (7, 'A. Pelaksanaan Pekerjaan Khusus dan Spesifik Pada Jaringan Pipa Antara Lain:');
insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Metode penyambungan jaringan pipa eksisting');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 43, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 43, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Penggantian Kerangan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 44, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 44, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Boring atau Zingker');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 45, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 45, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Hot Tapping');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 46, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 46, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Perbaikan Bak Kerangan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 47, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 47, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Radiographi');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 48, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 48, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Kerusakan akibat pihak eksternal');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 49, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 49, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Modifikasi Kompresor');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 50, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 50, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Perbaikan Fiber Optik');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 51, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 51, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Gas in Perbaikan Jaringan Pipa');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 52, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 52, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Modifikasi Stasiun');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 53, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 53, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Perbaikan Bekas Galian');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 54, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 54, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Perbaikan Katodik');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 55, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 55, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 11, 'Perbaikan Akibat Kondisi Emergency');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 56, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 11, 56, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL		values (7, 'B. Pelaksanaan Pekerjaan Khusus dan Spesifik Pada Gedung Antara Lain:');
insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 12, 'Pembersihan Kaca Gedung');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 57, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 57, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 12, 'Perubahan Fungsi dan Peruntukan Bangunan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 58, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 58, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 12, 'Penilaian Kekuatan Bangunan');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 59, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 59, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (7, 12, 'Perbaikan Akibat Kondisi Emergency');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 60, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (7, 12, 60, 'Tidak', 0);

insert into R_CSM_PENILAIAN2			values ('PROSEDUR TANGGAP GAWAT DARURAT', 7);
insert into R_CSM_PENILAIAN2_DETAIL		values (8, '-');
insert into R_CSM_PENILAIAN2_DETAIL2	values (8, 13, 'Apakah Perusahaan mempunyai Prosedur tanggap gawat darurat?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 61, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 61, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (8, 13, 'Apakah prosedur tersebut sudah pernah diterapkan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 62, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 62, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (8, 13, 'Apakah dilakukan debriefing setelah pelaksanaan tanggap gawat?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 63, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 63, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (8, 13, 'Apakah Prosedur ini sudah dilakukan perbaikan < 1 tahun?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 64, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 64, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (8, 13, 'Apakah Perusahaan mempunyai jadual pelatihan secara berkala?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 65, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (8, 13, 65, 'Tidak', 0);

insert into R_CSM_PENILAIAN2			values ('ASURANSI TENAGA KERJA', 10);
insert into R_CSM_PENILAIAN2_DETAIL		values (9, '-');
insert into R_CSM_PENILAIAN2_DETAIL2	values (9, 14, 'Apakah Perusahaan sudah memiliki asuransi?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 66, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 66, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (9, 14, 'Apakah Perusahaan mengasuransikan para pekerja?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 67, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 67, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (9, 14, 'Apakah Perusahaan pernah mengklaim asuransi dalam kurun waktu < 1 tahun?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 68, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 68, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (9, 14, 'Apakah Perusahaan pernah mempunyai masalah terhadap klaim asuransi < 1 tahun?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 69, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 69, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (9, 14, 'Apakah Perusahaan pernah mempunyai tunggakan asuransi?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 70, 'Ya (Jelaskan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (9, 14, 70, 'Tidak', 0);

insert into R_CSM_PENILAIAN2			values ('AUDIT DAN PENGKAJIAN K3', 7);
insert into R_CSM_PENILAIAN2_DETAIL		values (10, '-');
insert into R_CSM_PENILAIAN2_DETAIL2	values (10, 15, 'Apakah Perusahaan mempunyai metode audit terhadap pekerjaan yang akan dilaksanakan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 71, 'Ya (Lampirkan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 71, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (10, 15, 'Apakah Perusahaan mempunyai standar audit pekerjaan aman?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 72, 'Ya (Lampirkan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 72, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (10, 15, 'Apakah Perusahaan mempunyai jadual audit? Dan berapa sering dilakukan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 73, 'Ya (Lampirkan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 73, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (10, 15, 'Apakah Perusahaan mempunyai auditor yang sudah tersertifikasi?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 74, 'Ya (Lampirkan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 74, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (10, 15, 'Apakah Perusahaan pernah merevisi metode audit terhadap suatu pekerjaan?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 75, 'Ya (Lampirkan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 75, 'Tidak', 0);

insert into R_CSM_PENILAIAN2_DETAIL2	values (10, 15, 'Apakah Perusahaan menetapkan maksimum waktu perbaikan atas temuan audit < 2 minggu?');
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 76, 'Ya (Lampirkan)', 1);
insert into R_CSM_PENILAIAN2_PENILAIAN	values (10, 15, 76, 'Tidak', 0);

create table T_RCA_IMAGES (
	ID_RCA		bigint			not null
,	IMAGE_NAME	varchar (1024)	not null
,	IMAGE_SIZE	int				not null
,	UPLOAD_DATE	datetime		not null default getdate()
,	UPLOADER	varchar (20)	not null
,	constraint PK_T_RCA_IMAGES primary key (ID_RCA)
)
go

create index T_RCA_IMAGES_FK on T_RCA_IMAGES (
UPLOADER ASC
)
go

alter table T_RCA_IMAGES
   add constraint FK_T_RCA_T_RCA_IMAGES foreign key (ID_RCA)
      references T_RCA (ID_RCA)
go

alter table T_RCA_IMAGES
   add constraint FK___USER_T_RCA_IMAGES foreign key (UPLOADER)
      references __USER (NIPG)
go
