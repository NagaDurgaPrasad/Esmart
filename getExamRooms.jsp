<option value="">:: Select Rooms ::</option>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		String branch=request.getParameter("branch");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=null;
		if(branch.equals("total"))
			rs=stmt.executeQuery("SELECT ROOM_ID FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' GROUP BY ROOM_ID ORDER BY ROOM_ID");
		else
			rs=stmt.executeQuery("SELECT ROOM_ID FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+branch+"' GROUP BY ROOM_ID ORDER BY ROOM_ID");
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
