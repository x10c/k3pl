<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	Statement	db_stmt2		= db_con.createStatement();
	ResultSet	rs2				= null;
	String		id_proyek		= request.getParameter("id_proyek");
	String		id_faktor		= request.getParameter("id_faktor");
	String		nilai;
	String		id_penilaian;
	String		q_detail;

	JSONObject	faktor	= null;
	JSONArray	satuan	= null;
	JSONObject	item	= null;

	db_stmt	= db_con.createStatement();
	json_o	= new JSONObject ();
	json_a	= new JSONArray ();

db_q
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
+" 	from	t_csm_proyek_kont_eval_nilai"
+" 	where	id_project		="+ id_proyek
+" ) B"
+" on A.id = B.id_penilaian";

	db_rs = db_stmt.executeQuery (db_q);

	while (db_rs.next()) {
		faktor = new JSONObject();

		id_penilaian	= db_rs.getString("id");

		faktor.put("id", id_penilaian);
		faktor.put("faktor", db_rs.getString("faktor"));

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
		faktor.put("hasil_pantauan", db_rs.getString("nilai"));
		faktor.put("keterangan", db_rs.getString("nilai_keterangan"));

		json_a.put(faktor);
	}

	json_o.put ("faktors", json_a);

	out.print (json_o);

	db_rs.close ();
	db_stmt.close ();
	db_stmt2.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
