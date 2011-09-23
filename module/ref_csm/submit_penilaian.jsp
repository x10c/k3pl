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

	int		dml 		= Integer.parseInt(request.getParameter("dml"));
	String	id			= request.getParameter("id");
	String	id_faktor	= request.getParameter("id_faktor");
	String	keterangan	= request.getParameter("keterangan");
	String	q;

	switch (dml) {
	case 2:
		q	=" insert into r_csm_penilaian ("
			+"		id_faktor"
			+" ,	keterangan"
			+" ) values ("
			+ id_faktor
			+",'"+ keterangan +"'"
			+");";
		break;
	case 3:
		q	=" update	r_csm_penilaian"
			+" set		keterangan	='"+ keterangan +"'"
			+" where	id = "+ id;
		break;
	case 4:
		q	=" delete from r_csm_penilaian"
			+" where  id = "+ id;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ id_user +"','"+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
