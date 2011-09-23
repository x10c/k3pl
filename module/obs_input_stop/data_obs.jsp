<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	Statement	db_stmt2= db_con.createStatement();

	String		id_stop = (String) request.getParameter("id_stop");
	ResultSet	rs;
	ResultSet	rs2;
	String		q;
	String		n_obs;
	String		safe, unsafe;
	JSONObject	data	= new JSONObject();
	JSONArray	details	= new JSONArray();
	JSONObject	detail;
	int		i	= 0;

	q=" select	A.nipg "
	+" ,		B.nama_pegawai "
	+" ,		A.id_area_seksi "
	+" ,		replace(convert(varchar, A.tanggal, 111), '/', '-') tanggal "
	+" ,		A.site "
	+" ,		A.shift "
	+" ,		A.lama_observasi "
	+" ,		A.jml_org_observasi "
	+" ,		A.jml_org_diskusi "
	+" ,		A.tindakan_aman_diamati "
	+" ,		A.tindakan_tidak_aman_diamati "
	+" ,		A.status_aktif "
	+" from		t_stop		A "
	+" ,		r_pegawai	B "
	+" where	A.nipg		= B.nipg "
	+" and		A.id_stop	= "+ id_stop;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data observasi tidak ditemukan!'}");
		return;
	}

	n_obs	= rs.getString("jml_org_observasi");

	data.put("id_stop", id_stop);
	data.put("nipg", rs.getString("nipg"));
	data.put("nama_pegawai", rs.getString("nama_pegawai"));
	data.put("id_area_seksi", rs.getString("id_area_seksi"));
	data.put("tanggal", rs.getString("tanggal"));
	data.put("site", rs.getString("site"));
	data.put("shift", rs.getString("shift"));
	data.put("lama_observasi", rs.getString("lama_observasi"));
	data.put("jml_org_observasi", n_obs);
	data.put("jml_org_diskusi", rs.getString("jml_org_diskusi"));
	data.put("safe", rs.getString("tindakan_aman_diamati"));
	data.put("unsafe", rs.getString("tindakan_tidak_aman_diamati"));
	data.put("status_aktif", rs.getString("status_aktif"));

	q=" select	id_kel_tipe_observasi"
	+" ,		id_tipe_observasi"
	+" ,		id_detail_tipe_observasi"
	+" ,		jumlah_safe"
	+" ,		jumlah_unsafe"
	+" from		t_stop_detail"
	+" where	id_stop = "+ id_stop;

	rs2 = db_stmt2.executeQuery(q);

	while (rs2.next()) {
		detail	= new JSONObject();

		detail.put("kel_id", rs2.getString("id_kel_tipe_observasi"));
		detail.put("tipe_id", rs2.getString("id_tipe_observasi"));
		detail.put("detail_id", rs2.getString("id_detail_tipe_observasi"));
		detail.put("safe", rs2.getString("jumlah_safe"));
		detail.put("unsafe", rs2.getString("jumlah_unsafe"));

		details.put(detail);
	}

	data.put("details", details);

	rs.close();
	rs2.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
