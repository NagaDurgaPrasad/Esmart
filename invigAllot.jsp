<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.lang.*" %>
<form id="allot" name="allot">
<table class="reqtab">
<tr>
<%
try
	{
      int cnt=0,temp=1,incr=1;
      String dates="";
      String dates2="";
      String uids="";
      String nops="";
      String eid=request.getParameter("eid");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("SELECT TO_CHAR(EXAM_DATE,'DD-MON-YYYY'),TO_CHAR(NEW_DATE,'DD-MON-YYYY'),START_TIME,END_TIME FROM EXAM_DATES WHERE EXAM_ID='"+eid+"' ORDER BY EXAM_DATE ASC");
		while(rs.next())	
		{
          if(cnt==0)
          {    
             %>
             	<td class="corner"></td>
             <%
          }
          if(rs.getString(2)==null)
          {
          	dates+=rs.getString(1)+",";
			 	%>
					<td class="tabtop"><input type="hidden" value="<%=rs.getString(1)%>" id="column<%=incr++%>" /><strong><%=rs.getString(1)%></strong><br/><small>(<%=rs.getString(3)%>&nbsp;To&nbsp;<%=rs.getString(4)%>)</small></td>
			 	<%		
          }
          else
          {
          	dates+=rs.getString(2)+",";
				%>
					<td class="tabtop"><input type="hidden" value="<%=rs.getString(1)%>" id="column<%=incr++%>" /><strong><%=rs.getString(2)%></strong><br/><small>(<%=rs.getString(3)%>&nbsp;To&nbsp;<%=rs.getString(4)%>)</small></td>
				<%		
          }
          cnt++;
		}
		String exdates[]=dates.split(",");
		rs=stmt.executeQuery("SELECT to_char(INVIG_DATE,'DD-MON-YYYY'),REQUESTED_TO,NOP FROM INVIG_REQUESTS WHERE EXAM_ID='"+eid+"'");
      while(rs.next())
     	{
 			dates2+=rs.getString(1)+":";
 			uids+=rs.getString(2)+":";
 			nops+=rs.getString(3)+":";
     	}
     	String dlist[]=dates2.split(":");
     	String uidlist[]=uids.split(":");
     	String noplist[]=nops.split(":");
     	int p=0;
      if(cnt>0)
      {
      	temp=1;
          rs=stmt.executeQuery("SELECT DEPT,USER_ID FROM USERS WHERE ROLE='HOD' AND DEPT IS NOT NULL");
          while(rs.next())	
          {
        	    int counter=1;
        	    String user=rs.getString(2);
             %>
					</tr> <tr><td class="tableft"><strong style="font-size:18px;">&nbsp;&nbsp;<%=rs.getString(1)%>&nbsp;&nbsp;</strong></td>
             <%		
             for(int i=0;i<cnt;i++)
             {
             	int flag=0;
             	for(int j=0;j<dlist.length;j++)
             	{
             		if(exdates[i].equals(dlist[j])&&uidlist[j].equals(user))
	             	{
   	             	%>
    							<td><input type="text" maxlength="2" onkeypress="return isNum(event)" onblur="invigsum()" value="<%=noplist[j]%>" id="reqval<%=temp%>"  class="req" /><input type="hidden" id="reqhidden<%=temp++%>" value="<%=user%>,<%=counter++%>" /></td>
         	       	<%
            	    	 flag=1;
            	    	 p=1;
               	 	 break;
                	}
               }
            	if(flag==0)
            	{
                	%>
    						<td><input type="text" maxlength="2" onkeypress="return isNum(event)" onblur="invigsum()" id="reqval<%=temp%>"  class="req" /><input type="hidden" id="reqhidden<%=temp++%>" value="<%=user%>,<%=counter++%>" /></td>
                	<%
           
                }
             }
          }
      	if(p==0)
      	{
          %>                           
              </tr></table>
              <br/><br/>
              <center>
              		<input type="button" class="btn" value="Send Request" onclick="sendReq(<%=temp-1%>,'<%=eid%>')" style="width: 150px;" />&nbsp;&nbsp;<input type="reset" value="Clear" class="btn" />
              </center>
              <br/>
              </form>
          <%
          }
      	else if(p==1)
      	{
      		%>
      		 </tr></table>
              <br/><br/>
              <center>
              		<input type="button" class="btn" value="Send Modified Request" onclick="modifyReq(<%=temp-1%>,'<%=eid%>')" style="width:230px;" />&nbsp;&nbsp;<input type="reset" value="Clear" class="btn" />
              </center>
              <br/>
              </form>
             <%
      	}
      }
      else
      {
         %>
       		<div style="padding:10% 20%;font-size:25px;color:red;">Ooops....Dates are not given for this Exam.</div>
         <%
      }
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
	}
%>