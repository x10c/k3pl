<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - Prasetya Yanuar (mieh100freak@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_kel_jabatan_csc	= request.getParameter("id_kel_csc");

	String q= " select   id_kel_jabatan_komite_sub_komite "
		+ " ,        nama_kel_jabatan_komite_sub_komite "
		+ " ,        id_kel_jabatan_csc "
		+ " ,        id_divprosbu "
		+ " ,        id_direktorat "
		+ " from     r_kel_jabatan_komite_sub_komite "
		+ " where     id_kel_jabatan_csc = "+ id_kel_jabatan_csc
		+ " order by id_kel_jabatan_komite_sub_komite ";
//out.print(q);
	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "{ rows : [";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "{ id : '"+ rs.getString("id_kel_jabatan_komite_sub_komite") +"' "
			+  ", nama : '"+ rs.getString("nama_kel_jabatan_komite_sub_komite") +"' "
			+  ", id_kel_jabatan_csc : '"+ rs.getString("id_kel_jabatan_csc") +"' "
			+  ", id_divprosbu : '"+ rs.getString("id_divprosbu") +"' "
			+  ", id_direktorat : '"+ rs.getString("id_direktorat") +"' "
			+  "} ";
	}

	data += "]}";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
