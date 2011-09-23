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

	String q= " select   a.id_material "
		+ " ,        a.id_material_interaction "
		+ " ,        (select b.nama_material from r_material as b where a.id_material = b.id_material) as material "
		+ " ,        (select c.nama_material_interaction from r_material_interaction as c where a.id_material_interaction = c.id_material_interaction) as material_interaction "
		+ " ,        a.interaction "
		+ " from     t_cim	as a"
		+ " order by a.id_material, a.id_material_interaction ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		String inter = rs.getString("interaction");

		inter = inter.replace("\n","\\n");

		data	+= "[ "+ rs.getString("id_material")
			+  ","+ rs.getString("id_material_interaction")
			+  ",'"+ rs.getString("material") +"' "
			+  ",'"+ rs.getString("material_interaction") +"' "
			+  ",\""+ inter +"\""
			+  "]";
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
