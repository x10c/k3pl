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
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_material	= request.getParameter("id_material");
	
	String q= " select   a.id_material "
		+ " ,        a.id_properties "
		+ " ,        (select b.nama_properties from r_properties as b where a.id_properties = b.id_properties) as properties "
		+ " ,        a.description "
		+ " from     t_chemical_hazard	as a "
		+ " where    a.id_material	= " + id_material
		+ " order by a.id_material, a.id_properties ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		String desc = rs.getString("description");

		desc = desc.replace("\n","\\n");

		data	+= "["+ rs.getString("id_material")
			+  ","+ rs.getString("id_properties")
			+  ",'"+ rs.getString("properties") + "'"
			+ ",\""+ desc +"\""
			+  "]";
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
