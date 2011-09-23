<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Prasetya
--%>


<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
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
	
	
	JSONObject	data_obj;
	JSONArray	data	= new JSONArray((String) request.getParameter("store"));
	Integer l,idx;
	
	String body = "";
	l = data.length();
	for (idx = 0; idx < l; idx++) {
		data_obj = data.getJSONObject(idx);
		body += " 		<tr> "
				+" 			<td width=30 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+idx+"</font></p> "
				+" 			</td> "
				+" 			<td width=150 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("name")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("teknik_bulan")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50  valign=middle> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("teknik_tahun")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("teknik_kumul")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("servis_bulan")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("servis_tahun")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("servis_kumul")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("kontrak_bulan")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("kontrak_tahun")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("kontrak_kumul")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("kum_bulan")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("kum_tahun")+"</font></p> "
				+" 			</td> "
				+" 			<td width=50 valign=center halign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\">"+data_obj.getString("kum_kumul")+"</font></p> "
				+" 			</td> "
				+" 		</tr> ";

	}
	String header = "";
		header =	"<div> "
				+" 	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center> "
				+" 		<tr> "
				+" 			<th width=30 valign=middle rowspan=2> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>No</b></font></p> "
				+" 			</th> "
				+" 			<th width=150  valign=middle rowspan=2> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Keterangan</b></font></p> "
				+" 			</th> "
				+" 			<th width=50  valign=middle colspan = 3> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Teknik</b></font></p> "
				+" 			</th> "
				+" 			<th width=50  valign=middle colspan = 3> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Servis</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center colspan = 3 > "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Bulan</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center colspan = 3 > "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Teknik</b></font></p> "
				+" 			</th> "
				+" 		</tr> "
				+" 		<tr> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Bulan</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center > "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Tahun</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Kumulatif</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Bulan</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center > "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Tahun</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Kumulatif</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Bulan</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center > "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Tahun</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Kumulatif</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Bulan</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center > "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Tahun</b></font></p> "
				+" 			</th> "
				+" 			<th width=50 valign=center> "
				+" 				<p align=center style=\"margin-top: 0px;margin-bottom:2px\"><font size =\"1\"><b>Kumulatif</b></font></p> "
				+" 			</th> "
				+" 		</tr> "
				+" 	</table> ";
	
// String root_path = "F:\\Tomcat7\\webapps\\k3pl\\files";
String root_path = getServletContext().getRealPath("\\files");
FileOutputStream fos = new FileOutputStream(root_path+"\\lap_unjuk_kerja.xls");
	PrintWriter pw = new PrintWriter(fos);
	pw.println("<html> "
					+"<head> "
					+" <title>MOM Central Committee</title>"
					+"</head>"
					+"<body>"
					+ header
					+ body
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
	
	String fileName=getServletContext().getRealPath("\\files\\lap_unjuk_kerja.xls");

	File f=new File(fileName);

	InputStream in = new FileInputStream(f);

	BufferedInputStream bin = new BufferedInputStream(in); 
	ServletOutputStream	httpout	= response.getOutputStream();
response.setHeader("Content-Disposition", "attachment; filename=\"lap_unjuk_kerja.xls\"");
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
