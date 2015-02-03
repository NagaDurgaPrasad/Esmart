<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT EXAM_ID FROM EXAMS WHERE EXAM_ID='"+exid+"'");
		if(rs.next())	
		{
%>
		<div style="color:red;font-size:13px;"><img src="pic/warn.png" style="width:20px;height:20px;"/>&nbsp;Sorry Examination Already Registered with the above Information<input type="hidden" id="exavailStatus" value="1" /></div>
<%		
		}
		else
		{
%>
			<input type="hidden" id="exavailStatus" value="0" />
<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
