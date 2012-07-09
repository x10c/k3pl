<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - agus sugianto (agus.delonge@gmail.com)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

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
		q	=" update	t_csm_proyek"
			+" set		work_level	= "+ work_lvl
			+" ,		koefisien_utama	= "+ k_utama
			+" ,		koefisien_tambah= "+ k_tambah
			+" ,		id_divprosbu	= "+ user_div
			+" ,		id_direktorat	= "+ user_dir
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
		+ user_nipg +"','"+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
