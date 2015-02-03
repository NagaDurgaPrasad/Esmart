<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		stmt.executeUpdate("DELETE FROM MISSING_NUMBERS WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM SUPPLY_NUMS WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM INVIGILATION WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM INVIG_PAYMENTS WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM EXAM_DATES WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM INVIG_REQUESTS WHERE EXAM_ID='"+exid+"'");
		stmt.executeUpdate("DELETE FROM EXAMS WHERE EXAM_ID='"+exid+"'");
		out.print(true);
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
		out.println(false);
	}
%>
