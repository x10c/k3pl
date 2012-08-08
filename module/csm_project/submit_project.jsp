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

	int		dml 	= Integer.parseInt(request.getParameter("dml"));
	String	id		= request.getParameter("id");
	String	work_lvl= request.getParameter("work_level");
	String	k_utama	= request.getParameter("koefisien_utama");
	String	k_tambah= request.getParameter("koefisien_tambah");

	db_stmt = db_con.createStatement();

	/* set default work level to 0 */
	if (work_lvl == null || (work_lvl != null && work_lvl.equals (""))) {
		work_lvl = "1";
	}

	switch (dml) {
	case 2:
		db_q=" insert into t_csm_proyek ("
			+"		id_project"
			+" ,	id_kontraktor"
			+" ,	eval_raw_score"
			+" ,	eval_weighted_score"
			+" ,	work_level"
			+" ,	penghargaan_sanksi"
			+" ,	koefisien_utama"
			+" ,	koefisien_tambah"
			+" ,	id_divprosbu"
			+" ,	id_direktorat"
			+" ) values ("+ id +", null, 0, 0.0, "+ work_lvl
			+", 1"
			+","+ k_utama
			+","+ k_tambah
			+","+ user_div
			+","+ user_dir
			+")";
		break;
	case 3:
		db_q=" update	t_csm_proyek"
			+" set		work_level	= "+ work_lvl
			+" ,		koefisien_utama	= "+ k_utama
			+" ,		koefisien_tambah= "+ k_tambah
			+" ,		id_divprosbu	= "+ user_div
			+" ,		id_direktorat	= "+ user_dir
			+" where	id_project	= "+ id;
		break;
	case 4:
		db_q="	delete from t_csm_proyek_kont_eval_nilai where id_project = "+ id
			+";	delete from t_csm_proyek_kont_eval where id_project = "+ id
			+";	delete from t_csm_proyek_kont_nilai where id_project = "+ id
			+";	delete from t_csm_proyek_kontraktor where id_project = "+ id
			+";	delete from t_csm_proyek where id_project = "+ id;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+dml+")!");
		out.print (_return);
		return;
	}

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
