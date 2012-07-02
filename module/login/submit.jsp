<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String	q				= "";
Cookie	c_user_nipg		= null;
Cookie	c_user_name		= null;
Cookie	c_user_email	= null;
Cookie	c_user_dir		= null;
Cookie	c_user_div		= null;
Cookie	c_user_dep		= null;
Cookie	c_user_din		= null;
Cookie	c_user_sek		= null;
String	c_path			= request.getContextPath ();
int		c_max_age		= 60 * 60 * 24 * 30; // 30 days
try {
	Connection db_con = (Connection) session.getAttribute("db.con");

	if (db_con == null || db_con.isClosed()) {
		String db_url = (String) session.getAttribute("db.url");

		if (db_url == null) {
			response.sendRedirect (c_path);
			return;
		}

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		db_con = DriverManager.getConnection(db_url);

		session.setAttribute("db.con", (Object) db_con);
	}

	Statement db_stmt = db_con.createStatement();

	String nipg = request.getParameter("nipg");
	String pass = request.getParameter("pass");

	q	=" select	A.nipg"
		+" ,		B.nama_pegawai"
		+" ,		B.email"
		+" ,		B.id_direktorat"
		+" ,		B.id_divprosbu"
		+" ,		B.id_departemen"
		+" ,		B.id_dinas"
		+" ,		B.id_seksi"
		+" from   __user	A"
		+" ,      r_pegawai	B"
		+" where  A.nipg     = '"+ nipg +"'"
		+" and    A.password = '"+ pass +"'"
		+" and    A.nipg     = B.nipg";

	ResultSet rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false"
			+ ",info:'NIPG atau Kata Kunci tidak diketahui!'}");
		rs.close();
		return;
	}

	String get_nipg			= rs.getString("nipg");
	String get_nama			= rs.getString("nama_pegawai");
	String get_email		= rs.getString("email");
	String id_direktorat	= rs.getString ("id_direktorat");
	String id_divprosbu		= rs.getString ("id_divprosbu");
	String id_departemen	= rs.getString ("id_departemen");
	String id_dinas			= rs.getString ("id_dinas");
	String id_seksi			= rs.getString ("id_seksi");

	rs.close();

	if (!get_nipg.equals(nipg)) {
		out.print("{success:false"
			+ ",info:'NIPG atau Kata Kunci tidak diketahui!'}");
		return;
	}

	/* save user to session */
	session.setAttribute("user.nipg", get_nipg);
	session.setAttribute("user.name", get_nama);
	session.setAttribute("user.email", get_email);
	session.setAttribute("user.direktorat", id_direktorat);
	session.setAttribute("user.divprosbu", id_divprosbu);
	session.setAttribute("user.departemen", id_departemen);
	session.setAttribute("user.dinas", id_dinas);
	session.setAttribute("user.seksi", id_seksi);

	/* save user data to cookies */
	c_user_nipg		= new Cookie ("user.nipg", get_nipg);
	c_user_name		= new Cookie ("user.name", get_nama);
	c_user_email	= new Cookie ("user.email", get_email);
	c_user_dir		= new Cookie ("user.direktorat", id_direktorat);
	c_user_div		= new Cookie ("user.divprosbu", id_divprosbu);
	c_user_dep		= new Cookie ("user.departemen", id_departemen);
	c_user_din		= new Cookie ("user.dinas", id_dinas);
	c_user_sek		= new Cookie ("user.seksi", id_seksi);

	c_user_nipg.setMaxAge (c_max_age);
	c_user_name.setMaxAge (c_max_age);
	c_user_email.setMaxAge (c_max_age);
	c_user_dir.setMaxAge (c_max_age);
	c_user_div.setMaxAge (c_max_age);
	c_user_dep.setMaxAge (c_max_age);
	c_user_din.setMaxAge (c_max_age);
	c_user_sek.setMaxAge (c_max_age);

	c_user_nipg.setPath (c_path);
	c_user_name.setPath (c_path);
	c_user_email.setPath (c_path);
	c_user_dir.setPath (c_path);
	c_user_div.setPath (c_path);
	c_user_dep.setPath (c_path);
	c_user_din.setPath (c_path);
	c_user_sek.setPath (c_path);

	response.addCookie (c_user_nipg);
	response.addCookie (c_user_name);
	response.addCookie (c_user_email);
	response.addCookie (c_user_dir);
	response.addCookie (c_user_div);
	response.addCookie (c_user_dep);
	response.addCookie (c_user_din);
	response.addCookie (c_user_sek);

	/* insert to __log */
	q	=" insert into __log (tanggal,nipg,nama_menu,status_akses)"
		+" values (getdate(),'"+ get_nipg +"', '01', '5')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'User logged in!'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
