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

	Statement	db_stmt		= db_con.createStatement();	
	String		id_user = (String) session.getAttribute("user.nipg");

	int dml	= Integer.parseInt(request.getParameter("dml_type"));
	String id	= request.getParameter("id");
	String name	= request.getParameter("name");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_alat_pelindung_diri_ptw (nama_alat_pelindung_diri_ptw, id_user) "
			+" values ('"+ name +"', '"+ id_user +"')";
		break;
	case 3:
		q	=" update	r_alat_pelindung_diri_ptw "
			+" set		nama_alat_pelindung_diri_ptw	= '"+ name +"' "
			+" ,		id_user		= '"+ id_user +"' "
			+" ,		tanggal_akses	= getdate() "
			+" where	id_alat_pelindung_diri_ptw	=  "+ id;
		break;
	case 4:
		q	=" delete from r_alat_pelindung_diri_ptw "
			+" where  id_alat_pelindung_diri_ptw = "+ id;
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
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
