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
	String	nilai		= request.getParameter("nilai");
	String	keterangan	= request.getParameter("keterangan");
	String	q;

	switch (dml) {
	case 2:
		q	=" insert into r_csm_project_work_level ("
			+" 		nilai"
			+" ,	keterangan"
			+" ) values ("
			+"  "+ nilai
			+",'"+ keterangan +"'"
			+");";
		break;
	case 3:
		q	=" update	r_csm_project_work_level"
			+" set		keterangan	='"+ keterangan +"'"
			+" ,		nilai		= "+ nilai
			+" where	id = "+ id;
		break;
	case 4:
		q	=" delete from r_csm_project_work_level"
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
