<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String bid=request.getParameter("bid");
String nums[]=(request.getParameter("nums")).split(",");
String eid=(String)session.getAttribute("exid");
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		for(int i=0;i<nums.length;i++)
			stmt.executeUpdate("INSERT INTO SUPPLY_NUMS VALUES('"+eid+"','"+bid+"','"+nums[i]+"')");					
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	%>
			<div id='alertbox3' class='alertbox'>Sorry....Details are not Saved.<%=e.getErrorCode()%><div class="close" title="Close" onclick="hideMsg('alertbox3')">X</div></div>
		<%		
	}
%>