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

	String	q	=" select	A.id_seksi "
				+" ,		A.id_dinas "
				+" ,		A.id_departemen "
				+" ,		A.id_divprosbu "
				+" ,		A.id_direktorat "
				+" ,		C.nama_departemen +' - '+ B.nama_dinas +' - '+ A.nama_seksi as nama_seksi"
				+" from		r_seksi			A"
				+" ,		r_dinas			B"
				+" ,		r_departemen	C"
				+" where	A.id_divprosbu	= " + id_divprosbu
				+" and		A.id_direktorat	= " + id_direktorat
				+" and		A.id_departemen	= C.id_departemen"
				+" and		A.id_dinas		= B.id_dinas"
				+" order by	C.nama_departemen, B.nama_dinas, A.nama_seksi";

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
