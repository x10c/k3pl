<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %	 - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con		= (Connection) session.getAttribute("db.con");
	Statement	db_stmt		= db_con.createStatement();
	
	String id_user		= (String) session.getAttribute("user.nipg");
	String p=" select	A.id_kel_jabatan_komite_sub_komite "
		+" ,		C.id_direktorat "
		+" ,		C.id_divprosbu "
		+" from		r_jabatan_komite_sub_komite A "
		+" left join  t_pegawai_komite_sub_komite B on (B.id_jabatan_komite = A.id_jabatan_komite) "
		+" left join R_KEL_JABATAN_KOMITE_SUB_KOMITE C on (C.ID_KEL_JABATAN_KOMITE_SUB_KOMITE = A.ID_KEL_JABATAN_KOMITE_SUB_KOMITE) "
		+" where B.nipg = "+ id_user +" and A.notulen in ('1','3') and A.id_kel_jabatan_komite_sub_komite is not null "
		+" order by	A.id_kel_jabatan_komite_sub_komite ";
		
	ResultSet	rs_kel = db_stmt.executeQuery(p);
	
	String id_direktorat = "";
	String id_divprosbu = "";
	if (rs_kel.next()){
		id_direktorat = rs_kel.getString("id_direktorat");
		id_divprosbu = rs_kel.getString("id_divprosbu");
	}else {
		out.print("{ success:false,info: tidak dapat menemukan anda dalam daftar anggota CSC");
	}
	
	String	q	=" "
			+"	select		a.id_dinas "
			+" 		,		a.id_departemen "
			+" 		,		a.nama_dinas "
			+" 		,		( "
			+"					select	nipg "
			+"					from	( "
			+"								select	b.nipg								as nipg "
			+"									,	row_number() over(order by b.nipg)	as row_num "
			+"								from	r_pegawai	as b "
			+"								where	b.id_dinas 			= a.id_dinas "
			+"								and		b.id_jabatan		= 3 "
			+"								and		b.status_pegawai	= '1' "
			+"							)	as hasil "
			+"					where	row_num between 1 and 1 "
			+" 				)	as kepala_dinas "
			+"	from		r_dinas as a "
			+"	where		a.id_direktorat = "+ id_direktorat +" and a.id_divprosbu = "+ id_divprosbu
			+" 	order by	a.nama_dinas ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_dinas") +"' "
			+  ", '"+ rs.getString("id_departemen") +"'"
			+  ", '"+ rs.getString("nama_dinas") +"'"
			+  ", '"+ rs.getString("kepala_dinas") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
