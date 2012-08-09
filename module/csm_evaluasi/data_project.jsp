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
	JSONArray item = null;

	db_stmt	= db_con.createStatement();
	db_q	=" select	X.id_project"
			+" ,		X.nama_project"
			+" ,		X.id_kontraktor"
			+" ,		X.nama_kontraktor"
			+" ,		X.score"
			+" ,		X.penghargaan_sanksi"
			+" ,		X.koefisien_utama"
			+" ,		X.koefisien_tambah"
			+" ,		isnull (Y.tanggal, '') as tanggal"
			+" ,		isnull (Y.team, '') as team"
			+" ,		isnull (Y.work_area, '') as work_area"
			+" from "
			+" ("
			+"		select	A.id_project"
			+" 		,		C.nama_project"
			+"		,		A.id_kontraktor"
			+"		,		B.nama as nama_kontraktor"
			+"		,		isnull(A.eval_score, 0.0) as score"
			+"		,		A.penghargaan_sanksi"
			+"		,		A.koefisien_utama"
			+"		,		A.koefisien_tambah"
			+"		from	t_csm_proyek			A"
			+"		,		r_kontraktor			B"
			+"		,		r_project				C"
			+"		,		r_csm_perf_eval_ps		D"
			+"		where	A.id_kontraktor 		= B.id"
			+"		and		A.id_project			= C.id_project"
			+"		and		A.penghargaan_sanksi	= D.id"
			+"		and		A.id_divprosbu			= "+ user_div
			+"		and		A.id_direktorat			= "+ user_dir
			+" ) X"
			+" left join "
			+" ("
			+"		select	id_project"
			+" 		,		replace(convert(varchar, tanggal, 111), '/', '-') as tanggal "
			+"		,		team"
			+"		,		work_area"
			+"		from	t_csm_proyek_kont_eval"
			+" ) Y"
			+" on X.id_project = Y.id_project";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		item = new JSONArray ();
		item.put (db_rs.getString ("id_project"));
		item.put (db_rs.getString ("nama_project"));
		item.put (db_rs.getString ("id_kontraktor"));
		item.put (db_rs.getString ("nama_kontraktor"));
		item.put (db_rs.getString ("score"));
		item.put (db_rs.getString ("penghargaan_sanksi"));
		item.put (db_rs.getString ("koefisien_utama"));
		item.put (db_rs.getString ("koefisien_tambah"));
		item.put (db_rs.getString ("tanggal"));
		item.put (db_rs.getString ("team"));
		item.put (db_rs.getString ("work_area"));

		json_a.put (item);
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
