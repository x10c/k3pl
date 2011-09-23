<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Statement	db_stmt = db_con.createStatement();
	String		id_user	= (String) session.getAttribute("user.nipg");

	String dml		= request.getParameter("dml_type");
	String nipg		= request.getParameter("nipg");
	String id_rapat_materi  = request.getParameter("id_rapat_materi");
	String status_materi	= request.getParameter("status_materi");
	String q		= "";

	if (dml.equals("update")) {
		q	=" update	t_rapat_materi "
			+" set		status_materi		= '"+ status_materi +"' "
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_rapat_materi			= "+ id_rapat_materi ;

	}  else {
		out.print("{success:false"
			+ ",info   :'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e +"'}");
}
%>
