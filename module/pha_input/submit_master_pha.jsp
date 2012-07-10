<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies			= request.getCookies ();
	String		id_divprosbu	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		id_direktorat	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement	db_stmt = db_con.createStatement();
	String		id_user = (String) session.getAttribute("user.nipg");

	int			dml				= Integer.parseInt(request.getParameter("dml_type"));
	String		id_pha			= request.getParameter("id_pha");
	String		id_project		= request.getParameter("id_project");
	String		lokasi			= request.getParameter("lokasi");
	String		tanggal			= request.getParameter("tanggal");
	String		proses_phr		= request.getParameter("proses_phr");
	
	String		q 		= "";
	Date		date	= new Date();

	switch (dml) {
	case 2:
		id_pha	= Long.toString(date.getTime());

		q	=" insert into t_pha (id_pha, id_project, lokasi, tanggal,"
			+" proses_phr, id_user, id_divprosbu, id_direktorat)"
			+" values ("+ id_pha +" ,"+ id_project +" ,'"+ lokasi +"' ,'"+ tanggal +"' ,"
			+" '"+ proses_phr +"' ,'"+ id_user + "' ," + id_divprosbu + " ," + id_direktorat + ")";

		break;
	case 3:
		q	=" update t_pha "
			+" set "
			+"   id_project			= "+ id_project
			+" , lokasi				= '"+ lokasi +"' "
			+" , tanggal			= cast('"+ tanggal +"' as datetime) "
			+" , proses_phr			= '"+ proses_phr +"' "
			+" , id_user			= '"+ id_user +"' "
			+" , id_divprosbu		=  "+ id_divprosbu
			+" , id_direktorat		=  "+ id_direktorat
			+" , tanggal_akses		= getdate() "
			+" where id_pha			=  "+ id_pha;
			
		break;
	case 4:
		q	=" delete from t_pha "
			+" where  id_pha =  "+ id_pha;

		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
