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

	String q=" select	A.id_rapat "
		+" ,		A.id_tipe_rapat "
		+" , 		B.nama_tipe_rapat "
		+" ,		A.no_rapat "
		+" ,		A.judul_rapat "
		+" ,		replace(convert(varchar, A.tanggal_rapat, 111), '/', '-') tanggal"
		+" ,		A.lokasi_rapat "
		+" ,		A.tanggal_notulen "
		+" , 		A.nama_notulis "
		+" from		t_rapat	A "
		+" left join r_tipe_rapat B on a.id_tipe_rapat = b.id_tipe_rapat "
		+" where A.id_tipe_rapat = "+ tipe_rapat
		+" order by	A.id_rapat ";

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
			+ "','"+ rs.getString("id_tipe_rapat")
			+ "','"+ rs.getString("nama_tipe_rapat")
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
