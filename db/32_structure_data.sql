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
