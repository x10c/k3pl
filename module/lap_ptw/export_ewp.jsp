<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String		q		= "";
String		id_ptw	= request.getParameter("id_ptw");

String		ptw_tgl_sah		= "";
String		pil_nama		= "";
String		pil_jab			= "";
String		pukg_nama		= "";
String		pukg_jab		= "";
String		pp_nama			= "";
String		pp_jab			= "";
String		mk_nama			= "";
String		mk_jab			= "";
String		catatan			= "";

ResultSet	rs		= null;
int			i;

try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();
%>

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>ELECTRICAL WORK PERMIT</title>
<style type="text/css">
<![CDATA[
html {
	padding		: 10px;
	font-family	: sans;
}

body {
	width		: 98%;
}

table, th, td {
	border			: 1px solid black;
	padding			: 4px;
	vertical-align	: middle;
}

table {
	border-collapse	: collapse;
}

th {
	font-weight		: bold;
}

.header {
	width			: 100%;
}

.div-center {
	font-weight			: bold;
	margin				: 10px auto 10px auto;
	text-align			: center;
	vertical-align		: middle;
}

.ewp_no {
	border-bottom		: 2px dotted black;
}

.content {
	background			: blue;
	border				: 1px solid black;
	padding				: 6px;
}

.content-box {
	background			: white;
	border				: 1px solid black;
	margin				: 4px 0px 4px 0px;
	padding				: 4px 10px 10px 4px;
}

.content-table {
	width		: auto;
	margin		: 10px auto 0px 20px;
	border		: 0px;
	font-weight	: normal;
}

.tcenter {
	text-align	: center;
}

.theader {
	text-align	: center;
	background	: blue;	
	color		: white;
}

.thdr {
	border-right	: 0px;
}

.thdr-left {
	text-align	: left;
}

.tsep {
	border-left		: 0px;
	border-right	: 0px;
}

.tval {
	border-left		: 0px;
}

.tnone {
	border			: 0px;
}

]]>
</style>
</head>

<body>
<!-- header -->
<table class="header">
<tr>
	<th class="tcenter" width="100"><img src="../../images/logo_new.png" width="60" height="70"/></th>
	<th class="theader">
INSTRUKSI KERJA<br/>
IJIN KERJA LISTRIK (<i>ELECTRICAL WORK PERMIT</i>) <br/>
PT PERUSAHAAN GAS NEGARA (Persero) Tbk <br/>
	</th>
	<th class="tcenter" width="100"></th>
</tr>
</table>

<%
	q	=" select	nomor															as ewp_no"
		+" ,		replace(convert(varchar, tgl_pengesahan, 111), '/', '-')		as a_tgl"
		+" ,		replace(convert(varchar, masa_berlaku_awal, 111), '/', '-')		as a_laku_tgl_start"
		+" ,		replace(convert(varchar, masa_berlaku_akhir, 111), '/', '-')	as a_laku_tgl_end"
		+" ,		lokasi_pekerjaan					as a_lokasi"
		+" ,		pelaksana_pekerjaan					as a_pelaksana"
		+" ,		uraian_pekerjaan					as a_uraian"
		+" ,		nama_petugas_isolasi_listrik		as h_pil_nama"
		+" ,		jabatan_petugas_isolasi_listrik		as h_pil_jab"
		+" ,		nama_petugas_uji_kandungan_gas		as h_pukg_nama"
		+" ,		jabatan_petugas_uji_kandungan_gas	as h_pukg_jab"
		+" ,		nama_pelaksana_pekerjaan			as i_pp_nama"
		+" ,		jabatan_pelaksana_pekerjaan			as i_pp_jab"
		+" ,		nama_pejabat_berwenang				as i_mk_nama"
		+" ,		jabatan_pejabat_berwenang			as i_mk_jab"
		+" ,		catatan"
		+" from		t_ptw"
		+" where	jenis_ptw	= 5"
		+" and		id_ptw		= "+ id_ptw;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		return;
	}

	ptw_tgl_sah = rs.getString("a_tgl");
	pil_nama	= rs.getString("h_pil_nama");
	pil_jab		= rs.getString("h_pil_jab");
	pukg_nama	= rs.getString("h_pukg_nama");
	pukg_jab	= rs.getString("h_pukg_jab");
	pp_nama		= rs.getString("i_pp_nama");
	pp_jab		= rs.getString("i_pp_jab");
	mk_nama		= rs.getString("i_mk_nama");
	mk_jab		= rs.getString("i_mk_jab");
	catatan		= rs.getString("catatan");
%>

<div class="div-center"><span class="ewp_no">NO. <%= rs.getString("ewp_no") %></span></div>
<div class="content">
<div class="content-box">
<b> A. UMUM </b>
<table class="content-table">
	<tr><td class="thdr">Nomor</td><td class="tsep">:</td>
		<td class="tval" colspan="5">
			<%= rs.getString("ewp_no") %>
		</td>
	</tr>
	<tr><td class="thdr">Tanggal Pengesahan</td><td class="tsep">:</td>
		<td class="tval" colspan="5">
			<%= ptw_tgl_sah %>
		</td>
	</tr>
	<tr><td class="thdr">Masa Berlaku</td><td class="tsep">:</td>
		<td class="thdr tval">Tanggal</td>
		<td class="tsep">:</td>
		<td class="tval tsep" width="200">
			<%= rs.getString("a_laku_tgl_start") %>
		</td>
		<td class="tsep">s/d</td><td class="tval" width="200">
			<%= rs.getString("a_laku_tgl_end") %>
		</td>
	</tr>
	<tr><td class="thdr">Lokasi Pekerjaan</td><td class="tsep">:</td>
		<td colspan="5" class="tval">
			<%= rs.getString("a_lokasi") %>
		</td>
	</tr>
	<tr><td class="thdr">Pelaksana Pekerjaan</td><td class="tsep">:</td>
		<td colspan="6" class="tval">
			<%= rs.getString("a_pelaksana") %>
		</td>
	</tr>
	<tr><td class="thdr">Uraian Pekerjaan</td><td class="tsep">:</td>
		<td colspan="5" class="tval">
			<%= rs.getString("a_uraian") %>
		</td>
	</tr>
</table>
</div>

<div class="content-box">
<b> B. ALAT PELINDUNG DIRI </b>
<table class="content-table">
<%
q
=" select	B.nama_alat_pelindung_diri_ptw	as name"
+" ,		isnull(A.v,'')					as v"
+" from	("
+"	select	A.id_alat_pelindung_diri_ptw"
+" 	,		B.nama_alat_pelindung_diri_ptw"
+" 	,		A.keterangan as v"
+" 	from	t_ptw_alat_pelindung_diri	A"
+" 	,		r_alat_pelindung_diri_ptw	B"
+" 	where	A.id_alat_pelindung_diri_ptw	= B.id_alat_pelindung_diri_ptw"
+" 	and		A.id_ptw						= "+ id_ptw
+" ) A"
+" right join ("
+" 	select	id_alat_pelindung_diri_ptw"
+" 	,		nama_alat_pelindung_diri_ptw"
+" 	,		null as v"
+" 	from	r_alat_pelindung_diri_ptw"
+" ) B"
+" on	A.id_alat_pelindung_diri_ptw = B.id_alat_pelindung_diri_ptw";

rs = db_stmt.executeQuery(q);

while (rs.next()) {
	out.print("<tr><td class='thdr'>"+ rs.getString("name") +"</td>"
			+ "<td class='tsep'>:</td>"
			+ "<td class='tval'>"+ rs.getString("v") +"</td></tr>");
}

rs.close();
%>
</table>
</div>

<div class="content-box">
<b> C. DOKUMEN PENDUKUNG </b>
	<div class="content-table">
	<ol type='a'>
<%
q
=" select	JSA.no_dokumen"
+" from		t_jsa	JSA"
+" ,		t_ptw	PTW"
+" where	PTW.id_jsa = JSA.id_jsa"
+" and		PTW.id_ptw = "+ id_ptw;

rs = db_stmt.executeQuery(q);

while (rs.next()) {
	out.print("<li>"+ rs.getString("no_dokumen") +"</li>");
}

rs.close();
%>
	</ol>
	</div>
</div>

<div class="content-box">
<b> D. SAFETY CHECKLIST </b>
<table class="content-table">
<tr><th>Item</th><th>Status</th><th width="400">Keterangan</th></tr>
<%
q
=" select	B.nama_safety_checklist_ptw					as name"
+" ,		case A.v when 1 then 'Ya' else 'Tidak' end	as v"
+" ,		A.ket"
+" from	("
+" 	select	A.id_safety_checklist_ptw"
+" 	,		B.nama_safety_checklist_ptw"
+" 	,		A.status		as v"
+"	,		A.keterangan	as ket"
+" 	from	t_ptw_safety_checklist	A"
+" 	,		r_safety_checklist_ptw	B"
+" 	where	A.id_safety_checklist_ptw = B.id_safety_checklist_ptw"
+" 	and		A.id_ptw = "+ id_ptw
+" ) A"
+" right join ("
+" 	select	id_safety_checklist_ptw"
+" 	,		nama_safety_checklist_ptw"
+" 	,		0	as v"
+"	,		''	as ket"
+" 	from	r_safety_checklist_ptw"
+" 	where	jenis_ptw = 5"
+" ) B"
+" on	A.id_safety_checklist_ptw = B.id_safety_checklist_ptw";

rs = db_stmt.executeQuery(q);
while (rs.next()) {
	out.print("<tr><td>"+ rs.getString("name") +"</td>"
			+ "<td>"+ rs.getString("v") +"</td>"
			+ "<td width='400'>"+ rs.getString("ket") +"</th></tr>");
}
rs.close();
%>
</table>
</div>

<div class="content-box">
<b> E. UJI KANDUNGAN </b>
<table class="content-table">
<tr><th>Gas Item</th><th>Standard</th><th width="400">Hasil</th></tr>

<%
q
=" select	B.name"
+" ,		B.standard"
+" ,		isnull(A.v,'')	as v"
+" from	("
+" 	select	A.id_uji_kandungan_gas_ptw"
+" 	,		A.hasil						as v"
+" 	from	t_ptw_uji_kandungan_gas		A"
+" 	,		r_uji_kandungan_gas_ptw		B"
+" 	where	A.id_uji_kandungan_gas_ptw = B.id_uji_kandungan_gas_ptw"
+" 	and		A.id_ptw = " + id_ptw
+" ) A"
+" right join ("
+" 	select	id_uji_kandungan_gas_ptw"
+" 	,		nama_uji_kandungan_gas_ptw	as name"
+" 	,		standard"
+" 	from	r_uji_kandungan_gas_ptw"
+" ) B"
+" on	A.id_uji_kandungan_gas_ptw = B.id_uji_kandungan_gas_ptw";

rs = db_stmt.executeQuery(q);

while (rs.next()) {
	out.print("<tr>"
			+ "<td>"+ rs.getString("name") +"</td>"
			+ "<td>"+ rs.getString("standard") +"</td>"
			+ "<td>"+ rs.getString("v") +"</td>"
			+ "</tr>");
}

rs.close();
%>
</table>
</div>

<div class="content-box">
<b> F. PETUGAS PENGAWAS </b>
<br/><br/>

Petugas Isolasi Listrik <br/>
<table class="content-table">
	<tr><th class="thdr-left">Nama</th>						<td>:</td><td width='200'><%= pil_nama %></td></tr>
	<tr><th class="thdr-left" height='60'>Tandatangan</th>	<td>:</td><td></td></tr>
	<tr><th class="thdr-left">Jabatan</th>					<td>:</td><td><%= pil_jab %></td></tr>
	<tr><th class="thdr-left">Tanggal</th>					<td>:</td><td><%= ptw_tgl_sah %></td></tr>
</table><br/>

Petugas Uji Kandungan Gas
<table class="content-table">
	<tr><th class="thdr-left">Nama</th>						<td>:</td><td width='200'><%= pukg_nama %></td></tr>
	<tr><th class="thdr-left" height='60'>Tandatangan</th>	<td>:</td><td></td></tr>
	<tr><th class="thdr-left">Jabatan</th>					<td>:</td><td><%= pukg_jab %></td></tr>
	<tr><th class="thdr-left">Tanggal</th>					<td>:</td><td><%= ptw_tgl_sah %></td></tr>
</table>
</div>

<div class="content-box">
<b> G. PENGESAHAN </b>
<br/><br/>
Saya memahami semua tindakan pencegahan dan akan menghubungi Pejabat Operasi yang berwenang.
<br/><br/>
Pelaksana Pekerjaan
<table class="content-table">
	<tr><th class="thdr-left">Nama</th>						<td>:</td><td width='200'><%= pp_nama %></td></tr>
	<tr><th class="thdr-left" height='60'>Tandatangan</th>	<td>:</td><td></td></tr>
	<tr><th class="thdr-left">Jabatan</th>					<td>:</td><td><%= pp_jab %></td></tr>
	<tr><th class="thdr-left">Tanggal</th>					<td>:</td><td><%= ptw_tgl_sah %></td></tr>
</table>
<br/><br/>
Saya sendiri telah memeriksa lokasi dan keadaannya, ijin ini menjamin untuk pekerjaan pada saat beroperasi.
<br/><br/>
Manajer K3PL atau Pejabat yang berwenang
<table class="content-table">
	<tr><th class="thdr-left">Nama</th>						<td>:</td><td width='200'><%= mk_nama %></td></tr>
	<tr><th class="thdr-left" height='60'>Tandatangan</th>	<td>:</td><td></td></tr>
	<tr><th class="thdr-left">Jabatan</th>					<td>:</td><td><%= mk_jab %></td></tr>
	<tr><th class="thdr-left">Tanggal</th>					<td>:</td><td><%= ptw_tgl_sah %></td></tr>
</table>
</div>

<div class="content-box">
<b> Validasi: </b>
<table class="content-table">
<tr> <th rowspan='2'>Hari</th> <th colspan='2'>Waktu</th> <th colspan='2'>Pelaksana</th> <th colspan='2'>Pengawas</th> </tr>
<tr> <th>Mulai</th> <th>Selesai</th> <th>Nama</th> <th>Inisial</th> <th>Nama</th> <th>Inisial</th></tr>
<%
q
=" select	hari"
+" ,		waktu_mulai"
+" ,		waktu_selesai"
+" ,		nama_pelaksana"
+" ,		inisial_pelaksana"
+" ,		nama_pengawas"
+" ,		inisial_pengawas"
+" from		t_ptw_validasi"
+" where	id_ptw = "+ id_ptw;

rs = db_stmt.executeQuery(q);

while (rs.next()) {
	out.print("<tr>"
			+ "<td>"+ rs.getString("hari") +"</td>"
			+ "<td>"+ rs.getString("waktu_mulai") +"</td>"
			+ "<td>"+ rs.getString("waktu_selesai") +"</td>"
			+ "<td>"+ rs.getString("nama_pelaksana") +"</td>"
			+ "<td>"+ rs.getString("inisial_pelaksana") +"</td>"
			+ "<td>"+ rs.getString("nama_pengawas") +"</td>"
			+ "<td>"+ rs.getString("inisial_pengawas") +"</td>"
			+ "</tr>");
}

rs.close();
%>
</table>
</div>

<div class="content-box">
<b> Catatan: </b>
<br/>
<%= catatan %>
</div>

</div><!-- content -->

</body>
</html>

<%
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.getMessage().replace("'","\\'") +"'}");
}
%>
