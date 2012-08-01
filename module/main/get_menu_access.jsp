<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	String menu_id = request.getParameter("menu_id");

	if (menu_id == null || (menu_id != null && menu_id.equals(""))) {
		out.print("{success:true,info:'0'}");
		return;
	}

	session.setAttribute("menu.id", menu_id);

	db_stmt = db_con.createStatement();

	db_q
	=" select	isnull(max(ha_level),1) ha_level"
	+" from		__hak_akses"
	+" where	menu_id = '"+ menu_id +"'"
	+" and		id_grup in ("
	+" 	select	id_grup"
	+" 	from	__user_grup"
	+" 	where	nipg = '"+ user_nipg +"'"
	+" )";

	db_rs = db_stmt.executeQuery (db_q);

	if (! db_rs.next()) {
		out.print("{success:true,info:'0'}");
	} else {
		out.print("{success:true,info:'"+ db_rs.getString("ha_level") +"'}");
	}

	db_rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
