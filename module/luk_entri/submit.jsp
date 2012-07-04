<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String q="";
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User Divisi/Proyek/SBU tidak diketahui.'}");
		return;
	}

	Statement	db_stmt	= db_con.createStatement();
	String		id_user	= (String) session.getAttribute("user.nipg");
	String		year	= (String) request.getParameter("year");
	String		month	= (String) request.getParameter("month");
	String		id, v, q_where, q_update, q_fields, q_values, tanggal;
	JSONArray	data	= new JSONArray((String) request.getParameter("rows"));
	JSONObject	col_change;
	String[]	keys;
	
	JSONObject	row;
	int			i,j,l;

	tanggal = "cast('"+ year +"-"+ month +"-01' as datetime)";

	l = data.length();
	for (i = 0; i < l; i++) {
		row			= data.getJSONObject(i);
		id			= row.getString("id");
		col_change	= row.getJSONObject("data");
		keys		= JSONObject.getNames(col_change);

		q_where	=" where	tanggal					= "+ tanggal
				+" and		tahun					= "+ year
				+" and		bulan					= "+ month
				+" and		id_klasifikasi_pegawai	= "+ id
				+" and		id_divprosbu			= "+ user_div
				+" and		id_direktorat			= "+ user_dir;

		q_update=" id_user			= "+ id_user
				+",tanggal_akses	= getdate()";

		q_fields	= " tanggal, tahun, bulan, id_klasifikasi_pegawai, id_user, id_divprosbu, id_direktorat";
		q_values	= tanggal +","+ year +","+ month +","+ id +","+ id_user +","+ user_div +","+ user_dir;

		for (j = 0; j < col_change.length(); j++) {
			v	= col_change.getString(keys[j]);

			q_update	+= ", "+ keys[j] +"="+ v;
			q_fields	+= ", "+ keys[j];
			q_values	+= ", "+ v;

			q	=" if exists("
				+"	select	1"
				+"	from	t_unjuk_kerja"
				+ q_where
				+" ) begin"
				+"	update	t_unjuk_kerja"
				+"	set "+ q_update + q_where
				+" end else begin"
				+"	insert into t_unjuk_kerja ("
				+ q_fields
				+"	) values ("
				+ q_values
				+"	);"
				+"end";

			db_stmt.executeUpdate(q);
		}
	}

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
