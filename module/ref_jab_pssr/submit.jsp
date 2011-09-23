<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya (prasetya.yanuar@gmail.com)
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
	String id_jabatan_pssr	= request.getParameter("id_jabatan_pssr");
	String nama_jabatan_pssr	= request.getParameter("nama_jabatan_pssr");
	String id_user		= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_jabatan_pssr (nama_jabatan_pssr, id_user)"
			+" values ('"+ nama_jabatan_pssr +"'" +" ,'"+ id_user +"')";
		break;
	case 3:
		q	=" update	r_jabatan_pssr"
			+" set		nama_jabatan_pssr	= '"+ nama_jabatan_pssr +"'"
			+" ,		id_user		= '"+ id_user +"'"
			+" ,		tanggal_akses	= getdate()"
			+" where	id_jabatan_pssr	= "+ id_jabatan_pssr;
		break;
	case 4:
		q = " delete from r_jabatan_pssr where id_jabatan_pssr = "+ id_jabatan_pssr;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
