<%@ page import="java.io.IOException" %>
<%String name=Auth(session,response,request);%>
<%!
String Auth(HttpSession sess,HttpServletResponse res,HttpServletRequest req)throws IOException
{
	String ssid=null;
	ssid=req.getParameter("ssid");
	String name=(String)sess.getAttribute("name");
	String sid=(String)sess.getId();   
	if(ssid==null||!ssid.equals(sid))
	{
		sess.invalidate();
		res.sendRedirect("Login.jsp");
	}
	return name;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Esmart::Seating Arrangement Tool::</title>
<meta http-equiv="Pragma" content="no-cache" />
<link type="image/png"	rel="icon" href="pic/vr3.gif" />
<link rel="stylesheet" type="text/css" href="style/css.css" />
<script type="text/javascript" src="script/jquery.js"></script>
<script type="text/javascript" src="script/adjust.js"></script>
<script type="text/javascript">
var sel="#item1";
$(document).ready(function(){
$(".menuitem").hover(function () {
	$(".menuitem").css("background-color","#085592");
	$(sel).css("background-color","#E6E6FA");
	$(this).css("background-color","#2C93E6");
});
$(".menuitem").mouseleave(function () {
	$(".menuitem").css("background-color","#085592");
	$(sel).css("background-color","#E6E6FA");
});

		$("#item1").css({"background-color":"#E6E6FA","color":"black"});
	$("#item1").click(function () {
		$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item1").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item1";
		$("#item1").slideUp();
		$("#item1").slideDown();
	});
	$("#item2").click(function () {
		$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item2").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item2";
	});
	$("#item3").click(function () {
			$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item3").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item3";
	});
});	
function disable()
{
	window.history.forward();
}
</script>
<style type="text/css">
body{font-family:Verdana, Geneva, sans-serif;}
.menuitem{padding-left:15px;font-size:16px;}
</style>
</head>
<body>
<div class="body">
<header class="header">
<img src="pic/head.png" alt="LOGO" width="35%" height="120px"  />
<table class="menu" style="width:400px;">
<tr>
	<td><a id="item1" class="menuitem" href="viewseatingPlans.html" target="main">Seating Plans</a></td>
	<td><a id="item2" class="menuitem" href="attendance.html" target="main">Attendance</a></td>
	<td><a id="item3" class="menuitem" href="profile.jsp" target="main">My Profile</a></td>
</tr>
</table> 
<div class="username"><b>Hi..&nbsp;<%=name%>&nbsp;</b>&nbsp;&nbsp;&nbsp;<a href="Logout.jsp" class="logout">Logout<img src="pic/logout.png" width="30" height="30" title="Logout" alt="Logout" style="border:0;" /></a></div>
</header>
<div style="width:1024px;margin:0 auto;">
<iframe name="main" src="viewseatingPlans.html"  class="main" id="main" scrolling="no"></iframe>
</div>
<footer></footer>
</div>
</body>
</html>