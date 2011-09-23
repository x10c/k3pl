<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.*" %>
<%
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_user	= (String) session.getAttribute("user.nipg");

	int		dml 	= Integer.parseInt(request.getParameter("dml"));
	String	id		= request.getParameter("id");
	String	work_lvl= request.getParameter("work_level");
	String	k_utama	= request.getParameter("koefisien_utama");
	String	k_tambah= request.getParameter("koefisien_tambah");
	String	q;

	switch (dml) {
	case 2:
		q	=" insert into t_csm_proyek ("
			+"		id_project"
			+" ,	id_kontraktor"
			+" ,	eval_raw_score"
			+" ,	eval_weighted_score"
			+" ,	work_level"
			+" ,	penghargaan_sanksi"
			+" ,	koefisien_utama"
			+" ,	koefisien_tambah"
			+" ) values ("+ id +", null, 0, 0.0, "+ work_lvl
			+", 1"
			+","+ k_utama
			+","+ k_tambah
			+")";
		break;
	case 3:
		q	=" update	t_csm_proyek"
			+" set		work_level	= "+ work_lvl
			+" ,		koefisien_utama	= "+ k_utama
			+" ,		koefisien_tambah= "+ k_tambah
			+" where	id_project	= "+ id;
		break;
	case 4:
		q	="	delete from t_csm_proyek_kont_eval_nilai where id_project = "+ id
			+";	delete from t_csm_proyek_kont_eval where id_project = "+ id
			+";	delete from t_csm_proyek_kont_nilai where id_project = "+ id
			+";	delete from t_csm_proyek_kontraktor where id_project = "+ id
			+";	delete from t_csm_proyek where id_project = "+ id;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ id_user +"','"+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
