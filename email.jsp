<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Email send Example for project </title>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="javax.net.ssl.*" %>
<%
String host = "smtp.gmail.com";
//String to =request.getParameter("to");
String to ="bnd.prasad143@gmail.com";
String from="vrsec.examinationsection@gmail.com";  // write your email address means from email address.
String subject = "Controller of Examination";
//String messageText = request.getParameter("msg");
String messageText = "<b style='color:red'>HAi prasad</b>";
boolean sessionDebug = true;
try
{
Properties props = System.getProperties();
props.put("mail.smtp.starttls.enable","true");
props.setProperty("mail.transport.protocol","smtp");
props.setProperty("mail.host",host);
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.port", "587");    //port is 587 for TLS  if you use SSL then port is 465
props.put("mail.debug", "true");
props.put("mail.smtp.socketFactory.port", "465");
props.put("mail.smtp.socketFactory.fallback", "false");
props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {protected PasswordAuthentication getPasswordAuthentication() {return new PasswordAuthentication("UserName", "Password");}});
mailSession.setDebug(sessionDebug);
Message msg = new MimeMessage(mailSession);
msg.setFrom(new InternetAddress(from));
InternetAddress[] address = {new InternetAddress(to)};
msg.setRecipients(Message.RecipientType.TO, address);
msg.setSubject(subject);
msg.setSentDate(new Date());
msg.setContent(messageText,"text/html");

Transport transport = mailSession.getTransport("smtp");
transport.connect(host, "vrsec.examinationsection", "vrsec@321");
transport.sendMessage(msg, msg.getAllRecipients());
out.println("Mail was sent to "+to);
out.println(" from "+from);
out.println(" using host "+host+".");
}
catch(Exception e)
{}
%>
</table>
</body>
</html>