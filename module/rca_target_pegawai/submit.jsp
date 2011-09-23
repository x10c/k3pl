<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
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
	String		year	= (String) request.getParameter("year");
	JSONArray	rows	= new JSONArray((String) request.getParameter("rows"));
	JSONObject	row;
	JSONObject	cols;
	String		keys[];
	String		nipg, q_update, q_fields, q_values, q_where, v;
	int		i,j,l;

	l = rows.length();
	for (i = 0; i < l; i++) {
		row		= rows.getJSONObject(i);
		nipg		= row.getString("nipg");
		cols		= row.getJSONObject("cols");
		keys		= JSONObject.getNames(cols);

		q_where		="	where	nipg ='"+ nipg +"'"
				+"	and	year = "+ year;

		q_update	=" id_user		= "+ id_user
				+",tanggal_akses	= getdate()";

		q_fields	=" nipg, year, id_user";
		q_values	="'"+ nipg +"',"+ year +","+ id_user;

		for (j = 0; j < cols.length(); j++) {
			v	= cols.getString(keys[j]);

			q_update	+= ","+ keys[j] +"="+ v;
			q_fields	+= ","+ keys[j];
			q_values	+= ","+ v;

			q	=" if exists("
				+"	select	1"
				+"	from	t_rca_target_pegawai"
				+ q_where
				+" ) begin"
				+"	update	t_rca_target_pegawai"
				+"	set"
				+ q_update
				+ q_where
				+" end else begin"
				+"	insert into t_rca_target_pegawai ("
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
