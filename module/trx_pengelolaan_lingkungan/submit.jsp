<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_user = (String) session.getAttribute("user.nipg");

	int			dml								= Integer.parseInt(request.getParameter("dml_type"));
	String		id_pengelolaan_lingkungan		= request.getParameter("id_pengelolaan_lingkungan");
	String		id_wilayah						= request.getParameter("id_wilayah");
	String		tanggal_pengelolaan_lingkungan	= request.getParameter("tanggal_pengelolaan_lingkungan");
	String		lokasi_pengelolaan_lingkungan	= request.getParameter("lokasi_pengelolaan_lingkungan");
	String		tipe_station					= request.getParameter("tipe_station");
	String		parameter						= request.getParameter("parameter");
	String		sumber_dampak					= request.getParameter("sumber_dampak");
	String		q;

	Date		date	= new Date();

	switch (dml) {
	case 2:
		id_pengelolaan_lingkungan	= Long.toString(date.getTime());

		q	=" insert into t_pengelolaan_lingkungan (id_pengelolaan_lingkungan, id_wilayah, tanggal_pengelolaan_lingkungan, "
			+" lokasi_pengelolaan_lingkungan, tipe_station, parameter, sumber_dampak, id_user) "
			+" values ("+ id_pengelolaan_lingkungan +" ,"+ id_wilayah +" ,'"+ tanggal_pengelolaan_lingkungan +"' , "
			+" '"+ lokasi_pengelolaan_lingkungan +"' ,'"+ tipe_station +"' ,'"+ parameter +"' ,'"+ sumber_dampak +"' ,'"+ id_user +"' )";
		break;

	case 3:
		q	=" update t_pengelolaan_lingkungan "
			+" set "
			+"   id_wilayah						= "+ id_wilayah
			+" , tanggal_pengelolaan_lingkungan	= cast('"+ tanggal_pengelolaan_lingkungan +"' as datetime) "
			+" , lokasi_pengelolaan_lingkungan	= '"+ lokasi_pengelolaan_lingkungan +"' "
			+" , tipe_station					= '"+ tipe_station +"' "
			+" , parameter						= '"+ parameter +"' "
			+" , sumber_dampak					= '"+ sumber_dampak +"' "
			+" , id_user						= '"+ id_user +"' "
			+" , tanggal_akses					= getdate() "
			+" where id_pengelolaan_lingkungan	=  "+ id_pengelolaan_lingkungan;
		break;

	case 4:
		q	=" delete from t_pengelolaan_lingkungan "
			+" where  id_pengelolaan_lingkungan =  "+ id_pengelolaan_lingkungan;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
