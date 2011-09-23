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

	ResultSet	rs;
	String		q;

	q= " "
	+ " select   a.id_pssr "
	+ " ,        a.id_project "
	+ " ,		replace(convert(varchar, b.tanggal_mulai, 111), '/', '-') tanggal_mulai"
	+ " ,        a.lokasi "
	+ " ,		replace(convert(varchar, a.tanggal, 111), '/', '-') tanggal"
	+ " from     t_pssr as a "
	+ " ,     r_project as b "
	+ " where     a.id_project = b.id_project ";

	rs = db_stmt.executeQuery(q);

	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("id_pssr")
			+ "','"+ rs.getString("id_project")
			+ "','"+ rs.getString("tanggal_mulai")
			+ "','"+ rs.getString("lokasi")
			+ "','"+ rs.getString("tanggal")
			+ "']";
	}

	data += "]";


	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
