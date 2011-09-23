<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.json.*" %>
<%
String q="";
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_user = (String) session.getAttribute("user.nipg");

	String		id, v, q_where, q_update, q_fields, q_values, tanggal;
	String		year	= (String) request.getParameter("year");
	String		month	= (String) request.getParameter("month");
	JSONArray	data	= new JSONArray((String) request.getParameter("rows"));
	JSONObject	col_change;
	String[]	keys;
	
	JSONObject	row;
	int		i,j,l;

	tanggal = "cast('"+ year +"-"+ month +"-01' as datetime)";

	l = data.length();
	for (i = 0; i < l; i++) {
		row		= data.getJSONObject(i);
		id		= row.getString("id");
		col_change	= row.getJSONObject("data");
		keys		= JSONObject.getNames(col_change);

		q_where		=" where	tanggal			= "+ tanggal
				+" and		tahun			= "+ year
				+" and		bulan			= "+ month
				+" and		id_klasifikasi_pegawai	= "+ id;

		q_update	=" id_user		= "+ id_user
				+",tanggal_akses	= getdate()";

		q_fields	= " tanggal, tahun, bulan, id_klasifikasi_pegawai, id_user";
		q_values	= tanggal +","+ year +","+ month +","+ id +","+ id_user;

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
