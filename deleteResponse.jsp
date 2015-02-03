<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String exam_id=request.getParameter("exam_id");
String dept=(String)session.getAttribute("dept");
try
	{
		String ss="";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT S.BRANCH_ID,I.STAFF_ID FROM STAFF S JOIN INVIGILATION I ON I.EXAM_ID='"+exam_id+"' AND I.STAFF_ID=S.STAFF_ID");		
      while(rs.next())
      {
          if(rs.getString(1).equals(dept))
          	ss+=rs.getString(2)+",";
      }
  		String staff[]=ss.split(",");
  		for(int i=0;i<staff.length;i++)
  			stmt.executeUpdate("DELETE FROM INVIGILATION WHERE STAFF_ID='"+staff[i]+"'");
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