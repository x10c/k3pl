<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	String		id_user		= (String) session.getAttribute("user.nipg");

	int		dml				= Integer.parseInt(request.getParameter("dml_type"));
	String	id_stop			= request.getParameter("id_stop");
	String	status_aktif	= request.getParameter("status_aktif");

	switch (dml) {
	case 3:
		q=" update	t_stop"
		+ " set		status_aktif	= '"+ status_aktif +"'"
		+" ,		id_user		= '"+ id_user +"' "
		+" ,		tanggal_akses	= getdate() "
		+ " where	id_stop		= "+ id_stop;
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
