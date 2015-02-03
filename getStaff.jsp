<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<table class="innertable" id="Table">
<%
try
	{
		String dept=request.getParameter("dept_id");
		if(dept.equals("HOD"))
			dept=(String)session.getAttribute("dept");
		int temp=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT STAFF_ID,NAME,ROUND(MONTHS_BETWEEN(TO_CHAR(SYSDATE,'DD-MON-YYYY'),TO_CHAR(DOJ,'DD-MON-YYYY'))/12,0) FROM STAFF WHERE BRANCH_ID='"+dept+"'");
		while(rs.next())	
		{
			if(temp==0)
			{
%>
				<tr>
					<td class="head" style="width:5%;text-align:center;">S.No</td>
					<td class="head" style="width:25%">Staff_ID</td>
					<td class="head"  style="width:50%">Name</td>
					<td class="head"  style="width:20%" colspan="2">Exp.(Yrs.)</td>
				</tr>
<%			
			}temp++;
%>
			<tr>
				<td onclick="getStaffDetails('<%=rs.getString(1)%>')"><%=temp%></td>
				<td onclick="getStaffDetails('<%=rs.getString(1)%>')" ><%=rs.getString(1)%></td>
				<td onclick="getStaffDetails('<%=rs.getString(1)%>')"><%=rs.getString(2)%></td>
				<td onclick="getStaffDetails('<%=rs.getString(1)%>')"><%=rs.getString(3)%></td>
				<td onclick="deleteStaff('<%=rs.getString(1)%>')" style="width:5%"><img src="pic/del.png" width="25px" title="Delete" height="20px" alt="Delete"  /></td>
			</tr>
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
