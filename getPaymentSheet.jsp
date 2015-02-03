<html>
<head>
<title>Invigilation Allotment Form</title>
<style>
	.requests{width:750px;}
	.requests td{border-radius:2px;border:1px black ridge;background-color:white;}
	.requests .tot td{border-radius:2px;border:1px black ridge;background-color:white;font-size:18px;text-align:center;font-weight:bold;}
	.requests .tot td:last-child{color:maroon;font-size:16px;text-align:center;border:1px black ridge;font-weight:bold;}
	.requests td button{float:right;top:0;}
	.requests thead td{font-size:14px;}
	.requests .textbox{border:none;width:100%;text-align:center;color:black;}
	.promptmsg{font-size:20px;text-align:center;width:500px;}
</style>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		int cnt=1;
		String exid=request.getParameter("exid");
		int amount=Integer.parseInt(request.getParameter("amount"));
		int total=0;
		int invig=0;
		int status=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT AMT_PER_HEAD FROM INVIG_PAYMENTS WHERE EXAM_ID='"+exid+"'");
		if(rs.next())
		{
			amount=rs.getInt(1);	
			status=1;	
		}
		rs=stmt.executeQuery("SELECT EXAM_NAME,MONTH,ACADEMIC_YEAR FROM EXAMS WHERE EXAM_ID='"+exid+"'");
		if(rs.next())
		{	
			%>
				<table class="inform"><tr><td colspan="2"><%=rs.getString(1)%></td></tr><tr><td>MONTH &nbsp;:&nbsp;<%=rs.getString(2)%></td><td>ACADEMIC YEAR &nbsp;:&nbsp;<%=rs.getString(3)%></td></tr>
			<%
			if(status==1)
			{
			%>				
				<tr><td colspan="2" class="error" style="font-size:15px;">Invigilation payments are already Paid</td></tr></table><table class="requests">
			<%
			}
			else
			{
			%>				
				</table><table class="requests">
			<%
			}
		}
		rs=stmt.executeQuery("SELECT I.STAFF_ID,S.NAME,S.BRANCH_ID,COUNT(I.STAFF_ID) FROM INVIGILATION I JOIN STAFF S ON I.STAFF_ID=S.STAFF_ID AND I.EXAM_ID='"+exid+"' GROUP BY I.STAFF_ID,S.NAME,S.BRANCH_ID ORDER BY S.BRANCH_ID");
		while(rs.next())	
		{
			total+=rs.getInt(4)*amount;
			invig+=rs.getInt(4);
		%>
			<tr><td><%=cnt%></td><td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getInt(4)%>&nbsp;*&nbsp;<%=amount%>&nbsp;=&nbsp;&#8377;&nbsp;<%=rs.getInt(4)*amount%></td></tr>
		<%
		cnt++;
		}
		if(cnt>1)
		{
			%>
				<tr class="tot"><td colspan="4">TOTAL AMOUNT FOR INVIGILATION</td><td><%=invig%>&nbsp;*&nbsp;<%=amount%>&nbsp;=&nbsp;&#8377;&nbsp;<%=total%></td></tr>
			<%
			if(status==1)
			{
				%><tr id="infobar"><td colspan="2" style="border:none;"><br/><input type="button" class="btn" style="width:200px" onclick="updatePayments('<%=exid%>',<%=amount%>,<%=invig%>)" value="Update Payments" /></td><td style="border:none;">New Amount(&#8377;)</td><td style="border:none;"><input type="text" class="textbox" id="newamount" style="width:80px;border:1px blue solid;" onblur="isEmpty(this,'err')" /></td><td style="border:none;" class="error" id="err"></td></tr><%
			}
			else
			{
				%><tr><td colspan="5"  style="border:none;"><br/><input type="button" class="btn" style="width:150px" onclick="savePayments('<%=exid%>',<%=amount%>,<%=invig%>)" value="Save Payments" /></td></tr><%	
			}
			%>
			<thead><tr><td>S.NO</td><td>STAFF ID</td><td style="width:200px;">NAME</td><td>DEPT.</td><td style="width:200px;">EXAMS&nbsp;*&nbsp;AMOUNT&nbsp;=&nbsp;TOTAL(&#8377;)</td></tr></thead>
			<%	
		}
		else
		{
			%>
			<div class="promptmsg">Invigilators are not Alloted</div>
			<%		
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</div>
</body>
</html>