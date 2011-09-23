<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
String q = "";
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_user = (String) session.getAttribute("user.nipg");
	String		user_email = (String) session.getAttribute("user.email");

	int			dml		= Integer.parseInt(request.getParameter("dml_type"));
	String		id_pssr	= request.getParameter("id_pssr");
	JSONArray	data	= new JSONArray((String) request.getParameter("detail"));
	Date		date	= new Date();
	int			status	= 0;
	int			jumlah	= 0;
	String		query	= "";
	int			i, l;
	JSONObject	o;
	ResultSet	rs2;

	switch (dml) {
	case 2:
		/* insert stop detail */
		q	=" insert into t_pssr_detail ("
			+"	id_pssr "
			+" ,	id_kategori_item_pssr "
			+" ,	id_item_pssr "
			+" ,	id_item_detail_pssr "
			+" ,	applicable "
			+" ,	confirm_ok "
			+" ,	punchlist "
			+" ,	keterangan "
			+" ,	id_user "
			+")";

		l = data.length();
		for (i = 0; i < l; i++) {
			o = data.getJSONObject(i);

			q	+= " select "+ id_pssr
				+", "+ o.getString("kat_id")
				+", "+ o.getString("item_id")
				+", "+ o.getString("detail_id")
				+", "+ o.getString("applicable")
				+", "+ o.getString("confirm_ok")
				+", "+ o.getString("punchlist")
				+", '"+ o.getString("keterangan")
				+"','"+ id_user +"' ";

			if (i < (l - 1)) {
				q += " union all ";
			}
		}
		break;
	case 3:
		q = "";
		l = data.length();
		for (i = 0; i < l; i++) {
			o = data.getJSONObject(i);

			q	+=" update	t_pssr_detail "
				+ " set		applicable	= "+ o.getString("applicable")
				+ " ,		confirm_ok	= "+ o.getString("confirm_ok")
				+ " ,		punchlist	= "+ o.getString("punchlist")
				+ " ,		keterangan	= '"+ o.getString("keterangan")+"' "
				+ " ,		id_user		= '"+ id_user +"' "
				+ " ,		tanggal_akses	= getdate() "
				+ " where	id_kategori_item_pssr		= "+ o.getString("kat_id")
				+ " and		id_item_pssr		= "+ o.getString("item_id")
				+ " and		id_item_detail_pssr	= "+ o.getString("detail_id")
				+ " and		id_pssr				= "+ id_pssr
				+ ";";
		}
		break;
	}
	db_stmt.executeUpdate(q);

	q	="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);
	
	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
