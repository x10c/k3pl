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
	String		id_proyek	= request.getParameter("id_proyek");
	JSONArray	item		= null;

	db_stmt	= db_con.createStatement();

db_q
=" select	A.id_project"
+" ,		D.nama_project"
+" ,		A.id_kontraktor"
+" ,		B.nama"
+" ,		A.tanggal"
+" ,		A.jenis_pekerjaan"
+" ,		A.tempat_konstruksi"
+" ,		A.total_nilai"
+" ,		A.keterangan"
+" from		t_csm_proyek_kontraktor2	A"
+" ,		r_kontraktor				B"
+" ,		t_csm_proyek				C"
+" ,		r_project					D"
+" where	A.id_project	= "+ id_proyek
+" and		A.id_kontraktor	= B.id"
+" and		A.id_project	= C.id_project"
+" and		C.id_project	= D.id_project"
+" order by A.id_kontraktor";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		item = new JSONArray ();
		item.put (db_rs.getString ("id_project"));
		item.put (db_rs.getString ("nama_project"));
		item.put (db_rs.getString ("id_kontraktor"));
		item.put (db_rs.getString ("nama"));
		item.put (db_rs.getString ("tanggal"));
		item.put (db_rs.getString ("jenis_pekerjaan"));
		item.put (db_rs.getString ("tempat_konstruksi"));
		item.put (db_rs.getString ("total_nilai"));
		item.put (db_rs.getString ("keterangan"));

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
