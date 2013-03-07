<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray	data		= null;
	String		date_bgn	= request.getParameter("date_bgn");
	String		date_end	= request.getParameter("date_end");
	String		user		= request.getParameter("user");
	String		menu		= request.getParameter("menu");
	String		stat		= request.getParameter("stat");

	db_q	=" select"
			+" 			replace(convert(varchar, A.tanggal, 120), '/', '-') tanggal"
			+" ,		B.nama_pegawai"
			+" ,		A.nama_menu"
			+" ,		A.status_akses"
			+" from		__log		A"
			+" ,		r_pegawai	B"
			+" where	A.nipg = B.nipg";

	if (date_bgn != null && !date_bgn.equals("")) {
		db_q	+=" and A.tanggal >= cast('"+ date_bgn +"' as datetime)";
	}
	if (date_end != null && !date_end.equals("")) {
		db_q	+=" and A.tanggal <= cast('"+ date_end +"' as datetime)";
	}
	if (user != null && !user.equals("")) {
		db_q	+=" and B.nama_pegawai like '%"+ user +"%'";
	}
	if (menu != null && !menu.equals("")) {
		db_q	+=" and A.nama_menu = '"+ menu +"'";
	}
	if (stat != null && !stat.equals("")) {
		db_q	+=" and A.status_akses = '"+ stat +"'";
	}

	db_q		+=" order by	A.tanggal desc";

	db_stmt		= db_con.createStatement ();
	db_rs		= db_stmt.executeQuery(db_q);

	json_a		= new JSONArray ();
	while (db_rs.next()) {
		data = new JSONArray ();

		data.put (db_rs.getString	("tanggal"));
		data.put (db_rs.getString	("nama_pegawai"));
		data.put (db_rs.getString	("nama_menu"));
		data.put (db_rs.getInt		("status_akses"));

		json_a.put (data);
	}

	out.print (json_a);

	db_rs.close ();
	db_stmt.close ();

} catch (Exception e) {
	_return.put ("success"	,false);
	_return.put ("info"		,e);
	out.print (_return);
}
%>
