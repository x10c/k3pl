<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya (prasetya.yanuar@gmail.com)
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try{
	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String id_project		= request.getParameter("id_project");
	String no_project		= request.getParameter("no_project");
	String nama_project		= request.getParameter("nama_project");
	String tanggal_mulai	= request.getParameter("tanggal_mulai");
	String durasi			= request.getParameter("durasi");
	String keterangan		= request.getParameter("keterangan");

	db_stmt = db_con.createStatement();

	switch (dml) {
	case 2:
		db_q=" insert into r_project (no_project, nama_project, tanggal_mulai, durasi, keterangan, id_user, id_divprosbu, id_direktorat)"
			+" values ('"+ no_project +"','"+ nama_project +"','"+ tanggal_mulai +"'"
			+" ,'"+ durasi +"'"+" ,'"+keterangan +"'"
			+" ,'"+ user_nipg +"'" +" ,"+ user_div +" ,"+ user_dir + ")";
		break;
	case 3:
		db_q=" update	r_project"
			+" set		no_project		= '"+ no_project+"'"
			+" ,		nama_project	= '"+ nama_project +"'"
			+" ,		tanggal_mulai	= '"+ tanggal_mulai +"'"
			+" ,		durasi			= '"+ durasi +"'"
			+" ,		keterangan		= '"+ keterangan +"'"
			+" ,		id_divprosbu	=  "+ user_div
			+" ,		id_direktorat	=  "+ user_dir
			+" ,		id_user			= '"+ user_nipg +"'"
			+" ,		tanggal_akses	= getdate()"
			+" where	id_project	= "+ id_project;
		break;
	case 4:
		db_q= " delete from r_project where id_project = "+ id_project;
		break;
	default:
		_return.put ("success", false);
		_return.put ("info", "DML tipe tidak diketahui ("+dml+")!");
		out.print (_return);
		return;
	}

	db_q+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

	_return.put ("success", true);
	_return.put ("info", "Data telah tersimpan.");
} catch (Exception e){
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
