<option value="">:: Select Branch ::</option>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT BRANCH_ID FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' GROUP BY BRANCH_ID ORDER BY BRANCH_ID");
		while(rs.next())	
		{
%>
		<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
