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
	Connection	db_con		= (Connection) session.getAttribute("db.con");
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

	Statement	db_stmt 	= db_con.createStatement();
	String		tahun		= request.getParameter("tahun");
	String		bulan		= request.getParameter("bulan");
	
	String q
		=" select	id_lingkungan_bulanan_detail "
		+" ,		tipe_kegiatan "
		+" ,		nama_kegiatan "
		+" ,		replace(convert(varchar, tanggal_awal, 111), '/', '-') as tanggal_awal "
		+" ,		replace(convert(varchar, tanggal_akhir, 111), '/', '-') as tanggal_akhir "
		+" from		t_lingkungan_bulanan_detail "
		+" where	tahun 			= "+ tahun
		+" and		bulan 			= "+ bulan
		+" and		id_divprosbu 	= "+ user_div
		+" and		id_direktorat 	= "+ user_dir
		+" order by	tahun, bulan, id_lingkungan_bulanan_detail ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="["+ rs.getString("id_lingkungan_bulanan_detail")
			+ ","+ rs.getString("tipe_kegiatan")
			+ ",'"+ rs.getString("nama_kegiatan") + "'"
			+ ",'"+ rs.getString("tanggal_awal") + "'"
			+ ",'"+ rs.getString("tanggal_akhir") + "'"
			+ "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
