<%
	session.removeAttribute("uname");
	session.removeAttribute("uid");
	session.removeAttribute("dept");
	session.invalidate();
	response.sendRedirect("Login.jsp");
%>