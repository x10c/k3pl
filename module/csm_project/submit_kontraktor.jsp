<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
try {
	db_stmt = db_con.createStatement();

	int		dml 			= Integer.parseInt(request.getParameter("dml"));
	String	id_proyek		= request.getParameter("id_proyek");
	String	id_kontraktor	= request.getParameter("id_kontraktor");

	switch (dml) {
	case 2:
		db_q=" insert into t_csm_proyek_kontraktor2 ("
			+"		id_project"
			+" ,	id_kontraktor"
			+" ) values ("+ id_proyek +","+ id_kontraktor +")";
		break;
	case 4:
		db_q="	delete from t_csm_proyek_kont_nilai"
			+"	where	id_project		= "+ id_proyek
			+"	and		id_kontraktor	= "+ id_kontraktor
			+";	delete from t_csm_proyek_kontraktor2 "
			+"	where	id_project		= "+ id_proyek
			+"	and		id_kontraktor	= "+ id_kontraktor;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+dml+")");
		out.print (_return);
		return;
	}

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");

	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", true);
	_return.put ("info", e);
}
out.print (_return);
%>
