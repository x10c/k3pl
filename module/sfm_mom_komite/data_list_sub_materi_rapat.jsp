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
	
	String		id_rapat	= request.getParameter("id_rapat");
	String		id_rapat_materi	= request.getParameter("id_rapat_materi");
	

	String q=" select	A.id_rapat "
		+" ,		A.id_rapat_materi "
		+" ,		A.id_rapat_sub_materi "
		+" , 		A.isi_rapat_sub_materi "
		+" ,		A.batas_waktu_sub_materi"
		+" ,		A.status_sub_materi "
		+" ,		A.keterangan_sub_materi "
		+" ,		B.nipg_pelaksana"
		+" ,		B.seksi_pelaksana"
		+" ,		B.nipg_supervisor"
		+" ,		B.dinas_supervisor"
		+" from		t_rapat_sub_materi	A "
		+" left join 	t_rapat_materi	D on (D.id_rapat_materi = A.id_rapat_materi and D.id_rapat = A.id_rapat )"
		+" left join 	t_pic_rapat_materi	B on (B.id_rapat_materi = A.id_rapat_materi and B.id_rapat = A.id_rapat )"
		+" where A.id_rapat = '"+ id_rapat +"' and A.id_rapat_materi = '"+ id_rapat_materi "' " 
		+" order by	A.id_rapat_materi ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String batas_waktu, keterangan_materi, nipg_pelaksana, nipg_supervisor, seksi_pelaksana, dinas_supervisor;
		String		data = "{ rows: [";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		batas_waktu = rs.getString("batas_waktu_sub_materi");
		keterangan_materi = rs.getString("keterangan_sub_materi");
		nipg_pelaksana = rs.getString("nipg_pelaksana");
		seksi_pelaksana = rs.getString("seksi_pelaksana");
		nipg_supervisor = rs.getString("nipg_supervisor");
		dinas_supervisor = rs.getString("dinas_supervisor");
		
		if (batas_waktu == null){
			batas_waktu = "";
		}
		if (keterangan_materi == null){
			keterangan_materi = "";
		}
		if (nipg_pelaksana == null){
			nipg_pelaksana = "";
		}
		if (nipg_supervisor == null){
			nipg_supervisor = "";
		}
		if (seksi_pelaksana == null){
			seksi_pelaksana = "";
		}
		if (dinas_supervisor == null){
			dinas_supervisor = "";
		}
		data	+="{ id_rapat			: '"+ rs.getString("id_rapat") +"' "
			+ ", id_rapat_materi		: '"+ rs.getString("id_rapat_materi") +"' "
			+ ", id_rapat_sub_materi		: '"+ rs.getString("id_rapat_sub_materi") +"' "
			+ ", isi_rapat_sub_materi		: '"+ rs.getString("isi_rapat_sub_materi") +"' "
			+ ", batas_waktu_sub_materi		: '"+ batas_waktu +"' "
			+ ", status_sub_materi			: '"+ rs.getString("status_sub_materi") +"' "
			+ ", keterangan_sub_materi			: '"+ keterangan_materi +"' "
			+ ", nipg_pelaksana			: '"+ nipg_pelaksana +"' "
			+ ", seksi_pelaksana			: '"+ seksi_pelaksana +"' "
			+ ", nipg_supervisor			: '"+ nipg_supervisor +"' "
			+ ", dinas_supervisor			: '"+ dinas_supervisor +"' "
			+  "}";
	}

	data += "]}";



	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
