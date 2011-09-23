<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%
String q = "";
String q_detail = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	Statement	db_stmt2		= db_con.createStatement();
	ResultSet	rs				= null;
	ResultSet	rs2				= null;
	String		id_proyek		= request.getParameter("id_proyek");
	String		id_kontraktor	= request.getParameter("id_kontraktor");
	String		id_faktor		= request.getParameter("id_faktor");
	String		nilai;
	String		id_penilaian;

	JSONObject	data	= new JSONObject ();
	JSONArray	faktors	= new JSONArray ();
	JSONObject	faktor	= null;
	JSONArray	satuan	= null;
	JSONObject	item	= null;

q
=" select	A.id"
+" ,		A.keterangan as faktor"
+" ,		isnull(B.nilai, 0) as nilai"
+" ,		isnull(B.keterangan, '') as nilai_keterangan"
+" from"
+" ("
+" 	select	id"
+" 	,		keterangan"
+" 	from	r_csm_penilaian"
+" 	where	id_faktor ="+ id_faktor
+" ) A"
+" left join"
+" ("
+" 	select	id_penilaian"
+" 	,		nilai"
+" 	,		keterangan"
+" 	from	t_csm_proyek_kont_nilai"
+" 	where	id_project		="+ id_proyek
+" 	and		id_kontraktor	="+ id_kontraktor
+" ) B"
+" on A.id = B.id_penilaian";

	rs = db_stmt.executeQuery (q);

	while (rs.next()) {
		faktor = new JSONObject();

		id_penilaian	= rs.getString("id");

		faktor.put("id", id_penilaian);
		faktor.put("faktor", rs.getString("faktor"));

		q_detail	= " select	nilai"
					+ " ,		keterangan"
					+ " from	r_csm_penilaian_detail"
					+ " where	id_penilaian = "+ id_penilaian;

		rs2		= db_stmt2.executeQuery(q_detail);
		satuan	= new JSONArray();

		while (rs2.next()) {
			item	= new JSONObject();
			nilai	= rs2.getString("nilai");
			item.put("nilai", nilai);
			item.put("mark", "("+ nilai +") "+ rs2.getString("keterangan"));
			satuan.put(item);
		}

		rs2.close();

		faktor.put("satuan", satuan);
		faktor.put("hasil_pantauan", rs.getString("nilai"));
		faktor.put("keterangan", rs.getString("nilai_keterangan"));

		faktors.put(faktor);
	}

	data.put ("faktors", faktors);

	out.print (data.toString());

	rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
