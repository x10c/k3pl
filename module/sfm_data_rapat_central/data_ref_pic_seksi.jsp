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
	String p=" select	A.id_kel_jabatan_csc "
		+" ,		C.id_direktorat "
		+" ,		C.id_divprosbu "
		+" from		r_jabatan_komite_sub_komite A "
		+" left join  t_pegawai_komite_sub_komite B on (B.id_jabatan_komite = A.id_jabatan_komite) "
		+" left join R_KEL_JABATAN_CSC C on (C.ID_KEL_JABATAN_CSC = A.ID_KEL_JABATAN_CSC) "
		+" where B.nipg = '"+ id_user +"' and A.notulen in ('1','3') "
		+" order by	A.id_kel_jabatan_csc ";
		
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
			+"	select		a.id_seksi "
			+" 		,		a.id_dinas "
			+" 		,		a.id_departemen "
			+" 		,		a.nama_seksi "
			+" 		,		( "
			+"					select	nipg "
			+"					from	( "
			+"								select	b.nipg								as nipg "
			+"									,	row_number() over(order by b.nipg)	as row_num "
			+"								from	r_pegawai	as b "
			+"								where	b.id_seksi 			= a.id_seksi "
			+"								and		b.id_jabatan		= 7 "
			+"								and		b.status_pegawai	= '1' "
			+"							)	as hasil "
			+"					where	row_num between 1 and 1 "
			+" 				)	as kepala_seksi "
			+"	from		r_seksi as a "
			+"	where		a.id_direktorat = "+id_direktorat +" and a.id_divprosbu = "+ id_divprosbu
			+" 	order by	a.nama_seksi ";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "[ '"+ rs.getString("id_seksi") +"' "
			+  ", '"+ rs.getString("id_dinas") +"'"
			+  ", '"+ rs.getString("id_departemen") +"'"
			+  ", '"+ rs.getString("nama_seksi") +"' "
			+  ", '"+ rs.getString("kepala_seksi") +"' "
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
