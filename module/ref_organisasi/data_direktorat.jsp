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
	JSONArray dir = null;

	db_stmt	= db_con.createStatement();
	db_q	= " select   id_direktorat"
			+ " ,        nama_direktorat"
			+ " from     r_direktorat"
			+ " order by id_direktorat";
	db_rs 	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		dir = new JSONArray ();
		dir.put (db_rs.getString ("id_direktorat"));
		dir.put (db_rs.getString ("nama_direktorat"));

		json_a.put (dir);
	}

	out.print (json_a);

	db_rs.close();
	db_stmt.close();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
