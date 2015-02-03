<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		int i=1;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT BRANCH_ID,BRANCH_NAME FROM BRANCHES WHERE BLOCK_ID IS NULL");
		while(rs.next())	
		{
			if(i==1)
			{
%>
			<fieldset><legend>Select Branches in that Block</legend><div style="font-size:11px;color:black;">
<%
			}
%>
			<input type="checkbox" name="braches" id="b<%=i%>" value="<%=rs.getString(1)%>" onclick="setParam(this.value)"><label for="b<%=i++%>" style="font-size:12px;"><%=rs.getString(2)%></label></input><br/>
<%		
		}
		rs=stmt.executeQuery("SELECT BRANCH_ID,BRANCH_NAME FROM BRANCHES WHERE BLOCK_ID IS NOT NULL");
		while(rs.next())	
		{
			if(i==1)
			{
%>
			<fieldset><legend>Select Branches in that Block</legend><div style="font-size:11px;color:black;">
<%
			}
			%>
				<input type="checkbox" disabled="true" title="Not Available" name="braches" id="reserved<%=i++%>"  value="<%=rs.getString(1)%>"><em style="color:gray;" title="Already selected in other Blocks"><%=rs.getString(2)%><em></input><br/>
			<%
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</div></fieldset>