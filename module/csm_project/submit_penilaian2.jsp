<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp"%>
<%
try {
	String		id_proyek			= request.getParameter ("id_proyek");
	String		id_kontraktor		= request.getParameter ("id_kontraktor");
	String		tanggal				= request.getParameter ("tanggal");
	String		jenis_pekerjaan		= request.getParameter ("jenis_pekerjaan");
	String		tempat_konstruksi	= request.getParameter ("tempat_konstruksi");
	String		total_nilai			= request.getParameter ("total_nilai");
	String		keterangan			= request.getParameter ("keterangan");
	json_a							= new JSONArray(request.getParameter("data_utama"));

	db_stmt			= db_con.createStatement();

	db_q=" update	t_csm_proyek_kontraktor2"
		+" set		tanggal				='"+ tanggal +"'"
		+" ,		jenis_pekerjaan		='"+ jenis_pekerjaan +"'"
		+" ,		tempat_konstruksi	='"+ tempat_konstruksi +"'"
		+" ,		total_nilai			= "+ total_nilai
		+" ,		keterangan			='"+ keterangan +"'"
		+" where	id_project			= "+ id_proyek
		+" and		id_kontraktor		= "+ id_kontraktor;

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate (db_q);

	/* delete all existing data-penilaian */
	db_q	=" delete	t_csm_proyek_kont_nilai"
			+" where	id_project		= "+ id_proyek
			+" and		id_kontraktor	= "+ id_kontraktor;

	db_stmt.executeUpdate (db_q);

	/* insert new data-penilaian */
	db_q	=" insert into t_csm_proyek_kont_nilai ("
			+"		id_project"
			+" ,	id_kontraktor"
			+" ,	id_penilaian"
			+" ,	nilai"
			+" )";

	int l = json_a.length ();
	for (int i = 0; i < l; i++) {
		json_o = json_a.getJSONObject (i);

		db_q	+=" select "+ id_proyek
				+ " , "+ id_kontraktor
				+ " , "+ json_o.getString ("id")
				+ " , "+ json_o.getString ("nilai");

		if (i < (l - 1)) {
			db_q += " union all ";
		}
	}

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");

	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
