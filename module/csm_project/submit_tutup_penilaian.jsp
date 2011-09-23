<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.*" %>
<%
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_user	= (String) session.getAttribute("user.nipg");

	String	id_proyek		= request.getParameter("id_proyek");
	String	id_kontraktor	= request.getParameter("id_kontraktor");
	String	q;

	q	=" update	t_csm_proyek"
		+" set		id_kontraktor	= "+ id_kontraktor
		+" where	id_project		= "+ id_proyek;

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ id_user +"','"+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
