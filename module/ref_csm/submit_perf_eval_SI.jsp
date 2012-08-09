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
	int		dml 		= Integer.parseInt(request.getParameter("dml"));
	String	id			= request.getParameter("id");
	String	min			= request.getParameter("min");
	String	max			= request.getParameter("max");
	String	keterangan	= request.getParameter("keterangan");

	switch (dml) {
	case 2:
		db_q=" insert into r_csm_perf_eval_si ("
			+"		min"
			+" ,	max"
			+" ,	keterangan"
			+" ) values ("+ min +","+ max +",'"+ keterangan +"') ";
		break;
	case 3:
		db_q=" update	r_csm_perf_eval_si"
			+" set		min	= "+ min
			+" ,		max = "+ max
			+" ,		keterangan = '"+ keterangan +"'"
			+" where	id = "+ id;
		break;
	case 4:
		db_q=" delete from r_csm_perf_eval_si"
			+" where  id = "+ id;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+dml+")!");
		out.print (_return);
		return;
	}

	db_stmt = db_con.createStatement ();
	db_q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
			+ user_nipg +"','"+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");

	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
