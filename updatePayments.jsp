<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String exid=request.getParameter("exid");
String amount=request.getParameter("amount");
String persons=request.getParameter("persons");
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		stmt.executeUpdate("DELETE FROM INVIG_PAYMENTS WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("INSERT INTO INVIG_PAYMENTS VALUES('"+exid+"',"+amount+","+persons+",SYSDATE)");
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{			
	}
%>