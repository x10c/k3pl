<%--
 % Copyright 2013 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String	q		= "";
String	q2		= "";
String	months[]	= {	"jan", "feb", "mar", "apr"
			,	"may", "jun", "jul", "aug"
			,	"sep", "oct", "nov", "dec"
			};

String	d1;
String	d2;

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
	String		data	= "[";
	String		nipg;
	int			i,x;
	int			year;
	int			month;

	id_dir		= request.getParameter("id_dir");
	id_div		= request.getParameter("id_div");
	id_dep		= request.getParameter("id_dep");
	id_dinas	= request.getParameter("id_dinas");
	id_seksi	= request.getParameter("id_seksi");
	id_wilayah	= request.getParameter("id_wilayah");
	id_area		= request.getParameter("id_area");
	year		= Integer.parseInt (request.getParameter("year"));

	q	=" select	B.nipg"
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
		+" 		r_pegawai		B"
		+" ,	r_seksi			D"
		+" ,	t_stop_target_pegawai	A"
		+" where	B.nipg		= A.nipg"
		+" and		A.year		= "+ year
		+" and		B.id_seksi			= D.id_seksi"
		+" and		B.status_pegawai	= '1'";

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

	q +=" order by B.nama_pegawai";

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
			month = i + 1;
			if (month == 1) {
				d1 = (year - 1) +"-12-25";
				d2 = year +"-"+ month +"-24";
			} else {
				d1 = year +"-"+ (month - 1) +"-25";
				d2 = year +"-"+ month +"-24";
			}
			q2	=" select	count(id_stop) as v"
				+" from		t_stop"
				+" where	nipg			='"+ nipg +"'"
				+" and		status_aktif	= '1'"
				+" and		status			in (1,2)"
				+" and		tanggal			>= cast ('"+ d1 +"' as datetime)"
				+" and		tanggal			<= cast ('"+ d2 +"' as datetime)";

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
