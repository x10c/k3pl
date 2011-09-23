<%--
% Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
%
% Author(s):
% + PT. Awakami
%   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%
String rca_months
="[{"
+"	id	: '1'"
+",	name	: 'Jan'"
+"},{"
+"	id	: '2'"
+",	name	: 'Feb'"
+"},{"
+"	id	: '3'"
+",	name	: 'Mar'"
+"},{"
+"	id	: '4'"
+",	name	: 'Apr'"
+"},{"
+"	id	: '5'"
+",	name	: 'Mei'"
+"},{"
+"	id	: '6'"
+",	name	: 'Jun'"
+"},{"
+"	id	: '7'"
+",	name	: 'Jul'"
+"},{"
+"	id	: '8'"
+",	name	: 'Agu'"
+"},{"
+"	id	: '9'"
+",	name	: 'Sep'"
+"},{"
+"	id	: '10'"
+",	name	: 'Okt'"
+"},{"
+"	id	: '11'"
+",	name	: 'Nov'"
+"},{"
+"	id	: '12'"
+",	name	: 'Des'"
+"}]";

try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt	= db_con.createStatement();

	String		year		= (String) request.getParameter ("year");
	String		month_start	= (String) request.getParameter ("month_start");
	String		month_end	= (String) request.getParameter ("month_end");
	int		start, end;

	if (month_start == null) {
		start = 0;
	} else {
		start = Integer.parseInt(month_start);
		start--;
	}
	if (month_end == null) {
		end = 12;
	} else {
		end = Integer.parseInt(month_end);
		end--;
	}

	JSONArray	rca		= new JSONArray (rca_months);
	JSONArray	data	= new JSONArray();
	JSONObject	rca_month;

	ResultSet	rs;
	String		q, month;
	int			i, a;

	for (i = 0; i < rca.length(); i++) {
		if (i < start || i > end) {
			continue;
		}

		rca_month	= rca.getJSONObject(i);
		month		= rca_month.getString("id");

		q
=" select"
+" 		PL.jumlah	as penjualan_dan_layanan"
+" ,	OP.jumlah	as operasi_dan_pemeliharaan"
+" ,	IJK.jumlah	as integritas_jaringan_dan_k3pl"
+" ,	EP.jumlah	as enjiniring_dan_pembangunan"
+" ,	KS.jumlah	as keuangan_dan_sdm"
+" ,	LAU.jumlah	as logistik_dan_administrasi_umum"
+" ,	TOT.jumlah	as total"
+" from"
+" ("
+" 	select	convert(decimal(18,2), case when sum(b.li_45) is null then 0 else (1.0 * (sum(b.li_45) * 100) / isnull(sum(b.number_of_violations),1)) end) as jumlah "
+"	from	t_rca			as a "
+"	,		t_rca_detail	as b "
+"	where	a.id_rca						= b.id_rca "
+"	and		month(a.tanggal_rca)			= " + month
+"	and		year(a.tanggal_rca)				= " + year
+"	and		a.penanggung_jawab_departemen	= 1 "
+" ) PL,"
+" ("
+" 	select	convert(decimal(18,2), case when sum(b.li_45) is null then 0 else (1.0 * (sum(b.li_45) * 100) / isnull(sum(b.number_of_violations),1)) end) as jumlah "
+"	from	t_rca			as a "
+"	,		t_rca_detail	as b "
+"	where	a.id_rca						= b.id_rca "
+"	and		month(a.tanggal_rca)			= " + month
+"	and		year(a.tanggal_rca)				= " + year
+"	and		a.penanggung_jawab_departemen	= 2 "
+" ) OP,"
+" ("
+" 	select	convert(decimal(18,2), case when sum(b.li_45) is null then 0 else (1.0 * (sum(b.li_45) * 100) / isnull(sum(b.number_of_violations),1)) end) as jumlah "
+"	from	t_rca			as a "
+"	,		t_rca_detail	as b "
+"	where	a.id_rca						= b.id_rca "
+"	and		month(a.tanggal_rca)			= " + month
+"	and		year(a.tanggal_rca)				= " + year
+"	and		a.penanggung_jawab_departemen	= 3 "
+" ) IJK,"
+" ("
+" 	select	convert(decimal(18,2), case when sum(b.li_45) is null then 0 else (1.0 * (sum(b.li_45) * 100) / isnull(sum(b.number_of_violations),1)) end) as jumlah "
+"	from	t_rca			as a "
+"	,		t_rca_detail	as b "
+"	where	a.id_rca						= b.id_rca "
+"	and		month(a.tanggal_rca)			= " + month
+"	and		year(a.tanggal_rca)				= " + year
+"	and		a.penanggung_jawab_departemen	= 4 "
+" ) EP,"
+" ("
+" 	select	convert(decimal(18,2), case when sum(b.li_45) is null then 0 else (1.0 * (sum(b.li_45) * 100) / isnull(sum(b.number_of_violations),1)) end) as jumlah "
+"	from	t_rca			as a "
+"	,		t_rca_detail	as b "
+"	where	a.id_rca						= b.id_rca "
+"	and		month(a.tanggal_rca)			= " + month
+"	and		year(a.tanggal_rca)				= " + year
+"	and		a.penanggung_jawab_departemen	= 5 "
+" ) KS,"
+" ("
+" 	select	convert(decimal(18,2), case when sum(b.li_45) is null then 0 else (1.0 * (sum(b.li_45) * 100) / isnull(sum(b.number_of_violations),1)) end) as jumlah "
+"	from	t_rca			as a "
+"	,		t_rca_detail	as b "
+"	where	a.id_rca						= b.id_rca "
+"	and		month(a.tanggal_rca)			= " + month
+"	and		year(a.tanggal_rca)				= " + year
+"	and		a.penanggung_jawab_departemen	= 6 "
+" ) LAU,"
+" ("
+" 	select	convert(decimal(18,2), case when sum(b.li_45) is null then 0 else (1.0 * (sum(b.li_45) * 100) / isnull(sum(b.number_of_violations),1)) end) as jumlah "
+"	from	t_rca			as a "
+"	,		t_rca_detail	as b "
+"	where	a.id_rca						= b.id_rca "
+"	and		month(a.tanggal_rca)			= " + month
+"	and		year(a.tanggal_rca)				= " + year
+" ) TOT";

		rs = db_stmt.executeQuery(q);

		if (!rs.next()) {
			rs.close();
			continue;
		}

		rca_month.put("penjualan_dan_layanan", rs.getString("penjualan_dan_layanan"));
		rca_month.put("operasi_dan_pemeliharaan", rs.getString("operasi_dan_pemeliharaan"));
		rca_month.put("integritas_jaringan_dan_k3pl", rs.getString("integritas_jaringan_dan_k3pl"));
		rca_month.put("enjiniring_dan_pembangunan", rs.getString("enjiniring_dan_pembangunan"));
		rca_month.put("keuangan_dan_sdm", rs.getString("keuangan_dan_sdm"));
		rca_month.put("logistik_dan_administrasi_umum", rs.getString("logistik_dan_administrasi_umum"));
		rca_month.put("total", rs.getString("total"));

		data.put(rca_month);

		rs.close();
	}

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
