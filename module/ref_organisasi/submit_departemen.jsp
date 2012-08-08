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
	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_direktorat	= request.getParameter("id_direktorat");
	String id_divprosbu		= request.getParameter("id_divprosbu");
	String id_departemen	= request.getParameter("id_departemen");
	String nama_departemen	= request.getParameter("nama_departemen");

	db_stmt = db_con.createStatement();

	switch (dml) {
	case 2:
		db_q=" insert into	r_departemen (id_direktorat, id_divprosbu, nama_departemen, id_user) "
			+" values ("
			+ id_direktorat +","
			+ id_divprosbu +","
			+ "'"+ nama_departemen +"',"
			+ "'"+ user_nipg +"') ";
		break;
	case 3:
		db_q=" update	r_departemen "
			+" set		nama_departemen	= '"+ nama_departemen +"' "
			+" ,		id_user		= '"+ user_nipg +"' "
			+" ,		tanggal_akses	= getdate() "
			+" where	id_departemen   = "+ id_departemen
			+" and		id_divprosbu	= "+ id_divprosbu
			+" and		id_direktorat	= "+ id_direktorat;
		break;
	case 4:
		db_q=" delete from	r_departemen "
			+" where	id_departemen =  "+ id_departemen
			+" and		id_divprosbu	= "+ id_divprosbu
			+" and		id_direktorat	= "+ id_direktorat;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+dml+")!");
		out.print (_return);
		return;
	}

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"');";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
