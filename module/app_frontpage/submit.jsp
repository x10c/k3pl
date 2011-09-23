<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%
String q;
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	Date		date	= new Date();
	

	int		dml				= Integer.parseInt(request.getParameter("dml_type"));
	String	id				= request.getParameter("id");
	String	date_published	= request.getParameter("date_published");
	String	subject			= request.getParameter("subject");
	String	url				= request.getParameter("url");
	String	content			= request.getParameter("content");

	content = content.replace("'","''");

	switch (dml) {
	case 2:
		q	=" insert into t_home_news (date_published, subject, url, content)"
			+" values (cast('"+ date_published +"' as datetime)"
			+" ,'"+ subject +"'"
			+" ,'"+ url +"'"
			+" ,'"+ content +"'"
			+" )";

		log("query: "+ q);
		break;
	case 3:
		q	=" update	t_home_news"
			+" set		date_published	= cast('"+ date_published +"' as datetime)"
			+" ,		date_updated	= getdate()"
			+" ,		subject			='"+ subject +"'"
			+" ,		url				='"+ url +"'"
			+" ,		content			='"+ content +"'"
			+" where	id				= "+ id;

		log("query: "+ q);
		break;
	case 4:
		q	=" delete from t_home_news where id = "+ id;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
