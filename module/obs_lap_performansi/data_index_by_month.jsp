<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %
 % WARNING: This script is used by charts module.
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	stmt	= db_con.createStatement();
	Statement	stmt2	= db_con.createStatement();

	ResultSet	rs;
	String		data	= "[";
	String		q		= "";
	String		q2		= "";
	int			i, sum_act;

	String		id_dir		= request.getParameter("id_dir");
	String		id_div		= request.getParameter("id_div");
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		id_wilayah	= request.getParameter("id_wilayah");
	String		id_area		= request.getParameter("id_area");
	String		year		= request.getParameter("year");
	String		months[]	= { "Januari", "Februari", "Maret"
					, "April", "Mei", "Juni"
					, "Juli", "Agustus", "September"
					, "October", "November", "Desember"
					};

	/* 1: get total safe and unsafe per year */
	q	=" select	(isnull(sum(jumlah_safe), 0) + isnull(sum(jumlah_unsafe), 0)) sum_act"
		+" from		t_stop_detail"
		+" where	id_stop in ("
		+"	select	A.id_stop"
		+"	from	t_stop 		A"
		+"	,		r_seksi		B"
		+"	where	A.status_aktif	= '1'"
		+"	and		A.year			= "+ year;

	if (id_dir != null && (!id_dir.equals("0") && !id_dir.equals(""))) {
		q += " and A.id_direktorat = "+ id_dir;
	}
	if (id_div != null && (!id_div.equals ("0") && !id_div.equals (""))) {
		q += " and A.id_divprosbu = "+ id_div;
	}
	if (id_dep != null && !(id_dep.equals("0") || id_dep.equals(""))) {
		q += " and	A.id_departemen	= "+ id_dep;
	}
	if (id_dinas != null
	&& !(id_dinas.equals("0") || id_dinas.equals(""))) {
		q += " and	A.id_dinas	= "+ id_dinas;
	}
	if (id_seksi != null
	&& !(id_seksi.equals("0") || id_seksi.equals(""))) {
		q += " and	A.id_seksi	= "+ id_seksi;
	}

	if (id_wilayah != null
	&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
		q	+=" and	B.id_seksi	= A.id_seksi"
			+ " and B.id_wilayah	= "+ id_wilayah;
	}
	if (id_area != null
	&& !(id_area.equals("0") || id_area.equals(""))) {
		q += " and	id_seksi	= "+ id_area;
	}

	q	+=" )";

	rs = stmt.executeQuery(q);
	rs.next();

	sum_act	= rs.getInt("sum_act");

	/* check zero sum */
	if (sum_act == 0) {
		sum_act = 1;
	}

	/* 2: get total safe and unsafe per month */
	for (i = 0; i < months.length; i++) {
		if (i > 0) {
			data += ",";
		}

		q2	=" select	isnull(sum(B.jumlah_safe),0) sum_safe "
			+" ,		isnull(sum(B.jumlah_unsafe),0) sum_unsafe "
			+" ,		((isnull(sum(B.jumlah_safe),0)/"+ sum_act +".00)*100) safe_index "
			+" ,		((isnull(sum(B.jumlah_unsafe),0)/"+ sum_act +".00)*100) unsafe_index "
			+" from		t_stop			A"
			+" ,		t_stop_detail	B"
			+" ,		r_seksi			C"
			+" where 	A.id_stop		= B.id_stop"
			+" and		A.status_aktif	= '1' "
			+" and		A.year			= "+ year
			+" and		A.month			= "+ (i + 1)
			+" and		A.id_seksi		= C.id_seksi"
			+" and		A.id_dinas		= C.id_dinas"
			+" and		A.id_departemen	= C.id_departemen"
			+" and		A.id_divprosbu	= C.id_divprosbu"
			+" and		A.id_direktorat	= C.id_direktorat";

		if (id_dir != null && (!id_dir.equals ("0") && !id_dir.equals (""))) {
			q2 += " and A.id_direktorat = "+ id_dir;
		}
		if (id_div != null && (!id_div.equals ("0") && !id_div.equals (""))) {
			q2 += " and A.id_divprosbu = "+ id_div;
		}
		if (!id_dep.equals("0") && !id_dep.equals("")) {
			q2 += " and	A.id_departemen	= "+ id_dep;
		}
		if (!id_dinas.equals("0") && !id_dinas.equals("")) {
			q2 += " and	A.id_dinas	= "+ id_dinas;
		}
		if (!id_seksi.equals("0") && !id_seksi.equals("")) {
			q2 += " and	A.id_seksi	= "+ id_seksi;
		}
		if (id_wilayah != null
		&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
			q2	+=" and	A.id_seksi		= C.id_seksi"
				+ " and C.id_wilayah	= "+ id_wilayah;
		}
		if (id_area != null
		&& !(id_area.equals("0") || id_area.equals(""))) {
			q2	+=" and	C.id_seksi		= "+ id_area;
		}

		ResultSet rs2 = stmt2.executeQuery(q2);

		rs2.next();

		data	+="[ '"+ (i+1) +"' "
			+ ", '"+ months[i] +"' "
			+ ", "+ rs2.getString("sum_safe")
			+ ", "+ rs2.getString("sum_unsafe")
			+ ", "+ rs2.getString("safe_index")
			+ ", "+ rs2.getString("unsafe_index")
			+ "]";

		rs2.close();
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
