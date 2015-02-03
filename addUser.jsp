<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String id=request.getParameter("user_id");
String pwd=request.getParameter("pwd");
String type=request.getParameter("type");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("INSERT INTO USERS(USER_ID,PASSWORD,ROLE) VALUES('"+id.toUpperCase()+"','"+pwd+"','"+type+"')");
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