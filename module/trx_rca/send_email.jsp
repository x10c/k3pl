<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String		id_user 				= (String) session.getAttribute("user.nipg");
	String		user_email 				= (String) session.getAttribute("user.email");

	String		penanggung_jawab_nipg	= request.getParameter("penanggung_jawab_nipg");
	String		q 		= "";
	String		q_pj	= "";

	if (user_email.equals("")) {
		out.print("{success:true, info:'Data telah tersimpan.'}");
		return;
	}

	q_pj
	=" select	email"
	+" from		r_pegawai"
	+" where	nipg	= '" + penanggung_jawab_nipg + "'";

	ResultSet rs_pj = db_stmt.executeQuery(q_pj);

	if (!rs_pj.next()) {
		out.print("{success:true, info:'Data telah tersimpan.'}");
		return;
	}

	String pj_email	= rs_pj.getString("email");

	q
	=" select	email_server"
	+" ,		email_server_port"
	+" ,		email_use_auth"
	+" ,		email_username"
	+" ,		email_password"
	+" ,		email_rca_notif_active"
	+" ,		email_rca_sender"
	+" ,		email_rca_subject"
	+" ,		email_rca_content"
	+" ,		email_rca_subject_pj"
	+" ,		email_rca_content_pj"
	+" from		r_k3pl"
	+" where	email_rca_notif_active = 1";

	ResultSet rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:true, info:'Data telah tersimpan.'}");
		return;
	}

	String email_server			= rs.getString("email_server");
	String email_server_port	= rs.getString("email_server_port");
	String email_use_auth		= rs.getString("email_use_auth");
	String email_username		= rs.getString("email_username");
	String email_password		= rs.getString("email_password");

	String rca_sender		= rs.getString("email_rca_sender");
	String rca_subject		= rs.getString("email_rca_subject");
	String rca_subject_pj	= rs.getString("email_rca_subject_pj");
	String rca_content		= rs.getString("email_rca_content");
	String rca_content_pj	= rs.getString("email_rca_content_pj");
	
	rca_content_pj = String.format(rca_content_pj,id_user);

	if (email_server == null || email_server.equals("")
	||  email_server_port == null || email_server_port.equals("")) {
		out.print("{success:true, info:'Data telah tersimpan.'}");
		return;
	}

	Properties props = System.getProperties();

	props.put("mail.smtp.host", email_server);
	props.put("mail.smtp.port", email_server_port);

	if (email_use_auth.equals("1")) {
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.user", email_username);
		props.put("mail.smtp.password", email_password);
	}

	Session		ses				= Session.getDefaultInstance(props, null);
	MimeMessage	msg				= new MimeMessage(ses);
	MimeMessage	msg_pj			= new MimeMessage(ses);
	InternetAddress	to_addr		= new InternetAddress(user_email);
	InternetAddress	to_addr_pj	= new InternetAddress(pj_email);

	msg.setFrom(new InternetAddress(rca_sender));
	msg.addRecipient(Message.RecipientType.TO, to_addr);

	msg.setSubject(rca_subject);
	msg.setText(rca_content);

	if (email_use_auth.equals("1")) {
		Transport transport = ses.getTransport("smtp");

		transport.connect(email_server, email_username, email_password);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
	} else {
		Transport.send(msg);
	}

	msg_pj.setFrom(new InternetAddress(rca_sender));
	msg_pj.addRecipient(Message.RecipientType.TO, to_addr_pj);

	msg_pj.setSubject(rca_subject_pj);
	msg_pj.setText(rca_content_pj);

	if (email_use_auth.equals("1")) {
		Transport transport = ses.getTransport("smtp");

		transport.connect(email_server, email_username, email_password);
		transport.sendMessage(msg_pj, msg_pj.getAllRecipients());
		transport.close();
	} else {
		Transport.send(msg_pj);
	}
	
	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
