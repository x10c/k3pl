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
String cpath = (String) request.getContextPath();

try {
	Properties	props	= new Properties();

	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"web.properties")));

	String		db_url	= props.getProperty("db")
						+";user="+props.getProperty("user")
						+";password="+props.getProperty("pass");
	Connection	db_con	= DriverManager.getConnection(db_url);

	session.setAttribute("db.con", (Object) db_con);
	session.setAttribute("db.url", (Object) db_url);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'", "''") +"'}");
	return;
}
%>

<html>
<head>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/ext-all.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/xtheme-gray.css'/>
<script>
	var _g_root = '<%= cpath %>'
</script>

<script type='text/javascript' src='<%=cpath%>/extjs/adapter/ext/ext-base.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ext-all.js'></script>

<%-- Highchart --%>
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/highcharts/extjs-highcharts-adapter.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/highcharts.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/modules/exporting.js'></script>
<!--[if IE]><script type="text/javascript" src="<%=cpath%>/highcharts/excanvas.compiled.js"></script><![endif]-->
<script type='text/javascript' src='<%=cpath%>/extjs/ux/HighChart.js'></script>

<%-- k3pl js --%>
<script type='text/javascript' src='<%=cpath%>/js/all.js'></script>
<script type='text/javascript' src='<%=cpath%>/charts/layout.js'></script>
<script type='text/javascript'>
	m_charts_interval = window.setInterval('charts_do_refresh()', 4000);
</script>

<script type='text/javascript'>
Ext.onReady(
function(){
	m_charts = new M_Charts();

	var viewport = new Ext.Viewport({
		layout		: 'border'
	,	items		: [
			m_charts.panel
		]
	});

	m_charts.panel.renderTo = 'charts';
	m_charts.panel.doLayout();
});
</script>
</head>

<body>
<div id='charts'></div>
</body>

</html>
