<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	String		load_type		= (String) request.getParameter("load_type");

	String q
		=" select	A.id_stop"
		+" ,		A.nipg"
		+" ,		C.nama_pegawai"
		+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal"
		+" ,		B.nama_seksi as nama_area"
		+" ,		A.site"
		+" ,		A.shift"
		+" ,		A.lama_observasi"
		+" ,		A.jml_org_observasi"
		+" ,		A.jml_org_diskusi"
		+" ,		A.status_aktif"
		+" from		t_stop		A"
		+" ,		r_seksi		B"
		+" ,		r_pegawai	C"
		+" where	A.id_area_seksi	= B.id_seksi"
		+" and		A.nipg			= C.nipg"
		+" and		C.id_divprosbu	= "+ user_div;

	if (!load_type.equals("all")) {
		q+=" and	A.nipg		= '"+ user_nipg +"'";
	}

	q+=" order by	A.id_stop desc";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data+="[ '"+ rs.getString("id_stop")
			+ "','"+ rs.getString("nipg")
			+ "',\""+ rs.getString("nama_pegawai") +"\""
			+ " ,'"+ rs.getString("tanggal")
			+ "','"+ rs.getString("nama_area")
			+ "','"+ rs.getString("site")
			+ "','"+ rs.getString("shift")
			+ "','"+ rs.getString("lama_observasi")
			+ "','"+ rs.getString("jml_org_observasi")
			+ "','"+ rs.getString("jml_org_diskusi")
			+ "','"+ rs.getString("status_aktif")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
