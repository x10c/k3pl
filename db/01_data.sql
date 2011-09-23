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
