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
	String		load_type	= (String) request.getParameter("load_type");

	String		id_pha	= request.getParameter("id_pha");

	ResultSet	rs;
	String		q;

	q=" select	a.id_pha "
	+" ,		a.nipg "
	+" ,		a.nipg as nipg_old "
	+" ,		(select b.nama_departemen from r_departemen as b, r_pegawai as c where c.id_departemen = b.id_departemen and c.nipg = a.nipg) as departemen "
	+" ,		a.id_jabatan_pha "
	+" from		t_pha_keanggotaan	as a"
	+" where	a.id_pha 	= " + id_pha
	+" order by	a.id_pha, a.id_jabatan_pha";

	rs = db_stmt.executeQuery(q);

	int		i		= 0;
	String	data 	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "["+ rs.getString("id_pha")
			+  ",'"+ rs.getString("nipg") + "'"
			+  ",'"+ rs.getString("nipg_old") + "'"
			+  ",'"+ rs.getString("departemen") + "'"
			+  ","+ rs.getString("id_jabatan_pha")
			+  "]";
	}

	data += "]";
	
	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
