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
	
	String q;
	
	q=" select	tahun "
	+" 		,	bulan "
	+" 		,	case bulan "
	+"				when	1	then	'Januari' "
	+"				when	2	then	'Februari' "
	+"				when	3	then	'Maret' "
	+"				when	4	then	'April' "
	+"				when	5	then	'Mei' "
	+"				when	6	then	'Juni' "
	+"				when	7	then	'Juli' "
	+"				when	8	then	'Agustus' "
	+"				when	9	then	'September' "
	+"				when	10	then	'Oktober' "
	+"				when	11	then	'November' "
	+"				else	'Desember' "
	+"			end as nama_bulan "
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
		data	+="[ '"+ rs.getString("tahun")
			+ "','"+ rs.getString("bulan")
			+ "','"+ rs.getString("nama_bulan")
			+ "']";
	}

	data += "]";

	out.print(data);
	
	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
