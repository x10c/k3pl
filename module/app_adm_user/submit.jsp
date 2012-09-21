<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	String dml			= request.getParameter("dml_type");
	String nipg			= request.getParameter("nipg");
	String password		= request.getParameter("password");
	String status_user	= request.getParameter("status_user");

	db_stmt = db_con.createStatement();

	if (dml.equals("2")) {
		db_q=" insert into __user ("
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
		db_q=" update	__user"
			+" set		password	= '"+ password +"'"
			+" where 	nipg		= '"+ nipg +"'";

	} else if (dml.equals("update_stat")) {
		db_q=" update	__user"
			+" set		status_user	= '"+ status_user +"'"
			+" where 	nipg		= '"+ nipg +"'";

		dml = "3";
	} else if (dml.equals("4")) {
		db_q=" delete from	__user "
			+" where	nipg = '"+ nipg +"'";
	} else {
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+ dml +")!");
		out.print (_return);
		return;
	}

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
