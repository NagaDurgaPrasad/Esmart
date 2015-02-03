<div class="title" id="tx" style="visibility:visible;position:relative;left:0;top:1%;">Select Branches</div><br/>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		int cnt=1;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT BRANCH_ID,BRANCH_NAME FROM BRANCHES ORDER BY BRANCH_ID");
		while(rs.next())	
		{
			if(cnt==1)
			{
%>
				<input type="checkbox" class="branchlisthead" id="bh" onclick="selectAll('branchlist');" /><label style="cursor:pointer;color:black;font-size:16px;font-weight:bold;" for="bh">Select All</label><br/>
<%
			}
%>
			<input type="checkbox" value="<%=rs.getString(1)%>" class="branchlist" onclick="saveBranch('<%=rs.getString(1)%>',<%=cnt%>)" id="branch<%=cnt%>"/><label id="b<%=cnt%>" class="branchlisttext" style="font-weight:bold;cursor:pointer;color:black;font-size:14px;" for="branch<%=cnt++%>" class="branchlisttext" ><%=rs.getString(2)%></label><br/>
<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
