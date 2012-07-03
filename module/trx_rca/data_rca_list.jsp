<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies			= request.getCookies ();
	String		nipg			= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		id_divprosbu	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		id_direktorat	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement	db_stmt 		= db_con.createStatement();
	String		load_type		= (String) request.getParameter("load_type");
	
	String q=" select	a.id_rca "
		+" ,		replace(convert(varchar, a.tanggal_rca, 111), '/', '-') as tanggal_rca "
		+" ,		a.auditor_seksi as id_seksi "
		+" ,		( select c.nama_seksi from r_seksi as c where a.auditor_seksi = c.id_seksi ) as auditor_seksi "
		+" ,		( "
		+"				select	nama "
		+"				from 	( "
		+"							select	e.nama_pegawai						as nama "
		+"								, 	row_number() over(order by d.nipg) 	as rownum "
		+"							from 	t_rca_auditor 	as d "
		+"								, 	r_pegawai 		as e "
		+"							where 	d.nipg 		= e.nipg "
		+"							and 	d.id_rca	= a.id_rca "
		+"						) as hasil "
		+"				where rownum between 1 and 1 "
		+"			) as nama_auditor "
		+" ,		( select f.nama_seksi from r_seksi as f where a.penanggung_jawab_seksi = f.id_seksi ) as penanggung_jawab_seksi "
		+" ,		a.penanggung_jawab_nipg as pic "
		+" ,		( select g.nama_pegawai from r_pegawai as g where a.penanggung_jawab_nipg = g.nipg) as nama_pic "
		+" ,		'" + nipg + "' as user_login "
		+" from		t_rca	as a "
		+" where	a.penanggung_jawab_nipg = '"+ nipg +"'"
		+" or		'"+ nipg +"' in (select b.nipg from t_rca_auditor b where b.id_rca = a.id_rca)";

		if (load_type.equals("all")) {
			q+=" or		'"+ nipg +"' in (select c.nipg from __user_grup as c where c.id_grup = 1)";
			q+=" and	a.auditor_divprosbu		= "+ id_divprosbu
			q+=" and	a.auditor_direktorat	= "+ id_direktorat;
		}

		q+=" order by	a.tanggal_rca desc ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("id_rca")
			+ "','"+ rs.getString("tanggal_rca")
			+ "','"+ rs.getString("id_seksi")
			+ "','"+ rs.getString("auditor_seksi")
			+ "','"+ rs.getString("nama_auditor")
			+ "','"+ rs.getString("penanggung_jawab_seksi")
			+ "','"+ rs.getString("pic")
			+ "','"+ rs.getString("nama_pic")
			+ "','"+ rs.getString("user_login")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
