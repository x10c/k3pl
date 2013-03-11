<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
String	q_where	= "";
try {
	JSONArray	data		= null;
	String		date_bgn	= request.getParameter("date_bgn");
	String		date_end	= request.getParameter("date_end");
	String		user		= request.getParameter("user");
	String		menu		= request.getParameter("menu");
	String		stat		= request.getParameter("stat");
	int			start		= ServletUtilities.getIntParameter (request, "start", 0);
	int			limit		= ServletUtilities.getIntParameter (request, "limit", 50);
	int			offset		= start * limit;
	int			total		= 0;

	if (date_bgn != null && !date_bgn.equals("")) {
		q_where	+=" and A.tanggal >= cast('"+ date_bgn +"' as datetime)";
	}
	if (date_end != null && !date_end.equals("")) {
		q_where	+=" and A.tanggal <= cast('"+ date_end +"' as datetime)";
	}
	if (user != null && !user.equals("")) {
		q_where	+=" and B.nama_pegawai like '%"+ user +"%'";
	}
	if (menu != null && !menu.equals("")) {
		q_where	+=" and A.nama_menu = '"+ menu +"'";
	}
	if (stat != null && !stat.equals("")) {
		q_where	+=" and A.status_akses = '"+ stat +"'";
	}

	db_q	=" select	count (*) as total"
			+" from		__log		A"
			+" ,		r_pegawai	B"
			+" where	A.nipg = B.nipg"
			+ q_where;

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		total = db_rs.getInt ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	db_q	=" with results as ("
			+"	select	replace(convert(varchar, A.tanggal, 120), '/', '-') tanggal"
			+"	,		B.nama_pegawai"
			+"	,		A.nama_menu"
			+"	,		A.status_akses"
			+"	,		row_number () over (order by A.tanggal desc) as rownum"
			+"	from	__log		A"
			+"	,		r_pegawai	B"
			+"	where	A.nipg = B.nipg"
			+ q_where
			+" ) select * from results where rownum >= "+ offset +" and rownum <= "+ (offset + limit);

	db_stmt		= db_con.createStatement ();
	db_rs		= db_stmt.executeQuery(db_q);

	json_a		= new JSONArray ();
	while (db_rs.next()) {
		json_o	= new JSONObject ();

		json_o.put ("date"	,db_rs.getString	("tanggal"));
		json_o.put ("user"	,db_rs.getString	("nama_pegawai"));
		json_o.put ("menu"	,db_rs.getString	("nama_menu"));
		json_o.put ("stat"	,db_rs.getInt		("status_akses"));

		json_a.put (json_o);
	}

	db_rs.close ();
	db_stmt.close ();

	_return.put ("success"	,true);
	_return.put ("data"		,json_a);
	_return.put ("total"	,total);

} catch (Exception e) {
	_return.put ("success"	,false);
	_return.put ("info"		,e);
} finally {
	out.print (_return);
}
%>
