<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String pwd=request.getParameter("pwd");
String uid=request.getParameter("uid");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("UPDATE USERS SET PASSWORD='"+pwd+"' WHERE USER_ID='"+uid.toUpperCase()+"'");
		if(cnt>0)
		{
		%>
			<div style="margin:5%;margin-left:10%;width:500px"><img src="pic/p1.jpg" width="80" height="80" style="float:left;" /><center style="color:green;font-size:30px;float:right;">Password Successfully Changed<br /><button style="font-size:25px;width:150px;height:50px;" onclick="location.replace('Login.jsp')">Login Here</button></center></div>
		<%
		}
		else
			response.sendRedirect("forgotpwd.html");
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		%><b style="font-size:13px;color:red;"><img src='pic/warn.png' width='22' height='22' alt='Saved' style='border:0' />Not Saved</b><%		
	}
%>
