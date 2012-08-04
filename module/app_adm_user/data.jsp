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
	JSONArray peg = null;

	db_stmt = db_con.createStatement ();
	db_q	=" select	A.nipg"
			+" ,		B.nama_pegawai"
			+" ,		A.status_user"
			+" from		__user		A"
			+" ,		r_pegawai	B"
			+" where	A.nipg 			= B.nipg";

	if (! "1".equals (user_group)) {
		db_q	+=" and id_direktorat	= "+ user_dir
				+ " and id_divprosbu	= "+ user_div;
	}

	db_q	+=" order by	B.nama_pegawai";
	db_rs	= db_stmt.executeQuery (db_q);

	json_a	= new JSONArray ();
	while (db_rs.next()) {
		peg = new JSONArray ();
		peg.put (db_rs.getString ("nipg"));
		peg.put (db_rs.getString ("nama_pegawai"));
		peg.put ("");
		peg.put (db_rs.getString ("status_user"));

		json_a.put (peg);
	}

	out.print (json_a);

	db_rs.close();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
