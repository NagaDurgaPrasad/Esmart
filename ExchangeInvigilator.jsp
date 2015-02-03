<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		int cnt=0;
		String exid=request.getParameter("exid");
		String date=request.getParameter("date");
		String news=request.getParameter("news");
		String old=request.getParameter("old");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("UPDATE INVIGILATION SET STAFF_ID='"+news+"' WHERE STAFF_ID='"+old+"' AND EXAM_ID='"+exid+"' AND to_char(INVIG_DATE,'DD-MM-YYYY')='"+date+"'");
		if(cnt>0)
		{
			ResultSet rs=stmt.executeQuery("SELECT I.STAFF_ID,S.NAME,S.BRANCH_ID FROM INVIGILATION I JOIN STAFF S ON I.STAFF_ID=S.STAFF_ID AND I.STAFF_ID='"+news+"' AND I.EXAM_ID='"+exid+"' AND to_char(INVIG_DATE,'DD-MM-YYYY')='"+date+"' ORDER BY S.BRANCH_ID");
			if(rs.next())	
			{
				%>
					<td><input type="text" class="textbox" readonly id="oldid" style="width:150px;" value="<%=rs.getString(1)%>" /></td><td><input type="text" class="textbox" readonly style="width:250px;" id="oldname" value="<%=rs.getString(2)%>" /></td><td><input type="text" class="textbox" readonly id="olddept" value="<%=rs.getString(3)%>" style="width:100px;" /></td>
				<%
			}
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>