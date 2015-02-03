<html>
<head>
<title>Invigilation Allotment Form</title>
<link rel="stylesheet" type="text/css" href="style/print.css" media="print"/>
<style>
	.requests{width:750px;}
	.requests td{border-radius:2px;border:1px black ridge;background-color:white;}
	.requests td button{float:right;top:0;}
	.requests thead td{font-size:14px;}
	.requests .textbox{border:none;text-align:center;color:black;width:80px;}
	.promptmsg{font-size:20px;text-align:center;width:500px;}
	.section1{width:750px;height:100%;float:left;overflow:auto;}
	.section2{width:250px;height:100%;float:left;overflow-y:auto;}
	.section2 table{width:200px}
	.section2 table td{width:auto;height:20px;font-size:12px;border:1px gray ridge;color:black;}
	.section2 #br{font-size:10px;width:40px;}
	.section2 table thead td{width:200px;height:20px;font-size:12px;background-color:maroon;color:white;}
</style>
</head>
<body>
<input type="button" value="&nbsp;Print&nbsp;" style="position:absolute;top:-8%;left:85%;font-weight:bold;width:100px;height:30px;" onclick="printDiv('section1')" />
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		int cnt=1;
		String exid=request.getParameter("exid");
		String date=request.getParameter("date");
		String bid="";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=null,rs2=null;
		rs=stmt.executeQuery("SELECT EXAM_NAME,MONTH,ACADEMIC_YEAR FROM EXAMS WHERE EXAM_ID='"+exid+"'");
		if(rs.next())
		{	
			%>
				<div class="section1" id="section1"><table class="inform"><tr><td colspan="2"><%=rs.getString(1)%></td></tr><tr><td>MONTH &nbsp;:&nbsp;<%=rs.getString(2)%></td><td>ACADEMIC YEAR &nbsp;:&nbsp;<%=rs.getString(3)%></td></tr><tr><td colspan="2">DATE&nbsp;&nbsp;:&nbsp;<%=date%></td></tr></table><table class="requests">
			<%
		}
		rs=stmt.executeQuery("SELECT S.BRANCH_ID,I.STAFF_ID,S.NAME,I.ROOM_ID,I.FILE_NO FROM INVIGILATION I JOIN STAFF S ON I.STAFF_ID=S.STAFF_ID AND I.EXAM_ID='"+exid+"' AND to_char(INVIG_DATE,'DD-MM-YYYY')='"+date+"' ORDER BY S.BRANCH_ID");
		while(rs.next())	
		{
			int sum=0;
			String rmid="";
			String file="";
			if(rs.getString(4)!=null)
			{
				rmid=rs.getString(4);
				file=rs.getString(5);
			}
			if(!bid.equals(rs.getString(1)))
			{
				rs2=stmt2.executeQuery("SELECT COUNT(*) FROM INVIGILATION I JOIN STAFF S ON I.STAFF_ID=S.STAFF_ID AND I.EXAM_ID='"+exid+"' AND to_char(INVIG_DATE,'DD-MM-YYYY')='"+date+"' AND S.BRANCH_ID='"+rs.getString(1)+"' GROUP BY S.BRANCH_ID");
				if(rs2.next())
					sum=rs2.getInt(1);
				%>			
				<tr><td><%=cnt%></td><td rowspan="<%=sum%>"><%=rs.getString(1)%></td><td><input type="text" class="textbox" tabindex="-1" id="staff<%=cnt-1%>" readonly value="<%=rs.getString(2)%>" /></td><td style="text-align:left;"><%=rs.getString(3)%><button onclick="changeInvigData('<%=exid%>','<%=date%>','<%=rs.getString(2)%>')" tabindex="-1">Edit</button></td><td><input type="text" class="textbox" value="<%=file%>" id="file<%=cnt-1%>" onkeypress="return isNum(event)" onchange="setRoom(this,'rno<%=cnt%>')" /></td><td><input type="text" class="textbox" value="<%=rmid%>" id="rno<%=cnt%>" tabindex="-1" readonly /></td><td>&nbsp;</td><td>&nbsp;</td></tr>
				<%
				bid=rs.getString(1);
			}
			else
			{
				%>			
				<tr><td><%=cnt%></td><td><input type="text" readonly class="textbox" id="staff<%=cnt-1%>" tabindex="-1" value="<%=rs.getString(2)%>" /></td><td style="text-align:left;"><%=rs.getString(3)%><button onclick="changeInvigData('<%=exid%>','<%=date%>','<%=rs.getString(2)%>')" tabindex="-1">Edit</button></td><td><input type="text" class="textbox" onkeypress="return isNum(event)" value="<%=file%>" id="file<%=cnt-1%>" onchange="setRoom(this,'rno<%=cnt%>')" /></td><td><input type="text" class="textbox" value="<%=rmid%>" id="rno<%=cnt%>" tabindex="-1" readonly /></td><td>&nbsp;</td><td style="width:200px">&nbsp;</td></tr>
				<%
			}
		cnt++;
		}
		if(cnt>1)
		{
			
%>
			<tr><td colspan="8"><input type="button" class="btn" onclick="saveInvigilation()" value=" SUBMIT "/><input type="hidden" value="<%=cnt%>" id="invigCount"/></td></tr>			
			<thead><tr><td style="width:15px">S.NO</td><td style="width:35px">DEPT.</td><td style="width:90px">STAFF ID</td><td style="width:190px">NAME</td><td style="width:40px">FILE NO</td><td style="width:60px">ROOM NO.</td><td style="width:70px">TIME</td><td style="width:200px">SIGNATURE</td></tr></thead></table></div>
			<div class="section2"><table><thead><tr><td>File</td><td>Room</td><td colspan="2">Branches&nbsp;&amp;&nbsp;Count</td></tr></thead>
			<%
			cnt=1;
			rs=stmt.executeQuery("SELECT ROOM_ID,SUM(NO_STU) FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' GROUP BY ROOM_ID");
			while(rs.next())
			{
				%>
				<tr><td><%=cnt%></td><td><%=rs.getString(1)%><input type="hidden" value="<%=rs.getString(1)%>" id="rmf<%=cnt++%>" /></td>
				<td id="br">[<%	
				rs2=stmt2.executeQuery("SELECT BRANCH_ID FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' AND ROOM_ID='"+rs.getString(1)+"' ORDER BY ORDERED");
				while(rs2.next())
					out.print(rs2.getString(1)+",");
				%>]</td><td><%=rs.getInt(2)%></td></tr><%
			}	
			%></table><input type="hidden" onclick="alert(this.value)" value="<%=cnt%>" id="limit"><%
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