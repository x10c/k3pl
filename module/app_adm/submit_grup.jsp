<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q;
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int		dml			= Integer.parseInt(request.getParameter("dml_type"));
	String	id_grup		= request.getParameter("id_grup");
	String	nama_grup	= request.getParameter("nama_grup");
	String	ket_grup	= request.getParameter("keterangan_grup");

	switch (dml) {
	case 2:
		q	=" insert into __grup_user (nama_grup, keterangan_grup)"
			+" values ('"+ nama_grup +"', '"+ ket_grup +"' )";
		break;
	case 3:
		q	=" update	__grup_user"
			+" set		nama_grup		='"+ nama_grup +"'"
			+" ,		keterangan_grup	='"+ ket_grup +"'"
			+" where	id_grup			= "+ id_grup;
		break;
	case 4:
		q	=" delete from __user_grup where id_grup = "+ id_grup +";"
			+" delete from __hak_akses where id_grup = "+ id_grup +";"
			+" delete from __grup_user where id_grup = "+ id_grup;
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
