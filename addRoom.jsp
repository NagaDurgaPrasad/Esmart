<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String id=request.getParameter("room_id");
String rno=request.getParameter("room_no");
String rows=request.getParameter("rows");
String cols=request.getParameter("cols");
String block_id=request.getParameter("block_id");
String branch_id=request.getParameter("branch_id");
String type=request.getParameter("type");
String temp_id=request.getParameter("temp_id");
String temp_block=request.getParameter("temp_block");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		if(type.equalsIgnoreCase("new"))
			cnt=stmt.executeUpdate("INSERT INTO ROOMS(ROOM_ID,ROOM_NO,NO_ROWS,NO_COLUMNS,BLOCK_ID,BRANCH_ID) VALUES('"+id+"',"+rno+","+rows+","+cols+",'"+block_id+"','"+branch_id+"')");
		else 
			cnt=stmt.executeUpdate("UPDATE ROOMS SET ROOM_ID='"+id+"',ROOM_NO="+rno+",NO_ROWS="+rows+",NO_COLUMNS="+cols+",BLOCK_ID='"+block_id+"',BRANCH_ID='"+branch_id+"' WHERE ROOM_ID='"+temp_id+"'");
		if(cnt>0)	
		{
			if(type.equalsIgnoreCase("new"))
				stmt.executeUpdate("UPDATE BLOCKS SET AVAIL_ROOMS=AVAIL_ROOMS+1 WHERE BLOCK_ID='"+block_id+"'");
			else if(type.equalsIgnoreCase("change")&&!(block_id.equalsIgnoreCase(temp_block)))
			{
				stmt.executeUpdate("UPDATE BLOCKS SET AVAIL_ROOMS=AVAIL_ROOMS+1 WHERE BLOCK_ID='"+block_id+"'");
				stmt.executeUpdate("UPDATE BLOCKS SET AVAIL_ROOMS=AVAIL_ROOMS-1 WHERE BLOCK_ID='"+temp_block+"'");
			}	
			out.print(1);	
		}
		else
			out.print(0);
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	out.print(0);		
	}
%>