<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_name	= ServletUtilities.getCookieValue (cookies, "user.name", null);
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", null);
	String		user_email	= ServletUtilities.getCookieValue (cookies, "user.email", null);
	String		user_seksi	= ServletUtilities.getCookieValue (cookies, "user.seksi", null);
	String		user_dinas	= ServletUtilities.getCookieValue (cookies, "user.dinas", null);
	String		user_dep	= ServletUtilities.getCookieValue (cookies, "user.departemen", null);
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", null);
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", null);

	if (null == user_name || null == user_nipg || null == user_email
	|| null == user_seksi || null == user_dinas || null == user_dep
	|| null == user_div || null == user_dir) {
		out.print ("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect (request.getContextPath());
		return;
	}

	Statement	db_stmt	= null;
	ResultSet	db_rs	= null;
	String		db_q	= "";
	JSONArray	json_a	= null;
	JSONObject	json_o	= null;
	String		data	= "";
%>
