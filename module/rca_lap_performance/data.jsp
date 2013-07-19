<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- agus sugianto (agus.delonge@gmail.com)
		- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
String	q_org				= "";
String	q_target			= "";
String	q_part				= "";
String	q_partisi			= "";
String	q_vio				= "";
String	q_temuan			= "";
String	q_sev				= "";
String	q_get_temuan		= "";
String	q_get_temuan_non	= "";
String	q_tl_temuan			= "";
String	q_tl_temuan_non		= "";
String	q_avg				= "";
String	q_sum				= "";
String	q_where				= "";
String	months[]			= {	"jan", "feb", "mar", "apr"
							,	"may", "jun", "jul", "aug"
							,	"sep", "oct", "nov", "dec"
							};
try {
	Statement	stmt_org	= db_con.createStatement();
				db_stmt		= db_con.createStatement();
	ResultSet	rs_org;
	String		id, name;

	int			is_in_org	= ServletUtilities.getIntParameter (request, "is_in_org", 1);
	int			id_dir		= ServletUtilities.getIntParameter (request, "id_dir", 0);
	int			id_div		= ServletUtilities.getIntParameter (request, "id_div", 0);
	int			id_dep		= ServletUtilities.getIntParameter (request, "id_dep", 0);
	int			id_dinas	= ServletUtilities.getIntParameter (request, "id_dinas", 0);
	int			id_seksi	= ServletUtilities.getIntParameter (request, "id_seksi", 0);
	int			id_wilayah	= ServletUtilities.getIntParameter (request, "id_wilayah", 0);
	int			id_area		= ServletUtilities.getIntParameter (request, "id_area", 0);
	int			year		= ServletUtilities.getIntParameter (request, "year", 0);
	int			month		= ServletUtilities.getIntParameter (request, "month", 0);
	String		tgl_before	= "";
	String		tgl_after	= "";
	String		q_date		= "";

	String		nipg;
	int			i,x;
	int			total_part			= 0;
	int			target				= 0;
	double		total_part_percent	= 0.0;

	/* filter/aggregate by month */
	if (month != 0) {
		if (month == 1) {
			tgl_before	= (year - 1) +"-12-25";
			tgl_after	= year +"-"+ month +"-24";
		} else {
			tgl_before	= year +"-"+ (month - 1) +"-25";
			tgl_after	= year +"-"+ month +"-24";
		}
	} else {
		tgl_before	= (year - 1) +"-12-25";
		tgl_after	= year +"-12-24";
	}

	q_date	+=	" and		rca.tanggal_rca	>= cast ('"+ tgl_before	+"' as datetime)"
			+	" and		rca.tanggal_rca	<= cast ('"+ tgl_after	+"' as datetime)";

	q_part	=" select	count(rca_auditor.nipg) as total_part"
			+" from		t_rca					as rca"
			+" ,		t_rca_auditor			as rca_auditor"
			+" ,		r_pegawai				as A"
			+" ,		r_seksi					as B"
			+"	,		__user					E"
			+"	,		__user_grup				F"
			+"	,		__grup_user				G"
			+" where	rca.id_rca				= rca_auditor.id_rca"
			+" and		rca_auditor.nipg		= A.nipg"
			+" and		A.status_pegawai		= '1'"
			+" and		A.id_seksi				= B.id_seksi"
			+"	and		A.nipg					= E.nipg"
			+"	and		E.nipg					= F.nipg"
			+"	and		F.id_grup				= G.id_grup"
			+"	and		G.id_grup				= 5"
			+"	and		A.status_pegawai		= '1'"
			+"	and		E.status_user			= 1";

	q_partisi	=" select	count(distinct(rca_auditor.nipg)) as total_part"
				+" from		t_rca					as rca"
				+" ,		t_rca_auditor			as rca_auditor"
				+" ,		r_pegawai				as A"
				+" ,		r_seksi					as B"
				+"	,		__user					E"
				+"	,		__user_grup				F"
				+"	,		__grup_user				G"
				+" where	rca.id_rca				= rca_auditor.id_rca"
				+" and		rca_auditor.nipg		= A.nipg"
				+" and		A.status_pegawai		= '1'"
				+" and		A.id_seksi				= B.id_seksi"
				+"	and		A.nipg					= E.nipg"
				+"	and		E.nipg					= F.nipg"
				+"	and		F.id_grup				= G.id_grup"
				+"	and		G.id_grup				= 5"
				+"	and		A.status_pegawai		= '1'"
				+"	and		E.status_user			= 1";

	q_vio	=" select	cast(isnull(sum(rca_detail.number_of_violations),0) as varchar) as violation"
			+" from		t_rca_detail				as rca_detail"
			+" ,		t_rca						as rca"
			+" ,		r_pegawai					as A"
			+" ,		r_seksi						as B"
			+"	,		__user						E"
			+"	,		__user_grup					F"
			+"	,		__grup_user					G"
			+" where	rca_detail.id_rca			= rca.id_rca"
			+" and		(rca.penanggung_jawab_nipg	= A.nipg"
			+"	or		rca.ID_USER					= A.NIPG)"
			+" and		A.status_pegawai			= '1'"
			+" and		A.id_seksi					= B.id_seksi"
			+"	and		A.nipg						= E.nipg"
			+"	and		E.nipg						= F.nipg"
			+"	and		F.id_grup					= G.id_grup"
			+"	and		G.id_grup					= 5"
			+"	and		A.status_pegawai			= '1'"
			+"	and		E.status_user				= 1";

	q_temuan	=" select	count(rca_detail.id_rca)	as temuan"
				+" from		t_rca_detail				as rca_detail"
				+" ,		t_rca						as rca"
				+" ,		r_pegawai					as A"
				+" ,		r_seksi						as B"
				+"	,		__user						E"
				+"	,		__user_grup					F"
				+"	,		__grup_user					G"
				+" where	rca_detail.id_rca			= rca.id_rca"
				+" and		rca_detail.id_severity		in (4,5)"
				+" and		(rca.penanggung_jawab_nipg	= A.nipg"
				+"	or		rca.ID_USER					= A.NIPG)"
				+" and		A.status_pegawai			= '1'"
				+" and		A.id_seksi					= B.id_seksi"
				+"	and		A.nipg						= E.nipg"
				+"	and		E.nipg						= F.nipg"
				+"	and		F.id_grup					= G.id_grup"
				+"	and		G.id_grup					= 5"
				+"	and		A.status_pegawai			= '1'"
				+"	and		E.status_user				= 1";

	q_sev	="select	cast(convert(decimal(18,2), case when sum(rca_detail.li_45) is null then 0 else (1.0 * (sum(rca_detail.li_45) * 100) / isnull(nullif(sum(rca_detail.number_of_violations), 0),1)) end) as varchar) as severity"
			+" from		t_rca_detail				as rca_detail"
			+" ,		t_rca						as rca"
			+" ,		r_pegawai					as A"
			+" ,		r_seksi						as B"
			+"	,		__user						E"
			+"	,		__user_grup					F"
			+"	,		__grup_user					G"
			+" where	rca_detail.id_rca			= rca.id_rca"
			+" and		(rca.penanggung_jawab_nipg	= A.nipg"
			+"	or		rca.ID_USER					= A.NIPG)"
			+" and		A.status_pegawai			= '1'"
			+" and		A.id_seksi					= B.id_seksi"
			+"	and		A.nipg						= E.nipg"
			+"	and		E.nipg						= F.nipg"
			+"	and		F.id_grup					= G.id_grup"
			+"	and		G.id_grup					= 5"
			+"	and		A.status_pegawai			= '1'"
			+"	and		E.status_user				= 1";

	q_get_temuan	="select	count(rca_detail.id_rca)	as jml"
					+" from		t_rca_detail				as rca_detail"
					+" ,		t_rca						as rca"
					+" ,		r_pegawai					as A"
					+" ,		r_seksi						as B"
					+"	,		__user						E"
					+"	,		__user_grup					F"
					+"	,		__grup_user					G"
					+" where	rca_detail.id_rca			= rca.id_rca"
					+" and		rca_detail.id_severity		in (4,5)"
					+" and		(rca.penanggung_jawab_nipg	= A.nipg"
					+"	or		rca.ID_USER					= A.NIPG)"
					+" and		A.status_pegawai			= '1'"
					+" and		A.id_seksi					= B.id_seksi"
					+"	and		A.nipg						= E.nipg"
					+"	and		E.nipg						= F.nipg"
					+"	and		F.id_grup					= G.id_grup"
					+"	and		G.id_grup					= 5"
					+"	and		A.status_pegawai			= '1'"
					+"	and		E.status_user				= 1";

	q_get_temuan_non	="select	count(rca_detail.id_rca)	as jml"
						+" from		t_rca_detail				as rca_detail"
						+" ,		t_rca						as rca"
						+" ,		r_pegawai					as A"
						+" ,		r_seksi						as B"
						+"	,		__user						E"
						+"	,		__user_grup					F"
						+"	,		__grup_user					G"
						+" where	rca_detail.id_rca			= rca.id_rca"
						+" and		rca_detail.id_severity		in (1,2,3)"
						+" and		(rca.penanggung_jawab_nipg	= A.nipg"
						+"	or		rca.ID_USER					= A.NIPG)"
						+" and		A.status_pegawai			= '1'"
						+" and		A.id_seksi					= B.id_seksi"
						+"	and		A.nipg						= E.nipg"
						+"	and		E.nipg						= F.nipg"
						+"	and		F.id_grup					= G.id_grup"
						+"	and		G.id_grup					= 5"
						+"	and		A.status_pegawai			= '1'"
						+"	and		E.status_user				= 1";

	q_tl_temuan	=" select	count(rca_detail.id_rca)	as temuan"
				+" from		t_rca_detail				as rca_detail"
				+" ,		t_rca						as rca"
				+" ,		r_pegawai					as A"
				+" ,		r_seksi						as B"
				+"	,		__user						E"
				+"	,		__user_grup					F"
				+"	,		__grup_user					G"
				+" where	rca_detail.id_rca			= rca.id_rca"
				+" and		rca_detail.id_severity		in (4,5)"
				+" and		rca_detail.status			in ('2','3')"
				+" and		(rca.penanggung_jawab_nipg	= A.nipg"
				+"	or		rca.ID_USER					= A.NIPG)"
				+" and		A.status_pegawai			= '1'"
				+" and		A.id_seksi					= B.id_seksi"
				+"	and		A.nipg						= E.nipg"
				+"	and		E.nipg						= F.nipg"
				+"	and		F.id_grup					= G.id_grup"
				+"	and		G.id_grup					= 5"
				+"	and		A.status_pegawai			= '1'"
				+"	and		E.status_user				= 1";

	q_tl_temuan_non	=" select	count(rca_detail.id_rca)	as temuan"
					+" from		t_rca_detail				as rca_detail"
					+" ,		t_rca						as rca"
					+" ,		r_pegawai					as A"
					+" ,		r_seksi						as B"
					+"	,		__user						E"
					+"	,		__user_grup					F"
					+"	,		__grup_user					G"
					+" where	rca_detail.id_rca			= rca.id_rca"
					+" and		rca_detail.id_severity		in (1,2,3)"
					+" and		rca_detail.status			in ('2','3')"
					+" and		(rca.penanggung_jawab_nipg	= A.nipg"
					+"	or		rca.ID_USER					= A.NIPG)"
					+" and		A.status_pegawai			= '1'"
					+" and		A.id_seksi					= B.id_seksi"
					+"	and		A.nipg						= E.nipg"
					+"	and		E.nipg						= F.nipg"
					+"	and		F.id_grup					= G.id_grup"
					+"	and		G.id_grup					= 5"
					+"	and		A.status_pegawai			= '1'"
					+"	and		E.status_user				= 1";

	q_avg	="	select"
			+"		cast ("
			+"			convert ("
			+"				decimal (18,2)"
			+"				,	case when sum (rca_detail.violation_x_severity) is null"
			+"					then 0"
			+"					else ("
			+"						1.0 * sum ("
			+"							rca_detail.violation_x_severity"
			+"						)"
			+"						/"
			+"						isnull ("
			+"							nullif ("
			+"									sum ( rca_detail.number_of_violations )"
			+"								,	0"
			+"							)"
			+"							,	1"
			+"						)"
			+"					)"
			+"					end"
			+"			)"
			+"			as varchar"
			+"		)"
			+"		as average"
			+" from		t_rca_detail				as rca_detail"
			+" ,		t_rca						as rca"
			+" ,		t_rca_auditor				as rca_auditor"
			+" ,		r_pegawai					as A"
			+" ,		r_seksi						as B"
			+"	,		__user						E"
			+"	,		__user_grup					F"
			+"	,		__grup_user					G"
			+" where	rca_detail.id_rca			= rca.id_rca"
			+" and		rca.id_rca					= rca_auditor.id_rca"
			+" and		(rca.penanggung_jawab_nipg	= A.nipg"
			+"	or		rca.ID_USER					= A.NIPG)"
			+" and		A.status_pegawai			= '1'"
			+" and		A.id_seksi					= B.id_seksi"
			+"	and		A.nipg						= E.nipg"
			+"	and		E.nipg						= F.nipg"
			+"	and		F.id_grup					= G.id_grup"
			+"	and		G.id_grup					= 5"
			+"	and		A.status_pegawai			= '1'"
			+"	and		E.status_user				= 1";

	/* filter/aggregate by month */
	if (month == 0) {
		q_target	="	select (isnull (sum (B.jan), 0) +"
					+"			isnull (sum (B.feb), 0) +"
					+"			isnull (sum (B.mar), 0) +"
					+"			isnull (sum (B.apr), 0) +"
					+"			isnull (sum (B.may), 0) +"
					+"			isnull (sum (B.jun), 0) +"
					+"			isnull (sum (B.jul), 0) +"
					+"			isnull (sum (B.aug), 0) +"
					+"			isnull (sum (B.sep), 0) +"
					+"			isnull (sum (B.oct), 0) +"
					+"			isnull (sum (B.nov), 0) +"
					+"			isnull (sum (B.dec), 0) ) as target";
	} else {
		q_target	=" select isnull ( sum (B."+ months[month - 1] +" ) , 0 ) as target";
	}

	q_part				+= q_date;
	q_partisi			+= q_date;
	q_vio				+= q_date;
	q_temuan			+= q_date;
	q_sev				+= q_date;
	q_get_temuan		+= q_date;
	q_get_temuan_non	+= q_date;
	q_tl_temuan			+= q_date;
	q_tl_temuan_non		+= q_date;
	q_avg				+= q_date;

	q_target	+=" from	r_pegawai				A"
				+"	,		t_rca_target_pegawai	B"
				+"	,		r_seksi					D"
				+"	,		__user					E"
				+"	,		__user_grup				F"
				+"	,		__grup_user				G"
				+"	where	B.year					= "+ year
				+"	and		A.nipg					= B.nipg"
				+"	and		A.id_seksi				= D.id_seksi"
				+"	and		A.nipg					= E.nipg"
				+"	and		E.nipg					= F.nipg"
				+"	and		F.id_grup				= G.id_grup"
				+"	and		G.id_grup				= 5"
				+"	and		A.status_pegawai		= '1'"
				+"	and		E.status_user			= 1";

	/* query by organisasi */
	if (is_in_org == 1) {
		if (id_seksi != 0) {
			/* select partisipasi by single seksi */
			q_org	=" select	id_seksi	as id"
					+" ,		nama_seksi	as name"
					+" from		r_seksi"
					+" where	id_seksi = "+ id_seksi;

			q_where	=" and A.id_seksi = ";

		} else if (id_dinas != 0) {
			/* select all seksi in one dinas */
			q_org	=" select	id_seksi	as id"
					+" ,		nama_seksi	as name"
					+" from		r_seksi"
					+" where	id_dinas = "+ id_dinas;

			q_where	=" and A.id_seksi = ";

		} else if (id_dep != 0) {
			/* select all dinas in one departement */
			q_org	=" select	id_dinas	as id"
					+" ,		nama_dinas	as name"
					+" from		r_dinas"
					+" where	id_departemen = "+ id_dep;

			q_where =" and A.id_dinas = ";

		} else if (id_div != 0) {
			/* select all departement */
			q_org	=" select	id_departemen	as id"
					+" ,		nama_departemen	as name"
					+" from		r_departemen"
					+" where	id_divprosbu = "+ id_div;

			q_where =" and A.id_departemen = ";
		} else if (id_dir != 0) {
			/* select all divisi */
			q_org	=" select	id_divprosbu	as id"
					+" ,		nama_divprosbu	as name"
					+" from		r_divprosbu"
					+" where	id_direktorat = "+ id_dir;

			q_where =" and A.id_divprosbu = ";
		} else {
			/* select all direktorat */
			q_org	=" select	id_direktorat	as id"
					+" ,		nama_direktorat	as name"
					+" from		r_direktorat";

			q_where =" and A.id_direktorat = ";
		}

	} else { /* query by wilayah/area */
		if (id_area != 0) {
			/* select partisipasi by single area */
			q_where	=" and A.id_seksi = ";

			q_org	=" select	id_seksi	as id"
					+" ,		nama_seksi	as name"
					+" from		r_seksi"
					+" where	id_seksi = "+ id_area;

		} else {
			if (id_wilayah != 0) {
				/* select all area in one wilayah */
				q_where	=" and A.id_seksi = ";

				q_org	=" select	id_seksi	as id"
						+" ,		nama_seksi	as name"
						+" from		r_seksi"
						+" where	id_wilayah = "+ id_wilayah;

			} else {
				/* select all wilayah */
				q_where =" and A.id_seksi = B.id_seksi"
						+" and B.id_wilayah = ";

				q_org	=" select	id_wilayah		as id"
						+" ,		nama_wilayah	as name"
						+" from		r_wilayah";
			}
		}
	}

	q_org	+=" order by name";

	rs_org	= stmt_org.executeQuery(q_org);
	json_a	= new JSONArray ();

	while (rs_org.next()) {
		id		= rs_org.getString("id");
		name	= rs_org.getString("name");

		db_q="	select	PARTISIPAN.total_part		as partisipan"
			+"	,		isnull (P.total_part, 0)	as total_part"
			+"	,		isnull (T.Target, 0)		as target"
			+"	,		V.violation"
			+"	,		TEMUAN.temuan"
			+"	,		SEV.severity"
			+"	,		TL_TEMUAN.temuan			as jml_tl_temuan"
			+"	,		round ("
			+"				("
			+"					TL_TEMUAN.temuan"
			+"					/"
			+"					cast ("
			+"						isnull ("
			+"							nullif ( GET_TEMUAN.jml , 0 )"
			+"							, 1"
			+"						)"
			+"						as float"
			+"					)"
			+"				)"
			+"				* 100, 2, 1"
			+"			)							as tl_temuan"
			+"	,		GET_TEMUAN_NON.jml			as jml_temuan_non"
			+"	,		TL_TEMUAN_NON.temuan		as jml_tl_temuan_non"
			+"	,		round ("
			+"				("
			+"					TL_TEMUAN_NON.temuan"
			+"					/ cast ("
			+"						isnull ("
			+"							nullif ( GET_TEMUAN_NON.jml, 0 )"
			+"							, 1"
			+"						)"
			+"						as float"
			+"					)"
			+"				 )"
			+"				* 100, 2, 1"
			+"			)							as persen_tl_temuan_non"
			+"	,		AVERAGE.average"
			+"	from	("+ q_target			+ q_where + id +") T"
			+"	,		("+ q_partisi			+ q_where + id +") PARTISIPAN"
			+"	,		("+ q_part				+ q_where + id +") P"
			+"	,		("+ q_vio				+ q_where + id +") V"
			+"	,		("+ q_temuan			+ q_where + id +") TEMUAN"
			+"	,		("+ q_sev				+ q_where + id +") SEV"
			+"	,		("+ q_get_temuan		+ q_where + id +") GET_TEMUAN"
			+"	,		("+ q_tl_temuan			+ q_where + id +") TL_TEMUAN"
			+"	,		("+ q_get_temuan_non	+ q_where + id +") GET_TEMUAN_NON"
			+"	,		("+ q_tl_temuan_non		+ q_where + id +") TL_TEMUAN_NON"
			+"	,		("+ q_avg				+ q_where + id +") AVERAGE";

		db_rs	= db_stmt.executeQuery(db_q);

		while (db_rs.next()) {
			json_o		= new JSONObject ();
			total_part	= db_rs.getInt ("total_part");
			target		= db_rs.getInt ("target");

			if (target <= 0) {
				total_part_percent	= 0.00;
			} else {
				total_part_percent	= new BigDecimal ((total_part / (target * 1.00)) * 100).setScale (2, RoundingMode.HALF_UP).doubleValue ();
			}

			json_o.put ("item"					,name);
			json_o.put ("partisipan"			,db_rs.getInt		("partisipan"));
			json_o.put ("target"				,target);
			json_o.put ("partisipasi"			,total_part);
			json_o.put ("total_part_percent"	,total_part_percent);
			json_o.put ("violation"				,db_rs.getDouble	("violation"));
			json_o.put ("temuan"				,db_rs.getDouble	("temuan"));
			json_o.put ("severity"				,db_rs.getDouble	("severity"));
			json_o.put ("jml_tl_temuan"			,db_rs.getDouble	("jml_tl_temuan"));
			json_o.put ("tl_temuan"				,db_rs.getDouble	("tl_temuan"));
			json_o.put ("jml_tl_temuan_non"		,db_rs.getDouble	("jml_tl_temuan_non"));
			json_o.put ("jml_temuan_non"		,db_rs.getDouble	("jml_temuan_non"));
			json_o.put ("persen_tl_temuan_non"	,db_rs.getDouble	("persen_tl_temuan_non"));
			json_o.put ("avg"					,db_rs.getDouble	("average"));

			json_a.put (json_o);
		}

		db_rs.close ();
	}

	rs_org.close ();
	stmt_org.close ();

	_return.put ("success"	,true);
	_return.put ("data"		,json_a);

} catch (Exception e) {
	_return.put ("success"	, false);
	_return.put ("info"		, e);
	_return.put ("query"	, db_q);
	_return.put ("q_org"	, q_org);
} finally {
	out.print (_return);
}
%>
