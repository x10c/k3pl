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

	String	q	=" select	a.nipg "
			+" ,		a.nama_pegawai "
			+" ,		(select b.nama_departemen from r_departemen as b where b.id_departemen = a.id_departemen) as departemen "
			+" from		r_pegawai	as a"
			+" where	a.status_pegawai	= '1' "
			+" and		a.id_divprosbu		= " + id_divprosbu
			+" and		a.id_direktorat		= " + id_direktorat
			+" order by	a.nama_pegawai ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "['"+ rs.getString("nipg") + "'"
			+ ",\""+ rs.getString("nama_pegawai") +"\""
			+ ",\""+ rs.getString("departemen") +"\""
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
