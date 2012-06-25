<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
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
	String		start	= request.getParameter("start");
	String		end	= request.getParameter("end");

	String q=" select	nipg "
		+" ,		id_klasifikasi_pegawai "
		+" ,		id_jabatan "
		+" ,		id_direktorat "
		+" ,		id_divprosbu "
		+" ,		id_departemen "
		+" ,		id_dinas "
		+" ,		id_seksi "
		+" ,		nama_pegawai "
		+" ,		email "
		+" ,		status_pegawai "
		+" from		r_pegawai "
		+" order by	nama_pegawai";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		nama, data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="['"+ rs.getString("nipg") +"'"
			+ ","+ rs.getString("id_klasifikasi_pegawai")
			+ ","+ rs.getString("id_jabatan")
			+ ","+ rs.getString("id_direktorat")
			+ ","+ rs.getString("id_divprosbu")
			+ ","+ rs.getString("id_departemen")
			+ ","+ rs.getString("id_dinas")
			+ ","+ rs.getString("id_seksi")
			+ ",\""+ rs.getString("nama_pegawai") +"\""
			+ ",'"+ rs.getString("email") +"'"
			+ ",'"+ rs.getString("status_pegawai") +"'"
			+  "]";
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
