<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %
 % WARNING: This script is used by charts module, do not use modinit.
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
JSONObject	_return	= new JSONObject ();
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement		stmt			= db_con.createStatement();
	ResultSet		rs				= null;
	JSONArray		json_a			= new JSONArray ();
	JSONArray		data			= null;
	String			q				= "";
	DecimalFormat	df				= new DecimalFormat("#.##");
	int				i				= 0;
	int				sum_safe		= 0;
	int				sum_unsafe		= 0;
	double			sum_total		= 0.0;
	double			safe_index		= 0.0;
	double			unsafe_index	= 0.0;

	int				id_dir		= ServletUtilities.getIntParameter (request, "id_dir"		, 0);
	int				id_div		= ServletUtilities.getIntParameter (request, "id_div"		, 0);
	int				id_dep		= ServletUtilities.getIntParameter (request, "id_dep"		, 0);
	int				id_dinas	= ServletUtilities.getIntParameter (request, "id_dinas"		, 0);
	int				id_seksi	= ServletUtilities.getIntParameter (request, "id_seksi"		, 0);
	int				id_wilayah	= ServletUtilities.getIntParameter (request, "id_wilayah"	, 0);
	int				id_area		= ServletUtilities.getIntParameter (request, "id_area"		, 0);
	int				year		= ServletUtilities.getIntParameter (request, "year"			, 0);
	String[]		months		= { "Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des" };

	/* 1: get total safe and unsafe per month */
	for (i = 0; i < months.length; i++) {
		q	=" select	isnull(sum(B.jumlah_safe),0) sum_safe "
			+" ,		isnull(sum(B.jumlah_unsafe),0) sum_unsafe "
			+" from		t_stop			A"
			+" ,		t_stop_detail	B"
			+" ,		r_seksi			C"
			+" where 	A.id_stop		= B.id_stop"
			+" and		A.status_aktif	= '1' "
			+" and		A.year			= "+ year
			+" and		A.month			= "+ (i + 1)
			+" and		A.id_seksi		= C.id_seksi";

		if (0 != id_dir) {
			q += " and A.id_direktorat = "+ id_dir;
		}
		if (0 != id_div) {
			q += " and A.id_divprosbu = "+ id_div;
		}
		if (0 != id_dep) {
			q += " and	A.id_departemen	= "+ id_dep;
		}
		if (0 != id_dinas) {
			q += " and	A.id_dinas	= "+ id_dinas;
		}
		if (0 != id_seksi) {
			q += " and	A.id_seksi	= "+ id_seksi;
		}
		if (0 != id_wilayah) {
			q	+=" and C.id_wilayah	= "+ id_wilayah;
		}
		if (0 != id_area) {
			q	+=" and	C.id_seksi		= "+ id_area;
		}

		rs = stmt.executeQuery(q);

		rs.next();

		sum_safe		= rs.getInt ("sum_safe");
		sum_unsafe		= rs.getInt ("sum_unsafe");
		sum_total		= sum_safe + sum_unsafe;
		safe_index		= (double) (sum_safe / (sum_total <= 0 ? 1.00 : sum_total)) * 100;
		unsafe_index	= (double) (sum_unsafe / (sum_total <= 0 ? 1.00 : sum_total)) * 100;

		data = new JSONArray ();
		data.put (i + 1);
		data.put (months[i]);
		data.put (sum_safe);
		data.put (sum_unsafe);
		data.put (Double.valueOf (df.format (safe_index)));
		data.put (Double.valueOf (df.format (unsafe_index)));

		json_a.put (data);

		rs.close();
	}

	out.print (json_a);

	stmt.close ();
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	out.print (_return);
}
%>
