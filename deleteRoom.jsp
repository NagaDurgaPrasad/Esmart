<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String room_id=request.getParameter("room_id");
		int status=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		status=stmt.executeUpdate("DELETE FROM ROOMS WHERE ROOM_ID='"+room_id+"'");
		if(status>0)
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
