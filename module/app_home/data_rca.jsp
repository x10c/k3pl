<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
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

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	Statement	db_stmt 	= db_con.createStatement();

	String	load_type	= (String) request.getParameter("load_type");
	
	String q=" select	replace(convert(varchar, a.tanggal_rca, 111), '/', '-') as tanggal_rca "
			+" ,		b.description 											as description "
			+" ,		b.id_severity 											as id_severity "
			+" ,		case b.status "
			+" 				when '1' then 'Open' "
			+" 				when '2' then 'Process' "
			+" 				when '3' then 'Closed' "
			+" 			end as status "
			+" from		t_rca			as a "
			+" ,		t_rca_detail	as b "
			+" where	a.id_rca		= b.id_rca "
			+" and		(a.penanggung_jawab_nipg = '"+user_nipg+"'"
			+" or		'"+user_nipg+"' in (select c.nipg from t_rca_auditor c where c.id_rca = a.id_rca)) ";

	if (load_type.equals("all")) {
		q	+=" or		'"+user_nipg+"' in (select d.nipg from __user_grup as d where d.id_grup = 1) "
			+" and	a.auditor_divprosbu		= "+ user_div
			+" and	a.auditor_direktorat	= "+ user_dir;
	}

	q	+=" order by a.tanggal_rca desc ";

	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="[ '"+ rs.getString("tanggal_rca")
				+ "','"+ rs.getString("description")
				+ "','"+ rs.getString("id_severity")
				+ "','"+ rs.getString("status")
				+ "']";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
