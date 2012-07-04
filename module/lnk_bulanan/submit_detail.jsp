<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int			dml								= Integer.parseInt(request.getParameter("dml_type"));
	String		id_lingkungan_bulanan_detail	= request.getParameter("id_lingkungan_bulanan_detail");
	String		tahun							= request.getParameter("tahun");
	String		bulan							= request.getParameter("bulan");
	String		tipe_kegiatan					= request.getParameter("tipe_kegiatan");
	String		nama_kegiatan					= request.getParameter("nama_kegiatan");
	String		tanggal_awal					= request.getParameter("tanggal_awal");
	String		tanggal_akhir					= request.getParameter("tanggal_akhir");
	String		uraian_kegiatan					= request.getParameter("uraian_kegiatan");
	String		keterangan						= request.getParameter("keterangan");
	
	String		q 		= "";
	Date		date	= new Date();

	switch (dml) {
	case 2:
		id_lingkungan_bulanan_detail = Long.toString(date.getTime());

		q	=" insert into t_lingkungan_bulanan_detail ("
			+"   id_lingkungan_bulanan_detail"
			+" , id_direktorat"
			+" , id_divprosbu"
			+" , tahun"
			+" , bulan"
			+" , tipe_kegiatan"
			+" , nama_kegiatan"
			+" , tanggal_awal"
			+" , tanggal_akhir"
			+" , uraian_kegiatan"
			+" , keterangan"
			+" , id_user"
			+" ) values ("
			+      id_lingkungan_bulanan_detail
			+", "+ user_dir
			+", "+ user_div
			+", "+ tahun
			+", "+ bulan
			+", "+ tipe_kegiatan
			+",'"+ nama_kegiatan +"'"
			+",'"+ tanggal_awal +"'"
			+",'"+ tanggal_akhir +"'"
			+",'"+ uraian_kegiatan +"'"
			+",'"+ keterangan +"'"
			+",'"+ user_nipg +"'"
			+")";

		break;
	case 3:
		q	=" update t_lingkungan_bulanan_detail "
			+" set "
			+"   tipe_kegiatan		= "+ tipe_kegiatan
			+" , nama_kegiatan		= '"+ nama_kegiatan + "'"
			+" , tanggal_awal		= cast('"+ tanggal_awal +"' as datetime)"
			+" , tanggal_akhir		= cast('"+ tanggal_akhir +"' as datetime)"
			+" , uraian_kegiatan	= '"+ uraian_kegiatan +"'"
			+" , keterangan			= '"+ keterangan +"'"
			+" , id_user			= '"+ user_nipg +"'"
			+" , tanggal_akses		= getdate() "
			+" where id_lingkungan_bulanan_detail	=  "+ id_lingkungan_bulanan_detail;
		break;
	case 4:
		q	=" delete from t_lingkungan_bulanan_detail "
			+" where  id_lingkungan_bulanan_detail =  "+ id_lingkungan_bulanan_detail;

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
