<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<table class="innertable" id="Table">
<%
try
	{
		String block_id=request.getParameter("block_id");
		int temp=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT R.ROOM_ID,R.NO_ROWS*R.NO_COLUMNS,B.BLOCK_NAME FROM ROOMS R,BLOCKS B WHERE R.BLOCK_ID='"+block_id+"' AND R.BLOCK_ID=B.BLOCK_ID ORDER BY R.ROOM_ID ASC");
		while(rs.next())	
		{
			if(temp==0)
			{
%>
				<tr>
					<td class="head" style="width:5%;text-align:center;">S.No</td>
					<td class="head" style="width:20%">Block_ID</td>
					<td class="head"  style="width:20%;">Capacity</td>
					<td class="head"  style="width:50%" colspan="2">Name of the Block</td>
				</tr>
<%			
			}temp++;
%>
			<tr>
				<td style="text-align:center;" onclick="getRoomDetails('<%=rs.getString(1)%>')"><%=temp%></td>
				<td onclick="getRoomDetails('<%=rs.getString(1)%>')" ><%=rs.getString(1)%></td>
				<td onclick="getRoomDetails('<%=rs.getString(1)%>')" ><%=rs.getString(2)%></td>
				<td onclick="getRoomDetails('<%=rs.getString(1)%>')" ><%=rs.getString(3)%></td>
				<td style="width:30px;text-align:center;" onclick="deleteRoom('<%=rs.getString(1)%>')"><img src="pic/del.png" width="25px" title="Delete" height="20px" alt="Delete"  /></td>
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
