<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String ltif_months
="[{"
+"	id	: '1'"
+",	name: 'Jan'"
+"},{"
+"	id	: '2'"
+",	name: 'Feb'"
+"},{"
+"	id	: '3'"
+",	name: 'Mar'"
+"},{"
+"	id	: '4'"
+",	name: 'Apr'"
+"},{"
+"	id	: '5'"
+",	name: 'Mei'"
+"},{"
+"	id	: '6'"
+",	name: 'Jun'"
+"},{"
+"	id	: '7'"
+",	name: 'Jul'"
+"},{"
+"	id	: '8'"
+",	name: 'Agu'"
+"},{"
+"	id	: '9'"
+",	name: 'Sep'"
+"},{"
+"	id	: '10'"
+",	name: 'Okt'"
+"},{"
+"	id	: '11'"
+",	name: 'Nov'"
+"},{"
+"	id	: '12'"
+",	name: 'Des'"
+"}]";

try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt	= db_con.createStatement();

	String		year		= (String) request.getParameter ("year");
	String		month_start	= (String) request.getParameter ("month_start");
	String		month_end	= (String) request.getParameter ("month_end");
	int			start, end;

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

	JSONArray	ltif	= new JSONArray (ltif_months);
	JSONArray	data	= new JSONArray();
	JSONObject	ltif_month;

	ResultSet	rs;
	String		q, klas, month;
	int			i, a;

	for (i = 0; i < ltif.length(); i++) {
		if (i < start || i > end) {
			continue;
		}

		ltif_month	= ltif.getJSONObject(i);
		month		= ltif_month.getString("id");

		q
=" select"
+" 	TEK.ltif	as teknik"
+" ,	SER.ltif	as servis"
+" ,	KON.ltif	as kontrak"
+" ,	KUM.ltif	as kumulatif"
+" ,	K3PL.target_ltif"
+" from"
+" r_k3pl	K3PL,"
+" ("
+" 	select	round(((TI.lti/cast(TUK.jk as float)) * 100000),2,1) as ltif"
+" 	from"
+" 	("
+" 		select	(isnull(sum(jml_korban_mati),0)"
+" 		+		isnull(sum(jml_korban_berat),0)"
+" 		+		isnull(sum(jml_korban_sedang),0)) as lti"
+" 		from	t_insiden"
+" 		where	id_klasifikasi_pegawai	= 1"
+" 		and		tahun					= "+ year
+" 		and		bulan					= "+ month
+"		and		id_divprosbu			= "+ user_div
+" 	) TI,"
+" 	("
+" 		select	isnull(nullif(sum(jml_jam_kerja),0),1) as jk"
+" 		from	t_unjuk_kerja"
+" 		where	id_klasifikasi_pegawai	= 1"
+" 		and		tahun					= "+ year
+" 		and		bulan					= "+ month
+"		and		id_divprosbu			= "+ user_div
+" 	) TUK"
+" ) TEK,"
+" ("
+" 	select	round(((TI.lti/cast(TUK.jk as float)) * 100000),2,1) as ltif"
+" 	from"
+" 	("
+" 		select	(isnull(sum(jml_korban_mati),0)"
+" 		+		isnull(sum(jml_korban_berat),0)"
+" 		+		isnull(sum(jml_korban_sedang),0)) as lti"
+" 		from	t_insiden"
+" 		where	id_klasifikasi_pegawai	= 2"
+" 		and		tahun					= "+ year
+" 		and		bulan					= "+ month
+"		and		id_divprosbu			= "+ user_div
+" 	) TI,"
+" 	("
+" 		select	isnull(nullif(sum(jml_jam_kerja),0),1) as jk"
+" 		from	t_unjuk_kerja"
+" 		where	id_klasifikasi_pegawai	= 2"
+" 		and		tahun					= "+ year
+" 		and		bulan					= "+ month
+"		and		id_divprosbu			= "+ user_div
+" 	) TUK"
+" ) SER,"
+" ("
+" 	select	round(((TI.lti/cast(TUK.jk as float)) * 100000),2,1) ltif"
+" 	from"
+" 	("
+" 		select	(isnull(sum(jml_korban_mati),0)"
+" 		+		isnull(sum(jml_korban_berat),0)"
+" 		+		isnull(sum(jml_korban_sedang),0)) as lti"
+" 		from	t_insiden"
+" 		where	id_klasifikasi_pegawai	= 3"
+" 		and		tahun					= "+ year
+" 		and		bulan					= "+ month
+"		and		id_divprosbu			= "+ user_div
+" 	) TI,"
+" 	("
+" 		select	isnull(nullif(sum(jml_jam_kerja),0),1) as jk"
+" 		from	t_unjuk_kerja"
+" 		where	id_klasifikasi_pegawai	= 3"
+" 		and		tahun					= "+ year
+" 		and		bulan					= "+ month
+"		and		id_divprosbu			= "+ user_div
+" 	) TUK"
+" ) KON,"
+" ("
+" 	select	round(((TI.lti/cast(TUK.jk as float)) * 100000),2,1) as ltif"
+" 	from"
+" 	("
+" 		select	(isnull(sum(jml_korban_mati),0)"
+" 		+	isnull(sum(jml_korban_berat),0)"
+" 		+	isnull(sum(jml_korban_sedang),0)) as lti"
+" 		from	t_insiden"
+" 		where	tahun			= "+ year
+" 		and		bulan			= "+ month
+"		and		id_divprosbu	= "+ user_div
+" 	) TI,"
+" 	("
+" 		select	isnull(nullif(sum(jml_jam_kerja),0),1) as jk"
+" 		from	t_unjuk_kerja"
+" 		where	tahun			= "+ year
+" 		and		bulan			= "+ month
+"		and		id_divprosbu	= "+ user_div
+" 	) TUK"
+" ) KUM";

		rs = db_stmt.executeQuery(q);

		if (!rs.next()) {
			rs.close();
			continue;
		}

		ltif_month.put("teknik", rs.getDouble("teknik"));
		ltif_month.put("servis", rs.getDouble("servis"));
		ltif_month.put("kontrak", rs.getDouble("kontrak"));
		ltif_month.put("kumulatif", rs.getDouble("kumulatif"));
		ltif_month.put("target", rs.getDouble("target_ltif"));

		data.put(ltif_month);

		rs.close();
	}

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
