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

	Statement	db_stmt						= db_con.createStatement();
	int			dml							= Integer.parseInt(request.getParameter("dml_type"));
	String		id_lingkungan_tahunan		= request.getParameter("id_lingkungan_tahunan");
	String		id_seksi					= request.getParameter("id_seksi");
	String		id_dinas					= request.getParameter("id_dinas");
	String		id_departemen				= request.getParameter("id_departemen");
	String		tipe_kegiatan_lingkungan	= request.getParameter("tipe_kegiatan_lingkungan");
	String		proyek_kegiatan_aktifitas	= request.getParameter("proyek_kegiatan_aktifitas");
	String		dikompilasi_oleh			= request.getParameter("dikompilasi_oleh");
	String		tanggal_kompilasi			= request.getParameter("tanggal_kompilasi");
	String		disetujui_oleh				= request.getParameter("disetujui_oleh");
	String		tanggal_disetujui			= request.getParameter("tanggal_disetujui");
	
	String		q 		= "";
	Date		date	= new Date();

	switch (dml) {
	case 2:
		id_lingkungan_tahunan	= Long.toString(date.getTime());

		q	=" insert into t_lingkungan ("
			+" 		id_lingkungan_tahunan"
			+" ,	id_seksi"
			+" ,	id_dinas"
			+" ,	id_departemen"
			+" ,	tipe_kegiatan_lingkungan"
			+" ,	proyek_kegiatan_aktifitas"
			+" ,	dikompilasi_oleh"
			+" ,	tanggal_kompilasi"
			+" ,	disetujui_oleh"
			+" ,	tanggal_disetujui"
			+" ,	id_user"
			+" ,	id_divprosbu"
			+" ,	id_direktorat"
			+" )"
			+" values ("
			+"  "+ id_lingkungan_tahunan
			+", "+ id_seksi
			+", "+ id_dinas
			+", "+ id_departemen
			+", "+ tipe_kegiatan_lingkungan
			+",'"+ proyek_kegiatan_aktifitas +"'"
			+",'"+ dikompilasi_oleh +"'"
			+",'"+ tanggal_kompilasi +"'"
			+",'"+ disetujui_oleh +"'"
			+",'"+ tanggal_disetujui +"'"
			+",'"+ user_nipg +"'"
			+", "+ user_div
			+", "+ user_dir
			+")";

		break;
	case 3:
		q	=" update t_lingkungan "
			+" set "
			+"   id_seksi					= "+ id_seksi
			+" , id_dinas					= "+ id_dinas
			+" , id_departemen				= "+ id_departemen
			+" , proyek_kegiatan_aktifitas	= '"+ proyek_kegiatan_aktifitas +"' "
			+" , dikompilasi_oleh			= '"+ dikompilasi_oleh +"' "
			+" , tanggal_kompilasi			= cast('"+ tanggal_kompilasi +"' as datetime) "
			+" , disetujui_oleh				= '"+ disetujui_oleh +"' "
			+" , tanggal_disetujui			= cast('"+ tanggal_disetujui +"' as datetime) "
			+" , id_user					= '"+ user_nipg +"' "
			+" , tanggal_akses				= getdate() "
			+" where id_lingkungan_tahunan	=  "+ id_lingkungan_tahunan;
			
		break;
	case 4:
		q	=" delete from t_lingkungan "
			+" where  id_lingkungan_tahunan =  "+ id_lingkungan_tahunan;

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
