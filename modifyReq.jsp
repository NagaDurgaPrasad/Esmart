<p>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String eid=request.getParameter("eid");
String exam_id=request.getParameter("exam_id");
String nop=request.getParameter("nop");
String date=request.getParameter("date");
int cnt=0;
long rid=Long.parseLong(request.getParameter("rid"));
boolean status=false;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();		
		cnt=stmt.executeUpdate("INSERT INTO INVIG_REQUESTS(RID,REQUESTED_TO,EXAM_ID,INVIG_DATE,NOP,REQ_DATE) VALUES('R"+rid+"','"+eid+"','"+exam_id+"',to_date('"+date+"','DD-MON-YYYY'),"+nop+",sysdate)");
		if(cnt>0)	
		{
			out.println("<i style='font-size:11px'>Successfully sent to "+eid+"<br/></i>");		
		}
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
</p>