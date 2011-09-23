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
	JSONObject	item	= null;
	JSONArray	all		= new JSONArray();

	String q=" select	id"
			+" ,		replace(convert(varchar, date_uploaded, 111), '/', '-') uploaded"
			+" ,		filename"
			+" ,		description"
			+" from		t_home_gallery"
			+" order by	date_uploaded desc";

	ResultSet rs = db_stmt.executeQuery(q);

	while (rs.next()) {
		item = new JSONObject();

		item.put("id", rs.getString("id"));
		item.put("date_uploaded", rs.getString("uploaded"));
		item.put("filename", rs.getString("filename"));
		item.put("description", rs.getString("description"));

		all.put(item);
	}

	data.put("data", all);

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
