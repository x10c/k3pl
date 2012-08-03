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
	db_stmt	= db_con.createStatement ();
	db_q	=" select	repo_max_file_size"
			+" from		r_k3pl";
	db_rs	= db_stmt.executeQuery (db_q);
	json_o	= new JSONObject ();

	if (db_rs.next ()) {
		json_o.put ("repo_max_file_size", db_rs.getInt ("repo_max_file_size"));
	} else {
		json_o.put ("repo_max_file_size", 0);
	}

	_return.put ("success", true);
	_return.put ("data", json_o);

	db_rs.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
