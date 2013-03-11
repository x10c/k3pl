<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- mhd.sulhan (ms@kilabit.org)
--%>

<%@ include file="../modinit.jsp" %>
<%
	ResultSet	rs_trn		= null;
	String		q_trn		= "";
	String		nipg		= "";
	int			start		= 0;
	int			limit		= 0;
	int			total		= 0;
try {
	start	= ServletUtilities.getIntParameter (request, "start", 0);
	limit	= ServletUtilities.getIntParameter (request, "limit", 50);

	db_q="	select	count (*)			as total"
		+"	from	r_pegawai			as a"
		+"	, 		r_jabatan			as b"
		+"	where	a.status_pegawai	= '1'"
		+"	and		a.id_jabatan		= b.id_jabatan"
		+"	and		a.id_divprosbu		= "+ user_div
		+"	and		a.id_direktorat		= "+ user_dir;

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		total	= db_rs.getInt ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	db_q="	with results as ("
		+"		select	a.nipg"
		+"		,		a.nama_pegawai"
		+"		,		a.id_jabatan"
		+"		,		b.nama_jabatan"
		+"		,		a.id_direktorat"
		+"		,		a.id_divprosbu"
		+"		,		row_number () over (order by nama_pegawai) as rownum"
		+"		from	r_pegawai			as a"
		+"		,		r_jabatan			as b"
		+"		where	a.status_pegawai	= '1'"
		+"		and		a.id_jabatan		= b.id_jabatan"
		+"		and		a.id_divprosbu		= "+ user_div
		+"		and		a.id_direktorat		= "+ user_dir
		+"	) select * from results where rownum >= "+ start +" and rownum <= "+ (start + limit);

	q_trn	="	select	id_pelatihan"
			+"	,		replace(convert(varchar, tanggal, 111), '/', '-') tanggal"
			+"	from	t_pelatihan"
			+"	where	id in ("
			+"		select	id"
			+"		from	t_pelatihan_peserta"
			+"		where	nipg = ?"
			+"	)";

	db_ps	= db_con.prepareStatement (q_trn);

	db_stmt	= db_con.createStatement();
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		json_o	= new JSONObject ();

		nipg	= db_rs.getString("nipg");

		json_o.put ("nipg"			, nipg);
		json_o.put ("nama_pegawai"	, db_rs.getString("nama_pegawai"));
		json_o.put ("id_jabatan"	, db_rs.getString("id_jabatan"));
		json_o.put ("nama_jabatan"	, db_rs.getString("nama_jabatan"));
		json_o.put ("id_direktorat"	, user_dir);
		json_o.put ("id_divprosbu"	, user_div);

		db_ps.setString (1, nipg);
		rs_trn = db_ps.executeQuery ();

		while (rs_trn.next()) {
			json_o.put (rs_trn.getString ("id_pelatihan"),  rs_trn.getString ("tanggal"));
		}

		rs_trn.close ();

		json_a.put (json_o);
	}

	db_rs.close ();
	db_stmt.close ();
	db_ps.close ();

	_return.put ("success"	, true);
	_return.put ("total"	, total);
	_return.put ("rows"		, json_a);

} catch (Exception e) {
	_return.put ("success"	, false);
	_return.put ("info"		, e);
	_return.put ("total"	, total);
} finally {
	out.print (_return);
}
%>
