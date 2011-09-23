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
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_user = (String) session.getAttribute("user.nipg");

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_kel	= request.getParameter("id_kel");
	String id_tipe	= request.getParameter("id_tipe");
	String id	= request.getParameter("id");
	String name	= request.getParameter("name");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_detail_tipe_observasi ("
			+"	id_kel_tipe_observasi "
			+",	id_tipe_observasi "
			+",	nama_detail_tipe_observasi "
			+",	id_user "
			+" ) values ("
			+ id_kel +", "
			+ id_tipe +", '"
			+ name +"', '"
			+ id_user +"' )";
		break;
	case 3:
		q	=" update	r_detail_tipe_observasi "
			+" set		nama_detail_tipe_observasi	= '"+ name +"' "
			+" ,		id_user				= '"+ id_user +"' "
			+" ,		tanggal_akses			= getdate() "
			+" where	id_kel_tipe_observasi		= "+ id_kel
			+" and		id_tipe_observasi		= "+ id_tipe
			+" and		id_detail_tipe_observasi	= "+ id;
		break;
	case 4:
		q	=" delete	from r_detail_tipe_observasi "
			+" where	id_kel_tipe_observasi	= "+ id_kel
			+" and		id_tipe_observasi	= "+ id_tipe
			+" and		id_detail_tipe_observasi= "+ id;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
