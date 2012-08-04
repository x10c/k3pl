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
	int		dml		= Integer.parseInt(request.getParameter("dml_type"));
	String	id_grup	= request.getParameter("id_grup");
	String	nipg	= request.getParameter("nipg");

	db_stmt = db_con.createStatement();

	switch (dml) {
	case 2:
		db_q=" insert into __user_grup ("
			+"		nipg"
			+" ,	id_grup"
			+" ) values ("
			+" '"+ nipg +"'"
			+", "+ id_grup
			+")";
		break;
	case 4:
		db_q=" delete	from	__user_grup"
			+" where	id_grup = "+ id_grup
			+" and		nipg	='"+ nipg +"'";
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
