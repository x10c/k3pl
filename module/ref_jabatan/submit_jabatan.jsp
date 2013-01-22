<%--
 % Copyright 2013 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
try {
	int		dml				= Integer.parseInt (request.getParameter("dml_type"));
	String	id_jabatan		= request.getParameter ("id_jabatan");
	String	nama_jabatan	= request.getParameter ("nama_jabatan");
	String	pj_rca			= request.getParameter ("pj_rca");

	switch (dml) {
	case 2:
		db_q=" insert into r_jabatan (nama_jabatan, pj_rca, id_user)"
			+" values ('"+ nama_jabatan +"', "+ pj_rca +" ,'"+ user_nipg +"')";
		break;
	case 3:
		db_q=" update	r_jabatan"
			+" set		nama_jabatan	= '"+ nama_jabatan +"'"
			+" ,		pj_rca			= "+ pj_rca
			+" ,		id_user			= '"+ user_nipg +"'"
			+" ,		tanggal_akses	= getdate()"
			+" where	id_jabatan	= "+ id_jabatan;
		break;
	case 4:
		db_q= " delete from r_jabatan where id_jabatan = "+ id_jabatan;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+ dml +")!");
		out.print (_return);
		return;
	}

	db_stmt = db_con.createStatement();
	db_q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
			+ user_nipg +"','"
			+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);
	db_stmt.close ();

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e){
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
