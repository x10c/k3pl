<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
String	q		= "";
String	q2		= "";
String	months[]	= {	"jan", "feb", "mar", "apr"
			,	"may", "jun", "jul", "aug"
			,	"sep", "oct", "nov", "dec"
			};

try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt	= db_con.createStatement();
	Statement	db_stmt2= db_con.createStatement();
	ResultSet	rs;
	ResultSet	rs2;
	String		id_dir;
	String		id_div;
	String		id_dep;
	String		id_dinas;
	String		id_seksi;
	String		id_wilayah;
	String		id_area;
	String		year;
	String		data	= "[";
	String		nipg;
	int			i,x;

	id_dir		= request.getParameter("id_dir");
	id_div		= request.getParameter("id_div");
	id_dep		= request.getParameter("id_dep");
	id_dinas	= request.getParameter("id_dinas");
	id_seksi	= request.getParameter("id_seksi");
	id_wilayah	= request.getParameter("id_wilayah");
	id_area		= request.getParameter("id_area");
	year		= request.getParameter("year");

	q	=" select	C.nipg"
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
		+" 			r_pegawai		B"
		+" ,		r_seksi			D"
		+" ,		__user_grup		C"
		+" left join	t_rca_target_pegawai	A"
		+"	on	C.nipg		= A.nipg"
		+"	and	A.year		= "+ year
		+" where	C.id_grup			= 5"
		+" and		C.nipg				= B.nipg"
		+" and		B.id_seksi			= D.id_seksi";

	if (id_dir != null
	&& !(id_dir.equals ("0") || id_dir.equals (""))) {
		q += " and B.id_direktorat = "+ id_dir;
	}
	if (id_div != null
	&& !(id_div.equals ("0") || id_div.equals (""))) {
		q += " and B.id_divprosbu = "+ id_div;
	}
	if (id_dep != null
	&& !(id_dep.equals("0") || id_dep.equals(""))) {
		q += " and	B.id_departemen	= "+ id_dep;
	}
	if (id_dinas != null
	&& !(id_dinas.equals("0") || id_dinas.equals(""))) {
		q += " and	B.id_dinas	= "+ id_dinas;
	}
	if (id_seksi != null
	&& !(id_seksi.equals("0") || id_seksi.equals(""))) {
		q += " and	B.id_seksi	= "+ id_seksi;
	}
	if (id_wilayah != null
	&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
		q += " and	D.id_wilayah	= "+ id_wilayah;
	}
	if (id_area != null
	&& !(id_area.equals("0") || id_area.equals(""))) {
		q += " and	B.id_seksi	= "+ id_area;
	}

	rs = db_stmt.executeQuery(q);

	x = 0;
	while (rs.next()) {
		if (x > 0) {
			data += ",";
		} else {
			x = 1;
		}

		nipg	= rs.getString("nipg");
			

		data	+="["
			+"\""+ rs.getString("nama_pegawai") +"\""
			+",'"+ rs.getString("id_direktorat") +"'"
			+",'"+ rs.getString("id_divprosbu") +"'"
			+",'"+ rs.getString("id_departemen") +"'"
			+",'"+ rs.getString("id_dinas") +"'"
			+",'"+ rs.getString("id_seksi") +"'"
			;

		for (i = 0; i < months.length; i++) {
			data	+=","+ rs.getString(months[i]);
		}

		for (i = 0; i < months.length; i++) {
			q2	=" select	count(a.nipg) 	as v"
				+" from		t_rca_auditor	as a"
				+" ,		t_rca			as b"
				+" where	a.nipg					= '"+ nipg +"'"
				+" and		a.id_rca				= b.id_rca"
				+" and		a.status				in (1,2)"
				+" and		year(b.tanggal_rca)		= "+ year
				+" and		month(b.tanggal_rca)	= "+ (i + 1);

			rs2 = db_stmt2.executeQuery(q2);

			if (!rs2.next()) {
				data += ",0";
			} else {
				data += ","+ rs2.getString("v");
			}

			rs2.close();
		}

		data +=",0,0]";
	}
	data += "]";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
