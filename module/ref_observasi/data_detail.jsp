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
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_kel	= request.getParameter("id_kel");
	String		id_tipe	= request.getParameter("id_tipe");

	String q=" select	id_detail_tipe_observasi "
		+" ,		nama_detail_tipe_observasi "
		+" from		r_detail_tipe_observasi "
		+" where	id_kel_tipe_observasi	= "+ id_kel
		+" and		id_tipe_observasi	= "+ id_tipe
		+" order by	id_detail_tipe_observasi ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data	+="[ '"+ rs.getString("id_detail_tipe_observasi") +"' "
			+ ", '"+ rs.getString("nama_detail_tipe_observasi") +"' ]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
