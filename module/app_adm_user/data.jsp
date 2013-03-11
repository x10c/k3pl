<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
String	q_where	= "";
int		total	= 0;
int		start	= 0;
int		limit	= 0;
try {
	start	= ServletUtilities.getIntParameter (request, "start", 0);
	limit	= ServletUtilities.getIntParameter (request, "limit", 50);

	if (! "1".equals (user_group)) {
		q_where	+=" and id_direktorat	= "+ user_dir
				+ " and id_divprosbu	= "+ user_div;
	}

	db_q	=" select	count (*) as total"
			+" from		__user		A"
			+" ,		r_pegawai	B"
			+" where	A.nipg 			= B.nipg"
			+ q_where;

	db_stmt = db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		total = db_rs.getInt ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	db_q	="	with results as ("
			+"		select	A.nipg"
			+"		,		B.nama_pegawai"
			+"		,		A.status_user"
			+"		,		row_number () over (order by B.nama_pegawai) as rownum"
			+"		from	__user		A"
			+"		,		r_pegawai	B"
			+"		where	A.nipg 		= B.nipg"
			+ q_where
			+"	) select * from results where rownum >= "+ start +" and rownum <= "+ (start + limit);

	db_stmt = db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	json_a	= new JSONArray ();
	while (db_rs.next()) {
		json_o	= new JSONObject ();
		json_o.put ("nipg"	,db_rs.getString ("nipg"));
		json_o.put ("name"	,db_rs.getString ("nama_pegawai"));
		json_o.put ("pass"	,"");
		json_o.put ("stat"	,db_rs.getString ("status_user"));

		json_a.put (json_o);
	}

	db_rs.close ();
	db_stmt.close ();

	_return.put ("success"	,true);
	_return.put ("total"	,total);
	_return.put ("data"		,json_a);

} catch (Exception e) {
	_return.put ("success"	,false);
	_return.put ("info"		,e);
	_return.put ("total"	,total);
} finally {
	out.print (_return);
}
%>
