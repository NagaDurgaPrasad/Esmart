<%
	String ssid=ssid=request.getParameter("ssid");
	String name=(String)session.getAttribute("name");
	String sid=(String)session.getId();   
	if(ssid==null||!ssid.equals(sid))
	{
		session.invalidate();
		response.sendRedirect("Login.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>Esmart::Examination Section::</title>
<meta http-equiv="Pragma" content="no-cache" />
<link type="image/png"	rel="icon" href="pic/vr3.gif" />
<link rel="stylesheet" type="text/css" href="style/css.css" />
<style type="text/css">
	.menu a{width:200px;}
	.menu{width:600px;}
</style>
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
	});
	$("#item2").click(function () {
		$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item2").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item2";
	});
	$("#item3").click(function () {
		$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item3").css({"background-color":"#E6E6FA","color":"black"});
		$("#reqstatus").css("visibility","hidden");
		sel="#item3";
	});
	$("#item4").click(function () {
		$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item4").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item4";
	});
	window.history.forward();
});
window.onload=function()
{
	if (window.XMLHttpRequest)
 		xmlhttp=new XMLHttpRequest();
	else
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			var cnt=xmlhttp.responseText;
 			if(cnt!=0)
 			{
 				var ele=document.getElementById("reqstatus");
 				ele.innerHTML=cnt;
 				ele.style.visibility="visible"; 			
 			}
 		}
  	}
	xmlhttp.open("GET","requestsCount.jsp",true);
	xmlhttp.send();
}
</script>
</head>
<body>
<header class="header">
<img src="pic/head.png" alt="LOGO" width="32%" height="120px"  />
<table class="menu">
<tr>
	<td><a id="item1" class="menuitem" href="staff.html" target="main">&nbsp;Staff Members</a></td>
	<td><a id="item2" class="menuitem" href="viewseatingPlans.html" target="main">View Seating Plans</a></td>
	<td><a id="item3" class="menuitem" style="padding-left:5px;" href="requestsList.jsp" target="main">Invigilation Requests&nbsp;<strong  id="reqstatus" style="visibility:hidden;width:20px;height:20px;border-radius:2px;background-color:red;color:white;font-size:12px;position:absolute;padding-top:3px;top:2px;text-align:center;"></strong></a></td>
	<td><a id="item4" class="menuitem" href="profile.jsp" target="main">My Profile</a></td>
</tr>
</table> 
<div class="username"><b>Hi..&nbsp;<%=name%>&nbsp;</b>&nbsp;&nbsp;<a href="Logout.jsp" class="logout">Logout<img src="pic/logout.png" width="30" height="30" title="Logout" alt="Logout" style="border:0;" /></a></div>
</header>
<div style="width:1024px;margin-left:auto;margin-right:auto;">
<iframe name="main" src="staff.html"  class="main" id="main" style="border-left:none;" scrolling="no"></iframe>
</div>
<footer></footer>
</body>
</html>