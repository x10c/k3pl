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
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies			= request.getCookies ();
	String		nipg			= (String) request.getParameter ("nipg");
	String		id_divprosbu	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		id_direktorat	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement	db_stmt = db_con.createStatement();
	String		start	= request.getParameter("start");
	String		end	= request.getParameter("end");
	
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
		where_clause = " where 		id_direktorat	= " + id_direktorat
						+ " and		id_divprosbu	= " + id_divprosbu;
	}

	String q=" select	nipg "
		+" ,		id_klasifikasi_pegawai "
		+" ,		id_jabatan "
		+" ,		id_direktorat "
		+" ,		id_divprosbu "
		+" ,		id_departemen "
		+" ,		id_dinas "
		+" ,		id_seksi "
		+" ,		nama_pegawai "
		+" ,		email "
		+" ,		status_pegawai "
		+" from		r_pegawai "
		+ where_clause;

	if (null != nipg) {
		q +=" and nipg = '"+ nipg +"'";
	}

	q += " order by	nama_pegawai";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		nama, data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="['"+ rs.getString("nipg") +"'"
			+ ","+ rs.getString("id_klasifikasi_pegawai")
			+ ","+ rs.getString("id_jabatan")
			+ ","+ rs.getString("id_direktorat")
			+ ","+ rs.getString("id_divprosbu")
			+ ","+ rs.getString("id_departemen")
			+ ","+ rs.getString("id_dinas")
			+ ","+ rs.getString("id_seksi")
			+ ",\""+ rs.getString("nama_pegawai") +"\""
			+ ",'"+ rs.getString("email") +"'"
			+ ",'"+ rs.getString("status_pegawai") +"'"
			+  "]";
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
