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

	String		id_rca = (String) request.getParameter("id_rca");
	ResultSet	rs;
	String		q;
	String		data;
	int		i	= 0;

	q=" select	replace(convert(varchar, tanggal_rca, 111), '/', '-') tanggal_rca "
	+" ,		auditor_departemen "
	+" ,		auditor_dinas "
	+" ,		auditor_seksi "
	+" ,		nama_tempat_rca "
	+" ,		penanggung_jawab_departemen "
	+" ,		penanggung_jawab_dinas "
	+" ,		penanggung_jawab_seksi "
	+" ,		penanggung_jawab_nipg "
	+" ,		waktu_audit "
	+" ,		lama_audit "
	+" ,		cuaca "
	+" from		t_rca "
	+" where	id_rca	= "+ id_rca;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data RCA tidak ditemukan!'}");
		return;
	}

	data	="{  id_rca	: '"+ id_rca
		+"', tanggal_rca	: '"+ rs.getString("tanggal_rca")
		+"', auditor_departemen	: '"+ rs.getString("auditor_departemen")
		+"', auditor_dinas : '"+ rs.getString("auditor_dinas")
		+"', auditor_seksi : '"+ rs.getString("auditor_seksi")
		+"', nama_tempat_rca : '"+ rs.getString("nama_tempat_rca")
		+"', penanggung_jawab_departemen : '"+ rs.getString("penanggung_jawab_departemen")
		+"', penanggung_jawab_dinas	: '"+ rs.getString("penanggung_jawab_dinas")
		+"', penanggung_jawab_seksi	: '"+ rs.getString("penanggung_jawab_seksi")
		+"', penanggung_jawab_nipg	: '"+ rs.getString("penanggung_jawab_nipg")
		+"', waktu_audit : '"+ rs.getString("waktu_audit")
		+"', lama_audit : '"+ rs.getString("lama_audit")
		+"', cuaca : '"+ rs.getString("cuaca")+"'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
