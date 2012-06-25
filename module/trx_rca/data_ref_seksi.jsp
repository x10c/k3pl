<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	String		id_divprosbu	= (String) session.getAttribute ("user.divprosbu");

	String	q	=" select	id_seksi "
				+" ,		id_dinas "
				+" ,		id_departemen "
				+" ,		id_divprosbu "
				+" ,		id_direktorat "
				+" ,		nama_seksi "
				+" from		r_seksi "
				+" where	id_divprosbu = " + id_divprosbu
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
