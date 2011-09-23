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
	String		nipg		= (String) session.getAttribute("user.nipg");
	
	String q;
	
	q=" select	tahun "
	+" 		,	bulan "
	+" 		,	(select a.id_wilayah from r_seksi a, r_pegawai b where a.id_seksi = b.id_seksi and b.nipg = '" + nipg + "') as wilayah"
	+" from		t_kegiatan "
	+" order by	tahun, bulan";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ "+ rs.getString("tahun")
			+ ","+ rs.getString("bulan")
			+ ","+ rs.getString("wilayah")
			+ "]";
	}

	data += "]";

	out.print(data);
	
	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
