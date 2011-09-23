<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_rca = (String) request.getParameter("id_rca");
	ResultSet	rs;
	String		q;
	String		data = "[";
	int		i	= 0;

	q=" select	id_rca "
	+"		,	nipg "
	+" from		t_rca_auditor "
	+" where	id_rca	= "+ id_rca
	+" order by	tanggal_akses ";

	rs = db_stmt.executeQuery(q);

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("id_rca") + "' "
				+  ", '"+ rs.getString("nipg") +"' "
				+ "]";
	}

	data += "]";

	out.print(data);

	rs.close();

} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
