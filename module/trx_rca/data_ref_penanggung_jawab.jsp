<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies			= request.getCookies ();
	String		id_divprosbu	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		id_direktorat	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement	db_stmt			= db_con.createStatement();
	
	String	q	=" "
			+"	select		a.id_seksi "
			+" 		,		a.id_dinas "
			+" 		,		a.id_departemen "
			+" 		,		a.id_divprosbu "
			+" 		,		a.id_direktorat "
			+" 		,		a.nama_seksi "
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
			+" 				)	as kepala_seksi "
			+"	from		r_seksi as a "
			+"	where		a.id_divprosbu	= " + id_divprosbu
			+"	and			a.id_direktorat = " + id_direktorat
			+" 	order by	a.nama_seksi ";

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
				+  ", '"+ rs.getString("kepala_seksi") +"' "
				+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
