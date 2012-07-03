<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies			= request.getCookies ();
	String		id_divprosbu	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		id_direktorat	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement	db_stmt			= db_con.createStatement();

	String	q	=" select	id_seksi "
				+" ,		id_dinas "
				+" ,		id_departemen "
				+" ,		id_divprosbu "
				+" ,		id_direktorat "
				+" ,		nama_seksi "
				+" from		r_seksi "
				+" where	id_divprosbu	= " + id_divprosbu
				+" and		id_direktorat	= " + id_direktorat
				+" order by	nama_seksi ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_seksi") +"' "
				+  ", '"+ rs.getString("id_dinas") +"' "
				+  ", '"+ rs.getString("id_departemen") +"' "
				+  ", '"+ rs.getString("id_divprosbu") +"' "
				+  ", '"+ rs.getString("id_direktorat") +"' "
				+  ", '"+ rs.getString("nama_seksi") +"' "
				+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
