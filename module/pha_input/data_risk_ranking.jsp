<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		frequency_category 		= request.getParameter("frequency_category");
	String		consequence_category 	= request.getParameter("consequence_category");
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	risk_score "
	 +" from	r_risk_ranking_matrix "
	 +" where	frequency_category		= '" + frequency_category + "'"
	 +" and		consequence_category	= '" + consequence_category + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Risk Ranking tidak ditemukan!'}");
		return;
	}

	data	="{ risk_score : '" + rs.getString("risk_score") + "'}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
