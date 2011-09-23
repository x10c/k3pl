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

	String		id_lingkungan_tahunan = (String) request.getParameter("id_lingkungan_tahunan");
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	id_lingkungan_tahunan "
	+" ,		id_seksi "
	+" ,		id_dinas "
	+" ,		id_departemen "
	+" ,		tipe_kegiatan_lingkungan "
	+" ,		proyek_kegiatan_aktifitas "
	+" ,		dikompilasi_oleh "
	+" ,		replace(convert(varchar, tanggal_kompilasi, 111), '/', '-') tanggal_kompilasi "
	+" ,		disetujui_oleh "
	+" ,		replace(convert(varchar, tanggal_disetujui, 111), '/', '-') tanggal_disetujui "
	+" from		t_lingkungan "
	+" where	id_lingkungan_tahunan	= "+ id_lingkungan_tahunan;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Lingkungan tidak ditemukan!'}");
		return;
	}

	data	="{ id_lingkungan_tahunan : "+ id_lingkungan_tahunan
		+", id_seksi : "+ rs.getString("id_seksi")
		+", id_dinas : "+ rs.getString("id_dinas")
		+", id_departemen : "+ rs.getString("id_departemen")
		+", tipe_kegiatan_lingkungan : "+ rs.getString("tipe_kegiatan_lingkungan")
		+", proyek_kegiatan_aktifitas : '"+ rs.getString("proyek_kegiatan_aktifitas")
		+"', dikompilasi_oleh : '"+ rs.getString("dikompilasi_oleh")
		+"', tanggal_kompilasi : '"+ rs.getString("tanggal_kompilasi")
		+"', disetujui_oleh	: '"+ rs.getString("disetujui_oleh")
		+"', tanggal_disetujui : '"+ rs.getString("tanggal_disetujui")
		+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
