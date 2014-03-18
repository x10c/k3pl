<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
String q = "";
String email_server			= request.getParameter("email_server");
String email_server_port	= request.getParameter("email_server_port");
String email_use_auth		= request.getParameter("email_use_auth");
String email_username		= request.getParameter("email_username");
String email_password		= request.getParameter("email_password");
String from					= request.getParameter("from");
String subject				= request.getParameter("subject");
String content				= request.getParameter("content");
String to					= request.getParameter("to");

Properties props = System.getProperties();

props.put("mail.smtp.host", email_server);
props.put("mail.smtp.port", email_server_port);

if (email_use_auth.equals("1")) {
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.user", email_username);
	props.put("mail.smtp.password", email_password);
}

Session		ses	= Session.getDefaultInstance(props, null);

try {
	MimeMessage	msg	= new MimeMessage(ses);
	InternetAddress	to_addr	= new InternetAddress(to);

	msg.setFrom(new InternetAddress(from));
	msg.addRecipient(Message.RecipientType.TO, to_addr);

	msg.setSubject(subject);
	msg.setText(content);

	if (email_use_auth.equals("1")) {
		Transport transport = ses.getTransport("smtp");

		transport.connect(email_server, email_username, email_password);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
	} else {
		Transport.send(msg);
	}

	out.print("{success:true,info:'Email percobaan telah terkirim!'}");
} catch (MessagingException e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
