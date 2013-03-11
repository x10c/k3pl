<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
String	nipg	= "";
String	q_where	= "";
int		start	= 0;
int		limit	= 0;
int		total	= 0;
try {
	nipg	= request.getParameter ("nipg");
	start	= ServletUtilities.getIntParameter (request, "start", 0);
	limit	= ServletUtilities.getIntParameter (request, "limit", 50);

	if (null != nipg) {
		q_where +=" where nipg = '"+ nipg +"'";
	} else {
		if (! "1".equals (user_group)) {
			q_where	+=" where	id_direktorat	= "+ user_dir
					+ " and		id_divprosbu	= "+ user_div;
		}
	}

	db_q=" select	count (*)	as total"
		+" from		r_pegawai"
		+ q_where;

	db_stmt = db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		total	= db_rs.getInt ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	/* full select query */
	db_q	="	with results as ("
			+"		select	nipg"
			+"		,		id_klasifikasi_pegawai"
			+"		,		id_jabatan"
			+"		,		id_direktorat"
			+"		,		id_divprosbu"
			+"		,		id_departemen"
			+"		,		id_dinas"
			+"		,		id_seksi"
			+"		,		nama_pegawai"
			+"		,		email"
			+"		,		status_pegawai"
			+"		,		row_number () over (order by nama_pegawai) as rownum"
			+"		from	r_pegawai"
			+ q_where
			+"	) select * from results where rownum >= "+ start +" and rownum <= "+ (start + limit);

	db_stmt = db_con.createStatement();
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		json_o = new JSONObject ();
		json_o.put ("nipg"						, db_rs.getString	("nipg"));
		json_o.put ("id_klasifikasi_pegawai"	, db_rs.getString	("id_klasifikasi_pegawai"));
		json_o.put ("id_jabatan"				, db_rs.getString ("id_jabatan"));
		json_o.put ("id_direktorat"				, db_rs.getString ("id_direktorat"));
		json_o.put ("id_divprosbu"				, db_rs.getString ("id_divprosbu"));
		json_o.put ("id_departemen"				, db_rs.getString ("id_departemen"));
		json_o.put ("id_dinas"					, db_rs.getString ("id_dinas"));
		json_o.put ("id_seksi"					, db_rs.getString ("id_seksi"));
		json_o.put ("nama_pegawai"				, db_rs.getString ("nama_pegawai"));
		json_o.put ("email"						, db_rs.getString ("email"));
		json_o.put ("status_pegawai"			, db_rs.getString ("status_pegawai"));

		json_a.put (json_o);
	}

	db_rs.close ();
	db_stmt.close ();

	_return.put ("success"	,true);
	_return.put ("total"	,total);
	_return.put ("data"		,json_a);

} catch (Exception e) {
	_return.put ("success"	, false);
	_return.put ("info"		, e);
} finally {
	out.print (_return);
}
%>
