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

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_kel_jabatan_csc	= request.getParameter("id");
	String nama_kel_jabatan_csc	= request.getParameter("nama");
	String id_divprosbu	= request.getParameter("id_divprosbu");
	String id_direktorat	= request.getParameter("id_direktorat");
	String id_user			= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_kel_jabatan_csc ("
			+"	nama_kel_jabatan_csc "
			+",	id_divprosbu "
			+",	id_direktorat "
			+",	id_user "
			+") values ('"
			+ nama_kel_jabatan_csc +"', "
			+ id_divprosbu +", "
			+ id_direktorat +", '"
			+ id_user
			+"' )";
		break;
	case 3:
		q	=" update	r_kel_jabatan_csc "
			+" set		nama_kel_jabatan_csc	= '"+ nama_kel_jabatan_csc +"' "
			+" ,		id_divprosbu			= "+ id_divprosbu 
			+" ,		id_direktorat			= "+ id_direktorat 
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_kel_jabatan_csc	=  "+ id_kel_jabatan_csc;
		break;
	case 4:
		q	=" delete from	r_kel_jabatan_csc "
			+" where	id_kel_jabatan_csc =  "+ id_kel_jabatan_csc;
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
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
