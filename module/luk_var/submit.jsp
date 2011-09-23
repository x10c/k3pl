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

	Statement db_stmt = db_con.createStatement();

	String target_tsaf		= request.getParameter("target_tsaf");
	String target_ltif		= request.getParameter("target_ltif");
	String jt_min_kecelakaan	= request.getParameter("jt_min_kecelakaan");
	String jt_min_nilai_rusak	= request.getParameter("jt_min_nilai_rusak");

	q	=" update	r_k3pl"
		+" set		target_tsaf			= "+ target_tsaf
		+" ,		target_ltif			= "+ target_ltif;

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{ success: true, info:'Data telah tersimpan.' }");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
