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

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String risk_score			= request.getParameter("risk_score");
	String risk_score_old		= request.getParameter("risk_score_old");
	String description			= request.getParameter("description");
	String note					= request.getParameter("note");
	String action_required		= request.getParameter("action_required");
	String pha_recommendation	= request.getParameter("pha_recommendation");
	String id_user				= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_risk_definition("
			+"	risk_score"
			+" ,	description"
			+" ,	note"
			+" ,	action_required"
			+" ,	pha_recommendation"
			+" ,	id_user"
			+" ) values ('"+ risk_score +"', '"+ description +"', '"+ note +"', '"+ action_required +"', '"+ pha_recommendation +"', '"+ id_user +"' )";
		break;
	case 3:
		q	=" update	r_risk_definition "
			+" set		risk_score			= '"+ risk_score +"' "
			+" ,		description			= '"+ description +"' "
			+" ,		note				= '"+ note +"' "
			+" ,		action_required		= '"+ action_required +"' "
			+" ,		pha_recommendation	= '"+ pha_recommendation +"' "
			+" ,		id_user				= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	risk_score			=  '"+ risk_score_old + "'";
		break;
	case 4:
		q	=" delete from r_risk_definition "
			+" where  risk_score	=  '"+ risk_score + "'";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{ success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
