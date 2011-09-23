<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_user = (String) session.getAttribute("user.nipg");

	int			dml						= Integer.parseInt(request.getParameter("dml_type"));
	String		id_pha					= request.getParameter("id_pha");
	String		id_pha_phr				= request.getParameter("id_pha_phr");
	String		process_step			= request.getParameter("process_step");
	String		what_if					= request.getParameter("what_if");
	String		consequence				= request.getParameter("consequence");
	String		protection_now			= request.getParameter("protection_now");
	String		frequency_category		= request.getParameter("frequency_category");
	String		consequence_category	= request.getParameter("consequence_category");
	String		risk_score				= request.getParameter("risk_score");
	String		resp					= request.getParameter("resp");
	String		status_of_question		= request.getParameter("status_of_question");
	String		q;
	Date		date	= new Date();

	switch (dml) {
	case 2:
		id_pha_phr	= Long.toString(date.getTime());
		
		q	=" insert into t_pha_phr (id_pha, id_pha_phr, process_step, what_if, consequence, protection_now, frequency_category, consequence_category, risk_score, resp, status_of_question, id_user) "
			+" values ("+ id_pha
			+", "+ id_pha_phr 
			+", '"+ process_step + "'"
			+", '"+ what_if +"'"
			+", '"+ consequence +"'"
			+", '"+ protection_now +"'"
			+", '"+ frequency_category + "'"
			+", '"+ consequence_category + "'"
			+", '"+ risk_score + "'"
			+", '"+ resp +"'"
			+", '"+ status_of_question +"'"
			+", '"+ id_user +"')";
		break;

	case 3:
		q	=" update t_pha_phr "
			+" set "
			+"   process_step			= '"+ process_step +"' "
			+" , what_if				= '"+ what_if +"' "
			+" , consequence			= '"+ consequence +"' "
			+" , protection_now			= '"+ protection_now +"' "
			+" , frequency_category		= '"+ frequency_category + "' "
			+" , consequence_category	= '"+ consequence_category + "' "
			+" , risk_score				= '"+ risk_score + "' "
			+" , resp					= '"+ resp +"' "
			+" , status_of_question		= '"+ status_of_question +"' "
			+" , id_user				= '"+ id_user +"' "
			+" , tanggal_akses			= getdate() "
			+" where 	id_pha			= "+ id_pha
			+" and		id_pha_phr		= "+ id_pha_phr;
		break;

	case 4:
		q	=" delete from t_pha_phr "
			+" where  	id_pha			= "+ id_pha
			+" and		id_pha_phr		= "+ id_pha_phr;
		break;

	default:
		out.print("{success: false,info: 'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
