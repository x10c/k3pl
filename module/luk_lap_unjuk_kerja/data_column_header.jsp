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
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();

	String		q;
	String		output = "[";
	int		i;

	q	=" select	id_klasifikasi_pegawai"
		+" ,		nama_klasifikasi_pegawai"
		+" from		r_klasifikasi_pegawai"
		+" order by	id_klasifikasi_pegawai";

	ResultSet rs = db_stmt.executeQuery(q);

	i = 0;
	while (rs.next()) {
		if (i > 0) {
			output += ",";
		} else {
			i = 1;
		}

		output	+="{ id:'"+ rs.getString("id_klasifikasi_pegawai") +"'"
			+ ", name:'"+ rs.getString("nama_klasifikasi_pegawai") +"'"
			+ "}";
	}
	output += "]";

	out.print(output);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
