<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Agus Sugianto (agus.delonge@gmail.com)
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import = "java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_user	= (String) session.getAttribute("user.nipg");
	String id_group	= request.getParameter("id_group");
	String id	= request.getParameter("id");
	String name	= request.getParameter("name");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_pelatihan ("
			+"	nama_pelatihan "
			+" ,	id_pelatihan_kelompok "
			+" ,	id_user "
			+" ) values ("
			+" '"+ name +"' "
			+",'"+ id_group +"' "
			+",'"+ id_user +"')";
		break;
	case 3:
		q	=" update	r_pelatihan "
			+" set		nama_pelatihan	= '"+ name +"' "
			+" ,		id_user		= '"+ id_user +"' "
			+" where	id_pelatihan	= "+ id;
		break;
	case 4:
		q	=" delete from	r_pelatihan "
			+" where	id_pelatihan = "+ id
			+" and		id_pelatihan_kelompok = "+ id_group;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
