<html>
<head>
<link rel="stylesheet" type="text/css" href="style/css.css" />
<link href="style/jquery.ui.all.css" rel="stylesheet">
<script type="text/javascript" src="script/javaScript.js"></script>
<script type="text/javascript" src="script/jquery.js"></script>
<script src="script/jquery.ui.core.js"></script>
<script src="script/jquery.ui.widget.js"></script>
<script src="script/jquery.ui.accordion.js"></script>
<script type="text/javascript">
$(document).ready(function(){
 $( ".accordion" ).accordion({active: false,
            autoHeight: false,
            navigation: true,
            collapsible: true});
});
function submitmodifiedResponse(val,exid)
{
	if (window.XMLHttpRequest)
 		xmlhttp=new XMLHttpRequest();
	else	
 	 	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
  		{
  			submitResponse(val);
  		}
 	} 	
	xmlhttp.open("GET","deleteResponse.jsp?exam_id="+exid,false);
	xmlhttp.send();
}
function submitResponse(val)
{
	var cnt=0;
	if (window.XMLHttpRequest)
 		xmlhttp=new XMLHttpRequest();
	else	
 	 	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
  		{
  			cnt++;
  		}
 	}
 	var flag=0;
 	for(i=1;i<val;i++)
	{
		if(document.getElementById("invig"+i).checked)
		{
			flag++;
			var vals=(document.getElementById("invig"+i).value).split(',');
			xmlhttp.open("GET","saveResponse.jsp?sid="+vals[0]+"&date="+vals[1]+"&exid="+vals[2],false);
			xmlhttp.send();
		}
	}
	if(cnt==flag)
	{
		popup("Successful","Successfully Submitted",1);
		setTimeout(function(){location.reload()},2000);
	}
	else
		popup("Alert","Response Not fully submitted",2);
}
</script>
</head>
<body style="border-left:1px gray solid;height:520px;">
<table class="requests2">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		int cnt=0;
		int alloted=0;
		String uid=request.getParameter("uid");
		String type=(String)session.getAttribute("type");
		String exid=request.getParameter("exid");
		String rid=request.getParameter("rid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();	
		ResultSet rs=stmt.executeQuery("SELECT * FROM VISITED_LIST WHERE USER_ID='"+uid+"' AND RID='"+rid+"'");
		if(rs.next())
			cnt=1;
		if(cnt==0)
			stmt.executeUpdate("INSERT INTO VISITED_LIST(USER_ID,RID,VISITED_ON) VALUES('"+uid+"','"+rid+"',CURRENT_TIMESTAMP)");
		cnt=0;
		rs=stmt.executeQuery("SELECT S.STAFF_ID,S.NAME FROM STAFF S JOIN USERS U ON U.USER_ID='"+uid+"' AND U.DEPT=S.BRANCH_ID");	
		while(rs.next())
			cnt++;
		String staff[][]=new String[cnt][2];
		cnt=0;
		rs=stmt.executeQuery("SELECT S.STAFF_ID,S.NAME,S.BRANCH_ID FROM STAFF S JOIN USERS U ON U.USER_ID='"+uid+"' AND U.DEPT=S.BRANCH_ID");	
		while(rs.next())
		{
			staff[cnt][0]=rs.getString(1);
			staff[cnt++][1]=rs.getString(2);
		}
		cnt=0;
		int temp=1;
		String ss="";
		String ds="";
		rs=stmt.executeQuery("SELECT STAFF_ID,to_char(INVIG_DATE,'DD-MON-YYYY') FROM INVIGILATION WHERE EXAM_ID='"+exid+"'");
		while(rs.next())
		{
			ss+=rs.getString(1)+",";
			ds+=rs.getString(2)+",";
		}
		String staff2[]=ss.split(",");
		String dates[]=ds.split(",");
		rs=stmt.executeQuery("SELECT TO_CHAR(I.INVIG_DATE,'DD-MON-YYYY'),E.START_TIME,E.END_TIME,I.NOP,I.RID,to_char(E.EXAM_DATE,'DD-MON-YYYY') FROM EXAM_DATES E JOIN INVIG_REQUESTS I ON I.REQUESTED_TO='"+uid+"' AND I.EXAM_ID='"+exid+"' AND E.EXAM_ID=I.EXAM_ID AND E.EXAM_DATE=I.INVIG_DATE ORDER BY I.INVIG_DATE");
		while(rs.next())	
		{
			cnt++;
			if(cnt==1)
			{
%>
				<thead><tr><td>S.NO</td><td>Date of Invigilation</td><td>Invigilation Timings</td><td>Staff Needed</td><td>Select Staff</td></tr></thead>				
<%
			}
%>
				<tr style="cursor:pointer"><td><%=cnt%></td><td><%=rs.getString(1)%></td><td><%=rs.getString(2)%>&nbsp;To&nbsp;<%=rs.getString(3)%></td><td><%=rs.getString(4)%></td>
				<td><div class="accordion">
					<h3 style="height:15px;color:white;background-color:#1E90FF;padding-top:2px;padding-left:5px;width:185px;border:1px black solid">Select Staff</h3>
						<div style="text-align:left;font-size:14px;">
				<%
					for(int i=0;i<staff.length;i++)
					{
						int status=0;
						for(int j=0;j<staff2.length;j++)
						{
							if(staff[i][0].equals(staff2[j])&&dates[j].equals(rs.getString(6)))
							{
								%>
								<input style="padding:2px 0 2px 2px;" type="checkbox" id="invig<%=temp%>" checked="checked" value="<%=staff[i][0]%>,<%=rs.getString(6)%>,<%=exid%>" /><label for="invig<%=temp%>"><%=staff[i][1]%></label><br/>
								<%
								status=1;
								alloted++;
								break;
							}
						}
						if(status==0)
						{
							%>
								<input style="padding:2px 0 2px 2px;" type="checkbox" id="invig<%=temp%>" value="<%=staff[i][0]%>,<%=rs.getString(6)%>,<%=exid%>" /><label for="invig<%=temp%>"><%=staff[i][1]%></label><br/>
							<%
						}
						temp++;
					}
				%>		</div>
					</div>
				</td></tr>
				<%
			}
				if(alloted==0)
				{
					%>
					</table>
					<div style="left:25%;margin:5%;position:relative;">
					<button class="btn" onclick="submitResponse(<%=temp%>,1)">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn" onclick="location.replace('requestsList.jsp')">Go Back</button>
					</div>
					</body>
					</html>
					<%
				}
				else
				{
					%>
					</table>
					<div style="left:25%;margin:5%;position:relative;">
					<button class="btn" onclick="submitmodifiedResponse(<%=temp%>,'<%=exid%>')">Modify</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn" onclick="location.replace('requestsList.jsp')">Go Back</button>
					</div>
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