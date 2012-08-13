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
	String		id_rapat_materi	= request.getParameter("id_rapat_materi");
	
	String where_clause = "";
	int	found = 0;
	int	it = 0;
	String batas_waktu_sub_materi = "";
	String keterangan_sub_materi = "";
	
	String q=" select	B.nipg_pelaksana "
		+" ,		B.nipg_supervisor "
		+" ,		A.id_rapat_sub_materi "
		+" ,		A.id_rapat_materi "
		+" ,		A.id_rapat "
		+" ,		A.isi_rapat_sub_materi "
		+" ,		replace(convert(varchar, A.batas_waktu_sub_materi , 111), '/', '-') batas_waktu_sub_materi"
		+" ,		A.status_sub_materi "
		+" ,		A.keterangan_sub_materi "
		+" from		t_rapat_sub_materi A"
		+" left join  t_pic_rapat_materi B on (B.id_rapat = A.id_rapat and B.id_rapat_materi = A.id_rapat_materi) "
		+" where A.id_rapat_materi = '"+ id_rapat_materi +"' and B.nipg_supervisor = '"+ id_user +"' "
		+" order by	B.id_rapat_materi ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "{ rows: [";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		
		batas_waktu_sub_materi 	= rs.getString("batas_waktu_sub_materi");
		keterangan_sub_materi	= rs.getString("keterangan_sub_materi");
		
		if (batas_waktu_sub_materi == null || batas_waktu_sub_materi.equals("null")){
			batas_waktu_sub_materi = "";
		}
		if (keterangan_sub_materi == null || keterangan_sub_materi.equals("null")){
			keterangan_sub_materi = "";
		}
		
		data	+="{ nipg_pelaksana			: '"+ rs.getString("nipg_pelaksana") +"' "
			+ ",  nipg_supervisor			: '"+ rs.getString("nipg_supervisor") +"' "
			+ ", id_rapat					: '"+ rs.getString("id_rapat") +"' "
			+ ", id_rapat_materi			: '"+ rs.getString("id_rapat_materi") +"' "
			+ ", id_rapat_sub_materi		: '"+ rs.getString("id_rapat_sub_materi") +"' "
			+ ", isi_rapat_sub_materi		: '"+ rs.getString("isi_rapat_sub_materi") +"' "
			+ ", batas_waktu_sub_materi		: '"+ batas_waktu_sub_materi +"' "
			+ ", status_sub_materi			: '"+ rs.getString("status_sub_materi") +"' "
			+ ", keterangan_sub_materi			: '"+ keterangan_sub_materi +"' "
			+  "}";
	}

	data += "]}";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false, info:'"+ e +"'}");
}
%>
