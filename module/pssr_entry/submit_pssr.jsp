<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - prasetya (prasetya.yanuar@googlemail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();	

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_pssr							= request.getParameter("id_pssr");
	String id_project						= request.getParameter("id_project");
	String lokasi							= request.getParameter("lokasi");
	String tanggal							= request.getParameter("tanggal");
	String id_user							= (String) session.getAttribute("user.nipg");
	String q;
	
	Date		date	= new Date();
	if (id_pssr.equals("")){
		id_pssr = Long.toString(date.getTime());
	}
	
	switch (dml) {
	case 2:
		q	=" insert into t_pssr ( id_pssr, id_project, lokasi, tanggal, id_user)"
			+" values ('"+id_pssr+ "' ,'"+id_project +"' ,'"+ lokasi +"' ,'"+ tanggal +"' ,'"+  id_user +"' )";
		break;

	case 3:
		q	=" update	t_pssr "
			+" set		id_project						= '"+ id_project +"' "
			+" ,		lokasi							= '"+ lokasi +"' "
			+" ,		tanggal						= '"+ tanggal +"' "
			+" ,		id_user							= '"+ id_user +"' "
			+" ,		tanggal_akses					= getdate() "
			+" where	id_pssr							=  "+ id_pssr;
		break;

	case 4:
		q	=" delete from t_pssr "
			+" where  id_pssr =  "+ id_pssr;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
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
