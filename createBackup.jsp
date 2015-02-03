<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
try
	{
		String exid=request.getParameter("exid");
		FileWriter fout=null;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:Oracle:thin:@vrsecmca:1521:orcl1","esmart","vrsec");
		Statement stmt=con.createStatement();
		ResultSet rs=null;
		File Dir=new File("D:/ESMART_BACKUP");
		if(!Dir.exists())
			Dir.mkdir();
		Dir=new File("D:/ESMART_BACKUP/"+exid);
		if(!Dir.exists())
		{
			Dir.mkdir();
			File file;
			if((exid.substring(0,3)).equals("REG"))
			{
				file=new File("D:/ESMART_BACKUP/"+exid+"/missing_numbers.txt");
				fout= new FileWriter(file);			
				rs=stmt.executeQuery("SELECT BRANCH_ID,ROLL_NO FROM MISSING_NUMBERS WHERE EXAM_ID='"+exid+"'");
				while(rs.next())
				{
					fout.write("INSERT INTO MISSING_NUMBERS(EXAM_ID,BRANCH_ID,ROLL_NO) VALUES('"+exid+"','"+rs.getString(1)+"','"+rs.getString(2)+"')\n");
				}
				stmt.executeUpdate("DELETE FROM MISSING_NUMBERS WHERE EXAM_ID='"+exid+"'");
				fout.close();
				file.setReadOnly();
				file=new File("D:/ESMART_BACKUP/"+exid+"/additional_numbers.txt");
				fout= new FileWriter(file);			
				rs=stmt.executeQuery("SELECT BRANCH_ID,ROLL_NO FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='"+exid+"'");
				while(rs.next())
				{
					fout.write("INSERT INTO ADDITIONAL_NUMBERS(EXAM_ID,BRANCH_ID,ROLL_NO) VALUES('"+exid+"','"+rs.getString(1)+"','"+rs.getString(2)+"')\n");
				}	
				stmt.executeUpdate("DELETE FROM ADDITIONAL_NUMBERS WHERE EXAM_ID='"+exid+"'");
				fout.close();
				file.setReadOnly();
			}
			else
			{		
				file=new File("D:/ESMART_BACKUP/"+exid+"/supply_nums.txt");
				fout= new FileWriter(file);	
				rs=stmt.executeQuery("SELECT BRANCH_ID,ROLL_NO FROM SUPPLY_NUMS WHERE EXAM_ID='"+exid+"'");
				while(rs.next())
				{
					fout.write("INSERT INTO SUPPLY_NUMS(EXAM_ID,BRANCH_ID,ROLL_NO) VALUES('"+exid+"','"+rs.getString(1)+"','"+rs.getString(2)+"')\n");
				}
				stmt.executeUpdate("DELETE FROM SUPPLY_NUMS WHERE EXAM_ID='"+exid+"'");	
				fout.close();
				file.setReadOnly();
			}
			file=new File("D:/ESMART_BACKUP/"+exid+"/invigilation.txt");
			fout= new FileWriter(file);			
			rs=stmt.executeQuery("SELECT STAFF_ID,ROOM_ID,TO_CHAR(INVIG_DATE,'DD-MON-YYYY'),FILE_NO,PAY_STATUS FROM INVIGILATION WHERE EXAM_ID='"+exid+"'");
			while(rs.next())
			{
				String room=null;
				if(rs.getString(2)!=null)
					room="'"+rs.getString(2)+"'";
				fout.write("INSERT INTO INVIGILATION(EXAM_ID,STAFF_ID,ROOM_ID,INVIG_DATE,FILE_NO,PAY_STATUS) VALUES('"+exid+"','"+rs.getString(1)+"',"+room+",TO_DATE('"+rs.getString(3)+"','DD-MON-YYYY'),"+rs.getString(4)+","+rs.getString(5)+")\n");
			}
			stmt.executeUpdate("DELETE FROM INVIGILATION WHERE EXAM_ID='"+exid+"'");
			fout.close();
			file.setReadOnly();
			file=new File("D:/ESMART_BACKUP/"+exid+"/invig_payments.txt");
			fout= new FileWriter(file);			
			rs=stmt.executeQuery("SELECT AMT_PER_HEAD,NO_OF_PERSONS,TO_CHAR(PAID_DATE,'DD-MON-YYYY') FROM INVIG_PAYMENTS WHERE EXAM_ID='"+exid+"'");
			while(rs.next())
			{
				fout.write("INSERT INTO INVIG_PAYMENTS(EXAM_ID,AMT_PER_HEAD,NO_OF_PERSONS,PAID_DATE) VALUES('"+exid+"',"+rs.getString(1)+","+rs.getString(2)+",TO_DATE('"+rs.getString(3)+"','DD-MON-YYYY'))\n");
			}
			stmt.executeUpdate("DELETE FROM INVIG_PAYMENTS WHERE EXAM_ID='"+exid+"'");
			fout.close();
			file.setReadOnly();
			file=new File("D:/ESMART_BACKUP/"+exid+"/exam_dates.txt");
			fout= new FileWriter(file);			
			rs=stmt.executeQuery("SELECT TO_CHAR(EXAM_DATE,'DD-MON-YYYY'),TO_CHAR(NEW_DATE,'DD-MON-YYYY'),START_TIME,END_TIME FROM EXAM_DATES WHERE EXAM_ID='"+exid+"'");
			while(rs.next())
			{
				String date=null;
				if(rs.getString(2)!=null)
					date="TO_DATE('"+rs.getString(2)+"','DD-MON-YYYY')";
				fout.write("INSERT INTO EXAM_DATES(EXAM_ID,EXAM_DATE,NEW_DATE,START_TIME,END_TIME) VALUES('"+exid+"',TO_DATE('"+rs.getString(1)+"','DD-MON-YYYY'),"+date+",'"+rs.getString(3)+"','"+rs.getString(4)+"')\n");
			}
			stmt.executeUpdate("DELETE FROM EXAM_DATES WHERE EXAM_ID='"+exid+"'");
			fout.close();
			file.setReadOnly();
			file=new File("D:/ESMART_BACKUP/"+exid+"/seating_plans.txt");
			fout= new FileWriter(file);			
			rs=stmt.executeQuery("SELECT ROOM_ID,BRANCH_ID,START_NO,END_NO,ORDERED,FLAG,NO_ROWS,NO_COLUMNS,NO_STU,BRANCH_ORDER FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"'");
			while(rs.next())
			{
				fout.write("INSERT INTO SEATING_PLANS(EXAM_ID,ROOM_ID,BRANCH_ID,START_NO,END_NO,ORDERED,FLAG,NO_ROWS,NO_COLUMNS,NO_STU,BRANCH_ORDER) VALUES('"+exid+"','"+rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+"','"+rs.getString(4)+"','"+rs.getString(5)+"','"+rs.getString(6)+"',"+rs.getString(7)+","+rs.getString(8)+","+rs.getString(9)+","+rs.getString(10)+")\n");
			}
			stmt.executeUpdate("DELETE FROM SEATING_PLANS WHERE EXAM_ID='"+exid+"'");
			fout.close();
			file.setReadOnly();
			file=new File("D:/ESMART_BACKUP/"+exid+"/exams.txt");
			fout= new FileWriter(file);			
			rs=stmt.executeQuery("SELECT EXAM_NAME,ACADEMIC_YEAR,MONTH,STATUS,TO_CHAR(CR_TIME,'YYYY-MM-DD HH24.MI.SS.FF') FROM EXAMS WHERE EXAM_ID='"+exid+"'");
			while(rs.next())
			{
				fout.write("INSERT INTO EXAMS(EXAM_ID,EXAM_NAME,ACADEMIC_YEAR,MONTH,STATUS,CR_TIME) VALUES('"+exid+"','"+rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+"','"+rs.getString(4)+"',TO_TIMESTAMP('"+rs.getString(5)+"','YYYY-MM-DD HH24.MI.SS.FF'))\n");
			}
			stmt.executeUpdate("DELETE FROM INVIG_REQUESTS WHERE EXAM_ID='"+exid+"'");
			stmt.executeUpdate("DELETE FROM EXAMS WHERE EXAM_ID='"+exid+"'");
			fout.close();
			file.setReadOnly();
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
	}
%>
