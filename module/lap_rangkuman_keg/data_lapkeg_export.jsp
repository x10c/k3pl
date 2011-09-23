<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Prasetya
--%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	Statement	db_stmt2 = db_con.createStatement();
	Statement	db_stmt3 = db_con.createStatement();
	Date currentDate = new Date();

	String		bulan	= request.getParameter("bulan");
	String		tahun	= request.getParameter("tahun");
	
	String 		nama_bulan = "";
	
	switch (Integer.parseInt(bulan)) {
			case 1:
				nama_bulan = "Januari";
				break;
			case 2:
				nama_bulan = "Februari";
				break;
			case 3:
				nama_bulan = "Maret";
				break;
			case 4:
				nama_bulan = "April";
				break;
			case 5:
				nama_bulan = "Mei";
				break;
			case 6:
				nama_bulan = "Juni";
				break;
			case 7:
				nama_bulan = "Juli";
				break;
			case 8:
				nama_bulan = "Agustus";
				break;
			case 9:
				nama_bulan = "September";
				break;
			case 10:
				nama_bulan = "Oktober";
				break;
			case 11:
				nama_bulan = "November";
				break;
			case 12:
				nama_bulan = "Desember";
				break;
			}

		String q=" select	distinct id_tipe_kegiatan "
				+" from		t_kegiatan_detail "
				+" where bulan = "+bulan+" and tahun = "+tahun;

	ResultSet	rs	= db_stmt.executeQuery(q);
	String audit, pelatihan, rapat, inspeksi, jsa, institusi, investigasi, pemantauan, lainnya;
	audit = "";
	pelatihan = "";
	rapat = "";
	inspeksi = "";
	jsa = "";
	institusi = "";
	investigasi = "";
	pemantauan = "";
	lainnya = "";
	
	q=" SELECT "
     +" TAHUN "
     +" ,BULAN "
     +" ,SUM (JML_KORBAN_MATI) JML_KORBAN_MATI "
     +" ,SUM (JML_KORBAN_BERAT) JML_KORBAN_BERAT "
     +" ,SUM (JML_KORBAN_SEDANG) JML_KORBAN_SEDANG "
     +" ,SUM (JML_HARI_KERJA_HILANG) JML_HARI_KERJA_HILANG "
     +" ,SUM (JML_KORBAN_DAMPAK) JML_KORBAN_DAMPAK "
     +" ,SUM (JML_KORBAN_MEDIS) JML_KORBAN_MEDIS "
     +" ,SUM (JML_KORBAN_P3K) JML_KORBAN_P3K "
     +" ,SUM (JML_HAMPIR_CELAKA) JML_HAMPIR_CELAKA "
     +" ,SUM (JML_BAKAR_LEDAK_BOCOR) JML_BAKAR_LEDAK_BOCOR "
     +" ,SUM (JML_RUSAK_JARINGAN) JML_RUSAK_JARINGAN "
     +" ,SUM (JML_RUSAK_BANGUNAN) JML_RUSAK_BANGUNAN "
     +" ,SUM (JML_RUSAK_KENDARAAN) JML_RUSAK_KENDARAAN "
     +" ,SUM (JML_RUSAK_LAIN) JML_RUSAK_LAIN "
     +" ,SUM (NILAI_RUSAK_JARINGAN) NILAI_RUSAK_JARINGAN "
     +" ,SUM (NILAI_RUSAK_BANGUNAN) NILAI_RUSAK_BANGUNAN "
     +" ,SUM (NILAI_RUSAK_KENDARAAN) NILAI_RUSAK_KENDARAAN "
     +" ,SUM (NILAI_RUSAK_LAIN) NILAI_RUSAK_LAIN "
     +" ,SUM (JML_PENCEMARAN_LINGKUNGAN) JML_PENCEMARAN_LINGKUNGAN "
     +" ,SUM (JML_KECELAKAAN_KENDARAAN) JML_KECELAKAAN_KENDARAAN "
     +" ,SUM (JML_KEJADIAN_KEAMANAN) JML_KEJADIAN_KEAMANAN "
	 +"	FROM T_INSIDEN "
	 +"	WHERE  BULAN = "+bulan+" and TAHUN = "+tahun
	 +" GROUP BY BULAN, TAHUN "; 

	String header;
	header = "";
	String a = "";
	int tipe_kegiatan = 0;
	while (rs.next()){ 
		tipe_kegiatan = Integer.parseInt(rs.getString("id_tipe_kegiatan"));
		switch (tipe_kegiatan) {
		case 1:
			audit = "1";
			break;
		case 2:
			pelatihan = "1";
			break;
		case 3:
			rapat = "1";
			break;
		case 4:
			inspeksi = "1";
			break;
		case 5:
			jsa = "1";
			break;
		case 6:
			institusi = "1";
			break;
		case 7:
			investigasi = "1";
			break;
		case 8:
			pemantauan = "1";
			break;
		case 9:
			lainnya = "1";
			break;
		}
	}

	DateFormat df = new SimpleDateFormat ("dd MMMMMMMMM yyyy");
	String formattedDate = df.format(new Date());

	header =	"<div> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=140 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><img src='"+ getServletContext().getRealPath("\\images") +"\\Logo-PGN.jpg' width=80 height=80 align=center/> </p>"
				+" 			</td> "
				+" 			<td width=800  valign=top> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><b>PT Perusahaan Gas Negara (Persero) Tbk</b></p> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><b>SBU Distribusi Wilayah I - JBB</b></p> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><b>RANGKUMAN LAPORAN BULANAN K3PL/ </b></p> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><b><i>MONTHLY HSE SUMMARY OF Report</i></b></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> "
				+" 	<p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=470 valign=top> "
				+" 				<p align=left ><font size =\"1\"><b>Lokasi/ Location: SBU DW 1 JBB</b></font></p> "
				+" 			</td> "
				+" 			<td width=470  valign=top> "
				+" 				<p align=left ><font size =\"1\"><b>Laporan untuk bulan/ Report for the month of: "+nama_bulan+" "+tahun+" </b></font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=470 valign=top> "
				+" 				<p align=left><font size =\"1\"><b>Tanggal Pelaporan/ Date of the report: "+formattedDate+"</b></font></p> "
				+" 			</td> "
				+" 			<td width=470 valign=top> "
				+" 				<p align=left><font size =\"1\"><b>Disiapkan oleh/ Prepared by: Tim K3PL SBU DW 1 JBB</b></font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=470 valign=top> "
				+" 				<p align=left><font size =\"1\"><b>Ditinjau oleh/ Reviewed by: Staff K3</b></font></p> "
				+" 			</td> "
				+" 			<td width=470 valign=top> "
				+" 				<p align=left><font size =\"1\"><b>Dilengkapi sebelum tanggal 15 setiap bulan/ To be completed by 15th day of every month</b></font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> ";
	

	rs	= db_stmt.executeQuery(q);
	String korban_mati, tanpa_celaka, nyaris_celaka, hilang_hari, sehat_kerja, keamanan, no_hilang_hari, lingkungan;
	korban_mati = "o"; 
	tanpa_celaka = "o";
	nyaris_celaka = "o"; 
	hilang_hari = "o"; 
	sehat_kerja = "o"; 
	keamanan ="o"; 
	no_hilang_hari = "o"; 
	lingkungan = "o";
	Integer sum;

	if (rs.next()){
		sum = rs.getInt("jml_korban_mati") 
			+ rs.getInt("jml_korban_sedang")
			+ rs.getInt("jml_hari_kerja_hilang")
			+ rs.getInt("jml_korban_dampak")
			+ rs.getInt("jml_korban_medis")
			+ rs.getInt("jml_korban_p3k")
			+ rs.getInt("jml_hampir_celaka")
			+ rs.getInt("jml_bakar_ledak_bocor")
			+ rs.getInt("jml_rusak_bangunan")
			+ rs.getInt("jml_rusak_kendaraan")
			+ rs.getInt("jml_rusak_lain")
			+ rs.getInt("jml_pencemaran_lingkungan")
			+ rs.getInt("jml_kecelakaan_kendaraan")
			+ rs.getInt("jml_kejadian_keamanan");

		if (rs.getInt("jml_korban_mati")>0){
			korban_mati = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			korban_mati = "o";
		}
		if (rs.getInt("jml_hampir_celaka")>0){
			nyaris_celaka = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			nyaris_celaka = "o";
		}
		if (rs.getInt("jml_hari_kerja_hilang")>0){
			hilang_hari = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			hilang_hari = "o";
		}
		if (rs.getInt("jml_korban_p3k")>0){
			sehat_kerja = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			sehat_kerja = "o";
		}
		if (rs.getInt("jml_kejadian_keamanan")>0){
			keamanan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			keamanan = "o";
		}
		if (rs.getInt("jml_hari_kerja_hilang")==0){
			no_hilang_hari = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			no_hilang_hari = "o";
		}
		if (rs.getInt("jml_pencemaran_lingkungan")>0){
			lingkungan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			lingkungan = "o";
		}
		if (sum > 0 ){
			tanpa_celaka = "o";
		}
		else{
			tanpa_celaka = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
	}

	String body_insiden = " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p><table align=center> "
				+" 	<tr> <td width=940 valign=top><p align=left><font size =\"2\"><b>1.  KECELAKAAN BULAN INI/ INCIDENTS FOR THE MONTH (Pilih yang sesuai/ Tick where applicable)</b></font></p> "
				+" 	</td></tr> "
				+" 	<tr><td width=940 valign=top> "
				+" 	<table> "
				+" 		<tr> "
				+" 			<td width=200 valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+korban_mati+" Kematian/ Fatality</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+tanpa_celaka+" Tanpa Kecelakaan/ Non-injurious</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+nyaris_celaka+" Nyaris Celaka/ Near Misses</font></p> "
				+" 			</td> "
				+" 			<td width=250  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+hilang_hari+" Kecelakaan dengan Kehilangan Hari Kerja/ Injurious LTI</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+sehat_kerja+" Kesehatan Kerja/ Occupational Health</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+keamanan+" Keamanan/ Security</font></p> "
				+" 			</td> "
				+" 			<td width=255  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+no_hilang_hari+" Kecelakaan Tanpa Kehilangan Hari Kerja/ Injurious Non LTI</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+lingkungan+" Lingkungan/ Environment</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> </td></tr></table> ";

	q = "select a.id_insiden "
    +" ,a.id_area_departemen "
    +" ,a.id_area_dinas "
    +" ,a.id_area_seksi "
    +" ,c.nama_wilayah "
    +" ,a.id_klasifikasi_pegawai "
    +" ,a.tanggal "
    +" ,a.tahun "
    +" ,a.bulan "
    +" ,a.uraian "
	+"	from t_insiden a, r_seksi b, r_wilayah c "
	+"	where a.id_area_seksi = b.id_seksi "
	+"	and b.id_wilayah = c.id_wilayah ";

	rs	= db_stmt.executeQuery(q);
	String body_insiden_wilayah, insiden_wilayah;
	body_insiden_wilayah = "";
	insiden_wilayah = "";

	while(rs.next()){
		insiden_wilayah += "	<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+rs.getString("nama_wilayah")+": "+rs.getString("uraian")+"</font></p> ";
	}
	body_insiden_wilayah = " <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
			+" 		<tr> "
			+" 			<td width=940 valign=top> "
			+insiden_wilayah
			+" 			</td> "
			+" 		</tr> "
			+" 	</table> </td></tr></table> ";

		if (audit.equals("1")){
			audit = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			audit = "o";
		}
		if (pelatihan.equals("1")){
			pelatihan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			pelatihan = "o";
		}
		if (rapat.equals("1")){
			rapat = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			rapat = "o";
		}
		if (inspeksi.equals("1")){
			inspeksi = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			inspeksi = "o";
		}
		if (jsa.equals("1")){
			jsa = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			jsa = "o";
		}
		if (institusi.equals("1")){
			institusi = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			institusi = "o";
		}
		if (investigasi.equals("1")){
			investigasi = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			investigasi = "o";
		}	
		if (pemantauan.equals("1")){
			pemantauan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			pemantauan = "o";
		}
		if (lainnya.equals("1")){
			lainnya = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			lainnya = "o";
		}

		String header_kegiatan = " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p><table align=center> "
				+" 	<tr> <td width=940 valign=top><p align=left><font size =\"2\"><b>2.  KEGIATAN K3PL BULAN INI/ HSE ACTIVITIES FOR THE MONTH (Pilih yang sesuai/ Tick where applicable)</b></font></p> "
				+" 	</td></tr> "
				+" 	<tr><td width=940 valign=top> "
				+" 	<table> "
				+" 		<tr> "
				+" 			<td width=200 valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+audit+" Audit/ Audit</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+pelatihan+" Pelatihan/Induksi / Safety Induction/Training</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+rapat+" Rapat/ Meettings</font></p> "
				+" 			</td> "
				+" 			<td width=250  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+inspeksi+" Inspeksi/ Inspection</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+jsa+" JSA/HAZOP/Safety Review</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+institusi+" Institusi Pemerintah/ Statutory Bodies</font></p> "
				+" 			</td> "
				+" 			<td width=255  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+investigasi+" Investigasi Kecelakaan/ Incident Investigation</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+pemantauan+" Pemantauan/Pengamatan / Monitoring/Surveillance</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+lainnya+" Lainnya/ Others</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> </td></tr></table> ";

		q=" select	distinct a.id_wilayah "
		+" ,		b.nama_wilayah "
		+" from		t_kegiatan_detail a, r_wilayah b "
		+" where	a.tahun 	= " + tahun
		+" and		a.bulan	= " + bulan
		+" and		a.id_wilayah	= b.id_wilayah "
		+" order by	a.id_wilayah ";

		rs	= db_stmt.executeQuery(q);
		ResultSet	rs_tipe_keg;
		ResultSet	rs_nama_keg;
		String kegiatan_detil = "";
		String wilayah_temp = "";
		String tipe_kegiatan_temp = "";
		Integer idx =1;

		while (rs.next()){
			wilayah_temp = rs.getString("id_wilayah");

			q=" select	distinct a.id_tipe_kegiatan "
			+" ,		b.nama_tipe_kegiatan "
			+" from		t_kegiatan_detail a, r_tipe_kegiatan b "
			+" where	a.tahun 	= " + tahun
			+" and		a.bulan	= " + bulan
			+" and		a.id_wilayah	= " + wilayah_temp
			+" and		a.id_tipe_kegiatan	= b.id_tipe_kegiatan "
			+" order by	a.id_tipe_kegiatan ";
			idx = 1;
			rs_tipe_keg = db_stmt2.executeQuery(q);
			kegiatan_detil += " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p><table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
						+" 		<tr> "
						+" 			<td width=940 valign=top> "
						+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>"+rs.getString("nama_wilayah")+"</b></font></p> ";

			while (rs_tipe_keg.next()){
					tipe_kegiatan_temp = rs_tipe_keg.getString("id_tipe_kegiatan");
					kegiatan_detil += " 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>"+idx+".  "+rs_tipe_keg.getString("nama_tipe_kegiatan")+"</b></font></p> ";
					q=" select  a.nama_kegiatan "
					+" from		t_kegiatan_detail a "
					+" where	a.tahun 	= " + tahun
					+" and		a.bulan	= " + bulan
					+" and		a.id_wilayah	= " + wilayah_temp
					+" and		a.id_tipe_kegiatan	= " + tipe_kegiatan_temp
					+" order by	a.id_kegiatan_detail ";

					rs_nama_keg = db_stmt3.executeQuery(q);
					while (rs_nama_keg.next()){
						kegiatan_detil += " 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">- "+rs_nama_keg.getString("nama_kegiatan")+"</font></p> ";
					}
					idx= idx+1;
			}
			kegiatan_detil +=" </td></tr></table>";
		}
		Integer next_bulan = Integer.parseInt(bulan);
		Integer next_tahun = Integer.parseInt (tahun);

		if ((next_bulan + 1) > 12){
			next_bulan = 1;
			next_tahun += 1;
		}
		else{
			next_bulan += 1;
		}

	 q=" select	distinct id_tipe_kegiatan "
				+" from		t_kegiatan_detail "
				+" where bulan = "+next_bulan+" and tahun = "+next_tahun;

		rs	= db_stmt.executeQuery(q);

		
		while (rs.next()){ 
			tipe_kegiatan = Integer.parseInt(rs.getString("id_tipe_kegiatan"));
			switch (tipe_kegiatan) {
			case 1:
				audit = "1";
				break;
			case 2:
				pelatihan = "1";
				break;
			case 3:
				rapat = "1";
				break;
			case 4:
				inspeksi = "1";
				break;
			case 5:
				jsa = "1";
				break;
			case 6:
				institusi = "1";
				break;
			case 7:
				investigasi = "1";
				break;
			case 8:
				pemantauan = "1";
				break;
			case 9:
				lainnya = "1";
				break;
			}
		}
		
		if (audit.equals("1")){
			audit = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			audit = "o";
		}
		if (pelatihan.equals("1")){
			pelatihan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			pelatihan = "o";
		}
		if (rapat.equals("1")){
			rapat = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			rapat = "o";
		}
		if (inspeksi.equals("1")){
			inspeksi = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			inspeksi = "o";
		}
		if (jsa.equals("1")){
			jsa = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {			jsa = "o";
		}
		if (institusi.equals("1")){
			institusi = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			institusi = "o";
		}
		if (investigasi.equals("1")){
			investigasi = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			investigasi = "o";
		}
		if (pemantauan.equals("1")){
			pemantauan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			pemantauan = "o";
		}
		if (lainnya.equals("1")){
			lainnya = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			lainnya = "o";
		}

		String header_kegiatan_next = " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p><table align=center> "
				+" 	<tr> <td width=940 valign=top><p align=left><font size =\"2\"><b>3.  KEGIATAN K3PL BULAN DEPAN/ HSE ACTIVITIES FOR NEXT MONTH (Pilih yang sesuai/ Tick where applicable)</b></font></p> "
				+" 	</td></tr> "
				+" 	<tr><td width=940 valign=top> "
				+" 	<table> "
				+" 		<tr> "
				+" 			<td width=200 valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+audit+" Audit/ Audit</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+pelatihan+" Pelatihan/Induksi / Safety Induction/Training</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+rapat+" Rapat/ Meettings</font></p> "
				+" 			</td> "
				+" 			<td width=250  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+inspeksi+" Inspeksi/ Inspection</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+jsa+" JSA/HAZOP/Safety Review</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+institusi+" Institusi Pemerintah/ Statutory Bodies</font></p> "
				+" 			</td> "
				+" 			<td width=255  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+investigasi+" Investigasi Kecelakaan/ Incident Investigation</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+pemantauan+" Pemantauan/Pengamatan / Monitoring/Surveillance</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+lainnya+" Lainnya/ Others</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> </td></tr></table> ";

		q=" select	distinct a.id_wilayah "
		+" ,		b.nama_wilayah "
		+" from		t_kegiatan_detail a, r_wilayah b "
		+" where	a.tahun 	= " + next_tahun
		+" and		a.bulan	= " + next_bulan
		+" and		a.id_wilayah	= b.id_wilayah "
		+" order by	a.id_wilayah ";

		rs	= db_stmt.executeQuery(q);
		String kegiatan_detil_next = "";
		 wilayah_temp = "";
		 tipe_kegiatan_temp = "";
		 idx =1;

		while (rs.next()){
			wilayah_temp = rs.getString("id_wilayah");

			q=" select	distinct a.id_tipe_kegiatan "
			+" ,		b.nama_tipe_kegiatan "
			+" from		t_kegiatan_detail a, r_tipe_kegiatan b "
			+" where	a.tahun 	= " + next_tahun
			+" and		a.bulan	= " + next_bulan
			+" and		a.id_wilayah	= " + wilayah_temp
			+" and		a.id_tipe_kegiatan	= b.id_tipe_kegiatan "
			+" order by	a.id_tipe_kegiatan ";
			idx = 1;
			rs_tipe_keg = db_stmt2.executeQuery(q);
			kegiatan_detil_next += " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p><table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
						+" 		<tr> "
						+" 			<td width=940 valign=top> "
						+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>"+rs.getString("nama_wilayah")+"</b></font></p> ";
			while (rs_tipe_keg.next()){
					tipe_kegiatan_temp = rs_tipe_keg.getString("id_tipe_kegiatan");
					kegiatan_detil_next += " 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>"+idx+".  "+rs_tipe_keg.getString("nama_tipe_kegiatan")+"</b></font></p> ";
					q=" select  a.nama_kegiatan "
					+" from		t_kegiatan_detail a "
					+" where	a.tahun 	= " + next_tahun
					+" and		a.bulan	= " + next_bulan
					+" and		a.id_wilayah	= " + wilayah_temp
					+" and		a.id_tipe_kegiatan	= " + tipe_kegiatan_temp
					+" order by	a.id_kegiatan_detail ";

					rs_nama_keg = db_stmt3.executeQuery(q);
					while (rs_nama_keg.next()){
						kegiatan_detil_next += " 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">- "+rs_nama_keg.getString("nama_kegiatan")+"</font></p> ";
					}
					idx= idx+1;
			}
			kegiatan_detil_next +=" </td></tr></table>";
		}

		q=" select	distinct id_tipe_area_perhatian "
				+" from		t_area_perhatian_detail "
				+" where bulan = "+bulan+" and tahun = "+tahun;
				
		int tipe_area_perhatian = 0;
		rs	= db_stmt.executeQuery(q);
		
		String perilaku_tidak_aman = "";
		String kurang_pengawasan = "";
		String kurang_pengetahuan= "";
		String tidak_memenuhi_peraturan= "";	
		String kurang_komunikasi= "";
		String kurang_sumber_daya= ""; 
		String kurang_tekad= "";
		String kurang_prosedur="";
		String kondisi_tidak_aman= "";
		String pelanggaran= "";
		String housekeeping_kurang= "";
		String lainnya_ar= "";

		while (rs.next()){ 
			tipe_area_perhatian = Integer.parseInt(rs.getString("id_tipe_area_perhatian"));
			switch (tipe_area_perhatian) {
			case 1:
				perilaku_tidak_aman = "1";
				break;
			case 2:
				kurang_pengawasan = "1";
				break;
			case 3:
				kurang_pengetahuan = "1";
				break;
			case 4:
				tidak_memenuhi_peraturan = "1";
				break;
			case 5:
				kurang_komunikasi = "1";
				break;
			case 6:
				kurang_sumber_daya = "1";
				break;
			case 7:
				kurang_tekad = "1";
				break;
			case 8:
				kurang_prosedur = "1";
				break;
			case 9:
				kondisi_tidak_aman = "1";
				break;
			case 10:
				pelanggaran = "1";
				break;
			case 11:
				housekeeping_kurang = "1";
				break;
			case 12:
				lainnya_ar = "1";
				break;
			}
		}
		
		if (perilaku_tidak_aman.equals("1")){
			perilaku_tidak_aman = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			perilaku_tidak_aman = "o";
		}
		if (kurang_pengawasan.equals("1")){
			kurang_pengawasan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			kurang_pengawasan = "o";
		}
		if (kurang_pengetahuan.equals("1")){
			kurang_pengetahuan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			kurang_pengetahuan = "o";
		}
		if (tidak_memenuhi_peraturan.equals("1")){
			tidak_memenuhi_peraturan = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			tidak_memenuhi_peraturan = "o";
		}
		if (kurang_komunikasi.equals("1")){
			kurang_komunikasi = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {			kurang_komunikasi = "o";
		}
		if (kurang_sumber_daya.equals("1")){
			kurang_sumber_daya = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			kurang_sumber_daya = "o";
		}
		if (kurang_tekad.equals("1")){
			kurang_tekad = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			kurang_tekad = "o";
		}
		if (kurang_prosedur.equals("1")){
			kurang_prosedur = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			kurang_prosedur = "o";
		}
		if (kondisi_tidak_aman.equals("1")){
			kondisi_tidak_aman = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			kondisi_tidak_aman = "o";
		}

		if (pelanggaran.equals("1")){
			pelanggaran = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			pelanggaran = "o";
		}
		if (housekeeping_kurang.equals("1")){
			housekeeping_kurang = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			housekeeping_kurang = "o";
		}
		if (lainnya_ar.equals("1")){
			lainnya_ar = "<span style=\"font-family: Arial Unicode MS\">&#10003;</span>";
		}
		else {
			lainnya_ar = "o";
		}

		String header_area = " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p><table align=center> "
				+" 	<tr> <td width=940 valign=top><p align=left><font size =\"2\"><b>4.  AREA PERHATIAN/ AREAS OF CONCERN (Pilih yang sesuai/ Tick where applicable)</b></font></p> "
				+" 	</td></tr> "
				+" 	<tr><td width=940 valign=top> "
				+" 	<table> "
				+" 		<tr> "
				+" 			<td width=300 valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+perilaku_tidak_aman+" Perilaku tidak aman/ Unsafe act</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+kurang_pengawasan+" Kurang pengawasan/ supervisi/Lact of control/supervision</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+kurang_pengetahuan+" Kurang pengetahuan/kesadaran / Lack of knowledge/awareness</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+tidak_memenuhi_peraturan+" Tidak memenuhi peraturan perundang-undangan/ Non compliance to laws/ regulations</font></p> "
				+" 			</td> "
				+" 			<td width=300  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+kurang_komunikasi+" Kurang komunikasi/ tanggung jawab tidak jelas / Poor communication/ unclear responsibilities</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+kurang_sumber_daya+" Kurang sumber daya/ kompetensi/ Lack of resource/ competency</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+kurang_tekad+" Kurang tekad/ Lack of commitment</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+kurang_prosedur+" Kurang prosedur/ Lack of procedures</font></p> "
				+" 			</td> "
				+" 			<td width=300  valign=top> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+kondisi_tidak_aman+" Kondisi tidak aman/ Unsafe condition/equipment</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+pelanggaran+" Pelanggaran/ Violation</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+housekeeping_kurang+" Housekeeping kurang/ Poor housekeeping</font></p> "
				+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+lainnya_ar+" Lainnya/ Others - training & sosialisasi</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> </td></tr></table> ";

		q=" select	distinct a.id_wilayah "
		+" ,		b.nama_wilayah "
		+" from		t_area_perhatian_detail a, r_wilayah b "
		+" where	a.tahun 	= " + tahun
		+" and		a.bulan	= " + bulan
		+" and		a.id_wilayah	= b.id_wilayah "
		+" order by	a.id_wilayah ";

		rs	= db_stmt.executeQuery(q);
		String area_detil_next = "";
		 wilayah_temp = "";
		 tipe_kegiatan_temp = "";
		 idx =1;

		while (rs.next()){
			wilayah_temp = rs.getString("id_wilayah");

			idx = 1;
			rs_tipe_keg = db_stmt2.executeQuery(q);
			area_detil_next += " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p><table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
						+" 		<tr> "
						+" 			<td width=940 valign=top> "
						+" 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>"+rs.getString("nama_wilayah")+"</b></font></p> ";
			q=" select  a.nama_area_perhatian "
				+" from		t_area_perhatian_detail a "
				+" where	a.tahun 	= " + tahun
				+" and		a.bulan	= " + bulan
				+" and		a.id_wilayah	= " + wilayah_temp
				+" order by	a.id_area_perhatian_detail ";

			rs_nama_keg = db_stmt3.executeQuery(q);
			while (rs_nama_keg.next()){
				area_detil_next += " 				<p align=left style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+idx+".  "+rs_nama_keg.getString("nama_area_perhatian")+"</font></p> ";
				idx= idx+1;
			}

			area_detil_next +=" </td></tr></table>";
		}

// String root_path = "F:\\Tomcat7\\webapps\\k3pl\\files";
String root_path = getServletContext().getRealPath("\\files");
FileOutputStream fos = new FileOutputStream(root_path+"\\lap_rangkuman.doc");
	PrintWriter pw = new PrintWriter(fos);
	pw.println("<html> "
					+"<head> "
					+" <title>MOM Central Committee</title>"
					+"</head>"
					+"<body>"
					+ header
					+ body_insiden
					+ body_insiden_wilayah
					+ header_kegiatan
					+ kegiatan_detil
					+ header_kegiatan_next
					+ kegiatan_detil_next
					+ header_area
					+ area_detil_next
					+" </div> "
					+"</body>"
					+"</html>");
	pw.close();
	fos.close();

	String fileName=getServletContext().getRealPath("\\files\\lap_rangkuman.doc");

	File f=new File(fileName);

	InputStream in = new FileInputStream(f);

	BufferedInputStream bin = new BufferedInputStream(in); 
	ServletOutputStream	httpout	= response.getOutputStream();
response.setHeader("Content-Disposition", "attachment; filename=\"lap_rangkuman.doc\"");
response.setContentType("application/vnd.ms-word");	
	int bit = 256;
		int i = 0;
		try {
			while ((bit) >= 0) {
				bit = in.read();
				httpout.write(bit);
			}
			//System.out.println("" +bit);
		} catch (IOException ioe) {
			ioe.printStackTrace(System.out);
		}
//		System.out.println( "\n" + i + " bytes sent.");
//		System.out.println( "\n" + f.length() + " bytes sent.");
		httpout.flush();
		httpout.close();
		in.close();	

	// httpout.print("<html> "
					// +"<head> "
					// +" <title>MOM Central Committee</title>"
					// +"</head>"
					// +"<body>"
					// +header
					// +"</body>"
					// +"</html>");
	// httpout.flush();
	// httpout.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
<%--
This is an example of
	"Know a knife, but does not know how to use it"
or
	"Using a knife for chopping a tree!"

	-ms
--%>
