<html>
<head>
<style>
	#changeTab{margin:10px;margin-left:5%;}
	#changeTab .textbox{height:30px;font-color:black;text-align:center;}
	#changeTab select{width:500px;height:30px;}
	#changeTab option{width:500px;height:30px;}
	#changeTab td{text-align:center;}
</style>
</head>
<body>
<table id="changeTab">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		String date=request.getParameter("date");
		String sid=request.getParameter("sid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT I.STAFF_ID,S.NAME,S.BRANCH_ID FROM INVIGILATION I JOIN STAFF S ON I.STAFF_ID=S.STAFF_ID AND I.STAFF_ID='"+sid+"' AND I.EXAM_ID='"+exid+"' AND to_char(INVIG_DATE,'DD-MM-YYYY')='"+date+"' ORDER BY S.BRANCH_ID");
		if(rs.next())	
		{
			%>
				<tr id="replaceStaff"><td><input type="text" class="textbox" readonly id="oldid" style="width:150px;" value="<%=rs.getString(1)%>" /></td><td><input type="text" class="textbox" readonly style="width:250px;" id="oldname" value="<%=rs.getString(2)%>" /></td><td><input type="text" class="textbox" readonly id="olddept" value="<%=rs.getString(3)%>" style="width:100px;" /></td></tr>
			<%
		}
		%>
			<tr><td colspan="3"><button onclick="ExchangeInvigilator(document.getElementById('selectstaff').value,'<%=sid%>','<%=exid%>','<%=date%>')"><img src="pic/replace.png" width="35" height="35" alt="Replace" style="border:0;" /></button></td></tr>
			<tr><td colspan="3"><select class="textbox" id="selectstaff" ><option value="">Select New Invigilator</option>
		<%
		rs=stmt.executeQuery("SELECT STAFF_ID,NAME,BRANCH_ID FROM STAFF ORDER BY NAME");
		while(rs.next())
		{
%>
			<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getString(2)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<%=rs.getString(3)%>]</option>
<%			
		}
		%>
			</td></tr><td colspan="3"><br/><br/><button class="btn" onclick="document.getElementById('invig_allot_form').removeChild(document.getElementById('replacebox'));getInvigilators();">Close</button></td></table>
		<%
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</body>
</html>