<%--
% Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
%
% Author(s):
% + PT. Awakami
%   - m.shulhan (ms@kilabit.org)
%
% WARNING: This script is used by charts module.
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String tsaf_months
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
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", null);

	Statement	db_stmt		= db_con.createStatement();
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

	JSONArray	tsaf	= new JSONArray (tsaf_months);
	JSONArray	data	= new JSONArray();
	JSONObject	tsaf_month;

	ResultSet	rs;
	String		q, klas, month;
	int			i, a;

	for (i = 0; i < tsaf.length(); i++) {
		if (i < start || i > end) {
			continue;
		}

		tsaf_month	= tsaf.getJSONObject(i);
		month		= tsaf_month.getString("id");

		q
=" select"
+" 	TEK.tsaf	as teknik"
+" ,	SER.tsaf	as servis"
+" ,	KON.tsaf	as kontrak"
+" ,	KUM.tsaf	as kumulatif"
+" ,	K3PL.target_tsaf"
+" from"
+" r_k3pl K3PL,"
+" ("
+" 	select	round(((isnull(sum(jml_hari_absen),0)"
+" 	/	isnull(nullif(cast(sum(jml_hari_kerja) as float),0.00),1.00))"
+" 	/	100.00),4,1)		as tsaf"
+" 	from	t_unjuk_kerja"
+" 	where	id_klasifikasi_pegawai	= 1"
+" 	and		tahun					= "+ year
+" 	and		bulan					= "+ month;

if (user_div != null && ! (user_div.equals("0") || user_div.equals (""))) {
	q+="	and		id_divprosbu			= "+ user_div;
}

q+=" ) TEK,"
+" ("
+" 	select	round(((isnull(sum(jml_hari_absen),0)"
+" 	/	isnull(nullif(convert(float, sum(jml_hari_kerja), 2),0.00),1.00))"
+" 	/	100.00),4,1)		as tsaf"
+" 	from	t_unjuk_kerja"
+" 	where	id_klasifikasi_pegawai	= 2"
+" 	and		tahun					= "+ year
+" 	and		bulan					= "+ month;

if (user_div != null && ! (user_div.equals("0") || user_div.equals (""))) {
	q+="	and		id_divprosbu			= "+ user_div;
}

q+=" ) SER,"
+" ("
+" 	select	round(((isnull(sum(jml_hari_absen),0)"
+" 	/	isnull(nullif(convert(float, sum(jml_hari_kerja), 2),0.00),1.00))"
+" 	/	100.00),4,1)		as tsaf"
+" 	from	t_unjuk_kerja"
+" 	where	id_klasifikasi_pegawai	= 3"
+" 	and		tahun					= "+ year
+" 	and		bulan					= "+ month;

if (user_div != null && ! (user_div.equals("0") || user_div.equals (""))) {
	q+="	and		id_divprosbu			= "+ user_div;
}

q+=" ) KON,"
+" ("
+" 	select	round(((isnull(sum(jml_hari_absen),0)"
+" 	/	isnull(nullif(convert(float, sum(jml_hari_kerja), 2),0.00),1.00))"
+" 	/	100.00),4,1)		as tsaf"
+" 	from	t_unjuk_kerja"
+" 	where	tahun			= "+ year
+" 	and		bulan			= "+ month
+"	and		id_divprosbu	= "+ user_div
+" ) KUM";

		rs = db_stmt.executeQuery(q);

		if (!rs.next()) {
			rs.close();
			continue;
		}

		tsaf_month.put("teknik", rs.getDouble("teknik"));
		tsaf_month.put("servis", rs.getDouble("servis"));
		tsaf_month.put("kontrak", rs.getDouble("kontrak"));
		tsaf_month.put("kumulatif", rs.getDouble("kumulatif"));
		tsaf_month.put("target", rs.getDouble("target_tsaf"));

		data.put(tsaf_month);

		rs.close();
	}

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
