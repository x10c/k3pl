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
	String		id_user = (String) session.getAttribute("user.nipg");

	int			dml						= Integer.parseInt(request.getParameter("dml_type"));
	String		id_lingkungan_tahunan	= request.getParameter("id_lingkungan_tahunan");
	String		id_komponen_lingkungan	= request.getParameter("id_komponen_lingkungan");
	String		lokasi_dampak			= request.getParameter("lokasi_dampak");
	String		jenis_dampak			= request.getParameter("jenis_dampak");
	String		sumber_dampak			= request.getParameter("sumber_dampak");
	String		parameter_pemantauan	= request.getParameter("parameter_pemantauan");
	String		baku_mutu_pemantauan	= request.getParameter("baku_mutu_pemantauan");
	String		periode_pemantauan		= request.getParameter("periode_pemantauan");
	String		hasil_pemantauan		= request.getParameter("hasil_pemantauan");
	String		penanggung_jawab		= request.getParameter("penanggung_jawab");
	
	String		q 		= "";

	switch (dml) {
	case 2:
		q	=" insert into t_lingkungan_detail (id_lingkungan_tahunan, id_komponen_lingkungan, lokasi_dampak, jenis_dampak,"
			+" sumber_dampak, parameter_pemantauan, baku_mutu_pemantauan, periode_pemantauan,"
			+" hasil_pemantauan, penanggung_jawab, id_user)"
			+" values ("+ id_lingkungan_tahunan +", "+ id_komponen_lingkungan +", '"+ lokasi_dampak +"', '"+ jenis_dampak +"',"
			+" '"+ sumber_dampak +"', '"+ parameter_pemantauan +"', '"+ baku_mutu_pemantauan +"', '"+ periode_pemantauan +"',"
			+" '"+ hasil_pemantauan +"', '"+ penanggung_jawab +"', '"+ id_user + "')";

		break;
	case 3:
		q	=" update t_lingkungan_detail "
			+" set "
			+"   lokasi_dampak			= '"+ lokasi_dampak + "'"
			+" , jenis_dampak			= '"+ jenis_dampak + "'"
			+" , sumber_dampak			= '"+ sumber_dampak + "'"
			+" , parameter_pemantauan	= '"+ parameter_pemantauan +"' "
			+" , baku_mutu_pemantauan	= '"+ baku_mutu_pemantauan +"' "
			+" , periode_pemantauan		= '"+ periode_pemantauan +"' "
			+" , hasil_pemantauan		= '"+ hasil_pemantauan +"' "
			+" , penanggung_jawab		= '"+ penanggung_jawab +"' "
			+" , id_user				= '"+ id_user +"' "
			+" , tanggal_akses			= getdate() "
			+" where	id_lingkungan_tahunan	=  "+ id_lingkungan_tahunan
			+" and		id_komponen_lingkungan	=  "+ id_komponen_lingkungan;
			
		break;
	case 4:
		q	=" delete from t_lingkungan_detail "
			+" where 	id_lingkungan_tahunan	=  "+ id_lingkungan_tahunan
			+" and		id_komponen_lingkungan	=  "+ id_komponen_lingkungan;

		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
