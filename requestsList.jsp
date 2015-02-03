<html>
<head>
<link rel="stylesheet" type="text/css" href="style/css.css" />
<script type="text/javascript" src="script/javaScript.js"></script>
<script>
	function deleteReq(uid,rid)
	{
		var ans=window.confirm("Are you sure? Do you want to Delete ?");
		if(ans)
		{
			if (window.XMLHttpRequest)
 				xmlhttp=new XMLHttpRequest();
			else	
 	 			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			xmlhttp.onreadystatechange=function()
  			{
  				if(xmlhttp.readyState==4 && xmlhttp.status==200)
  				{
  					popup("Successfull","Request is Successfully Deleted",1)
  					window.reload();
  				}
 			} 	
			xmlhttp.open("GET","deleteReq.jsp?uid="+uid+"&rid="+rid,false);
			xmlhttp.send();
		}		
	}
</script>
</head>
<body style="border-left:1px gray solid;height:520px;">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<table class="requests">
<%
try
	{
		String uid=(String)session.getAttribute("uid");
		int cnt=0,c=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=null,rs2=null;
		rs=stmt.executeQuery("SELECT EXAM_ID,to_char(REQ_DATE,'DD-MON-YYYY'),RID FROM INVIG_REQUESTS WHERE REQUESTED_TO='"+uid+"' GROUP BY EXAM_ID,RID,to_char(REQ_DATE,'DD-MON-YYYY') ORDER BY to_char(REQ_DATE,'DD-MON-YYYY') DESC");
		while(rs.next())	
		{
			int status=0,flag=0;
			String exname="";
			cnt++;
			rs2=stmt2.executeQuery("SELECT DELETED_STATUS FROM VISITED_LIST WHERE USER_ID='"+uid+"' AND RID='"+rs.getString(3)+"'");
			if(rs2.next())
			{
				status=1;
				flag=rs2.getInt(1);
			}
			rs2=stmt2.executeQuery("SELECT EXAM_NAME FROM EXAMS WHERE EXAM_ID='"+rs.getString(1)+"'");
			if(rs2.next())
				exname=rs2.getString(1);
			if(status==1&&flag==0)
			{
				c++;
%>
				<tr class="visited"><td><%=cnt%></td><td><%=rs.getString(2)%></td><td><img src="pic/read.png" width="30px" height="25px" alt="visited" /></td><td><a href="requests.jsp?uid=<%=uid%>&exid=<%=rs.getString(1)%>&rid=<%=rs.getString(3)%>" >Invigilators Needed for "<%=exname%>" </a></td><td><a onclick="deleteReq('<%=uid%>','<%=rs.getString(3)%>')"><img src="pic/del.png" width="25px" height="25px" alt="Delete" /></a></td></tr> 
<%			}
			else if(status==0)
			{ c++;
%>
				<tr><td><%=cnt%></td><td><%=rs.getString(2)%></td><td><img src="pic/nonread.png" width="30px" height="25px" alt="visited" /></td><td><a href="requests.jsp?uid=<%=uid%>&exid=<%=rs.getString(1)%>&rid=<%=rs.getString(3)%>" >Invigilators Needed for "<%=exname%>" </a></td><td><a onclick="deleteReq('<%=uid%>','<%=rs.getString(3)%>')"><img src="pic/del.png" width="25px" height="25px" alt="Delete" /></a></td></tr>
<%			}
			
		}
		if(c>0)
		{
			%>
				<thead><tr><td>S.NO</td><td>Date</td><td colspan="3">Requests</td></tr></thead></table>
			<%
		}
		else
		{
			%>
				<strong class="promptmsg">You don't have any Invigilation Requests</strong>
			<%
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</body>
</html>