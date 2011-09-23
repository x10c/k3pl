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
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();	
	String		id_jsa		= request.getParameter("id_jsa");

	if ( id_jsa.equals("0")) {
		id_jsa ="0 or 1 = 1 ";
	}

	String q= " select   id_jsa "
		+ " ,        id_jsa_detail "
		+ " ,        urutan_langkah_pekerjaan_dasar "
		+ " ,        potensi_bahaya "
		+ " ,        rekomendasi_aksi "
		+ " ,        penanggung_jawab "
		+ " from     t_jsa_detail "
		+ " where    id_jsa = "+ id_jsa
		+ " order by id_jsa, id_jsa_detail ";

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
			+  ", '"+ rs.getString("id_jsa_detail") +"' "
			+  ", '"+ rs.getString("urutan_langkah_pekerjaan_dasar") +"' "
			+  ", '"+ rs.getString("potensi_bahaya") +"' "
			+  ", '"+ rs.getString("rekomendasi_aksi") +"' "
			+  ", '"+ rs.getString("penanggung_jawab") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
