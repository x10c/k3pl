<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - Prasetya Yanuar (mieh100freak@gmail.com)
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

	String dml			= request.getParameter("dml_type");
	String id_rapat		= request.getParameter("id");
	String id_kel_jabatan_komite_sub_komite	= request.getParameter("type");
	String no_rapat	= request.getParameter("sfm_no");
	String judul_rapat	= request.getParameter("title");
	String tanggal_rapat		= request.getParameter("date");
	String lokasi_rapat	= request.getParameter("place");
	String tanggal_notulen	= request.getParameter("note_date");
	String nama_notulis	= request.getParameter("note_writer");
	String id_user			= (String) session.getAttribute("user.nipg");
	String q, p;
	Date		date	= new Date();
	
	if (id_rapat.equals("")){
		id_rapat = Long.toString(date.getTime());
	}

	if (dml.equals("insert")) {
		q	=" insert into t_rapat ("
			+"		id_rapat "
			+" ,	id_kel_jabatan_komite_sub_komite "
			+" ,	no_rapat "
			+" ,	judul_rapat "
			+" ,	tanggal_rapat "
			+" ,	lokasi_rapat "
			+" ,	tanggal_notulen "
			+" ,	nama_notulis "
			+" ,	id_user "
			+" ) values ( "
			+ 		id_rapat 		
			+", "+ 	id_kel_jabatan_komite_sub_komite 	
			+", '"+ no_rapat 		+"' "
			+", '"+	judul_rapat 	+"' "
			+", 	cast('"+  tanggal_rapat +"' as datetime)  "
			+", '"+	lokasi_rapat 	+"' "
			+", 	cast('"+  tanggal_notulen +"' as datetime)  "
			+", '"+	nama_notulis 	+"' "
			+", '"+	id_user 		+"' )";
		
			
	} else if (dml.equals("update")) {
		q	=" update	t_rapat "
			+" set		no_rapat			= '"+ no_rapat +"' "
			+" ,		judul_rapat			= '"+ judul_rapat +"' "
			+" ,		tanggal_rapat		= cast('"+  tanggal_rapat +"' as datetime) "
			+" ,		lokasi_rapat		= '"+ lokasi_rapat +"' "
			+" ,		tanggal_notulen		= cast('"+  tanggal_notulen +"' as datetime) "
			+" ,		nama_notulis		= '"+ nama_notulis +"' "
			+" ,		id_user				= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_rapat			=  "+ id_rapat +" and id_kel_jabatan_komite_sub_komite = "+ id_kel_jabatan_komite_sub_komite;

	} else if (dml.equals("delete")) {
		q	=" delete from	t_rapat "
			+" where	id_rapat   =  "+ id_rapat +" and id_kel_jabatan_komite_sub_komite = "+ id_kel_jabatan_komite_sub_komite;
	} else {
		out.print("{ success:false"
			+ ", info   :'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}
	
	db_stmt.executeUpdate(q);
	
	if (dml.equals("insert")) {
				/* GET ID_RAPAT BEFORE new.tanggal_rapat*/
		q	=" SELECT TOP 1 TANGGAL_RAPAT, ID_RAPAT "
			+" FROM T_RAPAT "
			+" WHERE TANGGAL_RAPAT < '"+ tanggal_rapat +"' "
			+" ORDER BY TANGGAL_RAPAT DESC ";

			ResultSet	rs	= db_stmt.executeQuery(q);
			
			if(rs.next()){
					
				p  =" insert into t_rapat_absensi_komite_sub_komite ("
					+"		id_rapat "
					+" ,	nipg "
					+" ,	nama_peserta "
					+" ,	id_jabatan_komite "
					+" ,	status_absensi "
					+" , 	jml_hadir "
					+" , 	jml_absen "
					+" , 	id_user "
					+" ) select "
					+" "+ id_rapat 
					+" , a.nipg "
					+" , b.nama_pegawai "
					+" , c.id_jabatan_komite "
					+" ,  '0' "
					+" , d.jml_hadir "
					+" , (d.jml_absen + 1) jml_absen"
					+" , '"+ id_user +"' "
					+" from t_pegawai_komite_sub_komite a"
					+" left join r_pegawai b on b.nipg = a.nipg "
					+" left join r_jabatan_komite_sub_komite c on c.id_jabatan_komite = a.id_jabatan_komite "
					+" left join t_rapat_absensi_komite_sub_komite d on d.nipg = a.nipg and id_rapat = "+ rs.getString("id_rapat")
					+" where c.id_kel_jabatan_komite_sub_komite = 1 ";
			}
			else {
				p  =" insert into t_rapat_absensi_komite_sub_komite ("
					+"		id_rapat "
					+" ,	nipg "
					+" ,	nama_peserta "
					+" ,	id_jabatan_komite "
					+" ,	status_absensi "
					+" , 	jml_hadir "
					+" , 	jml_absen "
					+" , 	id_user "
					+" ) select "
					+" "+ id_rapat 
					+" , a.nipg "
					+" , b.nama_pegawai "
					+" , c.id_jabatan_komite "
					+" ,  '0' "
					+" , 0 "
					+" , 1 "
					+" , '"+ id_user +"' "
					+" from t_pegawai_komite_sub_komite a"
					+" left join r_pegawai b on b.nipg = a.nipg "
					+" left join r_jabatan_komite_sub_komite c on c.id_jabatan_komite = a.id_jabatan_komite "
					+" where c.id_kel_jabatan_komite_sub_komite = 1 ";

			}
			
			db_stmt.executeUpdate(p);
			rs.close();
			
			
	}
	
	out.print("{ success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{ success:false, info:'"+ e +"'}");
}
%>
