<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - prasetya (prasetya.yanuar@googlemail.com)
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

	Statement	db_stmt		= db_con.createStatement();

	ResultSet	rs;
	String		q;

	q	= " "
		+ " select	a.id_pssr "
		+ " ,		a.id_project "
		+ " ,		replace(convert(varchar, b.tanggal_mulai, 111), '/', '-') tanggal_mulai"
		+ " ,		a.lokasi "
		+ " ,		replace(convert(varchar, a.tanggal, 111), '/', '-') tanggal"
		+ " from	t_pssr as a "
		+ " ,		r_project as b "
		+ " where	a.id_project 	= b.id_project "
		+ " and		a.id_divprosbu	= " + user_div
		+ " and		a.id_direktorat	= " + user_dir;

	rs = db_stmt.executeQuery(q);

	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("id_pssr")
			+ "','"+ rs.getString("id_project")
			+ "','"+ rs.getString("tanggal_mulai")
			+ "','"+ rs.getString("lokasi")
			+ "','"+ rs.getString("tanggal")
			+ "']";
	}

	data += "]";


	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
