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
	String		load_type	= (String) request.getParameter("load_type");

	String		id_pha_phr	= request.getParameter("id_pha_phr");

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	id_pha "
	+" ,		id_pha_phr "
	+" ,		process_step "
	+" ,		what_if "
	+" ,		consequence "
	+" ,		protection_now "
	+" ,		frequency_category "
	+" ,		consequence_category "
	+" ,		risk_score "
	+" ,		resp "
	+" ,		status_of_question "
	+" from		t_pha_phr "
	+" where	id_pha_phr 	= " + id_pha_phr;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data PHA What If tidak ditemukan!'}");
		return;
	}

	data	="{  id_pha	: "+ rs.getString("id_pha")
		+", id_pha_phr	: "+ id_pha_phr
		+", process_step	: '"+ rs.getString("process_step")
		+"', what_if : '"+ rs.getString("what_if")
		+"', consequence : '"+ rs.getString("consequence")
		+"', protection_now : '"+ rs.getString("protection_now")
		+"', frequency_category	: '"+ rs.getString("frequency_category")
		+"', consequence_category : '"+ rs.getString("consequence_category")
		+"', rr	: '"+ rs.getString("risk_score")
		+"', resp	: '"+ rs.getString("resp")
		+"', status_of_question	: '"+ rs.getString("status_of_question")
		+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
