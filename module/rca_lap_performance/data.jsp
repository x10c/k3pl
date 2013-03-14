<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- agus sugianto (agus.delonge@gmail.com)
		- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
String	q_nipg				= "";
String	q_nipg2				= "";
String	q_nipg3				= "";
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

	String		nipg;
	int			i,x;

	q_nipg	=" and nipg in ("
			+"	select	A.nipg"
			+"	from	r_pegawai	A"
			+"	where	A.status_pegawai = '1'";

	q_nipg2	=" and rca_auditor.nipg in ("
			+"	select	A.nipg"
			+"	from	r_pegawai	A"
			+"	where	A.status_pegawai = '1'";

	q_nipg3	=" and rca.penanggung_jawab_nipg in ("
			+"	select	A.nipg"
			+"	from	r_pegawai	A"
			+"	where	A.status_pegawai = '1'";

	q_part	=" select	count(rca_auditor.nipg) as total_part"
			+" from		t_rca				as rca"
			+" ,		t_rca_auditor		as rca_auditor"
			+" where	rca.id_rca			= rca_auditor.id_rca"
			+" and		rca_auditor.status			in (1,2)"
			+" and		year(rca.tanggal_rca)	= "+ year;

	q_partisi	=" select	count(distinct(rca_auditor.nipg)) as total_part"
				+" from		t_rca				as rca"
				+" ,		t_rca_auditor		as rca_auditor"
				+" where	rca.id_rca			= rca_auditor.id_rca"
				+" and		rca_auditor.status			in (1,2)"
				+" and		year(rca.tanggal_rca)	= "+ year;

	q_vio	=" select	cast(isnull(sum(rca_detail.number_of_violations),0) as varchar) as violation"
			+" from		t_rca_detail		as rca_detail"
			+" ,		t_rca				as rca"
			+" where	rca_detail.id_rca	= rca.id_rca"
			+" and		year(rca.tanggal_rca)	= "+ year;

	q_temuan	=" select	count(rca_detail.id_rca) as temuan"
				+" from		t_rca_detail		as rca_detail"
				+" ,		t_rca				as rca"
				+" where	rca_detail.id_rca		= rca.id_rca"
				+" and		rca_detail.id_severity	in (4,5)"
				+" and		year(rca.tanggal_rca)	= "+ year;

	q_sev	="select	cast(convert(decimal(18,2), case when sum(rca_detail.li_45) is null then 0 else (1.0 * (sum(rca_detail.li_45) * 100) / isnull(nullif(sum(rca_detail.number_of_violations), 0),1)) end) as varchar) as severity"
			+" from		t_rca_detail		as rca_detail"
			+" ,		t_rca				as rca"
			+" where	rca_detail.id_rca		= rca.id_rca"
			+" and		year(rca.tanggal_rca)	= "+ year;

	q_get_temuan	="select	count(rca_detail.id_rca)	as jml"
					+" from		t_rca_detail				as rca_detail"
					+" ,		t_rca						as rca"
					+" where	rca_detail.id_rca		= rca.id_rca"
					+" and		rca_detail.id_severity	in (4,5)"
					+" and		year(rca.tanggal_rca)	= "+ year;

	q_get_temuan_non	="select	count(rca_detail.id_rca)	as jml"
						+" from		t_rca_detail				as rca_detail"
						+" ,		t_rca						as rca"
						+" where	rca_detail.id_rca		= rca.id_rca"
						+" and		rca_detail.id_severity	in (1,2,3)"
						+" and		year(rca.tanggal_rca)	= "+ year;

	q_tl_temuan	=" select	count(rca_detail.id_rca)	as temuan"
				+" from		t_rca_detail				as rca_detail"
				+" ,		t_rca						as rca"
				+" where	rca_detail.id_rca		= rca.id_rca"
				+" and		rca_detail.id_severity	in (4,5)"
				+" and		rca_detail.status		in ('2','3')"
				+" and		year(rca.tanggal_rca)	= "+ year;

	q_tl_temuan_non	=" select	count(rca_detail.id_rca)	as temuan"
					+" from		t_rca_detail				as rca_detail"
					+" ,		t_rca						as rca"
					+" where	rca_detail.id_rca		= rca.id_rca"
					+" and		rca_detail.id_severity	in (1,2,3)"
					+" and		rca_detail.status		in ('2','3')"
					+" and		year(rca.tanggal_rca)	= "+ year;
				
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
			+" from		t_rca_detail		as rca_detail"
			+" ,		t_rca				as rca"
			+" ,		t_rca_auditor		as rca_auditor"
			+" where	rca_detail.id_rca		= rca.id_rca"
			+" and		rca.id_rca				= rca_auditor.id_rca"
			+" and		year(rca.tanggal_rca)	= "+ year;

	/* filter/aggregate by month */
	if (month == 0) {
		q_target ="select (";

		for (i = 0; i < months.length; i++) {
			if (i > 0) {
				q_target +="+";
			}
			q_target += " isnull(sum("+ months[i] +"),0)";
		}

		q_target +=") as target";
	} else {
		q_target			=" select isnull ( sum ("+ months[month - 1] +" ) , 1 ) as target";
		q_part				+=" and month(rca.tanggal_rca) = "+ month;
		q_partisi			+=" and month(rca.tanggal_rca) = "+ month;
		q_vio				+=" and month(rca.tanggal_rca) = "+ month;
		q_temuan			+=" and month(rca.tanggal_rca) = "+ month;
		q_sev				+=" and month(rca.tanggal_rca) = "+ month;
		q_get_temuan		+=" and month(rca.tanggal_rca) = "+ month;
		q_get_temuan_non	+=" and month(rca.tanggal_rca) = "+ month;
		q_tl_temuan			+=" and month(rca.tanggal_rca) = "+ month;
		q_tl_temuan_non		+=" and month(rca.tanggal_rca) = "+ month;
		q_avg				+=" and month(rca.tanggal_rca) = "+ month;
	}

	q_target	+="	from	t_rca_target_pegawai"
				+"	where	year = "+ year
				+ q_nipg;

	q_part				+= q_nipg2;
	q_partisi			+= q_nipg2;
	q_vio				+= q_nipg3;
	q_temuan			+= q_nipg3;
	q_sev				+= q_nipg3;
	q_get_temuan		+= q_nipg3;
	q_get_temuan_non	+= q_nipg3;
	q_tl_temuan			+= q_nipg3;
	q_tl_temuan_non		+= q_nipg3;
	q_avg				+= q_nipg3;

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

	rs_org	= stmt_org.executeQuery(q_org);
	json_a	= new JSONArray ();

	while (rs_org.next()) {
		id		= rs_org.getString("id");
		name	= rs_org.getString("name");

		db_q="	select	PARTISIPAN.total_part		as partisipan"
			+"	,		round ("
			+"				("
			+"					 P.total_part"
			+"					/"
			+"					cast ("
			+"						isnull ("
			+"							nullif ( T.target , 0 )"
			+"							, 1"
			+"						)"
			+"						as float"
			+"					)"
			+"				)"
			+"				* 100, 2, 1"
			+"			)							as total_part_percent"
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
			+"			)							as tl_temuan_non"
			+"	,		AVERAGE.average"
			+"	from	("+ q_target			+ q_where + id +")) T"
			+"	,		("+ q_partisi			+ q_where + id +")) PARTISIPAN"
			+"	,		("+ q_part				+ q_where + id +")) P"
			+"	,		("+ q_vio				+ q_where + id +")) V"
			+"	,		("+ q_temuan			+ q_where + id +")) TEMUAN"
			+"	,		("+ q_sev				+ q_where + id +")) SEV"
			+"	,		("+ q_get_temuan		+ q_where + id +")) GET_TEMUAN"
			+"	,		("+ q_tl_temuan			+ q_where + id +")) TL_TEMUAN"
			+"	,		("+ q_get_temuan_non	+ q_where + id +")) GET_TEMUAN_NON"
			+"	,		("+ q_tl_temuan_non		+ q_where + id +")) TL_TEMUAN_NON"
			+"	,		("+ q_avg				+ q_where + id +")) AVERAGE";

		db_rs	= db_stmt.executeQuery(db_q);

		while (db_rs.next()) {
			json_o	= new JSONObject ();

			json_o.put ("item"					,name);
			json_o.put ("partisipan"			,db_rs.getInt		("partisipan"));
			json_o.put ("total_part_percent"	,db_rs.getDouble	("total_part_percent"));
			json_o.put ("violation"				,db_rs.getDouble	("violation"));
			json_o.put ("temuan"				,db_rs.getDouble	("temuan"));
			json_o.put ("severity"				,db_rs.getDouble	("severity"));
			json_o.put ("jml_tl_temuan"			,db_rs.getDouble	("jml_tl_temuan"));
			json_o.put ("tl_temuan"				,db_rs.getDouble	("tl_temuan"));
			json_o.put ("jml_tl_temuan_non"		,db_rs.getDouble	("jml_tl_temuan_non"));
			json_o.put ("tl_temuan_non"			,db_rs.getDouble	("tl_temuan_non"));
			json_o.put ("avg"					,db_rs.getDouble	("average"));

			json_a.put (json_o);
		}

		db_rs.close ();
	}

	rs_org.close ();
	stmt_org.close ();

	_return.put ("success"	,true);
	_return.put ("data"		,json_a);
	_return.put ("query"	, db_q);
	_return.put ("q_org"	, q_org);

} catch (Exception e) {
	_return.put ("success"	, false);
	_return.put ("info"		, e);
	_return.put ("query"	, db_q);
} finally {
	out.print (_return);
}
%>
