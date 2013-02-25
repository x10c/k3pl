<%--
 % Copyright 2013 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
try {
	JSONArray data = null;

	db_stmt = db_con.createStatement();

	db_q	=" select	id_jabatan"
			+" ,		nama_jabatan"
			+" ,		pj_rca"
			+" from		r_jabatan"
			+" order by	id_jabatan";
	
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next ()){
		data	= new JSONArray ();
		data.put (db_rs.getString	("id_jabatan"));
		data.put (db_rs.getString	("nama_jabatan"));
		data.put (db_rs.getInt		("pj_rca"));

		json_a.put (data);
	}	

	db_rs.close ();
	db_stmt.close ();

	out.print (json_a);

}catch (Exception e){
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
