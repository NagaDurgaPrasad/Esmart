<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String uid=request.getParameter("uid");
String rid=request.getParameter("rid");
String dept=(String)session.getAttribute("dept");
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		if(dept.equals("Admin"))
		{
			stmt.executeUpdate("DELETE FROM VISITED_LIST WHERE RID='"+rid+"'");		
			stmt.executeUpdate("DELETE FROM INVIG_REQUESTS WHERE RID='"+rid+"'");
		}
		else
		{
			stmt.executeUpdate("UPDATE VISITED_LIST SET DELETED_STATUS=1 WHERE RID='"+rid+"' AND USER_ID='"+uid+"'");		
			response.sendRedirect("requestsList.jsp");
		}		
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		%>
			<div id='alertbox3' class='alertbox'>Sorry....Details are not Saved.<%=e.getErrorCode()%><div class="close" title="Close" onclick="hideMsg('alertbox3')">X</div></div>
		<%		
	}
%>