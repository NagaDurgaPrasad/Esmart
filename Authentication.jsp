<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%
		String id = (request.getParameter("id")).toUpperCase();
      String pwd = request.getParameter("pwd");
      String type = request.getParameter("type");
		try
		{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@vrsecmca:1521:orcl1", "esmart", "vrsec");
            Statement stmt=con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT NAME,DEPT FROM USERS WHERE USER_ID='"+id+"' AND PASSWORD='"+pwd+"' AND ROLE='"+type+"'");
            if (rs.next()) 
            {
                session.setAttribute("uid",id);
                session.setAttribute("name",rs.getString(1));
                session.setAttribute("dept", rs.getString(2));
                session.setAttribute("type",type);
                String ssid=(String)session.getId();
                if (type.equals("Administrator")) 
                {
                	if(rs.getString(1)!=null)
                     response.sendRedirect("HomePage.jsp?ssid="+ssid);
                  else
                  {
                  	session.setAttribute("link","HomePage.jsp?ssid="+ssid);
                  	response.sendRedirect("Registration.jsp");
                  }
                } 
                else if (type.equals("HOD"))
                {
                	if(rs.getString(1)!=null)
                  	response.sendRedirect("HODHomePage.jsp?ssid="+ssid);
                  else
                  {
                  	session.setAttribute("link","HODHomePage.jsp?ssid="+ssid);
                  	response.sendRedirect("Registration.jsp");
                  }
                     
                } 
                else 
                {
                	if(rs.getString(1)!=null)
                 		response.sendRedirect("GuestHomePage.jsp?ssid="+ssid);
                  else
                  {
                  	session.setAttribute("link","GuestHomePage.jsp?ssid="+ssid);
                  	response.sendRedirect("Registration.jsp");
                  }
                }
 
            } 
            else 
            {
                response.sendRedirect("ErrorLogin.jsp");
            }
           con.close();
           rs.close();
        } catch (Exception ex) {
        }
    %>
