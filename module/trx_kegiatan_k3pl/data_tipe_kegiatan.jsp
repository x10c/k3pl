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

	String	q	=" select	id_tipe_kegiatan "
			+" ,		nama_tipe_kegiatan "
			+" from		r_tipe_kegiatan "
			+" order by	id_tipe_kegiatan ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ "+ rs.getString("id_tipe_kegiatan")
			+  ", '"+ rs.getString("nama_tipe_kegiatan") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
