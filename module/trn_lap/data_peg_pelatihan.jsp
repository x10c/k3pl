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

	Statement	db_stmt_peg	= db_con.createStatement();
	Statement	db_stmt_trn	= db_con.createStatement();

	String		q
		,	o
		,	nipg;
	
	int		i = 0;

	q	=" select	a.nipg"
		+" ,		a.nama_pegawai"
		+" ,		a.id_jabatan"
		+" ,		b.nama_jabatan"
		+" from		r_pegawai as a, "
		+" 			r_jabatan as b "
		+" where	a.status_pegawai = '1' and a.id_jabatan = b.id_jabatan"
		+" order by	nama_pegawai";

	ResultSet rs = db_stmt_peg.executeQuery(q);

	o = "{ rows : [";
	while (rs.next()) {
		if (i > 0) {
			o += ",";
		} else {
			i = 1;
		}

		nipg	= rs.getString("nipg");

		o	+="{ nipg			:\""+ nipg +"\""
			+ ", nama_pegawai	:\""+ rs.getString("nama_pegawai") +"\""
			+ ", id_jabatan		: "+ rs.getString("id_jabatan")
			+ ", nama_jabatan	:\""+ rs.getString("nama_jabatan")+"\"";

		q	=" select	id_pelatihan"
			+" ,		replace(convert(varchar, tanggal, 111), '/', '-') tanggal"
			+" from		t_pelatihan"
			+" where	id in ("
			+"	select	id"
			+"	from	t_pelatihan_peserta"
			+"	where	nipg = '"+ nipg +"'"
			+")";

		ResultSet rs_trn = db_stmt_trn.executeQuery(q);

		while (rs_trn.next()) {
			o +=", "+ rs_trn.getString("id_pelatihan") +":'"+ rs_trn.getString("tanggal") +"' ";
		}

		o += "}";

		rs_trn.close();
	}
	o += "]}";

	out.print(o);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
