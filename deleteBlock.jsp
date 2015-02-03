<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String block_id=request.getParameter("block_id");
		int status=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT BLOCK_ID FROM ROOMS");
		while(rs.next())
			if(rs.getString(1).equals(block_id))
				status=1;
		if(status==0)
		{
			stmt.executeUpdate("UPDATE BRANCHES SET BLOCK_ID=NULL WHERE BLOCK_ID='"+block_id+"'");
			status=stmt.executeUpdate("DELETE FROM BLOCKS WHERE BLOCK_ID='"+block_id+"'");
			if(status>0)
				out.print(1);
		}
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
