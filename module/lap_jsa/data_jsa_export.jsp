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
	Statement	db_stmt = db_con.createStatement();
	Statement	db_stmt2 = db_con.createStatement();
	Statement	db_stmt3 = db_con.createStatement();
	Date currentDate = new Date();
	
	String		id_jsa	= request.getParameter("id_jsa");
	
		String q= " select   id_jsa "
		+ " ,        no_dokumen "
		+ " ,        revisi "
		+ " ,        no_kontrak "
		+ " ,        nama_perusahaan "
		+ " ,        nama_proyek "
		+ " ,        nama_pic "
		+ " ,        aktifitas_pekerjaan "
		+ " ,        tanggal_jsa "
		+ " ,        alat_pelindung_diri_digunakan "
		+ " from     t_jsa "
		+ " where id_jsa = "+ id_jsa;

	ResultSet	rs	= db_stmt.executeQuery(q);
	
	String header;
	header = "";
	if (rs.next()){ 
		
	header =	"<div> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=120 valign=center valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><img src='"+ getServletContext().getRealPath("\\images") +"\\Logo-PGN.jpg' width=60 height=60 align=center/> </p>"
				+" 			</td> "
				+" 			<td width=700  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><b>JOB SAFETY ANALISYS</b></p> "
				+" 			</td> "
				+" 			<td width=120 valign=center valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><img src='"+ getServletContext().getRealPath("\\images") +"\\SBU_I.png' width=60 height=42 align=center/> </p>"
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=120 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">Document No.</font></p> "
				+" 			</td> "
				+" 			<td width=350  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">Rev.</font></p> "
				+" 			</td> "
				+" 			<td width=350  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">Contract No.</font></p> "
				+" 			</td> "
				+" 			<td width=120 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">Pages.</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=120 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("no_dokumen")+"</font></p> "
				+" 			</td> "
				+" 			<td width=350  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("revisi")+"</font></p> "
				+" 			</td> "
				+" 			<td width=350  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("no_kontrak")+"</font></p> "
				+" 			</td> "
				+" 			<td width=120 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">&nbsp;</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> "
				+" 	<p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=150 valign=top> "
				+" 				<p align=left ><font size =\"1\"> Company</font></p> "
				+" 			</td> "
				+" 			<td width=10 valign=top> "
				+" 				<p align=center ><font size =\"1\">:</font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=top> "
				+" 				<p align=left ><font size =\"1\"> "+rs.getString("nama_perusahaan")+"</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=left ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">Prepared by</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">Checked by</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">Approved by</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=150 valign=top> "
				+" 				<p align=left ><font size =\"1\"> Project</font></p> "
				+" 			</td> "
				+" 			<td width=10 valign=top> "
				+" 				<p align=center ><font size =\"1\">:</font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=top> "
				+" 				<p align=left ><font size =\"1\"> "+rs.getString("nama_proyek")+"</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=left ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">Contractor</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">HSE Contractor</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">PGN SBU 1</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=150 valign=top> "
				+" 				<p align=left ><font size =\"1\"> Person In Charge</font></p> "
				+" 			</td> "
				+" 			<td width=10 valign=top> "
				+" 				<p align=center ><font size =\"1\">:</font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=top> "
				+" 				<p align=left ><font size =\"1\"> "+rs.getString("nama_pic")+"</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=left ><font size =\"1\">  NAME</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=150 valign=top> "
				+" 				<p align=left ><font size =\"1\"> Job Activity</font></p> "
				+" 			</td> "
				+" 			<td width=10 valign=top> "
				+" 				<p align=center ><font size =\"1\">:</font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=top> "
				+" 				<p align=left ><font size =\"1\"> "+rs.getString("aktifitas_pekerjaan")+"</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=left ><font size =\"1\">  SIGNATURE</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<td width=150 valign=top> "
				+" 				<p align=left ><font size =\"1\"> Date/ Tanggal</font></p> "
				+" 			</td> "
				+" 			<td width=10 valign=top> "
				+" 				<p align=center ><font size =\"1\">:</font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=top> "
				+" 				<p align=left ><font size =\"1\"> "+rs.getString("tanggal_jsa")+"</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=left ><font size =\"1\">  DATE</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">&nbsp;</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=150 valign=top> "
				+" 				<p align=left ><font size =\"1\"> Personel Protective equipment/ tools</font></p> "
				+" 			</td> "
				+" 			<td width=10 valign=top> "
				+" 				<p align=center ><font size =\"1\">:</font></p> "
				+" 			</td> "
				+" 			<td width=770 valign=top> "
				+" 				<p align=left ><font size =\"1\"> "+rs.getString("alat_pelindung_diri_digunakan")+"</font></p> "
				+" 			</td> "
				+" 		</tr> "
				+" 	</table> ";
	}
	
	q= " select   id_jsa "
		+ " ,        id_jsa_detail "
		+ " ,        urutan_langkah_pekerjaan_dasar "
		+ " ,        potensi_bahaya "
		+ " ,        rekomendasi_aksi "
		+ " ,        penanggung_jawab "
		+ " from     t_jsa_detail "
		+ " where    id_jsa = "+ id_jsa
		+ " order by id_jsa, id_jsa_detail ";
	
	rs	= db_stmt.executeQuery(q);
	String jsa_detil = "";
	String body_jsa_detil = "";
	Integer idx = 1;
	
	while(rs.next()){
			jsa_detil +=" 		<tr> "
				+" 			<td width=30 valign=top> "
				+" 				<p align=center ><font size =\"1\">"+idx+"</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=left ><font size =\"1\">"+rs.getString("urutan_langkah_pekerjaan_dasar")+"</font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=top> "
				+" 				<p align=left ><font size =\"1\"> "+rs.getString("potensi_bahaya")+"</font></p> "
				+" 			</td> "
				+" 			<td width=390 valign=top> "
				+" 				<p align=left ><font size =\"1\">"+rs.getString("rekomendasi_aksi")+"</font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\">"+rs.getString("penanggung_jawab")+"</font></p> "
				+" 			</td> "
				+" 		</tr> ";
			idx+=1;
	}
	
	body_jsa_detil = " <p style=\"margin-top: 0px;margin-bottom:2px\">&nbsp;</p>	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=30 valign=top> "
				+" 				<p align=center ><font size =\"1\"><b>NO</b></font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\"><b>SEQUENCE OF BASIC JOB STEP</b></font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=top> "
				+" 				<p align=center ><font size =\"1\"><b>POTENTIAL HAZARDS</b></font></p> "
				+" 			</td> "
				+" 			<td width=390 valign=top> "
				+" 				<p align=center ><font size =\"1\"><b>RECOMMENDED ACTION</b></font></p> "
				+" 			</td> "
				+" 			<td width=130 valign=top> "
				+" 				<p align=center ><font size =\"1\"><b>PERSON IN CHARGE</b></font></p> "
				+" 			</td> "
				+" 		</tr> "
				+jsa_detil
				+" </table> " ;
	
// String root_path = "F:\\Tomcat7\\webapps\\k3pl\\files";
String root_path = getServletContext().getRealPath("\\files");
FileOutputStream fos = new FileOutputStream(root_path+"\\lap_jsa.doc");
	PrintWriter pw = new PrintWriter(fos);
	pw.println("<html> "
					+"<head> "
					+" <title>MOM Central Committee</title>"
					+"</head>"
					+"<body>"
					+ header
					+ body_jsa_detil
					// + body_insiden_wilayah
					// + header_kegiatan
					// + kegiatan_detil
					// + header_kegiatan_next
					// + kegiatan_detil_next
					// + header_area
					// + area_detil_next
					+" </div> "
					+"</body>"
					+"</html>");
	pw.close();
	fos.close();
	
	String fileName=getServletContext().getRealPath("\\files\\lap_jsa.doc");

	File f=new File(fileName);

	InputStream in = new FileInputStream(f);

	BufferedInputStream bin = new BufferedInputStream(in); 
	ServletOutputStream	httpout	= response.getOutputStream();
response.setHeader("Content-Disposition", "attachment; filename=\"lap_jsa.doc\"");
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
