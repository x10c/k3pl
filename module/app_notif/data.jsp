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
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt	= db_con.createStatement();
	ResultSet	rs;
	JSONObject	data = new JSONObject();

	q
	=" select	email_server"
	+" ,		email_server_port"
	+" ,		email_use_auth"
	+" ,		email_username"
	+" ,		email_password"
	+" ,		email_stop_notif_active"
	+" ,		email_stop_sender"
	+" ,		email_stop_subject"
	+" ,		email_stop_content"
	+" ,		email_rca_notif_active"
	+" ,		email_rca_sender"
	+" ,		email_rca_subject"
	+" ,		email_rca_content"
	+" from		r_k3pl";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		return;
	}

	data.put("email_server", rs.getString("email_server"));
	data.put("email_server_port", Integer.parseInt(rs.getString("email_server_port")));
	data.put("email_use_auth", Integer.parseInt(rs.getString("email_use_auth")));
	data.put("email_username", rs.getString("email_username"));
	data.put("email_password", rs.getString("email_password"));

	data.put("stop_active", Integer.parseInt(rs.getString("email_stop_notif_active")));
	data.put("stop_sender", rs.getString("email_stop_sender"));
	data.put("stop_subject", rs.getString("email_stop_subject"));
	data.put("stop_content", rs.getString("email_stop_content"));

	data.put("rca_active", Integer.parseInt(rs.getString("email_rca_notif_active")));
	data.put("rca_sender", rs.getString("email_rca_sender"));
	data.put("rca_subject", rs.getString("email_rca_subject"));
	data.put("rca_content", rs.getString("email_rca_content"));

	out.print("{r_k3pl:["+ data.toString() +"]}");

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
