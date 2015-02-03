<%@ page import="java.io.IOException" %>
<%!
	String Authenticate(HttpSession session,HttpServletRequest request,HttpServletResponse response)throws IOException
	{
		String ssid=null;
		ssid=request.getParameter("ssid");
		String name=(String)session.getAttribute("name");
		String sid=(String)session.getId();   
		if(ssid==null||!ssid.equals(sid))
		{
			session.invalidate();
			response.sendRedirect("Login.jsp");
		}
		return name;
	}
%>
<%
	String name=Authenticate(session,request,response);
%>
<!DOCTYPE html>
<html>
<head>
<title>Esmart:: Examination Section ::</title>
<meta http-equiv="Pragma" content="no-cache" />
<link type="image/png"	rel="icon" href="pic/vr3.gif" />
<link rel="stylesheet" type="text/css" href="style/css.css" />
<script type="text/javascript" src="script/jquery.js"></script>
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
	$("#item4").click(function () {
			$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item4").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item4";
	});
	$("#item5").click(function () {
			$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item5").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item5";
	});
	$("#item6").click(function () {
			$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item6").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item6";
	});
	$("#item7").click(function () {
			$(".menuitem").css({"background-color":"#085592","color":"white"});
		$("#item7").css({"background-color":"#E6E6FA","color":"black"});
		sel="#item7";
	});
	window.history.forward();
});
</script>
</head>
<body>
<div class="body">
<header class="header">
<img src="pic/head.png" alt="LOGO" width="32%" height="120px" />
<table class="menu">
<tr>
	<td><a id="item1" class="menuitem" href="staffDetails.html" target="main">&nbsp;&nbsp;&nbsp;&nbsp;Staff</a></td>
	<td><a id="item2" class="menuitem" href="blocks.html" target="main">&nbsp;&nbsp;&nbsp;&nbsp;Blocks</a></td>
	<td><a id="item3" class="menuitem" href="rooms.html" target="main">&nbsp;&nbsp;&nbsp;&nbsp;Rooms</a></td>
	<td><a id="item4" class="menuitem" style="padding-left:5px;" href="seatingPlans.html" target="main">Seating Plans</a></td>
	<td><a id="item5" class="menuitem" style="padding-left:5px;" href="invigilation.html" target="main">Invigilation</a></td>
	<td><a id="item6" class="menuitem" style="padding-left:5px;" href="users.html" target="main">Manage Users</a></td>
	<td><a id="item7" class="menuitem" style="padding-left:5px;" href="profile.jsp" target="main">My Profile</a></td>
</tr>
</table> 
<div class="username"><b>Hi..&nbsp;<%=name%>&nbsp;</b>&nbsp;&nbsp;&nbsp;<a href="Logout.jsp" class="logout">Logout<img src="pic/logout.png" width="30" height="30" title="Logout" alt="Logout" style="border:0;" /></a></div>
</header>
<div style="width:1024px;margin:0 auto;">
<iframe name="main" src="staffDetails.html"  class="main" id="main" scrolling="no"></iframe>
</div>
<footer></footer>
</div>
</body>
</html>