<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
		String rid=request.getParameter("room_id");
		String block_id=null;
		String block_name=null;
		String branch_id=null;
		String branch_name=null;
		int rows=0,cols=0,cnt=1,rno=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT R.ROOM_NO,R.NO_ROWS,R.NO_COLUMNS,R.BRANCH_ID,BR.BRANCH_NAME,R.BLOCK_ID,B.BLOCK_NAME FROM ROOMS R,BLOCKS B,BRANCHES BR WHERE R.ROOM_ID='"+rid+"' AND R.BLOCK_ID=B.BLOCK_ID AND R.BRANCH_ID=BR.BRANCH_ID");
		while(rs.next())	
		{
			rno=rs.getInt(1);
			rows=rs.getInt(2);
			cols=rs.getInt(3);
			branch_id=rs.getString(4);
			branch_name=rs.getString(5);
			block_id=rs.getString(6);
			block_name=rs.getString(7);
		}
%>
<form method="post" id="rooms2" name="rooms2">
		<table style="width:100%">
			<caption style="background-color:maroon;color:white;height:35px;font-size:20px;padding:0 5px;font-weight:bold;width:100%;">Room Details</caption>
			<tr><td></td><td></td></tr>
			<tr><td>Room ID</td><td><input type="text" class="textbox" name="temp_id" id="temp_id" disabled="true" value="<%=rid%>" /></td></tr>
			<tr><td>Room Number</td><td><input type="text" class="textbox" onchange="showbtn('sub','clr')" name="room_no2" id="room_no2" required="" value="<%=rno%>" autofocus="true" /></td></tr>
			<tr><td>Rows</td><td><input type="text" class="textbox" name="rows2" onchange="showbtn('sub','clr')" id="rows2" onkeypress="return isNum(event)" value="<%=rows%>" onblur="setCapacity2(this.value,rooms2.columns2.value)" /></td></tr>
			<tr><td>Columns</td><td><input type="text" class="textbox" onchange="showbtn('sub','clr')" name="columns2" id="columns2"  onkeypress="return isNum(event)" value="<%=cols%>" onblur="setCapacity2(this.value,rooms2.row2.value)" /></td></tr>
			<tr><td>Max.Capacity</td><td><input type="text" class="textbox" name="capacity2" id="capacity2" required="" disabled="true" value="<%=rows*cols%>" /></td></tr>
			<tr><td>Block Name</td><td><select  class="textbox" name="block2" id="block2" onchange="getSelectedBranches(this.value,'branch2');showbtn('sub','clr')" onfocus="this.remove(0);this.removeAttribute('onfocus')" /><option selected="selected" value="<%=block_id%>"><%=block_name%></option>
<%
			rs=stmt.executeQuery("SELECT BLOCK_ID,BLOCK_NAME FROM BLOCKS");
			while(rs.next())	
			{
%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>						
<%	
			}
%>					
			</select></td></tr>
			<tr><td>Branch Name</td><td><select  class="textbox" name="branch2" id="branch2" onchange="showbtn('sub','clr')" onfocus="this.remove(0);this.removeAttribute('onfocus')" required=""/> <option selected="selected" value="<%=branch_id%>"><%=branch_name%></option>
<%
			rs=stmt.executeQuery("SELECT BRANCH_ID,BRANCH_NAME FROM BRANCHES WHERE BLOCK_ID='"+block_id+"'");
			while(rs.next())	
			{
%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>						
<%	
			}
%>			
			</select></td></tr>		
			<tr><td align="right"><input type="button" value="Submit" class="btn" id="sub" style="visibility:hidden" onclick="addRoom('change')" /></td><td><input type="reset" value="Clear" id="clr" class="btn" style="visibility:hidden" /></td></tr>
			<tr><td colspan="2" align="center"><input type="button" value="Close" onclick="hide()" id="close" class="btn" /></td></tr>
		</table>	
		<input type="hidden" id="temp_block" name="temp_block" value="<%=block_id%>" />		
</form>
<%
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>