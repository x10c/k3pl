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
	JSONArray	peg		= null;
	String		nipg	= request.getParameter("nipg");

	db_stmt	= db_con.createStatement();
	db_q	=" select	nipg"
			+" ,		nama_pegawai"
			+" from		r_pegawai"
			+" where	status_pegawai = '1'"
			+" and		nipg not in (select nipg from __user)";

	if (! "1".equals (user_group)) {
		db_q	+=" and	id_direktorat	= "+ user_dir
				+ " and id_divprosbu	= "+ user_div;
	}

	db_q	+=" order by nama_pegawai";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next()) {
		peg = new JSONArray ();
		peg.put (db_rs.getString ("nipg"));
		peg.put (db_rs.getString ("nama_pegawai"));

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
