<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - agus sugianto (agus.delonge@gmail.com)
 %
 % WARNING: do not use modinit.jsp
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
JSONObject _return = new JSONObject ();
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	String		id_dir	= request.getParameter("id_direktorat");
	JSONArray	div		= null;

	if (id_dir == null || id_dir.equals("0")) {
		id_dir ="0 or 1 = 1 ";
	}

	Statement	db_stmt	= db_con.createStatement();
	String		db_q	= " select   id_direktorat"
				+ " ,        id_divprosbu"
				+ " ,        nama_divprosbu"
				+ " ,        status_divprosbu"
				+ " from     r_divprosbu"
				+ " where    id_direktorat = "+ id_dir
				+ " order by id_divprosbu, id_direktorat";
	ResultSet	db_rs	= db_stmt.executeQuery (db_q);
	JSONArray	json_a	= new JSONArray ();

	while (db_rs.next()) {
		div = new JSONArray ();
		div.put (db_rs.getString ("id_direktorat"));
		div.put (db_rs.getString ("id_divprosbu"));
		div.put (db_rs.getString ("nama_divprosbu"));
		div.put (db_rs.getString ("status_divprosbu"));

		json_a.put (div);
	}

	out.print (json_a);

	db_rs.close();
	db_stmt.close();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
