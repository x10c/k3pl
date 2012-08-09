<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%!
public String build_query (JSONArray data, String id_proyek)
{
	String		q		= "";
	String		id		= "";
	String		nilai	= "";
	String		ket		= "";
	JSONObject	item	= null;
	int			i;
try {
	for (i = 0; i < data.length(); i++) {
		item	= data.getJSONObject(i);
		id		= item.getString("id");
		nilai	= item.getString("nilai");
		ket		= item.getString("ket");

		q
		+=" if exists ("
		+"	select	1"
		+"	from	t_csm_proyek_kont_eval_nilai"
		+"	where	id_project		= "+ id_proyek
		+"	and		id_penilaian	= "+ id
		+" ) begin"
		+"	update	t_csm_proyek_kont_eval_nilai"
		+"	set		nilai			= "+ nilai
		+"	,		keterangan		='"+ ket +"'"
		+"	where	id_project		= "+ id_proyek
		+"	and		id_penilaian	= "+ id
		+" end else begin"
		+"	insert into t_csm_proyek_kont_eval_nilai ("
		+"		id_project"
		+"	,	id_penilaian"
		+"	,	nilai"
		+"	,	keterangan"
		+"	) values ("
		+		id_proyek
		+"		,"+ id
		+"		,"+ nilai
		+"		,'"+ ket +"'"
		+"	);"
		+"end;";
	}
	return q;
} catch (Exception e) {
	return q;
}}
%>
<%
try {
	String		id_proyek		= request.getParameter ("id_proyek");
	String		tanggal			= request.getParameter ("tanggal");
	String		team			= request.getParameter ("team");
	String		work_area		= request.getParameter ("work_area");
	String		score			= request.getParameter ("score");
	JSONArray	nilai_utama		= new JSONArray(request.getParameter ("nilai_utama"));
	JSONArray	nilai_tambahan	= new JSONArray(request.getParameter ("nilai_tambahan"));
	String		q_utama			= "";
	String		q_tambahan		= "";

	db_stmt		= db_con.createStatement ();
	q_utama		= build_query (nilai_utama, id_proyek);
	q_tambahan	= build_query (nilai_tambahan, id_proyek);

	if (!q_utama.equals ("")) {
		db_stmt.executeUpdate (q_utama);
	}
	if (!q_tambahan.equals ("")) {
		db_stmt.executeUpdate (q_tambahan);
	}

	db_q=" if exists ("
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

	db_q+="; update	t_csm_proyek"
		+" set		eval_score	= "+ score
		+" where	id_project	= "+ id_proyek;

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");

	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
