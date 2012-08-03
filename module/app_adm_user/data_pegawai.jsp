<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies			= request.getCookies ();
	String		id_divprosbu	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		id_direktorat	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement db_stmt = db_con.createStatement();
	
	String		nipg		= request.getParameter("nipg");
	String 		p="";
	String where_clause ="";
	p = " select nipg from r_pegawai where nipg in	( "
			+"						select 	nipg "
			+"						from	__user_grup "
			+"						where	id_grup	= 9 "
			+"					) ";
	ResultSet	rs_val	= db_stmt.executeQuery(p);
	

	if (rs_val.next()){
		where_clause = " ";
	}else{
		where_clause = " and		id_direktorat	= " + id_direktorat
						+ " and		id_divprosbu	= " + id_divprosbu;
	}

	q=" select	nipg"
	+ " ,		nama_pegawai"
	+ " from	r_pegawai"
	+ " where	status_pegawai	= '1'"
	+ where_clause
	+ " and		nipg not in (select nipg from __user)"
	+ " order by	nama_pegawai";
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[\""+ rs.getString("nipg") +"\""
			+  ",\""+ rs.getString("nama_pegawai") +"\""
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
