<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - mhd.sulhan (sulhan@x10c-lab.com)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String		load_type	= (String) request.getParameter("load_type");
int			start		= ServletUtilities.getIntParameter (request, "start", 0);
int			limit		= ServletUtilities.getIntParameter (request, "limit", 50);
int			total		= 0;
String		db_q		= "";
Statement	db_stmt		= null;
ResultSet	db_rs		= null;
JSONObject	o			= null;
JSONArray	a			= null;
JSONObject	_return		= new JSONObject ();

try {
	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");
	Connection	db_con		= (Connection) session.getAttribute("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	// get total
	db_q	=" select	count (*)		as total"
			+" from		t_rca			as a "
			+" ,		t_rca_detail	as b "
			+" where	a.id_rca		= b.id_rca "
			+" and		(a.penanggung_jawab_nipg = '"+user_nipg+"'"
			+" or		'"+user_nipg+"' in (select c.nipg from t_rca_auditor c where c.id_rca = a.id_rca)) ";

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);

	if (db_rs.next()) {
		total = db_rs.getInt ("total");
	}

	db_rs.close ();
	db_stmt.close ();

	// get data
	db_q	=" with results as ("
			+" select	replace(convert(varchar, a.tanggal_rca, 111), '/', '-') as tanggal_rca "
			+" ,		b.description 											as description "
			+" ,		b.id_severity 											as id_severity "
			+" ,		case b.status "
			+" 				when '1' then 'Open' "
			+" 				when '2' then 'Process' "
			+" 				when '3' then 'Closed' "
			+" 			end as status "
			+" ,		ROW_NUMBER() OVER (ORDER BY a.tanggal_rca desc) as rownum"
			+" from		t_rca			as a "
			+" ,		t_rca_detail	as b "
			+" where	a.id_rca		= b.id_rca "
			+" and		(a.penanggung_jawab_nipg = '"+user_nipg+"'"
			+" or		'"+user_nipg+"' in (select c.nipg from t_rca_auditor c where c.id_rca = a.id_rca)) ";

	if (load_type.equals("all")) {
		db_q	+=" or		'"+user_nipg+"' in (select d.nipg from __user_grup as d where d.id_grup = 1) "
				+" and	a.auditor_divprosbu		= "+ user_div
				+" and	a.auditor_direktorat	= "+ user_dir;
	}

	db_q	+=" ) select * from results where rownum >= "+ start +" and rownum <= "+ (start + limit);

	db_stmt 	= db_con.createStatement ();
	db_rs		= db_stmt.executeQuery (db_q);

	a = new JSONArray ();
	while (db_rs.next()) {
		o = new JSONObject ();

		o.put ("tanggal_rca"	, db_rs.getString("tanggal_rca"));
		o.put ("description"	, db_rs.getString("description"));
		o.put ("id_severity"	, db_rs.getString("id_severity"));
		o.put ("status"			, db_rs.getString("status"));

		a.put (o);
	}

	_return.put ("success"	,true);
	_return.put ("data"		,a);
	_return.put ("total"	,total);

	db_stmt.close ();
	db_rs.close ();

} catch (Exception e) {
	_return.put ("success"	,true);
	_return.put ("info"		,e);
} finally {
	out.print (_return);
}
%>
