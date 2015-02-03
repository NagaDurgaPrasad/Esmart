<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="javax.net.ssl.*" %>
<%
String id=request.getParameter("rid");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT EMAIL FROM INVIG_REQUESTS JOIN USERS ON RID='R"+id+"' AND REQUESTED_TO=USER_ID GROUP BY REQUESTED_TO,EMAIL");
		while(rs.next())	
		{
			if(!rs.getString(1).equals(""))
			{
				String host = "smtp.gmail.com";
				String to =rs.getString(1);
				String from="vrsec.examinationsection@gmail.com";  // write your email address means from email address.
				String subject = "Controller of Examination";
				String messageText ="<strong>Dear sir,<br/>You have Received Invigilation Requests.<br/>Please Complete Invigilation Allotment Immediately</strong>";
				boolean sessionDebug = true;
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
				msg.setSentDate(new java.util.Date ());
				msg.setContent(messageText,"text/html");
				Transport transport = mailSession.getTransport("smtp");
				transport.connect(host, "vrsec.examinationsection", "vrsec@321");
				transport.sendMessage(msg, msg.getAllRecipients());
			}
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	%>
			<div id='alertbox' class='alertbox'>Sorry....Account Not Created.<%=e.getErrorCode()%><div class="close" title="Close" onclick="hideMsg('infobox');">X</div></div>
		<%		
	}
%>