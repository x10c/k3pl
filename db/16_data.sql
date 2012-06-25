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
