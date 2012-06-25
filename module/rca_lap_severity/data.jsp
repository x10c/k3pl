<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		start	= request.getParameter("start");
	String		end		= request.getParameter("end");

	String 		year	= request.getParameter("year");
	String 		month	= request.getParameter("month");
	
	String q = " "
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
	+"	where	year(a.tanggal_rca)				= " + year
	+"	and		month(a.tanggal_rca)			= " + month
	+"	and		a.penanggung_jawab_seksi		= b.id_seksi "
	+"	and		a.penanggung_jawab_dinas		= c.id_dinas "
	+"	and		a.penanggung_jawab_departemen	= d.id_departemen "
	+"	and		a.penanggung_jawab_divprosbu	= e.id_divprosbu "
	+"	and		a.penanggung_jawab_direktorat	= f.id_direktorat "
	+"	order by a.tanggal_rca";

	ResultSet	rs 		= db_stmt.executeQuery(q);
	int			i 		= 0;
	String		data 	= "[";

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
