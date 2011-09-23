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

	String		id_lingkungan_bulanan_detail	= request.getParameter("id_lingkungan_bulanan_detail");
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	id_lingkungan_bulanan_detail "
	+" ,		tahun "
	+" ,		bulan "
	+" ,		tipe_kegiatan "
	+" ,		nama_kegiatan "
	+" ,		replace(convert(varchar, tanggal_awal, 111), '/', '-') tanggal_awal "
	+" ,		replace(convert(varchar, tanggal_akhir, 111), '/', '-') tanggal_akhir "
	+" ,		uraian_kegiatan "
	+" ,		keterangan "
	+" from		t_lingkungan_bulanan_detail "
	+" where	id_lingkungan_bulanan_detail	= "+ id_lingkungan_bulanan_detail;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Lingkungan tidak ditemukan!'}");
		return;
	}

	data	="{ id_lingkungan_bulanan_detail : "+ id_lingkungan_bulanan_detail
		+", tahun : "+ rs.getString("tahun")
		+", bulan : "+ rs.getString("bulan")
		+", tipe_kegiatan : "+ rs.getString("tipe_kegiatan")
		+", nama_kegiatan : '"+ rs.getString("nama_kegiatan")
		+"', tanggal_awal : '"+ rs.getString("tanggal_awal")
		+"', tanggal_akhir : '"+ rs.getString("tanggal_akhir")
		+"', uraian_kegiatan : '"+ rs.getString("uraian_kegiatan")
		+"', keterangan : '"+ rs.getString("keterangan")
		+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
