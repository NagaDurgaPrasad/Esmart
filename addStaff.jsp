<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String id=request.getParameter("staff_id");
String name=request.getParameter("sname");
String doj=request.getParameter("doj");
String gen=request.getParameter("gender");
String role=request.getParameter("role");
String dept_id=request.getParameter("dept_id");
if(dept_id.equals("HOD"))
	dept_id=(String)session.getAttribute("dept");
String type=request.getParameter("type")+"user";
String temp=request.getParameter("temp");
String mobile=request.getParameter("mobile");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		if(type.equalsIgnoreCase("newuser"))
		{
			cnt=stmt.executeUpdate("INSERT INTO STAFF(STAFF_ID,NAME,GENDER,DOJ,ROLE,STATUS,BRANCH_ID,MOBILE) VALUES('"+id+"','"+name+"','"+gen+"',to_date('"+doj+"','DD-MM-YYYY'),'"+role+"',0,'"+dept_id+"',"+mobile+")");
			if(cnt>0)	
				out.print(1);
			else
				out.print(0);
		}
		else
		{ 
			cnt=stmt.executeUpdate("UPDATE STAFF SET STAFF_ID='"+id+"',NAME='"+name+"',GENDER='"+gen+"',DOJ=to_date('"+doj+"','DD-MM-YYYY'),ROLE='"+role+"',BRANCH_ID='"+dept_id+"',MOBILE="+mobile+" WHERE STAFF_ID='"+temp+"'");
			if(cnt>0)	
				out.print(1);
			else
				out.print(0);
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		out.print(0);		
	}
%>