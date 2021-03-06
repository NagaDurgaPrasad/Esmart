<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<div>
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
String exid=request.getParameter("exid");
String rmid=request.getParameter("rmid");
try
	{
		int c=0,flag=0,i=0;
		String exname="";
		String ac_yr="";
		String month="";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=null,rs2=null;
		rs=stmt.executeQuery("SELECT EXAM_NAME,ACADEMIC_YEAR,TO_CHAR(TO_DATE(MONTH,'MONTH'),'MONTH') FROM EXAMS WHERE EXAM_ID='"+exid+"'");
		if(rs.next())
		{
				exname=rs.getString(1);
				ac_yr=rs.getString(2);
				month=rs.getString(3);
		}			
		rs=stmt.executeQuery("SELECT BRANCH_ID,START_NO,END_NO,NO_STU,ORDERED FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"' AND ROOM_ID='"+rmid+"' ORDER BY ORDERED");
		while(rs.next())	
		{
			int status=0;
			int extracnt=0;
			int capacity=rs.getInt(4);
			String numbers[]=new String[capacity];
			String sno=rs.getString(2);
			String eno=rs.getString(3);
			int order=rs.getInt(5);
			String sigsno=sno.substring(0,8);
			int ssno=getCode(sno.substring(8,10));
			String sigeno=eno.substring(0,8);
			int seno=getCode(eno.substring(8,10));
			rs2=stmt2.executeQuery("SELECT ROLL_NO FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+rs.getString(1)+"' AND ROLL_NO='"+eno+"' ORDER BY ROLL_NO");
			while(rs2.next())
			{
				status=2;
			}
			if(status==2)
			{
				rs2=stmt2.executeQuery("SELECT ROLL_NO FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+rs.getString(1)+"' AND ROLL_NO>='"+sno+"' AND ROLL_NO<='"+eno+"' ORDER BY ROLL_NO");
				while(rs2.next())
					numbers[c++]=rs2.getString(1);
			}
			if(status!=2)
			{
				if(!sigeno.equals(sigsno)&&order==1)
				{
					rs2=stmt2.executeQuery("SELECT ROLL_NO FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+rs.getString(1)+"' ORDER BY ROLL_NO");
					while(rs2.next())						
					{
						numbers[c++]=rs2.getString(1);
						extracnt++;
						status=4;
					}
				}
				else if(!sigeno.equals(sigsno))
				{
					rs2=stmt2.executeQuery("SELECT ROLL_NO FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+rs.getString(1)+"' AND ROLL_NO>='"+sno+"' ORDER BY ROLL_NO");
					while(rs2.next())						
					{
						numbers[c++]=rs2.getString(1);
						extracnt++;
						status=4;
					}
				}	
				int j=0; 
				if(status==4)
				{
					
					j=extracnt+seno-capacity;
				}
				else
					j=ssno;
				for(;j<=seno;j++)
				{
					flag=0;
					String cno=sigeno;
					cno+=deCode(j);
					rs2=stmt2.executeQuery("SELECT ROLL_NO FROM MISSING_NUMBERS WHERE EXAM_ID='"+exid+"' AND BRANCH_ID='"+rs.getString(1)+"'");
					while(rs2.next())
					{
						if(cno.equalsIgnoreCase(rs2.getString(1)))
						{
							flag=1;
							break;							
						}
					}
					if(flag!=1)	
						numbers[c++]=cno;
				}
			}
			rs2=stmt2.executeQuery("SELECT BRANCH_NAME FROM BRANCHES WHERE BRANCH_ID='"+rs.getString(1)+"'");
			if(rs2.next())
			{
			%>
				<div class="page">
				<table class="inform"><tr><td><%=exname%><td></tr><tr><td>Month&nbsp;:&nbsp;"month"&nbsp;&nbsp;Academic Year&nbsp;:&nbsp;"<%=ac_yr%>"</td></tr>
				<tr><td style="font-size:18px;font-weight:bold;">Room Number&nbsp;:&nbsp;<%=rmid%></td></tr><tr><td style="font-size:15px;"><u>Attendance Sheet</u></td></tr></table><table class="requests">
				<br/><center><div style="font-weight:bold;">BRANCH&nbsp;:&nbsp;<%=rs2.getString(1)%></div></center>
				<table class="requests"><thead><tr><td>S.NO</td><td>ROLL NO.</td><td>MAIN ANSWER<br/> SCRIPT NO.</td><td>MODEL NUMBER OF<br/>CALC. USED</td><td>SIGNATURE</td></tr></thead>
			<%
			}
			for(int j=0;j<capacity;j++)
			{
				%>
					<tr><td><%=j+1%></td><td><%=numbers[j]%></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>			
				<%
			}
			%>
				<tr><td colspan="3" style="text-align:left">ISSUED ANSWER SCRIPTS :<br/>USED ANSWER SCRIPTS :<br />RETURNED ANSWER SCRIPTS :</td><td style="text-align:left" colspan="2">SIGNATURE :<br/>NAME&nbsp;&nbsp;:</td></tr>
				</table>
				<div>
			<%
			i++;
			c=0;
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
</div>