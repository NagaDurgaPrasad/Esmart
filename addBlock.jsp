<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String id=request.getParameter("block_id");
String name=request.getParameter("bname");
String loc=request.getParameter("loc");
String args=request.getParameter("args");
String type=request.getParameter("type");
String arglist[]=args.split(",");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		if(type.equals("new"))
		{
			cnt=stmt.executeUpdate("INSERT INTO BLOCKS(BLOCK_ID,BLOCK_NAME,AVAIL_ROOMS,LOCATION) VALUES('"+id+"','"+name+"',0,'"+loc+"')");
			if(cnt>0)	
			{
				for(int i=0;i<arglist.length;i++)
					cnt=stmt.executeUpdate("UPDATE BRANCHES SET BLOCK_ID='"+id+"' WHERE BRANCH_ID='"+arglist[i]+"'");
				out.print(1);
			}
			else
				out.print(0);
		}
		else
		{
			cnt=stmt.executeUpdate("UPDATE BLOCKS SET BLOCK_NAME='"+name+"',LOCATION='"+loc+"' WHERE BLOCK_ID='"+id+"'");
			if(cnt>0)	
			{
					cnt=stmt.executeUpdate("UPDATE BRANCHES SET BLOCK_ID=NULL WHERE BLOCK_ID='"+id+"'");
					for(int i=0;i<arglist.length;i++)
						cnt=stmt.executeUpdate("UPDATE BRANCHES SET BLOCK_ID='"+id+"' WHERE BRANCH_ID='"+arglist[i]+"'");
					out.print(1);
			}
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		out.print(0);		
	}
%>