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
	+" ,		id_pha_wsfca "
	+" ,		hazard "
	+" ,		hazard_event "
	+" ,		qty_release "
	+" ,		impact "
	+" from		t_pha_wsfca "
	+" where	id_pha 	= " + id_pha
	+" order by	id_pha, id_pha_wsfca";

	rs = db_stmt.executeQuery(q);

	int		i		= 0;
	String	data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		
		String hazard 		= rs.getString("hazard");
		String hazard_event = rs.getString("hazard_event");
		String impact 		= rs.getString("impact");
		
		hazard 			= hazard.replace("\n","\\n");
		hazard_event 	= hazard_event.replace("\n","\\n");
		impact 			= impact.replace("\n","\\n");

		data	+= "["+ rs.getString("id_pha")
			+  ","+ rs.getString("id_pha_wsfca")
			+ ",\""+ hazard +"\""
			+ ",\""+ hazard_event +"\""
			+  ",'"+ rs.getString("qty_release") + "'"
			+ ",\""+ impact +"\""
			+  "]";
	}

	data += "]";
	
	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
