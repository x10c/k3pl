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
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt_grp = db_con.createStatement();
	Statement	db_stmt = db_con.createStatement();

	String		q;
	String		output;
	int		i,j;

	q	=" select	id, nama"
		+" from		r_pelatihan_kelompok"
		+" order by	id";

	ResultSet rs_grp = db_stmt_grp.executeQuery(q);

	i	= 0;
	output	= "{";
	while (rs_grp.next()) {
		if (i > 0) {
			output += ",";
		} else {
			i = 1;
		}

		output += rs_grp.getString("nama") +": [";

		q	=" select	id_pelatihan "
			+" ,		nama_pelatihan "
			+" from		r_pelatihan "
			+" where	id_pelatihan_kelompok = "+ rs_grp.getString("id")
			+" order by	id_pelatihan ";

		ResultSet rs = db_stmt.executeQuery(q);

		j = 0;
		while (rs.next()) {
			if (j > 0) {
				output += ",";
			} else {
				j = 1;
			}

			output	+="{"
				+ "  id  : '"+ rs.getString("id_pelatihan") +"'"
				+ ", name: '"+ rs.getString("nama_pelatihan") +"'"
				+ "}";
		}
		output += "]";

		rs.close();
	}
	output += "}";

	out.print(output);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
