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
		+" ,		id_kontraktor"
		+" ,		id_jab"
		+" ,		nama"
		+" ,		lama_bekerja"
		+" from		r_kontraktor_pim"
		+" where	id_kontraktor = "+ id;

	rs	= db_stmt.executeQuery(q);

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		data+=	"{ id			:"+ rs.getString("id")
			+	", id_kontraktor:"+ rs.getString("id_kontraktor")
			+	", id_jab		:"+ rs.getString("id_jab")
			+	", nama			:'"+ rs.getString("nama").replace("'", "\\'") +"'"
			+	", lama_bekerja	:"+ rs.getString("lama_bekerja")
			+	"}";
	}

	data += "]}";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
