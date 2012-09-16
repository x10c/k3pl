<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
try {
	JSONArray	item		= null;
	String		id_proyek	= request.getParameter("id_proyek");

	db_stmt = db_con.createStatement();

	db_q=" select   id"
		+" ,        nama"
		+" from     r_kontraktor"
		+" where	id not in ("
		+"		select	id_kontraktor"
		+"		from	t_csm_proyek_kontraktor2"
		+"		where	id_project = "+ id_proyek
		+" )";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		item = new JSONArray ();
		item.put (db_rs.getString ("id"));
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
