<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	
	String		id_seksi	= request.getParameter("id_seksi");

	String	q	=" select	nipg "
			+" ,		nama_pegawai "
			+" ,		id_seksi "
			+" from		r_pegawai "
			+" where	id_seksi 		= " + id_seksi
			+" and		status_pegawai	= '1' "
			+" and		nipg in	( "
			+"						select 	nipg "
			+"						from	__user_grup "
			+"						where	id_grup	= 5 "
			+"					) "
			+" order by	nama_pegawai ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("nipg") +"' "
			+  ",\""+ rs.getString("nama_pegawai") +"\""
			+  ", '"+ rs.getString("id_seksi") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
