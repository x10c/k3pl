<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	Statement	db_stmt		= db_con.createStatement();	

	String q= " select   id_jsa "
		+ " ,        no_dokumen "
		+ " ,        revisi "
		+ " ,        no_kontrak "
		+ " ,        nama_perusahaan "
		+ " ,        nama_proyek "
		+ " ,        nama_pic "
		+ " ,        aktifitas_pekerjaan "
		+ " ,        replace(convert(varchar, tanggal_jsa, 111), '/', '-') as tanggal_jsa "
		+ " ,        alat_pelindung_diri_digunakan "
		+ " from     t_jsa "
		+ " order by id_jsa ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_jsa") +"' "
			+  ", '"+ rs.getString("no_dokumen") +"' "
			+  ", '"+ rs.getString("revisi") +"' "
			+  ", '"+ rs.getString("no_kontrak") +"' "
			+  ", '"+ rs.getString("nama_perusahaan") +"' "
			+  ", '"+ rs.getString("nama_proyek") +"' "
			+  ", '"+ rs.getString("nama_pic") +"' "
			+  ", '"+ rs.getString("aktifitas_pekerjaan") +"' "
			+  ", '"+ rs.getString("tanggal_jsa") +"' "
			+  ", '"+ rs.getString("alat_pelindung_diri_digunakan") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
