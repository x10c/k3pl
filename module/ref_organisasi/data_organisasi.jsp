<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt	= db_con.createStatement();
	ResultSet	rs;
	int		i	= 0;
	String		data	= "[";

	q	=" select	A.nama_departemen"
		+" ,		B.nama_dinas"
		+" ,		C.nama_seksi"
		+" from		r_departemen	A"
		+" ,		r_dinas		B"
		+" ,		r_seksi		C"
		+" where	A.id_departemen	= B.id_departemen"
		+" and		B.id_dinas	= C.id_dinas"
		+" order by	C.id_departemen, C.id_dinas, C.id_seksi";

	rs = db_stmt.executeQuery(q);

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "['"+ rs.getString("nama_departemen") +"'"
			+  ",'"+ rs.getString("nama_dinas") +"'"
			+  ",'"+ rs.getString("nama_seksi") +"'"
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
	db_stmt.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
