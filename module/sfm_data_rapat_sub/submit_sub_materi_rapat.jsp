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
	String id_rapat		;
	String id_rapat_materi	;
	String id_rapat_sub_materi	;
	String isi_rapat_sub_materi	;
	String batas_waktu_sub_materi;
	String status_sub_materi	;
	String keterangan_sub_materi;
	String nipg_pelaksana;
	String nipg_supervisor;
	String seksi_pelaksana;
	String dinas_supervisor;
	String id_user			= (String) session.getAttribute("user.nipg");
	int randomize		= Integer.parseInt(id_user);
	Date		date	= new Date();
	String q = "";
	String p = "";
	String s = "";
	int		i,j,l;
	JSONObject	data_obj;
	JSONArray	data	= new JSONArray((String) request.getParameter("data"));
	
	
	l = data.length();
	for (i = 0; i < l; i++) {
		data_obj = data.getJSONObject(i);
		id_rapat = data_obj.getString("id_rapat");
		id_rapat_materi 	= data_obj.getString("id_rapat_materi");
		id_rapat_sub_materi = data_obj.getString("id_rapat_sub_materi");
		isi_rapat_sub_materi 	= data_obj.getString("isi_rapat_sub_materi");
		batas_waktu_sub_materi	= data_obj.getString("batas_waktu_sub_materi");
		status_sub_materi		= data_obj.getString("status_sub_materi");
		keterangan_sub_materi	= data_obj.getString("keterangan_sub_materi");
		nipg_pelaksana		= data_obj.getString("nipg_pelaksana");
		nipg_supervisor		= data_obj.getString("nipg_supervisor");
		seksi_pelaksana		= data_obj.getString("seksi_pelaksana");
		dinas_supervisor		= data_obj.getString("dinas_supervisor");
		
		if (batas_waktu_sub_materi.equals("") || batas_waktu_sub_materi.equals("undefined") || batas_waktu_sub_materi.equals("-")){
				batas_waktu_sub_materi = null;
		}
		else{
			batas_waktu_sub_materi = "\'"+ batas_waktu_sub_materi +"\'";
		}
		if (keterangan_sub_materi.equals("") || keterangan_sub_materi.equals("undefined")){
			keterangan_sub_materi = null;
		}
		else{
			keterangan_sub_materi = "\'"+ keterangan_sub_materi +"\'";
		}
		if (nipg_pelaksana.equals("") || nipg_pelaksana.equals("undefined") || nipg_pelaksana.equals("'null'")){
				nipg_pelaksana = null;
		}
		
		if (dml.equals("insert")) {
		
			if (id_rapat_sub_materi.equals("") || id_rapat_sub_materi.equals("undefined")){
				id_rapat_sub_materi = Long.toString(date.getTime()) + ( i );
			}
			q	=" insert into t_rapat_sub_materi ("
			+"		id_rapat "
			+"	,	id_rapat_materi "
			+"	,	id_rapat_sub_materi "
			+"	,	isi_rapat_sub_materi "
			+" ,	batas_waktu_sub_materi "
			+" ,	status_sub_materi "
			+"	,	keterangan_sub_materi "
			+" ,	id_user "
			+" ) values ("
			+ id_rapat +", "
			+ id_rapat_materi +", "
			+ id_rapat_sub_materi +", '"
			+ isi_rapat_sub_materi +"', "
			+" cast("+  batas_waktu_sub_materi +" as datetime) , '"
			+ status_sub_materi +"', "
			+ keterangan_sub_materi +", '"
			+ id_user +"' )";
			if (seksi_pelaksana.equals("") || seksi_pelaksana.equals("undefined") || seksi_pelaksana.equals("-")){
				seksi_pelaksana = null;
			}
			else{
				p	= "insert into t_pic_rapat_sub_materi ("
					+" 		id_rapat "
					+" , 	id_rapat_materi "
					+" , 	id_rapat_sub_materi "
				+" ,	nipg_pelaksana "
				+" ,	seksi_pelaksana "
				+" ,	nipg_supervisor "
				+" ,	dinas_supervisor "
					+" , 	id_user "
					+" ) values ("
					+ id_rapat +", "
					+ id_rapat_materi +", "
					+ id_rapat_sub_materi +", '"
				+ nipg_pelaksana +"', "
				+ seksi_pelaksana +", '"
				+ nipg_supervisor +"', "
				+ dinas_supervisor +", '"
					+ id_user +"' )";
			}

		} else if (dml.equals("update")) {
			q	=" update	t_rapat_sub_materi "
				+" set		isi_rapat_sub_materi	= '"+ isi_rapat_sub_materi +"' "
				+" ,		batas_waktu_sub_materi			= cast("+  batas_waktu_sub_materi +" as datetime) "
				+" ,		status_sub_materi			= '"+ status_sub_materi +"' "
				+" ,		keterangan_sub_materi			= "+ keterangan_sub_materi +" "
				+" ,		id_user			= '"+ id_user +"' "
				+" ,		tanggal_akses		= getdate() "
				+" where	id_rapat	=  "+ id_rapat +" and id_rapat_materi = "+ id_rapat_materi +" and id_rapat_sub_materi = "+ id_rapat_sub_materi;

			if (nipg_pelaksana.equals("") || nipg_pelaksana.equals("undefined") || nipg_pelaksana.equals("-")){
				nipg_pelaksana = null;
			}
			else{
				p 	=" if exists("
					+"	select	*"
					+"	from	t_pic_rapat_sub_materi"
					+"	where	id_rapat	= "+ id_rapat
					+"	and	id_rapat_materi		= "+ id_rapat_materi
					+"  and id_rapat_sub_materi = "+ id_rapat_sub_materi
					+" ) begin"
					+"	update	t_pic_rapat_sub_materi"+"	set	nipg_pelaksana	= '"+ nipg_pelaksana +"' "
					+"	,	seksi_pelaksana	= "+ seksi_pelaksana 
					+"	,	nipg_supervisor	= '"+ nipg_supervisor +"' "
					+"	,	dinas_supervisor	= "+ dinas_supervisor 
					+"	,	id_user			= '"+ id_user +"'"
					+"	,	tanggal_akses		= getdate()"
					+"	where	id_rapat			= "+ id_rapat +" "
					+"	and	id_rapat_materi		= "+ id_rapat_materi
					+"  and id_rapat_sub_materi = "+ id_rapat_sub_materi
					+" end else begin "
					+" insert into t_pic_rapat_sub_materi ("
					+" 		id_rapat "
					+" , 	id_rapat_materi "
					+" , 	id_rapat_sub_materi "
					+" ,	nipg_pelaksana "
					+" ,	seksi_pelaksana "
					+" ,	nipg_supervisor "
					+" ,	dinas_supervisor "
					+" , 	id_user "
					+" ) values ("
					+ id_rapat +", "
					+ id_rapat_materi +", "
					+ id_rapat_sub_materi +", '"
					+ nipg_pelaksana +"', "
					+ seksi_pelaksana +", '"
					+ nipg_supervisor +"', "
					+ dinas_supervisor +", '"
					+ id_user +"' )"
					+"end;";
			}
		
		} else if (dml.equals("delete")) {
			q	=" delete from t_pic_rapat_sub_materi "
				+" where	id_rapat   =  "+ id_rapat +" and id_rapat_materi = "+ id_rapat_materi +" and id_rapat_sub_materi = "+ id_rapat_sub_materi;
			p	=" delete from	t_rapat_sub_materi "
				+" where	id_rapat   =  "+ id_rapat +" and id_rapat_materi = "+ id_rapat_materi +" and id_rapat_sub_materi = "+ id_rapat_sub_materi;

		}
		db_stmt.executeUpdate(q);
		if (!p.equals("")){
			db_stmt.executeUpdate(p);
			db_stmt.executeUpdate(s);
		}
	}
	
	out.print("{ success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{ success:false, info:'"+ e +"'}");
}
%>
