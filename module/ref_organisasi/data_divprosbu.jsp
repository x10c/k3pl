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
	String		id_direktorat	= request.getParameter("id_direktorat");
	JSONArray	div				= null;

	if (id_direktorat == null || id_direktorat.equals("0")) {
		id_direktorat ="0 or 1 = 1 ";
	}

	db_stmt	= db_con.createStatement();
	db_q	= " select   id_direktorat"
			+ " ,        id_divprosbu"
			+ " ,        nama_divprosbu"
			+ " ,        status_divprosbu"
			+ " from     r_divprosbu"
			+ " where    id_direktorat = "+ id_direktorat
			+ " order by id_divprosbu, id_direktorat";
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		div = new JSONArray ();
		div.put (db_rs.getString ("id_direktorat"));
		div.put (db_rs.getString ("id_divprosbu"));
		div.put (db_rs.getString ("nama_divprosbu"));
		div.put (db_rs.getString ("status_divprosbu"));

		json_a.put (div);
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
