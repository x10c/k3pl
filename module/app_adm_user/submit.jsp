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

	Statement db_stmt = db_con.createStatement();

	String dml			= request.getParameter("dml_type");
	String nipg			= request.getParameter("nipg");
	String password		= request.getParameter("password");
	String status_user	= request.getParameter("status_user");
	String q;

	if (dml.equals("2")) {
		q	=" insert into __user ("
			+" 	nipg"
			+" ,	password"
			+" ,	status_user"
			+" )"
			+" values ("
			+"  '"+ nipg
			+"','"+ password
			+"','"+ status_user
			+"')";

	} else if (dml.equals("3")) {
		q	=" update	__user"
			+" set		status_user	= '"+ status_user +"'"
			+" ,		password	= '"+ password +"'"
			+" where 	nipg		= '"+ nipg +"'";

	} else if (dml.equals("update_stat")) {
		q	=" update	__user"
			+" set		status_user	= '"+ status_user +"'"
			+" where 	nipg		= '"+ nipg +"'";

			dml = "3";
	} else if (dml.equals("4")) {
		q	=" delete from	__user "
			+" where	nipg = '"+ nipg +"'";
	} else {
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
