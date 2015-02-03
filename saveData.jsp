<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String val=request.getParameter("val");
String dbid=request.getParameter("dbid");
String uid=(String)session.getAttribute("uid");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		if(dbid.equals("MOBILE"))
			cnt=stmt.executeUpdate("UPDATE USERS SET "+dbid+"="+val+" WHERE USER_ID='"+uid+"'");
		else if(dbid.equals("DOB"))
			cnt=stmt.executeUpdate("UPDATE USERS SET "+dbid+"=to_date('"+val+"','DD-MM-YYYY') WHERE USER_ID='"+uid+"'");
		else
			cnt=stmt.executeUpdate("UPDATE USERS SET "+dbid+"='"+val+"' WHERE USER_ID='"+uid+"'");
		if(cnt>0)	
		{
			%><img src='pic/success.png' width='18' height='18' alt='Saved' style='border:0' /><%	
			session.removeAttribute("name");
			session.setAttribute("name",val);	
		}
		else
		{
			%><img src='pic/warn.png' width='18' height='18' alt='Saved' style='border:0' />Not Saved<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		%><img src='pic/warn.png' width='18' height='18' alt='Saved' style='border:0' />Not Saved<%		
	}
%>