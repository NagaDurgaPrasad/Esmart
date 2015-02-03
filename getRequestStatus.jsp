<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<table class="requests">
<tbody>
<%
try
	{
		String exid=request.getParameter("exid");
		int status=0,cnt=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=null,rs2=null;
		rs=stmt.executeQuery("SELECT U.DEPT,SUM(I.NOP),U.MOBILE FROM USERS U JOIN INVIG_REQUESTS I ON I.REQUESTED_TO=U.USER_ID AND I.EXAM_ID='"+exid+"' GROUP BY U.DEPT,U.MOBILE");
		while(rs.next())	
		{
			String mobile="";
			if(rs.getString(3)==null)
			 	mobile="Not Available";
			else
			 	mobile=rs.getString(3);
			status=0;
			cnt++;
			rs2=stmt2.executeQuery("SELECT COUNT(S.BRANCH_ID) FROM STAFF S JOIN INVIGILATION I ON I.STAFF_ID=S.STAFF_ID AND EXAM_ID='"+exid+"' AND S.BRANCH_ID='"+rs.getString(1)+"' GROUP BY S.BRANCH_ID");
			if(rs2.next())
			{
				status=1;
				if(rs.getInt(2)==rs2.getInt(1))
				{
				%>
					<tr class="visited"><td><%=cnt%></td><td><%=rs.getString(1)%></td><td><%=rs.getInt(2)%></td><td><%=rs2.getInt(1)%></td><td>Mobile&nbsp;:&nbsp;<%=mobile%></td></tr>
				<%
				}	
				else
				{
					%>
					<tr class="visited"><td><%=cnt%></td><td><%=rs.getString(1)%></td><td><%=rs.getInt(2)%></td><td><%=rs2.getInt(1)%></td><td>Mobile&nbsp;:&nbsp;<%=mobile%></td></tr>
					<%
				}			
			}
			if(status==0)
			{
				%>
				<tr><td><%=cnt%></td><td><%=rs.getString(1)%></td><td><%=rs.getInt(2)%></td><td>--</td><td>Mobile&nbsp;:&nbsp;<%=mobile%></td></tr>
				<%	
			}		
		}
		if(cnt>0)
		{
			%>
				</tbody><thead><td>S.NO</td><td>BRANCH NAME</td><td>REQUESTED STAFF</td><td>ALLOTED STAFF</td><td>CONTACT DETAILS</td></tr></thead>
			<%	
		}
		else
		{
		%>
			<div class="promptmsg" style="font-size:20px;font-weight:bold;text-align:center;top:15%;left:25%;"> Sorry...you don't send any Requests</div>
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