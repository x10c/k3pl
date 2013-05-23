<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
	- agus sugianto (agus.delonge@gmail.com)
--%>

<%@ include file="../modinit.jsp"%>
<%
String	q2			= "";
String	months[]	= {	"jan", "feb", "mar", "apr"
			,	"may", "jun", "jul", "aug"
			,	"sep", "oct", "nov", "dec"
			};

try {
	Statement	db_stmt2	= db_con.createStatement();
	ResultSet	db_rs2		= null;
	JSONArray	data		= null;
	String		id_dir;
	String		id_div;
	String		id_dep;
	String		id_dinas;
	String		id_seksi;
	String		id_wilayah;
	String		id_area;
	String		year;
	String		nipg;
	int			hide_inaktif	= ServletUtilities.getIntParameter (request, "hide_inaktif", 1);
	int			i;

	id_dir		= request.getParameter("id_dir");
	id_div		= request.getParameter("id_div");
	id_dep		= request.getParameter("id_dep");
	id_dinas	= request.getParameter("id_dinas");
	id_seksi	= request.getParameter("id_seksi");
	id_wilayah	= request.getParameter("id_wilayah");
	id_area		= request.getParameter("id_area");
	year		= request.getParameter("year");

	db_q=" select	B.nipg"
		+" ,		B.nama_pegawai"
		+" ,		B.id_direktorat"
		+" ,		B.id_divprosbu"
		+" ,		B.id_departemen"
		+" ,		B.id_dinas"
		+" ,		B.id_seksi"
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
		+" 			r_pegawai				B"
		+" ,		r_seksi					D"
		+" ,		t_rca_target_pegawai	A"
		+"	,		__user					U"
		+"	,		__user_grup				E"
		+"	,		__grup_user				F"
		+" where	B.nipg					= A.nipg"
		+" and		A.year					= "+ year
		+" and		B.id_seksi				= D.id_seksi"
		+" and		B.nipg					= U.nipg"
		+" and		U.nipg					= E.nipg"
		+" and		E.id_grup				= F.id_grup"
		+" and		F.id_grup				= 5";

	if (id_dir != null
	&& !(id_dir.equals ("0") || id_dir.equals (""))) {
		db_q += " and B.id_direktorat = "+ id_dir;
	}
	if (id_div != null
	&& !(id_div.equals ("0") || id_div.equals (""))) {
		db_q += " and B.id_divprosbu = "+ id_div;
	}
	if (id_dep != null
	&& !(id_dep.equals("0") || id_dep.equals(""))) {
		db_q += " and	B.id_departemen	= "+ id_dep;
	}
	if (id_dinas != null
	&& !(id_dinas.equals("0") || id_dinas.equals(""))) {
		db_q += " and	B.id_dinas	= "+ id_dinas;
	}
	if (id_seksi != null
	&& !(id_seksi.equals("0") || id_seksi.equals(""))) {
		db_q += " and	B.id_seksi	= "+ id_seksi;
	}
	if (id_wilayah != null
	&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
		db_q += " and	D.id_wilayah	= "+ id_wilayah;
	}
	if (id_area != null
	&& !(id_area.equals("0") || id_area.equals(""))) {
		db_q += " and	B.id_seksi	= "+ id_area;
	}
	if (1 == hide_inaktif) {
		db_q	+=" and		U.status_user			= 1"
				+" and		B.status_pegawai		= 1";
	}

	db_q	+=" order by B.nama_pegawai";

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);
	json_a	= new JSONArray ();

	while (db_rs.next()) {
		data	= new JSONArray ();
		nipg	= db_rs.getString ("nipg");
		data.put (db_rs.getString ("nama_pegawai"));
		data.put (db_rs.getString ("id_direktorat"));
		data.put (db_rs.getString ("id_divprosbu"));
		data.put (db_rs.getString ("id_departemen"));
		data.put (db_rs.getString ("id_dinas"));
		data.put (db_rs.getString ("id_seksi"));

		for (i = 0; i < months.length; i++) {
			data.put (db_rs.getInt (months[i]));
		}

		for (i = 0; i < months.length; i++) {
			q2	=" select	count(a.nipg) 	as v"
				+" from		t_rca_auditor	as a"
				+" ,		t_rca			as b"
				+" where	a.nipg					= '"+ nipg +"'"
				+" and		a.id_rca				= b.id_rca"
				+" and		year(b.tanggal_rca)		= "+ year
				+" and		month(b.tanggal_rca)	= "+ (i + 1);

			db_rs2 = db_stmt2.executeQuery(q2);

			if (! db_rs2.next()) {
				data.put (0);
			} else {
				data.put (db_rs2.getInt ("v"));
			}

			db_rs2.close();
		}

		data.put (0);
		data.put (0);

		json_a.put (data);
	}

	db_rs.close();
	db_stmt.close ();
	db_stmt2.close ();

	out.print (json_a);

} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
