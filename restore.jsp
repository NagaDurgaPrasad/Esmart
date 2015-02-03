<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		String path="D:/ESMART_BACKUP/"+exid+"/";
		String reg_files[]={"exams.txt","exam_dates.txt","seating_plans.txt","invigilation.txt","invig_payments.txt","missing_numbers.txt","additional_numbers.txt"};
		String sup_files[]={"exams.txt","exam_dates.txt","seating_plans.txt","invigilation.txt","invig_payments.txt","supply_nums.txt"};
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		File Dir=new File(path);
		if(Dir.exists())
		{
			if(exid.substring(0,3).equals("REG"))
			{
				for(int i=0;i<7;i++)
				{
					BufferedReader in = new BufferedReader(new FileReader(path+reg_files[i]));
					String str;
					while ((str = in.readLine()) != null) 
						if(str!=null)
							stmt.executeUpdate(str);
					in.close();
					new File(path+reg_files[i]).delete();
				}
			}
			else
			{
				for(int i=0;i<6;i++)
				{
					BufferedReader in = new BufferedReader(new FileReader(path+sup_files[i]));
					String str;
					while ((str = in.readLine()) != null) 
						if(str!=null)
							stmt.executeUpdate(str);
					in.close();
					new File(path+sup_files[i]).delete();
				}
			}
		Dir.delete();
		out.print(true);			
		}	
		else
		{
			out.print(false);
		}		
		con.close();
		stmt.close();
	}
	catch(SQLException e)
	{		
		out.println(e);
	}
%>
