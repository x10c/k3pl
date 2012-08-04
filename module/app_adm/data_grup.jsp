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
	JSONArray group = null;

	db_stmt	= db_con.createStatement();
	db_q	=" select	id_grup"
			+" ,		nama_grup"
			+" ,		keterangan_grup"
			+" from		__grup_user";

	if (! "1".equals (user_group)) {
		db_q	+=" where id_grup != 1";
	}

	db_q	+=" order by nama_grup";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next ()) {
		group = new JSONArray ();
		group.put (db_rs.getString ("id_grup"));
		group.put (db_rs.getString ("nama_grup"));
		group.put (db_rs.getString ("keterangan_grup"));

		json_a.put (group);
	}

	out.print (json_a);

	db_rs.close();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
