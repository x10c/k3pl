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

	Statement	stmt2		= db_con.createStatement();
	Statement	stmt3		= db_con.createStatement();
	ResultSet	rs2			= null;
	ResultSet	rs3			= null;
	String		id_kel		= "";
	String		id_tipe		= "";
	JSONObject	obs_group	= null;
	JSONArray	obs_types	= null;
	JSONArray	obs_details	= null;
	JSONObject	obs_type	= null;
	JSONObject	obs_detail	= null;

	db_stmt = db_con.createStatement();

	db_q= " select   id_kel_tipe_observasi "
		+ " ,        nama_kel_tipe_observasi "
		+ " from     r_kelompok_tipe_observasi "
		+ " order by id_kel_tipe_observasi ";

	db_rs = db_stmt.executeQuery (db_q);

	json_a = new JSONArray ();
	while (db_rs.next()) {
		id_kel = db_rs.getString("id_kel_tipe_observasi");

		db_q=" select	id_tipe_observasi "
			+" ,		nama_tipe_observasi "
			+" from		r_tipe_observasi "
			+" where	id_kel_tipe_observasi = "+ id_kel;

		rs2 = stmt2.executeQuery (db_q);

		obs_types = new JSONArray ();
		while (rs2.next()) {
			id_tipe = rs2.getString("id_tipe_observasi");

			db_q=" select	id_detail_tipe_observasi "
				+" ,		nama_detail_tipe_observasi "
				+" from		r_detail_tipe_observasi "
				+" where	id_kel_tipe_observasi	= "+ id_kel
				+" and		id_tipe_observasi	= "+ id_tipe;

			rs3 = stmt3.executeQuery (db_q);

			obs_details = new JSONArray ();
			while (rs3.next()) {
				obs_detail = new JSONObject ();
				obs_detail.put ("kel_id", id_kel);
				obs_detail.put ("tipe_id", id_tipe);
				obs_detail.put ("detail_id", rs3.getString ("id_detail_tipe_observasi"));
				obs_detail.put ("detail_name", rs3.getString ("nama_detail_tipe_observasi"));
				obs_detail.put ("safe", 0);
				obs_detail.put ("unsafe", 0);

				obs_details.put (obs_detail);
			}

			obs_type = new JSONObject ();
			obs_type.put ("id", id_tipe);
			obs_type.put ("text", rs2.getString ("nama_tipe_observasi"));
			obs_type.put ("details", obs_details);

			obs_types.put (obs_type);

			rs3.close();
		}

		obs_group	= new JSONObject ();
		obs_group.put ("id", id_kel);
		obs_group.put ("text", db_rs.getString("nama_kel_tipe_observasi"));
		obs_group.put ("tipe", obs_types);

		json_a.put (obs_group);

		rs2.close();
	}

	out.print (json_a);

	db_rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
