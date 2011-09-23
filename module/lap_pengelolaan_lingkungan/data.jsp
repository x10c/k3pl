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
	String 		year	= request.getParameter("year");
	String 		month	= request.getParameter("month");
	
	String q = " select		b.nama_wilayah "
			 + "		,	a.lokasi_pengelolaan_lingkungan "
			 + "		,	a.tipe_station "
			 + "		,	a.parameter "
			 + "		,	a.sumber_dampak "
			 + " from		t_pengelolaan_lingkungan	as a "
			 + " left join	r_wilayah					as b on B.id_wilayah = a.id_wilayah "
			 + " where		MONTH(a.tanggal_pengelolaan_lingkungan) = " + month
			 + " and		YEAR(a.tanggal_pengelolaan_lingkungan) = " + year;

	ResultSet	rs 		= db_stmt.executeQuery(q);
	int			i 		= 0;
	String		data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
			
		data	+= "[ '"+ rs.getString("nama_wilayah") +"' "
			+  ", '"+ rs.getString("lokasi_pengelolaan_lingkungan") +"' "
			+  ", '"+ rs.getString("tipe_station") +"' "
			+  ", '"+ rs.getString("parameter") +"' "
			+  ", '"+ rs.getString("sumber_dampak") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
