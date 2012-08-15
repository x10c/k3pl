<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray wilayah = null;

	db_stmt	= db_con.createStatement();
	db_q	=" select   id_wilayah"
			+" ,        nama_wilayah"
			+" from     r_wilayah"
			+" order by nama_wilayah";
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		wilayah = new JSONArray ();
		wilayah.put (db_rs.getString ("id_wilayah"));
		wilayah.put (db_rs.getString ("nama_wilayah"));

		json_a.put (wilayah);
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
