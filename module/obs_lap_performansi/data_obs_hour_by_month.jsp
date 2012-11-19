<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %
 % WARNING: This script is used by charts module.
--%>

<%@ page import="java.sql.*" %>
<%
String	q_sum	= "";
String	q_time	= "";
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	stmt	= db_con.createStatement();

	ResultSet	rs		= null;
	String		data	= "[";
	String		q		= "";
	int			i;

	String		id_dir		= request.getParameter("id_dir");
	String		id_div		= request.getParameter("id_div");
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		id_wilayah	= request.getParameter("id_wilayah");
	String		id_area		= request.getParameter("id_area");
	String		year		= request.getParameter("year");
	String		months[]	= {
				 "Januari"	,"Februari"	,"Maret"
				,"April"	,"Mei"		,"Juni"
				,"Juli"		,"Agustus"	,"September"
				,"October"	, "November"	, "Desember"
			};

	q_sum	=" select	isnull(sum(B.jumlah_safe),0)	sum_safe"
			+" ,		isnull(sum(B.jumlah_unsafe),0)	sum_unsafe"
			+" from"
			+" 			t_stop			A"
			+" ,		t_stop_detail	B"
			+" ,		r_seksi			C"
			+" where 	A.id_stop		= B.id_stop"
			+" and		A.status_aktif	= '1'"
			+" and		A.year			= "+ year
			+" and		A.id_seksi		= C.id_seksi"
			+" and		A.id_dinas		= C.id_dinas"
			+" and		A.id_departemen	= C.id_departemen"
			+" and		A.id_divprosbu	= C.id_divprosbu"
			+" and		A.id_direktorat	= C.id_direktorat";

	q_time	=" select	(isnull(sum(A.lama_observasi), 0)) as v"
			+" from		t_stop			A"
			+" ,		r_seksi			C"
			+" where	A.status_aktif	= '1'"
			+" and		A.year			= "+ year;

	if (id_dir != null
	&& !(id_dir.equals("0") || id_dir.equals(""))) {
		q_sum	+=" and A.id_direktorat = "+ id_dir;
		q_time	+=" and A.id_direktorat = "+ id_dir;
	}
	if (id_div != null
	&& !(id_div.equals("0") || id_div.equals(""))) {
		q_sum	+=" and A.id_divprosbu = "+ id_div;
		q_time	+=" and A.id_divprosbu = "+ id_div;
	}
	if (id_dep != null
	&& !(id_dep.equals("0") || id_dep.equals(""))) {
		q_sum	+=" and A.id_departemen = "+ id_dep;
		q_time	+=" and A.id_departemen = "+ id_dep;
	}
	if (id_dinas != null
	&& !(id_dinas.equals("0") || id_dinas.equals(""))) {
		q_sum	+=" and A.id_dinas = "+ id_dinas;
		q_time	+=" and A.id_dinas = "+ id_dinas;
	}
	if (id_seksi != null
	&& !(id_seksi.equals("0") || id_seksi.equals(""))) {
		q_sum	+=" and	A.id_seksi = "+ id_seksi;
		q_time	+=" and	A.id_seksi = "+ id_seksi;
	}

	if (id_wilayah != null
	&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
		q_sum	+=" and	A.id_seksi = C.id_seksi and C.id_wilayah = "+ id_wilayah;
		q_time	+=" and	A.id_seksi = C.id_seksi and C.id_wilayah = "+ id_wilayah;
	}
	if (id_area != null
	&& !(id_area.equals("0") || id_area.equals(""))) {
		q_sum	+=" and	A.id_seksi = "+ id_area;
		q_time	+=" and	A.id_seksi = "+ id_area;
	}

	/* 2: get total safe and unsafe per month */
	for (i = 0; i < months.length; i++) {
		if (i > 0) {
			data += ",";
		}

		q	=" select	S.sum_safe"
			+" ,		S.sum_unsafe"
			+" ,		round((S.sum_safe / (case T.v when 0 then 1.00 else (T.v * 1.00) end)), 2,1)	safe_hour"
			+" ,		round((S.sum_unsafe / (case T.v when 0 then 1.00 else (T.v * 1.00) end)), 2,1)	unsafe_hour"
			+" from"
			+" 			("+ q_sum	+" and A.month = "+ (i+1) +") S"
			+" ,		("+ q_time	+" and A.month = "+ (i+1) +") T";

		rs = stmt.executeQuery(q);

		rs.next();

		data+="['"+ (i+1)		+"'"
			+ ",'"+ months[i]	+"'"
			+ ", "+ rs.getString("sum_safe")
			+ ", "+ rs.getString("sum_unsafe")
			+ ", "+ rs.getString("safe_hour")
			+ ", "+ rs.getString("unsafe_hour")
			+ "]";

		rs.close();
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
