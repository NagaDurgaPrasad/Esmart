<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String exid=request.getParameter("exid");
String rmid=request.getParameter("rmid");
try
	{
		int size=0,r=0,c=0,i=0,k=0,flag=0,rows=0,cols=0,nums=0,maxsize=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=null,rs2=null;
		rs=stmt.executeQuery("SELECT NO_ROWS,NO_COLUMNS,NO_STU FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' AND ROOM_ID='"+rmid+"' ORDER BY ORDERED");
		while(rs.next())
		{
			size++;
			rows=rs.getInt(1);
			cols=rs.getInt(2);
			nums+=rs.getInt(3);
			if(maxsize<rs.getInt(3))
				maxsize=rs.getInt(3);
		}
		String numbers[][]=new String[size][maxsize];
		String num[]=new String[rows*cols];
		String bid[]=new String[size];
		int order[]=new int[size];
		int capacity[]=new int[size];
		rs=stmt.executeQuery("SELECT BRANCH_ID,START_NO,END_NO,ORDERED,NO_STU FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' AND ROOM_ID='"+rmid+"' ORDER BY ORDERED");
		while(rs.next())	
		{
			int status=0;
			int extracnt=0;
			bid[i]=rs.getString(1);
			order[i]=rs.getInt(4);
			capacity[i]=rs.getInt(5);
			String sno=rs.getString(2);
			String eno=rs.getString(3);
			rs2=stmt2.executeQuery("SELECT ROLL_NO FROM SUPPLY_NUMS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+rs.getString(1)+"' AND ROLL_NO>='"+sno+"' AND ROLL_NO<='"+eno+"' ORDER BY ROLL_NO");
			while(rs2.next())
				numbers[r][c++]=rs2.getString(1);
			i++;
			r++;
			c=0;
		}
		int m=0,n=0,p=0;
	/*	for(int j=0;j<size;j++)
		{
			out.println("<br/>");
			for(k=0;k<maxsize;k++)
				out.println(k+"->"+numbers[j][k]+"<br/>");
		}*/	
		out.println("<table id='class' class='details'><tr><td>Room Number</td><td>"+rmid+"</td></tr>");
		out.println("<tr><td>Number of Students</td><td>"+nums+"/"+cols*rows+"</td></tr>");
		out.println("<tr><td>Branches</td><td>");
		for(int j=0;j<size;j++)
			out.println(bid[j]+"("+capacity[j]+"),&nbsp;");
		out.println("</td></tr></table>");
		out.println("<table class='room'><tr>");
		for(int j=0;j<rows;j++)
		{
			flag=0;
			out.println("<td><table class='cols'>");
			for(k=0;k<cols;)	
			{
				if(n==maxsize||p>=nums)
				{	
					out.println("<tr><td class='empty'>&nbsp;</td></tr><tr><td></td></tr>");
					k++;
				}
				else if(numbers[m][n]!=null)
				{	
					out.println("<tr><td class='nonempty' title='"+bid[m]+"'>"+numbers[m][n]+" ("+bid[m++]+")</td></tr><tr><td></td></tr>");
					k++;
					p++;
					if(m==size)
					{
						m=0;
						n++;	
					}
				}
				else if(numbers[m][n]==null)
				{
					m++;
					if(m==size)
					{
						m=0;
						n++;
					}
				}
			}	
			out.println("</table></td>");
		}	
		out.println("</tr></table>");
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
