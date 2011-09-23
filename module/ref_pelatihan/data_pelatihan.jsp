<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Agus Sugianto (agus.delonge@gmail.com)
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String q=" select	id_pelatihan_kelompok "
		+" ,		id_pelatihan "
		+" ,		nama_pelatihan "
		+" from		r_pelatihan "
		+" order by	id_pelatihan, id_pelatihan_kelompok";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="[ "+ rs.getString("id_pelatihan_kelompok")
			+ ", "+ rs.getString("id_pelatihan")
			+ ",'"+ rs.getString("nama_pelatihan") +"'"
			+ "]";
	}
	data += "]";

	out.print(data);

	rs.close();
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
