<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray data = null;

	db_stmt = db_con.createStatement ();
	db_q	=" select   id"
			+" ,		elemen"
			+" ,        nilai"
			+" from     r_csm_penilaian2";
	db_rs	= db_stmt.executeQuery (db_q);

	json_a	= new JSONArray ();
	while (db_rs.next()) {
		data = new JSONArray ();
		data.put (db_rs.getString ("id"));
		data.put (db_rs.getString ("elemen"));
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
