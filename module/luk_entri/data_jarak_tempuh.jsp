<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	String		year		= (String) request.getParameter("year");
	String		data		= "{rows:[";
	int		month		= Integer.parseInt((String) request.getParameter("month"));
	int		month_before	= month - 1;

	if (year == null || year.isEmpty()) {
		data += "]}";
		out.print(data);
		return;
	}

	q	=" select	Y.id_klasifikasi_pegawai"
		+" ,		Y.nama_klasifikasi_pegawai"
		+" ,		X.jml_jt_bulan_lalu"
		+" ,		Y.jml_jt_bulan_skrg"
		+" ,		X.jml_jta_bulan_lalu"
		+" ,		Y.jml_jta_bulan_skrg"
		+" from ("
		+" 	select	B.id_klasifikasi_pegawai"
		+" 	,	B.nama_klasifikasi_pegawai"
		+" 	,	isnull(A.tahun,"+ year +")		as tahun"
		+" 	,	isnull(A.bulan,"+ month_before +")	as bulan"
		+" 	,	isnull(A.jml_jarak_tempuh, 0)		as jml_jt_bulan_lalu"
		+" 	,	isnull(A.jml_jarak_tempuh_aman, 0)	as jml_jta_bulan_lalu"
		+" 	from		t_unjuk_kerja		A"
		+" 	right join	r_klasifikasi_pegawai	B"
		+" 	on		A.id_klasifikasi_pegawai= B.id_klasifikasi_pegawai"
		+" 	and		A.tahun			= "+ year
		+" 	and		(A.bulan		= "+ month_before +")"
		+" ) X"
		+" right join ("
		+" 	select	B.id_klasifikasi_pegawai"
		+" 	,	B.nama_klasifikasi_pegawai"
		+" 	,	isnull(A.tahun,"+ year +")		as tahun"
		+" 	,	isnull(A.bulan,"+ month +")		as bulan"
		+" 	,	isnull(A.jml_jarak_tempuh, 0)		as jml_jt_bulan_skrg"
		+" 	,	isnull(A.jml_jarak_tempuh_aman, 0)	as jml_jta_bulan_skrg"
		+" 	from		t_unjuk_kerja		A"
		+" 	right join	r_klasifikasi_pegawai	B"
		+" 	on	A.id_klasifikasi_pegawai= B.id_klasifikasi_pegawai"
		+" 	and	A.tahun			= "+ year
		+" 	and	(A.bulan		= "+ month +")"
		+" ) Y"
		+" on	X.id_klasifikasi_pegawai= Y.id_klasifikasi_pegawai"
		+" and	X.tahun			= Y.tahun";

	ResultSet rs = db_stmt.executeQuery(q);

	int i = 0;
	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		
		data	+="{  id			:'"+ rs.getString("id_klasifikasi_pegawai")
			+ "', name			:'"+ rs.getString("nama_klasifikasi_pegawai")
			+ "', jml_jt_bulan_lalu		: "+ rs.getString("jml_jt_bulan_lalu")
			+ " , jml_jarak_tempuh		: "+ rs.getString("jml_jt_bulan_skrg")
			+ " , jml_jta_bulan_lalu	: "+ rs.getString("jml_jta_bulan_lalu")
			+ " , jml_jarak_tempuh_aman	: "+ rs.getString("jml_jta_bulan_skrg")
			+ "}";
	}
	data += "]}";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
