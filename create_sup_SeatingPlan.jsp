<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
	String temp = "";
	String exid = (String) session.getAttribute("exid");
	try 
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1", "esmart", "vrsec");
		Statement stmt = con.createStatement();
		Statement stmt2=con.createStatement();
		int i = 0;
		ResultSet rs, rs2;
		rs = stmt.executeQuery("SELECT BID FROM TEMP_BRANCH_PRIORITY GROUP BY BID");
		while(rs.next())
			i++;
		String bid[] = new String[i];
		i=0;
		rs.close();
		rs = stmt.executeQuery("SELECT BID FROM TEMP_BRANCH_PRIORITY GROUP BY BID");
		while (rs.next()) 
		{
				bid[i++] = rs.getString(1);
		}
		rs.close();
		i = -1;
		String numstr="";
		int totalcap=0;
		rs = stmt.executeQuery("SELECT * FROM TEMP_BRANCH_PRIORITY ORDER BY BID,PRIORITY");
		while (rs.next()) 
		{
				String br = rs.getString(1);
				String rm = rs.getString(2);
				int cap = rs.getInt(3);
				int branch_priority=rs.getInt(4);
				int pri=0;
				int cnt=0; 
				int rows=0; 
				int cols=0; 
				if (!temp.equals(br)) 
				{
					numstr="";
					temp=br;
					totalcap=0;
					rs2 = stmt2.executeQuery("SELECT ROLL_NO FROM SUPPLY_NUMS WHERE BRANCH_ID='"+br+"' ORDER BY ROLL_NO");
					while (rs2.next())
					{
						out.println(rs2.getString(1));
						numstr+=rs2.getString(1)+",";
					}       
					rs2.close();              
				} 
				rs2 = stmt2.executeQuery("SELECT P.PRIORITY,R.NO_ROWS,R.NO_COLUMNS FROM TEMP_ROOM_PRIORITY P JOIN ROOMS R ON P.RID='"+rm+"' AND P.RID=R.ROOM_ID AND P.BID='"+br+"'");
				while (rs2.next())
				{
					pri=rs2.getInt(1);					
					rows=rs2.getInt(2);					
					cols=rs2.getInt(3);					
				}
				String nums[]=numstr.split(",");									
				stmt2.executeUpdate("INSERT INTO SEATING_PLANS(EXAM_ID,ROOM_ID,BRANCH_ID,START_NO,END_NO,ORDERED,FLAG,NO_ROWS,NO_COLUMNS,NO_STU,BRANCH_ORDER) VALUES('" + exid + "','" + rm + "','" + br + "','" + nums[totalcap] + "','" + nums[totalcap+cap-1] + "',"+pri+",0,"+rows+","+cols+","+cap+","+branch_priority+")");					
				totalcap+=cap;
		}
%>
		<jsp:forward page="removesupTempData.jsp" />
<%
		con.close();
		stmt.close();
	} catch (SQLException e) {
		out.println(e);
%>
<div id='alertbox3' class='alertbox'>Sorry....Details are not Saved.<%=e.getErrorCode()%><div class="close" title="Close" onclick="hideMsg('alertbox3')">X</div></div>
<%
	}
%>