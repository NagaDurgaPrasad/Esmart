<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String bid=request.getParameter("arg1");
String sno=request.getParameter("arg2");
String eno=request.getParameter("arg3");
String mno[]=(request.getParameter("arg4")).split(",");
String xno[]=(request.getParameter("arg5")).split(",");
String eid=(String)session.getAttribute("exid");
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("INSERT INTO TEMP_BRANCH VALUES('"+bid+"','"+sno+"','"+eno+"')");
		if(cnt>=0)	
		{
				for(int i=0;i<mno.length;i++)
				{
					if(!mno[i].equals(""))
						stmt.executeUpdate("INSERT INTO MISSING_NUMBERS VALUES('"+eid+"','"+bid+"','"+mno[i]+"')");
				}
				for(int i=0;i<xno.length;i++)
				{
					if(!xno[i].equals(""))
						stmt.executeUpdate("INSERT INTO ADDITIONAL_NUMBERS VALUES('"+eid+"','"+bid+"','"+xno[i]+"')");
				}						
				//%>
			//	<div id='infobox3' class='infobox'>Details are Successfully saved.<div class="close" title="Close" onclick="hideMsg('infobox3');block1.reset()">X</div></div>
				//<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	%>
			<div id='alertbox3' class='alertbox'>Sorry....Details are not Saved.<%=e.getErrorCode()%><div class="close" title="Close" onclick="hideMsg('alertbox3')">X</div></div>
		<%		
	}
%>