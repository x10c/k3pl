<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - mhd.sulhan (ms@kilabit.org)
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
	String		load_type	= (String) request.getParameter("load_type");
	
	String q
		=" select	a.id_lingkungan_tahunan "
		+" ,		b.nama_seksi as satuan_kerja "
		+" ,		a.proyek_kegiatan_aktifitas as proyek "
		+" from		t_lingkungan	as a "
		+" ,		r_seksi			as b "
		+" where	a.id_seksi					= b.id_seksi "
		+" and		a.tipe_kegiatan_lingkungan	= 2 "
		+" and		a.id_divprosbu				= "+ user_div
		+" and		(a.id_user 					= '"+ user_nipg +"'";

		if (load_type.equals("all")) {
			q+=" or		'"+ user_nipg +"' in (select c.nipg from __user_grup as c where c.id_grup = 1))";
		}

		q+=" order by	a.id_lingkungan_tahunan ";

	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data+="["+ rs.getString("id_lingkungan_tahunan")
			+ ",'"+ rs.getString("satuan_kerja")
			+ "','"+ rs.getString("proyek")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
