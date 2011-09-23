<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - prasetya (prasetya.yanuar@gmail.com)
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String q=" select	id_project"
		+" ,		no_project"
		+" ,		nama_project"
		+" ,		replace(convert(varchar, tanggal_mulai, 111), '/', '-') as tanggal_mulai "
		+" ,		durasi"
		+" ,		keterangan"
		+" ,(select count(id_project) from t_pha as b where  r_project.id_project = b.id_project) as pha "
		+" ,(select count(id_project) from t_pssr as c where  r_project.id_project = c.id_project) as pssr "
		+" ,(select count(id_project) from t_csm_proyek as d where  r_project.id_project = d.id_project) as csm "
		+" from		r_project"
		+" order by	id_project";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	int		pha,csm,pssr;
	pha = 0;
	csm = 0;
	pssr = 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		
		if (Integer.parseInt(rs.getString("pha")) > 0 ){
			pha = 1;
		}
		if (Integer.parseInt(rs.getString("pssr")) > 0 ){
			pssr = 1;
		}
		if (Integer.parseInt(rs.getString("csm")) > 0 ){
			csm = 1;
		}
		
		data 	+="[ "+ rs.getString("id_project")
			+ ",'"+ rs.getString("no_project") 
			+ "','"+ rs.getString("nama_project")
			+ "','"+ rs.getString("tanggal_mulai")
			+ "',"+ rs.getString("durasi")
			+ ",'"+ rs.getString("keterangan")
			+ "','"+ pha 
			+ "','"+ pssr 
			+ "','"+ csm
			+"' ] ";
		
		pha = 0;
		csm = 0;
		pssr = 0;
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
