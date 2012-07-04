<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
String	q			= "";
String	q_where		= "";
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

	Statement	db_stmt		= db_con.createStatement();
	ResultSet	rs;
	String		id, name;
	String		is_in_org	= request.getParameter("is_in_org");
	String		id_dir		= request.getParameter("id_dir");
	String		id_div		= request.getParameter("id_div");
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		id_wilayah	= request.getParameter("id_wilayah");
	String		id_area		= request.getParameter("id_area");
	String		year		= request.getParameter("year");
	int			month		= Integer.parseInt(request.getParameter("month"));

	q 	= " "
		+"	select	a.description "
		+"		,	a.id_severity "
		+"		,	a.nama_tempat_rca "
		+"		,	a.penanggung_jawab_seksi "
		+"		,	b.nama_seksi "
		+"		,	a.penanggung_jawab_dinas "
		+"		,	c.nama_dinas "
		+"		,	a.penanggung_jawab_departemen "
		+"		,	d.nama_departemen "
		+"		,	a.penanggung_jawab_divprosbu "
		+"		,	e.nama_divprosbu "
		+"		,	a.penanggung_jawab_direktorat "
		+"		,	f.nama_direktorat "
		+"		,	a.completion_date_target "
		+"		,	a.status "
		+"		,	case a.status when '1' then 'Open' when '2' then 'Process' else 'Closed' end as nama_status "
		+"		,	a.note "
		+"	from	[k3pl].[dbo].[V_SEVERITY]	as a"
		+"	,		r_seksi						as b"
		+"	,		r_dinas						as c"
		+"	,		r_departemen				as d"
		+"	,		r_divprosbu					as e"
		+"	,		r_direktorat				as f"
		+"	where	a.penanggung_jawab_seksi		= b.id_seksi "
		+"	and		a.penanggung_jawab_dinas		= b.id_dinas "
		+"	and		a.penanggung_jawab_departemen	= b.id_departemen "
		+"	and		a.penanggung_jawab_divprosbu	= b.id_divprosbu "
		+"	and		a.penanggung_jawab_direktorat	= b.id_direktorat "
		+"	and		b.id_dinas						= c.id_dinas "
		+"	and		b.id_departemen					= d.id_departemen "
		+"	and		b.id_divprosbu					= e.id_divprosbu "
		+"	and		b.id_direktorat					= f.id_direktorat "
		+"	and		year(a.tanggal_rca)				= " + year;
		
	/* filter/aggregate by month */
	if (month != 0) {
		q	+=" and month(a.tanggal_rca) = "+ month;
	}

	if (id_dir != null
	&& !(id_dir.equals ("0") || id_dir.equals (""))) {
		q += " and b.id_direktorat = "+ id_dir;
	}
	if (id_div != null
	&& !(id_div.equals ("0") || id_div.equals (""))) {
		q += " and b.id_divprosbu = "+ id_div;
	}
	if (id_dep != null
	&& !(id_dep.equals("0") || id_dep.equals(""))) {
		q += " and	b.id_departemen	= "+ id_dep;
	}
	if (id_dinas != null
	&& !(id_dinas.equals("0") || id_dinas.equals(""))) {
		q += " and	b.id_dinas	= "+ id_dinas;
	}
	if (id_seksi != null
	&& !(id_seksi.equals("0") || id_seksi.equals(""))) {
		q += " and	b.id_seksi	= "+ id_seksi;
	}
	if (id_wilayah != null
	&& !(id_wilayah.equals("0") || id_wilayah.equals(""))) {
		q += " and	b.id_wilayah	= "+ id_wilayah;
	}
	if (id_area != null
	&& !(id_area.equals("0") || id_area.equals(""))) {
		q += " and	b.id_seksi	= "+ id_area;
	}
	
	q	+="	order by a.tanggal_rca";

	rs 				= db_stmt.executeQuery(q);
	
	int		i 		= 0;
	String	data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		
		data	+= "[ '"+ rs.getString("description") +"'"
				+  ","+ rs.getString("id_severity")
				+  ",'"+ rs.getString("nama_tempat_rca") +"'"
				+  ","+ rs.getString("penanggung_jawab_seksi")
				+  ",'"+ rs.getString("nama_seksi") + "'"
				+  ","+ rs.getString("penanggung_jawab_dinas")
				+  ",'"+ rs.getString("nama_dinas") + "'"
				+  ","+ rs.getString("penanggung_jawab_departemen")
				+  ",'"+ rs.getString("nama_departemen") + "'"
				+  ","+ rs.getString("penanggung_jawab_divprosbu")
				+  ",'"+ rs.getString("nama_divprosbu") + "'"
				+  ","+ rs.getString("penanggung_jawab_direktorat")
				+  ",'"+ rs.getString("nama_direktorat") + "'"
				+  ",'"+ rs.getString("completion_date_target") +"'"
				+  ",'"+ rs.getString("status") +"'"
				+  ",'"+ rs.getString("nama_status") +"'"
				+  ",'"+ rs.getString("note") +"'"
				+  "]";
	}

	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
