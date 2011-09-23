<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt 	= db_con.createStatement();
	String		load_type	= (String) request.getParameter("load_type");
	String		nipg		= (String) session.getAttribute("user.nipg");
	
	String q=" select	a.id_pha "
		+" ,		(select b.nama_project from r_project as b where a.id_project = b.id_project) as project "
		+" ,		(select replace(convert(varchar, b.tanggal_mulai, 111), '/', '-') from r_project as b where a.id_project = b.id_project) as tanggal_project "
		+" ,		replace(convert(varchar, tanggal, 111), '/', '-') as tanggal "
		+" ,		a.lokasi "
		+" from		t_pha as a"
		+" where	a.id_user = '"+ nipg +"'";

		if (load_type.equals("all")) {
			q+=" or		'"+ nipg +"' in (select c.nipg from __user_grup as c where c.id_grup = 1)";
		}

		q+=" order by	tanggal desc ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="['"+ rs.getString("id_pha")
			+ "','"+ rs.getString("project")
			+ "','"+ rs.getString("tanggal_project")
			+ "','"+ rs.getString("tanggal")
			+ "','"+ rs.getString("lokasi")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
