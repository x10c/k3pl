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

	q
	=" update	r_k3pl"
	+" set	email_server		='"+ request.getParameter("email_server") +"'"
	+" ,	email_server_port	= "+ request.getParameter("email_server_port")
	+" ,	email_use_auth		= "+ request.getParameter("email_use_auth")
	+" ,	email_username		='"+ request.getParameter("email_username") +"'"
	+" ,	email_password		='"+ request.getParameter("email_password") +"'"
	+" ,	email_stop_notif_active	= "+ request.getParameter("stop_active")
	+" ,	email_stop_sender	='"+ request.getParameter("stop_sender") +"'"
	+" ,	email_stop_subject	='"+ request.getParameter("stop_subject") +"'"
	+" ,	email_stop_content	='"+ request.getParameter("stop_content") +"'"
	+" ,	email_rca_notif_active	= "+ request.getParameter("rca_active")
	+" ,	email_rca_sender	='"+ request.getParameter("rca_sender") +"'"
	+" ,	email_rca_subject	='"+ request.getParameter("rca_subject") +"'"
	+" ,	email_rca_content	='"+ request.getParameter("rca_content") +"'";

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah diperbaharui.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
