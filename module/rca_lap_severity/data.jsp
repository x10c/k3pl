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
String	months[]	= {	"jan", "feb", "mar", "apr"
					,	"may", "jun", "jul", "aug"
					,	"sep", "oct", "nov", "dec"
					};

try {
	String		id, name;
	String		is_in_org	= request.getParameter("is_in_org");
	String		id_dir		= request.getParameter("id_dir");
	String		id_div		= request.getParameter("id_div");
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		id_wilayah	= request.getParameter("id_wilayah");
	String		id_area		= request.getParameter("id_area");
	String		year		= request.getParameter("year");
	int			month		= Integer.parseInt(request.getParameter("month"));
	int			start		= ServletUtilities.getIntParameter (request, "start", 0);
	int			limit		= ServletUtilities.getIntParameter (request, "limit", 50);
	int			offset		= start * limit;
	int			total		= 0;

	/* filter/aggregate by month */
	if (month != 0) {
		q_where	+=" and month(a.tanggal_rca) = "+ month;
	}
	if (id_dir != null
	&& !(id_dir.equals ("0") || id_dir.equals (""))) {
		q_where += " and b.id_direktorat = "+ id_dir;
	}
	if (id_div != null
	&& !(id_div.equals ("0") || id_div.equals (""))) {
		q_where += " and b.id_divprosbu = "+ id_div;
	}
	if (id_dep != null
	&& !(id_dep.equals("0") || id_dep.equals(""))) {
		q_where += " and	b.id_departemen	= "+ id_dep;
	}
	if (id_dinas != null
	&& !(id_dinas.equals("0") || id_dinas.equals(""))) {
		q_where += " and	b.id_dinas	= "+ id_dinas;
	}
	if (id_seksi != null
	&& !(id_seksi.equals("0") || id_seksi.equals(""))) {
		q_where += " and	b.id_seksi	= "+ id_seksi;
	}
	if (id_wilayah != null
	&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
		q_where += " and	b.id_wilayah	= "+ id_wilayah;
	}
	if (id_area != null
	&& !(id_area.equals("0") || id_area.equals(""))) {
		q_where += " and	b.id_seksi	= "+ id_area;
	}

	db_q=" 	select	count (*) as total"
		+"	from	t_rca						as a"
		+"	,		r_seksi						as b"
		+"	,		r_dinas						as c"
		+"	,		r_departemen				as d"
		+"	,		r_divprosbu					as e"
		+"	,		r_direktorat				as f"
		+"	,		t_rca_detail				as g"
		+"	where	a.penanggung_jawab_seksi		= b.id_seksi "
		+"	and		a.penanggung_jawab_dinas		= b.id_dinas "
		+"	and		a.penanggung_jawab_departemen	= b.id_departemen "
		+"	and		a.penanggung_jawab_divprosbu	= b.id_divprosbu "
		+"	and		a.penanggung_jawab_direktorat	= b.id_direktorat "
		+"	and		b.id_dinas						= c.id_dinas "
		+"	and		b.id_departemen					= d.id_departemen "
		+"	and		b.id_divprosbu					= e.id_divprosbu "
		+"	and		b.id_direktorat					= f.id_direktorat "
		+"	and		a.id_rca						= g.id_rca "
		+"	and		year(a.tanggal_rca)				= " + year
		+ q_where;

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		total	= db_rs.getInt ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	db_q=";with results as ( "
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
		+"		,	row_number () over (order by a.tanggal_rca, g.status) as rownum"
		+"	from	t_rca						as a"
		+"	,		r_seksi						as b"
		+"	,		r_dinas						as c"
		+"	,		r_departemen				as d"
		+"	,		r_divprosbu					as e"
		+"	,		r_direktorat				as f"
		+"	,		t_rca_detail				as g"
		+"	where	a.penanggung_jawab_seksi		= b.id_seksi "
		+"	and		a.penanggung_jawab_dinas		= b.id_dinas "
		+"	and		a.penanggung_jawab_departemen	= b.id_departemen "
		+"	and		a.penanggung_jawab_divprosbu	= b.id_divprosbu "
		+"	and		a.penanggung_jawab_direktorat	= b.id_direktorat "
		+"	and		b.id_dinas						= c.id_dinas "
		+"	and		b.id_departemen					= d.id_departemen "
		+"	and		b.id_divprosbu					= e.id_divprosbu "
		+"	and		b.id_direktorat					= f.id_direktorat "
		+"	and		a.id_rca						= g.id_rca "
		+"	and		year(a.tanggal_rca)				= " + year
		+ q_where
		+" ) select * from results where rownum >= "+ offset +" and rownum <= "+ (offset + limit);

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
	_return.put ("total", total);

} catch (Exception e) {
	_return.put ("success"	,false);
	_return.put ("info"		,e);
	_return.put ("total"	,0);
} finally {
	out.print (_return);
}
%>
