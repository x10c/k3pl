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

	ResultSet	rs;
	Statement	db_stmt	= db_con.createStatement();
	String		id_user	= (String) session.getAttribute("user.nipg");
	String		lama	= request.getParameter("lama");
	String		baru	= request.getParameter("baru");

	q	=" update	r_pegawai"
		+" set		email		= '"+ baru +"'"
		+" where	nipg		= '"+ id_user +"'";

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	session.setAttribute("user.email", baru);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
