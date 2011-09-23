<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%
String q = "";
String o = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	String		applicable		= request.getParameter("applicable");
	String		confirm_ok	= request.getParameter("confirm_ok");
	String		punchlist	= request.getParameter("punchlist");
	String		q_org;
	String		q_id;
	int		i = 0;

	q	=" select	X.id_pssr "
		+" ,		X.id_item_detail_pssr "
		+" ,		A.nama_item_detail_pssr "
		+" ,		X.id_item_pssr "
		+" ,		Z.nama_item_pssr "
		+" ,		X.id_kategori_item_pssr "
		+" ,		Y.nama_kategori_item_pssr "
		+" ,		X.applicable "
		+" ,		X.confirm_ok "
		+" ,		X.punchlist "
		+" ,		X.keterangan "
		+" from	t_pssr_detail	X "
		+" , r_kategori_item_pssr Y "
		+" , r_item_pssr Z "
		+" , r_item_detail_pssr A "
		+" where	X.id_kategori_item_pssr	= Y.id_kategori_item_pssr "
		+" and		X.id_item_pssr	= Z.id_item_pssr "
		+" and		X.id_item_detail_pssr	= A.id_item_detail_pssr ";

	if (applicable != null || !applicable.equals("")) {
		q +=" and	X.applicable ="+applicable;
	}

	if (confirm_ok != null && !confirm_ok.equals("")) {
		q +=" and	X.confirm_ok = "+ confirm_ok ;
	}

	if (punchlist != null && !punchlist.equals("")) {
		q +=" and	X.punchlist = "+ punchlist ;
	}
	
	ResultSet rs = db_stmt.executeQuery(q);

	o = "{rows:[";
	while (rs.next()) {
		if (i > 0) {
			o += ",";
		} else {
			i = 1;
		}

		o	+="{id_pssr:"+ rs.getString("id_pssr")			+""
			+ ",id_item_detail_pssr:"+ rs.getString("id_item_detail_pssr")	+""
			+ ",nama_item_detail_pssr:\""+ rs.getString("nama_item_detail_pssr") +"\""
			+ ",id_item_pssr:"+ rs.getString("id_item_pssr")
			+ ",nama_item_pssr:\""+ rs.getString("nama_item_pssr") +"\""
			+ ",id_kategori_item_pssr:"+ rs.getString("id_kategori_item_pssr")
			+ ",nama_kategori_item_pssr:\""+ rs.getString("nama_kategori_item_pssr")	+"\""
			+ ",applicable:"+ rs.getString("applicable")	
			+ ",confirm_ok:"+ rs.getString("confirm_ok")	
			+ ",punchlist:"+ rs.getString("punchlist")
			+ "}";
	}
	rs.close();

	o += "]}";

	out.print(o);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
