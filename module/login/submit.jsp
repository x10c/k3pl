<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
Connection	db_con			= null;
Statement	db_stmt			= null;
ResultSet	db_rs			= null;
String		db_q			= "";
String		user_name		= null;
String		user_nipg		= null;
String		user_group		= null;
String		user_email		= null;
String		user_seksi		= null;
String		user_dinas		= null;
String		user_dep		= null;
String		user_div		= null;
String		user_dir		= null;
String		user_wilayah	= null;
String		nipg			= null;
String		pass			= null;
Cookie		c_user_nipg		= null;
Cookie		c_user_group	= null;
Cookie		c_user_name		= null;
Cookie		c_user_email	= null;
Cookie		c_user_dir		= null;
Cookie		c_user_div		= null;
Cookie		c_user_dep		= null;
Cookie		c_user_din		= null;
Cookie		c_user_sek		= null;
Cookie		c_user_wilayah	= null;
String		c_path			= request.getContextPath ();
int			c_max_age		= 60 * 60 * 24 * 30; // 30 days
JSONObject	_return			= new JSONObject ();
try {
	db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	nipg = request.getParameter("nipg");
	pass = request.getParameter("pass");

	db_stmt	= db_con.createStatement();
	db_q	=" select	A.nipg"
			+" ,		B.nama_pegawai"
			+" ,		B.email"
			+" ,		B.id_direktorat"
			+" ,		B.id_divprosbu"
			+" ,		B.id_departemen"
			+" ,		B.id_dinas"
			+" ,		B.id_seksi"
			+" ,		D.id_wilayah"
			+" ,		max (C.id_grup) id_grup"
			+" from   	__user		A"
			+" ,      	r_pegawai	B"
			+" ,		__user_grup	C"
			+" ,		r_seksi		D"
			+" where	A.nipg		= '"+ nipg +"'"
			+" and		A.password	= '"+ pass +"'"
			+" and		A.nipg		= B.nipg"
			+" and		A.nipg		= C.nipg"
			+" and		B.id_seksi	= D.id_seksi"
			+" group by	A.nipg"
			+" ,		B.nama_pegawai"
			+" ,		B.email"
			+" ,		B.id_direktorat"
			+" ,		B.id_divprosbu"
			+" ,		B.id_departemen"
			+" ,		B.id_dinas"
			+" ,		B.id_seksi"
			+" ,		D.id_wilayah";

	db_rs	= db_stmt.executeQuery (db_q);

	if (! db_rs.next()) {
		db_rs.close();
		_return.put ("success", false);
		_return.put ("info", "NIPG atau Kata Kunci tidak diketahui!");
		out.print (_return);
		return;
	}

	user_nipg		= db_rs.getString ("nipg");
	user_group		= db_rs.getString ("id_grup");
	user_name		= db_rs.getString ("nama_pegawai");
	user_email		= db_rs.getString ("email");
	user_dir		= db_rs.getString ("id_direktorat");
	user_div		= db_rs.getString ("id_divprosbu");
	user_dep		= db_rs.getString ("id_departemen");
	user_dinas		= db_rs.getString ("id_dinas");
	user_seksi		= db_rs.getString ("id_seksi");
	user_wilayah	= db_rs.getString ("id_wilayah");

	db_rs.close();

	if (! user_nipg.equals (nipg)) {
		_return.put ("success", false);
		_return.put ("info", "NIPG atau Kata Kunci tidak diketahui!");
		out.print (_return);
		return;
	}

	/* save user to session */
	session.setAttribute("user.nipg", user_nipg);
	session.setAttribute("user.group", user_group);
	session.setAttribute("user.name", user_name);
	session.setAttribute("user.email", user_email);
	session.setAttribute("user.direktorat", user_dir);
	session.setAttribute("user.divprosbu", user_div);
	session.setAttribute("user.departemen", user_dep);
	session.setAttribute("user.dinas", user_dinas);
	session.setAttribute("user.seksi", user_seksi);
	session.setAttribute("user.wilayah", user_wilayah);

	/* save user data to cookies */
	c_user_nipg		= new Cookie ("user.nipg", user_nipg);
	c_user_group	= new Cookie ("user.group", user_group);
	c_user_name		= new Cookie ("user.name", user_name);
	c_user_email	= new Cookie ("user.email", user_email);
	c_user_dir		= new Cookie ("user.direktorat", user_dir);
	c_user_div		= new Cookie ("user.divprosbu", user_div);
	c_user_dep		= new Cookie ("user.departemen", user_dep);
	c_user_din		= new Cookie ("user.dinas", user_dinas);
	c_user_sek		= new Cookie ("user.seksi", user_seksi);
	c_user_wilayah	= new Cookie ("user.wilayah", user_wilayah);

	c_user_nipg.setMaxAge (c_max_age);
	c_user_group.setMaxAge (c_max_age);
	c_user_name.setMaxAge (c_max_age);
	c_user_email.setMaxAge (c_max_age);
	c_user_dir.setMaxAge (c_max_age);
	c_user_div.setMaxAge (c_max_age);
	c_user_dep.setMaxAge (c_max_age);
	c_user_din.setMaxAge (c_max_age);
	c_user_sek.setMaxAge (c_max_age);
	c_user_wilayah.setMaxAge (c_max_age);

	c_user_nipg.setPath (c_path);
	c_user_group.setPath (c_path);
	c_user_name.setPath (c_path);
	c_user_email.setPath (c_path);
	c_user_dir.setPath (c_path);
	c_user_div.setPath (c_path);
	c_user_dep.setPath (c_path);
	c_user_din.setPath (c_path);
	c_user_sek.setPath (c_path);
	c_user_wilayah.setPath (c_path);

	response.addCookie (c_user_nipg);
	response.addCookie (c_user_group);
	response.addCookie (c_user_name);
	response.addCookie (c_user_email);
	response.addCookie (c_user_dir);
	response.addCookie (c_user_div);
	response.addCookie (c_user_dep);
	response.addCookie (c_user_din);
	response.addCookie (c_user_sek);
	response.addCookie (c_user_wilayah);

	/* insert to __log */
	db_q=" insert into __log (tanggal,nipg,nama_menu,status_akses)"
		+" values (getdate(),'"+ user_nipg +"', '01', '5')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "User logged in!");
}
catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
