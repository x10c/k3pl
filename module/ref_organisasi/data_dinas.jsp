<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
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
	String		id_departemen	= request.getParameter("id_departemen");

	if (id_departemen == null || id_departemen.equals("0")) {
		id_departemen ="0 or 1 = 1 ";
	}

	String q= " select   id_departemen"
		+ " ,        id_dinas"
		+ " ,        nama_dinas"
		+ " from     r_dinas"
		+ " where    id_departemen = "+ id_departemen
		+ " order by id_dinas, id_departemen";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="["+ rs.getString("id_departemen")
			+ ","+ rs.getString("id_dinas")
			+ ",'"+ rs.getString("nama_dinas") +"'"
			+ "]";
	}

	data += "]";

	out.print(data);

	rs.close();
	db_stmt.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
