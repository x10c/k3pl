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

	int			dml							= Integer.parseInt(request.getParameter("dml_type"));
	String		id_area_perhatian_detail	= request.getParameter("id_area_perhatian_detail");
	String		tahun						= request.getParameter("tahun");
	String		bulan						= request.getParameter("bulan");
	String		id_wilayah					= request.getParameter("id_wilayah");
	String		id_tipe_area_perhatian		= request.getParameter("id_tipe_area_perhatian");
	String		nama_area_perhatian			= request.getParameter("nama_area_perhatian");
	String		q;

	switch (dml) {
	case 2:
		q	=" insert into t_area_perhatian_detail (tahun, bulan, id_wilayah, id_tipe_area_perhatian, nama_area_perhatian, id_user) "
			+" values ("+ tahun +" ,"+ bulan +" ,"+ id_wilayah +" ,"+ id_tipe_area_perhatian +" ,'"+ nama_area_perhatian +"' ,'"+ id_user +"' )";
		break;

	case 3:
		q	=" update t_area_perhatian_detail "
			+" set "
			+"   id_wilayah				= "+ id_wilayah
			+" , id_tipe_area_perhatian	= "+ id_tipe_area_perhatian
			+" , nama_area_perhatian	= '"+ nama_area_perhatian +"' "
			+" , id_user				= '"+ id_user +"' "
			+" , tanggal_akses			= getdate() "
			+" where 	id_area_perhatian_detail	= "+ id_area_perhatian_detail;
		break;

	case 4:
		q	=" delete from t_area_perhatian_detail "
			+" where  	id_area_perhatian_detail	= "+ id_area_perhatian_detail;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
