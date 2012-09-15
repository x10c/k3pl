create table R_CSM_PENILAIAN2 (
	ID		int identity (1,1) not null primary key
,	ELEMEN	varchar (1024) not null
,	NILAI	int not null default 0
);

create table R_CSM_PENILAIAN2_DETAIL (
	ID				int identity (1,1) not null primary key
,	ID_PENILAIAN	int not null foreign key references R_CSM_PENILAIAN2 (ID)
,	ELEMEN			varchar (1024) default '-'
);

create table R_CSM_PENILAIAN2_DETAIL2 (
	ID				int identity (1,1) not null primary key
,	ID_PENILAIAN	int not null foreign key references R_CSM_PENILAIAN2 (ID)
,	ID_DETAIL		int not null foreign key references R_CSM_PENILAIAN2_DETAIL (ID)
,	ELEMEN			varchar (1024) default '-'
);

create table R_CSM_PENILAIAN2_PENILAIAN (
	ID				int identity (1,1) not null primary key
,	ID_PENILAIAN	int not null foreign key references R_CSM_PENILAIAN2 (ID)
,	ID_DETAIL		int not null foreign key references R_CSM_PENILAIAN2_DETAIL (ID)
,	ID_DETAIL2		int not null foreign key references R_CSM_PENILAIAN2_DETAIL2 (ID)
,	PENILAIAN		varchar (1024) not null
,	NILAI			int not null default 0
);

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
