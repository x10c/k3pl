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
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();

	String q=" select	A.id_insiden"
		+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal"
		+" ,		B.nama_seksi as nama_area"
		+" ,		D.nama_klasifikasi_pegawai"
		+" ,		A.jml_korban_mati"
		+" ,		A.status_reset"
		+" from		t_insiden		A"
		+" ,		r_seksi			B"
		+" ,		r_klasifikasi_pegawai	D"
		+" where	(A.jml_korban_mati	> 0"
		+" or		A.jml_korban_berat	> 0"
		+" or		A.jml_korban_sedang	> 0)"
		+" and		A.id_area_seksi		= B.id_seksi"
		+" and		A.id_klasifikasi_pegawai= D.id_klasifikasi_pegawai"
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
			+  "','"+ rs.getString("jml_korban_mati")
			+  "',"+ rs.getString("status_reset")
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
