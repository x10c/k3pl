<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%@ page import="java.util.Calendar" %>
<%
try {
	String		dir				= request.getParameter ("dir");
	String		div				= request.getParameter ("div");
	int			year			= ServletUtilities.getIntParameter (request, "tahun", 0);
	int			month			= ServletUtilities.getIntParameter (request, "bulan", 0);
	String		tanggal_skrg	= "";
	String		tanggal_lalu	= "";
	String		q_where			= "";
	Calendar	cal				= Calendar.getInstance();

	if (month == 0) {
		month = cal.get (Calendar.MONTH) + 1;
	}

	tanggal_skrg = "cast('"+ year +"-"+ month +"-01' as datetime)";

	if (month == 1) {
		tanggal_lalu = "cast('"+ (year - 1) +"-12-01' as datetime)";
	} else {
		tanggal_lalu = "cast('"+ year +"-"+ (month - 1) +"-01' as datetime)";
	}

	if (! dir.equals ("0")) {
		q_where		=" and A.id_direktorat = "+ dir;
	}
	if (! div.equals ("0")) {
		q_where		+=" and A.id_divprosbu = "+ div;
	}

	db_stmt = db_con.createStatement();
	db_q	=" if exists (select tanggal from t_insiden where status_reset = 1";

	if (q_where.isEmpty ()) {
		db_q	+=" and id_divprosbu = "+ user_div +")";
	} else {
		db_q	+= q_where;
	}

db_q
+=" begin"
+"	select	X.kum_jk_bulan_skrg"
+"	,		Y.kum_jk_bulan_lalu"
+"	,		replace(convert(varchar, Z.tanggal, 111), '/', '-') tanggal"
+"	from"
+"	("
+"		select	isnull(sum(A.jml_jam_kerja),0)  as kum_jk_bulan_skrg"
+"		from	t_unjuk_kerja	A"
+"		,		t_insiden		B"
+"		where"
+"			B.status_reset	= 1"
+"		and	A.tanggal		>= B.tanggal"
+"		and	A.tanggal		<= "+ tanggal_skrg
+ q_where
+"	) X,"
+"	(	select	isnull(sum(A.jml_jam_kerja),0) as kum_jk_bulan_lalu"
+"		from	t_unjuk_kerja	A"
+"		,		t_insiden		B"
+"		where"
+"			B.status_reset	= 1"
+"		and	A.tanggal		>= B.tanggal"
+"		and	A.tanggal		<= "+ tanggal_lalu
+ q_where
+"	) Y,"
+"	(	select	tanggal"
+"		from	t_insiden"
+"		where	status_reset	= 1"
+ q_where
+"	) Z"
+" end else begin"
+"	select	X.kum_jk_bulan_skrg"
+"	,		Y.kum_jk_bulan_lalu"
+"	,		'-' as tanggal"
+"	from"
+"	("
+"		select	isnull(sum(A.jml_jam_kerja),0)  as kum_jk_bulan_skrg"
+"		from	t_unjuk_kerja	A"
+"		where	A.tanggal		<= "+ tanggal_skrg
+ q_where
+"	) X,"
+"	(	select	isnull(sum(A.jml_jam_kerja),0) as kum_jk_bulan_lalu"
+"		from	t_unjuk_kerja	A"
+"		where	A.tanggal		<= "+ tanggal_lalu
+ q_where
+"	) Y"
+" end";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next()) {
		json_o = new JSONObject ();
		json_o.put ("kum_jk_bulan_lalu"	, db_rs.getString ("kum_jk_bulan_lalu"));
		json_o.put ("kum_jk_bulan_skrg"	, db_rs.getString ("kum_jk_bulan_skrg"));
		json_o.put ("kum_tanggal"		, db_rs.getString ("tanggal"));

		json_a.put (json_o);
	}

	_return.put ("success", true);
	_return.put ("info", json_a);
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("query", db_q);
	_return.put ("info", e);
}
out.print (_return);
%>
