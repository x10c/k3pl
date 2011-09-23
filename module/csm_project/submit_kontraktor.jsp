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

	int		dml 			= Integer.parseInt(request.getParameter("dml"));
	String	id_proyek		= request.getParameter("id_proyek");
	String	id_kontraktor	= request.getParameter("id_kontraktor");
	String	q;

	switch (dml) {
	case 2:
		q	=" insert into t_csm_proyek_kontraktor ("
			+"		id_project"
			+" ,	id_kontraktor"
			+" ) values ("+ id_proyek +","+ id_kontraktor +")";
		break;
	case 4:
		q	="	delete from t_csm_proyek_kont_nilai"
			+"	where	id_project		= "+ id_proyek
			+"	and		id_kontraktor	= "+ id_kontraktor
			+";	delete from t_csm_proyek_kontraktor"
			+"	where	id_project		= "+ id_proyek
			+"	and		id_kontraktor	= "+ id_kontraktor;
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
