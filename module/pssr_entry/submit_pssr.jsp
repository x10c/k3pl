<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - prasetya (prasetya.yanuar@googlemail.com)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.kilabit.ServletUtilities" %>
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

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();	

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String id_pssr							= request.getParameter("id_pssr");
	String id_project						= request.getParameter("id_project");
	String lokasi							= request.getParameter("lokasi");
	String tanggal							= request.getParameter("tanggal");
	String q;
	
	Date		date	= new Date();
	if (id_pssr.equals("")){
		id_pssr = Long.toString(date.getTime());
	}
	
	switch (dml) {
	case 2:
		q	=" insert into t_pssr ( id_pssr, id_project, lokasi, tanggal, id_user, id_divprosbu, id_direktorat)"
			+" values ('"+id_pssr+ "' ,'"+id_project +"' ,'"+ lokasi +"' ,'"+ tanggal +"' ,'"+  user_nipg +"' ," + user_div + " ," + user_dir + " )";
		break;

	case 3:
		q	=" update	t_pssr "
			+" set		id_project						= '"+ id_project +"' "
			+" ,		lokasi							= '"+ lokasi +"' "
			+" ,		tanggal							= '"+ tanggal +"' "
			+" ,		id_user							= '"+ user_nipg +"' "
			+" ,		id_divprosbu					=  "+ user_div
			+" ,		id_direktorat					=  "+ user_dir
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
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
