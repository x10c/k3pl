<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

	q	=" select   id"
		+" ,		weight_factor"
		+" ,        element"
		+" from     r_csm_perf_eval";

	ResultSet	rs		= db_stmt.executeQuery(q);
	JSONArray	data	= new JSONArray ();
	JSONArray	element	= null;

	while (rs.next()) {
		element = new JSONArray ();
		element.put(rs.getString("id"));
		element.put(rs.getString("weight_factor"));
		element.put(rs.getString("element"));

		data.put(element);
	}

	out.print(data.toString());

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
