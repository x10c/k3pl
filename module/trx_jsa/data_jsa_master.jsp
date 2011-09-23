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
	String		load_type	= (String) request.getParameter("load_type");
	String		nipg		= (String) session.getAttribute("user.nipg");


	String q= " select   id_jsa "
		+ " ,        no_dokumen "
		+ " ,        revisi "
		+ " ,        no_kontrak "
		+ " ,        nama_perusahaan "
		+ " from     t_jsa ";

	if (!load_type.equals("all")) {
		q+=" and	id_user		= '"+ nipg +"'";
	}

	q+=" order by id_jsa ";
	
	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_jsa")
			+  "','"+ rs.getString("no_dokumen")
			+  "','"+ rs.getString("revisi")
			+  "','"+ rs.getString("no_kontrak")
			+  "','"+ rs.getString("nama_perusahaan")
			+  "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
