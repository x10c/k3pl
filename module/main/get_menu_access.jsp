<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String q = "";
try {
	Connection con = (Connection) session.getAttribute("db.con");
	if (con == null || (con != null && con.isClosed())) {
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

	String		menu_id		= request.getParameter("menu_id");

	if (menu_id == null || (menu_id != null && menu_id.equals(""))) {
		out.print("{success:true,info:'0'}");
		return;
	}

	session.setAttribute("menu.id", menu_id);

	Statement	stmt	= con.createStatement();
	ResultSet	rs		= null;

	q
	=" select	isnull(max(ha_level),1) ha_level"
	+" from		__hak_akses"
	+" where	menu_id = '"+ menu_id +"'"
	+" and		id_grup in ("
	+" 	select	id_grup"
	+" 	from	__user_grup"
	+" 	where	nipg = '"+ user_nipg +"'"
	+" )";

	rs = stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:true,info:'0'}");
	} else {
		out.print("{success:true,info:'"+ rs.getString("ha_level") +"'}");
	}

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
