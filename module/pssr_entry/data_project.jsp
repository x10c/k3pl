<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - prasetya (prasetya.yanuar@googlemail.com)
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


	String q= " select   id_project "
		+ " ,        no_project "
		+ " ,        nama_project "
	+ " ,		replace(convert(varchar, tanggal_mulai, 111), '/', '-') tanggal_mulai"
		+ " from     r_project ";

	q+=" order by id_project ";
	
	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_project")
			+  "','"+ rs.getString("no_project")
			+  "','"+ rs.getString("nama_project")
			+  "','"+ rs.getString("tanggal_mulai")
			+  "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
