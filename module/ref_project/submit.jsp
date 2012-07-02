<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya (prasetya.yanuar@gmail.com)
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String id_project		= request.getParameter("id_project");
	String no_project		= request.getParameter("no_project");
	String nama_project		= request.getParameter("nama_project");
	String tanggal_mulai	= request.getParameter("tanggal_mulai");
	String durasi			= request.getParameter("durasi");
	String keterangan		= request.getParameter("keterangan");
	String id_user			= (String) session.getAttribute("user.nipg");
	String id_divprosbu		= (String) session.getAttribute ("user.divprosbu");
	String id_direktorat	= (String) session.getAttribute ("user.direktorat");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_project (no_project, nama_project, tanggal_mulai, durasi, keterangan, id_user, id_divprosbu, id_direktorat)"
			+" values ('"+ no_project +"'" +" ,'"+ nama_project +"'" +" ,'"+tanggal_mulai+"'" +" ,'"+ durasi +"'" +" ,'"+keterangan +"'" +" ,'"+id_user +"'" +" ,"+ id_divprosbu +" ,"+ id_direktorat + ")";
		break;
	case 3:
		q	=" update	r_project"
			+" set		no_project		= '"+ no_project+"'"
			+" ,		nama_project	= '"+ nama_project +"'"
			+" ,		tanggal_mulai	= '"+ tanggal_mulai +"'"
			+" ,		durasi			= '"+ durasi +"'"
			+" ,		keterangan		= '"+ keterangan +"'"
			+" ,		id_divprosbu	=  "+ id_divprosbu
			+" ,		id_direktorat	=  "+ id_direktorat
			+" ,		id_user			= '"+ id_user +"'"
			+" ,		tanggal_akses	= getdate()"
			+" where	id_project	= "+ id_project;
		break;
	case 4:
		q = " delete from r_project where id_project = "+ id_project;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
