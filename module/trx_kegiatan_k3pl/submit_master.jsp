<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
String	q 	= "";
String	q2 	= "";
String	q3	= "";

try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_user = (String) session.getAttribute("user.nipg");

	int			dml		= Integer.parseInt(request.getParameter("dml_type"));
	String		tahun	= request.getParameter("tahun");
	String		bulan	= request.getParameter("bulan");

	switch (dml) {
	case 2:
		q	=" insert into t_kegiatan (tahun, bulan, id_user)"
			+" values ("+ tahun +" ,"+ bulan +" ,'"+ id_user +"')";
		break;

	case 3:
		q	=" update t_kegiatan "
			+" set "
			+"   tahun			= "+ tahun
			+" , bulan			= "+ bulan
			+" , id_user		= '"+ id_user +"' "
			+" , tanggal_akses	= getdate() "
			+" where 	tahun	= "+ tahun
			+" and		bulan	= "+ bulan;
		break;

	case 4:
		q	=" delete from t_kegiatan_detail "
			+" where  	tahun = "+ tahun
			+" and		bulan = "+ bulan;
			
		q2	=" delete from t_area_perhatian_detail "
			+" where  	tahun = "+ tahun
			+" and		bulan = "+ bulan;

		q3	=" delete from t_kegiatan "
			+" where  	tahun = "+ tahun
			+" and		bulan = "+ bulan;

		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	db_stmt.executeUpdate(q);
	if (!q2.equals("")) {
		db_stmt.executeUpdate(q2);
	}
	if (!q3.equals("")) {
		db_stmt.executeUpdate(q3);
	}

	q	="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
