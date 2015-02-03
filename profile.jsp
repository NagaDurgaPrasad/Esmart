<%
	String uid=(String)session.getAttribute("uid");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset=UTF-8/>
<title>My Profile</title> 
<link href="style/jquery.ui.all.css" rel="stylesheet"/>
<link href="style/css.css" rel="stylesheet"/>
<style>
	.button{visibility:hidden}
	body{border-left:1px gray solid;height:530px;font-size:15px;}
	#reg{position:absolute;top:4%;left:10%;}
	label{font-size:14px}
	td{width:200px;margin:0;}
	#reg td{height:25px;}
	.textbox{width:300px;padding-left:10px;height:22px;}
	.btn{width:150px;}
	strong{color:#6D1B22;}
	.textbox:focus{width:300px;padding-left:10px;}
</style>
<script type="text/javascript" src="script/jquery.js"></script>
<script type="text/javascript" src="script/jquery-1.8.3.js"></script>
<script type="text/javascript" src="script/jquery.ui.core.js"></script>
<script type="text/javascript" src="script/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="script/javaScript.js"></script>
<script type="text/javascript">
var errStatus=-1;
$(document).ready(function(){
	getDept("dept");
	$("#dob").datepicker({ dateFormat: 'dd-mm-yy',changeMonth: true,changeYear: true,showButtonPanel: true });
	$("#chpwd").slideUp();
	setTimeout(function()
	{
   	for(var i=0; i < reg.dept.options.length; i++)
   	{	
     		if(dept.options[i].value == reg.deptval.value)
     		{
       		dept.selectedIndex = i;
       		break;
     		}
   	}
   },1000);
});
function showButton(id)
{
	document.getElementById(id).style.visibility="visible"
}
function isEmpty(ele,target)
{
	if(ele.value=="")
	{
		document.getElementById(target).innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Field Should not be Empty";
		errStatus=1;
		ele.focus();	
	}
	else
	{
		document.getElementById(target).innerHTML="";
		errStatus=0;
	}
}
function isvalidpwd(ele,target)
{
	if(ele.value=="")
	{
		document.getElementById(target).innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Field Should not be Empty";
		errStatus=1;
		ele.focus();	
	}
	else if((ele.value).length<5)
	{
		document.getElementById(target).innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Password Length is too short";
		errStatus=1;
		ele.focus();
	}
	else
	{
		document.getElementById(target).innerHTML="";
		errStatus=0;
	}
}
function isEmail(ele,target)
{
	if(ele.value=="")
	{
		document.getElementById(target).innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Field Should not be Empty";
		errStatus=1;
		ele.focus();	
	}
	else
	{
		var mail=ele.value;
		if(mail.indexOf('@')>4&&mail.lastIndexOf('.')>5)
		{
			document.getElementById(target).innerHTML="";
			errStatus=0;
		}
		else
		{
			document.getElementById(target).innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Invalid Email Address";
			errStatus=1;
			ele.focus();
		}
	}
}
function checkPassword(ele,target)
{
	var psd=chpwd.new.value;
	var rpsd=chpwd.renew.value;
	if(psd==""||psd!=rpsd)
	{
		document.getElementById(target).innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Password Missmatch";
		errStatus=1;
		document.getElementById(ele).focus();
	}	
	else
	{
		document.getElementById(target).innerHTML="";
		errStatus=0;
	}
}

function capsLock(e) 
{
   kc = e.keyCode ? e.keyCode : e.which;
   sk = e.shiftKey ? e.shiftKey : ((kc == 16) ? true : false);
   if (((kc >= 65 && kc <= 90) && !sk) || ((kc >= 97 && kc <= 122) && sk))
       document.getElementById("err8").innerHTML="<img src='pic/info.jpg' width='20' height='20' />Caps Lock is On";
   else
       document.getElementById("err8").innerHTML="";
}
function saveData(ele,item,dbid,msgid)
{
	ele.style.visibility='hidden'
	if(errStatus==0)
	{
		if (window.XMLHttpRequest)
 			xmlhttp=new XMLHttpRequest();
		else
 		 	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				document.getElementById(msgid).innerHTML=xmlhttp.responseText;
 				setTimeout(function(){document.getElementById(msgid).innerHTML=""},2000);
 			}
  		}
		xmlhttp.open("POST","saveData.jsp",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("val="+item.value+"&dbid="+dbid);	
	}
}
function changePwd()
{
	if(errStatus==0)
	{
		if (window.XMLHttpRequest)
 			xmlhttp=new XMLHttpRequest();
		else
 		 	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				document.getElementById("pch").innerHTML=xmlhttp.responseText;
 				setTimeout(function(){document.getElementById("pch").innerHTML=""},2000);
 			}
  		}
		xmlhttp.open("POST","changePwd.jsp",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("pwd="+chpwd.old.value+"&newpwd="+chpwd.new.value);	
	}
}
function showChangePwd()
{
	$("#chpwd").slideToggle();
}
</script>
</head>	
<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT USER_ID,NAME,to_char(to_date(DOB),'DD-MM-YYYY'),GENDER,DEPT,EMAIL,MOBILE,ROLE FROM USERS WHERE USER_ID='"+uid+"'");
		if(rs.next())
		{
		%>
				<form method="post" name="reg" id="reg">
					<div class="tabcont">
					<strong style="background:url(pic/profile.png) no-repeat left;background-size:35px 35px;padding:40px;">Personal Details</strong>
					<hr/>
						<table id="tab1">
							<tr><td>Staff ID</td><td><input type="text" name="id" id="id" size="30" class="textbox"  autofocus="autofocus" value="<%=rs.getString(1)%>" required="true" value="<%=uid%>" maxlength="20" onblur="isEmpty(this,'err1')" onchange="showButton('btn1')" />&nbsp;<input type="button" value="Save" class="button"id="btn1" onclick="saveData(this,document.getElementById('id'),'USER_ID','err1')"/></td><td id="err1" class="error"></td></tr>
							<tr><td>Name</td><td><input type="text" name="name" id="name" size="30" required="true" class="textbox" maxlength="30" value="<%=rs.getString(2)%>" onkeypress="return isChar(event)" onblur="isEmpty(this,'err2')" onchange="showButton('btn2')" />&nbsp;<input type="button" value="Save" class="button"id="btn2" onclick="saveData(this,document.getElementById('name'),'NAME','err2')"/></td><td id="err2" class="error"></td></tr>
							<%
							if(rs.getString(4).equals("male"))
							{	
								%>	<tr><td>Gender</td><td><input type="radio" name="gen" value="male" id="gen1" checked="checked" class="radio" required="true" onblur="isEmpty(this,'err4')"  /><label for="gen1">Male</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="gen2" name="gen" class="radio" required="true" value="female" onclick="showButton('btn4')" /><label for="gen2">Female</label>&nbsp;<input type="button" value="Save" class="button"id="btn4" onclick="saveData(this,document.getElementById('gen2'),'GENDER','err4')"/></td><td id="err4" class="error"></td></tr><%
							}
							else
							{
								%><tr><td>Gender</td><td><input type="radio" name="gen" value="male" id="gen1" class="radio" required="true" onblur="isEmpty(this,'err4')" onclick="showButton('btn4')" /><label for="gen1">Male</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="gen2" checked="checked" name="gen" class="radio" required="true" value="female" /><label for="gen2">Female</label>&nbsp;<input type="button" value="Save" class="button"id="btn4" onclick="saveData(this,document.getElementById('gen1'),'GENDER','err4')"/></td><td id="err4" class="error"></td></tr><%
							}
							if(!rs.getString(8).equalsIgnoreCase("Administrator"))
							{
								%>
									<tr><td>Department</td><td><select name="dept" id="dept" required="true" class="textbox" onblur="isEmpty(this,'err5')" onchange="showButton('btn5')" ><option value="">Select Department</option></select>&nbsp;<input type="button" value="Save" class="button"id="btn5" onclick="saveData(this,document.getElementById('dept'),'DEPT','err5')"/></td><td id="err5" class="error"></td></tr>
								<%
							}
							%>
							<tr><td>Date of Birth</td><td><input type="text" name="dob" id="dob" maxlength="10" size="30" class="textbox" required="true" value="<%=rs.getString(3)%>" onblur="isEmpty(this,'err3')" placeholder="DD-MM-YYYY" onchange="showButton('btn3')" />&nbsp;<input type="button" value="Save" class="button"id="btn3" onclick="saveData(this,document.getElementById('dob'),'DOB','err3')"/></td><td id="err3" class="error"></td></tr>
							</table>
							<br/>
						<strong style="background:url(pic/contact.png) no-repeat left;background-size:35px 35px;padding:40px;">Contact Details</strong>
						<hr/>
						<table>
							<tr><td>Email</td><td><input type="email" name="email" id="email" size="30" class="textbox"  required="true" value="<%=rs.getString(6)%>" onblur="isEmail(this,'err6')" maxlength="40" onchange="showButton('btn6')"/>&nbsp;<input type="button" value="Save" class="button"id="btn6" onclick="saveData(this,document.getElementById('email'),'EMAIL','err6')"/></td><td id="err6" class="error"></td></tr>
							<tr><td>Mobile Number</td><td><input type="text" name="mobile" id="mobile" class="textbox" onkeypress="return isNum(event)" value="<%=rs.getString(7)%>" size="30" required="true" maxlength="10" onblur="isEmpty(this,'err7')" onchange="showButton('btn7')" />&nbsp;<input type="button" value="Save" class="button"id="btn7" onclick="saveData(this,document.getElementById('mobile'),'MOBILE','err7')"/></td><td class="error" id="err7"></td></tr>
							<tr><td colspan="3"><input type="hidden" name="deptval" value="<%=rs.getString(5)%>"/></td></tr>
						</table>
						</form>
						<strong style="background:url(pic/lock.png) no-repeat left;background-size:35px 35px;padding:40px;">Security Details</strong><b id="pch"></b><img src="pic/down.png" width="25" height="25" alt="Click Here" title="Click Here" style="cursor:pointer;float:right;" onclick="showChangePwd()" />
						<hr />
						<form id="chpwd" name="chpwd">						
						<table style="float:left;">
							<tr><td>Old Password</td><td><input type="password" name="old" id="old" class="textbox" onkeyPress="return capsLock(event)"  required onblur="isEmpty(this,'err8')" maxlength="25"/></td><td id="err8" class="error"></td></tr>									
							<tr><td>New Password</td><td><input type="password" name="new" id="new" class="textbox" onblur="isvalidpwd(this,'err9')" maxlength="25" /></td><td id="err9" class="error"></td></tr>									
							<tr><td>Re-Enter New Password</td><td><input type="password" name="renew" id="renew" class="textbox" onblur="checkPassword(this,'err9')" maxlength="25"/></td><td id="err10" class="error"></td></tr>
							<tr><td colspan="2" align="center" ><input type="button" class="btn" onclick="changePwd()" class="btn" value="Save Password" /></td></tr>
						</table>
						</form>									
					</div>
	<%
	}
	con.close();
	stmt.close();
}
catch(SQLException e)
{	%>
		<div id='alertbox' class='alertbox'>Sorry....Deatails not Found<%=e.getErrorCode()%><div class="close" title="Close" onclick="hideMsg('alertbox')">X</div></div>
	<%		
}
%>
	</body>
</html>