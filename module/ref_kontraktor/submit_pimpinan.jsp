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

	Statement	db_stmt			= db_con.createStatement();
	int			dml				= Integer.parseInt(request.getParameter("dml"));
	String		id				= request.getParameter("id");
	String		id_kontraktor	= request.getParameter("id_kontraktor");
	String		id_jab			= request.getParameter("id_jab");
	String		nama			= request.getParameter("nama");
	String		lama_bekerja	= request.getParameter("lama_bekerja");

	switch (dml) {
	case 2:
		q	=" insert into r_kontraktor_pim ("
			+"		id_kontraktor"
			+" ,	id_jab"
			+" ,	nama"
			+" ,	lama_bekerja"
			+" ) values ("
			+	id_kontraktor
			+" , "+ id_jab
			+" ,'"+ nama +"'"
			+" , "+ lama_bekerja
			+" )";
		break;

	case 3:
		q	=" update r_kontraktor_pim"
			+" set		id_jab			= "+ id_jab
			+" ,		nama			='"+ nama +"'"
			+" ,		lama_bekerja	= "+ lama_bekerja
			+" where	id				= "+ id;
		break;

	case 4:
		q	=" delete from r_kontraktor_pim"
			+" where	id = "+ id;
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
