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
	String		id_divprosbu	= request.getParameter("id_divprosbu");
	String		id_departemen	= request.getParameter("id_departemen");
	String		id_dinas		= request.getParameter("id_dinas");

	if (id_direktorat == null || id_direktorat.equals("0")) {
		id_direktorat ="0 or 1 = 1 ";
	}

	if (id_direktorat == null || id_divprosbu == null || id_divprosbu.equals("0")) {
		id_divprosbu ="0 or 1 = 1 ";
	}

	if (id_direktorat == null || id_divprosbu == null || id_departemen == null || id_departemen.equals("0")) {
		id_departemen ="0 or 1 = 1 ";
	}

	if (id_direktorat == null || id_divprosbu == null || id_departemen == null || id_dinas == null || id_dinas.equals("0")) {
		id_dinas ="0 or 1 = 1 ";
	}

	String q=" select   id_direktorat"
			+" ,        id_divprosbu"
			+" ,        id_departemen"
			+" ,        id_dinas"
			+" ,        id_seksi"
			+" ,        nama_seksi"
			+" from		r_seksi"
			+" where	id_direktorat	= "+ id_direktorat
			+" and		id_divprosbu	= "+ id_divprosbu
			+" and		id_departemen	= "+ id_departemen
			+" and		id_dinas		= "+ id_dinas
			+" order by id_seksi, id_dinas, id_departemen, id_divprosbu, id_direktorat";

	ResultSet	rs 		= db_stmt.executeQuery(q);
	int			i 		= 0;
	String		data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="["+ rs.getString("id_direktorat")
				+ ","+ rs.getString("id_divprosbu")
				+ ","+ rs.getString("id_departemen")
				+ ","+ rs.getString("id_dinas")
				+ ","+ rs.getString("id_seksi")
				+ ",'"+ rs.getString("nama_seksi") +"'"
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
