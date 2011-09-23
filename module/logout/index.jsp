<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
Connection db_con = (Connection) session.getAttribute("db.con");

if (db_con != null && !db_con.isClosed()) {
	db_con.close();
}

session.removeAttribute("user.nipg");
session.removeAttribute("user.name");
session.removeAttribute("db.con");
session.removeAttribute("db.url");

out.print("{success:true,info:'"+ request.getContextPath() +"/'}");
%>
