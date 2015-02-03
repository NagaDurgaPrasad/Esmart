<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String uid=request.getParameter("uid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT QUES FROM USERS WHERE USER_ID='"+uid.toUpperCase()+"'");
		if(rs.next())	
		{
			%>
				<tr><td style="width:300px;"><%=rs.getString(1)%></td><td><input type="password" class="textbox" name="ans" maxlength="20" /></td></tr>
				<tr><td><input type="button" value="  Next >>>  " id="btn" onclick="checkAns()" ></td><td id="mailpwd"></td></tr> 
			<%				
		}
		else
		{
			%>
				<tr><td colspan="2" align="center" style="width:300px;"><strong style="background:url(pic/warn.png) no-repeat left;background-size:35px 35px;padding:40px;">Incorrect Login Id</strong></td></tr>
				<tr><td><input type="button" value="  Next >>>  " id="btn" onclick="getQues()" ></td><td id="mailpwd"></td></tr>
			<%
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>