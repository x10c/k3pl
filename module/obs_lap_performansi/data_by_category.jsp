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
<%@ page import="org.kilabit.ServletUtilities" %>
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

	int			id_dir		= ServletUtilities.getIntParameter (request, "id_dir", 0);
	int			id_div		= ServletUtilities.getIntParameter (request, "id_div", 0);
	int			id_dep		= ServletUtilities.getIntParameter (request, "id_dep", 0);
	int			id_dinas	= ServletUtilities.getIntParameter (request, "id_dinas", 0);
	int			id_seksi	= ServletUtilities.getIntParameter (request, "id_seksi", 0);
	int			id_wilayah	= ServletUtilities.getIntParameter (request, "id_wilayah", 0);
	int			id_area		= ServletUtilities.getIntParameter (request, "id_area", 0);
	int			year		= ServletUtilities.getIntParameter (request, "year", 0);
	int			month		= ServletUtilities.getIntParameter (request, "month", 0);

	q2	=" select	isnull(sum(B.jumlah_safe),1) sum_safe"
		+" ,		isnull(sum(B.jumlah_unsafe),1) sum_unsafe"
		+" from		t_stop			A"
		+"	,		t_stop_detail	B"
		+"	where	A.id_stop		= B.id_stop"
		+"	and		A.status_aktif	= '1'"
		+"	and		A.year			= "+ year;

	if (0 != id_dir) {
		q2 += " and A.id_direktorat = "+ id_dir;
	}
	if (0 != id_div) {
		q2 += " and A.id_divprosbu = "+ id_div;
	}
	if (0 != id_dep) {
		q2 += " and	A.id_departemen	= "+ id_dep;
	}
	if (0 != id_dinas) {
		q2 += " and	A.id_dinas	= "+ id_dinas;
	}
	if (0 != id_seksi) {
		q2 += " and	A.id_seksi	= "+ id_seksi;
	}

	if (0 != id_wilayah) {
		q2	+=" and	B.id_wilayah	= "+ id_wilayah
			+ " and B.id_seksi	= A.id_seksi";
	}
	if (0 != id_area) {
		q2 += " and	A.id_seksi	= "+ id_area;
	}

	if (0 != month) {
		q2 += " and	A.month		= "+ month;
	}

	rs2 = stmt2.executeQuery(q2);

	if (rs2.next()) {
		all_safe = rs2.getLong("sum_safe");
		all_unsafe = rs2.getLong("sum_unsafe");
	} else {
		all_safe	= 1;
		all_unsafe	= 1;
	}

	if (all_safe == 0) {
		all_safe = 1;
	}
	if (all_unsafe == 0) {
		all_unsafe = 1;
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

		id_tipe_obs		= rs.getString("id_tipe_observasi");
		nama_tipe_obs	= rs.getString("nama_tipe_observasi");

		q2	=" select	isnull(sum(B.jumlah_safe),0) sum_safe "
			+" ,		isnull(sum(B.jumlah_unsafe),0) sum_unsafe "
			+" from		t_stop				A"
			+"	,		t_stop_detail		B"
			+"	,		r_seksi				C"
			+" where	A.id_stop			= B.id_stop"
			+"	and		A.id_seksi			= C.id_seksi"
			+"	and		B.id_tipe_observasi	= "+ id_tipe_obs
			+"	and		A.status_aktif		= '1' "
			+"	and		A.year				= "+ year;

		if (0 != id_dir) {
			q2 += " and A.id_direktorat = "+ id_dir;
		}
		if (0 != id_div) {
			q2 += " and A.id_divprosbu = "+ id_div;
		}
		if (0 != id_dep) {
			q2 += " and	A.id_departemen	= "+ id_dep;
		}
		if (0 != id_dinas) {
			q2 += " and	A.id_dinas	= "+ id_dinas;
		}
		if (0 != id_seksi) {
			q2 += " and	A.id_seksi	= "+ id_seksi;
		}
		if (0 != id_wilayah) {
			q2	+=" and	C.id_wilayah	= "+ id_wilayah
				+ " and C.id_seksi		= A.id_seksi";
		}
		if (0 != id_area) {
			q2 += " and	A.id_seksi	= "+ id_area;
		}
		if (0 != month) {
			q2 += " and	A.month		= "+ month;
		}

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
