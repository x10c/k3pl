<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

	q	=" select   A.id_project"
		+" ,		C.nama_project"
		+" ,		A.id_kontraktor"
		+" ,		B.nama as nama_kontraktor"
		+" ,		isnull(A.eval_weighted_score, 0.0) as weighted_score"
		+" ,		A.penghargaan_sanksi"
		+" from     t_csm_proyek	A"
		+" ,		r_kontraktor	B"
		+" ,		r_project		C"
		+" ,		r_csm_perf_eval_ps	D"
		+" where	A.id_kontraktor 		= B.id"
		+" and		A.id_project			= C.id_project"
		+" and		A.penghargaan_sanksi	= D.id"
		+" and		A.id_divprosbu			= " + user_div
		+" and		A.id_direktorat			= " + user_dir;

	ResultSet	rs		= db_stmt.executeQuery (q);
	JSONArray	data	= new JSONArray ();
	JSONArray	item	= null;

	while (rs.next()) {
		item = new JSONArray ();
		item.put (rs.getString ("id_project"));
		item.put (rs.getString ("nama_project"));
		item.put (rs.getString ("id_kontraktor"));
		item.put (rs.getString ("nama_kontraktor"));
		item.put (rs.getString ("weighted_score"));
		item.put (rs.getString ("penghargaan_sanksi"));

		data.put (item);
	}

	out.print (data.toString ());

	rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
