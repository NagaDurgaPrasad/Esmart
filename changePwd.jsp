<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String val1=request.getParameter("pwd");
String val2=request.getParameter("newpwd");
if(val1.equals(val2))
{
String uid=(String)session.getAttribute("uid");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("UPDATE USERS SET PASSWORD='"+val2+"' WHERE USER_ID='"+uid+"'");
		if(cnt>0)	
		{
			%><b style="font-size:13px;color:green;"><img src='pic/success.png' width='22' height='22' alt='Saved' style='border:0' />Successfully Saved</b><%		
		}
		else
		{
			%><b style="font-size:13px;color:red;"><img src='pic/warn.png' width='22' height='22' alt='Saved' style='border:0' />Not Saved</b><%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		%><b style="font-size:13px;color:red;"><img src='pic/warn.png' width='22' height='22' alt='Saved' style='border:0' />Not Saved</b><%		
	}
}
else
{
	%><b style="font-size:13px;color:red;"><img src='pic/warn.png' width='22' height='22' alt='Saved' style='border:0' />Sorry..Incorrect Old Password</b><%
}
%>
