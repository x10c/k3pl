<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
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
	String		id_wilayah	= request.getParameter("id_wilayah");

	if (id_wilayah == null || id_wilayah.equals("0") || id_wilayah.equals("")) {
		id_wilayah ="0 or 1 = 1 ";
	}

	String q=" select	id_departemen"
		+" ,		id_dinas"
		+" ,		id_wilayah"
		+" ,		id_seksi"
		+" ,		nama_seksi"
		+" from		r_seksi"
		+" where	id_wilayah = "+ id_wilayah
		+" order by	nama_seksi";

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
			+ ","+ rs.getString("id_wilayah")
			+ ","+ rs.getString("id_seksi")
			+ ",\""+ rs.getString("nama_seksi") +"\""
			+ "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
