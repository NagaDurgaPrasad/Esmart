<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="javax.net.ssl.*,java.sql.*" %>
<%
String host = "smtp.gmail.com";
String to ="";
String password ="";
String from="vrsec.examinationsection@gmail.com";  // write your email address means from email address.
String subject = "Password";
String uid = request.getParameter("uid");
boolean sessionDebug = true;
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
	Statement stmt=con.createStatement();
	ResultSet rs=stmt.executeQuery("SELECT EMAIL,PASSWORD FROM USERS WHERE USER_ID='"+uid.toUpperCase()+"'");
	if(rs.next())
	{
		to=rs.getString(1);
		password=rs.getString(2);
	}
	if(to!=null)
	{
		String messageText = "<strong style='color:green'>Hai,<br/>Login ID&nbsp;&nbsp;:&nbsp;"+uid+"<br/>Your Password&nbsp;&nbsp;:&nbsp;"+password+"</strong>";
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable","true");
		props.setProperty("mail.transport.protocol","smtp");
		props.setProperty("mail.host",host);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");    //port is 587 for TLS  if you use SSL then port is 465
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
		msg.setSentDate(new java.util.Date());
		msg.setContent(messageText,"text/html");
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, "vrsec.examinationsection@gmail.com", "vrsec@321");
		transport.sendMessage(msg, msg.getAllRecipients());
		%>
			<div style="margin:5%;margin-left:10%;width:500px"><img src="pic/p1.jpg" width="80" height="80" style="float:left;" /><center style="color:green;font-size:20px;float:right;">Password Successfully Sent to Your Email<br /><button style="font-size:25px;width:150px;height:50px;"><a href="Login.jsp">Login Here</a></button></center></div>
		<%
		}
		else
		{
		%>
			<div style="margin:5%;margin-left:10%;width:500px"><img src="pic/info.jpg" width="80" height="80" style="float:left;" /><center style="color:red;font-size:20px;float:right;">We are currently unable to send your Password.<br/>Contact Administrator<br/><button style="font-size:25px;width:150px;height:50px;" ><a href="Login.jsp">Login Here</a></button></center></div>
		<%		
		}
	}
	catch(Exception e)
	{
		%>
			<div style="margin:5%;margin-left:10%;width:500px"><img src="pic/info.jpg" width="80" height="80" style="float:left;" /><center style="color:red;font-size:20px;float:right;">No Internet Connection<br/>We are currently unable to send your Password.<br/>Contact Administrator<br/><button style="font-size:25px;width:150px;height:50px;"><a href="Login.jsp">Login Here</a></button></center></div>
		<%
	}
%>