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
	int		dml				= Integer.parseInt(request.getParameter("dml_type"));
	String	id_stop			= request.getParameter("id_stop");
	String	status_aktif	= request.getParameter("status_aktif");

	db_stmt = db_con.createStatement();

	switch (dml) {
	case 3:
		db_q
		=" update	t_stop"
		+ " set		status_aktif	= '"+ status_aktif +"'"
		+" ,		id_user			= '"+ user_nipg +"' "
		+" ,		tanggal_akses	= getdate() "
		+ " where	id_stop			= "+ id_stop +";";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_q+=" insert into __log (nipg, nama_menu, status_akses) values ("
		+" '"+ user_nipg +"'"
		+",'"+ session.getAttribute("menu.id") +"'"
		+",'"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
