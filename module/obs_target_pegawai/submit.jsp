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
	String		year	= (String) request.getParameter("year");
	JSONArray	rows	= new JSONArray((String) request.getParameter("rows"));
	JSONObject	row;
	JSONObject	cols;
	String		keys[];
	String		nipg, q_update, q_fields, q_values, q_where, v;
	int			i,j,l;

	db_stmt = db_con.createStatement();

	l = rows.length();
	for (i = 0; i < l; i++) {
		row		= rows.getJSONObject(i);
		nipg	= row.getString("nipg");
		cols	= row.getJSONObject("cols");
		keys	= JSONObject.getNames(cols);

		q_where	="	where	nipg ='"+ nipg +"'"
				+"	and		year = "+ year;

		q_update=" id_user			= "+ user_nipg
				+",tanggal_akses	= getdate()";

		q_fields	=" nipg, year, id_user";
		q_values	="'"+ nipg +"',"+ year +","+ user_nipg;

		for (j = 0; j < cols.length(); j++) {
			v	= cols.getString(keys[j]);

			q_update	+= ","+ keys[j] +"="+ v;
			q_fields	+= ","+ keys[j];
			q_values	+= ","+ v;

			db_q=" if exists("
				+"	select	1"
				+"	from	t_stop_target_pegawai"
				+ q_where
				+" ) begin"
				+"	update	t_stop_target_pegawai"
				+"	set"
				+ q_update
				+ q_where
				+" end else begin"
				+"	insert into t_stop_target_pegawai ("
				+ q_fields
				+"	) values ("
				+ q_values
				+"	);"
				+"end";

			db_stmt.executeUpdate (db_q);
		}
	}

	db_q=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','3')";

	db_stmt.executeUpdate (db_q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
