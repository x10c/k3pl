<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - agus sugianto (agus.delonge@gmail.com)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray	item	= null;

	db_stmt = db_con.createStatement();

db_q
=" select	X.id_project"
+" ,		X.nama_project"
+" ,		X.id_kontraktor"
+" ,		isnull(Y.nama,'-') as nama_kontraktor"
+" ,		X.koefisien_utama"
+" ,		X.koefisien_tambah"
+" from"
+" ("
+"		select	A.id_project"
+"		,		B.nama_project"
+"		,		isnull(A.id_kontraktor, '0') as id_kontraktor"
+"		,		A.koefisien_utama"
+"		,		A.koefisien_tambah"
+"		from	t_csm_proyek				A"
+"		,		r_project					B"
+"		where	A.id_project	= B.id_project"
+"		and		A.id_divprosbu	= " + user_div
+"		and		A.id_direktorat	= " + user_dir
+" ) X"
+" left join"
+" ("
+"		select	id"
+"		,		nama"
+"		from	r_kontraktor"
+" ) Y"
+" on	X.id_kontraktor = Y.id";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next()) {
		item = new JSONArray ();
		item.put (db_rs.getString ("id_project"));
		item.put (db_rs.getString ("nama_project"));
		item.put (db_rs.getString ("id_kontraktor"));
		item.put (db_rs.getString ("nama_kontraktor"));
		item.put (db_rs.getString ("koefisien_utama"));
		item.put (db_rs.getString ("koefisien_tambah"));

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
