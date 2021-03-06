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
		+" ,		nilai"
		+" ,        keterangan"
		+" from     r_csm_project_work_level"
		+" order by nilai asc";

	ResultSet	rs		= db_stmt.executeQuery(q);
	JSONArray	data	= new JSONArray ();
	JSONArray	element	= null;
	String		ket		= null;

	while (rs.next()) {
		element = new JSONArray ();
		element.put(rs.getString("id"));

		ket = "("+ rs.getString("nilai") +") "+ rs.getString("keterangan");
		element.put(ket);

		data.put(element);
	}

	out.print(data.toString());

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
