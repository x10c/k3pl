<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	String		id_direktorat	= request.getParameter("id_direktorat");

	if (id_direktorat == null || id_direktorat.equals("0")) {
		id_direktorat ="0 or 1 = 1 ";
	}

	String q= " select   id_direktorat"
			+ " ,        id_divprosbu"
			+ " ,        nama_divprosbu"
			+ " from     r_divprosbu"
			+ " where    id_direktorat = "+ id_direktorat
			+ " order by id_divprosbu, id_direktorat";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="["+ rs.getString("id_direktorat")
				+ ","+ rs.getString("id_divprosbu")
				+ ",'"+ rs.getString("nama_divprosbu") +"'"
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
