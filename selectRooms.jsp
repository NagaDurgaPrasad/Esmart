
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String block=null;
		int status=0,cnt=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT B.BLOCK_NAME,R.ROOM_ID,NO_ROWS*NO_COLUMNS FROM BLOCKS B,ROOMS R WHERE B.BLOCK_ID=R.BLOCK_ID ORDER BY B.BLOCK_ID,R.ROOM_NO");
		while(rs.next())	
		{
			String newstr=rs.getString(1).replace(" ","");
			if(block==null)
			{
				block=rs.getString(1);
				status=1;
			}
			else if(block.equals(rs.getString(1)))
				status=2;
			else
			{
				status=3;
				block=rs.getString(1);
			}
			if(status==1)
			{
%>
				<h3 style="font-weight:bold;color:maroon;background-color:skyblue;font-size:15px;height:14px;padding-top:2px;"><%=rs.getString(1)%></h3><div>
				<input type="checkbox" value="<%=rs.getString(2)%>" onclick="selectAll('<%=newstr%>roomslist');" id="<%=newstr%>" class="<%=newstr%>roomslisthead" /><label style="cursor:pointer;color:black;font-size:12px;font-weight:bold;" for="<%=newstr%>" >Select All</label><input type="hidden" value="<%=newstr%>" class="blockname"/><br/>
<%			
			}
			else if(status==3)
			{
%>
				</div><h3 style="font-weight:bold;color:maroon;background-color:skyblue;font-size:15px;height:14px;padding-top:2px;"><%=rs.getString(1)%></h3><div>
				<input type="checkbox" value="<%=rs.getString(2)%>" onclick="selectAll('<%=newstr%>roomslist');" id="<%=newstr%>" class="<%=newstr%>roomslisthead" /><label style="cursor:pointer;color:black;font-size:12px;font-weight:bold;" for="<%=newstr%>">Select All</label><input type="hidden" value="<%=newstr%>" class="blockname"/><br/>
<%			
			}	
%>
			<input type="checkbox" value="<%=rs.getString(2)%>" onclick="saveRoom('<%=rs.getString(1)%>',<%=cnt%>)" id="room<%=cnt%>" class="<%=newstr%>roomslist" /><label style="cursor:pointer;color:black;font-size:12px;font-weight:bold;" class="<%=newstr%>roomslisttext" id="rm<%=cnt%>" for="room<%=cnt%>" ><%=rs.getString(2)%></label><small style="color:maroon;font-size:12px;">&nbsp;&nbsp;Capacity&nbsp;&nbsp;<b id="cap<%=cnt++%>"><%=rs.getString(3)%></b></small><input type="hidden" value="<%=rs.getString(3)%>" id="rc<%=rs.getString(2)%>"/> <br/>
<%		
			status=0;
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</div>