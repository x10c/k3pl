<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>
<%@ include file="../modinit.jsp"%>
<%
try {
	JSONArray	data		= null;
	String		load_type	= (String) request.getParameter("load_type");

	db_stmt = db_con.createStatement();
	db_q=" select	a.id_rca "
		+" ,		a.tanggal_rca as tanggal_rca "
		+" ,		a.auditor_seksi as id_seksi "
		+" ,		( select c.nama_seksi from r_seksi as c where a.auditor_seksi = c.id_seksi ) as auditor_seksi "
		+" ,		( "
		+"				select	nama "
		+"				from 	( "
		+"							select	e.nama_pegawai						as nama "
		+"								, 	row_number() over(order by d.nipg) 	as rownum "
		+"							from 	t_rca_auditor 	as d "
		+"								, 	r_pegawai 		as e "
		+"							where 	d.nipg 		= e.nipg "
		+"							and 	d.id_rca	= a.id_rca "
		+"						) as hasil "
		+"				where rownum between 1 and 1 "
		+"			) as nama_auditor "
		+" ,		( select f.nama_seksi from r_seksi as f where a.penanggung_jawab_seksi = f.id_seksi ) as penanggung_jawab_seksi "
		+" ,		a.penanggung_jawab_nipg as pic "
		+" ,		( select g.nama_pegawai from r_pegawai as g where a.penanggung_jawab_nipg = g.nipg) as nama_pic "
		+" ,		'" + user_nipg + "' as user_login "
		+" ,		a.id_user	as id_user "
		+" from		t_rca	as a "
		+" where	(a.penanggung_jawab_nipg = '"+ user_nipg +"'"
		+" or		'"+ user_nipg +"' in (select b.nipg from t_rca_auditor b where b.id_rca = a.id_rca))";

		if (load_type.equals("all")) {
			db_q+=" or		'"+ user_nipg +"' in (select c.nipg from __user_grup as c where c.id_grup = 1)"
				+" and	a.auditor_divprosbu		= "+ user_div
				+" and	a.auditor_direktorat	= "+ user_dir;
		}

		db_q+=" order by	a.tanggal_rca desc ";

	db_rs		= db_stmt.executeQuery (db_q);
	json_a		= new JSONArray ();
	while (db_rs.next()) {
		data = new JSONArray ();
		data.put (db_rs.getString("id_rca"));
		data.put (db_rs.getString("tanggal_rca"));
		data.put (db_rs.getString("id_seksi"));
		data.put (db_rs.getString("auditor_seksi"));
		data.put (db_rs.getString("nama_auditor"));
		data.put (db_rs.getString("penanggung_jawab_seksi"));
		data.put (db_rs.getString("pic"));
		data.put (db_rs.getString("nama_pic"));
		data.put (db_rs.getString("user_login"));
		data.put (db_rs.getString("id_user"));

		json_a.put (data);
	}

	out.print (json_a);

	db_rs.close();
	db_stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
