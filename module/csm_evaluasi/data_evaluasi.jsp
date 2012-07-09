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
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.kilabit.ServletUtilities" %>
<%@ page import="java.text.DecimalFormat"%>
<%
String q = "";
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

	Statement	db_stmt 	= db_con.createStatement();
	ResultSet	rs			= null;
	String		id_proyek	= request.getParameter("id_proyek");
	JSONObject	data		= new JSONObject();
	JSONObject	item		= null;
	JSONArray	elements	= new JSONArray();
	DecimalFormat df		= new DecimalFormat("#.##");
	double		wf			= 0.0;
	double		ws			= 0.0;
	int			nilai		= 0;

q
=" select	X.id_project"
+" ,		X.nama_project"
+" ,		X.id_kontraktor"
+" ,		X.nama as nama_kontraktor"
+" ,		replace(convert(varchar, Y.tanggal, 111),'/','-') as tanggal"
+" ,		isnull(Y.team, '')		as team"
+" ,		isnull(Y.work_area, '')	as work_area"
+" from"
+" ("
+" 	select	A.id_project"
+" 	,		C.nama_project"
+" 	,		A.id_kontraktor"
+" 	,		B.nama"
+" 	from	t_csm_proyek	A"
+" 	,		r_kontraktor	B"
+"	,		r_project		C"
+" 	where	A.id_project	= "+ id_proyek
+" 	and		A.id_kontraktor = B.id"
+"	and		A.id_project	= C.id_project"
+" ) X"
+" left join"
+" ("
+" 	select	id_project"
+" 	,		tanggal"
+" 	,		team"
+" 	,		work_area"
+" 	from	t_csm_proyek_kont_eval"
+" 	where	id_project = "+ id_proyek
+" ) Y"
+" on X.id_project = Y.id_project";

	rs = db_stmt.executeQuery (q);

	if (!rs.next()) {
		out.print(data.toString());
		return;
	}

	data.put("id", rs.getString("id_project"));
	data.put("name", rs.getString("nama_project"));
	data.put("id_kontraktor", rs.getString("id_kontraktor"));
	data.put("nama_kontraktor", rs.getString("nama_kontraktor"));
	data.put("tanggal", rs.getString("tanggal"));
	data.put("team", rs.getString("team"));
	data.put("work_area", rs.getString("work_area"));

	rs.close ();

q
=" select	A.id"
+" ,		A.element"
+" ,		A.weight_factor"
+" ,		isnull(B.nilai,0) as nilai"
+" from"
+" ("
+" 	select	id"
+" 	,		element"
+" 	,		weight_factor"
+" 	from	r_csm_perf_eval"
+" ) A"
+" left join"
+" ("
+" 	select	id_evaluasi"
+" 	,		nilai"
+" 	from	t_csm_proyek_kont_eval_nilai"
+" 	where	id_project = "+ id_proyek
+" ) B"
+" on A.id = B.id_evaluasi";

	rs = db_stmt.executeQuery (q);

	while (rs.next()) {
		item	= new JSONObject();
		wf		= Double.parseDouble(rs.getString("weight_factor"));
		nilai	= Integer.parseInt(rs.getString("nilai"));
		ws		= wf * nilai;

		item.put("id", rs.getString("id"));
		item.put("element", rs.getString("element"));
		item.put("weight_factor", wf);
		item.put("nilai", nilai);
		item.put("weighted_score", df.format(ws));

		elements.put(item);
	}

	data.put("evaluasi", elements);

	out.print (data.toString ());

	rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
