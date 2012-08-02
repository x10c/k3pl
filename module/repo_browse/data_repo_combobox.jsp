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
	JSONArray repo = new JSONArray ();

	db_stmt = db_con.createStatement();

	db_q=" select	id, name, dbo.fn_repo_get_path(pid, name) as path"
		+" from		t_repo"
		+" where	pid		= 3"
		+" and		type	= 1";

	db_rs = db_stmt.executeQuery (db_q);

	json_a = new JSONArray ();
	while (db_rs.next()) {
		repo = new JSONArray ();
		repo.put (db_rs.getInt ("id"));
		repo.put (db_rs.getString ("name").replace("'","\\'"));
		repo.put (db_rs.getString ("path"));

		json_a.put (repo);
	}

	out.print (json_a);

	db_rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
