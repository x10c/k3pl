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
		+ " ,        id_uji_kandungan_gas_ptw "
		+ " ,        id_uji_kandungan_gas_ptw as id_uji_kandungan_gas_ptw_old"
		+ " ,        hasil"
		+ " from     t_ptw_uji_kandungan_gas "
		+ " where    id_ptw = "+ id_ptw
		+ " order by id_ptw, id_uji_kandungan_gas_ptw ";

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
			+  ", '"+ rs.getString("id_uji_kandungan_gas_ptw") +"' "
			+  ", '"+ rs.getString("id_uji_kandungan_gas_ptw_old") +"' "
			+  ", '"+ rs.getString("hasil") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
