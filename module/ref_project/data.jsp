<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya (prasetya.yanuar@gmail.com)
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try{
	JSONArray project = null;

	db_stmt = db_con.createStatement();

	db_q=" select	id_project"
		+" ,		no_project"
		+" ,		nama_project"
		+" ,		replace(convert(varchar, tanggal_mulai, 111), '/', '-') as tanggal_mulai "
		+" ,		durasi"
		+" ,		keterangan"
		+" ,(select count(id_project) from t_pha as b where  r_project.id_project = b.id_project) as pha "
		+" ,(select count(id_project) from t_pssr as c where  r_project.id_project = c.id_project) as pssr "
		+" ,(select count(id_project) from t_csm_proyek as d where  r_project.id_project = d.id_project) as csm "
		+" from		r_project"
		+" where	id_divprosbu	= " + user_div
		+" and		id_direktorat	= " + user_dir
		+" order by	id_project";
	
	db_rs = db_stmt.executeQuery (db_q);

	json_a = new JSONArray ();
	while (db_rs.next()) {
		project = new JSONArray ();

		project.put (db_rs.getString ("id_project"));
		project.put (db_rs.getString ("no_project"));
		project.put (db_rs.getString ("nama_project"));
		project.put (db_rs.getString ("tanggal_mulai"));
		project.put (db_rs.getString ("durasi"));
		project.put (db_rs.getString ("keterangan"));
		project.put (db_rs.getString ("pha"));
		project.put (db_rs.getString ("pssr"));
		project.put (db_rs.getString ("csm"));

		json_a.put (project);
	}	
	
	out.print (json_a);
}catch (Exception e){
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
