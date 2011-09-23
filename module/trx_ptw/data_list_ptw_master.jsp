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
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt 	= db_con.createStatement();
	String		jenis_ptw	= request.getParameter("jenis_ptw");

	int		jenis = 0;

	String q;

	q=" select	id_jsa "
	+" 		,	id_ptw "
	+" 		,	jenis_ptw "
	+" 		,	nomor "
	+" 		,	replace(convert(varchar, tgl_pengesahan, 111), '/', '-') tgl_pengesahan "
	+" 		,	replace(convert(varchar, masa_berlaku_awal, 111), '/', '-') masa_berlaku_awal "
	+" 		,	replace(convert(varchar, masa_berlaku_akhir, 111), '/', '-') masa_berlaku_akhir "
	+" from		t_ptw ";

	jenis = Integer.parseInt(jenis_ptw);

	if (jenis < 1 || jenis > 6) {
		out.print("{success:false,info:'Jenis PTW ("+ jenis +") tidak diketahui!'}");
		return;
	}

	q	+=" where jenis_ptw = '"+ jenis +"'";
		+ " order by id_ptw";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ "+ rs.getString("id_jsa")
			+ ","+ rs.getString("id_ptw")
			+ ",'"+ rs.getString("jenis_ptw")
			+ "','"+ rs.getString("nomor")
			+ "','"+ rs.getString("tgl_pengesahan")
			+ "','"+ rs.getString("masa_berlaku_awal")
			+ "','"+ rs.getString("masa_berlaku_akhir")
			+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
