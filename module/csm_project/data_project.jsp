<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - agus sugianto (agus.delonge@gmail.com)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		user_nipg	= ServletUtilities.getCookieValue (cookies, "user.nipg", "");
	String		user_div	= ServletUtilities.getCookieValue (cookies, "user.divprosbu", "");
	String		user_dir	= ServletUtilities.getCookieValue (cookies, "user.direktorat", "");

	if (user_nipg.equals ("") || user_div.equals ("") || user_dir.equals ("")) {
		out.print("{success:false,info:'User NIPG atau Divisi/Direktorat tidak diketahui.'}");
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

q
=" select	X.id_project"
+" ,		X.nama_project"
+" ,		X.id_kontraktor"
+" ,		X.work_level"
+" ,		X.work_level_nilai"
+" ,		isnull(Y.nama,'-') as nama_kontraktor"
+" ,		X.koefisien_utama"
+" ,		X.koefisien_tambah"
+" from"
+" ("
+"		select	A.id_project"
+"		,		B.nama_project"
+"		,		A.work_level"
+"		,		C.nilai as work_level_nilai"
+"		,		isnull(A.id_kontraktor, '0') as id_kontraktor"
+"		,		A.koefisien_utama"
+"		,		A.koefisien_tambah"
+"		from	t_csm_proyek				A"
+"		,		r_project					B"
+"		,		r_csm_project_work_level	C"
+"		where	A.id_project	= B.id_project"
+"		and		A.work_level	= C.id"
+"		and		A.id_divprosbu	= " + user_div
+"		and		A.id_direktorat	= " + user_dir
+" ) X"
+" left join"
+" ("
+"		select	id"
+"		,		nama"
+"		from	r_kontraktor"
+" ) Y"
+" on	X.id_kontraktor = Y.id";

	ResultSet	rs		= db_stmt.executeQuery (q);
	JSONArray	data	= new JSONArray ();
	JSONArray	item	= null;

	while (rs.next()) {
		item = new JSONArray ();
		item.put (rs.getString ("id_project"));
		item.put (rs.getString ("nama_project"));
		item.put (rs.getString ("id_kontraktor"));
		item.put (rs.getString ("nama_kontraktor"));
		item.put (rs.getString ("work_level"));
		item.put (rs.getString ("work_level_nilai"));
		item.put (rs.getString ("koefisien_utama"));
		item.put (rs.getString ("koefisien_tambah"));

		data.put (item);
	}

	out.print (data.toString ());

	rs.close ();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
