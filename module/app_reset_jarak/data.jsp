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
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();

	String q=" select	A.id_insiden"
		+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal"
		+" ,		B.nama_seksi as nama_area"
		+" ,		D.nama_klasifikasi_pegawai"
		+" ,		A.jml_kecelakaan_kendaraan"
		+" ,		A.status_reset_jarak"
		+" from		t_insiden		A"
		+" ,		r_seksi			B"
		+" ,		r_klasifikasi_pegawai	D"
		+" where	A.jml_kecelakaan_kendaraan	> 0"
		+" and		A.nilai_rusak_kendaraan		>= 10000000"
		+" and		A.id_area_seksi			= B.id_seksi"
		+" and		A.id_klasifikasi_pegawai	= D.id_klasifikasi_pegawai"
		+" order by	A.tanggal desc ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_insiden")
			+  "','"+ rs.getString("tanggal")
			+  "','"+ rs.getString("nama_area")
			+  "','"+ rs.getString("nama_klasifikasi_pegawai")
			+  "','"+ rs.getString("jml_kecelakaan_kendaraan")
			+  "',"+ rs.getString("status_reset_jarak")
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
