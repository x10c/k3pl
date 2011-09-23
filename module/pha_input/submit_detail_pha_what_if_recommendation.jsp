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

	int			dml							= Integer.parseInt(request.getParameter("dml_type"));
	String		id_pha						= request.getParameter("id_pha");
	String		id_pha_phr					= request.getParameter("id_pha_phr");
	String		id_pha_phr_recommendation	= request.getParameter("id_pha_phr_recommendation");
	String		recommendation				= request.getParameter("recommendation");
	String		q;
	Date		date	= new Date();

	switch (dml) {
	case 2:
		id_pha_phr_recommendation	= Long.toString(date.getTime());
		
		q	=" insert into t_pha_phr_recommendation (id_pha, id_pha_phr, id_pha_phr_recommendation, recommendation, id_user) "
			+" values ("+ id_pha +", "+ id_pha_phr +", "+ id_pha_phr_recommendation +", '"+ recommendation +"', '"+ id_user +"')";
		break;

	case 3:
		q	=" update t_pha_phr_recommendation "
			+" set "
			+"   recommendation	= '"+ recommendation +"' "
			+" , id_user		= '"+ id_user +"' "
			+" , tanggal_akses	= getdate() "
			+" where 	id_pha						= "+ id_pha
			+" and		id_pha_phr					= "+ id_pha_phr
			+" and		id_pha_phr_recommendation	= "+ id_pha_phr_recommendation;
		break;

	case 4:
		q	=" delete from t_pha_phr_recommendation "
			+" where  	id_pha						= "+ id_pha
			+" and		id_pha_phr					= "+ id_pha_phr
			+" and		id_pha_phr_recommendation	= "+ id_pha_phr_recommendation;
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
