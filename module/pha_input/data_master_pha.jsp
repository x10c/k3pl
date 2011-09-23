<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_pha = (String) request.getParameter("id_pha");
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	a.id_project "
	+" ,		(select replace(convert(varchar, b.tanggal_mulai, 111), '/', '-') from r_project as b where a.id_project = b.id_project) as tanggal_project "
	+" ,		a.lokasi "
	+" ,		replace(convert(varchar, a.tanggal, 111), '/', '-') tanggal "
	+" ,		a.proses_phr "
	+" from		t_pha as a"
	+" where	a.id_pha	= "+ id_pha;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data PHA tidak ditemukan!'}");
		return;
	}

	data	="{id_pha : '"+ id_pha
		+"', id_project	: '"+ rs.getString("id_project")
		+"', tanggal_project : '"+ rs.getString("tanggal_project")
		+"', lokasi : '"+ rs.getString("lokasi")
		+"', tanggal : '"+ rs.getString("tanggal")
		+"', proses_phr	: '"+ rs.getString("proses_phr")
		+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
