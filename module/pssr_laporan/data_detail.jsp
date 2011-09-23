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
	ResultSet	rs;
	String		q;

	q=" select	id_report "
	+" ,		nama_report "
	+" ,		klasifikasi_report "
	+" ,		tipe_report "
	+" ,		file_location "
	+" ,		web_params "
	+" ,		report_params "
	+" from		r_report "
	+" where	klasifikasi_report 	= 2"
	+" order by	id_report";

	rs = db_stmt.executeQuery(q);

	int		i		= 0;
	String	data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "["+ rs.getString("id_report")
			+  ",'"+ rs.getString("nama_report") + "'"
			+  ","+ rs.getString("klasifikasi_report")
			+ ",\""+ rs.getString("tipe_report") +"\""
			+ ",\""+ rs.getString("file_location") +"\""
			+ ",\""+ rs.getString("web_params") +"\""
			+ ",\""+ rs.getString("report_params") +"\""
			+  "]";
	}

	data += "]";
	
	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
