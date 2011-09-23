<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	String		year		= (String) request.getParameter("year");
	String		data		= "{rows:[";
	ResultSet	rs		= null;
	int		i		= 0;

	if (year == null || year.isEmpty()) {
		data += "]}";
		out.print(data);
		return;
	}

	q	=" select	C.nipg"
		+" ,		B.nama_pegawai"
		+" ,		isnull(A.jan,0) as jan"
		+" ,		isnull(A.feb,0) as feb"
		+" ,		isnull(A.mar,0) as mar"
		+" ,		isnull(A.apr,0) as apr"
		+" ,		isnull(A.may,0) as may"
		+" ,		isnull(A.jun,0) as jun"
		+" ,		isnull(A.jul,0) as jul"
		+" ,		isnull(A.aug,0) as aug"
		+" ,		isnull(A.sep,0) as sep"
		+" ,		isnull(A.oct,0) as oct"
		+" ,		isnull(A.nov,0) as nov"
		+" ,		isnull(A.dec,0) as dec"
		+" from"
		+" 		r_pegawai		B"
		+" ,		__user_grup		C"
		+" left join	t_stop_target_pegawai	A"
		+"	on	C.nipg		= A.nipg"
		+"	and	A.year		= "+ year
		+" where	C.id_grup	= 2"
		+" and		C.nipg		= B.nipg";

	rs = db_stmt.executeQuery(q);

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		
		data	+="{ nipg:'"+ rs.getString("nipg") +"'"
			+ ", name:\""+ rs.getString("nama_pegawai") +"\""
			+ ", jan:'"+ rs.getString("jan") +"'"
			+ ", feb:'"+ rs.getString("feb") +"'"
			+ ", mar:'"+ rs.getString("mar") +"'"
			+ ", apr:'"+ rs.getString("apr") +"'"
			+ ", may:'"+ rs.getString("may") +"'"
			+ ", jun:'"+ rs.getString("jun") +"'"
			+ ", jul:'"+ rs.getString("jul") +"'"
			+ ", aug:'"+ rs.getString("aug") +"'"
			+ ", sep:'"+ rs.getString("sep") +"'"
			+ ", oct:'"+ rs.getString("oct") +"'"
			+ ", nov:'"+ rs.getString("nov") +"'"
			+ ", dec:'"+ rs.getString("dec") +"'"
			+ "}";
	}
	data += "]}";

	out.print(data);

} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
