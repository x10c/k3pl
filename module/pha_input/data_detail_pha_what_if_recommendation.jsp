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

	String		id_pha		= request.getParameter("id_pha");
	String		id_pha_phr	= request.getParameter("id_pha_phr");

	ResultSet	rs;
	String		q;

	q=" select	id_pha "
	+" ,		id_pha_phr "
	+" ,		id_pha_phr_recommendation "
	+" ,		recommendation "
	+" from		t_pha_phr_recommendation "
	+" where	id_pha 		= " + id_pha
	+" and		id_pha_phr 	= " + id_pha_phr
	+" order by	id_pha, id_pha_phr, id_pha_phr_recommendation";

	rs = db_stmt.executeQuery(q);

	int		i		= 0;
	String	data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ "+ rs.getString("id_pha")
			+  ", "+ rs.getString("id_pha_phr")
			+  ", "+ rs.getString("id_pha_phr_recommendation")
			+  ", '"+ rs.getString("recommendation") +"' "
			+  "]";
	}

	data += "]";
	
	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
