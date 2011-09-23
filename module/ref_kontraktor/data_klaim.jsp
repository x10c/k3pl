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
	String		data	="{data:[";

	q	=" select	A.id"
		+" ,		A.id_repo"
		+" from		r_kontraktor_klm	A"
		+" ,		t_repo				B"
		+" where	A.id_repo		= B.id"
		+" and		A.id_kontraktor	= "+ id;

	rs = db_stmt.executeQuery(q);

	int i = 0;
	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}

		data+="{id		:"+ rs.getString("id")
			+ ",id_repo	:"+ rs.getString("id_repo")
			+ "}";
	}

	data +="]}";

	rs.close();
	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
