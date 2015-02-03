<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<option value="" >::: Select Block :::</option>
<%
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT BLOCK_ID,BLOCK_NAME FROM BLOCKS");
		while(rs.next())	
		{
%>
		<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
