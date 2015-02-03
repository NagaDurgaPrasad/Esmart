<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
		String id=request.getParameter("block_id");
		String name=null;
		String loc=null;
		int availrms=0,cnt=1;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT BLOCK_NAME,AVAIL_ROOMS,LOCATION FROM BLOCKS WHERE BLOCK_ID='"+id+"'");
		while(rs.next())	
		{
			name=rs.getString(1);
			availrms=rs.getInt(2);
			loc=rs.getString(3);
		}
%>
<form method="post" id="block2" id="block2">
		<table style="width:100%">
			<caption style="background-color:maroon;color:white;height:35px;font-size:20px;padding:0 5px;font-weight:bold;width:100%;">Block Details</caption>
			<tr><td></td><td></td></tr>
			<tr><td>Block ID</td><td><input type="text" class="textbox" name="block_id2" id="block_id2" value="<%=id%>" disabled="true" /></td><td></td></tr>
			<tr><td>Block Name</td><td><input type="text" class="textbox" name="block_name2" onchange="showbtn('sub2','clr2')" id="block_name2" required="" autofocus="true"  value="<%=name%>" /></td></tr>
			<tr><td>Block Location</td><td><input type="text" class="textbox" name="locatn2" id="locatn2" required="" onchange="showbtn('sub2','clr2')" value="<%=loc%>" /></td></tr>
			<tr><td>Available Rooms</td><td><input type="text" class="textbox" name="availrms" id="availrms" required="" disabled="true"  value="<%=availrms%>" /></td></tr>
			<tr><td colspan="2" id="branch2"><fieldset><legend>Branches Located in that Block</legend><div style="font-size:12px;color:black">			
<%
			rs=stmt.executeQuery("SELECT BRANCH_ID,BRANCH_NAME FROM BRANCHES WHERE BLOCK_ID='"+id+"'");
			while(rs.next())	
			{
%>
				<input type="checkbox" id="br<%=cnt%>" onchange="showbtn('sub2','clr2')" value="<%=rs.getString(1)%>" checked="checked" /><label for="br<%=cnt++%>" style="font-size:12px;"><%=rs.getString(2)%><br/>						
<%	
			}
			rs=stmt.executeQuery("SELECT BRANCH_ID,BRANCH_NAME FROM BRANCHES WHERE BLOCK_ID IS NULL");
			while(rs.next())	
			{
%>
				<input type="checkbox" id="br<%=cnt%>" onchange="showbtn('sub2','clr2')" value="<%=rs.getString(1)%>" /><label for="br<%=cnt++%>" style="font-size:12px;"><%=rs.getString(2)%></label><br/>						
<%	
			}
%>		
			</div></fieldset></td></tr>
			<tr><td align="right"><input type="button" value="Submit" onclick="setArgs2()" class="btn" id="sub2" style="visibility:hidden" /></td><td><input type="reset" value="Clear" id="clr2" class="btn" style="visibility:hidden" /></td></tr>
			<tr><td colspan="2" align="center"><input type="button" value="Close" onclick="hide()" id="close" class="btn" /></td></tr>
		</table>		
</form>
<%
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>