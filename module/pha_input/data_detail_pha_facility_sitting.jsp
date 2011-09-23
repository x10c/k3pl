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
	String		load_type	= (String) request.getParameter("load_type");

	String		id_pha	= request.getParameter("id_pha");

	ResultSet	rs;
	String		q;

	q=" select	id_pha "
	+" ,		id_pha_facility_sitting "
	+" ,		category "
	+" ,		description "
	+" from		t_pha_facility_sitting "
	+" where	id_pha 	= " + id_pha
	+" order by	id_pha, id_pha_facility_sitting";

	rs = db_stmt.executeQuery(q);

	int		i		= 0;
	String	data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		
		String desc = rs.getString("description");

		desc = desc.replace("\n","\\n");
		data	+= "["+ rs.getString("id_pha")
			+  ","+ rs.getString("id_pha_facility_sitting")
			+ ",\""+ rs.getString("category") +"\""
			+ ",\""+ desc +"\""
			+  "]";
	}

	data += "]";
	
	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
