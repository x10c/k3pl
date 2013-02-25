<%--
 % Copyright 2013 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
	- mhd.sulhan (ms@kilabit.org)
--%>

<%@ include file="../modinit.jsp"%>
<%
try {
	String		id_seksi	= request.getParameter("id_seksi");
	JSONArray	data		= null;

	db_stmt = db_con.createStatement();
	db_q	=" select	nipg "
			+" ,		nama_pegawai "
			+" ,		id_seksi "
			+" from		r_pegawai "
			+" where	id_seksi 		= " + id_seksi
			+" and		status_pegawai	= '1' "
			+" and		nipg in	( "
			+"						select 	nipg "
			+"						from	__user_grup "
			+"						where	id_grup	= 5 "
			+"					) "
			+" order by	nama_pegawai ";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		data = new JSONArray ();
		data.put (db_rs.getString("nipg"));
		data.put (db_rs.getString("nama_pegawai"));
		data.put (db_rs.getString("id_seksi"));

		json_a.put (data);
	}

	db_rs.close();
	db_stmt.close ();

	out.print (json_a);

} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
