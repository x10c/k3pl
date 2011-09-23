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
	+" ,		id_pha_phr "
	+" ,		process_step "
	+" ,		what_if "
	+" ,		consequence "
	+" ,		frequency_category "
	+" ,		consequence_category "
	+" ,		risk_score "
	+" from		t_pha_phr "
	+" where	id_pha 	= " + id_pha;

	rs 				= db_stmt.executeQuery(q);
	int		i		= 0;
	String	data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="["+ rs.getString("id_pha")
			+ ","+ rs.getString("id_pha_phr")
			+ ",'"+ rs.getString("process_step") + "'"
			+ ",'"+ rs.getString("what_if") + "'"
			+ ",'"+ rs.getString("consequence") + "'"
			+ ",'"+ rs.getString("frequency_category") + "'"
			+ ",'"+ rs.getString("consequence_category") + "'"
			+ ",'"+ rs.getString("risk_score") + "'"
			+ "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
