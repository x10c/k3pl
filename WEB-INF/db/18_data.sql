insert into R_DIVPROSBU (ID_DIREKTORAT, NAMA_DIVPROSBU, ID_USER) values (1, 'Satuan Pengawasan Intern', '1')
go

insert	into R_DEPARTEMEN (ID_DIREKTORAT, ID_DIVPROSBU, NAMA_DEPARTEMEN, ID_USER) values (1, 2, 'Auditor Utama Bidang K3PL Dan Teknik', '1')
go

insert	into R_DINAS (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, NAMA_DINAS, ID_USER) values (1, 2, 9, 'Auditor Bidang K3PL', '1')
go

insert	into R_SEKSI (ID_DIREKTORAT, ID_DIVPROSBU, ID_DEPARTEMEN, ID_DINAS, ID_WILAYAH, NAMA_SEKSI, ID_USER) values (1, 2, 9, 23, 1, 'Audit K3PL', '1')
go
