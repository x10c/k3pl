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

	String q=" select	A.nipg "
		+" ,		B.nama_klasifikasi_pegawai "
		+" ,		C.nama_jabatan "
		+" ,		isnull(D.nama_departemen, '') nama_departemen "
		+" ,		isnull(E.nama_dinas, '') nama_dinas "
		+" ,		isnull(F.nama_seksi, '') nama_seksi "
		+" ,		A.nama_pegawai "
		+" ,		A.email "
		+" ,		A.status_pegawai "
		+" from		r_pegawai		A "
		+" left join "
		+" 		r_klasifikasi_pegawai	B  on B.id_klasifikasi_pegawai = A.id_klasifikasi_pegawai "
		+" left join "
		+" 		r_jabatan C on C.id_jabatan = A.id_jabatan "
		+" left join "
		+" 		r_departemen D on D.id_Departemen = A.id_departemen "
		+" left join "
		+" 		r_dinas E on E.id_dinas = A.id_dinas "
		+" left join "
		+" 		r_seksi F on F.id_seksi = A.id_seksi "
		+" where A.status_pegawai = '1' "
		+" order by	A.nipg";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "{ rows: [";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ nipg			: '"+ rs.getString("nipg") +"' "
			+ ", nama_klasifikasi_pegawai	: '"+ rs.getString("nama_klasifikasi_pegawai") +"' "
			+ ", nama_jabatan			: '"+ rs.getString("nama_jabatan") +"' "
			+ ", nama_departemen		: '"+ rs.getString("nama_departemen") +"' "
			+ ", nama_dinas			: '"+ rs.getString("nama_dinas") +"' "
			+ ", nama_seksi			: '"+ rs.getString("nama_seksi") +"' "
			+ ", nama_pegawai		: '"+ rs.getString("nama_pegawai") +"' "
			+ ", email			: '"+ rs.getString("email") +"' "
			+ ", status_pegawai		: '"+ rs.getString("status_pegawai") +"' "
			+  "}";
	}

	data += "]}";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
