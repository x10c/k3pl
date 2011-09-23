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

	int			dml					= Integer.parseInt(request.getParameter("dml_type"));
	String		id_pha				= request.getParameter("id_pha");
	String		id_pha_reference	= request.getParameter("id_pha_reference");
	String		reference			= request.getParameter("reference");
	String		q;
	Date		date	= new Date();

	switch (dml) {
	case 2:
		id_pha_reference	= Long.toString(date.getTime());
		
		q	=" insert into t_pha_reference (id_pha, id_pha_reference, reference, id_user) "
			+" values ("+ id_pha +", "+ id_pha_reference +", '"+ reference +"', '"+ id_user +"')";
		break;

	case 3:
		q	=" update t_pha_reference "
			+" set "
			+"   reference		= '"+ reference +"' "
			+" , id_user		= '"+ id_user +"' "
			+" , tanggal_akses	= getdate() "
			+" where 	id_pha				= "+ id_pha
			+" and		id_pha_reference	= "+ id_pha_reference;
		break;

	case 4:
		q	=" delete from t_pha_reference "
			+" where  	id_pha				= "+ id_pha
			+" and		id_pha_reference	= "+ id_pha_reference;
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
