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
	String	nilai_min	= request.getParameter("nilai_min");
	String	nilai_max	= request.getParameter("nilai_max");
	String	keterangan	= request.getParameter("keterangan");
	String	q;

	switch (dml) {
	case 2:
		q	=" insert into r_csm_perf_eval_ps ("
			+" 		nilai_min"
			+" ,	nilai_max"
			+" ,	keterangan"
			+" ) values ("
			+"  "+ nilai_min
			+", "+ nilai_max
			+",'"+ keterangan +"'"
			+");";
		break;
	case 3:
		q	=" update	r_csm_perf_eval_ps"
			+" set		keterangan	='"+ keterangan +"'"
			+" ,		nilai_min	= "+ nilai_min
			+" ,		nilai_max	= "+ nilai_max
			+" where	id = "+ id;
		break;
	case 4:
		q	=" delete from r_csm_perf_eval_ps"
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
