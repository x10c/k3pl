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
	JSONArray	element		= null;
	String		id_faktor	= request.getParameter("id_faktor");

	db_stmt	= db_con.createStatement();
	db_q	=" select   id"
			+" ,		nilai_min"
			+" ,		nilai_max"
			+" ,        keterangan"
			+" from     r_csm_perf_eval_ps";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		element = new JSONArray ();
		element.put (db_rs.getString("id"));
		element.put (db_rs.getString("nilai_min"));
		element.put (db_rs.getString("nilai_max"));
		element.put (db_rs.getString("keterangan"));

		json_a.put (element);
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
