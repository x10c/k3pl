<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya yanuar (prasetya.yanuar@googlemail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Statement	db_stmt = db_con.createStatement();
	
	String tipe_rapat = request.getParameter("type");
	String id_user		= (String) session.getAttribute("user.nipg");
	String q=" select	A.id_kel_jabatan_komite_sub_komite "
		+" ,		A.id_kel_jabatan_csc"
		+" from		r_jabatan_komite_sub_komite A"
		+" left join  t_pegawai_komite_sub_komite B on (B.id_jabatan_komite = A.id_jabatan_komite) "
		+" left join R_KEL_JABATAN_KOMITE_SUB_KOMITE C on (C.ID_KEL_JABATAN_KOMITE_SUB_KOMITE = A.ID_KEL_JABATAN_KOMITE_SUB_KOMITE) "
		+" where B.nipg = '"+ id_user +"' and A.notulen is not null and A.id_kel_jabatan_komite_sub_komite is not null"
		+" order by	A.id_kel_jabatan_csc ";
		
	ResultSet	rs_kel = db_stmt.executeQuery(q);
	q=" ";
	
	if (rs_kel.next()){
		
		 q= " select	A.id_rapat "
			+" ,		A.id_kel_jabatan_komite_sub_komite "
			+" , 		B.nama_kel_jabatan_komite_sub_komite "
			+" ,		A.no_rapat "
			+" ,		A.judul_rapat "
			+" ,		replace(convert(varchar, A.tanggal_rapat, 111), '/', '-') tanggal"
			+" ,		A.lokasi_rapat "
			+" ,		replace(convert(varchar, A.tanggal_notulen, 111), '/', '-') tanggal_notulen"
			+" , 		A.nama_notulis "
			+" from		t_rapat	A "
			+" left join r_kel_jabatan_komite_sub_komite B on a.id_kel_jabatan_komite_sub_komite = b.id_kel_jabatan_komite_sub_komite "
			+" where A.id_kel_jabatan_csc = "+ rs_kel.getString("id_kel_jabatan_csc") 
			+" and A.id_kel_jabatan_komite_sub_komite = "+ rs_kel.getString("id_kel_jabatan_komite_sub_komite") 
			+" order by	A.id_kel_jabatan_komite_sub_komite ";
	}else
	{
		q= " select	A.id_rapat "
			+" ,		A.id_kel_jabatan_komite_sub_komite "
			+" , 		B.nama_kel_jabatan_komite_sub_komite "
			+" ,		A.no_rapat "
			+" ,		A.judul_rapat "
			+" ,		replace(convert(varchar, A.tanggal_rapat, 111), '/', '-') tanggal"
			+" ,		A.lokasi_rapat "
			+" ,		replace(convert(varchar, A.tanggal_notulen, 111), '/', '-') tanggal_notulen"
			+" , 		A.nama_notulis "
			+" from		t_rapat	A "
			+" left join r_kel_jabatan_komite_sub_komite B on a.id_kel_jabatan_komite_sub_komite = b.id_kel_jabatan_komite_sub_komite "
			+" where 1=2 "
			+" order by	A.id_kel_jabatan_komite_sub_komite ";
	}
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("id_rapat")
			+ "','"+ rs.getString("id_kel_jabatan_komite_sub_komite")
			+ "','"+ rs.getString("nama_kel_jabatan_komite_sub_komite")
			+ "','"+ rs.getString("no_rapat")
			+ "','"+ rs.getString("judul_rapat")
			+ "','"+ rs.getString("tanggal")
			+ "','"+ rs.getString("lokasi_rapat")
			+ "','"+ rs.getString("tanggal_notulen")
			+ "','"+ rs.getString("nama_notulis")
			+ "']";
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
