<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - m.shulhan (ms@kilabit.org)
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
		out.print("{success:false,info:'User Divisi/Proyek/SBU tidak diketahui.'}");
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int			dml					= Integer.parseInt(request.getParameter("dml_type"));
	String		id_insiden			= request.getParameter("id_insiden");
	String		id_area_seksi		= request.getParameter("id_area_seksi");
	String		id_klas				= request.getParameter("id_klas");
	String		tanggal				= request.getParameter("tanggal");
	String		uraian				= request.getParameter("uraian");
	String		jml_korban_mati			= request.getParameter("jml_korban_mati");
	String		jml_korban_berat		= request.getParameter("jml_korban_berat");
	String		jml_korban_sedang		= request.getParameter("jml_korban_sedang");
	String		jml_hari_kerja_hilang	= request.getParameter("jml_hari_kerja_hilang");
	String		jml_korban_dampak		= request.getParameter("jml_korban_dampak");
	String		jml_korban_medis		= request.getParameter("jml_korban_medis");
	String		jml_korban_p3k			= request.getParameter("jml_korban_p3k");
	String		jml_hampir_celaka		= request.getParameter("jml_hampir_celaka");
	String		jml_bakar_ledak_bocor	= request.getParameter("jml_bakar_ledak_bocor");

	String		jml_rusak_jaringan		= request.getParameter("jml_rusak_jaringan");
	String		jml_rusak_bangunan		= request.getParameter("jml_rusak_bangunan");
	String		jml_rusak_kendaraan		= request.getParameter("jml_rusak_kendaraan");
	String		jml_rusak_lain			= request.getParameter("jml_rusak_lain");

	String		nilai_rusak_jaringan	= request.getParameter("nilai_rusak_jaringan");
	String		nilai_rusak_bangunan	= request.getParameter("nilai_rusak_bangunan");
	String		nilai_rusak_kendaraan	= request.getParameter("nilai_rusak_kendaraan");
	String		nilai_rusak_lain		= request.getParameter("nilai_rusak_lain");

	String		jml_pencemaran_lingkungan	= request.getParameter("jml_pencemaran_lingkungan");
	String		jml_kecelakaan_kendaraan	= request.getParameter("jml_kecelakaan_kendaraan");
	String		jml_kejadian_keamanan		= request.getParameter("jml_kejadian_keamanan");
	String		q;

	DateFormat	df	= new SimpleDateFormat("yyyy-MM-dd");
	Date		dt_in	= df.parse(tanggal);
	Calendar	cal	= Calendar.getInstance();
	Date		date	= new Date();
	int		year;
	int		month;

	cal.setTime(dt_in);

	year	= cal.get(cal.YEAR);
	month	= cal.get(cal.MONTH) + 1;

	switch (dml) {
	case 2:
		id_insiden	= Long.toString(date.getTime());

		q	=" insert into t_insiden ("
			+"   id_insiden"
			+" , id_area_direktorat"
			+" , id_area_divprosbu"
			+" , id_area_departemen"
			+" , id_area_dinas"
			+" , id_area_seksi"
			+" , id_klasifikasi_pegawai"
			+" , tanggal"
			+" , tahun"
			+" , bulan"
			+" , uraian"
			+" , jml_korban_mati"
			+" , jml_korban_berat"
			+" , jml_korban_sedang"
			+" , jml_hari_kerja_hilang"
			+" , jml_korban_dampak"
			+" , jml_korban_medis"
			+" , jml_korban_p3k"
			+" , jml_hampir_celaka"
			+" , jml_bakar_ledak_bocor"
			+" , jml_rusak_jaringan"
			+" , jml_rusak_bangunan"
			+" , jml_rusak_kendaraan"
			+" , jml_rusak_lain"
			+" , nilai_rusak_jaringan"
			+" , nilai_rusak_bangunan"
			+" , nilai_rusak_kendaraan"
			+" , nilai_rusak_lain"
			+" , jml_pencemaran_lingkungan"
			+" , jml_kecelakaan_kendaraan"
			+" , jml_kejadian_keamanan"
			+" , id_user"
			+" , id_divprosbu"
			+" , id_direktorat"
			+" ) select "
			+     id_insiden
			+" , id_direktorat"
			+" , id_divprosbu"
			+" , id_departemen"
			+" , id_dinas"
			+" ,"+ id_area_seksi
			+" ,"+ id_klas
			+" , cast('"+ tanggal +"' as datetime)"
			+" ,"+ year
			+" ,"+ month
			+" ,'"+ uraian +"'"
			+" ,"+ jml_korban_mati
			+" ,"+ jml_korban_berat
			+" ,"+ jml_korban_sedang
			+" ,"+ jml_hari_kerja_hilang
			+" ,"+ jml_korban_dampak
			+" ,"+ jml_korban_medis
			+" ,"+ jml_korban_p3k
			+" ,"+ jml_hampir_celaka
			+" ,"+ jml_bakar_ledak_bocor
			+" ,"+ jml_rusak_jaringan
			+" ,"+ jml_rusak_bangunan
			+" ,"+ jml_rusak_kendaraan
			+" ,"+ jml_rusak_lain
			+" ,"+ nilai_rusak_jaringan
			+" ,"+ nilai_rusak_bangunan
			+" ,"+ nilai_rusak_kendaraan
			+" ,"+ nilai_rusak_lain
			+" ,"+ jml_pencemaran_lingkungan
			+" ,"+ jml_kecelakaan_kendaraan
			+" ,"+ jml_kejadian_keamanan
			+" ,'"+ user_nipg +"'"
			+" ,"+ user_div
			+" ,"+ user_dir
			+" from r_seksi where id_seksi = "+ id_area_seksi;
		break;
	case 3:
		q	=" update t_insiden "
			+" set "
			+"   id_area_seksi				= "+ id_area_seksi
			+" , id_area_dinas				= (select id_dinas from r_seksi where id_seksi = "+ id_area_seksi +")"
			+" , id_area_departemen			= (select id_departemen from r_seksi where id_seksi = "+ id_area_seksi +")"
			+" , id_klasifikasi_pegawai		= "+ id_klas
			+" , tanggal					= cast('"+ tanggal +"' as datetime) "
			+" , tahun						= "+ year
			+" , bulan						= "+ month
			+" , uraian						= '"+ uraian +"'"
			+" , jml_korban_mati			= "+ jml_korban_mati
			+" , jml_korban_berat			= "+ jml_korban_berat
			+" , jml_korban_sedang			= "+ jml_korban_sedang
			+" , jml_hari_kerja_hilang		= "+ jml_hari_kerja_hilang
			+" , jml_korban_dampak			= "+ jml_korban_dampak
			+" , jml_korban_medis			= "+ jml_korban_medis
			+" , jml_korban_p3k				= "+ jml_korban_p3k
			+" , jml_hampir_celaka			= "+ jml_hampir_celaka
			+" , jml_bakar_ledak_bocor		= "+ jml_bakar_ledak_bocor

			+" , jml_rusak_jaringan			= "+ jml_rusak_jaringan
			+" , jml_rusak_bangunan			= "+ jml_rusak_bangunan
			+" , jml_rusak_kendaraan		= "+ jml_rusak_kendaraan
			+" , jml_rusak_lain				= "+ jml_rusak_lain

			+" , nilai_rusak_jaringan		= "+ nilai_rusak_jaringan
			+" , nilai_rusak_bangunan		= "+ nilai_rusak_bangunan
			+" , nilai_rusak_kendaraan		= "+ nilai_rusak_kendaraan
			+" , nilai_rusak_lain			= "+ nilai_rusak_lain
			+" , jml_pencemaran_lingkungan	= "+ jml_pencemaran_lingkungan
			+" , jml_kecelakaan_kendaraan	= "+ jml_kecelakaan_kendaraan
			+" , jml_kejadian_keamanan		= "+ jml_kejadian_keamanan

			+" , id_user				= '"+ user_nipg +"' "
			+" , tanggal_akses			= getdate() "
			+" where id_insiden			=  "+ id_insiden;
		break;
	case 4:
		q	=" delete from	t_insiden"
			+" where	id_insiden = "+ id_insiden;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
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
