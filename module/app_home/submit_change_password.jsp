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

	q	=" select	nipg"
		+" from		__user"
		+" where	nipg		= '"+ id_user +"'"
		+" and		password	= '"+ lama +"'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false,info:'Password lama Anda salah!'}");
		return;
	}

	rs.close();

	q	=" update	__user"
		+" set		password	= '"+ baru +"'"
		+" where	nipg		= '"+ id_user +"'";

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
