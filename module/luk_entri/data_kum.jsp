<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	String		data		= "{rows:[";
	int		year		= Integer.parseInt((String) request.getParameter("year"));
	int		month		= Integer.parseInt((String) request.getParameter("month"));
	String		tanggal_skrg	= "cast('"+ year +"-"+ month +"-01' as datetime)";
	String		tanggal_lalu;

	if (month == 1) {
		tanggal_lalu = "cast('"+ (year - 1) +"-12-01' as datetime)";
	} else {
		tanggal_lalu = "cast('"+ year +"-"+ (month - 1) +"-01' as datetime)";
	}

	q
=" if exists (select tanggal from t_insiden where status_reset = 1)"
+" begin"
+"	select	W.kum_hari_kerja"
+"	,		W.kum_hari_absen"
+"	,		X.kum_jk_bulan_skrg"
+"	,		Y.kum_jk_bulan_lalu"
+"	,		replace(convert(varchar, Z.tanggal, 111), '/', '-') tanggal"
+"	from"
+"	(	select	isnull(sum(A.jml_hari_kerja),0) as kum_hari_kerja"
+"		,		isnull(sum(A.jml_hari_absen),0) as kum_hari_absen"
+" 		from	t_unjuk_kerja	A"
+"		,		t_insiden		B"
+"		where"
+"		B.status_reset	= 1"
+"		and	A.tanggal	>= B.tanggal"
+"		and A.tanggal	<= "+ tanggal_skrg
+"	) W,"
+"	("
+"		select	isnull(sum(A.jml_jam_kerja),0)  as kum_jk_bulan_skrg"
+"		from	t_unjuk_kerja	A"
+"		,		t_insiden		B"
+"		where"
+"			B.status_reset	= 1"
+"		and	A.tanggal		>= B.tanggal"
+"		and	A.tanggal		<= "+ tanggal_skrg
+"	) X,"
+"	(	select	isnull(sum(A.jml_jam_kerja),0) as kum_jk_bulan_lalu"
+"		from	t_unjuk_kerja	A"
+"		,		t_insiden		B"
+"		where"
+"			B.status_reset	= 1"
+"		and	A.tanggal		>= B.tanggal"
+"		and	A.tanggal		<= "+ tanggal_lalu
+"	) Y,"
+"	(	select	tanggal"
+"		from	t_insiden"
+"		where	status_reset = 1"
+"	) Z"
+" end else begin"
+"	select	W.kum_hari_kerja"
+"	,		W.kum_hari_absen"
+"	,		X.kum_jk_bulan_skrg"
+"	,		Y.kum_jk_bulan_lalu"
+"	,		'-' as tanggal"
+"	from"
+"	(	select	isnull(sum(A.jml_hari_kerja),0) as kum_hari_kerja"
+"		,		isnull(sum(A.jml_hari_absen),0) as kum_hari_absen"
+"		from	t_unjuk_kerja	A"
+"	) W,"
+"	("
+"		select	isnull(sum(A.jml_jam_kerja),0)  as kum_jk_bulan_skrg"
+"		from	t_unjuk_kerja	A"
+"		where	A.tanggal		< "+ tanggal_skrg
+"	) X,"
+"	(	select	isnull(sum(A.jml_jam_kerja),0) as kum_jk_bulan_lalu"
+"		from	t_unjuk_kerja	A"
+"		where	A.tanggal		< "+ tanggal_lalu
+"	) Y"
+" end";

	ResultSet rs = db_stmt.executeQuery(q);

	int i = 0;
	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		
		data	+="{"  
			+ "   kum_hari_kerja	:'"+ rs.getString("kum_hari_kerja")
			+ "', kum_hari_absen	:'"+ rs.getString("kum_hari_absen")
			+ "', kum_jk_bulan_lalu	:'"+ rs.getString("kum_jk_bulan_lalu")
			+ "', kum_jk_bulan_skrg	:'"+ rs.getString("kum_jk_bulan_skrg")
			+ "', kum_tanggal	:'"+ rs.getString("tanggal")
			+ "'}";
	}
	data += "]}";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
