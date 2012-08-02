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
	int	id	= ServletUtilities.getIntParameter (request, "id", 0);
	int pid	= ServletUtilities.getIntParameter (request, "pid", 0);

	db_stmt = db_con.createStatement();

	db_q=" select	id"
		+" ,		type"
		+" ,		name"
		+" ,		owner"
		+" ,		group_owner"
		+" ,		size"
		+" ,		perm"
		+" ,		uploader"
		+" ,		replace(convert(varchar, upload_date, 120), '/', '-') upload_date"
		+" from		t_repo"
		+" where	pid		= "+ id
		+" order by type asc";

	db_rs = db_stmt.executeQuery (db_q);

	json_a = new JSONArray ();

	json_o = new JSONObject ();
	json_o.put ("id"			, pid);
	json_o.put ("type"			, 0);
	json_o.put ("name"			, "..");

	json_a.put (json_o);

	while (db_rs.next()) {
		json_o = new JSONObject ();
		json_o.put ("id"			, db_rs.getInt ("id"));
		json_o.put ("type"			, db_rs.getInt ("type"));
		json_o.put ("pid"			, id);
		json_o.put ("name"			, db_rs.getString ("name"));
		json_o.put ("owner"			, db_rs.getInt ("owner"));
		json_o.put ("group_owner"	, db_rs.getInt ("group_owner"));
		json_o.put ("size"			, db_rs.getInt ("size"));
		json_o.put ("perm"			, db_rs.getInt ("perm"));
		json_o.put ("uploader"		, db_rs.getInt ("uploader"));
		json_o.put ("update_date"	, db_rs.getString ("upload_date"));

		json_a.put (json_o);
	}

	out.print("{data:"+ json_a +"}");

	db_rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
