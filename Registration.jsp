<%
	String uid=(String)session.getAttribute("uid");
	String type=(String)session.getAttribute("type");
%>	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset=UTF-8/>
<title>Registraion</title> 
<link href="style/jquery.ui.all.css" rel="stylesheet"/>
<link href="style/register.css" rel="stylesheet"/>
<script type="text/javascript" src="script/jquery.js"></script>
<script type="text/javascript" src="script/jquery-1.8.3.js"></script>
<script type="text/javascript" src="script/jquery.ui.core.js"></script>
<script type="text/javascript" src="script/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="script/javaScript.js"></script>
<script type="text/javascript">
var errStatus=0;
$(document).ready(function(){
	getDept("dept");
$( "#dob" ).datepicker({ dateFormat: 'dd-mm-yy',changeMonth: true,changeYear: true,showButtonPanel: true });
});
function validate()
{	

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
		document.getElementById("err2").innerHTML="";
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
	var psd=reg.pwd.value;
	var rpsd=reg.rpwd.value;
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
       document.getElementById("capslockstatus").innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Caps Lock is On";
   else
       document.getElementById("capslockstatus").innerHTML="";
}
</script>
</head>
<body>
<form method="post" name="reg" onsubmit="return validate()" action="changeData.jsp" id="reg">
	<div class="caption">Registration</div>
	<div class="tabcont">
	<table>
		<tr><td>Staff ID</td><td><input type="text" name="id" size="30"  autofocus="autofocus" required="true" value="<%=uid%>" maxlength="20" onblur="isEmpty(this,'err1')" /></td><td id="err1"></td></tr>
		<tr><td>New Password</td><td><input type="password" name="pwd" size="30" autocomplete="off" required="true" maxlength="25" onkeypress="capsLock(event)" placeholder="Minimum 5 Characters" onblur="isvalidpwd(this,'err2')" /><br/><em style="background:url(pic/p2.png) no-repeat left;background-size:16px 16px;text-indent:50px;width:200px;" id="capslockstatus"></em></td><td id="err2"></td></tr>
		<tr><td>Re-Enter Password</td><td><input type="password" name="rpwd" size="30" autocomplete="off" maxlength="25" required="true"  onblur="checkPassword(this,'err3')"  /></td><td id="err3"></td></tr>
		<tr><td>Name</td><td><input type="text" name="name" size="30" required="true" maxlength="30" onkeypress="return isChar(event)" onblur="isEmpty(this,'err4')"  /></td><td id="err4"></td></tr>
		<tr><td>Date of Birth</td><td><input type="text" name="dob" id="dob" maxlength="10" size="30" required="true" onblur="isEmpty(this,'err5')" placeholder="DD-MM-YYYY"  /></td><td id="err5"></td></tr>
		<tr><td>Gender</td><td><input type="radio" name="gen" value="male" id="gen1" checked="checked" class="radio" required="true" onblur="isEmpty(this,'err6')"  /><label for="gen1">Male</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="gen2" name="gen" onfocus="isEmpty(document.getElementById('dob'),'err5')" class="radio" required="true" value="female" /><label for="gen2">Female</label></td><td id="err6"></td></tr>
		<%		
			if(!type.equals("Administrator"))
			{
				%><tr><td>Department</td><td><select name="dept" id="dept" value="" required="true" class="select" onblur="isEmpty(this,'err7')" onfocus="isEmpty(document.getElementById('dob'),'err7')" ><option>Select Department</option></select></td><td id="err7"></td></tr><%
			}
		%>
		<tr><td>Email</td><td><input type="email" name="email" size="30"  required="true" onblur="isEmail(this,'err8')" maxlength="40"/></td><td id="err8"></td></tr>
		<tr><td>Mobile Number</td><td><input type="text" name="mobile" onkeypress="return isNum(event)" size="30" required="true" maxlength="10" onblur="isEmpty(this,'err9')" /></td><td id="err9"></td></tr>
		<tr>
			<td>
				<select class="select" name="ques" onblur="isEmpty(this,'err10')" >
				<option value="" selected="selected">Select Question</option>
				<option>Your Favourite Book?</option>
				<option >Your Favourite Student Name?</option>
				<option >Your Favourite Subject Name?</option>
				<option >Your Childhood Friend Name?</option>
			</select>
			</td>
			<td><input type="text" name="ans" size="30" required="true" onblur="isEmpty(this,'err10')"  /></td><td id="err10"></td></tr>
		<tr><td></td><td></td><td></td></tr>
		<tr><td align="center"><input type="submit" value="  Register  " id="btn" ></td><td><input type="reset" value="  Clear  " id="btn" ></td><td></td></tr>
	</table>
	</div>
</form>
</body>
</html>