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
	Date currentDate = new Date();
	
	String		year	= request.getParameter("year");
	String		month	= request.getParameter("month");
	
		
	String q = " select		b.nama_wilayah "
			 + "		,	a.lokasi_pengelolaan_lingkungan "
			 + "		,	a.tipe_station "
			 + "		,	a.parameter "
			 + "		,	a.sumber_dampak "
			 + " from		t_pengelolaan_lingkungan	as a "
			 + " left join	r_wilayah					as b on B.id_wilayah = a.id_wilayah "
			 + " where		MONTH(a.tanggal_pengelolaan_lingkungan) = " + month
			 + " and		YEAR(a.tanggal_pengelolaan_lingkungan) = " + year;

	ResultSet	rs	= db_stmt.executeQuery(q);
	
	String body;
	body = "";
	
	while (rs.next()){ 
		body += " 		<tr> "
				+" 			<td width=200 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("nama_wilayah")+"</font></p> "
				+" 			</td> "
				+" 			<td width=200  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("lokasi_pengelolaan_lingkungan")+"</font></p> "
				+" 			</td> "
				+" 			<td width=150  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("tipe_station")+"</font></p> "
				+" 			</td> "
				+" 			<td width=250 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("parameter")+"</font></p> "
				+" 			</td> "
				+" 			<td width=200 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\">"+rs.getString("sumber_dampak")+"</font></p> "
				+" 			</td> "
				+" 		</tr> ";

	}
	String header = "";
		header =	"<div> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<td width=200 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>Wilayah</b></font></p> "
				+" 			</td> "
				+" 			<td width=200  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>Lokasi</b></font></p> "
				+" 			</td> "
				+" 			<td width=150  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>Tipe Station</b></font></p> "
				+" 			</td> "
				+" 			<td width=250  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>Parameter</b></font></p> "
				+" 			</td> "
				+" 			<td width=200 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"2\"><b>Sumber Dampak</b></font></p> "
				+" 			</td> "
				+" 		</tr> "
				+ body
				+" 	</table> ";
	
// String root_path = "F:\\Tomcat7\\webapps\\k3pl\\files";
String root_path = getServletContext().getRealPath("\\files");
FileOutputStream fos = new FileOutputStream(root_path+"\\lap_lingkungan.xls");
	PrintWriter pw = new PrintWriter(fos);
	pw.println("<html> "
					+"<head> "
					+" <title>MOM Central Committee</title>"
					+"</head>"
					+"<body>"
					+ header
					// + body_jsa_detil
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
	
	String fileName=getServletContext().getRealPath("\\files\\lap_lingkungan.xls");

	File f=new File(fileName);

	InputStream in = new FileInputStream(f);

	BufferedInputStream bin = new BufferedInputStream(in); 
	ServletOutputStream	httpout	= response.getOutputStream();
response.setHeader("Content-Disposition", "attachment; filename=\"lap_lingkungan.xls\"");
response.setContentType("application/vnd.ms-excel");	
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
