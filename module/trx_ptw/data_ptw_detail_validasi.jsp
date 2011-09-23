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
	String		id_ptw		= request.getParameter("id_ptw");

	if ( id_ptw.equals("0")) {
		id_ptw ="0 or 1 = 1 ";
	}

	String q= " select   id_ptw "
		+ " ,        id_ptw_validasi "
		+ " ,        hari"
		+ " ,        waktu_mulai"
		+ " ,        waktu_selesai"
		+ " ,        nama_pelaksana"
		+ " ,        inisial_pelaksana"
		+ " ,        nama_pengawas"
		+ " ,        inisial_pengawas"
		+ " from     t_ptw_validasi "
		+ " where    id_ptw = "+ id_ptw
		+ " order by id_ptw, id_ptw_validasi ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_ptw") +"' "
			+  ", '"+ rs.getString("id_ptw_validasi") +"' "
			+  ", '"+ rs.getString("hari") +"' "
			+  ", '"+ rs.getString("waktu_mulai") +"' "
			+  ", '"+ rs.getString("waktu_selesai") +"' "
			+  ", '"+ rs.getString("nama_pelaksana") +"' "
			+  ", '"+ rs.getString("inisial_pelaksana") +"' "
			+  ", '"+ rs.getString("nama_pengawas") +"' "
			+  ", '"+ rs.getString("inisial_pengawas") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
