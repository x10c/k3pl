<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	String		load_type	= (String) request.getParameter("load_type");
	int			start		= (int) Integer.parseInt (request.getParameter ("start"));
	int			limit		= (int) Integer.parseInt (request.getParameter ("limit"));
	long		total		= 0;

	db_stmt = db_con.createStatement();

	// get total
	db_q=" select	count_big (*) as total"
		+" from		t_stop		A"
		+" ,		r_seksi		B"
		+" ,		r_pegawai	C"
		+" where	A.id_area_seksi	= B.id_seksi"
		+" and		A.nipg			= C.nipg";

	if (! user_group.equalsIgnoreCase ("1")) {
		if (user_group.equalsIgnoreCase ("11")) {
			db_q+=" and	c.id_divprosbu	= "+ user_div
				+" and	c.id_direktorat	= "+ user_dir;
		} else {
			db_q	+="	and A.nipg = '"+ user_nipg +"'";
		}
	}

	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next ()) {
		total = db_rs.getLong ("total");
	}

	db_rs.close ();

	// get data
	db_q=" with results as ("
		+" select	A.id_stop"
		+" ,		A.nipg"
		+" ,		C.nama_pegawai"
		+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal"
		+" ,		B.nama_seksi as nama_area"
		+" ,		A.site"
		+" ,		A.shift"
		+" ,		A.lama_observasi"
		+" ,		A.jml_org_observasi"
		+" ,		A.jml_org_diskusi"
		+" ,		A.status_aktif"
		+" ,		row_number () over (order by C.nama_pegawai) AS rownum"
		+" from		t_stop		A"
		+" ,		r_seksi		B"
		+" ,		r_pegawai	C"
		+" where	A.id_area_seksi	= B.id_seksi"
		+" and		A.nipg			= C.nipg";

	if (! user_group.equalsIgnoreCase ("1")) {
		if (user_group.equalsIgnoreCase ("11")) {
			db_q+=" and	C.id_divprosbu	= "+ user_div
				+" and	C.id_direktorat	= "+ user_dir;
		} else {
			db_q	+="	and A.nipg = '"+ user_nipg +"'";
		}
	}

	db_q	+=" ) "
			+" select * from results where rownum >= "+ (start + 1) +" and rownum <= "+ (start + limit);

	db_rs = db_stmt.executeQuery (db_q);

	json_a = new JSONArray ();
	while (db_rs.next()) {
		json_o = new JSONObject ();

		json_o.put ("id"			,db_rs.getString ("id_stop"));
		json_o.put ("nipg"			,db_rs.getString ("nipg"));
		json_o.put ("nama_pegawai"	,db_rs.getString ("nama_pegawai"));
		json_o.put ("date"			,db_rs.getString ("tanggal"));
		json_o.put ("area"			,db_rs.getString ("nama_area"));
		json_o.put ("site"			,db_rs.getString ("site"));
		json_o.put ("shift"			,db_rs.getString ("shift"));
		json_o.put ("obs_time"		,db_rs.getString ("lama_observasi"));
		json_o.put ("n_obs"			,db_rs.getString ("jml_org_observasi"));
		json_o.put ("n_dis"			,db_rs.getString ("jml_org_diskusi"));
		json_o.put ("status_aktif"	,db_rs.getString ("status_aktif"));

		json_a.put (json_o);
	}

	db_rs.close ();

	_return.put ("success"	,true);
	_return.put ("data"		,json_a);
	_return.put ("total"	,total);
} catch (Exception e) {
	_return.put ("success"	,false);
	_return.put ("data"		,e);
}
out.print (_return);
%>
