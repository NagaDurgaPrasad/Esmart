<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String staff_id=request.getParameter("staff_id");
		int status=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		status=stmt.executeUpdate("DELETE FROM STAFF WHERE STAFF_ID='"+staff_id+"'");
		if(status>0)
			out.println(1);
		else
			out.println(0);
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		out.println(0);
	}
%>
