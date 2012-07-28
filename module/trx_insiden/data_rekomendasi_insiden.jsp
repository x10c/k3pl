<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
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
	String		id_insiden	= request.getParameter("id_insiden");

	if ( id_insiden.equals("0") || id_insiden.equals("")) {
		id_insiden ="0 or 1 = 1 ";
	}

	String q= " select   id_insiden "
			+ " ,        id_insiden_rekomendasi "
			+ " ,        rekomendasi "
			+ " ,        penanggung_jawab "
			+ " ,        replace(convert(varchar, tanggal_selesai, 111), '/', '-') tanggal_selesai"
			+ " from     t_insiden_rekomendasi "
			+ " where    id_insiden = "+ id_insiden
			+ " order by id_insiden, id_insiden_rekomendasi ";

	ResultSet	rs 		= db_stmt.executeQuery(q);
	int			i 		= 0;
	String		data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_insiden") +"' "
			+  ", '"+ rs.getString("id_insiden_rekomendasi") +"' "
			+  ", '"+ rs.getString("rekomendasi") +"' "
			+  ", '"+ rs.getString("penanggung_jawab") +"' "
			+  ", '"+ rs.getString("tanggal_selesai") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
