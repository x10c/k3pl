<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>
<%@ include file="../modinit.jsp"%>
<%
JSONArray	f				= null;
JSONObject	fo				= null;
String		q_where			= "";
String		filter_field	= "";
String		filter_type		= "";
String		filter_v		= "";
String		filter_cmp		= "";
JSONArray	filter_list_v	= null;

try {
	JSONObject	data		= null;
	String		load_type	= (String) request.getParameter("load_type");
	int			start		= ServletUtilities.getIntParameter (request, "start", 0);
	int			limit		= ServletUtilities.getIntParameter (request, "limit", 50);
	int			total		= 0;
	String		filter		= request.getParameter ("filter");

	if (filter != null && ! filter.isEmpty ()) {
		f = new JSONArray (filter);

		for (int i = 0; i < f.length (); i++) {
			fo = f.getJSONObject (i);

			filter_field	= fo.getString ("field");
			filter_type		= fo.getString ("type");
			filter_v		= fo.getString ("value");

			if (filter_type.equals ("list")) {
				filter_list_v	= new JSONArray (filter_v);

				q_where	+=" and "+ filter_field +" in ("+ filter_list_v.join (",").replace ("\"", "") +") ";
			} else if (filter_type.equals ("boolean")) {
				if (filter_v.equals ("true")) {
					filter_v = "1";
				} else {
					filter_v = "0";
				}

				q_where	+=" and "+ filter_field +" = "+ filter_v;
			} else if (filter_type.equals ("date")) {
				filter_cmp = fo.getString ("comparison");

				if (filter_cmp.equals ("lt")) {
					filter_cmp = " < ";
				} else if (filter_cmp.equals ("gt")) {
					filter_cmp = " > ";
				} else if (filter_cmp.equals ("eq")) {
					filter_cmp = " = ";
				}

				q_where	+=" and "+ filter_field + filter_cmp +" replace(convert(varchar, cast ('"+ filter_v +"' as datetime), 111), '/', '-') ";
			} else {
				q_where	+=" and b.nipg	in ( select c.nipg from r_pegawai c where lower(c.nama_pegawai) like '%"+ filter_v +"%') ";
			}
		}
	}



	// get total
	db_q=" with results as ("
		+" select	distinct (a.id_rca)	as id_rca"
		+" ,		replace(convert(varchar, a.tanggal_rca, 111), '/', '-') as tanggal_rca "
		+" ,		a.auditor_seksi as id_seksi "
		+" ,		( select c.nama_seksi from r_seksi as c where a.auditor_seksi = c.id_seksi ) as auditor_seksi "
		+" ,		( select c.nama_pegawai from r_pegawai as c where b.nipg = c.nipg) as nama_auditor "
		+" ,		( select f.nama_seksi from r_seksi as f where a.penanggung_jawab_seksi = f.id_seksi ) as penanggung_jawab_seksi "
		+" ,		a.penanggung_jawab_nipg as pic "
		+" ,		( select g.nama_pegawai from r_pegawai as g where a.penanggung_jawab_nipg = g.nipg) as nama_pic "
		+" ,		'" + user_nipg + "' as user_login "
		+" ,		a.id_user	as id_user "
		+" ,		ROW_NUMBER() OVER (ORDER BY a.id_user asc, a.tanggal_rca desc) as rownum"
		+" from		t_rca	as a "
		+" ,		t_rca_auditor	as b "
		+" where	b.id_rca	= a.id_rca "
		+ q_where;

	if (! user_group.equalsIgnoreCase ("1")) {
		if (user_group.equalsIgnoreCase ("11")) {
			db_q+=" and	a.auditor_divprosbu		= "+ user_div
				+" and	a.auditor_direktorat	= "+ user_dir;
		} else {
			db_q	+="	and (A.id_user = '"+ user_nipg +"'"
					+ " or	A.penanggung_jawab_nipg = '"+ user_nipg +"')";
		}
	}

	db_q+=" ) select count (*) as total from results where 1 = 1 ";

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next()) {
		total = db_rs.getInt ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	// get data
	db_q=" with results as ("
		+" select	distinct(a.id_rca) as id_rca "
		+" ,		replace(convert(varchar, a.tanggal_rca, 111), '/', '-') as tanggal_rca "
		+" ,		a.auditor_seksi as id_seksi "
		+" ,		( select c.nama_seksi from r_seksi as c where a.auditor_seksi = c.id_seksi ) as auditor_seksi "
		+" ,		( select c.nama_pegawai from r_pegawai as c where b.nipg = c.nipg) as nama_auditor "
		+" ,		( select f.nama_seksi from r_seksi as f where a.penanggung_jawab_seksi = f.id_seksi ) as penanggung_jawab_seksi "
		+" ,		a.penanggung_jawab_nipg as pic "
		+" ,		( select g.nama_pegawai from r_pegawai as g where a.penanggung_jawab_nipg = g.nipg) as nama_pic "
		+" ,		'" + user_nipg + "' as user_login "
		+" ,		a.id_user	as id_user "
		+" ,		("
		+" 			select		case ISNULL(MIN(x.status), 1) when 3 then 'Closed' when 2 then 'Process' else 'Open' end"
		+" 			from		t_rca_detail	x"
		+" 			where		x.id_rca		= a.id_rca"
		+" 			group by	x.id_rca"
		+" 			) status"
		+" ,		ROW_NUMBER() OVER (ORDER BY a.id_user asc, a.tanggal_rca desc) as rownum"
		+" from		t_rca	as a "
		+" ,		t_rca_auditor	as b "
		+" where	b.id_rca	= a.id_rca "
		+ q_where;

	if (! user_group.equalsIgnoreCase ("1")) {
		if (user_group.equalsIgnoreCase ("11")) {
			db_q+=" and	a.auditor_divprosbu		= "+ user_div
				+" and	a.auditor_direktorat	= "+ user_dir;
		} else {
			db_q	+="	and (A.id_user = '"+ user_nipg +"'"
					+ " or	A.penanggung_jawab_nipg = '"+ user_nipg +"')";
		}
	}

	db_q+=" ) select * from results where rownum >= "+ start +" and rownum <= "+ (start + limit);

	db_stmt		= db_con.createStatement ();
	db_rs		= db_stmt.executeQuery (db_q);
	json_a		= new JSONArray ();
	while (db_rs.next()) {
		data = new JSONObject ();
		data.put ("id_rca"					, db_rs.getString("id_rca"));
		data.put ("tanggal_rca"				, db_rs.getString("tanggal_rca"));
		data.put ("id_seksi"				, db_rs.getString("id_seksi"));
		data.put ("auditor_seksi"			, db_rs.getString("auditor_seksi"));
		data.put ("nama_auditor"			, db_rs.getString("nama_auditor"));
		data.put ("penanggung_jawab_seksi"	, db_rs.getString("penanggung_jawab_seksi"));
		data.put ("pic"						, db_rs.getString("pic"));
		data.put ("nama_pic"				, db_rs.getString("nama_pic"));
		data.put ("user_login"				, db_rs.getString("user_login"));
		data.put ("id_user"					, db_rs.getString("id_user"));
		data.put ("status"					, db_rs.getString("status"));

		json_a.put (data);
	}

	_return.put ("success"	,true);
	_return.put ("data"		,json_a);
	_return.put ("total"	,total);

	db_rs.close();
	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
} finally {
	out.print (_return);
}
%>
