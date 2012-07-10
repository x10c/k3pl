<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement	db_stmt = db_con.createStatement();

	int			dml						= Integer.parseInt(request.getParameter("dml_type"));
	String		id_kegiatan_detail		= request.getParameter("id_kegiatan_detail");
	String		tahun					= request.getParameter("tahun");
	String		bulan					= request.getParameter("bulan");
	String		id_wilayah				= request.getParameter("id_wilayah");
	String		id_tipe_kegiatan		= request.getParameter("id_tipe_kegiatan");
	String		nama_kegiatan			= request.getParameter("nama_kegiatan");
	String		q;

	switch (dml) {
	case 2:
		q	=" insert into t_kegiatan_detail (id_direktorat, id_divprosbu, tahun, bulan, id_wilayah, id_tipe_kegiatan, nama_kegiatan, id_user) "
			+" values ("+ user_dir + " ," + user_div + " ," + tahun +" ,"+ bulan +" ,"+ id_wilayah +" ,"+ id_tipe_kegiatan +" ,'"+ nama_kegiatan +"' ,'"+ user_nipg +"' )";
		break;

	case 3:
		q	=" update t_kegiatan_detail "
			+" set "
			+"   id_wilayah			= "+ id_wilayah
			+" , id_tipe_kegiatan	= "+ id_tipe_kegiatan
			+" , nama_kegiatan		= '"+ nama_kegiatan +"' "
			+" , id_user			= '"+ user_nipg +"' "
			+" , tanggal_akses		= getdate() "
			+" where 	id_kegiatan_detail	= "+ id_kegiatan_detail;
		break;

	case 4:
		q	=" delete from t_kegiatan_detail "
			+" where  	id_kegiatan_detail	= "+ id_kegiatan_detail;
		break;

	default:
		out.print("{success: false,info: 'DML tipe tidak diketahui ("+ dml +")!'}");
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
