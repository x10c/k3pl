<%--
% Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
%
% Author(s):
% + PT. Awakami
%   - mhd.sulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	String		id_dir		= request.getParameter ("id_dir");
	String		year		= request.getParameter ("year");

	Statement	st			= db_con.createStatement ();
	Statement	st_i		= db_con.createStatement ();
	ResultSet	rs			= null;
	ResultSet	rs_i		= null;
	JSONArray	data		= new JSONArray ();
	JSONObject	o			= null;
	int			unit_id		= 0;
	String		unit_name	= "";
	String		q			= "";
	String		q_insiden	= "";

	if (id_dir != null && ! id_dir.equals ("0")) {
		q	=" select	id_divprosbu	as id"
			+" ,		nama_divprosbu	as name"
			+" from		r_divprosbu"
			+" where	id_direktorat = "+ id_dir;
	} else {
		q	=" select	id_direktorat	as id"
			+" ,		nama_direktorat	as name"
			+" from		r_direktorat";
	}

	rs = st.executeQuery (q);

	/* loop for all unit */
	while (rs.next ()) {
		o			= new JSONObject ();
		unit_id		= rs.getInt ("id");
		unit_name	= rs.getString ("name");

		o.put ("unit_id", unit_id);
		o.put ("unit_name", unit_name);

		q_insiden	=" select	isnull (jml_korban_mati, 0) 			as jml_korban_mati"
					+" ,		isnull (jml_korban_berat, 0)			as jml_korban_berat"
					+" ,		isnull (jml_korban_sedang, 0)			as jml_korban_sedang"
					+" ,		isnull (jml_korban_medis, 0)			as jml_korban_medis"
					+" ,		isnull (jml_korban_p3k, 0)				as jml_korban_p3k"
					+" ,		isnull (jml_hampir_celaka, 0)			as jml_hampir_celaka"
					+" ,		isnull (jml_kecelakaan_kendaraan, 0)	as jml_kecelakaan_kendaraan"
					+" from		t_insiden"
					+" where	tahun			= "+ year;

		if (id_dir != null && ! id_dir.equals ("0")) {
			q_insiden +=" and	id_divprosbu = "+ unit_id;
		} else {
			q_insiden +=" and	id_direktorat = "+ unit_id;
		}

		rs_i = st_i.executeQuery (q_insiden);

		if (rs_i.next ()) {
			o.put ("jml_korban_mati",			rs_i.getInt ("jml_korban_mati"));
			o.put ("jml_korban_berat",			rs_i.getInt ("jml_korban_berat"));
			o.put ("jml_korban_sedang",			rs_i.getInt ("jml_korban_sedang"));
			o.put ("jml_korban_medis",			rs_i.getInt ("jml_korban_medis"));
			o.put ("jml_korban_p3k",			rs_i.getInt ("jml_korban_p3k"));
			o.put ("jml_hampir_celaka",			rs_i.getInt ("jml_hampir_celaka"));
			o.put ("jml_kecelakaan_kendaraan",	rs_i.getInt ("jml_kecelakaan_kendaraan"));
		} else {
			o.put ("jml_korban_mati", 0);
			o.put ("jml_korban_berat", 0);
			o.put ("jml_korban_sedang", 0);
			o.put ("jml_korban_medis", 0);
			o.put ("jml_korban_p3k", 0);
			o.put ("jml_hampir_celaka", 0);
			o.put ("jml_kecelakaan_kendaraan", 0);
		}

		data.put (o);

		rs_i.close ();
	}
	rs.close ();

	unit_id++;
	unit_name = "Kontrak";

	o = new JSONObject ();
	o.put ("unit_id", unit_id);
	o.put ("unit_name", unit_name);

	q	=" select	isnull (jml_korban_mati, 0) 			as jml_korban_mati"
		+" ,		isnull (jml_korban_berat, 0)			as jml_korban_berat"
		+" ,		isnull (jml_korban_sedang, 0)			as jml_korban_sedang"
		+" ,		isnull (jml_korban_medis, 0)			as jml_korban_medis"
		+" ,		isnull (jml_korban_p3k, 0)				as jml_korban_p3k"
		+" ,		isnull (jml_hampir_celaka, 0)			as jml_hampir_celaka"
		+" ,		isnull (jml_kecelakaan_kendaraan, 0)	as jml_kecelakaan_kendaraan"
		+" from		t_insiden"
		+" where	tahun					= "+ year
		+" and		id_klasifikasi_pegawai	= 3";

	rs = st.executeQuery (q);

	if (rs.next ()) {
		o.put ("jml_korban_mati",			rs_i.getInt ("jml_korban_mati"));
		o.put ("jml_korban_berat",			rs_i.getInt ("jml_korban_berat"));
		o.put ("jml_korban_sedang",			rs_i.getInt ("jml_korban_sedang"));
		o.put ("jml_korban_medis",			rs_i.getInt ("jml_korban_medis"));
		o.put ("jml_korban_p3k",			rs_i.getInt ("jml_korban_p3k"));
		o.put ("jml_hampir_celaka",			rs_i.getInt ("jml_hampir_celaka"));
		o.put ("jml_kecelakaan_kendaraan",	rs_i.getInt ("jml_kecelakaan_kendaraan"));
	} else {
		o.put ("jml_korban_mati", 0);
		o.put ("jml_korban_berat", 0);
		o.put ("jml_korban_sedang", 0);
		o.put ("jml_korban_medis", 0);
		o.put ("jml_korban_p3k", 0);
		o.put ("jml_hampir_celaka", 0);
		o.put ("jml_kecelakaan_kendaraan", 0);
	}

	data.put (o);

	rs.close ();
	st.close ();

	out.print (data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
