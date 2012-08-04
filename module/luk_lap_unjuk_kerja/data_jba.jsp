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
String	q_unit	= "";
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

	Statement	db_stmt		= db_con.createStatement ();
	Statement	stmt_jba	= db_con.createStatement ();

	String		id_dir		= request.getParameter ("id_dir");
	String		year		= request.getParameter ("year");

	JSONArray	data_jba	= new JSONArray ();
	JSONObject	o			= null;
	ResultSet	rs_unit		= null;
	ResultSet	rs_jba		= null;
	int			unit_id		= 0;
	String		unit_name	= "";
	int			i			= 0;

	if (id_dir != null && !id_dir.equals ("0")) {
		q_unit	=" select	id_divprosbu	as id"
				+" ,		nama_divprosbu	as name"
				+" from		r_divprosbu"
				+" where	id_direktorat = "+ id_dir;
	} else {
		q_unit	=" select	id_direktorat	as id"
				+" ,		nama_direktorat	as name"
				+" from		r_direktorat";
	}

	rs_unit = db_stmt.executeQuery (q_unit);

	/* loop for all direktorat */
	while (rs_unit.next ()) {
		o			= new JSONObject ();
		unit_id		= rs_unit.getInt ("id");
		unit_name	= rs_unit.getString ("name");

		o.put ("id", unit_id);
		o.put ("name", unit_name);

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
					+" and		bulan			= "+ i;

			if (id_dir != null && !id_dir.equals ("0")) {
				q_jba +=" and id_divprosbu = "+ unit_id;
			} else {
				q_jba +=" and id_direktorat	= "+ unit_id;
			}

			q_jba += ") M"+ i;

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
		unit_id++;
		switch (x) {
		case 0:
			unit_name = "Kontrak";
			break;
		case 1:
			unit_name = "Kumulatif Bulan";
			break;
		case 2:
			unit_name = "Kumulatif Tahun";
			break;
		}

		o = new JSONObject ();
		o.put ("id", unit_id);
		o.put ("name", unit_name);

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

	rs_unit.close ();
	stmt_jba.close ();
	db_stmt.close ();

	out.print(data_jba);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
