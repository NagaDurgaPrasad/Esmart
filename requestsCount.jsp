<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String uid=(String)session.getAttribute("uid");
		int cnt=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=null,rs2=null;
		rs=stmt.executeQuery("SELECT RID FROM INVIG_REQUESTS WHERE REQUESTED_TO='"+uid+"' GROUP BY RID");
		while(rs.next())	
		{
			int status=0;
			rs2=stmt2.executeQuery("SELECT DELETED_STATUS FROM VISITED_LIST WHERE USER_ID='"+uid+"' AND RID='"+rs.getString(1)+"'");
			if(rs2.next())
			{
				status=1;
			}
			if(status==0)
				cnt++;
		}
		out.println(cnt);
	}
	catch(Exception e)
	{}
%>