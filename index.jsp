<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%
Properties	props	= new Properties();
props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"web.properties")));
String		db_url	= props.getProperty("db")+";user="+props.getProperty("user")+";password="+props.getProperty("pass");

try {
	DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
} catch (SQLException e) {
	System.out.println(e.getMessage());
}

Connection	db_con	= DriverManager.getConnection(db_url);
Statement	db_stmt	= db_con.createStatement();
ResultSet	rs		= null;
Cookie[]	cookies	= request.getCookies ();
String		c_name	= "";
String		user	= null;
String		cpath	= request.getContextPath();

session.setAttribute("db.url", (Object) db_url);
session.setAttribute("db.con", (Object) db_con);

// get user session, redirect to main page if user already logged in

if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		c_name = cookies[i].getName ();
		if (c_name.equalsIgnoreCase ("user.nipg")) {
			user = cookies[i].getValue ();
		}
	}
}

if (user != null) {
	response.sendRedirect(cpath +"/module/main/index.jsp");
	return;
}

String		q		= "";
String		chart_delay		= "10";
String		gallery_delay	= "7";

q	=" select	isnull(chart_delay, 10) as chart_delay"
	+" ,		isnull(gallery_delay, 7) as gallery_delay"
	+" from		r_k3pl";

rs = db_stmt.executeQuery(q);

if (rs.next()) {
	chart_delay		= rs.getString("chart_delay");
	gallery_delay	= rs.getString("gallery_delay");
}

rs.close();
%>

<html>
<head>
<title> PT. PGN Tbk. | K3PL</title>
<link rel='shortcut icon' href='<%=cpath%>/images/favicon_new.ico'/>
<script>
	var _g_root = '<%= cpath %>';
	var _g_chart_delay		= <%= chart_delay %> * 1000;
	var _g_gallery_delay	= <%= gallery_delay %> * 1000;
</script>

<link rel='icon' href='<%=cpath%>/images/favicon_new.ico' />
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/index.css'/>
<%--
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/ext-all.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/xtheme-gray.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/style.css'/>
--%>

<%--
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/ext/ext-base.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ext-all.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery-1.4.2.min.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery.cycle.all.min.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery_ease.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery.Scroller-1.0.min.js'></script>
--%>
<script type='text/javascript' src='<%=cpath%>/js/index-all.js'></script>

<%-- Highcharts --%>
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/highcharts/extjs-highcharts-adapter.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/highcharts.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/modules/exporting.js'></script>
<!--[if IE]><script type="text/javascript" src="<%=cpath%>/highcharts/excanvas.compiled.js"></script><![endif]-->
<script type='text/javascript' src='<%=cpath%>/extjs/ux/HighChart.js'></script>

<%-- K3PL js --%>
<script type='text/javascript' src='<%=cpath%>/js/SHA256.js'></script>
<script type='text/javascript' src='<%=cpath%>/charts/layout.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/all.js'></script>
<script type='text/javascript' src='<%=cpath%>/layout.js'></script>
</head>

<body>
<div id="back" class="clearfloat">
	<div id="header" class="clearfloat">
		<img src="<%=cpath%>/images/logo_new.png"/>
		<h1> PT. Perusahaan Gas Negara (Persero) Tbk.</h1>
		<h2> Sistem Informasi K3PL</h2>
	</div><!--end #header-->

	<div id="wrap" class="clearfloat">
		<div id="top">
			<div class="horizontal_scroller">
			</div>
		</div>
		<div id="main">
			<div class='image-list'></div>
			<div class='image-display'>
<%
	q	=" select	A.gallery_path+'/'+B.filename as pic"
		+" from		r_k3pl			A"
		+" ,		t_home_gallery	B"
		+" order by B.date_uploaded desc";

	rs = db_stmt.executeQuery(q);

	while (rs.next()) {
		out.print("<img src='"+ cpath + rs.getString("pic") +"'/>");
	}
%>
			</div>

			<div id='main_charts'>
			</div>
		</div><!--end main-->

		<div id="sidebar" class="clearfloat">
			<div class="login-section">
				<h3>User Login</h3>
				<form name="login_form">
					<label>NIPG:</label>
					<input type="text" name="nipg" id="user_login" value="" size="23" />
					<label>Password:</label>
					<input type="password" name="password" id="user_pass" size="23" onKeyDown="form_pass_on_keydown(event)" />
					<center>
					<input type="button" name="login" value="Login" class="bt_login" onClick="call_do_login()"/>
					</center>
				</form>
			</div>

			<div class="news">
			<h3>Berita K3PL</h3>
				<div>
<%

	q	=" select"
		+" 			replace(convert(varchar, date_published, 111), '/', '-') published"
		+" ,		subject"
		+" ,		url"
		+" ,		content"
		+" from		t_home_news"
		+" order by	date_published desc, date_updated desc";

	rs = db_stmt.executeQuery(q);
	String url;
	String subject;

	while (rs.next()) {
		url		= rs.getString("url");
		subject	= rs.getString("subject");

		out.print("<h4 class='news_header'>");
		if (url.equals("")) {
			out.print(subject);
		} else {
			out.print("<a href='"+ url +"' target='_blank'>"+ subject +"</a>");
		}
		out.print("</h4>");

		out.print("<div><div class='news_content'>");
		out.print(rs.getString("content"));
		out.print("</div></div>");
	}
%>
				</div>
			</div>
		</div>
		<div id="footer" class="clearfloat">
			<div class="left">
			<p>&#169; 2011 PT Perusahaan Gas Negara (Persero) Tbk. All Rights Reserved.</p>
			</div>
		</div><!--end #footer-->
	</div><!--end wrap-->
</div><!--end back-->
</body>
</html>
