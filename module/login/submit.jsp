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

	if (db_con == null || db_con.isClosed()) {
		String db_url = (String) session.getAttribute("db.url");

		if (db_url == null) {
			response.sendRedirect(request.getContextPath());
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

	String get_nipg = rs.getString("nipg");
	String get_nama = rs.getString("nama_pegawai");
	String get_email = rs.getString("email");

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
