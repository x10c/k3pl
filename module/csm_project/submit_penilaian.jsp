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
public String build_query(JSONArray data, String id_proyek
						, String id_kontraktor)
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
		+"	from	t_csm_proyek_kont_nilai"
		+"	where	id_project		= "+ id_proyek
		+"	and		id_kontraktor	= "+ id_kontraktor
		+"	and		id_penilaian	= "+ id 
		+" ) begin"
		+"	update	t_csm_proyek_kont_nilai"
		+"	set		nilai		= "+ nilai
		+"	,		keterangan	='"+ ket +"'"
		+"	where	id_project		= "+ id_proyek
		+"	and		id_kontraktor	= "+ id_kontraktor
		+"	and		id_penilaian	= "+ id +";"
		+" end else begin"
		+"	insert into t_csm_proyek_kont_nilai ("
		+"		id_project"
		+"	,	id_kontraktor"
		+"	,	id_penilaian"
		+"	,	nilai"
		+"	,	keterangan"
		+"	) values ("
		+	id_proyek
		+","+ id_kontraktor
		+","+ id
		+","+ nilai
		+",'"+ ket +"');"
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
	String		id_kontraktor	= request.getParameter("id_kontraktor");
	JSONArray	data_utama		= new JSONArray(request.getParameter("data_utama"));
	JSONArray	data_tambahan	= new JSONArray(request.getParameter("data_tambahan"));
	String		total			= request.getParameter("total");
	String		q_utama			= "";
	String		q_tambahan		= "";

	q_utama		= build_query(data_utama, id_proyek, id_kontraktor);
	q_tambahan	= build_query(data_tambahan, id_proyek, id_kontraktor);

	if (!q_utama.equals("")) {
		db_stmt.executeUpdate(q_utama);
	}
	if (!q_tambahan.equals("")) {
		db_stmt.executeUpdate(q_tambahan);
	}

	q	=" update	t_csm_proyek_kontraktor"
		+" set		total_nilai 	= "+ total
		+" where	id_project		= "+ id_proyek
		+" and		id_kontraktor	= "+ id_kontraktor;

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
