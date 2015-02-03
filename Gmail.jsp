<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %> 
<% String result; 
   String to = "bnd.prasad536@yahoo.com"; 
   String body = "hai"; 
   String from = "vrsec.examinationsection@gmail.com"; 
   String host = "vrsecmca"; 
   Properties properties = System.getProperties(); 
   properties.setProperty("mail.smtp.host", host); 
   properties.setProperty("mail.user", "vrsec.examinationsection@gmail.com");
   properties.setProperty("mail.password", "vrsec@321");
   //String to = request.getParameter("to"); 
   //String from = request.getParameter("from");
   String subject = "Test";
   String messageText = "Hai..PRASAD";
   Session mailSession = Session.getDefaultInstance(properties); 
   try{ 
       MimeMessage message = new MimeMessage(mailSession);
       message.setFrom(new InternetAddress(from)); 
       message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));  
       BodyPart messageBodyPart = new MimeBodyPart(); 
       messageBodyPart.setText("This is message body"); 
       Multipart multipart = new MimeMultipart(); 
       multipart.addBodyPart(messageBodyPart); 
       String title = "Send Email"; 
       result = "Sent message successfully...."; 
    }
    catch (MessagingException mex) { 
       mex.printStackTrace(); 
       result = "Error: unable to send message...."; 
   }
 %> 
<html> 
<head> 
<title>Send email</title> 
</head> 
<body> 
<center> <h1>Send Attachement Email using JSP</h1> </center> 
<p align="center"> 
<% out.println("Result: " + result + "\n"); %> 
</p>
</body>
</html>