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
String q = "";
String o = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		nipg		= request.getParameter("nipg");
	String		date_bgn	= request.getParameter("date_begin");
	String		date_end	= request.getParameter("date_end");
	String		q_org;
	String		q_id;
	int		i = 0;

	q_org	=" select	nipg"
			+" from		r_pegawai"
			+" where	1=1";

	if (id_dep != null && !(id_dep.equals("") || id_dep.equals("0"))) {
		q_org +=" and id_departemen = "+ id_dep;
	}
	if (id_dinas != null && !(id_dinas.equals("") || id_dinas.equals("0"))) {
		q_org +=" and id_dinas = "+ id_dinas;
	}
	if (id_seksi != null && !(id_seksi.equals("") || id_seksi.equals("0"))) {
		q_org +=" and id_seksi = "+ id_seksi;
	}

	q_id
=" select	B.id"
+" ,		A.nama_pelatihan"
+" ,		replace(convert(varchar, B.tanggal, 111), '/', '-') tanggal"
+" ,		B.tempat"
+" ,		B.lama"
+" from		r_pelatihan	A"
+" ,		t_pelatihan	B"
+" where	B.id_pelatihan	= A.id_pelatihan";

	if (date_bgn != null && !date_bgn.equals("")) {
		q_id	+=" and	B.tanggal >= '"+ date_bgn +"'";
	}
	if (date_end != null && !date_end.equals("")) {
		q_id	+=" and	B.tanggal <= '"+ date_end +"'";
	}

	if (nipg != null && !nipg.equals("")) {
		q_id	+=" and	B.id in ("
			+" 	select	id"
			+" 	from	t_pelatihan_peserta"
			+" 	where	nipg = '"+ nipg +"'"
			+" )";
	}

	if (id_dep != null && !(id_dep.equals("") || id_dep.equals("0"))) {
		q_id	+=" and	B.id in ("
			+ "	select	id"
			+ "	from	t_pelatihan_peserta"
			+ "	where	nipg in ("+ q_org +")"
			+ ")";
	}

	q	=" select	X.nipg"
		+" ,		Y.nama_pegawai"
		+" ,		Y.id_departemen"
		+" ,		Y.id_dinas"
		+" ,		Y.id_seksi"
		+" ,		Z.nama_pelatihan"
		+" ,		Z.tanggal"
		+" ,		Z.tempat"
		+" ,		Z.lama"
		+" from	t_pelatihan_peserta	X"
		+" ,	r_pegawai		Y"
		+" ,("+ q_id +") Z"
		+" where	Z.id	= X.id"
		+" and		X.nipg	= Y.nipg";

	if (nipg == null || nipg.equals("")) {
		q +=" and	X.nipg in ("+ q_org +")";
	}

	if (nipg != null && !nipg.equals("")) {
		q +=" and	X.nipg = '"+ nipg +"'";
	}

	ResultSet rs = db_stmt.executeQuery(q);

	o = "{rows:[";
	while (rs.next()) {
		if (i > 0) {
			o += ",";
		} else {
			i = 1;
		}

		o	+="{nipg:\""+ rs.getString("nipg")			+"\""
			+ ",name:\""+ rs.getString("nama_pegawai")	+"\""
			+ ",id_dep:"+ rs.getString("id_departemen")
			+ ",id_dinas:"+ rs.getString("id_dinas")
			+ ",id_seksi:"+ rs.getString("id_seksi")
			+ ",nama_pelatihan:\""+ rs.getString("nama_pelatihan")	+"\""
			+ ",tanggal:\""+ rs.getString("tanggal")		+"\""
			+ ",tempat:\""+ rs.getString("tempat")			+"\""
			+ ",lama:"+ rs.getString("lama")
			+ "}";
	}
	rs.close();

	o += "]}";

	out.print(o);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
