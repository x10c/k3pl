<%--
 % Copyright 2013 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - mhd.sulhan (ms@kilabit.org)
--%>

<%@ include file="../modinit.jsp" %>
<%
String	q_where		= "";
long	total		= 0;

try {
	int		is_in_org	= ServletUtilities.getIntParameter (request, "is_in_org", 1);
	int		id_dir		= ServletUtilities.getIntParameter (request, "id_dir", 0);
	int		id_div		= ServletUtilities.getIntParameter (request, "id_div", 0);
	int		id_dep		= ServletUtilities.getIntParameter (request, "id_dep", 0);
	int		id_dinas	= ServletUtilities.getIntParameter (request, "id_dinas", 0);
	int		id_seksi	= ServletUtilities.getIntParameter (request, "id_seksi", 0);
	int		id_wilayah	= ServletUtilities.getIntParameter (request, "id_wilayah", 0);
	int		id_area		= ServletUtilities.getIntParameter (request, "id_area", 0);
	int		year		= ServletUtilities.getIntParameter (request, "year" , 0);
	int		month		= ServletUtilities.getIntParameter (request, "month", 0);
	int		start		= ServletUtilities.getIntParameter (request, "start", 0);
	int		limit		= ServletUtilities.getIntParameter (request, "limit", 50);

	/* filter/aggregate by month */
	if (month != 0) {
		q_where	+=" and month(a.tanggal_rca) = "+ month;
	}
	if (id_dir != 0) {
		q_where += " and b.id_direktorat = "+ id_dir;
	}
	if (id_div != 0) {
		q_where += " and b.id_divprosbu = "+ id_div;
	}
	if (id_dep != 0) {
		q_where += " and b.id_departemen = "+ id_dep;
	}
	if (id_dinas != 0) {
		q_where += " and b.id_dinas	= "+ id_dinas;
	}
	if (id_seksi != 0) {
		q_where += " and b.id_seksi	= "+ id_seksi;
	}
	if (id_wilayah != 0) {
		q_where += " and b.id_wilayah = "+ id_wilayah;
	}
	if (id_area != 0) {
		q_where += " and b.id_seksi	= "+ id_area;
	}

	db_q=" 	select	count_big (*) as total"
		+"	from	t_rca						as a"
		+"	,		r_seksi						as b"
		+"	,		r_dinas						as c"
		+"	,		r_departemen				as d"
		+"	,		r_divprosbu					as e"
		+"	,		r_direktorat				as f"
		+"	,		t_rca_detail				as g"
		+"	where	a.id_rca						= g.id_rca"
		+"	and		a.penanggung_jawab_seksi		= b.id_seksi "
		+"	and		a.penanggung_jawab_dinas		= c.id_dinas "
		+"	and		a.penanggung_jawab_departemen	= d.id_departemen "
		+"	and		a.penanggung_jawab_divprosbu	= e.id_divprosbu "
		+"	and		a.penanggung_jawab_direktorat	= f.id_direktorat "
		+"	and		year(a.tanggal_rca)				= " + year
		+ q_where;

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		total	= db_rs.getLong ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	db_q="with results as ( "
		+"	select	g.description "
		+"		,	g.id_severity "
		+"		,	a.nama_tempat_rca "
		+"		,	a.penanggung_jawab_seksi "
		+"		,	b.nama_seksi "
		+"		,	a.penanggung_jawab_dinas "
		+"		,	c.nama_dinas "
		+"		,	a.penanggung_jawab_departemen "
		+"		,	d.nama_departemen "
		+"		,	a.penanggung_jawab_divprosbu "
		+"		,	e.nama_divprosbu "
		+"		,	a.penanggung_jawab_direktorat "
		+"		,	f.nama_direktorat "
		+"		,	REPLACE(CONVERT(varchar, g.COMPLETION_DATE_TARGET, 111), '/', '-') as completion_date_target "
		+"		,	g.status "
		+"		,	case g.status when '1' then 'Open' when '2' then 'Process' else 'Closed' end as nama_status "
		+"		,	g.note "
		+"		,	g.id_rca_detail "
		+"		,	( "
		+"				select	nama "
		+"				from 	( "
		+"							select	i.nama_pegawai						as nama "
		+"								, 	row_number() over(order by h.nipg) 	as rownum "
		+"							from 	t_rca_auditor 	as h "
		+"								, 	r_pegawai 		as i "
		+"							where 	h.nipg 		= i.nipg "
		+"							and 	h.id_rca	= a.id_rca "
		+"						) as hasil "
		+"				where rownum between 1 and 1 "
		+"			) as nama_auditor "
		+"		,	row_number () over (order by a.tanggal_rca,g.status) as rownum"
		+"	from	t_rca						as a"
		+"	,		r_seksi						as b"
		+"	,		r_dinas						as c"
		+"	,		r_departemen				as d"
		+"	,		r_divprosbu					as e"
		+"	,		r_direktorat				as f"
		+"	,		t_rca_detail				as g"
		+"	where	a.id_rca						= g.id_rca "
		+"	and		a.penanggung_jawab_seksi		= b.id_seksi "
		+"	and		a.penanggung_jawab_dinas		= c.id_dinas "
		+"	and		a.penanggung_jawab_departemen	= d.id_departemen "
		+"	and		a.penanggung_jawab_divprosbu	= e.id_divprosbu "
		+"	and		a.penanggung_jawab_direktorat	= f.id_direktorat "
		+"	and		year(a.tanggal_rca)				= " + year
		+ q_where
		+" ) select * from results where rownum >= "+ start +" and rownum <= "+ (start + limit);

	db_stmt		= db_con.createStatement();
	db_rs 		= db_stmt.executeQuery(db_q);
	json_a		= new JSONArray ();

	while (db_rs.next()) {
		json_o	= new JSONObject ();

		json_o.put ("description"					, db_rs.getString	("description"));
		json_o.put ("id_severity"					, db_rs.getInt		("id_severity"));
		json_o.put ("nama_tempat_rca"				, db_rs.getString	("nama_tempat_rca"));
		json_o.put ("penanggung_jawab_seksi"		, db_rs.getInt		("penanggung_jawab_seksi"));
		json_o.put ("nama_seksi"					, db_rs.getString	("nama_seksi"));
		json_o.put ("penanggung_jawab_dinas"		, db_rs.getInt		("penanggung_jawab_dinas"));
		json_o.put ("nama_dinas"					, db_rs.getString	("nama_dinas"));
		json_o.put ("penanggung_jawab_departemen"	, db_rs.getInt		("penanggung_jawab_departemen"));
		json_o.put ("nama_departemen"				, db_rs.getString	("nama_departemen"));
		json_o.put ("penanggung_jawab_divprosbu"	, db_rs.getInt		("penanggung_jawab_divprosbu"));
		json_o.put ("nama_divprosbu"				, db_rs.getString	("nama_divprosbu"));
		json_o.put ("penanggung_jawab_direktorat"	, db_rs.getInt		("penanggung_jawab_direktorat"));
		json_o.put ("nama_direktorat"				, db_rs.getString	("nama_direktorat"));
		json_o.put ("completion_date_target"		, db_rs.getString	("completion_date_target"));
		json_o.put ("status"						, db_rs.getInt		("status"));
		json_o.put ("nama_status"					, db_rs.getString	("nama_status"));
		json_o.put ("note"							, db_rs.getString	("note"));
		json_o.put ("id_rca_detail"					, db_rs.getInt		("id_rca_detail"));
		json_o.put ("nama_auditor"					, db_rs.getString	("nama_auditor"));

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
	_return.put ("total"	,total);
	_return.put ("db_q"		,db_q);
} finally {
	out.print (_return);
}
%>
