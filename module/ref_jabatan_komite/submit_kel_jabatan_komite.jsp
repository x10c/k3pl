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
	String id_kel_jabatan_komite	= request.getParameter("id");
	String nama_kel_jabatan_komite	= request.getParameter("nama");
	String id_user			= (String) session.getAttribute("user.nipg");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_kel_jabatan_komite_sub_komite ("
			+"	id_kel_jabatan_komite_sub_komite "
			+",	nama_kel_jabatan_komite_sub_komite "
			+",	id_user "
			+") values ("
			+ id_kel_jabatan_komite +", '"
			+ nama_kel_jabatan_komite +"', '"
			+ id_user
			+"' )";
		break;
	case 3:
		q	=" update	r_kel_jabatan_komite_sub_komite "
			+" set		nama_kel_jabatan_komite_sub_komite	= '"+ nama_kel_jabatan_komite +"' "
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_kel_jabatan_komite_sub_komite	=  "+ id_kel_jabatan_komite;
		break;
	case 4:
		q	=" delete from	r_kel_jabatan_komite_sub_komite "
			+" where	id_kel_jabatan_komite_sub_komite =  "+ id_kel_jabatan_komite;
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
