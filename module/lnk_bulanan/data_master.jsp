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
	String		load_type	= (String) request.getParameter("load_type");
	
	String q
		=" select	tahun "
		+" ,		tahun as tahun_old "
		+" ,		bulan "
		+" ,		bulan as bulan_old "
		+" ,		pekerjaan "
		+" ,		lokasi_proyek "
		+" from		t_lingkungan_bulanan "
		+" where	id_user 		= '"+ user_nipg +"'"
		+" and		id_divprosbu	= "+ user_div;

		if (load_type.equals("all")) {
			q+=" or		'"+ user_nipg +"' in (select c.nipg from __user_grup as c where c.id_grup = 1)";
		}

		q+=" order by	tahun, bulan ";

	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data+="[ "+ rs.getString("tahun")
			+ ", "+ rs.getString("tahun_old")
			+ ", "+ rs.getString("bulan")
			+ ", "+ rs.getString("bulan_old")
			+ ",'"+ rs.getString("pekerjaan") +"'"
			+ ",'"+ rs.getString("lokasi_proyek")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
