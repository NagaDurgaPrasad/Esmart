<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String exam_id=request.getParameter("exam_id");
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		stmt.executeUpdate("DELETE FROM INVIG_REQUESTS WHERE EXAM_ID='"+exam_id+"'");		
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