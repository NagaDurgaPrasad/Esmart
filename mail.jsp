<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="javax.net.ssl.*,java.sql.*" %>
<%

        try{
            String host = "smtp.gmail.com";
            String from = "bnd.prasad143@gmail.com";
            String pass = "prasad143";
            Properties props = System.getProperties();
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.user", from);
            props.put("mail.smtp.password", pass);
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.auth", "true");

            String[] to = {"bnd.prasad143@gmail.com"};

            Session sess = Session.getDefaultInstance(props, null);
            MimeMessage message = new MimeMessage(sess);
            message.setFrom(new InternetAddress(from));
            InternetAddress[] toAddress = new InternetAddress[to.length];

            // To get the array of addresses
            for( int i=0; i < to.length; i++ ) { // changed from a while loop
                toAddress[i] = new InternetAddress(to[i]);
            }
            System.out.println(Message.RecipientType.TO);

            for( int i=0; i < toAddress.length; i++) { // changed from a while loop
                message.addRecipient(Message.RecipientType.TO, toAddress[i]);
            }
            message.setSubject("sending in a group");
            message.setText("Welcome to JavaMail");
            Transport transport = sess.getTransport("smtp");
            transport.connect(host, from, pass);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        }
        catch(Exception e){
            e.getMessage();
        }
 %>