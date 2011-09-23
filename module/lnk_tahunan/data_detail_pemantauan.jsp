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

	String		id_lingkungan_tahunan	= request.getParameter("id_lingkungan_tahunan");
	String		id_komponen_lingkungan	= request.getParameter("id_komponen_lingkungan");
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	id_lingkungan_tahunan "
	+" ,		id_komponen_lingkungan "
	+" ,		lokasi_dampak "
	+" ,		jenis_dampak "
	+" ,		sumber_dampak "
	+" ,		parameter_pemantauan "
	+" ,		baku_mutu_pemantauan "
	+" ,		periode_pemantauan "
	+" ,		hasil_pemantauan "
	+" ,		penanggung_jawab "
	+" from		t_lingkungan_detail "
	+" where	id_lingkungan_tahunan	= "+ id_lingkungan_tahunan
	+" and		id_komponen_lingkungan	= "+ id_komponen_lingkungan;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Lingkungan tidak ditemukan!'}");
		return;
	}

	data	="{ id_lingkungan_tahunan : "+ id_lingkungan_tahunan
		+", id_komponen_lingkungan : "+ rs.getString("id_komponen_lingkungan")
		+", lokasi_dampak : '"+ rs.getString("lokasi_dampak")
		+"', jenis_dampak : '"+ rs.getString("jenis_dampak")
		+"', sumber_dampak : '"+ rs.getString("sumber_dampak")
		+"', parameter_pemantauan : '"+ rs.getString("parameter_pemantauan")
		+"', baku_mutu_pemantauan : '"+ rs.getString("baku_mutu_pemantauan")
		+"', periode_pemantauan	: '"+ rs.getString("periode_pemantauan")
		+"', hasil_pemantauan : '"+ rs.getString("hasil_pemantauan")
		+"', penanggung_jawab : '"+ rs.getString("penanggung_jawab")
		+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
