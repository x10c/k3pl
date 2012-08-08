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
	String		id_divprosbu	= request.getParameter("id_divprosbu");
	String		id_departemen	= request.getParameter("id_departemen");
	JSONArray	dinas			= null;

	db_stmt = db_con.createStatement();

	if (id_direktorat == null || id_direktorat.equals("0")) {
		id_direktorat = "0 or 1 = 1 ";
	}

	if (id_direktorat == null || id_divprosbu == null || id_divprosbu.equals("0")) {
		id_divprosbu = "0 or 1 = 1 ";
	}

	if (id_direktorat == null || id_divprosbu == null || id_departemen == null || id_departemen.equals("0")) {
		id_departemen = "0 or 1 = 1 ";
	}

	db_q	= " select   id_direktorat"
			+ " ,        id_divprosbu"
			+ " ,        id_departemen"
			+ " ,        id_dinas"
			+ " ,        nama_dinas"
			+ " from     r_dinas"
			+ " where    (id_direktorat	= "+ id_direktorat +")"
			+ " and    	 (id_divprosbu 	= "+ id_divprosbu +")"
			+ " and    	 (id_departemen	= "+ id_departemen +")"
			+ " order by id_dinas, id_departemen, id_divprosbu, id_direktorat";

	db_rs 	= db_stmt.executeQuery (db_q);

	json_a = new JSONArray ();
	while (db_rs.next()) {
		dinas = new JSONArray ();
		dinas.put (db_rs.getString ("id_direktorat"));
		dinas.put (db_rs.getString ("id_divprosbu"));
		dinas.put (db_rs.getString ("id_departemen"));
		dinas.put (db_rs.getString ("id_dinas"));
		dinas.put (db_rs.getString ("nama_dinas"));

		json_a.put (dinas);
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
