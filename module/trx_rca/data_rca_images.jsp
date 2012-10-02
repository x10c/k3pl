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
	String	ctx_path	= request.getContextPath ();
	String	repo_rca	= "/repository/rca/";
	String	id_rca		= request.getParameter ("id_rca");

	db_q	=" select	image_name"
			+" ,		'"+ ctx_path + repo_rca +"/"+ id_rca +"/'+image_name as url"
			+" from		t_rca_images"
			+" where	id_rca = "+ id_rca;

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	
	while (db_rs.next ()) {
		json_o = new JSONObject ();
		json_o.put ("id_rca", id_rca);
		json_o.put ("name", db_rs.getString ("image_name"));
		json_o.put ("url", db_rs.getString ("url"));

		json_a.put (json_o);
	}

	_return.put ("success", true);
	_return.put ("data", json_a);

	db_rs.close ();
	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
