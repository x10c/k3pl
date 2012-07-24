<%--
% Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
%
% Author(s):
% + PT. Awakami
%   - mhd.sulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String	q_dir	= "";
String	q_jba	= "";
String	jba_months
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
	Connection db_con = (Connection) session.getAttribute("db.con");
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

	Statement	db_stmt		= db_con.createStatement ();
	Statement	stmt_jba	= db_con.createStatement ();
	String		year		= (String) request.getParameter ("year");
	String		month_start	= (String) request.getParameter ("month_start");
	String		month_end	= (String) request.getParameter ("month_end");
	int			start, end;

	if (month_end == null) {
		end = 12;
	} else {
		end = Integer.parseInt(month_end);
		end--;
	}
	if (month_start == null) {
		start = 0;
	} else {
		start = Integer.parseInt(month_start);
		start--;
	}
	JSONArray	jba			= new JSONArray (jba_months);
	JSONArray	data_jba	= new JSONArray ();
	JSONObject	jba_month	= null;
	JSONObject	o			= null;
	ResultSet	rs_dir		= null;
	ResultSet	rs_jba		= null;
	String		month		= "";
	int			dir_id		= 0;
	String		dir_name	= "";
	int			i			= 0;

	q_dir	=" select	id_direktorat"
			+" ,		nama_direktorat"
			+" from		r_direktorat";

	rs_dir	= db_stmt.executeQuery (q_dir);

	/* loop for all direktorat */
	while (rs_dir.next ()) {
		o			= new JSONObject ();
		dir_id		= rs_dir.getInt ("id_direktorat");
		dir_name	= rs_dir.getString ("nama_direktorat");

		o.put ("dir_id", dir_id);
		o.put ("dir_name", dir_name);

		q_jba		=" select	M1.jba as jan"
					+" ,		M2.jba as feb"
					+" ,		M3.jba as mar"
					+" ,		M4.jba as apr"
					+" ,		M5.jba as may"
					+" ,		M6.jba as jun"
					+" ,		M7.jba as jul"
					+" ,		M8.jba as aug"
					+" ,		M9.jba as sep"
					+" ,		M10.jba as oct"
					+" ,		M11.jba as nov"
					+" ,		M12.jba as dec"
					+" from ";

		/* loop for all months */
		for (i = 1; i <= 12; i++) {
			q_jba	+=
					"( select	isnull (sum (jml_jarak_tempuh_aman), 0)	as jba"
					+" from		t_unjuk_kerja"
					+" where	tahun			= "+ year
					+" and		bulan			= "+ i
					+" and		id_direktorat	= "+ dir_id
					+") M"+ i;

			if (i < 12) {
				q_jba += ",";
			}
		}

		rs_jba = stmt_jba.executeQuery (q_jba);

		while (rs_jba.next ()) {
			o.put ("jan", rs_jba.getString ("jan"));
			o.put ("feb", rs_jba.getString ("feb"));
			o.put ("mar", rs_jba.getString ("mar"));
			o.put ("apr", rs_jba.getString ("apr"));
			o.put ("may", rs_jba.getString ("may"));
			o.put ("jun", rs_jba.getString ("jun"));
			o.put ("jul", rs_jba.getString ("jul"));
			o.put ("aug", rs_jba.getString ("aug"));
			o.put ("sep", rs_jba.getString ("sep"));
			o.put ("oct", rs_jba.getString ("oct"));
			o.put ("nov", rs_jba.getString ("nov"));
			o.put ("dec", rs_jba.getString ("dec"));
		}

		data_jba.put(o);

		rs_jba.close ();
	}

	/* get JBA for Kontrak, Kumulatif Bulan, and Kumulatif Tahun */
	for (int x = 0; x < 3; x++) {
		dir_id++;
		switch (x) {
		case 0:
			dir_name = "Kontrak";
			break;
		case 1:
			dir_name = "Kumulatif Bulan";
			break;
		case 2:
			dir_name = "Kumulatif Tahun";
			break;
		}

		o = new JSONObject ();
		o.put ("dir_id", dir_id);
		o.put ("dir_name", dir_name);

		q_jba		=" select	M1.jba as jan"
					+" ,		M2.jba as feb"
					+" ,		M3.jba as mar"
					+" ,		M4.jba as apr"
					+" ,		M5.jba as may"
					+" ,		M6.jba as jun"
					+" ,		M7.jba as jul"
					+" ,		M8.jba as aug"
					+" ,		M9.jba as sep"
					+" ,		M10.jba as oct"
					+" ,		M11.jba as nov"
					+" ,		M12.jba as dec"
					+" from ";

		/* loop for all months */
		for (i = 1; i <= 12; i++) {
			q_jba	+=
					"( select	isnull (sum (jml_jarak_tempuh_aman), 0)	as jba"
					+" from		t_unjuk_kerja";
			switch (x) {
			case 0:
				q_jba	+=" where	tahun					= "+ year
						+" and		bulan					= "+ i
						+" and		id_klasifikasi_pegawai	= 3";
				break;
			case 1:
				q_jba	+=" where	tahun					= "+ year
						+" and		bulan					= "+ i;
				break;
			case 2:
				q_jba	+=" where	tahun					= "+ year
						+" and		bulan					<= "+ i;
				break;
			}

			q_jba +=") M"+ i;

			if (i < 12) {
				q_jba += ",";
			}
		}

		rs_jba = stmt_jba.executeQuery (q_jba);

		while (rs_jba.next ()) {
			o.put ("jan", rs_jba.getString ("jan"));
			o.put ("feb", rs_jba.getString ("feb"));
			o.put ("mar", rs_jba.getString ("mar"));
			o.put ("apr", rs_jba.getString ("apr"));
			o.put ("may", rs_jba.getString ("may"));
			o.put ("jun", rs_jba.getString ("jun"));
			o.put ("jul", rs_jba.getString ("jul"));
			o.put ("aug", rs_jba.getString ("aug"));
			o.put ("sep", rs_jba.getString ("sep"));
			o.put ("oct", rs_jba.getString ("oct"));
			o.put ("nov", rs_jba.getString ("nov"));
			o.put ("dec", rs_jba.getString ("dec"));
		}

		data_jba.put (o);
		rs_jba.close ();
	}

	rs_dir.close ();
	stmt_jba.close ();
	db_stmt.close ();

	out.print(data_jba);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
