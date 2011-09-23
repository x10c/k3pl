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
	String		load_type	= (String) request.getParameter("load_type");

	String		tahun	= request.getParameter("tahun");
	String		bulan	= request.getParameter("bulan");
	String		wilayah	= request.getParameter("wilayah");

	ResultSet	rs;
	String		q;

	q=" select	id_kegiatan_detail "
	+" ,		tahun "
	+" ,		bulan "
	+" ,		id_wilayah "
	+" ,		id_tipe_kegiatan "
	+" ,		nama_kegiatan "
	+" from		t_kegiatan_detail "
	+" where	tahun 	= " + tahun
	+" and		bulan	= " + bulan;

	if (!load_type.equals("all")) {
		q+=" and	id_wilayah		= "+ wilayah;
	}

	q+=" order by	tahun, bulan";

	rs = db_stmt.executeQuery(q);

	int		i		= 0;
	String	data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ "+ rs.getString("id_kegiatan_detail")
			+  ", "+ rs.getString("tahun")
			+  ", "+ rs.getString("bulan")
			+  ", "+ rs.getString("id_wilayah")
			+  ", "+ rs.getString("id_tipe_kegiatan")
			+  ", '"+ rs.getString("nama_kegiatan") +"' "
			+  "]";
	}

	data += "]";
	
	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
