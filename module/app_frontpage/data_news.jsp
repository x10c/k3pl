<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt	= db_con.createStatement();
	JSONObject	data	= new JSONObject();
	JSONObject	anew	= null;
	JSONArray	news	= new JSONArray();

	String q=" select	id"
			+" ,		replace(convert(varchar, date_published, 111), '/', '-') published"
			+" ,		subject"
			+" ,		url"
			+" ,		content"
			+" from		t_home_news"
			+" order by	date_published desc, date_updated desc";

	ResultSet	rs		= db_stmt.executeQuery(q);

	while (rs.next()) {
		anew = new JSONObject();

		anew.put("id", rs.getString("id"));
		anew.put("date_published", rs.getString("published"));
		anew.put("subject", rs.getString("subject"));
		anew.put("url", rs.getString("url"));
		anew.put("content", rs.getString("content"));

		news.put(anew);
	}

	data.put("data", news);

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
