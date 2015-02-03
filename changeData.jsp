<html>
<head>
<link href="style/css.css"  rel="stylesheet"/>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
String id=request.getParameter("id");
String pwd=request.getParameter("pwd");
String name=request.getParameter("name");
String dob=request.getParameter("dob");
String gen=request.getParameter("gen");;
String dept=request.getParameter("dept");
String mobile=request.getParameter("mobile");
String email=request.getParameter("email");
String ques=request.getParameter("ques");
String ans=request.getParameter("ans");
String uid=(String)session.getAttribute("uid");
String type=(String)session.getAttribute("type");
session.removeAttribute("uid");
session.removeAttribute("name");
session.setAttribute("name",name);
session.setAttribute("uid",id);
session.setAttribute("dept",dept);
String link=(String)session.getAttribute("link");
session.removeAttribute("link");
String branch=null;
if(!type.equals("Administrator"))
	branch="'"+dept+"'";
int cnt=0;
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		cnt=stmt.executeUpdate("UPDATE USERS SET USER_ID='"+id.toUpperCase()+"',PASSWORD='"+pwd+"',NAME='"+name+"',DOB=to_date('"+dob+"','DD-MM-YYYY'),GENDER='"+gen+"',DEPT="+branch+",MOBILE="+mobile+",EMAIL='"+email+"',QUES='"+ques+"',ANS='"+ans+"' WHERE USER_ID='"+uid+"'");
		if(cnt>0)	
		{
			%>
				<div style="position:absolute;top:20%;left:20%;width:700px;height:200px;border:1px gray ridge;box-shadow:2px 2px 5px 2px green;border-radius:5px;">
					<table style="border:none;padding-top:20px;width:500px;margin-left:8%;">
						<tr><td style="padding:none;"><img src="pic/p1.jpg" width="50px" height="50px" alt="Success" style="border:0;" /></td><td style="font-size:30px;color:green;">You are Successfully Registered</td></tr>
						<tr><td colspan="2"></td></tr>
						<tr><td colspan="2" align="center"><button onclick="location.replace('Logout.jsp');" class="btn">Logout</button>&nbsp;&nbsp;&nbsp;<button class="btn" onclick="location.replace('<%=link%>')">Home Page</button></td></tr>
					</table>				
				</div>
			<%
		}
		else
		{
		%>
			<div style="position:absolute;top:20%;left:20%;border:1px gray ridge;box-shadow:2px 2px 5px 2px red;border-radius:5px;">
			<div id='alertbox' class='alertbox'>Sorry....Details are not Saved.<br/><button onclick=location.replace("Registration.jsp")>Register Again</button>&nbsp;&nbsp;&nbsp;<button onclick=location.replace("Logout.jsp")>Logout</button></div>
			</div>
		<%			
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{	
		%>
		<div style="position:absolute;top:20%;left:20%;border:1px gray ridge;box-shadow:2px 2px 5px 2px red;border-radius:5px;">
			<div id='alertbox' class='alertbox'>Sorry....Details are not Saved.<br/><button onclick=location.replace("Registration.jsp")>Register Again</button>&nbsp;&nbsp;&nbsp;<button onclick=location.replace("Logout.jsp")>Logout</button></div>
		</div>
		<%		
	}
%>
</body>
</html>