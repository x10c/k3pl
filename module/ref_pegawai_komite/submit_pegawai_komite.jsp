<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - Prasetya (prasetya.yanuar@googlemail.com)
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
	
	int dml						= Integer.parseInt(request.getParameter("dml_type"));
	String nipg					= request.getParameter("nipg");
	String id_jabatan_komite	= request.getParameter("id_jabatan_komite");
	String id_kel				= request.getParameter("id_kel");
	String id_user				= (String) session.getAttribute("user.nipg");
	String id_grup				= "";
	String q;
	String p = "";

	if (id_kel.equals("1")){
		id_grup = "3";
	}else{
		id_grup = "4";
	}

	switch (dml) {
	case 2:
		q	=" insert into t_pegawai_komite_sub_komite (nipg, id_jabatan_komite, id_user) "
			+" values ('"+ nipg +"', '"+ id_jabatan_komite +"', '"+ id_user +"' )";

		p 	=" if not exists("
					+"	select	*"
					+"	from	__user_grup where nipg ='"+nipg+"' and id_grup = "+id_grup
					+" ) begin"
					+"	insert into __user_grup ("
					+"		nipg "
					+"	,	id_grup "
					+"	) values ( "
					+"	'"+nipg+"' "
					+"	, "+ id_grup+") "
					+"end;";
		break;
	case 3:
		q	=" update	t_pegawai_komite_sub_komite "
			+" set		id_jabatan_komite	= "+ id_jabatan_komite +" "
			+" ,		id_user		= '"+ id_user +"' "
			+" ,		tanggal_akses	= getdate() "
			+" where	nipg	= '"+ nipg +"' ";
		break;
	case 4:
		q = " delete from t_pegawai_komite_sub_komite where nipg = '"+ nipg +"' ";
		p = " delete from __user_grup where nipg = +'"+nipg+"' and id_grup ="+id_grup;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);
	
	if (!p.equals("")){
		db_stmt.executeUpdate(p);
	}
	
	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
