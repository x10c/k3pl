<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - prasetya (prasetya.yanuar@googlemail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();	
	String		id_pssr		= request.getParameter("id_pssr");

	if ( id_pssr.equals("0")) {
		id_pssr ="0 or 1 = 1 ";
	}

	String q= " select   id_pssr "
		+ " ,        a.nipg "
		+ " ,        a.nipg as nipg_old "
		+ " ,        b.id_departemen "
		+ " ,        a.id_jabatan_pssr "
		+ " from     t_pssr_keanggotaan as a"
		+ " ,     r_pegawai as b"
		+ " where    a.id_pssr = "+ id_pssr
		+ " and     b.nipg = a.nipg "
		+ " order by    id_jabatan_pssr";


	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_pssr") +"' "
			+  ", '"+ rs.getString("nipg") +"' "
			+  ", '"+ rs.getString("nipg_old") +"' "
			+  ", '"+ rs.getString("id_departemen") +"' "
			+  ", '"+ rs.getString("id_jabatan_pssr") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
