<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String id=request.getParameter("user_id");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("DELETE FROM USERS WHERE USER_ID='"+id+"'");
		if(cnt>0)	
			out.print(1);
		else
			out.print(0);
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		out.print(0);	
	}
%>