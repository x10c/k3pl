<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page contentType="text/html" %>
<%
Cookie[]	cookies	= request.getCookies ();
String		c_name	= "";
String		user_nipg	= null;
String		user_name	= null;
String		user_email	= null;

if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		c_name = cookies[i].getName ();
		if (c_name.equalsIgnoreCase ("user.nipg")) {
			user_nipg = cookies[i].getValue ();
		} else if (c_name.equalsIgnoreCase ("user.name")) {
			user_name = cookies[i].getValue ();
		} else if (c_name.equalsIgnoreCase ("user.email")) {
			user_email = cookies[i].getValue ();
		}
	}
}

// check user session, if not exist redirect user to module login
String cpath	= (String) request.getContextPath();
String db_url	= (String) session.getAttribute("db.url");

if (null == user_nipg || null == db_url) {
	String url = cpath +"/index.jsp";
	response.sendRedirect(url);
	return;
}
%>
<html>
<head>
<title>PT. Perusahaan Gas Negara Tbk. | K3PL</title>
<link rel='shortcut icon' href='<%=cpath%>/images/favicon_new.ico'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/main.css'/>
<%--
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/ext-all.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/xtheme-gray.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/RowEditor.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/Spinner.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/GridSummary.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/GroupSummary.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/ColumnHeaderGroup.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/LockingGridView.css'/>
<link rel="stylesheet" type="text/css" href="<%=cpath%>/extjs/ux/gridfilters/css/GridFilters.css" />
<link rel="stylesheet" type="text/css" href="<%=cpath%>/extjs/ux/gridfilters/css/RangeMenu.css" />
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/all.css'/>
--%>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/all.css'/>

<%--
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/ext/ext-base.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ext-all.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/RowEditor.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/Spinner.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/SpinnerField.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/GridSummary.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/GroupSummary.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/ColumnHeaderGroup.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/LockingGridView.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/PagingStore.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/data_drop_plugin/Override.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/data_drop_plugin/Ext.ux.DataDrop.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/ext_ux_exporter/Exporter-all.js'></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/menu/RangeMenu.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/menu/ListMenu.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/GridFilters.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/Filter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/StringFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/DateFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/ListFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/NumericFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/BooleanFilter.js"></script>
--%>
<script type='text/javascript' src='<%=cpath%>/extjs/extjs-ux-all.js'></script>

<%-- Highcharts --%>
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/highcharts/extjs-highcharts-adapter.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/highcharts.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/modules/exporting.js'></script>
<!--[if IE]><script type="text/javascript" src="<%=cpath%>/highcharts/excanvas.compiled.js"></script><![endif]-->
<script type='text/javascript' src='<%=cpath%>/extjs/ux/HighChart.js'></script>

<script>
	var _g_root = '<%= cpath %>'
	var _g_username = "<%= user_name %>"
	var _g_usernipg = '<%= user_nipg %>'
	var _g_usermail = '<%= user_email %>'

	Ext.QuickTips.init();
</script>

<%-- K3PL js --%>
<script type='text/javascript' src='<%=cpath%>/js/SHA256.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/all.js'></script>

<%-- all module --%>
<script type='text/javascript' src='<%=cpath%>/module/app_home/layout.js'></script>
<script type='text/javascript' src='<%=cpath%>/module/pssr_laporan/layout.js'></script>
<script type='text/javascript' src='<%=cpath%>/module/main/layout.js'></script>
</head>

<body>
<div id='loading-mask'></div>
<div id='loading'>
    <div class="loading-indicator">
        <img src='<%=cpath%>/images/logo_new.png'
		style='margin-right:8px;' align='absmiddle' />
	<br/>
        Loading&hellip;
    </div>
</div>

<div id='header'>
	<img class='header_logo' src='<%=cpath%>/images/logo_new.png'/>
	<span class='title'>Sistem Informasi K3PL</span>
	<span class='subtitle'>SBU Distribusi Wilayah I</span>
</div>

<div class='user'>
<span><%= user_name + "&nbsp;&nbsp ("+ user_nipg +")"%></span>
&nbsp;&nbsp; | &nbsp;&nbsp;
<a class="logout" href="#" onclick='do_logout()'>Logout</a>
</div>

<div id='msg'></div>
<div id='content'></div>

<div id='footer'>
&copy; 2011 - PT. Perusahaan Gas Negara (Persero) Tbk.
</div>

</body>
</html>
