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

	int dml 							= Integer.parseInt(request.getParameter("dml_type"));
	String id_material					= request.getParameter("id_material");
	String id_material_interaction		= request.getParameter("id_material_interaction");
	String interaction					= request.getParameter("interaction");
	String id_user						= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_cim("
			+"	id_material"
			+" ,	id_material_interaction"
			+" ,	interaction"
			+" ,	id_user"
			+" ) values ("+ id_material +", "+ id_material_interaction +", '"+ interaction +"', '"+ id_user +"' )";
		break;
	case 3:
		q	=" update	t_cim "
			+" set		interaction				= '"+ interaction +"' "
			+" ,		id_user					= '"+ id_user +"' "
			+" ,		tanggal_akses			= getdate() "
			+" where	id_material				=  "+ id_material
			+" and		id_material_interaction	=  "+ id_material_interaction;
		break;
	case 4:
		q	=" delete from t_cim "
			+" where  id_material				=  "+ id_material
			+" and    id_material_interaction	=  "+ id_material_interaction;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{ success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
