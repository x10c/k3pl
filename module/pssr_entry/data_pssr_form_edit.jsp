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
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	Statement	db_stmt2= db_con.createStatement();

	String		id_pssr = (String) request.getParameter("id_pssr");
	ResultSet	rs;
	ResultSet	rs2;
	String		q;
	String		n_obs;
	String		safe, unsafe;
	JSONObject	data	= new JSONObject();
	JSONArray	details	= new JSONArray();
	JSONObject	detail;
	int		i	= 0;

	q=" select	id_pssr "
	+" ,		id_project "
	+" ,		lokasi "
	+" ,		replace(convert(varchar, tanggal, 111), '/', '-') tanggal "
	+" from		t_pssr"
	+" where	id_pssr	= "+ id_pssr;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data observasi tidak ditemukan!'}");
		return;
	}

	data.put("id_pssr", id_pssr);
	data.put("id_project", rs.getString("id_project"));
	data.put("lokasi", rs.getString("lokasi"));
	data.put("tanggal", rs.getString("tanggal"));

	q=" select	id_kategori_item_pssr"
	+" ,		id_item_pssr"
	+" ,		id_item_detail_pssr"
	+" ,		applicable"
	+" ,		confirm_ok"
	+" ,		punchlist"
	+" ,		keterangan"
	+" from		t_pssr_detail"
	+" where	id_pssr = "+ id_pssr;

	rs2 = db_stmt2.executeQuery(q);

	while (rs2.next()) {
		detail	= new JSONObject();

		detail.put("kat_id", rs2.getString("id_kategori_item_pssr"));
		detail.put("item_id", rs2.getString("id_item_pssr"));
		detail.put("detail_id", rs2.getString("id_item_detail_pssr"));
		detail.put("applicable", rs2.getString("applicable"));
		detail.put("confirm_ok", rs2.getString("confirm_ok"));
		detail.put("punchlist", rs2.getString("punchlist"));
		detail.put("keterangan", rs2.getString("keterangan"));

		details.put(detail);
	}

	data.put("details", details);

	rs.close();
	rs2.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
