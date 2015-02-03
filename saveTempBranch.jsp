<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String bid[]=(request.getParameter("bid")).split(",");
String rid[]=(request.getParameter("rid")).split(",");
String cap[]=(request.getParameter("cap")).split(",");
String pri[]=(request.getParameter("pri")).split(",");
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		for(int i=0;i<bid.length;i++)
			stmt.executeUpdate("INSERT INTO TEMP_BRANCH_PRIORITY VALUES('"+bid[i]+"','"+rid[i]+"','"+cap[i]+"','"+pri[i]+"')");
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