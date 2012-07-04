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
	String id_jabatan_komite	= request.getParameter("id");
	String id_kel_jabatan_csc	= request.getParameter("id_kel_csc");
	String id_kel_jabatan_komite	= request.getParameter("id_kel");
	String nama_jabatan_komite	= request.getParameter("nama");
	String notulen	= request.getParameter("notulen");
	String id_user			= (String) session.getAttribute("user.nipg");
	String q;
	String where_clause = "";
	if ( id_kel_jabatan_komite.equals("0")
		|| id_kel_jabatan_komite.equals("") || id_kel_jabatan_komite.equals("null")) {
		where_clause =" and id_kel_jabatan_komite_sub_komite is null";
		id_kel_jabatan_komite = "null";
	}
	else {
		where_clause =" and id_kel_jabatan_komite_sub_komite = "+ id_kel_jabatan_komite;
	}
	
	switch (dml) {
	case 2:
		q	=" insert into r_jabatan_komite_sub_komite ("
			+"	nama_jabatan_komite "
			+" ,	notulen "
			+" ,	id_kel_jabatan_csc "
			+" ,	id_kel_jabatan_komite_sub_komite "
			+" ,	id_user "
			+" ) values ('"
			+ nama_jabatan_komite +"', '"
			+ notulen +"', "
			+ id_kel_jabatan_csc +", "
			+ id_kel_jabatan_komite +", '"
			+ id_user +"' )";
		break;
	case 3:
		q	=" update	r_jabatan_komite_sub_komite "
			+" set		nama_jabatan_komite	= '"+ nama_jabatan_komite +"' "
			+" ,		notulen			= '"+ notulen +"' "
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_jabatan_komite	=  "+ id_jabatan_komite
			+" and	id_kel_jabatan_csc	=  "+ id_kel_jabatan_csc + where_clause;
		break;
	case 4:
		q	=" delete from	r_jabatan_komite_sub_komite "
			+" where	id_jabatan_komite   =  "+ id_jabatan_komite 
			+" and	id_kel_jabatan_csc	=  "+ id_kel_jabatan_csc + where_clause;
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
