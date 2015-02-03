<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<table class="innertable" style="width:100%">
<%
try
	{
		int temp=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT NAME,USER_ID,ROLE,DEPT,MOBILE,EMAIL FROM USERS WHERE ROLE <> 'Administrator'");
		while(rs.next())	
		{
			String name="--";
			String uid="--";
			String type="--";
			String dept="--";
			String mobile="--";
			String email="--";
			if(rs.getString(1)!=null)
				name=rs.getString(1);
			if(rs.getString(2)!=null)
				uid=rs.getString(2);
			if(rs.getString(3)!=null)
				type=rs.getString(3);
			if(rs.getString(4)!=null)
				dept=rs.getString(4);
			if(rs.getString(5)!=null)
				mobile=rs.getString(5);
			if(rs.getString(6)!=null)
				email=rs.getString(1);
			if(temp==0)
			{
%>
				<tr><td class="head" style="width:5%;text-align:center;">S.No</td><td class="head" style="width:25%">User Name</td><td class="head" style="width:10%" >User_ID</td><td class="head"  style="width:10%" >TYPE</td><td class="head" style="width:10%">DEPARTMENT</td><td class="head" style="width:15%">MOBILE NO.</td><td class="head" style="width:25%" colspan="2">EMAIL</td></tr>
<%			
			}temp++;
%>
		<tr><td><%=temp%></td><td><%=name%></td><td><%=uid%></td><td><%=type%></td><td><%=dept%></td><td><%=mobile%></td><td><%=email%></td><td onclick="deleteUser('<%=rs.getString(2)%>')"><img src="pic/del.png" width="25px" title="Delete" height="20px" alt="Delete"  /></td></tr>
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
