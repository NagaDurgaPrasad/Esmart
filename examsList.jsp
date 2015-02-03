<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<table class="requests">
<%
try
	{
		String uid=(String)session.getAttribute("uid");
		int cnt=0,c=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=null,rs2=null;
		rs=stmt.executeQuery("SELECT EXAM_ID,EXAM_NAME,MONTH,ACADEMIC_YEAR FROM EXAMS ORDER BY CR_TIME DESC");
		while(rs.next())	
		{
			cnt++;	
			rs2=stmt2.executeQuery("SELECT to_char(MIN(EXAM_DATE),'DD-MM-YYYY'),to_char(MIN(NEW_DATE),'DD-MM-YYYY'),to_char(MAX(EXAM_DATE),'DD-MM-YYYY'),to_char(MAX(NEW_DATE),'DD-MM-YYYY') FROM EXAM_DATES WHERE EXAM_ID='"+rs.getString(1)+"'");
			if(rs2.next())
			{	
				String mindate=rs2.getString(2)==null?rs2.getString(1):rs2.getString(2);
				String maxdate=rs2.getString(4)==null?rs2.getString(3):rs2.getString(4);
				%>
					<tr><td><%=cnt%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td><td>(<%=mindate%>)&nbsp;TO&nbsp;(<%=maxdate%>)</td><td><img src="pic/del.png" width="25" height="25" onclick="deleteExam('<%=rs.getString(1)%>')" title="Delete" alt="Delete" style="border:0;" /></td><td><input type="button" class="btn" style="width:70px;height:24px;font-size:14px;" value="Back Up" onclick="createBackup('<%=rs.getString(1)%>')" /></td></tr> 
				<%			
			}
		}
		if(cnt>0)
		{
			%>
				<thead><tr><td>S.NO</td><td>NAME OF THE EXAM</td><td>MONTH</td><td>ACADEMIC YEAR</td><td colspan="3">DURAITON</td></tr></thead></table>
			<%
		}
		else
		{
			%>
				<strong class="promptmsg">No Exams Found</strong>
			<%
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>