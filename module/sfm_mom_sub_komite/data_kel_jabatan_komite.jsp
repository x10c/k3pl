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
	Statement	db_stmt = db_con.createStatement();

	String q= " select   id_kel_jabatan_komite_sub_komite "
		+ " ,        nama_kel_jabatan_komite_sub_komite "
		+ " from     r_kel_jabatan_komite_sub_komite "
		+ " where     id_kel_jabatan_komite_sub_komite not in ('1') "
		+ " union select 0,'Seluruh Sub Committee' from r_kel_jabatan_komite_sub_komite "
		+ " order by id_kel_jabatan_komite_sub_komite ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_kel_jabatan_komite_sub_komite") +"' "
			+  ", '"+ rs.getString("nama_kel_jabatan_komite_sub_komite") +"' "
			+  "] ";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{ success: false, info:'"+ e +"' }");
}
%>
