<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String sid=request.getParameter("sid");
String date=request.getParameter("date");
String exid=request.getParameter("exid");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		out.println("INSERT INTO INVIGILATION(EXAM_ID,STAFF_ID,ROOM_ID,INVIG_DATE,PAY_STATUS) VALUES('"+exid+"','"+sid+"',NULL,to_date('"+date+"','DD-MM-YYYY'),NULL)");
		cnt=stmt.executeUpdate("INSERT INTO INVIGILATION(EXAM_ID,STAFF_ID,ROOM_ID,INVIG_DATE,PAY_STATUS) VALUES('"+exid+"','"+sid+"',NULL,to_date('"+date+"','DD-MM-YYYY'),NULL)");
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