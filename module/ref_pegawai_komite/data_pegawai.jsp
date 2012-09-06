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
	String id_direktorat	= request.getParameter("id_direktorat");
	String id_divprosbu		= request.getParameter("id_divprosbu");
	String id_departemen	= request.getParameter("id_departemen");
	String id_dinas	= request.getParameter("id_dinas");
	String id_seksi	= request.getParameter("id_seksi");
	String where_clause = "";
	
	db_stmt = db_con.createStatement();

	if (! "1".equals (user_group)) {
		if (!id_direktorat.equals(user_dir) || !id_divprosbu.equals(user_div)){
			id_departemen = null;
			id_dinas = null;
			id_seksi = null;
		}
		id_direktorat 	= user_dir;
		id_divprosbu 	= user_div;
	}
	
	if (id_direktorat != null && (!id_direktorat.equals("0") && !id_direktorat.equals("null"))){
		where_clause += " and A.id_direktorat = "+ id_direktorat;
	}
	if (id_divprosbu != null && (!id_divprosbu.equals("0") && !id_divprosbu.equals("null"))){
		where_clause += " and A.id_divprosbu = "+ id_divprosbu;
	}
	if (id_departemen != null && (!id_departemen.equals("0") && !id_departemen.equals("null"))){
		where_clause += " and A.id_departemen = "+ id_departemen;
	}
	if (id_dinas != null && (!id_dinas.equals("0") && !id_dinas.equals("null"))){
		where_clause += " and A.id_dinas = "+ id_dinas;
	}
	if (id_seksi != null && (!id_seksi.equals("0") && !id_seksi.equals("null"))){
		where_clause += " and A.id_seksi = "+ id_seksi;
	}
	
	db_q=" select	A.nipg "
		+" ,		B.nama_klasifikasi_pegawai "
		+" ,		C.nama_jabatan "
		+" ,		isnull(D.nama_departemen, '') nama_departemen "
		+" ,		isnull(E.nama_dinas, '') nama_dinas "
		+" ,		isnull(F.nama_seksi, '') nama_seksi "
		+" ,		A.nama_pegawai "
		+" ,		A.email "
		+" ,		A.status_pegawai "
		+" from		r_pegawai		A "
		+" left join "
		+" 		r_klasifikasi_pegawai	B  on B.id_klasifikasi_pegawai = A.id_klasifikasi_pegawai "
		+" left join "
		+" 		r_jabatan C on C.id_jabatan = A.id_jabatan "
		+" left join "
		+" 		r_departemen D on D.id_Departemen = A.id_departemen "
		+" left join "
		+" 		r_dinas E on E.id_dinas = A.id_dinas "
		+" left join "
		+" 		r_seksi F on F.id_seksi = A.id_seksi "
		+" where A.status_pegawai = '1' "+ where_clause
		+" order by	A.nipg";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next()) {
		json_o = new JSONObject ();
		json_o.put ("nipg",  db_rs.getString ("nipg"));
		json_o.put ("nama_klasifikasi_pegawai", db_rs.getString ("nama_klasifikasi_pegawai"));
		json_o.put ("nama_jabatan", db_rs.getString ("nama_jabatan"));
		json_o.put ("nama_departemen", db_rs.getString ("nama_departemen"));
		json_o.put ("nama_dinas", db_rs.getString ("nama_dinas"));
		json_o.put ("nama_seksi", db_rs.getString ("nama_seksi"));
		json_o.put ("nama_pegawai", db_rs.getString ("nama_pegawai"));
		json_o.put ("email", db_rs.getString ("email"));
		json_o.put ("status_pegawai", db_rs.getString ("status_pegawai"));

		json_a.put (json_o);
	}

	_return.put ("success", true);
	_return.put ("rows", json_a);
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
