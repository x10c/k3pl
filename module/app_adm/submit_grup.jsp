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
	int		dml			= Integer.parseInt(request.getParameter("dml_type"));
	String	id_grup		= request.getParameter("id_grup");
	String	nama_grup	= request.getParameter("nama_grup");
	String	ket_grup	= request.getParameter("keterangan_grup");

	db_stmt = db_con.createStatement();

	switch (dml) {
	case 2:
		db_q=" insert into __grup_user (nama_grup, keterangan_grup)"
			+" values ('"+ nama_grup +"', '"+ ket_grup +"' )";
		break;
	case 3:
		db_q=" update	__grup_user"
			+" set		nama_grup		='"+ nama_grup +"'"
			+" ,		keterangan_grup	='"+ ket_grup +"'"
			+" where	id_grup			= "+ id_grup;
		break;
	case 4:
		db_q=" delete from __user_grup where id_grup = "+ id_grup +";"
			+" delete from __hak_akses where id_grup = "+ id_grup +";"
			+" delete from __grup_user where id_grup = "+ id_grup;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+dml+")!");
		out.print (_return);
		return;
	}

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
