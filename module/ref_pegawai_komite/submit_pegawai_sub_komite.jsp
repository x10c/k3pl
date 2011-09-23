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
	Statement	db_stmt = db_con.createStatement();
	
	String dml 		= request.getParameter("dml_type");
	String nipg	= request.getParameter("nipg");
	String id_jabatan_sub_komite	= request.getParameter("id_jabatan_sub_komite");
	String id_user		= (String) session.getAttribute("user.nipg");
	String q;
	
	if (dml.equals("insert")) {
		q	=" insert into t_pegawai_sub_komite (nipg, id_jabatan_sub_komite, id_user) "
			+" values ('"+ nipg +"', '"+ id_jabatan_sub_komite +"', '"+ id_user +"' )";
	}
	else if (dml.equals("update")){
		q	=" update	t_pegawai_sub_komite "
			+" set		id_jabatan_sub_komite	= '"+ id_jabatan_sub_komite +"' "
			+" ,		id_user		= '"+ id_user +"' "
			+" ,		tanggal_akses	= getdate() "
			+" where	nipg	= "+ nipg;
	}
	else if (dml.equals("delete")){
		q = " delete from t_pegawai_sub_komite where nipg = "+ nipg;
	}
	else{
		out.print("{ success: false"
			+ ", info : 'DML tipe tidak diketahui ("+ dml +")!' }");
		return;
	}
	
	db_stmt.executeUpdate(q);
	
	out.print("{ success: true, info:'Data telah tersimpan.' }");
} catch (Exception e){
	out.print("{ success: false, info : '"+ e +"' }");
}
%>
