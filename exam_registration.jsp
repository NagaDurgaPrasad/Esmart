<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String extype=request.getParameter("extype");
String exname=request.getParameter("exname");
String month=request.getParameter("month");
String ac_yr=request.getParameter("ac_yr");
int excnt=Integer.parseInt(request.getParameter("excnt"));
String dates[]=(request.getParameter("dates")).split(",");
String starttime[]=(request.getParameter("starttime")).split(",");
String endtime[]=(request.getParameter("endtime")).split(",");
String eid=extype+ac_yr.substring(0,4)+month.substring(0,3);
session.setAttribute("exid",eid);
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("INSERT INTO EXAMS(EXAM_ID,EXAM_NAME,ACADEMIC_YEAR,MONTH,CR_TIME) VALUES('"+eid+"','"+exname+"','"+ac_yr+"','"+month+"',current_timestamp)");
		out.println("INSERT INTO EXAMS(EXAM_ID,EXAM_NAME,ACADEMIC_YEAR,MONTH,CR_TIME) VALUES('"+eid+"','"+exname+"','"+ac_yr+"','"+month+"',current_timestamp)");
		if(cnt>=0)	
		{
			for(int i=0;i<dates.length;i++)
			{					
				stmt.executeUpdate("INSERT INTO EXAM_DATES VALUES('"+eid+"',TO_DATE('"+dates[i]+"','DD-MM-YYYY'),NULL,'"+starttime[i]+"','"+endtime[i]+"')");
			}	
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{			
	
	}
%>