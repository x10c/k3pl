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
	String frequency_category	= request.getParameter("frequency_category");
	String consequence_category	= request.getParameter("consequence_category");
	String risk_score			= request.getParameter("risk_score");
	String id_user				= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_risk_ranking_matrix("
			+"	frequency_category"
			+" ,	consequence_category"
			+" ,	risk_score"
			+" ,	id_user"
			+" ) values ('"+ frequency_category +"', '"+ consequence_category +"', '"+ risk_score +"', '"+ id_user +"' )";
		break;
	case 3:
		q	=" update	r_risk_ranking_matrix "
			+" set		risk_score		= '"+ risk_score + "' "
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses	= getdate() "
			+" where	frequency_category		= '"+ frequency_category + "' "
			+" and		consequence_category	= '"+ consequence_category + "' ";
		break;
	case 4:
		q	=" delete from r_risk_ranking_matrix "
			+" where	frequency_category		= '"+ frequency_category + "' "
			+" and		consequence_category	= '"+ consequence_category + "' ";
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
