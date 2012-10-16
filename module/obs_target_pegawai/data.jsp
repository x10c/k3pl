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
	String year = (String) request.getParameter("year");

	db_stmt = db_con.createStatement();
	json_a	= new JSONArray ();

	if (year == null || year.isEmpty()) {
		out.print("{rows:"+ json_a +"}");
		return;
	}

	db_q=" select	C.nipg"
		+" ,		B.nama_pegawai"
		+" ,		isnull(A.jan,0) as jan"
		+" ,		isnull(A.feb,0) as feb"
		+" ,		isnull(A.mar,0) as mar"
		+" ,		isnull(A.apr,0) as apr"
		+" ,		isnull(A.may,0) as may"
		+" ,		isnull(A.jun,0) as jun"
		+" ,		isnull(A.jul,0) as jul"
		+" ,		isnull(A.aug,0) as aug"
		+" ,		isnull(A.sep,0) as sep"
		+" ,		isnull(A.oct,0) as oct"
		+" ,		isnull(A.nov,0) as nov"
		+" ,		isnull(A.dec,0) as dec"
		+" from"
		+" 		r_pegawai		B"
		+" ,	__user_grup		C"
		+" left join"
		+"		t_stop_target_pegawai	A"
		+"	on	C.nipg		= A.nipg"
		+"	and	A.year		= "+ year
		+" where	C.id_grup		= 2"
		+" and		C.nipg			= B.nipg";

	if (! "1".equals (user_group)) {
		db_q+=" and		B.id_divprosbu	= "+ user_div;
	}

	db_q+=" order by B.nama_pegawai";

	db_rs = db_stmt.executeQuery (db_q);

	while (db_rs.next()) {
		json_o = new JSONObject ();
		json_o.put ("nipg", db_rs.getString("nipg"));
		json_o.put ("name", db_rs.getString("nama_pegawai"));
		json_o.put ("jan", db_rs.getString("jan"));
		json_o.put ("feb", db_rs.getString("feb"));
		json_o.put ("mar", db_rs.getString("mar"));
		json_o.put ("apr", db_rs.getString("apr"));
		json_o.put ("may", db_rs.getString("may"));
		json_o.put ("jun", db_rs.getString("jun"));
		json_o.put ("jul", db_rs.getString("jul"));
		json_o.put ("aug", db_rs.getString("aug"));
		json_o.put ("sep", db_rs.getString("sep"));
		json_o.put ("oct", db_rs.getString("oct"));
		json_o.put ("nov", db_rs.getString("nov"));
		json_o.put ("dec", db_rs.getString("dec"));

		json_a.put (json_o);
	}

	db_rs.close ();
	db_stmt.close ();

	_return.put ("rows", json_a);
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
