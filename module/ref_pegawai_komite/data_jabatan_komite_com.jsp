<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
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
	String		id_kel_jabatan_komite	= request.getParameter("id_kel");
	
	if ( id_kel_jabatan_komite.equals("0")
		|| id_kel_jabatan_komite.equals("")) {
		id_kel_jabatan_komite ="0 or 1 = 1 ";
	}

	String q= " select   id_jabatan_komite "
		+ " ,        id_kel_jabatan_komite_sub_komite "
		+ " ,        nama_jabatan_komite "
		+ " from     r_jabatan_komite_sub_komite "
		+ " where id_kel_jabatan_komite_sub_komite = "+ id_kel_jabatan_komite
		+ " order by id_jabatan_komite ";
	
	//out.print(q);
		
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_jabatan_komite") +"' "
			+  ", '"+ rs.getString("nama_jabatan_komite") +"' "
			+  "] ";
	}

	data += "]";


	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
