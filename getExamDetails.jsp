<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
      String eid=request.getParameter("eid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT EXAM_NAME,ACADEMIC_YEAR,MONTH FROM EXAMS WHERE EXAM_ID='"+eid+"'");
		if(rs.next())	
		{
%>
		<table class="smalltab">
    		<tr><td>Examination Name</td><td>:</td><td><%=rs.getString(1)%></td></tr>
    		<tr><td>Academic year</td><td>:</td><td><%=rs.getString(2)%></td></tr>
    		<tr><td>Month</td><td>:</td><td><%=rs.getString(3)%></td></tr>
<%
    		rs=stmt.executeQuery("SELECT SUM(NO_STU) FROM SEATING_PLANS WHERE EXAM_ID='"+eid+"'");
			if(rs.next())	
			{
%>
			<tr><td>Total Students Appearing</td><td>:</td><td><b id="appearstudents"><%=rs.getString(1)%></b>&nbsp;Members</td></tr>
		</table>
<%
			}	
		}
		rs.close();
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
