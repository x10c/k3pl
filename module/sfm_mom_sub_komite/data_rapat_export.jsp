<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Prasetya
--%>


<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Statement	db_stmt = db_con.createStatement();
	Statement	db_stmt2 = db_con.createStatement();
	
	String		id_rapat	= request.getParameter("id_rapat");
	String id_user		= (String) session.getAttribute("user.nipg");
	String q=" select	A.id_kel_jabatan_csc "
		+" ,		A.id_kel_jabatan_komite_sub_komite "
		+" from		r_jabatan_komite_sub_komite A"
		+" left join  t_pegawai_komite_sub_komite B on (B.id_jabatan_komite = A.id_jabatan_komite) "
		+" left join R_KEL_JABATAN_KOMITE_SUB_KOMITE C on (C.ID_KEL_JABATAN_KOMITE_SUB_KOMITE = A.ID_KEL_JABATAN_KOMITE_SUB_KOMITE) "
		+" where B.nipg = "+ id_user +" and A.notulen is not null and A.id_kel_jabatan_komite_sub_komite is not null"
		+" order by	A.id_kel_jabatan_komite_sub_komite ";
		
	ResultSet	rs_kel = db_stmt.executeQuery(q);
	q=" ";
	
	if (rs_kel.next()){
		 q=" select	A.id_rapat "
		+" ,		A.id_kel_jabatan_komite_sub_komite"
		+" , 		B.nama_kel_jabatan_komite_sub_komite "
		+" ,		A.no_rapat "
		+" ,		A.judul_rapat "
		+" ,		replace(convert(varchar, A.tanggal_rapat, 111), '/', '-') tanggal"
		+" ,		A.lokasi_rapat "
		+" ,		A.tanggal_notulen "
		+" , 		A.nama_notulis "
		+" from		t_rapat	A "
		+" left join	r_kel_jabatan_komite_sub_komite	B"
		+" on		A.id_kel_jabatan_komite_sub_komite = B.id_kel_jabatan_komite_sub_komite "
		+" where A.id_kel_jabatan_komite_sub_komite not in ('1') and A.id_rapat = '"+ id_rapat +"' "
		+" order by	A.id_rapat ";
	}else {
		out.print("Error, tidak dapat me-retrieve data rapat");
		return;
	}
	
	ResultSet	rs	= db_stmt.executeQuery(q);
		
	 q=" select	A.id_rapat "
	+" ,		A.id_rapat_materi "
	+" , 		A.isi_rapat_materi "
	+" ,		A.batas_waktu_materi"
	+" ,		A.status_materi "
	+" ,		A.keterangan_materi "
	+" ,		B.nipg nipg_pelaksana"
	+" ,		C.nipg nipg_supervisor"
	+" from		t_rapat_materi	A "
	+" left join 	t_pic_rapat_materi	B on (B.id_rapat_materi = A.id_rapat_materi and B.id_rapat = A.id_rapat )"
	+" left join 	t_pic_rapat_materi_detail C on (C.id_rapat_materi = A.id_rapat_materi and C.id_rapat = A.id_rapat)"
	+" where A.id_rapat = '"+ id_rapat +"' "
	+" order by	A.id_rapat_materi ";
	
	if (rs.next()){ String a = "";}

String header =	"<div> "
				+" 	<p align=center><b>RAPAT SUB SAFETY COMMITTEE</b></p> "
				+" 	<p align=center><b>PT PERUSAHAAN GAS NEGARA (Persero) Tbk</b></p> "
				+" 	<p align=center><b> </b></p> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=205 valign=top> "
				+" 				<p align=center><b>Risalah Rapat</b></p> "
				+" 				<p align=center>"+ rs.getString("judul_rapat")+"</p> "
				+" 			</td> "
				+" 			<td width=231  valign=top> "
				+" 				<p align=center><b>Rapat No.</b></p> "
				+" 				<p align=center>"+ rs.getString("no_rapat")+"</p> "
				+" 			</td> "
				+" 			<td width=206 valign=top> "
				+" 				<p align=center ><b>Disiapkan Oleh</b></p> "
				+" 				<p align=center>"+rs.getString("nama_notulis")+"</p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=205 valign=top> "
				+" 				<p align=center><b>Lokasi</b></p> "
				+" 				<p align=center>"+rs.getString("lokasi_rapat")+"</p> "
				+" 			</td> "
				+" 			<td width=231 valign=top> "
				+" 				<p align=center><b>Tanggal</b></p> "
				+" 				<p align=center>"+rs.getString("tanggal")+"</p> "
				+" 			</td> "
				+"   		<td width=206 valign=top> "
 				+"   			<p align=center><b>Waktu</b></p> "
				+"  		</td> "
				+" 		</tr> "
				+" 	</table> ";

	q=" select	A.id_rapat "
		+" ,		A.nipg "
		+" , 		B.nama_pegawai "
		+" ,		A.id_jabatan_komite "
		+" ,		C.nama_jabatan_komite "
		+" ,		A.status_absensi "
		+" ,		A.keterangan_absensi"
		+" ,		A.jml_hadir "
		+" ,		A.jml_absen"
		+" from		t_rapat_absensi_komite_sub_komite	A "
		+" left join r_pegawai B on B.nipg = A.nipg "
		+" left join r_jabatan_komite_sub_komite C on C.id_jabatan_komite = A.id_jabatan_komite "
		+" where	A.id_rapat = '"+ id_rapat +"' ";
	ResultSet	rs_absen	= db_stmt.executeQuery(q);	
	String absen_content = "";
	while (rs_absen.next()) {

		absen_content	+=" <tr> "
							+" <td width=177 valign=top><p align=center>"+ rs_absen.getString("nama_pegawai") +"</p></td> "
							+" <td width=142 valign=top><p align=center>"+ rs_absen.getString("nama_jabatan_komite") +"</p></td> "
							+" <td width=60 valign=top><p align=center>"+ rs_absen.getString("jml_hadir") +"</p></td> "
							+" <td width=60 valign=top><p align=center>"+ rs_absen.getString("jml_absen") +"</p></td> "
							+" <td width=203 valign=top><p align=center>"+ rs_absen.getString("keterangan_absensi") +"</p></td> "
						  +" </tr> ";
	}				
	String absen_table ="<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
							+" <tr> "
							+" 	<th width=177>Nama Peserta</th> "
							+" 	<th width=142>Jabatan</th> "
							+" 	<th width=60>Jumlah Hadir</th> "
							+" 	<th width=60>Jumlah Absen</th> "
							+" 	<th width=203>Keterangan</th> "
							+" </tr> "
							+ absen_content
							+" </table> ";
	q =" select	A.id_rapat "
		+" ,		A.id_rapat_materi "
		+" , 		A.isi_rapat_materi "
		+" ,		replace(convert(varchar, A.batas_waktu_materi, 111), '/', '-') as batas_waktu_materi "
		+" ,		A.status_materi "
		+" ,		A.keterangan_materi "
		+" ,		(select nama_seksi from r_seksi where id_seksi = B.seksi_pelaksana) seksi_pelaksana "
		+" ,		(select nama_dinas from r_dinas where id_dinas = B.dinas_supervisor) dinas_supervisor "
		+" from		t_rapat_materi	A "
		+" left join 	t_pic_rapat_materi	B on (B.id_rapat_materi = A.id_rapat_materi and B.id_rapat = A.id_rapat )"
		+" where A.id_rapat = '"+ id_rapat +"' "
		+" order by	A.id_rapat_materi ";
	
	
	ResultSet	rs_materi	= db_stmt.executeQuery(q);	
	String p = "";
	String gab_materi="";
	String materi_content = "";
	String temp_status="";
	String isi, batas_waktu, pelaksana, supervisor, keterangan;
	int no =1 ;
	while (rs_materi.next()) {
		temp_status = rs_materi.getString("status_materi");
		if (temp_status.equals("0")){
			temp_status = "info";
		}else if (temp_status.equals("1")){
			temp_status = "Open";
		}else if (temp_status.equals("2")){
			temp_status = "Closed Pelaksana";
		}else if (temp_status.equals("3")){
			temp_status = "Closed Supervisor";
		}else if (temp_status.equals("4")){
			temp_status = "Finished";
		}
		isi = (rs_materi.getString("isi_rapat_materi") == null) ? "" : rs_materi.getString("isi_rapat_materi");
		batas_waktu = (rs_materi.getString("batas_waktu_materi") == null) ? "" : rs_materi.getString("batas_waktu_materi");
		pelaksana = (rs_materi.getString("seksi_pelaksana") == null) ? "" : rs_materi.getString("seksi_pelaksana");
		supervisor = (rs_materi.getString("dinas_supervisor") == null) ? "" : rs_materi.getString("dinas_supervisor");
		keterangan = (rs_materi.getString("keterangan_materi") == null) ? "" : rs_materi.getString("keterangan_materi");

		materi_content	+=" <tr> <font size =\"2\">"
							+" <td width=35 valign=top><p align=center>"+ no +"</p></td> "
							+" <td width=145 valign=top><p align=center>"+ isi +"</p></td> "
							+" <td width=70 valign=top><p align=center>"+ temp_status +"</p></td> "
							+" <td width=65 valign=top><p align=center>"+ batas_waktu +"</p></td> "
							+" <td width=90 valign=top><p align=center>"+ pelaksana +"</p></td> "
							+" <td width=90 valign=top><p align=center>"+ supervisor +"</p></td> "
							+" <td width=140 valign=top><p align=center>"+ keterangan +"</p></td> "
						  +" </font></tr> ";
		no += 1;
		p =" select	A.id_rapat "
		+" ,		A.id_rapat_materi "
		+" ,		A.id_rapat_sub_materi "
		+" , 		A.isi_rapat_sub_materi "
		+" ,		replace(convert(varchar, A.batas_waktu_sub_materi, 111), '/', '-') as batas_waktu_sub_materi"
		+" ,		A.status_sub_materi "
		+" ,		A.keterangan_sub_materi "
		+" ,		(select nama_seksi from r_seksi where id_seksi = B.seksi_pelaksana) seksi_pelaksana "
		+" ,		(select nama_dinas from r_dinas where id_dinas = B.dinas_supervisor) dinas_supervisor "
		+" from		t_rapat_sub_materi	A "
		+" left join 	t_rapat_materi	D on (D.id_rapat_materi = A.id_rapat_materi and D.id_rapat = A.id_rapat )"
		+" left join 	t_pic_rapat_sub_materi	B on (B.id_rapat_materi = A.id_rapat_materi and B.id_rapat = A.id_rapat and B.id_rapat_sub_materi = A.id_rapat_sub_materi)"
		+" where A.id_rapat = '"+ rs_materi.getString("id_rapat") +"' and A.id_rapat_materi = '"+ rs_materi.getString("id_rapat_materi") +"' " ;
		
		ResultSet	rs_sub_materi	= db_stmt2.executeQuery(p);	
		String sub_materi_content = "";
		String sub_temp_status="";
		sub_materi_content = "";
		while (rs_sub_materi.next()) {
			sub_temp_status = rs_sub_materi.getString("status_sub_materi");
			if (sub_temp_status.equals("0")){
				sub_temp_status = "info";
			}else if (sub_temp_status.equals("1")){
				sub_temp_status = "Open";
			}else if (sub_temp_status.equals("2")){
				sub_temp_status = "Closed Pelaksana";
			}else if (sub_temp_status.equals("3")){
				sub_temp_status = "Closed Supervisor";
			}else if (sub_temp_status.equals("4")){
				sub_temp_status = "Finished";
			}
			
			isi = (rs_sub_materi.getString("isi_rapat_sub_materi") == null) ? "" : rs_sub_materi.getString("isi_rapat_sub_materi");
			batas_waktu = (rs_sub_materi.getString("batas_waktu_sub_materi") == null) ? "" : rs_sub_materi.getString("batas_waktu_sub_materi");
			pelaksana = (rs_sub_materi.getString("seksi_pelaksana") == null) ? "" : rs_sub_materi.getString("seksi_pelaksana");
			supervisor = (rs_sub_materi.getString("dinas_supervisor") == null) ? "" : rs_sub_materi.getString("dinas_supervisor");
			keterangan = (rs_sub_materi.getString("keterangan_sub_materi") == null) ? "" : rs_sub_materi.getString("keterangan_sub_materi");
			
			sub_materi_content	+=" <tr> "
							+" <td width=32 valign=top><p align=center></p></td> "
							+" <td width=145 valign=top><p align=center>"+ isi +"</p></td> "
							+" <td width=70 valign=top><p align=center>"+ sub_temp_status +"</p></td> "
							+" <td width=70 valign=top><p align=center>"+ batas_waktu +"</p></td> "
							+" <td width=90 valign=top><p align=center>"+ pelaksana +"</p></td> "
							+" <td width=90 valign=top><p align=center>"+ supervisor +"</p></td> "
							+" <td width=130 valign=top><p align=center>"+ keterangan +"</p></td> "
						  +" </tr> ";
						  
		}
		materi_content += sub_materi_content;

	}				
							out.print("asdfasdfadfasdf");
	gab_materi = "<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
						+" <tr> "
						+" 	<th width=35>No</th> "
						+" 	<th width=145>Diskusi</th> "
						+" 	<th width=70>Status</th> "
						+" 	<th width=65>Batas Waktu</th> "
						+" 	<th width=90>Pelaksana</th> "
						+" 	<th width=90>Supervisor</th> "
						+" 	<th width=130>Keterangan</th> "
						+" </tr> "
						+ materi_content
						+" </table> ";
		
// String root_path = "F:\\Tomcat7\\webapps\\k3pl\\files";
String root_path = getServletContext().getRealPath("\\files");
FileOutputStream fos = new FileOutputStream(root_path+"\\mom3.doc");
	PrintWriter pw = new PrintWriter(fos);
	pw.println("<html> "
					+"<head> "
					+" <title>MOM Central Committee</title>"
					+"</head>"
					+"<body>"
					+ header
					+ absen_table
					+ gab_materi
					+" </div> "
					+"</body>"
					+"</html>");
	pw.close();
	fos.close();

	
	String fileName=getServletContext().getRealPath("\\files\\mom3.doc");

	File f=new File(fileName);

	InputStream in = new FileInputStream(f);

	BufferedInputStream bin = new BufferedInputStream(in); 
	ServletOutputStream	httpout	= response.getOutputStream();
response.setHeader("Content-Disposition", "attachment; filename=\"mom.doc\"");
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
	out.print("{success:false,info:'"+ e +"'}");
}
%>
