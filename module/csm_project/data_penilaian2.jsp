<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
String q_detail = "";
try {
	String		id_proyek		= request.getParameter("id_proyek");
	String		id_kontraktor	= request.getParameter("id_kontraktor");
	JSONArray	data			= null;

	db_stmt		= db_con.createStatement();

db_q
=" select	A.id"
+" ,		A.elemen"
+" ,		A.nilai_maks"
+" ,		isnull(B.nilai, 0) as nilai"
+" from"
+" ("
+" 	select	id"
+" 	,		elemen"
+"	,		nilai as nilai_maks"
+" 	from	r_csm_penilaian2"
+" ) A"
+" left join"
+" ("
+" 	select	id_penilaian"
+" 	,		nilai"
+" 	from	t_csm_proyek_kont_nilai"
+" 	where	id_project		="+ id_proyek
+" 	and		id_kontraktor	="+ id_kontraktor
+" ) B"
+" on A.id = B.id_penilaian";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		data = new JSONArray ();
		data.put (id_proyek);
		data.put (id_kontraktor);
		data.put (db_rs.getString ("id"));
		data.put (db_rs.getString ("elemen"));
		data.put (db_rs.getString ("nilai_maks"));
		data.put (db_rs.getString ("nilai"));

		json_a.put (data);
	}

	out.print (json_a);

	db_rs.close ();
	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
