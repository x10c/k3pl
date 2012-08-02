<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray area = new JSONArray ();
	db_stmt = db_con.createStatement();

	db_q	=" select	B.id_seksi"
			+" ,		(A.nama_wilayah+' - '+B.nama_seksi) as nama_area"
			+" from		r_wilayah	A"
			+" ,		r_seksi		B"
			+" where	A.id_wilayah = B.id_wilayah"
			+" order by	A.nama_wilayah, B.nama_seksi";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next()) {
		area = new JSONArray ();
		area.put (db_rs.getString ("id_seksi"));
		area.put (db_rs.getString ("nama_area"));

		json_a.put (area);
	}

	out.print (json_a);

	db_rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
