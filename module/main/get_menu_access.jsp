<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection con = (Connection) session.getAttribute("db.con");
	if (con == null || con.isClosed()) {
		String db_url = (String) session.getAttribute("db.url");

		if (db_url == null) {
			out.print("{success:false, info:'0'}");
			return;
		}

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		con = DriverManager.getConnection(db_url);

		session.setAttribute("db.con", (Object) con);
	}

	Statement	stmt		= con.createStatement();
	String		user_nipg	= (String) session.getAttribute("user.nipg");
	String		menu_id		= request.getParameter("menu_id");
	ResultSet	rs		= null;

	if (menu_id == null || (menu_id != null && menu_id.equals(""))) {
		out.print("{success:true,info:'0'}");
		return;
	}

	session.setAttribute("menu.id", menu_id);

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
