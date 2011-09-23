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

	String id_grup = request.getParameter("id_grup");

	String q=" select	A.nipg"
			+" ,		B.nama_pegawai"
			+" ,		A.status_user"
			+" from		__user		A"
			+" ,		r_pegawai	B"
			+" ,		__user_grup	C"
			+" where	A.nipg		= B.nipg"
			+" and		A.nipg		= C.nipg"
			+" and		C.id_grup	= "+ id_grup
			+" order by	B.nama_pegawai";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		data	+="['"+ rs.getString("nipg") +"'"
			+ ",\""+ rs.getString("nama_pegawai") +"\""
			+ ",'"+ rs.getString("status_user") +"'"
			+ "]";
	}

	data +="]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
