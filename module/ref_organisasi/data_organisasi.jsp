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
	db_q	=" select	A.nama_direktorat"
			+" ,		B.nama_divprosbu"
			+" ,		C.nama_departemen"
			+" ,		D.nama_dinas"
			+" ,		E.nama_seksi"
			+" from		r_direktorat	A"
			+" ,		r_divprosbu		B"
			+" ,		r_departemen	C"
			+" ,		r_dinas			D"
			+" ,		r_seksi			E"
			+" where	A.id_direktorat	= B.id_direktorat"
			+" and		B.id_divprosbu	= C.id_divprosbu"
			+" and		C.id_departemen	= D.id_departemen"
			+" and		D.id_dinas		= E.id_dinas"
			+" order by	A.nama_direktorat";
	db_rs	= db_stmt.executeQuery(db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		org = new JSONArray ();
		org.put (db_rs.getString ("nama_direktorat"));
		org.put (db_rs.getString ("nama_divprosbu"));
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
