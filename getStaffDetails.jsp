<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
		String id=request.getParameter("staff_id");
		String staff_id=null;
		String name=null;
		String gen=null;
		String doj=null;
		String role=null;
		String avail_status=null;
		String branch_id=null;
		String mobile=null;
		String uid=(String)session.getAttribute("uid");
try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT STAFF_ID,NAME,GENDER,to_char(DOJ,'DD-MM-YYYY'),ROLE,STATUS,BRANCH_ID,MOBILE FROM STAFF WHERE STAFF_ID='"+id+"'");
		while(rs.next())	
		{
			staff_id=rs.getString(1);
			name=rs.getString(2);
			gen=rs.getString(3);
			doj=rs.getString(4);
			role=rs.getString(5);
			avail_status=rs.getString(6);
			branch_id=rs.getString(7);
			mobile=rs.getString(8);
		}
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>
<form id="staff2" name="staff2" >
		<table style="width:100%">
			<caption style="background-color:maroon;color:white;height:35px;font-size:20px;padding:0 5px;font-weight:bold;width:100%">Staff Details</caption>
			<tr><td>STAFF ID</td><td><input type="text" maxlength="10" onchange="showbtn('sub','clr')" class="textbox" name="staff_id2" id="staff_id2" value="<%=staff_id%>" autofocus="true"  required=""/></td></tr>
			<tr><td>NAME</td><td><input type="text" maxlength="25" onchange="showbtn('sub','clr')" class="textbox" name="sname2" id="sname2" required="" value="<%=name%>" /></td></tr>
			<tr><td>DATE OF JOINING</td><td><input type="text" id="datepicker2" name="datepicker2" onchange="showbtn('sub','clr')" onfocus="$(this).datepicker({ dateFormat: 'dd-mm-yy' });" class="textbox" value="<%=doj%>" /></td></tr>
			<tr><td>GENDER</td><td><% if(gen.equalsIgnoreCase("m")){ %><input type="radio" class="rad"  name="gender" id="rad3" onclick="showbtn('sub','clr')" checked="checked"  value="m"/>MALE&nbsp;&nbsp;<input type="radio" name="gender" class="rad" id="rad4" onclick="showbtn('sub','clr')" value="f"/>FEMALE</td></tr><%}else{%>&nbsp;<input type="radio" class="rad" name="gender" id="rad3" onclick="showbtn('sub','clr')" value="m"/>MALE&nbsp;&nbsp;<input type="radio" name="gender" class="rad" id="rad4" onclick="showbtn('sub','clr')" checked="checked" value="f"/>FEMALE</td></tr><%}%>
			<tr><td>ROLE</td><td><select class="textbox" name="role2" id="role2" required="" onchange="showbtn('sub','clr');" onfocus="this.remove(0);this.removeAttribute('onfocus')"><option value="<%=role%>" ><%=role%></option><option>Associate Professor</option><option >Assistant Professor</option><option>Professor</option><option>Professor & HOD</option></select></select></td></tr>
			<%
			if(uid.equals("ADMIN"))
			{			
				%><tr><td>DEPARTMENT</td><td><select class="textbox" name="dept_id2" id="dept_id2" onchange="showbtn('sub','clr');" onfocus="getDept('dept_id2');this.remove(0);this.removeAttribute('onfocus')" ><option value="<%=branch_id%>"><%=branch_id%></option></select></td></tr><%
			}
			%>
			<tr><td>MOBILE NUMBER</td><td><input type="text" maxlength="10" class="textbox" name="mobile" value="<%=mobile%>" id="mobile" required onkeypress="return isNum(event)" onchange="showbtn('sub','clr');" /></td></tr>
			<tr><td align="right"><input type="button" value="Submit" style="visibility:hidden" class="btn" id="sub" onclick="setGender();ChangeStaff();" /></td><td><input type="reset" value="Clear"  style="visibility:hidden" id="clr" class="btn" /></td></tr>
			<tr><td colspan="2" align="center"><input type="button" value="Close" onclick="hide()" id="close" class="btn" /></td></tr>
		</table>		
		<input type="hidden" maxlength="10"name="temp_id" id="temp_id" value="<%=staff_id%>" />
<form>