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

	String		id_rca 	= (String) request.getParameter("id_rca");
	ResultSet	rs;
	int			i 		= 0;
	String		q;
	String		data 	= "[";

	q=" select	id_rca "
	+" ,		id_rca_detail "
	+" ,		description "
	+" ,		good_citizens "
	+" ,		violators "
	+" ,		number_of_violations "
	+" ,		id_severity "
	+" ,		violation_x_severity "
	+" ,		li_45 "
	+" ,		li_apd "
	+" ,		li_housekeeping "
	+" ,		li_process_safety "
	+" ,		li_fire_safety "
	+" ,		actions "
	+" ,		status "
	+" ,		replace(convert(varchar, completion_date_target, 111), '/', '-') as completion_date_target "
	+" ,		replace(convert(varchar, completion_date_actual, 111), '/', '-') as completion_date_actual "
	+" ,		note "
	+" from		t_rca_detail "
	+" where	id_rca	= "+ id_rca;

	rs = db_stmt.executeQuery(q);

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_rca") +"' "
			+  ", "+ rs.getString("id_rca_detail") +" "
			+  ", '"+ rs.getString("description") +"' "
			+  ", "+ rs.getString("good_citizens") +" "
			+  ", "+ rs.getString("violators") +" "
			+  ", "+ rs.getString("number_of_violations") +" "
			+  ", "+ rs.getString("id_severity") +" "
			+  ", "+ rs.getString("violation_x_severity") +" "
			+  ", "+ rs.getString("li_45") +" "
			+  ", "+ rs.getString("li_apd") +" "
			+  ", "+ rs.getString("li_housekeeping") +" "
			+  ", "+ rs.getString("li_process_safety") +" "
			+  ", "+ rs.getString("li_fire_safety") +" "
			+  ", '"+ rs.getString("actions") +"' "
			+  ", '"+ rs.getString("status") +"' "
			+  ", '"+ rs.getString("completion_date_target") +"' "
			+  ", '"+ rs.getString("completion_date_actual") +"' "
			+  ", '"+ rs.getString("note") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);
	
	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
