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

	int		dml		= Integer.parseInt(request.getParameter("dml_type"));
	String	id_grup	= request.getParameter("id_grup");
	String	nipg	= request.getParameter("nipg");
	String	q;

	switch (dml) {
	case 2:
		q	=" insert into __user_grup ("
			+"		nipg"
			+" ,	id_grup"
			+" ) values ("
			+" '"+ nipg +"'"
			+", "+ id_grup
			+")";
		break;
	case 4:
		q	=" delete	from	__user_grup"
			+" where	id_grup = "+ id_grup
			+" and		nipg	='"+ nipg +"'";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
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
