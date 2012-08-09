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
+" ,		A.id_kontraktor"
+" ,		A.total_nilai"
+" ,		B.nama"
+" from		t_csm_proyek_kontraktor		A"
+" ,		r_kontraktor				B"
+" ,		t_csm_proyek				C"
+" where	A.id_project	= "+ id_proyek
+" and		A.id_kontraktor	= B.id"
+" and		A.id_project	= C.id_project"
+" order by B.nama";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		item = new JSONArray ();
		item.put (db_rs.getString ("id_project"));
		item.put (db_rs.getString ("id_kontraktor"));
		item.put (db_rs.getString ("total_nilai"));
		item.put (db_rs.getString ("nama"));

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
