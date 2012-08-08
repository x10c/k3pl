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
	String		id_dir	= request.getParameter ("id_direktorat");
	String		id_div	= request.getParameter ("id_divprosbu");
	JSONArray	dep		= null;

	if (id_dir == null || (id_dir != null && id_dir.equals ("0"))) {
		id_dir = "0 or 1 = 1";
	}
	if (id_dir == null || id_div == null || (id_div != null && id_div.equals ("0"))) {
		id_div = "0 or 1 = 1";
	}

	db_stmt = db_con.createStatement();
	db_q	=" select   id_direktorat"
			+" ,        id_divprosbu"
			+" ,        id_departemen"
			+" ,        nama_departemen"
			+" from		r_departemen"
			+" where	(id_direktorat	= "+ id_dir +")"
			+" and		(id_divprosbu	= "+ id_div +")"
			+" order by id_departemen, id_divprosbu, id_direktorat";
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		dep	= new JSONArray ();
		dep.put (db_rs.getString ("id_direktorat"));
		dep.put (db_rs.getString ("id_divprosbu"));
		dep.put (db_rs.getString ("id_departemen"));
		dep.put (db_rs.getString ("nama_departemen"));

		json_a.put (dep);
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
