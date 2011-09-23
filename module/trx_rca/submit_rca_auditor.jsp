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

	String		dml			= request.getParameter("dml_type");
	String		id_rca		= request.getParameter("id_rca");
	String		nipg		= request.getParameter("nipg");
	String		nipg_old	= request.getParameter("nipg_old");
	String		q;

	if (dml.equals("insert")) {
		q	=" insert into t_rca_auditor (id_rca, nipg, id_user) " 
			+" values ("+ id_rca +" ,"+ nipg +" ,'"+ id_user + "')";
	} else if (dml.equals("update")) {
		q	=" update t_rca_auditor "
			+" set "
			+"   nipg			= "+ nipg +" "
			+" , id_user		= '"+ id_user +"' "
			+" , tanggal_akses	= getdate() "
			+" where 	id_rca	= "+ id_rca
			+" and		nipg	= "+ nipg_old;

	} else if (dml.equals("delete")) {
		q	=" delete from t_rca_auditor "
			+" where  	id_rca 	=  "+ id_rca
			+" and		nipg	= "+ nipg;
	} else {
		out.print("{success: false"
			+ ",info   : 'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
