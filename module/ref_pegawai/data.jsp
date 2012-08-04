<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	JSONArray	peg		= null;
	String		nipg	= request.getParameter ("nipg");
	String		start	= request.getParameter("start");
	String		end		= request.getParameter("end");

	db_stmt = db_con.createStatement();

	db_q=" select	nipg"
		+" ,		id_klasifikasi_pegawai"
		+" ,		id_jabatan"
		+" ,		id_direktorat"
		+" ,		id_divprosbu"
		+" ,		id_departemen"
		+" ,		id_dinas"
		+" ,		id_seksi"
		+" ,		nama_pegawai"
		+" ,		email"
		+" ,		status_pegawai"
		+" from		r_pegawai";

	if (null != nipg) {
		db_q +=" where nipg = '"+ nipg +"'";
	} else {
		if (! "1".equals (user_group)) {
			db_q+=" where	id_direktorat	= "+ user_dir
				+ " and		id_divprosbu	= "+ user_div;
		}
	}

	db_q	+= " order by	nama_pegawai";

	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();
	while (db_rs.next()) {
		peg = new JSONArray ();
		peg.put (db_rs.getString ("nipg"));
		peg.put (db_rs.getString ("id_klasifikasi_pegawai"));
		peg.put (db_rs.getString ("id_jabatan"));
		peg.put (db_rs.getString ("id_direktorat"));
		peg.put (db_rs.getString ("id_divprosbu"));
		peg.put (db_rs.getString ("id_departemen"));
		peg.put (db_rs.getString ("id_dinas"));
		peg.put (db_rs.getString ("id_seksi"));
		peg.put (db_rs.getString ("nama_pegawai"));
		peg.put (db_rs.getString ("email"));
		peg.put (db_rs.getString ("status_pegawai"));

		json_a.put (peg);
	}

	out.print (json_a);

	db_rs.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
