<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%!
public String build_query(JSONArray data, String id_proyek)
{
	String		q		= "";
	String		id		= "";
	String		nilai	= "";
	JSONObject	item	= null;
	int			i;
try {
	for (i = 0; i < data.length(); i++) {
		item	= data.getJSONObject(i);
		id		= item.getString("id");
		nilai	= item.getString("nilai");

		q
		+=" if exists ("
		+"	select	1"
		+"	from	t_csm_proyek_kont_eval_nilai"
		+"	where	id_project	= "+ id_proyek
		+"	and		id_evaluasi	= "+ id 
		+" ) begin"
		+"	update	t_csm_proyek_kont_eval_nilai"
		+"	set		nilai		= "+ nilai
		+"	where	id_project	= "+ id_proyek
		+"	and		id_evaluasi	= "+ id
		+" end else begin"
		+"	insert into t_csm_proyek_kont_eval_nilai ("
		+"		id_project"
		+"	,	id_evaluasi"
		+"	,	nilai"
		+"	) values ("
		+		id_proyek
		+"		,"+ id
		+"		,"+ nilai
		+"	);"
		+"end;";
	}

	return q;
} catch (Exception e) {
	return q;
}}
%>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	ResultSet	rs				= null;
	String		id_proyek		= request.getParameter("id_proyek");
	String		tanggal			= request.getParameter("tanggal");
	String		team			= request.getParameter("team");
	String		work_area		= request.getParameter("work_area");
	String		raw_score		= request.getParameter("raw_score");
	String		weighted_score	= request.getParameter("weighted_score");
	String		penghargaan		= request.getParameter("penghargaan");
	JSONArray	evaluasi		= new JSONArray(request.getParameter("evaluasi"));
	String		q_evaluasi		= "";

	q_evaluasi = build_query(evaluasi, id_proyek);

	if (!q_evaluasi.equals("")) {
		db_stmt.executeUpdate(q_evaluasi);
	}

	q	=" if exists ("
		+"		select	1"
		+"		from	t_csm_proyek_kont_eval"
		+"		where	id_project = "+ id_proyek
		+" ) begin"
		+"		update	t_csm_proyek_kont_eval"
		+"		set		tanggal			= cast('"+ tanggal +"' as datetime)"
		+"		,		team			= '"+ team +"'"
		+"		,		work_area		= '"+ work_area +"'"
		+"		where	id_project		= "+ id_proyek +";"
		+" end else begin"
		+"		insert into t_csm_proyek_kont_eval ("
		+"			id_project"
		+"		,	tanggal"
		+"		,	team"
		+"		,	work_area"
		+"		) values ("
		+			id_proyek
		+"		, cast('"+ tanggal +"' as datetime)"
		+"		,'"+ team +"'"
		+"		,'"+ work_area +"'"
		+"		);"
		+" end";

	q	+="; update	t_csm_proyek"
		+" set		eval_raw_score		= "+ raw_score
		+" ,		eval_weighted_score	= "+ weighted_score
		+" ,		penghargaan_sanksi	= "+ penghargaan
		+" where	id_project			= "+ id_proyek;

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
