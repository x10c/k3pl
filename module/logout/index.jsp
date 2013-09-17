<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
Connection	db_con	= (Connection) session.getAttribute("db.con");
Cookie[]	cookies	= request.getCookies ();
String		c_path	= request.getContextPath ();
String		c_name	= "";

if (db_con != null && !db_con.isClosed()) {
	db_con.close();
}

session.removeAttribute("user.nipg");
session.removeAttribute("user.group");
session.removeAttribute("user.name");
session.removeAttribute("user.email");
session.removeAttribute("user.direktorat");
session.removeAttribute("user.divprosbu");
session.removeAttribute("user.departemen");
session.removeAttribute("user.dinas");
session.removeAttribute("user.seksi");
session.removeAttribute("user.wilayah");
session.removeAttribute("db.con");
session.removeAttribute("db.url");

if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		c_name = cookies[i].getName ();
		if (c_name.equalsIgnoreCase ("user.nipg")
		||  c_name.equalsIgnoreCase ("user.group")
		||  c_name.equalsIgnoreCase ("user.name")
		||  c_name.equalsIgnoreCase ("user.name")
		||  c_name.equalsIgnoreCase ("user.email")
		||  c_name.equalsIgnoreCase ("user.direktorat")
		||  c_name.equalsIgnoreCase ("user.divprosbu")
		||  c_name.equalsIgnoreCase ("user.departemen")
		||  c_name.equalsIgnoreCase ("user.dinas")
		||  c_name.equalsIgnoreCase ("user.seksi")
		||  c_name.equalsIgnoreCase ("user.wilayah")) {
			cookies[i].setMaxAge (0);
			cookies[i].setPath (c_path);
			response.addCookie (cookies[i]);
		}
	}
}

out.print("{success:true,info:'"+ c_path +"/'}");
%>
