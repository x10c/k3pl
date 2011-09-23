<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	String		id_jsa 		= (String) request.getParameter("id_jsa");

	ResultSet	rs;
	String		q;
	String		data;

	q= " "
	+ " select   id_jsa "
	+ " ,        no_dokumen "
	+ " ,        revisi "
	+ " ,        no_kontrak "
	+ " ,        nama_perusahaan "
	+ " ,        nama_proyek "
	+ " ,        nama_pic "
	+ " ,        aktifitas_pekerjaan "
	+ " ,        replace(convert(varchar, tanggal_jsa, 111), '/', '-') tanggal_jsa "
	+ " ,        alat_pelindung_diri_digunakan "
	+ " from     t_jsa "
	+ " where 	 id_jsa = " + id_jsa;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data JSA tidak ditemukan!'}");
		return;
	}

	data = "{ id_jsa : " + id_jsa
		+  ", no_dokumen : '"+ rs.getString("no_dokumen")
		+  "', revisi : '"+ rs.getString("revisi")
		+  "', no_kontrak : '"+ rs.getString("no_kontrak")
		+  "', nama_perusahaan : '"+ rs.getString("nama_perusahaan")
		+  "', nama_proyek : '"+ rs.getString("nama_proyek")
		+  "', nama_pic : '"+ rs.getString("nama_pic")
		+  "', aktifitas_pekerjaan : '"+ rs.getString("aktifitas_pekerjaan")
		+  "', tanggal_jsa : '"+ rs.getString("tanggal_jsa")
		+  "', alat_pelindung_diri_digunakan : '"+ rs.getString("alat_pelindung_diri_digunakan") + "'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
