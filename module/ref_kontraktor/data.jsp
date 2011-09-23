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

	Statement db_stmt = db_con.createStatement();

	q	=" select	id"
		+" ,		tipe"
		+" ,		nama"
		+" ,		alamat"
		+" ,		telp"
		+" ,		fax"
		+" ,		pemilik_nama"
		+" ,		pemilik_alamat"
		+" ,		asuransi_status"
		+" ,		asuransi_pj"
		+" ,		asuransi_alamat"
		+" ,		asuransi_telp"
		+" ,		penawar_nama"
		+" ,		penawar_jab"
		+" ,		penawar_telp"
		+" ,		penawar_fax"
		+" ,		pengisi_nama"
		+" ,		pengisi_jab"
		+" ,		pengisi_telp"
		+" ,		pengisi_fax"
		+" ,		klaim_status"
		+" ,		bangkrut_status"
		+" ,		bangkrut_detail"
		+" from		r_kontraktor";

	ResultSet	rs	= db_stmt.executeQuery(q);
	String		data= "[";
	int			i	= 0;

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		data+=	"[ "+ rs.getString("id")
			+	", "+ rs.getString("tipe")
			+	",'"+ rs.getString("nama") +"'"
			+	",'"+ rs.getString("alamat") +"'"
			+	",'"+ rs.getString("telp") +"'"
			+	",'"+ rs.getString("fax") +"'"
			+	",'"+ rs.getString("pemilik_nama") +"'"
			+	",'"+ rs.getString("pemilik_alamat") +"'"
			+	", "+ rs.getString("asuransi_status")
			+	",'"+ rs.getString("asuransi_pj") +"'"
			+	",'"+ rs.getString("asuransi_alamat") +"'"
			+	",'"+ rs.getString("asuransi_telp") +"'"
			+	",'"+ rs.getString("penawar_nama") +"'"
			+	", "+ rs.getString("penawar_jab")
			+	",'"+ rs.getString("penawar_telp") +"'"
			+	",'"+ rs.getString("penawar_fax") +"'"
			+	",'"+ rs.getString("pengisi_nama") +"'"
			+	", "+ rs.getString("pengisi_jab")
			+	",'"+ rs.getString("pengisi_telp") +"'"
			+	",'"+ rs.getString("pengisi_fax") +"'"
			+	", "+ rs.getString("klaim_status")
			+	", "+ rs.getString("bangkrut_status")
			+	",'"+ rs.getString("bangkrut_detail") +"'"
			+	"]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
