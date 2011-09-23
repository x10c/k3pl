<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - - prasetya (prasetya.yanuar@googlemail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();	

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_pssr							= request.getParameter("id_pssr");
	String nipg				= request.getParameter("nipg");
	String nipg_old				= request.getParameter("nipg_old");
	String id_jabatan_pssr						= request.getParameter("id_jabatan_pssr");
	String id_user							= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_pssr_keanggotaan(id_pssr, nipg,id_jabatan_pssr, id_user) "
			+" values ("
			+ id_pssr +", '"
			+ nipg +"', '"
			+ id_jabatan_pssr +"', '"
			+ id_user +"') ";
		break;

	case 3:
		q	=" update	t_pssr_reference "
			+" set		nipg	= '"+ nipg +"' "
			+" ,		id_jabatan_pssr							= '"+ id_jabatan_pssr +"' "
			+" ,		id_user							= '"+ id_user +"' "
			+" ,		tanggal_akses					= getdate() "
			+" where	id_pssr							= "+ id_pssr
			+" and	nipg							= '"+ nipg_old+"'";
		break;

	case 4:
		q	=" delete from	t_pssr_reference "
			+" where	nipg			= '"+ nipg
			+"' and		id_pssr	= "+ id_pssr;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}
	
	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{ success: true, info:'Data telah tersimpan.' }");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
