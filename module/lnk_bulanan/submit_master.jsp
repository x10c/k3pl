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
	String		menu_id		= ServletUtilities.getCookieValue (cookies, "menu.id", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	int			dml				= Integer.parseInt(request.getParameter("dml_type"));
	String		tahun			= request.getParameter("tahun");
	String		tahun_old		= request.getParameter("tahun_old");
	String		bulan			= request.getParameter("bulan");
	String		bulan_old		= request.getParameter("bulan_old");
	String		pekerjaan		= request.getParameter("pekerjaan");
	String		lokasi_proyek	= request.getParameter("lokasi_proyek");
	String		q 				= "";

	switch (dml) {
	case 2:
		q	=" insert into t_lingkungan_bulanan ("
			+" 	id_direktorat"
			+", id_divprosbu"
			+",	tahun"
			+", bulan"
			+", pekerjaan"
			+", lokasi_proyek"
			+", id_user"
			+") values ("
			+ 	   user_dir
			+", "+ user_div
			+", "+ tahun
			+", "+ bulan
			+",'"+ pekerjaan +"'"
			+",'"+ lokasi_proyek +"'"
			+",'"+ user_nipg + "'"
			+")";

		break;
	case 3:
		q	=" update t_lingkungan_bulanan "
			+" set "
			+"   id_direktorat	= "+ user_dir
			+" , id_divprosbu	= "+ user_div
			+" , tahun			= "+ tahun
			+" , bulan			= "+ bulan
			+" , pekerjaan		= '"+ pekerjaan + "'"
			+" , lokasi_proyek	= '"+ lokasi_proyek +"'"
			+" , id_user		= '"+ user_nipg +"'"
			+" , tanggal_akses	= getdate() "
			+" where 	tahun			= "+ tahun_old
			+" and		bulan			= "+ bulan_old
			+" and		id_divprosbu	= "+ user_div;
			
		break;
	case 4:
		q	=" delete from t_lingkungan_bulanan "
			+" where	id_direktorat	= "+ user_dir
			+" and		id_divprosbu	= "+ user_div
			+" and		tahun			= "+ tahun
			+" and		bulan			= "+ bulan;

		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ menu_id +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
