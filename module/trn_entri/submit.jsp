<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String q 	= "";
String q2	= "";
String q3	= "";
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
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

	Statement	db_stmt			= db_con.createStatement();
	int			dml				= Integer.parseInt(request.getParameter("dml_type"));
	String		id				= request.getParameter("id");
	String		id_pel			= request.getParameter("id_pelatihan");
	String		penyelenggara	= request.getParameter("penyelenggara");
	String		tempat			= request.getParameter("tempat");
	String		tanggal			= request.getParameter("tanggal");
	String		lama			= request.getParameter("lama");
	JSONArray	peserta			= new JSONArray((String)request.getParameter("peserta"));
	Date		date			= new Date();
	int			i, l;

	penyelenggara	= penyelenggara.replace("'", "''");
	tempat			= tempat.replace("'", "''");

	switch (dml) {
	case 2:
		id = Long.toString(date.getTime());

		q	=" insert into t_pelatihan ("
			+"   id"
			+" , id_pelatihan"
			+" , penyelenggara"
			+" , tempat"
			+" , tanggal"
			+" , lama"
			+" , id_user"
			+") values ("
			+ id
			+", "+ id_pel
			+",'"+ penyelenggara +"'"
			+",'"+ tempat +"'"
			+", cast('"+ tanggal +"' as datetime)"
			+", "+ lama
			+",'"+ user_nipg +"'"
			+");";

		l = peserta.length();
		if (l > 0) {
			q2	=" insert into t_pelatihan_peserta (id,nipg,id_user)";
			for (i = 0; i < l; i++) {
				q2	+=" select "+ id
					+",'"+ peserta.getString(i) +"'"
					+",'"+ user_nipg +"'";

				if (i < (l-1)) {
					q2 +=" union all";
				}
			}
		}
		break;
	case 3:
		q	=" update	t_pelatihan"
			+" set		id_pelatihan	= "+ id_pel
			+" ,		penyelenggara	='"+ penyelenggara +"'"
			+" ,		tempat		='"+ tempat +"'"
			+" ,		tanggal		=cast('"+ tanggal +"' as datetime)"
			+" ,		lama		= "+ lama
			+" where	id		= "+ id
			+";";

		q2	=" delete from t_pelatihan_peserta where id = "+ id +";";


		l = peserta.length();
		if (l > 0) {
			q3	=" insert into t_pelatihan_peserta (id,nipg,id_user)";
			for (i = 0; i < l; i++) {
				q3	+=" select "+ id
					+",'"+ peserta.getString(i) +"'"
					+",'"+ user_nipg +"'";

				if (i < (l-1)) {
					q3 +=" union all";
				}
			}
		}
		break;
	case 4:
		q	=" delete from t_pelatihan_peserta where id = "+ id +";";
		q2	=" delete from t_pelatihan where id = "+ id +";";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	db_stmt.executeUpdate(q);
	if (!q2.equals("")) {
		db_stmt.executeUpdate(q2);
	}
	if (!q3.equals("")) {
		db_stmt.executeUpdate(q3);
	}

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah diperbaharui.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
