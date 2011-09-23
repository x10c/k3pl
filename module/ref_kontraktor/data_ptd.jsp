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

	Statement	db_stmt = db_con.createStatement();
	ResultSet	rs		= null;
	String		id		= request.getParameter("id");
	String		data	= "{data:[";
	int			i		= 0;

	if (id == null || id.equals("")) {
		data += "]}";
		out.print(data);
		return;
	}

	q	=" select	id"
		+" ,		tempat"
		+" ,		jenis"
		+" ,		nilai"
		+" from		r_kontraktor_ptd"
		+" where	id_kontraktor = "+ id;

	rs	= db_stmt.executeQuery(q);

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		data+=	"{ id		:"+ rs.getString("id")
			+	", tempat	:'"+ rs.getString("tempat").replace("'","\\'") +"'"
			+	", jenis	:'"+ rs.getString("jenis").replace("'","\\'") +"'"
			+	", nilai	:'"+ rs.getString("nilai").replace("'","\\'") +"'"
			+	"}";
	}

	data += "]}";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
