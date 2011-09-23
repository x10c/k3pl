<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
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

	int			dml				= Integer.parseInt(request.getParameter("dml_type"));
	String		tahun			= request.getParameter("tahun");
	String		tahun_old		= request.getParameter("tahun_old");
	String		bulan			= request.getParameter("bulan");
	String		bulan_old		= request.getParameter("bulan_old");
	String		pekerjaan		= request.getParameter("pekerjaan");
	String		lokasi_proyek	= request.getParameter("lokasi_proyek");
	
	String		q 		= "";

	switch (dml) {
	case 2:
		q	=" insert into t_lingkungan_bulanan (tahun, bulan, pekerjaan, lokasi_proyek, id_user)"
			+" values ("+ tahun +", "+ bulan +", '"+ pekerjaan +"', '"+ lokasi_proyek +"', '"+ id_user + "')";

		break;
	case 3:
		q	=" update t_lingkungan_bulanan "
			+" set "
			+"   tahun			= "+ tahun
			+" , bulan			= "+ bulan
			+" , pekerjaan		= '"+ pekerjaan + "'"
			+" , lokasi_proyek	= '"+ lokasi_proyek +"'"
			+" , id_user		= '"+ id_user +"'"
			+" , tanggal_akses	= getdate() "
			+" where 	tahun	=  "+ tahun_old
			+" and		bulan	=  "+ bulan_old;
			
		break;
	case 4:
		q	=" delete from t_lingkungan_bulanan "
			+" where	tahun	=  "+ tahun
			+" and		bulan	=  "+ bulan;

		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
