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

insert into R_CSM_PERF_EVAL_SI values (1, 'Tidak Memenuhi Standar (TM) - < 50%');
insert into R_CSM_PERF_EVAL_SI values (2, 'Memenuhi Beberapa Standar (MB) - 50% s/d < 75%');
insert into R_CSM_PERF_EVAL_SI values (3, 'Memenuhi Hampir Semua Standar (MH) - 75% s/d < 100%');
insert into R_CSM_PERF_EVAL_SI values (4, 'Memenuhi Semua Standar (MS) - 100%');
insert into R_CSM_PERF_EVAL_SI values (5, 'Luar Biasa (LB)');

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
