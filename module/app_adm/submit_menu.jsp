<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	int dml = 3;
	String id_grup		= request.getParameter("id_grup");
	String menu_id		= request.getParameter("menu_id");
	String ha_level		= request.getParameter("ha_level");
	String ha_level_org	= request.getParameter("ha_level_org");

	db_stmt = db_con.createStatement();

	db_q=" if exists ("
		+"	select	1"
		+"	from	__hak_akses"
		+"	where	id_grup	= "+ id_grup
		+"	and		menu_id	='"+ menu_id +"'"
		+" ) begin"
		+"	update __hak_akses "
		+"	set    ha_level = "+ ha_level
		+"	where  id_grup  = "+ id_grup
		+"	and    menu_id  ='"+ menu_id +"';"
		+" end else begin"
		+"	insert into __hak_akses (id_grup, menu_id, ha_level)"
		+"	values ("+ id_grup +",'"+ menu_id +"',"+ ha_level +");"
		+" end";

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','"
		+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
