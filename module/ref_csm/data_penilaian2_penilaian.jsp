<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	String		id_elemen	= request.getParameter ("id_elemen");
	String		id_detail	= request.getParameter ("id_detail");
	String		id_detail2	= request.getParameter ("id_detail2");
	JSONArray	data		= null;

	if (id_elemen == null || id_detail == null || id_detail2 == null) {
		_return.put ("success", false);
		_return.put ("info", "ID elemen atau ID detail kosong!");
		out.print (_return);
		return;
	}

	db_stmt = db_con.createStatement ();
	db_q	=" select   id"
			+" ,		penilaian"
			+" ,		nilai"
			+" from     r_csm_penilaian2_penilaian"
			+" where	id_penilaian	= "+ id_elemen
			+" and		id_detail		= "+ id_detail
			+" and		id_detail2		= "+ id_detail2;
	db_rs	= db_stmt.executeQuery (db_q);

	json_a	= new JSONArray ();
	while (db_rs.next()) {
		data = new JSONArray ();
		data.put (db_rs.getString ("id"));
		data.put (db_rs.getString ("penilaian"));
		data.put (db_rs.getString ("nilai"));

		json_a.put (data);
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
