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
	Statement	db_stmt		= db_con.createStatement();
	
	String	q	=" "
			+"	select		a.id_dinas "
			+" 		,		a.id_departemen "
			+" 		,		a.nama_dinas "
			+" 		,		( "
			+"					select	nipg "
			+"					from	( "
			+"								select	b.nipg								as nipg "
			+"									,	row_number() over(order by b.nipg)	as row_num "
			+"								from	r_pegawai	as b "
			+"								where	b.id_dinas 			= a.id_dinas "
			+"								and		b.id_jabatan		= 3 "
			+"								and		b.status_pegawai	= '1' "
			+"							)	as hasil "
			+"					where	row_num between 1 and 1 "
			+" 				)	as kepala_dinas "
			+"	from		r_dinas as a "
			+" 	order by	a.nama_dinas ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_dinas") +"' "
			+  ", '"+ rs.getString("id_departemen") +"'"
			+  ", '"+ rs.getString("nama_dinas") +"'"
			+  ", '"+ rs.getString("kepala_dinas") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
