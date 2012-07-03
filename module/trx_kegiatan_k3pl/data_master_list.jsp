<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");

	if (user_div.equals ("")) {
		out.print("{success:false,info:'User Divisi/Proyek/SBU tidak diketahui.'}");
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		nipg	= (String) session.getAttribute("user.nipg");

	String q;

	q=" select	tahun "
	+" 	,		bulan "
	+" 	,		(	select	A.id_wilayah"
	+"				from	r_seksi		A"
	+"				,		r_pegawai	B"
	+"				where	A.id_seksi	= B.id_seksi"
	+"				and		B.nipg		= '" + nipg + "'"
	+"			) as wilayah"
	+" from		t_kegiatan "
	+" where	id_divprosbu = "+ user_div
	+" order by	tahun, bulan";

	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data+="[ "+ rs.getString("tahun")
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
