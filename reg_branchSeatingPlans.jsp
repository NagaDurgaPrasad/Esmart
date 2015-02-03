<div style="width:100%;margin:0 auto;">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String exid=request.getParameter("exid");
String bid=request.getParameter("bid");
int cnt=1;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT EXAM_NAME,ACADEMIC_YEAR,TO_CHAR(TO_DATE(MONTH,'MONTH'),'MONTH') FROM EXAMS WHERE EXAM_ID='"+exid+"'");
		if(rs.next())
		{
			%>
				<table class="inform"><tr><td><%=rs.getString(1)%><td></tr><tr><td>Month&nbsp;:&nbsp;"<%=rs.getString(3)%>"&nbsp;&nbsp;Academic Year&nbsp;:&nbsp;"<%=rs.getString(2)%>"</td></tr>
			<%	
			rs=stmt.executeQuery("SELECT BRANCH_NAME FROM BRANCHES WHERE BRANCH_ID='"+bid+"'");
			if(rs.next())
			{
				%>
					<tr><td><%=rs.getString(1)%></td></tr><tr><td style="font-size:15px;"><u>Seating Plan</u></td></tr></table><table class="requests">
				<%			
			}	
		}
		rs=stmt.executeQuery("SELECT ROOM_ID,START_NO,END_NO,NO_STU FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+bid+"' ORDER BY BRANCH_ORDER");
		while(rs.next())
		{
			%>
				<tr><td><%=cnt++%></td><td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td></tr>
			<%
		}
		if(cnt>1)
		{
			%>
				<thead><tr><td>S.NO</td><td>ROOM NUMBER</td><td>STARTING NUMBER</td><td>ENDING NUMBER</td><td>TOTAL STUDENTS</td></tr></thead>
			<%		
		}
		else
		{
			%>
				<strong class="promptmsg">Sorry..No Details found</strong>
			<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
<table>
</div>