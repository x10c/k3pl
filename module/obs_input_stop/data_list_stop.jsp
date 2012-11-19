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
	JSONArray	stop		= new JSONArray ();
	String		load_type	= (String) request.getParameter("load_type");
	int			start		= (int) Integer.parseInt (request.getParameter ("start"));
	int			limit		= (int) Integer.parseInt (request.getParameter ("limit"));
	int			i			= 0;

	db_stmt = db_con.createStatement();

	db_q=" select	X.*"
		+" from		("
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
		+" ,		row_number () over (order by id_stop) AS rownum"
		+" from		t_stop		A"
		+" ,		r_seksi		B"
		+" ,		r_pegawai	C"
		+" where	A.id_area_seksi	= B.id_seksi"
		+" and		A.nipg			= C.nipg"
		+" and		C.id_divprosbu	= "+ user_div;

	if (!load_type.equals("all")) {
		db_q +=" and	A.nipg		= '"+ user_nipg +"'";
	}

	db_q	+=" ) X"
			+" where X.rownum between "+ start +" and "+ limit
			+" order by	X.id_stop desc";

	db_rs = db_stmt.executeQuery (db_q);

	json_a = new JSONArray ();
	while (db_rs.next()) {
		stop = new JSONArray ();

		stop.put (db_rs.getString ("id_stop"));
		stop.put (db_rs.getString ("nipg"));
		stop.put (db_rs.getString ("nama_pegawai"));
		stop.put (db_rs.getString ("tanggal"));
		stop.put (db_rs.getString ("nama_area"));
		stop.put (db_rs.getString ("site"));
		stop.put (db_rs.getString ("shift"));
		stop.put (db_rs.getString ("lama_observasi"));
		stop.put (db_rs.getString ("jml_org_observasi"));
		stop.put (db_rs.getString ("jml_org_diskusi"));
		stop.put (db_rs.getString ("status_aktif"));

		json_a.put (stop);
	}

	out.print (json_a);

	db_rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
