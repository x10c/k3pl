<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya yanuar (prasetya.yanuar@googlemail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Statement	db_stmt = db_con.createStatement();
	
	String		id_rapat	= request.getParameter("id_rapat");
	String		tgl_rapat	= request.getParameter("tgl_rapat");
	
	if ( id_rapat.equals("0")
		|| id_rapat.equals("")) {
		id_rapat ="0 or 1 = 1 ";
	}
	
	if (tgl_rapat.equals("")){
		tgl_rapat = "1111-11-11";
	}
	
	String q=" select	A.id_rapat "
		+" ,		A.nipg "
		+" , 		B.nama_pegawai "
		+" ,		A.id_jabatan_komite "
		+" ,		A.status_absensi "
		+" ,		A.keterangan_absensi"
		+" ,		A.jml_hadir "
		+" ,		A.jml_absen"
		+" from		t_rapat_absensi_komite_sub_komite	A "
		+" left join r_pegawai B on B.nipg = A.nipg "
		+" where	A.id_rapat = "+ id_rapat;

	ResultSet	rs	= db_stmt.executeQuery(q);
	
	// get last attendance
	// q = " select  B.nipg "
	// +" , 	B.tanggal_rapat "
	// +" ,	coalesce(B.jml_hadir, 0) jml_hadir"
	// +" , 	coalesce(B.jml_absen, 0) jml_absen"
	// +" from t_rapat A "
	// +" left join t_rapat_absensi_komite_sub_komite B on B.id_rapat = A.id_rapat "
	// +" where A.id_tipe_rapat = '1' and A.tanggal_rapat < cast('"+ tgl_rapat +"' as datetime) "
	// +" group by A.id_rapat, b.jml_hadir, b.jml_absen"
	// +" order by A.id_rapat";
	
	// ResultSet	rs_attd = db_stmt.executeQuery(q);
	
	int		i	= 0;
	String 	temp_hadir = "0";
	String 	temp_absen = "0";
	String	keterangan = "";
	String	jabatan_komite = "";
	
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		// if (rs_attd.next()){
			// temp_hadir = rs_attd.getString("jml_hadir");
			// temp_absen = rs_attd.getString("jml_absen"); 
		// }
		
		keterangan = rs.getString("keterangan_absensi");
		jabatan_komite = rs.getString("id_jabatan_komite");
		if (keterangan == null){
			keterangan = "";
		}
		if (jabatan_komite.equals("0")){
			jabatan_komite = "";
		}
		
		data	+="[ '"+ rs.getString("id_rapat")
			+ "','"+ rs.getString("nipg")
			+ "','"+ rs.getString("nama_pegawai")
			+ "','"+ jabatan_komite
			+ "','"+ rs.getString("status_absensi")
			+ "','"+ keterangan
			+ "','"+ rs.getString("jml_hadir")
			+ "','"+ rs.getString("jml_absen")
			+ "']";
		
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
