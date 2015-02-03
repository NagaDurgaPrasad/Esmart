<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String uid=request.getParameter("uid");
		String ans=request.getParameter("ans");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT ANS FROM USERS WHERE USER_ID='"+uid.toUpperCase()+"'");
		if(rs.next())	
		{	
			if(ans.equalsIgnoreCase(rs.getString(1)))
			{
			%>
				<tr><td style="width:300px;">New Password</td><td><input type="password" class="textbox" name="pwd" maxlength="20" onkeypress="capsLock(event)" /><br/><em id="capslockstatus" style="background:url(pic/info.jpg) no-repeat left;background-size:16px 16px;text-indent:50px;width:200px;color:red;"></em></td></tr>
				<tr><td style="width:300px;">Re-Enter Password</td><td><input type="password" class="textbox" name="repwd" maxlength="20" /></td></tr>
				<tr><td colspan="2"><input type="button" style="width:200px;" value="  Save Password  " id="btn" onclick="changePassword()" ></td></tr> 
			<%
			}
			else
			{
				%>
					<tr><td colspan="2" align="center" style="width:300px;"><strong style="background:url(pic/warn.png) no-repeat left;background-size:35px 35px;padding:40px;">Sorry Incorrect Ans</strong></td></tr>
					<tr><td><input type="button" style="width:120px;" value=" Try Again " id="btn" onclick="checkAns()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OR</td><td><input type="button" style="width:250px;" value=" Send Password To Email  " id="btn" onclick="sendMail()" ></td></tr>
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