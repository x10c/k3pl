<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ include file="../modinit.jsp" %>
<%
try {
	int		dml 			= Integer.parseInt (request.getParameter("dml"));
	String	id				= (String) request.getParameter ("id");
	String	id_penilaian	= (String) request.getParameter ("id_penilaian");
	String	id_detail		= (String) request.getParameter ("id_detail");
	String	id_detail2		= (String) request.getParameter ("id_detail2");
	String	penilaian		= (String) request.getParameter ("penilaian");
	String	nilai			= (String) request.getParameter ("nilai");

	db_stmt = db_con.createStatement();

	switch (dml) {
	case 2:
		db_q	=" insert into r_csm_penilaian2_penilaian ("
				+"		id_penilaian"
				+" ,	id_detail"
				+" ,	id_detail2"
				+" ,	penilaian"
				+" ,	nilai"
				+" ) values ("
				+		id_penilaian
				+" , "+ id_detail
				+" , "+ id_detail2
				+" ,'"+ penilaian +"'"
				+" , "+ nilai
				+" );";
		break;
	case 3:
		db_q	=" update	r_csm_penilaian2_penilaian"
				+" set		penilaian	='"+ penilaian +"'"
				+" ,		nilai		= "+ nilai
				+" where	id			= "+ id;
		break;
	case 4:
		db_q	=" delete from r_csm_penilaian2_penilaian"
				+" where  id = "+ id;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+dml+")!");
		out.print (_return);
		return;
	}

	db_q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
			+ user_nipg +"','"+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
