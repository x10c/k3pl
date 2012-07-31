<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection con = (Connection) session.getAttribute("db.con");

	if (con == null || con.isClosed()) {
		String db_url = (String) session.getAttribute("db.url");

		if (db_url == null) {
			out.print("{success:false, info:'Session anda telah habis!'}");
			return;
		}

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		con = DriverManager.getConnection(db_url);

		session.setAttribute("db.con", (Object) con);
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

	Statement	stmt1	= con.createStatement();
	Statement	stmt2	= con.createStatement();
	ResultSet	rs1	= null;

	String	q;
	String	data;
	int	i = 0;
	int	j = 0;

	q	=" select	menu_name, menu_folder, menu_id, icon "
		+" from		__menu "
		+" where	menu_leaf = 0 "
		+" order by	menu_id ";

	rs1 = stmt1.executeQuery(q);

	data = "[";

	while (rs1.next()) {
		q	=" select distinct"
			+"	A.menu_id"
			+" ,	A.menu_name"
			+" ,	A.menu_folder"
			+" ,	A.menu_id"
			+" ,	A.icon"
			+" from		__menu		A"
			+" ,		__hak_akses	B"
			+" where	A.menu_id   	= B.menu_id"
			+" and		B.ha_level	>= 1"
			+" and		A.menu_parent	= "+ rs1.getString("menu_id")
			+" and		B.id_grup   	in ("
			+"	select	id_grup"
			+"	from	__user_grup"
			+"	where	nipg = '"+ user_nipg +"'"
			+" )"
			+" order by	A.menu_id";

		ResultSet rs2 = stmt2.executeQuery(q);

		if (!rs2.next()) {
			continue;
		}

		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data+="{ text     :'"+ rs1.getString("menu_name") +"'"
			+ ", id       :'"+ rs1.getString("menu_folder") +"'"
			+ ", iconCls  :'"+ rs1.getString("icon") +"' "
			+ ", children :[";

		j = 0;
		do {
			if (j > 0) {
				data += ",";
			} else {
				j++;
			}

			data+="{"
				+ "  text    : '"+ rs2.getString("menu_name") +"' "
				+ ", id      : '"+ rs2.getString("menu_folder") +"' "
				+ ", menu_id : '"+ rs2.getString("menu_id") +"' "
				+" , iconCls : '"+ rs2.getString("icon") +"' "
				+ ", leaf    : true "
				+ "}";
		} while (rs2.next());

		data +="]}";

		rs2.close();
	}

	data +="]";

	rs1.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
