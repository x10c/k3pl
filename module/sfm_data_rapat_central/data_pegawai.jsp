<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Statement	db_stmt = db_con.createStatement();
	String id_jabatan_komite= "";
	String q= " select	A.nipg "
		+ " ,		A.nama_pegawai "
		+ " ,		B.id_jabatan_komite "
		+ " from	r_pegawai as A"
		+ " left join t_pegawai_komite_sub_komite as B on B.nipg = A.nipg "
		+ " where	status_pegawai = '1' "
		+ " order by	nipg ";

	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		id_jabatan_komite = rs.getString("id_jabatan_komite");
		if (rs.getString("id_jabatan_komite") == null)
			{
				id_jabatan_komite = "";
			}
		data	+= "[ '"+ rs.getString("nipg") +"' "
			+  ", '"+ rs.getString("nama_pegawai") +"' "
			+  ", '"+ id_jabatan_komite +"' "
			+  "] ";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e +"'}");
}
%>
