<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../modinit.jsp" %>
<%
try {
	int		dml 			= Integer.parseInt(request.getParameter("dml_type"));
	String	nipg			= request.getParameter("nipg");
	String	nama_pegawai	= request.getParameter("nama_pegawai");
	String	email			= request.getParameter("email");
	String	id_klas			= request.getParameter("id_klasifikasi_pegawai");
	String	id_jabatan		= request.getParameter("id_jabatan");
	String	id_direktorat	= request.getParameter("id_direktorat");
	String	id_divprosbu	= request.getParameter("id_divprosbu");
	String	id_departemen	= request.getParameter("id_departemen");
	String	id_dinas		= request.getParameter("id_dinas");
	String	id_seksi		= request.getParameter("id_seksi");
	String	status_pegawai	= request.getParameter("status_pegawai");

	nama_pegawai = nama_pegawai.replace("'", "''");

	db_stmt = db_con.createStatement();

	switch (dml) {
	case 2:
		db_q=" insert into r_pegawai ("
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
			+", '"+ user_nipg +"'); ";
		break;
	case 3:
		db_q=" update	r_pegawai "
			+" set		nama_pegawai			= '"+ nama_pegawai +"'"
			+" ,		email					= '"+ email +"' "
			+" ,		id_klasifikasi_pegawai	= "+ id_klas
			+" ,		id_jabatan				= "+ id_jabatan
			+" ,		id_direktorat			= "+ id_direktorat
			+" ,		id_divprosbu			= "+ id_divprosbu
			+" ,		id_departemen			= "+ id_departemen
			+" ,		id_dinas				= "+ id_dinas
			+" ,		id_seksi				= "+ id_seksi
			+" ,		status_pegawai			= '"+ status_pegawai +"'"
			+" ,		id_user					= '"+ user_nipg +"' "
			+" ,		tanggal_akses			= getdate() "
			+" where	nipg					= '"+ nipg +"'"
			+";";

		if (status_pegawai.equals("0")) {
			db_q+=" update	__user"
				+" set		status_user	= '0'"
				+" where	nipg		= '"+ nipg +"'"
				+";"
				+" delete from	__user_grup"
				+" where	nipg = '"+ nipg +"'";
		} else if (status_pegawai.equals("1")) {
			db_q+=" update	__user"
				+" set		status_user	= '1'"
				+" where	nipg		= '"+ nipg +"'"
				+";";
		}
		break;
	case 4:
		db_q=" delete from	r_pegawai "
			+" where	nipg = '"+ nipg +"' ";
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
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
}
out.print (_return);
%>
