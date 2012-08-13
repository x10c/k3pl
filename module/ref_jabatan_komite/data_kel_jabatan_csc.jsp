<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - Prasetya Yanuar (mieh100freak@gmail.com)
--%>

<%@ include file="../modinit.jsp" %>
<%
try {

	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	String		nipg	= request.getParameter ("nipg");
	String		where_c = "";
	if (! "1".equals (user_group)) {
		where_c =" where	id_direktorat	= "+ user_dir
				+ " and		id_divprosbu	= "+ user_div;
	}
	db_stmt = db_con.createStatement();
	
	String q= " select   id_kel_jabatan_csc "
		+ " ,        nama_kel_jabatan_csc "
		+ " ,        id_divprosbu "
		+ " ,        id_direktorat "
		+ " from     r_kel_jabatan_csc "
		+ where_c
		+ " order by id_kel_jabatan_csc ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "{ rows : [";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "{ id : '"+ rs.getString("id_kel_jabatan_csc") +"' "
			+  ", nama : '"+ rs.getString("nama_kel_jabatan_csc") +"' "
			+  ", id_divprosbu : '"+ rs.getString("id_divprosbu") +"' "
			+  ", id_direktorat : '"+ rs.getString("id_direktorat") +"' "
			+  "} ";
	}

	data += "]}";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
