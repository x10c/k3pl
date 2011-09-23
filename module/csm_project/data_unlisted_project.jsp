<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

q
="	select	id_project"
+"	,		nama_project"
+"	from	r_project"
+"	where	id_project not in ("
+"		select	id_project"
+"		from	t_csm_proyek"
+"	)";

	ResultSet	rs		= db_stmt.executeQuery (q);
	JSONArray	data	= new JSONArray ();
	JSONArray	item	= null;

	while (rs.next()) {
		item = new JSONArray ();
		item.put (rs.getString ("id_project"));
		item.put (rs.getString ("nama_project"));

		data.put (item);
	}

	out.print (data.toString ());

	rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
