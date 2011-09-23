<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

	String	o;
	int	i = 0;

	q	=" select	nipg"
		+" ,		nama_pegawai"
		+" from		r_pegawai"
		+" where	status_pegawai = '1'"
		+" order by	nama_pegawai";

	ResultSet rs = db_stmt.executeQuery(q);

	o = "[";
	while (rs.next()) {
		if (i > 0) {
			o += ",";
		} else {
			i = 1;
		}

		o	+="['"+ rs.getString("nipg") +"'"
			+",\""+ rs.getString("nama_pegawai") +"\""
			+"]";
	}
	o += "]";

	out.print(o);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
