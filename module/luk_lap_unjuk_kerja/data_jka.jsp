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
String jka_months
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

	JSONArray	jka		= new JSONArray (jka_months);
	JSONArray	data	= new JSONArray();
	JSONObject	jka_month;

	ResultSet	rs;
	String		q, klas, month;
	int			i, a;

	for (i = 0; i < jka.length(); i++) {
		if (i < start || i > end) {
			continue;
		}

		jka_month	= jka.getJSONObject(i);
		month		= jka_month.getString("id");

		q
=" select"
+"	TEK.jka	as teknik"
+" ,	SER.jka	as servis"
+" ,	KON.jka as kontrak"
+" ,	KUM.jka as kumulatif"
+" from"
+" ("
+" 	select	isnull(sum(jml_jam_kerja),0)	as jka"
+" 	from	t_unjuk_kerja"
+" 	where	id_klasifikasi_pegawai	= 1"
+" 	and		tahun					= "+ year
+" 	and		bulan					= "+ month
+"	and		id_divprosbu			= "+ user_div
+" ) TEK,"
+" ("
+" 	select	isnull(sum(jml_jam_kerja),0)	as jka"
+" 	from	t_unjuk_kerja"
+" 	where	id_klasifikasi_pegawai	= 2"
+" 	and		tahun					= "+ year
+" 	and		bulan					= "+ month
+"	and		id_divprosbu			= "+ user_div
+" ) SER,"
+" ("
+" 	select	isnull(sum(jml_jam_kerja),0)	as jka"
+" 	from	t_unjuk_kerja"
+" 	where	id_klasifikasi_pegawai	= 3"
+" 	and		tahun					= "+ year
+" 	and		bulan					= "+ month
+"	and		id_divprosbu			= "+ user_div
+" ) KON,"
+" ("
+" 	select	isnull(sum(jml_jam_kerja),0)	as jka"
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

		jka_month.put("teknik", Integer.parseInt(rs.getString("teknik")));
		jka_month.put("servis", Integer.parseInt(rs.getString("servis")));
		jka_month.put("kontrak", Integer.parseInt(rs.getString("kontrak")));
		jka_month.put("kumulatif", Integer.parseInt(rs.getString("kumulatif")));

		data.put(jka_month);

		rs.close();
	}

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
