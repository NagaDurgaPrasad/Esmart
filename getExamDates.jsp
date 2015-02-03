<option value="">:: Select Date ::</option>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT to_char(EXAM_DATE,'DD-MM-YYYY'),START_TIME,END_TIME FROM EXAM_DATES WHERE EXAM_ID='"+exid+"' ORDER BY EXAM_DATE");
		while(rs.next())	
		{
%>
		<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%>&nbsp;&nbsp;<%=rs.getString(2)%>&nbsp;To&nbsp;<%=rs.getString(3)%></option>
<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
