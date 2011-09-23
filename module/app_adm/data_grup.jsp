<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

	String q=" select	id_grup"
		+" ,		nama_grup"
		+" ,		keterangan_grup"
		+" from		__grup_user"
		+" order by	nama_grup";

	ResultSet	rs	= db_stmt.executeQuery(q);
	String		data	= "[";
	int		i	= 0;

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		data	+= "['"+ rs.getString("id_grup") +"'"
			+  ",'"+ rs.getString("nama_grup") +"'"
			+  ",'"+ rs.getString("keterangan_grup") +"'"
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
