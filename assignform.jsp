<html>
<head>
<link rel="stylesheet" type="text/css" href="style/tab.css" />
<link rel="stylesheet" type="text/css" href="style/css.css" />
<script type="text/javascript" src="script/jquery.js"></script>
<script type="text/javascript" src="script/tab.js"></script>
<script type="text/javascript" src="script/javaScript.js"></script>
</head>
<body>
<table>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		int cnt=0;
		String type=(String)session.getAttribute("uid");
		String exid=request.getParameter("exid");
		String nop=Integer.parseInt(request.getParameter("nop"));
		String date=request.getParameter("date");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();		
		ResultSet rs=stmt.executeQuery("SELECT TO_CHAR(I.INVIG_DATE,'DD-MON-YYYY'),E.START_TIME,E.END_TIME,I.NOP FROM EXAM_DATES E JOIN INVIG_REQUESTS I ON I.REQUESTED_TO='"+uid+"' AND I.EXAM_ID='"+exid+"' AND E.EXAM_ID=I.EXAM_ID AND E.EXAM_DATE=I.INVIG_DATE");
		while(rs.next())	
		{
			cnt++;
			if(cnt==1)
			{
%>
				<tr><td>S.NO</td><td>Date of Invigilation</td><td>Invigilation Timings</td><td>Staff Needed</td></tr>				
<%
			}
%>
				<tr style="cursor:pointer" onclick="getInvigAssignmentForm('<%=rs.getString(1)%>',<%=rs.getInt(4)%>,'<%=exid%>')"><td><%=cnt%></td><td><%=rs.getString(1)%></td><td><%=rs.getString(2)%>&nbsp;To&nbsp;<%=rs.getString(3)%></td><td><%=rs.getString(4)%></td></tr>			
<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</table>
<div id="assignForm"></div>
<a href="requestsList.jsp"><button class="btn">Go Back</button></a>
</body>
</html>