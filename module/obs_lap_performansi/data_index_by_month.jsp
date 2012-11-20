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

	String		id_dir		= request.getParameter("id_dir");
	String		id_div		= request.getParameter("id_div");
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		id_wilayah	= request.getParameter("id_wilayah");
	String		id_area		= request.getParameter("id_area");
	String		year		= request.getParameter("year");
	String		months[]	= { "Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des" };

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
			+" and		A.id_seksi		= C.id_seksi"
			+" and		A.id_dinas		= C.id_dinas"
			+" and		A.id_departemen	= C.id_departemen"
			+" and		A.id_divprosbu	= C.id_divprosbu"
			+" and		A.id_direktorat	= C.id_direktorat";

		if (id_dir != null && (!id_dir.equals ("0") && !id_dir.equals (""))) {
			q += " and A.id_direktorat = "+ id_dir;
		}
		if (id_div != null && (!id_div.equals ("0") && !id_div.equals (""))) {
			q += " and A.id_divprosbu = "+ id_div;
		}
		if (!id_dep.equals("0") && !id_dep.equals("")) {
			q += " and	A.id_departemen	= "+ id_dep;
		}
		if (!id_dinas.equals("0") && !id_dinas.equals("")) {
			q += " and	A.id_dinas	= "+ id_dinas;
		}
		if (!id_seksi.equals("0") && !id_seksi.equals("")) {
			q += " and	A.id_seksi	= "+ id_seksi;
		}
		if (id_wilayah != null
		&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
			q	+=" and	A.id_seksi		= C.id_seksi"
				+ " and C.id_wilayah	= "+ id_wilayah;
		}
		if (id_area != null
		&& !(id_area.equals("0") || id_area.equals(""))) {
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
