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

	Statement	db_stmt	= db_con.createStatement();
	String		o		= "{data:[";

	String q=" select	chart_delay, gallery_delay"
			+" from		r_k3pl";

	ResultSet rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		o += "]}";
	} else {
		o	+=	"{chart_delay:"+ rs.getString("chart_delay")
			+	",gallery_delay:"+ rs.getString("gallery_delay")
			+	"}]}";
	}

	out.print(o);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
