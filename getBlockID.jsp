<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT COUNT(BLOCK_ID) FROM BLOCKS");
		while(rs.next())	
		{
			out.println("BLOCK-"+(rs.getInt(1)+1));
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
