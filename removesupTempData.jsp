<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		stmt.executeUpdate("DROP TABLE TEMP_ROOM_PRIORITY PURGE");
		stmt.executeUpdate("DROP TABLE TEMP_BRANCH_PRIORITY PURGE");
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
