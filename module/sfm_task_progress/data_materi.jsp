<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Statement	db_stmt = db_con.createStatement();
	
	String id_user		= (String) session.getAttribute("user.nipg");
	
	String q=" select	A.id_kel_jabatan_komite_sub_komite "
		+" from		r_jabatan_komite_sub_komite A"
		+" left join  t_pegawai_komite_sub_komite B on (B.id_jabatan_komite = A.id_jabatan_komite) "
		+" where B.nipg = "+ id_user +" and B.id_jabatan_komite in ('2','5','8','11','14','17','20') "
		+" order by	A.id_kel_jabatan_komite_sub_komite ";
		

	ResultSet	rs_kel = db_stmt.executeQuery(q);
	
	if (rs_kel.next()){
		q= " select	B.nipg_pelaksana "
		+" ,		B.nipg_supervisor "
		+" ,		A.id_rapat_materi "
		+" ,		A.id_rapat "
		+" ,		A.isi_rapat_materi "
		+" ,		A.batas_waktu_materi "
		+" ,		A.status_materi "
		+" ,		A.keterangan_materi "
		+" from		t_rapat_materi A"
		+" left join  t_pic_rapat_materi B on (B.id_rapat = A.id_rapat and B.id_rapat_materi = B.id_rapat_materi) "
		+" left join  t_rapat C on (C.id_rapat = A.id_rapat) "
		+" where C.id_kel_jabatan_komite_sub_komite = "+ rs_kel.getString("id_kel_jabatan_komite_sub_komite") 
		+" order by	B.id_rapat_materi ";
	}
	else {
		q=" select	B.nipg_pelaksana "
		+" ,		B.nipg_supervisor "
		+" ,		A.id_rapat_materi "
		+" ,		A.id_rapat "
		+" ,		A.isi_rapat_materi "
		+" ,		A.batas_waktu_materi "
		+" ,		A.status_materi "
		+" ,		A.keterangan_materi "
		+" from		t_rapat_materi A"
		+" left join  t_pic_rapat_materi B on (B.id_rapat = A.id_rapat and B.id_rapat_materi = B.id_rapat_materi) "
		+" where B.nipg_pelaksana = "+ id_user 
		+" order by	B.id_rapat_materi ";
	}
	
		

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "{ rows: [";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ nipg_pelaksana			: '"+ rs.getString("nipg_pelaksana") +"' "
			+ ",  nipg_pelaksana			: '"+ rs.getString("nipg_supervisor") +"' "
			+ ", id_rapat		: '"+ rs.getString("id_rapat") +"' "
			+ ", id_rapat_materi		: '"+ rs.getString("id_rapat_materi") +"' "
			+ ", isi_rapat_materi		: '"+ rs.getString("isi_rapat_materi") +"' "
			+ ", batas_waktu_materi		: '"+ rs.getString("batas_waktu_materi") +"' "
			+ ", status_materi			: '"+ rs.getString("status_materi") +"' "
			+ ", keterangan_materi			: '"+ rs.getString("keterangan_materi") +"' "
			+  "}";
	}

	data += "]}";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false, info:'"+ e +"'}");
}
%>
