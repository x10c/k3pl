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

	Statement	db_stmt	= db_con.createStatement();
	String		id		= request.getParameter("id_insiden");

	if (id.equals("0") || id.equals("")) {
		return;
	}

	String q=" update	t_insiden"
		+" set		status_reset = 0"
		+" where	status_reset = 1";

	db_stmt.executeUpdate(q);

	q	=" update	t_insiden"
		+" set		status_reset	= 1"
		+" where	id_insiden	= "+ id;

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan!'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
