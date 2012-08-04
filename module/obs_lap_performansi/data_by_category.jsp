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
long	all_safe	= 1;
long	all_unsafe	= 1;
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	stmt	= db_con.createStatement();
	Statement	stmt2	= db_con.createStatement();

	ResultSet	rs, rs2;
	String		data	= "[";
	String		id_tipe_obs;
	String		nama_tipe_obs;
	String		q, q2, q3;
	int		i	= 0;

	String		id_dir		= request.getParameter("id_dir");
	String		id_div		= request.getParameter("id_div");
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		id_wilayah	= request.getParameter("id_wilayah");
	String		id_area		= request.getParameter("id_area");
	String		year		= request.getParameter("year");
	String		month		= request.getParameter("month");

	q2	=" select	isnull(sum(jumlah_safe),1) sum_safe"
		+" ,		isnull(sum(jumlah_unsafe),1) sum_unsafe"
		+" from		t_stop_detail "
		+" where	id_stop in ("
		+"	select	A.id_stop"
		+"	from	t_stop		A"
		+"	,	r_seksi		B"
		+"	where	A.status_aktif	= '1'"
		+"	and	A.year		= "+ year;

		if (id_dir != null && (!id_dir.equals("0") && !id_dir.equals(""))) {
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
			q2	+=" and	B.id_wilayah	= "+ id_wilayah
				+ " and B.id_seksi	= A.id_seksi";
		}
		if (id_area != null
		&& !(id_area.equals("0") || id_area.equals(""))) {
			q2 += " and	A.id_seksi	= "+ id_area;
		}

		if (!month.equals("0")) {
			q2 += " and	A.month		= "+ month;
		}

		q2	+=" )";

	rs2 = stmt2.executeQuery(q2);

	if (rs2.next()) {
		all_safe = rs2.getLong("sum_safe");
		all_unsafe = rs2.getLong("sum_unsafe");
	}

	rs2.close();

	/* get safe/unsafe value for each type of observation */
	q	=" select	id_tipe_observasi "
		+" ,		nama_tipe_observasi "
		+" from		r_tipe_observasi ";

	rs = stmt.executeQuery(q);

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		id_tipe_obs	= rs.getString("id_tipe_observasi");
		nama_tipe_obs	= rs.getString("nama_tipe_observasi");

		q2	=" select	isnull(sum(jumlah_safe),0) sum_safe "
			+" ,		isnull(sum(jumlah_unsafe),0) sum_unsafe "
			+" from		t_stop_detail "
			+" where	id_tipe_observasi = "+ id_tipe_obs
			+" and		id_stop in ("
			+"	select	A.id_stop"
			+"	from	t_stop		A"
			+"	,	r_seksi		B"
			+"	where	A.status_aktif	= '1' "
			+"	and	A.year		= "+ year;

		if (!id_dir.equals("0") && !id_dir.equals("")) {
			q2 += " and A.id_direktorat = "+ id_dir;
		}
		if (!id_div.equals ("0") && !id_div.equals ("")) {
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
			q2	+=" and	B.id_wilayah	= "+ id_wilayah
				+ " and B.id_seksi	= A.id_seksi";
		}
		if (id_area != null
		&& !(id_area.equals("0") || id_area.equals(""))) {
			q2 += " and	A.id_seksi	= "+ id_area;
		}

		if (!month.equals("0")) {
			q2 += " and	A.month		= "+ month;
		}

		q2	+=" )";

		q3	=" select	A.sum_safe"
			+" ,		A.sum_unsafe"
			+" ,		((A.sum_safe / "+ all_safe +".00) * 100) as safe_percent"
			+" ,		((A.sum_unsafe / "+ all_unsafe +".00) * 100) as unsafe_percent"
			+" from	("+ q2 +") A";

		rs2	= stmt2.executeQuery(q3);

		rs2.next();

		data	+="[ "+ id_tipe_obs
			+ ",'"+ nama_tipe_obs +"' "
			+ ", "+ rs2.getString("sum_safe")
			+ ", "+ rs2.getString("sum_unsafe")
			+ ", "+ rs2.getString("safe_percent")
			+ ", "+ rs2.getString("unsafe_percent")
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
