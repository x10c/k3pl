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
	JSONArray org = null;

	db_stmt	= db_con.createStatement();
	db_q	=" select	A.nama_departemen"
			+" ,		B.nama_dinas"
			+" ,		C.nama_seksi"
			+" from		r_departemen	A"
			+" ,		r_dinas			B"
			+" ,		r_seksi			C"
			+" where	A.id_departemen	= B.id_departemen"
			+" and		B.id_dinas		= C.id_dinas"
			+" order by	C.id_departemen, C.id_dinas, C.id_seksi";
	db_rs	= db_stmt.executeQuery(db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		org = new JSONArray ();
		org.put (db_rs.getString ("nama_departemen"));
		org.put (db_rs.getString ("nama_dinas"));
		org.put (db_rs.getString ("nama_seksi"));

		json_a.put (org);
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
