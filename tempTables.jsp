<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		stmt.executeUpdate("CREATE TABLE TEMP_BRANCH(BID VARCHAR2(10),SNO VARCHAR2(10),ENO VARCHAR2(10))");
		stmt.executeUpdate("CREATE TABLE TEMP_ROOM_PRIORITY(RID VARCHAR2(10),BID VARCHAR2(10),PRIORITY NUMBER(2))");
		stmt.executeUpdate("CREATE TABLE TEMP_BRANCH_PRIORITY(BID VARCHAR2(10),RID VARCHAR2(10),CAPACITY NUMBER(2),PRIORITY NUMBER(2))");
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
