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
	ResultSet	rs;
	String		data = "{r_k3pl:[";

	q	=" select	target_tsaf"
		+" ,		target_ltif"
		+" ,		reset_jt_min_kecelakaan"
		+" ,		reset_jt_min_nilai_rusak"
		+" from		r_k3pl";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false,info:'Data tidak ada!'}");
		return;
	}

	data	+="{target_tsaf			:"+ rs.getString("target_tsaf")
		+ ",target_ltif			:"+ rs.getString("target_ltif")
		+ ",reset_jt_min_kecelakaan	:"+ rs.getString("reset_jt_min_kecelakaan")
		+ ",reset_jt_min_nilai_rusak	:"+ rs.getString("reset_jt_min_nilai_rusak")
		+ "}]}";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
