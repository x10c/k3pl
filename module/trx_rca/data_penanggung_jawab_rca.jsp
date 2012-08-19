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

	Statement	db_stmt			= db_con.createStatement();
	
	String	q	=" "
			+"	select		a.id_seksi "
			+" 		,		a.id_dinas "
			+" 		,		a.id_departemen "
			+" 		,		a.id_divprosbu "
			+" 		,		a.id_direktorat "
			+" 		,		a.nama_seksi "
			+" 		,		c.nama_dinas "
			+" 		,		d.nama_departemen "
			+" 		,		e.nama_divprosbu "
			+" 		,		f.nama_direktorat "
			+" 		,		( "
			+"					select	nipg "
			+"					from	( "
			+"								select	b.nipg											as nipg "
			+"									,	row_number() over(order by b.id_jabatan desc)	as row_num "
			+"								from	r_pegawai	as b "
			+"								where	b.id_seksi 			= a.id_seksi "
			+"								and		b.id_jabatan		in (3,7) "
			+"								and		b.status_pegawai	= '1' "
			+"							)	as hasil "
			+"					where	row_num between 1 and 1 "
			+" 				)	as pic "
			+"	from		r_seksi 		as a "
			+"		,		r_dinas 		as c "
			+"		,		r_departemen 	as d "
			+"		,		r_divprosbu 	as e "
			+"		,		r_direktorat 	as f "
			+"	where		a.id_dinas			= c.id_dinas "
			+"	and			a.id_departemen		= d.id_departemen "
			+"	and			a.id_divprosbu		= e.id_divprosbu "
			+"	and			a.id_direktorat		= f.id_direktorat "
			+" 	order by	a.id_direktorat, a.id_divprosbu, a.id_departemen, a.id_dinas, a.id_seksi ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_seksi") +"' "
				+  ", '"+ rs.getString("id_dinas") +"'"
				+  ", '"+ rs.getString("id_departemen") +"'"
				+  ", '"+ rs.getString("id_divprosbu") +"'"
				+  ", '"+ rs.getString("id_direktorat") +"'"
				+  ", '"+ rs.getString("nama_seksi") +"' "
				+  ", '"+ rs.getString("nama_dinas") +"' "
				+  ", '"+ rs.getString("nama_departemen") +"' "
				+  ", '"+ rs.getString("nama_divprosbu") +"' "
				+  ", '"+ rs.getString("nama_direktorat") +"' "
				+  ", '"+ rs.getString("pic") +"' "
				+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
