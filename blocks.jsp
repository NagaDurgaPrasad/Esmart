<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<table class="innertable" id="Table">
<%
try
	{
		int temp=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT BLOCK_ID,BLOCK_NAME FROM BLOCKS ORDER BY BLOCK_ID");
		while(rs.next())	
		{
			if(temp==0)
			{
%>
				<tr>
					<td class="head" style="width:5%;text-align:center;">S.No</td>
					<td class="head" style="width:25%">Block_Id</td>
					<td class="head"  style="width:70%" colspan="2">Name</td>
				</tr>
<%			
			}temp++;
%>
		<tr><td style="text-align:center;" onclick="getBlockDetails('<%=rs.getString(1)%>')"><%=temp%></td><td onclick="getBlockDetails('<%=rs.getString(1)%>')" ><%=rs.getString(1)%></td><td onclick="getBlockDetails('<%=rs.getString(1)%>')" ><%=rs.getString(2)%></td><td style="text-align:center;" onclick="deleteBlock('<%=rs.getString(1)%>')"><img src="pic/del.png" width="25px" title="Delete" height="20px" alt="Delete"  /></td></tr>
<%		
		if(temp==0)
			out.println("No Block Details Available");
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</table>