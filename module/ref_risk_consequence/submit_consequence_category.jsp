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
	String consequence			= request.getParameter("consequence");
	String consequence_category	= request.getParameter("consequence_category");
	String description			= request.getParameter("description");
	String id_user				= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_risk_consequence_category("
			+"	consequence"
			+" ,	consequence_category"
			+" ,	description"
			+" ,	id_user"
			+" ) values ('"+ consequence +"', '"+ consequence_category +"', '"+ description +"', '"+ id_user +"' )";
		break;
	case 3:
		q	=" update	r_risk_consequence_category "
			+" set		description		= '"+ description +"' "
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses	= getdate() "
			+" where	consequence				= '"+ consequence + "'"
			+" and		consequence_category	= '"+ consequence_category + "'";
		break;
	case 4:
		q	=" delete from r_risk_consequence_category "
			+" where  	consequence				=  '"+ consequence + "'"
			+" and		consequence_category	=  '"+ consequence_category + "'";
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
