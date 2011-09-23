<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
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
	String id_ptw						= request.getParameter("id_ptw");
	String id_uji_kandungan_gas_ptw		= request.getParameter("id_uji_kandungan_gas_ptw");
	String id_uji_kandungan_gas_ptw_old	= request.getParameter("id_uji_kandungan_gas_ptw_old");
	String hasil						= request.getParameter("hasil");
	String id_user						= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_ptw_uji_kandungan_gas(id_ptw, id_uji_kandungan_gas_ptw, hasil, id_user) "
			+" values ("
			+ id_ptw +", "
			+ id_uji_kandungan_gas_ptw +", '"
			+ hasil +"', '"
			+ id_user +"') ";
		break;
	case 3:
		q	=" update	t_ptw_uji_kandungan_gas "
			+" set		id_uji_kandungan_gas_ptw	= "+ id_uji_kandungan_gas_ptw +" "
			+" ,		hasil						= '"+ hasil +"' "
			+" ,		id_user						= '"+ id_user +"' "
			+" ,		tanggal_akses				= getdate() "
			+" where	id_ptw						= "+ id_ptw
			+" and		id_uji_kandungan_gas_ptw		= "+ id_uji_kandungan_gas_ptw_old;
		break;
	case 4:
		q	=" delete from	t_ptw_uji_kandungan_gas "
			+" where	id_ptw						= "+ id_ptw
			+" and		id_uji_kandungan_gas_ptw	= "+ id_uji_kandungan_gas_ptw;
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
