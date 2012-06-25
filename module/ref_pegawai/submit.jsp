<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	String		id_user	= (String) session.getAttribute("user.nipg");

	int dml = Integer.parseInt(request.getParameter("dml_type"));
	String nipg		= request.getParameter("nipg");
	String nama_pegawai	= request.getParameter("nama_pegawai");
	String email		= request.getParameter("email");
	String id_klas		= request.getParameter("id_klasifikasi_pegawai");
	String id_jabatan	= request.getParameter("id_jabatan");
	String id_direktorat	= request.getParameter("id_direktorat");
	String id_divprosbu		= request.getParameter("id_divprosbu");
	String id_departemen	= request.getParameter("id_departemen");
	String id_dinas		= request.getParameter("id_dinas");
	String id_seksi		= request.getParameter("id_seksi");
	String status_pegawai	= request.getParameter("status_pegawai");

	nama_pegawai = nama_pegawai.replace("'", "''");

	switch (dml) {
	case 2:
		q	=" insert into r_pegawai ("
			+"	nipg"
			+",	nama_pegawai"
			+",	email"
			+",	id_klasifikasi_pegawai"
			+",	id_jabatan"
			+",	id_direktorat "
			+",	id_divprosbu "
			+",	id_departemen "
			+",	id_dinas "
			+",	id_seksi "
			+",	status_pegawai "
			+",	id_user "
			+") values ("
			+"  '"+ nipg		+"' "
			+", '"+ nama_pegawai	+"' "
			+", '"+ email		+"' "
			+",  "+ id_klas		+" "
			+",  "+ id_jabatan	+" "
			+",  "+ id_direktorat
			+",  "+ id_divprosbu
			+",  "+ id_departemen
			+",  "+ id_dinas
			+",  "+ id_seksi
			+", '"+ status_pegawai	+"' "
			+", '"+ id_user		+"'); ";
		break;
	case 3:
		q	=" update	r_pegawai "
			+" set		nama_pegawai		= '"+ nama_pegawai +"'"
			+" ,		email			= '"+ email +"' "
			+" ,		id_klasifikasi_pegawai	= "+ id_klas
			+" ,		id_jabatan		= "+ id_jabatan
			+" ,		id_direktorat		= "+ id_direktorat
			+" ,		id_divprosbu		= "+ id_divprosbu
			+" ,		id_departemen		= "+ id_departemen
			+" ,		id_dinas		= "+ id_dinas
			+" ,		id_seksi		= "+ id_seksi
			+" ,		status_pegawai		= '"+ status_pegawai +"'"
			+" ,		id_user			= '"+ id_user +"' "
			+" ,		tanggal_akses		= getdate() "
			+" where	nipg			= '"+ nipg +"'"
			+";";

		if (status_pegawai.equals("0")) {
			q	+=" update	__user"
				+" set		status_user	= '0'"
				+" where	nipg		= '"+ nipg +"'"
				+";"
				+" delete from	__user_grup"
				+" where	nipg = '"+ nipg +"'";
		} else if (status_pegawai.equals("1")) {
			q	+=" update	__user"
				+" set		status_user	= '1'"
				+" where	nipg		= '"+ nipg +"'"
				+";";
		}
		break;
	case 4:
		q	=" delete from	r_pegawai "
			+" where	nipg = '"+ nipg +"' ";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	q	+="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
