<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt		= db_con.createStatement();
	int			i, l;
	int			dml			= Integer.parseInt(request.getParameter("dml"));
	String		id			= request.getParameter("id");
	String		nama		= request.getParameter("nama");
	String		tipe		= request.getParameter("tipe");
	String		alamat		= request.getParameter("alamat");
	String		telp		= request.getParameter("telp");
	String		fax			= request.getParameter("fax");
	String		pemilik_nama	= request.getParameter("pemilik_nama");
	String		pemilik_alamat	= request.getParameter("pemilik_alamat");
	String		asuransi_status	= request.getParameter("asuransi_status");
	String		asuransi_pj		= request.getParameter("asuransi_pj");
	String		asuransi_alamat	= request.getParameter("asuransi_alamat");
	String		asuransi_telp	= request.getParameter("asuransi_telp");
	String		penawar_nama	= request.getParameter("penawar_nama");
	String		penawar_jab		= request.getParameter("penawar_jab");
	String		penawar_telp	= request.getParameter("penawar_telp");
	String		penawar_fax		= request.getParameter("penawar_fax");
	String		pengisi_nama	= request.getParameter("pengisi_nama");
	String		pengisi_jab		= request.getParameter("pengisi_jab");
	String		pengisi_telp	= request.getParameter("pengisi_telp");
	String		pengisi_fax		= request.getParameter("pengisi_fax");
	String		klaim_status	= request.getParameter("klaim_status");
	String		bangkrut_status	= request.getParameter("bangkrut_status");
	String		bangkrut_detail	= request.getParameter("bangkrut_detail");
	String		q_pul			= "";
	String		q_pim			= "";
	String		q_jul			= "";
	String		q_psd			= "";
	String		q_ptd			= "";
	String		q_klm			= "";
	JSONArray	pul				= new JSONArray(request.getParameter("pul"));
	JSONArray	pim				= new JSONArray(request.getParameter("pim"));
	JSONArray	jul				= new JSONArray(request.getParameter("jul"));
	JSONArray	psd				= new JSONArray(request.getParameter("psd"));
	JSONArray	ptd				= new JSONArray(request.getParameter("ptd"));
	JSONArray	klm				= new JSONArray(request.getParameter("klm"));
	JSONObject	o				= null;

	switch (dml) {
	case 2:
		q	=" insert into r_kontraktor ("
			+"		id"
			+" ,	nama"
			+" ,	tipe"
			+" ,	alamat"
			+" ,	telp"
			+" ,	fax"
			+" ,	pemilik_nama"
			+" ,	pemilik_alamat"
			+" ,	asuransi_status"
			+" ,	asuransi_pj"
			+" ,	asuransi_alamat"
			+" ,	asuransi_telp"
			+" ,	penawar_nama"
			+" ,	penawar_jab"
			+" ,	penawar_telp"
			+" ,	penawar_fax"
			+" ,	pengisi_nama"
			+" ,	pengisi_jab"
			+" ,	pengisi_telp"
			+" ,	pengisi_fax"
			+" ,	klaim_status"
			+" ,	bangkrut_status"
			+" ,	bangkrut_detail"
			+" ) values ("
			+	id
			+" ,'"+ nama +"'"
			+" , "+ tipe
			+" ,'"+ alamat +"'"
			+" ,'"+ telp +"'"
			+" ,'"+ fax +"'"
			+" ,'"+ pemilik_nama +"'"
			+" ,'"+ pemilik_alamat +"'"
			+" , "+ asuransi_status
			+" ,'"+ asuransi_pj +"'"
			+" ,'"+ asuransi_alamat +"'"
			+" ,'"+ asuransi_telp +"'"
			+" ,'"+ penawar_nama +"'"
			+" , "+ penawar_jab
			+" ,'"+ penawar_telp +"'"
			+" ,'"+ penawar_fax +"'"
			+" ,'"+ pengisi_nama +"'"
			+" , "+ pengisi_jab
			+" ,'"+ pengisi_telp +"'"
			+" ,'"+ pengisi_fax +"'"
			+" , "+ klaim_status
			+" , "+ bangkrut_status
			+" ,'"+ bangkrut_detail +"'"
			+" );";

		l = pul.length();
		if (l > 0) {
			q_pul=" insert into r_kontraktor_pul ("
				+"		id_kontraktor"
				+" ,	nama"
				+" ,	alamat"
				+" ,	telp"
				+")";

			for (i = 0; i < l; i++) {
				if (i > 0) {
					q_pul +=" union all ";
				}

				o = pul.getJSONObject(i);

				q_pul+=	" select "+ id
					+	" ,'"+ o.getString("nama") +"'"
					+	" ,'"+ o.getString("alamat") +"'"
					+	" ,'"+ o.getString("telp") +"'";
			}
		}

		l = pim.length();
		if (l > 0) {
			q_pim=" insert into r_kontraktor_pim ("
				+"		id_kontraktor"
				+" ,	id_jab"
				+" ,	nama"
				+" ,	lama_bekerja"
				+")";

			for (i = 0; i < l; i++) {
				if (i > 0) {
					q_pim +=" union all ";
				}

				o = pim.getJSONObject(i);

				q_pim+=	" select "+ id
					+	" ,"+ o.getString("id_jab")
					+	" ,'"+ o.getString("nama") +"'"
					+	" ,"+ o.getString("lama_bekerja");
			}
		}

		l = jul.length();
		if (l > 0) {
			q_jul=" insert into r_kontraktor_jul ("
				+"		id_kontraktor"
				+" ,	ket"
				+")";

			for (i = 0; i < l; i++) {
				if (i > 0) {
					q_jul +=" union all ";
				}

				o = jul.getJSONObject(i);

				q_jul	+=" select "+ id
						+ " ,'"+ o.getString("ket") +"'";
			}
		}

		l = psd.length();
		if (l > 0) {
			q_psd=" insert into r_kontraktor_psd ("
				+"		id_kontraktor"
				+" ,	tempat"
				+" ,	jenis"
				+" ,	nilai"
				+")";

			for (i = 0; i < l; i++) {
				if (i > 0) {
					q_psd +=" union all ";
				}

				o = psd.getJSONObject(i);

				q_psd	+=" select "+ id
						+ " ,'"+ o.getString("tempat") +"'"
						+ " ,'"+ o.getString("jenis") +"'"
						+ " ,'"+ o.getString("nilai") +"'";
			}
		}

		l = ptd.length();
		if (l > 0) {
			q_ptd=" insert into r_kontraktor_ptd ("
				+"		id_kontraktor"
				+" ,	tempat"
				+" ,	jenis"
				+" ,	nilai"
				+")";

			for (i = 0; i < l; i++) {
				if (i > 0) {
					q_ptd +=" union all ";
				}

				o = ptd.getJSONObject(i);

				q_ptd	+=" select "+ id
						+ " ,'"+ o.getString("tempat") +"'"
						+ " ,'"+ o.getString("jenis") +"'"
						+ " ,'"+ o.getString("nilai") +"'";
			}
		}

		l = klm.length();
		if (l > 0) {
			q_klm=" insert into r_kontraktor_klm ("
				+"		id_kontraktor"
				+" ,	id_repo"
				+")";

			for (i = 0; i < l; i++) {
				if (i > 0) {
					q_klm +=" union all ";
				}

				o = klm.getJSONObject(i);

				q_klm	+=" select "+ id+ ","+ o.getString("id_repo");
			}
		}
		break;

	case 3:
		q	=" update	r_kontraktor"
			+" set		nama	='"+ nama +"'"
			+" ,		tipe	= "+ tipe
			+" ,		alamat	='"+ alamat +"'"
			+" ,		telp	='"+ telp +"'"
			+" ,		fax		='"+ fax +"'"
			+" ,		pemilik_nama	='"+ pemilik_nama +"'"
			+" ,		pemilik_alamat	='"+ pemilik_alamat +"'"
			+" ,		asuransi_status	= "+ asuransi_status
			+" ,		asuransi_pj		='"+ asuransi_pj +"'"
			+" ,		asuransi_alamat	='"+ asuransi_alamat +"'"
			+" ,		asuransi_telp	='"+ asuransi_telp +"'"
			+" ,		penawar_nama	='"+ penawar_nama +"'"
			+" ,		penawar_jab		= "+ penawar_jab
			+" ,		penawar_telp	='"+ penawar_telp +"'"
			+" ,		penawar_fax		='"+ penawar_fax +"'"
			+" ,		pengisi_nama	='"+ pengisi_nama +"'"
			+" ,		pengisi_jab		= "+ pengisi_jab
			+" ,		pengisi_telp	='"+ pengisi_telp +"'"
			+" ,		pengisi_fax		='"+ pengisi_fax +"'"
			+" ,		klaim_status	= "+ klaim_status
			+" ,		bangkrut_status	= "+ bangkrut_status
			+" ,		bangkrut_detail	='"+ bangkrut_detail +"'"
			+" where	id = "+ id;
		break;

	case 4:
		q_pim	=" delete from r_kontraktor_pim where id_kontraktor = "+ id;
		q_pul	=" delete from r_kontraktor_pul where id_kontraktor = "+ id;
		q		=" delete from r_kontraktor where id = "+ id;
		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	if (dml == 4) {
		db_stmt.executeUpdate(q_pim);
		db_stmt.executeUpdate(q_pul);
	}

	db_stmt.executeUpdate(q);

	if (dml == 2) {
		if (!q_pul.equals("")) {
			db_stmt.executeUpdate(q_pul);
		}
		if (!q_pim.equals("")) {
			db_stmt.executeUpdate(q_pim);
		}
		if (!q_jul.equals("")) {
			db_stmt.executeUpdate(q_jul);
		}
		if (!q_psd.equals("")) {
			db_stmt.executeUpdate(q_psd);
		}
		if (!q_ptd.equals("")) {
			db_stmt.executeUpdate(q_ptd);
		}
		if (!q_klm.equals("")) {
			db_stmt.executeUpdate(q_klm);
		}
	}

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
