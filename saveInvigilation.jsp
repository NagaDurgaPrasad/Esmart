<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String exid=request.getParameter("exid");
String date=request.getParameter("date");
String rno=request.getParameter("rno");
String sid=request.getParameter("sid");
String fno=request.getParameter("fno");
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		stmt.executeUpdate("UPDATE INVIGILATION SET ROOM_ID='"+rno+"',FILE_NO="+fno+" WHERE EXAM_ID='"+exid+"' AND STAFF_ID='"+sid+"' AND INVIG_DATE=to_date('"+date+"','DD-MM-YYYY')");
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	}
%>