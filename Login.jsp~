<%!
	void authentication(HttpSession session)
	{
		session.invalidate();
	}
%>
<%authentication(session);%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Login</title> 
<link type="text/css" href="style/LoginStyleSheet.css" rel="stylesheet" />
<link type="image/png"	rel="icon" href="pic/vr3.gif" />
<script type="text/javascript">
function disable()
{
	window.history.forward();
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
<body onload="disable()">
<form method="post" name="f1" onsubmit="valid(event)" action="Authentication.jsp" id="form1">
	<div class="caption">Login Here</div>
	<div class="tabcont">
	<table>
		<tr><td>&nbsp;&nbsp;Login ID</td><td><input style="background:url(pic/user1.png) no-repeat left;background-size:20px 20px;text-indent:15px" type="text" name="id" size="30"  autofocus="autofocus" required="true" /></td></tr>
		<tr><td>&nbsp;&nbsp;Password</td><td><input style="background:url(pic/lock.png) no-repeat left;background-size:20px 20px;text-indent:15px" type="password" name="pwd" size="30" autocomplete="off" required="true" onkeypress="capsLock(event)" /><br/><em style="background:url(pic/info.jpg) no-repeat left;background-size:16px 16px;text-indent:50px;width:200px;" id="capslockstatus"></em></td></tr>
		<tr><td>&nbsp;&nbsp;User Type</td><td colspan="2"><select name="type" required="true"><option>Administrator</option><option>HOD</option><option>Guest</option></select></td></tr>
		<tr></tr>
		<tr><td align="center"><input type="submit" value="  Login  " id="btn" ></td><td><a href="forgotpwd.html">I Can't Access My Account</a></td></tr>
	</table>
	</div>
</form>
</body>
</html>