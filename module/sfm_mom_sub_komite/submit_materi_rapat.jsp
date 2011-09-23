<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %   - Prasetya Yanuar (mieh100freak@gmail.com)
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
	Statement	db_stmt = db_con.createStatement();

	String dml			= request.getParameter("dml_type");
	String id_rapat		= request.getParameter("id_rapat");
	String id_rapat_materi	= request.getParameter("id_rapat_materi");
	String isi_rapat_materi	= request.getParameter("isi_rapat_materi");
	String batas_waktu_materi		= request.getParameter("batas_waktu_materi");
	String status_materi	= request.getParameter("status_materi");
	String keterangan_materi	= request.getParameter("keterangan_materi");
	String nipg_pelaksana	= request.getParameter("nipg_pelaksana");
	String nipg_supervisor	= request.getParameter("nipg_supervisor");
	String id_user			= (String) session.getAttribute("user.nipg");
	String q;
	Date		date	= new Date();
	String p = "";
	String s = "";
	if (id_rapat_materi.equals("")){
		id_rapat_materi = Long.toString(date.getTime());
	}

	if (dml.equals("insert")) {
		q	=" insert into t_rapat_materi ("
			+"		id_rapat "
			+"	,	id_rapat_materi "
			+"	,	isi_rapat_materi "
			+" ,	batas_waktu_materi "
			+" ,	status_materi "
			+"	,	keterangan_materi "
			+" ,	id_user "
			+" ) values ("
			+ id_rapat +", "
			+ id_rapat_materi +", '"
			+ isi_rapat_materi +"', "
			+" cast('"+  batas_waktu_materi +"' as datetime) , '"
			+ status_materi +"', '"
			+ keterangan_materi +"', '"
			+ id_user +"' )";
		p	= "insert into t_pic_rapat_materi ("
			+" 		id_rapat "
			+" , 	id_rapat_materi "
			+" ,	nipg "
			+" , 	id_user "
			+" ) values ("
			+ id_rapat +", "
			+ id_rapat_materi +", '"
			+ nipg_pelaksana +"', '"
			+ id_user +"' )";
		s	= "insert into t_pic_rapat_materi_detail ("
			+" 		id_rapat "
			+" , 	id_rapat_materi "
			+" ,	nipg "
			+" , 	id_user "
			+" ) values ("
			+ id_rapat +", "
			+ id_rapat_materi +", '"
			+ nipg_supervisor +"', '"
			+ id_user +"' )";	

	} else if (dml.equals("update")) {
		q	=" update	t_rapat_materi "
			+" set		isi_rapat_materi	= '"+ isi_rapat_materi +"' "
			+" ,		batas_waktu_materi			= cast('"+  batas_waktu_materi +"' as datetime) "
			+" ,		status_materi			= '"+ status_materi +"' "
			+" ,		keterangan_materi			= '"+ keterangan_materi +"' "
			+" ,		nipg_pelaksana			= '"+ nipg_pelaksana +"' "
			+" ,		nipg_supervisor			= '"+ nipg_supervisor +"' "
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	id_rapat	=  "+ id_rapat +" and id_rapat_materi = "+ id_rapat_materi;

	} else if (dml.equals("delete")) {
		q	=" delete from	t_rapat_materi "
			+" where	id_rapat   =  "+ id_rapat +" and id_rapat_materi = "+ id_rapat_materi;
	} else {
		out.print("{ success:false"
			+ ", info   :'DML tipe tidak diketahui ("+ dml +")!'}");
		return;
	}
	
	db_stmt.executeUpdate(q);
	if (!p.equals("")){
		db_stmt.executeUpdate(p);
		db_stmt.executeUpdate(s);
	}

	out.print("{ success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{ success:false, info:'"+ e +"'}");
}
%>
