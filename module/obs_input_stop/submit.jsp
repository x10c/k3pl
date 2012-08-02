<%--
 % Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
--%>

<%@ include file="../modinit.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="java.util.Properties" %>
<%
try {
	int			dml		= Integer.parseInt(request.getParameter("dml_type"));
	String		id_stop	= request.getParameter("id_stop");
	String		nipg	= request.getParameter("nipg");
	String		id_area_seksi	= request.getParameter("id_area_seksi");
	String		tanggal	= request.getParameter("tanggal");
	String		site	= request.getParameter("site");
	String		shift	= request.getParameter("shift");
	String		lama	= request.getParameter("lama");
	String		n_obs	= request.getParameter("n_obs");
	String		n_dis	= request.getParameter("n_dis");
	String		safe	= request.getParameter("safe");
	String		unsafe	= request.getParameter("unsafe");
	String		st_aktif= request.getParameter("st_aktif");
	int			periode	= Integer.parseInt(request.getParameter("periode"));
	int			bulan	= Integer.parseInt(request.getParameter("bulan"));
	int			tahun	= Integer.parseInt(request.getParameter("tahun"));
	DateFormat	df	= new SimpleDateFormat("yyyy-MM-dd");
	Date		dt_in	= df.parse(tanggal);
	Calendar	cal	= Calendar.getInstance();
	Date		date	= new Date();
	int			status	= 0;
	int			jumlah	= 0;
	String		query	= "";
	int			year;
	int			month;
	int			i, l;

	json_a	= new JSONArray((String) request.getParameter("detail"));
	db_stmt = db_con.createStatement();

	cal.setTime(dt_in);

	year = cal.get(cal.YEAR);
	month= cal.get(cal.MONTH) + 1;

	switch (dml) {
	case 2:
		id_stop	= Long.toString(date.getTime());

		if (periode == 1){
			db_q	=" select	count(*) as jumlah"
					+" from		t_stop"
					+" where	year(tanggal) = " + tahun
					+" and		month(tanggal) = " + bulan
					+" and		day(tanggal) between 1 and 15"
					+" and		nipg = '" + nipg + "'";

			db_rs = db_stmt.executeQuery (db_q);

			if (db_rs.next()){
				jumlah = db_rs.getInt("jumlah");
			}

			if (jumlah > 0){
				status = 0;
			} else {
				status = 1;
			}

			db_rs.close ();
		} else {
			db_q	=" select	count(*) as jumlah"
					+" from		t_stop"
					+" where	year(tanggal)	= " + tahun
					+" and		month(tanggal)	= " + bulan
					+" and		day(tanggal) between 16 and 31"
					+" and		nipg			= '" + nipg + "'";

			db_rs = db_stmt.executeQuery (db_q);

			if (db_rs.next()){
				jumlah = db_rs.getInt ("jumlah");
			}

			if (jumlah > 0){
				status = 0;
			} else {
				status = 2;
			}

			db_rs.close ();
		}

		db_q=" insert into t_stop ("
			+"   id_stop"
			+" , nipg"
			+" , id_direktorat"
			+" , id_divprosbu"
			+" , id_departemen"
			+" , id_dinas"
			+" , id_seksi"
			+" , id_area_seksi"
			+" , id_area_dinas"
			+" , id_area_departemen"
			+" , id_area_divprosbu"
			+" , id_area_direktorat"
			+" , tanggal"
			+" , year"
			+" , month"
			+" , site"
			+" , shift"
			+" , lama_observasi"
			+" , jml_org_observasi"
			+" , jml_org_diskusi"
			+" , tindakan_aman_diamati"
			+" , tindakan_tidak_aman_diamati"
			+" , status_aktif"
			+" , status"
			+" , id_user"
			+" ) select"
			+"   "+ id_stop
			+" ,'"+ nipg +"'"
			+" , A.id_direktorat"
			+" , A.id_divprosbu"
			+" , A.id_departemen"
			+" , A.id_dinas"
			+" , A.id_seksi"
			+" , "+ id_area_seksi
			+" , B.id_dinas"
			+" , B.id_departemen"
			+" , B.id_divprosbu"
			+" , B.id_direktorat"
			+" , cast('"+ tanggal +"' as datetime)"
			+" , "+ year
			+" , "+ month
			+" ,'"+ site +"'"
			+" ,'"+ shift +"'"
			+" , "+ lama
			+" , "+ n_obs
			+" , "+ n_dis
			+" ,'"+ safe +"'"
			+" ,'"+ unsafe +"'"
			+" ,'"+ st_aktif +"'"
			+" ,"+ status
			+" ,'"+ user_nipg +"'"
			+" from		r_pegawai	A"
			+" ,		r_seksi		B"
			+" where	A.nipg		= '"+ nipg +"'"
			+" and		B.id_seksi	= "+ id_area_seksi;
		break;
	case 3:
		db_q=" update t_stop"
			+" set"
			+"   id_area_seksi		= "+ id_area_seksi
			+" , id_area_dinas		= ("
			+"	select	id_dinas"
			+"	from	r_seksi"
			+"	where	id_seksi = "+ id_area_seksi
			+" )"
			+" , id_area_departemen		= ("
			+"	select	id_departemen"
			+"	from	r_seksi"
			+"	where	id_seksi = "+ id_area_seksi
			+" )"
			+" , tanggal			= cast('"+ tanggal +"' as datetime)"
			+" , year			= "+ year
			+" , month			= "+ month
			+" , site			= '"+ site +"'"
			+" , shift			= '"+ shift +"'"
			+" , lama_observasi		=  "+ lama
			+" , jml_org_observasi		=  "+ n_obs
			+" , jml_org_diskusi		=  "+ n_dis
			+" , tindakan_aman_diamati	= '"+ safe +"'"
			+" , tindakan_tidak_aman_diamati= '"+ unsafe +"'"
			+" , status_aktif		=  "+ st_aktif
			+" , id_user			= '"+ user_nipg +"'"
			+" , tanggal_akses		= getdate() "
			+" where id_stop		=  "+ id_stop;
		break;
	case 4:
		db_q=" delete from	t_stop_detail"
			+" where	id_stop = "+ id_stop +";";

		db_stmt.executeUpdate (db_q);

		db_q=" delete from	t_stop"
			+" where	id_stop	= "+ id_stop +";";
		break;
	default:
		out.print("{success: false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate (db_q);

	switch (dml) {
	case 2:
		/* insert stop detail */
		db_q=" insert into t_stop_detail ("
			+"		id_stop "
			+" ,	id_kel_tipe_observasi "
			+" ,	id_tipe_observasi "
			+" ,	id_detail_tipe_observasi "
			+" ,	jumlah_safe "
			+" ,	jumlah_unsafe "
			+" ,	id_user "
			+")";

		l = json_a.length();
		for (i = 0; i < l; i++) {
			json_o = json_a.getJSONObject(i);

			db_q+= " select "+ id_stop
				+", "+ json_o.getString("kel_id")
				+", "+ json_o.getString("tipe_id")
				+", "+ json_o.getString("detail_id")
				+", "+ json_o.getString("safe")
				+", "+ json_o.getString("unsafe")
				+",'"+ user_nipg +"' ";

			if (i < (l - 1)) {
				db_q += " union all ";
			}
		}
		break;
	case 3:
		db_q = "";
		l = json_a.length();
		for (i = 0; i < l; i++) {
			json_o = json_a.getJSONObject(i);

			db_q+=" update	t_stop_detail "
				+ " set		jumlah_safe		= "+ json_o.getString("safe")
				+ " ,		jumlah_unsafe	= "+ json_o.getString("unsafe")
				+ " ,		id_user			= '"+ user_nipg +"' "
				+ " ,		tanggal_akses	= getdate() "
				+ " where	id_kel_tipe_observasi		= "+ json_o.getString("kel_id")
				+ " and		id_tipe_observasi			= "+ json_o.getString("tipe_id")
				+ " and		id_detail_tipe_observasi	= "+ json_o.getString("detail_id")
				+ " and		id_stop						= "+ id_stop
				+ ";";
		}
		break;
	}

	db_stmt.executeUpdate (db_q);

	db_q="; insert into __log (nipg, nama_menu, status_akses) values ('"
		+ user_nipg +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate (db_q);

/*
 * send email notification if enabled.
 */
	if (user_email == null
	|| (user_email != null && user_email.equals(""))
	|| dml != 2) {
		out.print("{success:true, info:'Data telah tersimpan.'"
				+", user_email:'"+ user_email +"'}");
		return;
	}

	db_q
	=" select	email_server"
	+" ,		email_server_port"
	+" ,		email_use_auth"
	+" ,		email_username"
	+" ,		email_password"
	+" ,		email_stop_sender"
	+" ,		email_stop_subject"
	+" ,		email_stop_content"
	+" from		r_k3pl"
	+" where	email_stop_notif_active = 1";

	db_rs = db_stmt.executeQuery (db_q);

	if (! db_rs.next()) {
		out.print("{success:true, info:'Data telah tersimpan.'"
				+", message:'Failed to get server email'}");
		return;
	}

	String email_server			= db_rs.getString("email_server");
	String email_server_port	= db_rs.getString("email_server_port");
	String email_use_auth		= db_rs.getString("email_use_auth");
	String email_username		= db_rs.getString("email_username");
	String email_password		= db_rs.getString("email_password");

	String stop_sender		= db_rs.getString("email_stop_sender");
	String stop_subject		= db_rs.getString("email_stop_subject");
	String stop_content		= db_rs.getString("email_stop_content");

	db_rs.close();

	if (email_server == null || email_server.equals("")
	||  email_server_port == null || email_server_port.equals("")) {
		out.print("{success:true, info:'Data telah tersimpan.'"
				+", email_server:'"+ email_server +"'"
				+", email_port:"+ email_server_port +"}");
		return;
	}

	Properties props = System.getProperties();

	props.put("mail.smtp.host", email_server);
	props.put("mail.smtp.port", email_server_port);

	if (email_use_auth.equals("1")) {
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.user", email_username);
		props.put("mail.smtp.password", email_password);
	}

	Session		ses	= Session.getDefaultInstance(props, null);
	MimeMessage	msg	= new MimeMessage(ses);
	InternetAddress	to_addr	= new InternetAddress(user_email);

	msg.setFrom(new InternetAddress(stop_sender));
	msg.addRecipient(Message.RecipientType.TO, to_addr);

	msg.setSubject(stop_subject);
	msg.setText(stop_content);

	if (email_use_auth.equals("1")) {
		Transport transport = ses.getTransport("smtp");

		transport.connect(email_server, email_username, email_password);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
	} else {
		Transport.send(msg);
	}

	out.print("{success:true, info:'Data telah tersimpan.'"
			+", message:'Notifikasi email telah dikirim.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
