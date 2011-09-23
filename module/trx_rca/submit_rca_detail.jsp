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

	String		id_user = (String) session.getAttribute("user.nipg");

	int			dml						= Integer.parseInt(request.getParameter("dml_type"));
	String		id_rca					= request.getParameter("id_rca");
	String		id_rca_detail			= request.getParameter("id_rca_detail");
	String		description				= request.getParameter("description");
	String		good_citizens			= request.getParameter("good_citizens");
	String		violators				= request.getParameter("violators");
	String		number_of_violations	= request.getParameter("number_of_violations");
	String		id_severity				= request.getParameter("id_severity");
	String		violation_x_severity	= request.getParameter("violation_x_severity");
	String		li_45					= request.getParameter("li_45");
	String		li_apd					= request.getParameter("li_apd");
	String		li_housekeeping			= request.getParameter("li_housekeeping");
	String		li_process_safety		= request.getParameter("li_process_safety");
	String		li_fire_safety			= request.getParameter("li_fire_safety");
	String		actions					= request.getParameter("actions");
	String		status					= request.getParameter("status");
	String		completion_date_target	= request.getParameter("completion_date_target");
	String		completion_date_actual	= request.getParameter("completion_date_actual");
	String		note					= request.getParameter("note");
	String		q;

	switch (dml) {
	case 2:
		q	=" insert into t_rca_detail (id_rca, description, good_citizens, violators, "
			+" number_of_violations, id_severity, violation_x_severity, "
			+" li_45, li_apd, li_housekeeping, li_process_safety, li_fire_safety, "
			+" actions, status, completion_date_target, completion_date_actual, note, id_user) " 
			+" values ("+ id_rca +" ,'"+ description +"' ,"+ good_citizens +" ,"+ violators +" , "
			+" "+ number_of_violations +" ,"+ id_severity +" ,"+ violation_x_severity +" , "
			+" "+ li_45 +" ,"+ li_apd +" ,"+ li_housekeeping +" ,"+ li_process_safety +" ,"+ li_fire_safety +" , "
			+" '"+ actions +"' ,'"+ status +"' ,'"+ completion_date_target +"' ,'"+ completion_date_actual +"' ,'"+ note +"' , "
			+" '"+ id_user + "')";
		break;

	case 3:
		q	=" update t_rca_detail "
			+" set "
			+"   description			= '"+ description +"' "
			+" , good_citizens			= "+ good_citizens +" "
			+" , violators				= "+ violators +" "
			+" , number_of_violations	= "+ number_of_violations +" "
			+" , id_severity			= "+ id_severity +" "
			+" , violation_x_severity	= "+ violation_x_severity +" "
			+" , li_45					= "+ li_45 +" "
			+" , li_apd					= "+ li_apd +" "
			+" , li_housekeeping		= "+ li_housekeeping +" "
			+" , li_process_safety		= "+ li_process_safety +" "
			+" , li_fire_safety			= "+ li_fire_safety +" "
			+" , actions				= '"+ actions +"' "
			+" , status					= '"+ status +"' "
			+" , completion_date_target	= cast('"+ completion_date_target +"' as datetime) "
			+" , completion_date_actual	= cast('"+ completion_date_actual +"' as datetime) "
			+" , note					= '"+ note +"' "
			+" , id_user				= '"+ id_user +"' "
			+" , tanggal_akses			= getdate() "
			+" where 	id_rca_detail	= "+ id_rca_detail;
		break;

	case 4:
		q	=" delete from t_rca_detail "
			+" where  	id_rca_detail 	=  "+ id_rca_detail;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
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
