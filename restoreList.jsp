<%@ page import="java.io.*,java.util.StringTokenizer" %>
<br />
<table class="requests" style="width:700px;margin-left:12%;">
<%
try
{
	int cnt=0;
	File folder = new File("D:/ESMART_BACKUP/");
	File[] listOfFiles = folder.listFiles();
   for (int i = 0; i < listOfFiles.length; i++) 
   {
     	if(listOfFiles[i].isDirectory()) 
     	{
     		String exid=listOfFiles[i].getName();
     		String extype="";
     		if(exid.substring(0,3).equals("REG"))
     			extype="Regular";
     		else if(exid.substring(0,3).equals("SUP"))
     			extype="Supplementary";
     		else
     			extype="Undefined";
     		String path="D:/ESMART_BACKUP/"+exid+"/";
   		Process proc = Runtime.getRuntime().exec("cmd /c dir \"" +path+ "\" /tc");
    		BufferedReader br = 
    		   new BufferedReader(
    		      new InputStreamReader(proc.getInputStream()));
    		String data ="";

    		for(int j=0; j<6; j++){
    			data = br.readLine();
    		}
    		StringTokenizer st = new StringTokenizer(data);
    		String date = st.nextToken();
    		String time = st.nextToken();
    		time+=" "+st.nextToken();
     		cnt++;
     		%>
   			<tr><td><%=cnt%></td><td><%=exid%></td><td><%=extype%></td><td><%=time%>&nbsp;&nbsp;<%=date%></td><td><input type="button" class="btn" onclick="restore('<%=exid%>')" style="width:100px;height:25px" value="Restore" /></td>
        	<%
     	}
   }
   if(cnt>0)
 	{
 		%>
   		<thead><tr><td>S.NO</td><td>Examination</td><td>Type</td><td>Time&nbsp;&amp;&nbsp;Date of Creation</td><td>Restore</td></tr></thead>
       <%
 	}
 	else
 	{
		%>
			<div class="promptmsg" style="font-size:25px;font-size:width;text-align:center;">No Data Found to Restore</div>
		<% 	
 	}
}
catch(Exception e)
{
	out.println(e);
}
%>
</table>