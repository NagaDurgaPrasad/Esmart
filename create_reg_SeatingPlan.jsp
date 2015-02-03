<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<%!
int getCode(String num)
{
	char fch=Character.toUpperCase(num.charAt(0));
	int lch=Integer.parseInt(""+num.charAt(1));
	if(fch>='A'&&fch<='Z')
	{
	switch(fch)
	{
		case 'A':return 100+lch;
		case 'B':return 110+lch;
		case 'C':return 120+lch;
		case 'D':return 130+lch;
		case 'E':return 140+lch;
		case 'F':return 150+lch;
		case 'G':return 160+lch;
		case 'H':return 170+lch;
		case 'I':return 180+lch;
		case 'J':return 190+lch;
		case 'K':return 200+lch;
		case 'L':return 210+lch;
		case 'M':return 220+lch;
		case 'N':return 230+lch;
		case 'O':return 240+lch;
		case 'P':return 250+lch;
		case 'Q':return 260+lch;
		case 'R':return 270+lch;
		case 'S':return 280+lch;
		case 'T':return 290+lch;
		case 'U':return 300+lch;
		case 'V':return 310+lch;
		case 'W':return 320+lch;
		case 'X':return 330+lch;
		case 'Y':return 340+lch;
		case 'Z':return 350+lch;
	}
	}
	else
		return Integer.parseInt(num);
return 0;
}
String deCode(int num)
{
	if(num>99)
	{
	int fnum=num/10;
	int lnum=num%10;
	switch(fnum)
	{
		case 10 :return "A"+lnum;
		case 11 :return "B"+lnum;
		case 12 :return "C"+lnum;
		case 13 :return "D"+lnum;
		case 14 :return "E"+lnum;
		case 15 :return "F"+lnum;
		case 16 :return "G"+lnum;
		case 17 :return "H"+lnum;
		case 18 :return "I"+lnum;
		case 19 :return "J"+lnum;
		case 20 :return "K"+lnum;
		case 21 :return "L"+lnum;
		case 22 :return "M"+lnum;
		case 23 :return "N"+lnum;
		case 24 :return "O"+lnum;
		case 25 :return "P"+lnum;
		case 26 :return "Q"+lnum;
		case 27 :return "R"+lnum;
		case 28 :return "S"+lnum;
		case 29 :return "T"+lnum;
		case 30 :return "U"+lnum;
		case 31 :return "V"+lnum;
		case 32 :return "W"+lnum;
		case 33 :return "X"+lnum;
		case 34 :return "Y"+lnum;
		case 35 :return "Z"+lnum;
	}
	}
	else if(num>9)
		return num+"";
	else
		return "0"+num;
return "";
}

%>
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
		ResultSet rs, rs2, rs3;
		rs = stmt.executeQuery("SELECT BID FROM TEMP_BRANCH_PRIORITY GROUP BY BID");
		while(rs.next())
			i++;
		String bid[]= new String[i];
		i=0;
		rs.close();
		rs = stmt.executeQuery("SELECT BID FROM TEMP_BRANCH_PRIORITY GROUP BY BID");
		while (rs.next()) 
		{
				bid[i++] = rs.getString(1);
		}
		rs.close();
		i = -1;
		String sig=null;
		String numstr="";
		int shortstartno=0;
		int shortendno=0;
		int totalcap=0;
		String sno=null,eno=null;
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
					totalcap=0;
					rs2 = stmt2.executeQuery("SELECT ROLL_NO FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='" + exid + "' AND BRANCH_ID='" + br + "' ORDER BY ROLL_NO");
					while (rs2.next())
						numstr+=rs2.getString(1)+",";        
					rs2.close();              
					rs2 = stmt2.executeQuery("SELECT ROLL_NO FROM MISSING_NUMBERS WHERE EXAM_ID='" + exid + "' AND BRANCH_ID='" + br + "' ORDER BY ROLL_NO");
					while (rs2.next())
					cnt++;
					rs2.close();
					String mno[] = new String[cnt];
					if(cnt>0)
					{
						cnt=0;
						rs2 = stmt2.executeQuery("SELECT ROLL_NO FROM MISSING_NUMBERS WHERE EXAM_ID='" + exid + "' AND BRANCH_ID='" + br + "'");
						while (rs2.next())
							mno[cnt++] = rs2.getString(1);
						rs2.close();
					}
					i++;
					temp = br;
					rs2 = stmt2.executeQuery("SELECT SNO,ENO FROM TEMP_BRANCH WHERE BID='"+br+"' ORDER BY BID");
					while(rs2.next())
					{
						sno=rs2.getString(1);
						eno=rs2.getString(2);
					}
					rs2.close();
					sig =sno.substring(0,8);
					shortstartno=getCode(sno.substring(8,10));
					shortendno=getCode(eno.substring(8,10));
					for(int j=shortstartno;j<=shortendno;j++)
					{
							numstr+=sig+deCode(j)+",";
					}
					for(int p=0;p<mno.length;p++)
					{
						//	out.println(mno[p]);
							if(numstr.indexOf(mno[p])!=-1)
								numstr=numstr.replace(mno[p]+",","");
					}					
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
		<jsp:forward page="removeTempData.jsp" />
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