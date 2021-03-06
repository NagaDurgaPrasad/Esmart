/***************************************************************************************************************/
// This is the java Script for Staff page.....
// Staff Page related Java Script is Starts from Here
/*************************************************************/
var xmlhttp;
var desctar;
var gender;
var temp_id;
var args='';
var rows,columns,extype;
var pos;
var rcap=[];
var bid=[];
var bname=[];
var rid=[];
var brcount=[];
var blocknames=[];
var startnums=[];
var endnums=[];
var missnums=[];
var extranums=[];
var tabstatus=1;
var step=1;
var exavail;
var rmstatus=0;
var errStatus=0;
var selectedExam="";
$(function() {
$( "#datepicker" ).datepicker({ dateFormat: 'dd-mm-yy',minDate:'-500M',maxDate:0,changeMonth: true,changeYear: true,showButtonPanel: true });
});

function showbtn(tag1,tag2) 
{
document.getElementById(tag1).style.visibility="visible";
document.getElementById(tag2).style.visibility="visible";
}
function isEmpty(ele,target)
{
	if(ele.value=="")
	{
		document.getElementById(target).innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Field Should not be Empty";
		errStatus=1;	
	}
	else
	{
		document.getElementById(target).innerHTML="";
		errStatus=0;
	}
}

function getDept(target) 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML=xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getDept.jsp",true);
xmlhttp.send();
}

function addStaff() 
{
//document.getElementById("load").style.visibility="visible";
//alert("id:"+f.staff_id.value+" name:"+f.sname.value+" doj:"+f.datepicker.value+" gender:"+gender+" dept:"+f.dept_id.value+" role: "+f.role.value)
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
var dept_id="HOD";
if(staff1.dept_id.value!="")
	dept_id=staff1.dept_id.value;
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var res=xmlhttp.responseText;
			if(res==0)
				popup("Alert","Sorry..Staff Details are Not Saved.<br/>Please Check and Try Again",2)
			else
			{
				popup("Successful","Staff Details are Successfully Saved",1);
			}
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));
			if(res==1)
			{staff1.reset()}},2000);
		}
  	}
  	if(errStatus==0)
  	{
		xmlhttp.open("POST","addStaff.jsp",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("staff_id="+staff1.staff_id.value+"&sname="+staff1.sname.value+"&doj="+staff1.datepicker.value+"&gender="+gender+"&dept_id="+dept_id+"&mobile="+staff1.mobile.value+"&role="+staff1.role.value+"&type=new&temp=null");
	}
}

function ChangeStaff() 
{
//document.getElementById("load").style.visibility="visible";		
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var res=xmlhttp.responseText;
			if(res==0)
				popup("Alert","Sorry..Staff Details are Not Saved.<br/>Please Check and Try Again",2)
			else
				popup("Successful","Staff Details are Successfully Changed",1);
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));},2000);
			var ele=document.getElementById("close");
			ele.removeAttribute("onclick"); 
			ele.setAttribute("onclick","hide()");
  		}
  	}
 	xmlhttp.open("POST","addStaff.jsp",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("staff_id="+staff2.staff_id2.value+"&sname="+staff2.sname2.value+"&doj="+staff2.datepicker2.value+"&gender="+gender+"&dept_id="+staff2.dept_id2.value+"&mobile="+staff2.mobile.value+"&role="+staff2.role2.value+"&type=change&temp="+staff2.temp_id.value);
	console.log("staff_id="+staff2.staff_id2.value+"&sname="+staff2.sname2.value+"&doj="+staff2.datepicker2.value+"&gender="+gender+"&dept_id="+staff2.dept_id2.value+"&mobile="+staff2.mobile.value+"&role="+staff2.role2.value+"&type=change&temp="+staff2.temp_id.value);
}

function hide() 
{
var ans=window.confirm('Are you sure? Do you want to Close?');
if(ans)
{
	document.getElementById("descshow2").style.visibility="hidden";	
	document.getElementById("clr").style.visibility="hidden";	
	document.getElementById("sub").style.visibility="hidden";
}	
}

function getStaff(deptid,target) 
{
	if (window.XMLHttpRequest)
	{
 		xmlhttp=new XMLHttpRequest();
	}
	else
	{	
 		 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById(target).innerHTML=xmlhttp.responseText;
			document.getElementById(target).style.visibility="visible";
			desctar="desc"+target
 		}
  	}
  if(deptid!="HOD")
	{
		document.getElementById("deptname").innerHTML=deptid;
		document.getElementById("descshow2").style.visibility="hidden";
	}
xmlhttp.open("get","getStaff.jsp?dept_id="+deptid,true);
xmlhttp.send();
}

function deleteStaff(staff_id) 
{
var stat=window.confirm('Do you want to Delete?');
if (stat==true) 
{
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		  	var res=xmlhttp.responseText;
		  	if(res==0)
		  		popup("Deletion Failed","We are Currently Unable to Delete",2);
		  	else 
		  		popup("Successful","Staff Details Successfully Deleted",1);
		  	
			getStaff(document.getElementById("dept2").value,'show2');
 		}
  	}
	xmlhttp.open("post","deleteStaff.jsp?staff_id="+staff_id,true);
	xmlhttp.send();
}
}

function getStaffDetails(val) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById(desctar).innerHTML=xmlhttp.responseText;
		document.getElementById(desctar).style.visibility="visible"
		$( "#datepicker2" ).datepicker({ dateFormat: 'dd-mm-yy',changeMonth: true,changeYear: true,showButtonPanel: true });
 	}
  	}
xmlhttp.open("get","getStaffDetails.jsp?staff_id="+val,true);
xmlhttp.send();
}

function setGender() 
{
for(i=1;i<5;i++)
	if(document.getElementById("rad"+i))
		if(document.getElementById("rad"+i).checked)
			gender=document.getElementById("rad"+i).value;	
}

//This is Ending of Staff Related Java Script
/************************************************************************************************/

/************************************************************************************************/
//This is Starting of Blocks Related Java Script
/************************************************************************************************/
function getBlocksList(target) 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			document.getElementById(target).innerHTML =xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getBlocks.jsp",true);
xmlhttp.send();
}
function getBranches() 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			document.getElementById("branch1").innerHTML =xmlhttp.responseText;
 			getBlockID();
 		}
  	}
xmlhttp.open("GET","getBranches.jsp",true);
xmlhttp.send();
}

function getBlockID()
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			block1.block_id.value=xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getBlockID.jsp",true);
xmlhttp.send();
}

function addBlock(btype) 
{
//alert("block_id="+block_id.value+"&bname="+block_name.value+"&loc="+locatn.value+args)
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		var res=xmlhttp.responseText;
		if(btype=='new')
		{
			if(res==0)
				popup("Alert","Sorry..Block Details are Not Saved.<br/>Please Check and Try Again",2)
			else
				popup("Successful","Block Details are Successfully Saved",1);
			getBranches();
		}
		else
		{
			if(res==0)
				popup("Alert","Sorry..Block Details are Not Saved.<br/>Please Check and Try Again",2)
			else
				popup("Successful","Block Details are Successfully Updated",1);
			getBlockDetails(block2.block_id2.value);
		}
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));
			if(res==1)
			{block1.reset()}},2000);
 		}
  	}
  if(errStatus==0)
  {
		xmlhttp.open("POST","addBlock.jsp",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		if(btype=="new")
			xmlhttp.send("block_id="+block1.block_id.value+"&bname="+block1.block_name.value+"&loc="+block1.locatn.value+"&args="+args+"&type="+btype);
		else
		xmlhttp.send("block_id="+block2.block_id2.value+"&bname="+block2.block_name2.value+"&loc="+block2.locatn2.value+"&args="+args+"&type="+btype);
  }
}

function getBlocks() 
{
document.getElementById("descshow2").style.visibility="hidden";
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{ 
		document.getElementById("show2").style.visibility="visible"
		document.getElementById("show2").innerHTML =xmlhttp.responseText;
 	}
  	}
xmlhttp.open("get","blocks.jsp",true);
xmlhttp.send();
}

function getBlockDetails(block_id) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{ 
		
		document.getElementById("descshow2").style.visibility="visible"
		document.getElementById("descshow2").innerHTML =xmlhttp.responseText;
 	}
  	}
xmlhttp.open("get","getBlockDetails.jsp?block_id="+block_id,true);
xmlhttp.send();
}

function setArgs() 
{
args=""
for(var i=1;i<=9;i++) 
{
	if(document.getElementById("b"+i))
		if(document.getElementById("b"+i).checked)
			args+=(document.getElementById("b"+i).value)+","
		
}		
addBlock('new');
}
function setArgs2() 
{
args="";
for(var i=1;i<=9;i++) 
{
	if(document.getElementById("br"+i))
		if(document.getElementById("br"+i).checked)
			args+=(document.getElementById("br"+i).value)+",";
}		
addBlock('change');
}

function deleteBlock(block_id) 
{
var stat=window.confirm('Do you want to Delete?');
if(stat==true) 
{
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var res=xmlhttp.responseText;
			if(res==0)
				popup("Alert","Sorry..Deletion Failed.<br/>Block may contain one or more Rooms",2)
			else
			{
				popup("Successful","Block Details are Successfully Deleted",1);
			}
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));},2000);	
			getBlocks()
 		}
  	}
	xmlhttp.open("post","deleteBlock.jsp?block_id="+block_id,true);
	xmlhttp.send();
}
}

//This is Ending of Blocks Related Java Script
/************************************************************************************************/


/************************************************************************************************/
//This is Starting of Rooms Related Java Script
/************************************************************************************************/
function getSelectedBranches(block_id,target) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			document.getElementById(target).innerHTML =xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getSelectedBranches.jsp?block_id="+block_id,true);
xmlhttp.send();
}

function setCapacity(val1,val2)
{
if(val1.value!=""&&val2.value!="")
{	
	rows=parseInt(val1.value);
	columns=parseInt(val2.value);
	rooms1.capacity.value=rows*columns;
	document.getElementById("err3").innerHTML="";
}
else if(val1.value=="")
{
	document.getElementById("err2").innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Field Should not be Empty";
	val1.focus();
}
else 
{
	document.getElementById("err3").innerHTML="<img src='pic/warn.png' width='20' height='20' />&nbsp;Field Should not be Empty";
	val2.focus()
	document.getElementById("err2").innerHTML="";
}	
}
function setCapacity2(val1,val2)
{
if(val1!=""&&val2!="")
{	
	rows=parseInt(val1);
	columns=parseInt(val2);
	rooms2.capacity2.value=rows*columns;
}
}
function blockSpecialChar(evt) 
{
var charCode = (evt.which) ? evt.which : evt.keyCode
if((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8   || (charCode >= 48 && charCode <= 57))
	return true
return false
}
function allowComma(evt) 
{
var charCode = (evt.which) ? evt.which : evt.keyCode
if((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8   || (charCode >= 48 && charCode <= 57)||charCode==44)
	return true
return false
}	

function isChar(evt)
{
 var charCode = (evt.which) ? evt.which : evt.keyCode
 if ((charCode < 48 || charCode > 57)&&charCode!=32)
     return true;
 return false;
}	
function isNum(evt)
{
var charCode = (evt.which) ? evt.which : evt.keyCode
 if ((charCode < 48 || charCode > 57)&&charCode!=8)
     return false;
 return true;
}
function addRoom(rtype)
{
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var res=xmlhttp.responseText;
			if(rtype=="new")
			{
				if(res==0)
					popup("Alert","Sorry..Room Details are Not Saved.<br/>Please Check and Try Again",2)
				else
					popup("Successful","Room Details are Successfully Saved",1);
			}
			else 
			{
				if(res==0)
					popup("Alert","Sorry..Room Details are Not Saved.<br/>Please Check and Try Again",2)
				else
					popup("Successful","Room Details are Successfully updated",1);
				getRooms(document.getElementById('block2').value);
			}
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));
			if(res==1)
			{rooms1.reset()}},2000);
	
 		}
  	}
		xmlhttp.open("POST","addRoom.jsp",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		if(rtype=="new")
			xmlhttp.send("room_id="+(rooms1.branch.value+rooms1.room_no.value)+"&room_no="+rooms1.room_no.value+"&rows="+rooms1.rows.value+"&cols="+rooms1.columns.value+"&block_id="+rooms1.block.value+"&type="+rtype+"&temp_id=no&temp_block=no&branch_id="+rooms1.branch.value);
		else
			xmlhttp.send("room_id="+(rooms2.branch2.value+rooms2.room_no2.value)+"&room_no="+rooms2.room_no2.value+"&rows="+rooms2.rows2.value+"&cols="+rooms2.columns2.value+"&block_id="+rooms2.block2.value+"&type="+rtype+"&temp_id="+rooms2.temp_id.value+"&temp_block="+rooms2.temp_block.value+"&branch_id="+rooms2.branch2.value);
}
function getRooms(block_id) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			document.getElementById("show2").style.visibility='visible'
 			document.getElementById("show2").innerHTML=xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getRooms.jsp?block_id="+block_id,true);
xmlhttp.send();
}
function getRoomDetails(room_id) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			document.getElementById("descshow2").style.visibility='visible'
 			document.getElementById("descshow2").innerHTML=xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getRoomDetails.jsp?room_id="+room_id,true);
xmlhttp.send();
}
function deleteRoom(room_id) 
{
var ans=window.confirm("Are you sure? Do you want to Delete?")
if(ans)
{
	xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
 			var res=xmlhttp.responseText;
			if(res==0)
				popup("Alert","Sorry..Room Deletion Failed.<br/>Please Check and Try Again",2)
			else
				popup("Successful","Room Details are Successfully Deleted",1);
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));},2000);	
 			getRooms(block2.value)
 			}
  		}
	xmlhttp.open("GET","deleteRoom.jsp?room_id="+room_id,true);
	xmlhttp.send();
}
}


//This is Ending of Rooms Related Java Script
/************************************************************************************************/


/************************************************************************************************/
//This is Staritng of Users Related Java Script
/************************************************************************************************/
function getUsers() 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
	
 			document.getElementById("show2").style.visibility="visible"
 			document.getElementById("show2").innerHTML =xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getUsers.jsp",true);
xmlhttp.send();
}

function addUser() 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var res=xmlhttp.responseText;
			if(res==0)
				popup("Alert","Sorry..Account Not Created.<br/>Change User Name and Try Again ",2)
			else
				popup("Successful","User Account Successfully Created",1);
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));if(res==1)users1.reset();},2000);	
 		}
  	}
  if(errStatus==0)
  {
		xmlhttp.open("POST","addUser.jsp",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("user_id="+users1.uid.value+"&pwd="+users1.pwd.value+"&type="+users1.usertype.value);
	}
}

function deleteUser(uid) 
{
var ans=window.confirm("Do you want to Delete?")
if(ans)
{
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var res=xmlhttp.responseText;
			if(res==0)
				popup("Alert","Sorry..Currently you can't Delete.<br/>Please Check and Try Again",2);
			else
				popup("Successful","User Account is Successfully Deleted",1);
			setTimeout(function () {document.body.removeChild(document.getElementById('popup'));},2000);		
			getUsers();
 		}
  	}
	xmlhttp.open("POST","deleteUser.jsp",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("user_id="+uid);
}
}

//This is Ending of Users Related Java Script
/************************************************************************************************/


/************************************************************************************************/
//This is Startng of Invigilatoin Related Java Script
/************************************************************************************************/
function getExamsList(target) 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML =xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","getExamsList.jsp",true);
xmlhttp.send();
}
function suggestInvigilators() 
{
	var tot_stu=parseInt(document.getElementById("appearstudents").innerHTML);
	document.getElementById("invigreq").innerHTML="Suggested Invigilators :&nbsp;<b style='font-weight:bold;color:red;font-size:25px;'>"+Math.round(tot_stu/30)+"</b>&nbsp;Members per Day";	
}
function getExamDetails(eid) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
     	{
                 document.getElementById("data").style.visibility="visible"
                 document.getElementById("data").innerHTML =xmlhttp.responseText;
                 getInvigAllotForm(eid);
 		}
  	}
xmlhttp.open("GET","getExamDetails.jsp?eid="+eid,true);
xmlhttp.send();
}
function getInvigAllotForm(eid) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
   {
                 document.getElementById("allotform").style.visibility="visible"
                 document.getElementById("allotform").innerHTML =xmlhttp.responseText;
                 	suggestInvigilators();
 		}
  	}
xmlhttp.open("GET","invigAllot.jsp?eid="+eid,true);
xmlhttp.send();
}
function sendReq(val,eid) 
{
	var loader=document.getElementById("load");
	loader.style.visibility="visible";
	var flag1=0,flag2=0;
	var rid=new Date().getTime();
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
      {
           //document.getElementById("allotform").style.visibility="visible"
           flag2++;     
 		}
  	}
  	for(var i=1;i<=val;i++)
  	{
  		var ele=document.getElementById("reqval"+i);
  		if(ele.value!=""&&ele.value!="0")
  		{
  			flag1++;
  			var args=document.getElementById("reqhidden"+i).value;
  			var vals=args.split(',');
			xmlhttp.open("POST","sendReq.jsp",false);
   		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		//	alert("rid="+rid+"&eid="+vals[1]+"&exam_id="+vals[0]+"&nop="+ele.value+"&date="+document.getElementById("column"+vals[2]).value);
			xmlhttp.send("rid="+rid+"&eid="+vals[0]+"&exam_id="+eid+"&nop="+ele.value+"&date="+document.getElementById("column"+vals[1]).value);
		}
	}
	loader.style.visibility="hidden";
	if(flag1!=0&&flag1==flag2)
	{
		popup("Requests","Requests are Successfully Sent","1");
	}
	else if(flag2==0)
		popup("Alert","Please Enter Data","2");
	else
		popup("Requests Status","Sorry..some requests are not sent","2");
}
function modifyReq(val,eid) 
{
	var loader=document.getElementById("load");
	loader.style.visibility="visible";
	var flag1=0,flag2=0;
	var rid=new Date().getTime();
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
      {
           //document.getElementById("allotform").style.visibility="visible"
           flag2++;     
 		}
  	}
  	xmlhttp.open("GET","deleteRequests.jsp?exam_id="+eid,false);
  	xmlhttp.send();
  	for(var i=1;i<=val;i++)
  	{
  		var ele=document.getElementById("reqval"+i);
  		if(ele.value!=""&&ele.value!="0")
  		{
  			flag1++;
  			var args=document.getElementById("reqhidden"+i).value;
  			var vals=args.split(',');
			xmlhttp.open("POST","sendReq.jsp",false);
   		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("rid="+rid+"&eid="+vals[0]+"&exam_id="+eid+"&nop="+ele.value+"&date="+document.getElementById("column"+vals[1]).value);
		}
	}
	loader.style.visibility="hidden";
	if(flag1!=0&&flag1==flag2-1)
		popup("Requests","Requests are Successfully Changed","1");
	else if(flag2==0)
		popup("Alert","Please Enter Data","2");
	else
		popup("Requests Status","Sorry..some requests are not sent","2");
}

function getInvigAssignmentForm(date,nop,exid)
{
	if (window.XMLHttpRequest)
	{
 		xmlhttp=new XMLHttpRequest();
	}	
	else
	{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("assignForm").innerHTML=xmlhttp.responseText;
 		}
	}
xmlhttp.open("GET","assignform.jsp?exid="+exid+"&nop="+nop+"&date="+date,true);
}
function getRequestStatus(val) 
{
	if (window.XMLHttpRequest)
	{
 		xmlhttp=new XMLHttpRequest();
	}	
	else
	{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("reqstatus").innerHTML=xmlhttp.responseText;
 		}
	}
	xmlhttp.open("GET","getRequestStatus.jsp?exid="+val,true);
	xmlhttp.send();
}
function getExamDates(exid,target)
{
	selectedExam=exid;
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML =xmlhttp.responseText;
 		}
  	}
	xmlhttp.open("GET","getExamDates.jsp?exid="+exid,true);
	xmlhttp.send();
}
function getInvigilators() 
{
	var date=document.getElementById("exdates").value;
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
		//	document.write(xmlhttp.responseText)
 			document.getElementById("invig_allot_form").innerHTML =xmlhttp.responseText;
 			storeRooms();
 		}
  	}
	xmlhttp.open("GET","getInvigilators.jsp?exid="+selectedExam+"&date="+date,true);
	xmlhttp.send();
}
function getPaymentSheet() 
{
	var amount=document.getElementById("invig_amount").value;
	var exid=document.getElementById("exlist4").value;
	if(amount!=""&&amount!=0)
	{
		xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				//	document.write(xmlhttp.responseText)
 				document.getElementById("invig_payment").innerHTML =xmlhttp.responseText;
 			}
  		}
		xmlhttp.open("GET","getPaymentSheet.jsp?exid="+exid+"&amount="+amount,true);
		xmlhttp.send();
	}
	else
	{
		document.getElementById("invig_amount").style.borderColor="red";
		document.getElementById("invig_amount").focus();
	}	
}
function savePayments(exid,amount,persons) 
{
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			popup("Success","Payments are Successfully Saved",1);
 		}
  	}
	xmlhttp.open("GET","savePayments.jsp?exid="+exid+"&amount="+amount+"&persons="+persons,true);
	xmlhttp.send();
}
function updatePayments(exid,amount,persons) 
{
	amount=document.getElementById("newamount").value;
	if(amount!="")
	{
		xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				popup("Success","Payments are Successfully Saved",1);
				getPaymentSheet();			
 			}
  		}
		xmlhttp.open("GET","updatePayments.jsp?exid="+exid+"&amount="+amount+"&persons="+persons,true);
		xmlhttp.send();
	}
	else
	{ 
		document.getElementById("newamount").style.borderColor="red";
		document.getElementById("newamount").focus();
	}
}
var rooms=[];
function storeRooms() 
{
	var limit=document.getElementById("limit").value;
	for(var i=1;i<limit;i++)
	{
		rooms.push(document.getElementById("rmf"+i).value);
	}
}
function setRoom(val,ele) 
{
	var limit=parseInt(document.getElementById("limit").value);
	var num=parseInt(val.value);
	var cnt=0;
	var invigCount=parseInt(document.getElementById("invigCount").value);
	if(val.value!=""&&num!=0&&num<limit)
	{
		for(var i=0;i<invigCount;i++)
		{
			if(document.getElementById("file"+i))
				if(parseInt(document.getElementById("file"+i).value)==num)
					cnt++;
					
		}
		if(cnt>1)
		{
			popup("Alert","File Already given to another Invigilator",2);
			document.getElementById(ele).value="";
			val.value="";
			val.focus();
		}
		else 
			document.getElementById(ele).value=rooms[num-1];			
	}
	else
	{
		document.getElementById(ele).value="";
		val.value="";
		val.focus();
		popup("Alert","Invalid File Number",2);
	}
}
function saveInvigilation(date) 
{
	var date=document.getElementById("exdates").value;
	var limit=document.getElementById("limit").value;
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 		}
  	}
  	popup("Success","Invigilation Details are successfully Saved",1);
  	for(var i=0;i<rooms.length;i++)
  	{
  		var staff=document.getElementById("staff"+i).value;
  		var file=document.getElementById("file"+i).value;
  		var rmno=document.getElementById("rno"+(i+1)).value;
		xmlhttp.open("GET","saveInvigilation.jsp?exid="+selectedExam+"&date="+date+"&rno="+rmno+"&sid="+staff+"&fno="+file,false);
		xmlhttp.send();
	}
}
function printDiv(ele) 
{
   var divElements = document.getElementById(ele).innerHTML;
   var oldPage = document.body.innerHTML;
   document.body.innerHTML =divElements;
   window.print();
   document.body.innerHTML = oldPage;
}
function changeInvigData(exid,date,sid) 
{
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			var ele=document.createElement("div");
 			ele.setAttribute("class","box");
 			ele.setAttribute("id","replacebox");
 			ele.innerHTML=xmlhttp.responseText;
 			document.getElementById("invig_allot_form").appendChild(ele);
 		}
  	}
	xmlhttp.open("GET","changeInvigData.jsp?exid="+exid+"&date="+date+"&sid="+sid,true);
	xmlhttp.send();	
}
function ExchangeInvigilator(news,old,exid,date)
{
	if(news!="")
	{
		xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
 				document.getElementById("replaceStaff").innerHTML=xmlhttp.responseText;
 			}
  		}
		xmlhttp.open("GET","ExchangeInvigilator.jsp?news="+news+"&old="+old+"&date="+date+"&exid="+exid,true);
		xmlhttp.send();
	}		
}
//This is Ending of Invigilation Related Java Script
/************************************************************************************************/


/************************************************************************************************/
//This is Starting of Seating Plans Related Java Script
/************************************************************************************************/
function getAvailStatus() 
{
		var list=new Array();
		list=document.getElementsByName("extype")
		if(list[0].checked)
			extype=list[0].value
		else
			extype=list[1].value
		var exam_id=extype+""+newplan1.ac_yr.value.substring(0,4)+""+(newplan1.month.value.substring(0,3));
		if (window.XMLHttpRequest)
		{	
 			xmlhttp=new XMLHttpRequest();
		}
		else
		{	
 			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function()
		{
	  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
 				document.getElementById("exavail").innerHTML=xmlhttp.responseText;
 					exavail=document.getElementById("exavailStatus").value;
 			}
		}
		xmlhttp.open("GET","examAvailability.jsp?exid="+exam_id,true);
		xmlhttp.send();
}
function addEle(cnt) 
{
var child=document.getElementById("tbc");
if (child.hasChildNodes()) 
{
	while (child.childNodes.length>=1)
	{
		child.removeChild(child.firstChild);		
	}
}
if(cnt>0)
{
	document.getElementById("tbc").style.visibility="visible";
	document.getElementById("title").style.visibility="visible";
}
else
	document.getElementById("title").style.visibility="hidden";
var table = document.createElement("table");
var c1,c2,row,ele,ele2,ele3;
for(i=1;i<=cnt;i++)
{
	row=table.insertRow(i-1);
	c1=row.insertCell(0);
	c2=row.insertCell(1);
	ele=document.createElement("input");
	ele.setAttribute("type","text");		
	ele.setAttribute("name","date"+i);
	ele.setAttribute("style","margin-top:3px;width:150px;text-align:center;");
	ele.setAttribute("id","date"+i);
	ele.setAttribute("onchange","timeInput("+i+")");
	ele.setAttribute("class","datepicker");
	ele.setAttribute("placeholder","Exam "+i+" Date");
	ele.setAttribute("onfocus","$(this).datepicker({dateFormat:'dd-mm-yy'})");
	ele2=document.createElement("input");
	ele2.setAttribute("type","text");	
	ele2.setAttribute("class","textbox");
	ele2.setAttribute("style","width:70px;visibility:hidden;font-size:14px;text-align:center;");
	ele2.setAttribute("placeholder","HH:MM");
	ele2.setAttribute("maxlength","5");
	ele2.setAttribute("name","starttime"+i);
	ele2.setAttribute("onkeypress","return timer(this,event)");
	ele2.setAttribute("onblur","checkTime("+i+")");
	ele2.setAttribute("id","starttime"+i);
	ele2.setAttribute("value",newplan1.starttime0.value);
	ele3=document.createElement("input");
	ele3.setAttribute("type","text");	
	ele3.setAttribute("class","textbox");
	ele3.setAttribute("style","width:70px;visibility:hidden;font-size:14px;text-align:center;");
	ele3.setAttribute("placeholder","HH:MM");
	ele3.setAttribute("maxlength","5");
	ele3.setAttribute("name","endtime"+i);
	ele3.setAttribute("onkeypress","return timer(this,event)");
	ele3.setAttribute("id","endtime"+i);
	ele3.setAttribute("value",newplan1.endtime0.value);
	var sep=document.createElement("b")
	sep.setAttribute("id","sep"+i)
	sep.setAttribute("style","font-size:18px;visibility:hidden");
	sep.innerHTML="&nbsp;To&nbsp;"
	c1.appendChild(ele);
	c2.appendChild(ele2);
	c2.appendChild(sep);
	c2.appendChild(ele3);
}
document.getElementById("tbc").appendChild(table);
var mon=newplan1.month.value;
var yr=newplan1.ac_yr.value.split('-');
yr[1]=yr[0].substring(0,2)+""+yr[1];
$(".datepicker").datepicker({ dateFormat: "dd-mm-yy",minDate:0, maxDate:'+12M',changeMonth: true,changeYear: true,showButtonPanel: true });
}
function checkTime(pos) 
{
	if(document.getElementById("starttime"+pos).value!="")
	{
		var time=(document.getElementById("starttime"+pos).value).split(':');
		var endtime="";
		if(time[0].charAt(0)=="0")
			time[0]=time[0].charAt(1);
		var hr=parseInt(time[0])+3;
		if(hr<10)
			endtime="0"+hr;
		else if(hr>12)
			endtime="0"+(hr-12);
		else
			endtime=hr;
		endtime+=":"+time[1];
		document.getElementById("endtime"+pos).value=endtime;
	}
}
function timer(ele,evt) 
{
var charCode = (evt.which) ? evt.which : evt.keyCode
if((charCode>=48&&charCode<=57)||(charCode==8))
{
	var val=ele.value;
	switch(val.length) 
	{
		case 0:	if(charCode==49||charCode==48||charCode==8)
						return true;
					else
						return false;
					break;
		case 1:	if(val!='0')
					{
						if(charCode>=48&&charCode<=50||charCode==8)
							return true;
						else
							return false;
					}
					else 
					{
						if(charCode>=48&&charCode<=57||charCode==8)
							return true;
						else
							return false;
					}
					break;
		case 2: 	if(charCode==8)
						return true;
					else
						ele.value+=":";
					return true;
					break;
		case 3: if(charCode>=48&&charCode<=53||charCode==8)
						return true;
					else 
						return false;
	}
}
else 
	return false;
}
function timeInput(cnt) 
{
var d1=(document.getElementById("date"+cnt).value).split('-');
var d2=(document.getElementById("date"+(cnt-1)).value).split('-');
val1=""+d1[2]+d1[1]+d1[0];
val2=""+d2[2]+d2[1]+d2[0];
	if(val1<val2)
	{
		document.getElementById("date"+cnt).value="";
		document.getElementById("date"+(cnt-1)).focus();
	}
	else if (val2!="")
	{	
		if(val1==val2)
		{
			document.getElementById("starttime"+cnt).style.visibility="visible"	
			document.getElementById("endtime"+cnt).style.visibility="visible"	
			document.getElementById("sep"+cnt).style.visibility="visible"	
			document.getElementById("starttime"+cnt).focus()	
		}	
		else 
		{
			document.getElementById("starttime"+cnt).style.visibility="hidden"	
			document.getElementById("endtime"+cnt).style.visibility="hidden"	
			document.getElementById("sep"+cnt).style.visibility="hidden"	
		}
	}
}
function loadBranches() 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			document.getElementById("branches").innerHTML =xmlhttp.responseText;
 			loadRooms();
 			pos=1;
 		}
  	}
xmlhttp.open("GET","selectDept.jsp",true);
xmlhttp.send();
}
function loadRooms() 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById("accordion").innerHTML =xmlhttp.responseText;
 		   $( "#accordion" ).accordion({heightStyle: "fill"});
		
 		}
  	}
xmlhttp.open("GET","selectRooms.jsp",true);
xmlhttp.send();
}
function selectAll(items) 
{
if($("."+items+"head").prop("checked"))
{		
	$("."+items).prop("checked",true);
	$("."+items+"text").css({"color":"orange"});
}
else 
{
	$("."+items).prop("checked",false)
	$("."+items+"text").css({"color":"black"});
}
	if(items=='branchlist')
		checkedBranches()
	else 
		checkedRooms()
}
function saveBranch(bid,tid) 
{
var col=document.getElementById("b"+tid);
var ele=document.getElementById("branch"+tid);
if(ele.checked)	
	col.style.color="orange";
else 
	col.style.color="black";	
checkedBranches()
}
function saveRoom(rid,cid) 
{
var col=document.getElementById("rm"+cid);
var ele=document.getElementById("room"+cid);
if(ele.checked)
	col.style.color="orange";
else 
	col.style.color="black";
checkedRooms();
}
function checkedRooms() 
{
rid=[];
rcap=[];
var totalrmscap=0;
blocknames=[];    
$(".blockname").each(function () {
   blocknames.push($(this).val()) ;
});	
for(var i=0;i<blocknames.length;i++)
{
 	$("."+blocknames[i]+"roomslist:checked").each(function () {
   	rid.push($(this).val()) ;
      rcap.push(document.getElementById("rc"+($(this).val())).value);
      totalrmscap+=parseInt(document.getElementById("rc"+($(this).val())).value);
   });  
}
	var stu=parseInt(document.getElementById("totalStudents").value);
	document.getElementById("roomscapacity").value=totalrmscap;
	document.getElementById("roomselected").value=rid.length;
	if(stu-totalrmscap>0)
	{
		document.getElementById("statuscontent").innerHTML="Rooms Needed for Remaining Students"
		document.getElementById("remainingstudents").value=stu-totalrmscap;
		rmstatus=0;
	}
	else 
	{
		document.getElementById("statuscontent").innerHTML="Capacity of Rooms more than total students";
		document.getElementById("remainingstudents").value=totalrmscap-stu;
		rmstatus=1;
	}
}
function checkedBranches() 
{
bid=[];
bname=[];
var j=0;
$(".branchlist:checked").each(function () {
    bid.push($(this).val()) ;
    bname.push($("#b"+(j++)).html());
}); 
if(extype=="REG")
	branchInputTable1();
else
	branchInputTable2();  	
}

function branchInputTable1() 
{
var rowslen=bid.length;
var table = document.getElementById("branchDetails");
table.innerHTML="";
for(i=0;i<=rowslen;i++)
{
	var row = table.insertRow(i);
	for(j=0;j<=5;j++)
	{
		var cell= row.insertCell(j);
		if(i==0&&j==0)
		{
			cell.innerHTML="";
			cell.setAttribute("class","hiddencell");
		}
		else if(i==0)
		{
			if(j==1)
		 		cell.innerHTML="Starting Number";
		 	else if(j==2)
		 		cell.innerHTML="Ending Number";
		 	else if(j==3)
		 		cell.innerHTML="Missing Numbers";
		 	else if(j==4)
		 		cell.innerHTML="Extra Numbers";
		 	else
		 		cell.innerHTML="Total Students"
		 		cell.setAttribute("class","stop");
		}
		else if(j==0)
		{
			cell.innerHTML=bid[i-1];
			cell.setAttribute("title",bname[i-1])
			cell.setAttribute("class","sleft");				
		}
		else if(j==1)
				cell.innerHTML="<input type='text' maxlength='10' style='width:150px;text-align:center;' onkeypress='return blockSpecialChar(event)' onkeyup='ChangeToUpper()' class='textbox' id='txt"+(i-1)+""+(j-1)+"' name='numlist"+(i-1)+""+(j-1)+"' />"
		else if(j==2)
				cell.innerHTML="<input type='text' onchange='isValid("+(i-1)+")' maxlength='10' style='width:150px;text-align:center;' onkeypress='return blockSpecialChar(event)' class='textbox' id='txt"+(i-1)+""+(j-1)+"' name='numlist"+(i-1)+""+(j-1)+"' />"
		else if(j==4) 
				cell.innerHTML="<input type='text' onchange='isValid("+(i-1)+")' style='width:200px;text-align:center;' onkeypress='return allowComma(event)' class='textbox' id='txt"+(i-1)+""+(j-1)+"' name='numlist"+(i-1)+""+(j-1)+"' />"
		else if(j==3)
				cell.innerHTML="<input type='text' onchange='isValid("+(i-1)+")' style='width:200px;text-align:center;' onkeypress='return allowComma(event)' class='textbox' id='txt"+(i-1)+""+(j-1)+"' name='numlist"+(i-1)+""+(j-1)+"' />"
		else 
				cell.innerHTML="<input type='text' disabled='disabled' class='textbox' style='width:60px;color:maroon;text-align:center' id='countcell"+(i-1)+"' />"
	}
}
var row = table.insertRow(i);
	var cell= row.insertCell(0);
	cell.setAttribute("colspan","5");
	cell.setAttribute("style","text-align:right;font-weight:bold;font-size:20px");
	cell.innerHTML="Total Students";
	cell=row.insertCell(1);
	cell.innerHTML="<input type='text' disabled='disabled' class='textbox' style='font-size:25px;font-weight:bold;color:maroon;text-align:center;width:100px;height:30px' id='totalStudents' />"
}

function branchInputTable2() 
{
var rowslen=bid.length;
var table = document.getElementById("branchDetails");
table.innerHTML="";
for(i=0;i<=rowslen;i++)
{
	var row = table.insertRow(i);
	for(j=0;j<=2;j++)
	{
		var cell= row.insertCell(j);
		if(i==0&&j==0)
		{
			cell.innerHTML="";
			cell.setAttribute("class","hiddencell");
		}
		else if(i==0)
		{
			if(j==1)
		 		cell.innerHTML="Roll Numbers";
		 	else
		 		cell.innerHTML="Total Students"
		 		cell.setAttribute("class","stop");
		}
		else if(j==0)
		{
			cell.innerHTML=bid[i-1];
			cell.setAttribute("title",bname[i-1])
			cell.setAttribute("class","sleft");				
		}
		else if(j==1)
				cell.innerHTML="<input type='text' onblur='isValid("+(i-1)+")' style='width:600px;height:40px' onkeypress='return allowComma(event)' class='textbox' id='supnums"+(i-1)+""+(j-1)+"' name='supnums"+(i-1)+""+(j-1)+"' />"
		else if(j==2)
				cell.innerHTML="<input type='text' disabled='disabled' style='font-size:18px;color:maroon;text-align:center;width:60px' id='supcountcell"+(i-1)+"' />"
	}
}
	var row = table.insertRow(i);
	var cell= row.insertCell(0);
	cell.setAttribute("colspan","2");
	cell.setAttribute("style","text-align:right;font-weight:bold;font-size:20px");
	cell.innerHTML="Total Students";
	cell=row.insertCell(1);
	cell.innerHTML="<input type='text' disabled='disabled' class='textbox' style='font-size:25px;font-weight:bold;color:maroon;text-align:center;width:100px;height:30px' id='totalStudents' />"
}

function seatTable() 
{
	var child=document.getElementById("tabs");
	if (child.hasChildNodes()) 
	{
		while (child.childNodes.length>=1)
		{
			child.removeChild(child.firstChild);		
		}
	}	 
var cols=rid.length;
var rows=bid.length;
var ulele=document.createElement("ul");
document.getElementById("tabs").appendChild(ulele);	
var brc=0;
for(var i=0;i<rows;i++)
{	
	if(!isNaN(parseInt(brcount[i])))
		ulele.innerHTML +="<li><a id='branchtab"+i+"' title='"+bname[i]+"' href='#tabs-"+i+"'>"+bid[i]+"<br/>"+brcount[brc++]+"</a></li>"
	else
		ulele.innerHTML +="<li><a id='branchtab"+i+"' title='"+bname[i]+"' href='#tabs-"+i+"'>"+bid[i];
}
for(var i=0;i<rows;i++)
{
	var div=document.createElement("div");
	div.setAttribute("id","tabs-"+i);
	div.setAttribute("class","priordiv");
	document.getElementById("tabs").appendChild(div);
	var table = document.createElement("table");
	table.setAttribute("class","prioritytab");
	var row=table.insertRow(0);
	var c0=row.insertCell(0);c0.innerHTML="Room Number";c0.setAttribute("colspan","2");
	var c1=row.insertCell(1);c1.innerHTML="Allotted Students";
	var c2=row.insertCell(2);c2.innerHTML="Priority";
	c0.setAttribute("class","stop")
	c1.setAttribute("class","stop")
	c2.setAttribute("class","stop")
	for(var j=0;j<cols;j++)
	{
		row=table.insertRow(j+1);
		row.insertCell(0).innerHTML=rid[j];
		row.insertCell(1).innerHTML="<div class='rmremain"+rid[j]+"'>Remaining <b>"+rcap[j]+"</b></div>";
		row.insertCell(2).innerHTML="<input type='text' onkeypress='return isNum(event)' id='"+rid[j]+""+bid[i]+"val' onblur=showpriority(this.value,'"+rid[j]+""+bid[i]+"','"+bid[i]+"','"+rid[j]+"') class='textbox' style='width:100px;text-align:center' />";
		row.insertCell(3).innerHTML="<div  id='pricont"+rid[j]+""+bid[i]+"' class='checkBox' style='visibility:hidden'><input type='checkbox' style='opacity:0' class='branchPriority'  id='pri"+rid[j]+""+bid[i]+"' name='pri"+rid[j]+""+bid[i]+"' onclick=setPriority(this,'"+bid[i]+"') value='' tabindex='-1' /><label id='label"+rid[j]+""+bid[i]+"' for='pri"+rid[j]+""+bid[i]+"' ></label></div>"
	}
	div.appendChild(table);
	var div3=document.createElement("button");
	div3.setAttribute("id","branchPriorityStatus");
	div3.setAttribute("class","btn");
	div3.setAttribute("style","position:absolute;top:85%;right:3%;float:right;");
	div3.setAttribute("onclick","branchPriorityStatus()");
	div3.innerHTML="View Priview"
	div.appendChild(div3);
	var div4=document.createElement("button");
	div4.setAttribute("class","maxmin");
	div4.setAttribute("style","position:absolute;top:85%;right:18%;float:right;");
	div4.setAttribute("onclick","maximize()");
	div4.innerHTML="Maximize"
	div.appendChild(div4);
	var div2=document.createElement("div");
	div2.setAttribute("style","position:absolute;top:40%;right:10%;float:right;width:150px;height:60px;font-size:50px;color:red;font-weight:bold;");
	div2.setAttribute("id","remaining"+bid[i]);
	div.appendChild(div2);
	if(!isNaN(parseInt(brcount[i])))
		div2.innerHTML=brcount[i]
}
$(function() {$( "#tabs" ).tabs();});	
}


function showpriority(val,eleid,brid,rmid) 
{
var err=0;
var rcount=0;
if(val==""||val==0)
{
	document.getElementById("pricont"+eleid).style.visibility='hidden'
	document.getElementById("pri"+eleid).value=""
	document.getElementById("pri"+eleid).checked=false;
	document.getElementById("label"+eleid).value=""
	/*For Reset Priority */
	for(var i=0;i<rid.length;i++)
	{
		document.getElementById("pri"+rid[i]+""+brid).checked=false;
		document.getElementById("pri"+rid[i]+""+brid).value="";
		document.getElementById("label"+rid[i]+""+brid).innerHTML="";	
	}
}
else 
{
	document.getElementById("pricont"+eleid).style.visibility='visible'
	for(k=0;k<bid.length;k++)
	{
		if(document.getElementById(rmid+""+bid[k]+"val").value!="")
		{
			rcount+=parseInt(document.getElementById(rmid+""+bid[k]+"val").value);		
		}
		for(j=0;j<rid.length;j++)
			if(rid[j]==rmid)
				if(rcount>parseInt(rcap[j]))
					err=1;
	}
	if(err==0)
	{
		var ele=document.getElementById("remaining"+brid);
		rcount=0;
		for(var i=0;i<brcount.length;i++)
		{
			if(bid[i]==brid)
			{
				rcount=brcount[i];
					for(var j=0;j<rid.length;j++)
						if(document.getElementById(rid[j]+""+brid+"val").value!="")
							rcount-=document.getElementById(rid[j]+""+brid+"val").value
						if(rcount<0)
						{
							document.getElementById(eleid+"val").value="";
							document.getElementById(eleid+"val").focus();
							document.getElementById("pricont"+eleid).style.visibility='hidden'
							popup("Alert","Allotted Numbers are Exceeded than Total count",2);
						}
						else
						{		
							document.getElementById("pri"+eleid).checked="true";
							setPriority(document.getElementById("pri"+eleid),brid);						
							ele.innerHTML=rcount;
							var tempsum=0;
							for(var l=0;l<bid.length;l++)
								if(document.getElementById(rmid+""+bid[l]+"val").value!="")
										tempsum+=parseInt(document.getElementById(rmid+""+bid[l]+"val").value);						
							for(l=0;l<rid.length;l++)
								if(rmid==rid[l])
								{
									$(".rmremain"+rmid).each(function () {
										if((rcap[l]-tempsum)!=0)
         								$(this).html("Remaining <b>"+(rcap[l]-tempsum)+"</b>");
         							else
         								$(this).html("<b style='color:green;font-size:15px'>Filled</b>");
         						});
									break;									
								}	
						}
						break;
			}
		}	
	}
	else
	{
		document.getElementById(eleid+"val").value=0;
		document.getElementById("pricont"+eleid).style.visibility='hidden'
		popup("Alert","Value is more than Room Capacity",2);
		document.getElementById(eleid+"val").focus();
	}
}
}
function setPriority(eleid,brid) 
{
if(eleid.checked)
{
	if(eleid.value=="")
	{	
		var incr=0;
		for(i=0;i<rid.length;i++)
			if(document.getElementById("pri"+rid[i]+""+brid).checked)
				incr++;
		eleid.nextSibling.innerHTML=incr;
		eleid.value=incr;
	}
}	
else 
{
	var val1=eleid.value;
	var val2=0;
	eleid.value="";
	if(val1=="")
	{
	for(var i=0;i<bid.length;i++)
	{
		for(var j=0;j<rid.length;j++)
		{
			var ele=document.getElementById("label"+rid[j]+""+bid[i]);
			if((ele.innerHTML)!="")
			{
			val2=parseInt(ele.innerHTML);
			if(val2>val1)
    		{
    			ele.innerHTML=val2-1;	
    			ele.previousSibling.value=val2-1;
    		}
    		}		
		}
	}
}
}
}

function setPriority2(eleid,rmid) 
{
if(eleid.checked)
{
	var incr=0;
	for(var i=0;i<bid.length;i++)
		if(document.getElementById("rmpri"+rmid+""+bid[i]))
			if(document.getElementById("rmpri"+rmid+""+bid[i]).checked)
				incr++;
	eleid.nextSibling.innerHTML=incr;
	eleid.value=incr;
}	
else 
{
	var val1=eleid.value;
	var val2=0;
	eleid.value="";
	for(var i=0;i<bid.length;i++)
	{
			if(document.getElementById("label2"+rmid+""+bid[i]))
			{
				var ele=document.getElementById("label2"+rmid+""+bid[i]);
				if((ele.innerHTML)!="")
				{
					val2=parseInt(ele.innerHTML);
					if(val2>val1)
    				{
    					ele.innerHTML=val2-1;	
    					ele.previousSibling.value=val2-1;
    				}
    			}
    		}		
	}
}
}

function isValid(cellnum) 
{
var temp=0;
if(extype=="SUP")
{
	var val=document.getElementById("supnums"+""+cellnum+"0").value;
	if(val=="")
		document.getElementById("supnums"+""+cellnum+"0").focus();
	else
		supCount(cellnum);	
}
else
{
	totalCount(cellnum)
}
}
function supCount(cellnum) 
{
	var val=document.getElementById("supnums"+cellnum+""+0).value;
	var err=0;
	if(val!="")
	{
		val=val.toUpperCase();
		if((val.lastIndexOf(',')+1)==val.length)
		val=val.substring(0,val.length-1);
		extranums[cellnum]=val.split(',');
		if(extranums[cellnum][0].length!=10)
		{
			popup("Alert","Invalid Starting Number Identified...",2);
			err=1;
		}
		for(var i=0;i<extranums[cellnum].length&&err==0;i++)
			if(extranums[cellnum][i].length!=10&&extranums[cellnum][i].length!=1&&extranums[cellnum][i].length!=2)
			{
				popup("Alert","Invalid Number Identified...",2);
				err=1;
				break;			
			}
			else 
			{
				if(extranums[cellnum][i].length==10)
					sig=extranums[cellnum][i].substring(0,8)
				else if(extranums[cellnum][i].length==1)
					extranums[cellnum][i]=sig+"0"+extranums[cellnum][i];
				else 
					extranums[cellnum][i]=sig+extranums[cellnum][i];
			}
		if(err==0)
		{
			var sum=0;
			var sig="";
			brcount[cellnum]=extranums[cellnum].length;
			document.getElementById("supcountcell"+cellnum).value=extranums[cellnum].length;
			for(var i=0;i<=cellnum;i++)
				sum+=parseInt(document.getElementById("supcountcell"+cellnum).value);
			document.getElementById("totalStudents").value=sum;
			document.getElementById("nofstudents").value=sum;
			document.getElementById("remainingstudents").value=sum;
		}
		else 
		{
			document.getElementById("supnums"+cellnum+""+0).focus();
		}
	}
}
function ChangeToUpper()
{         
      key = window.event.which || window.event.keyCode;
        if ((key > 0x60) && (key < 0x7B))
         	window.event.keyCode = key-0x20;
}
function getCode(num)
{
	num=num.toUpperCase();
	var fch=num.charAt(0);
	var lch=parseInt(""+num.charAt(1));
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
		return parseInt(num);
return 0;
}
function deCode(num)
{
	if(num<99)
		return num+"";
	var fnum=num/100;
	var lnum=num%100;
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
return "";
}

function totalCount(cellnum) 
{
var brsum=0;
var flag=0;
var mstatus=0;
var estatus=0;
var shortstartnums=[]
var shortendnums=[]
var startsig,endsig;
var missig=[];
for(var i=0;i<4&&flag==0;i++)
{
	var val=document.getElementById("txt"+cellnum+""+i).value;
	switch(i) 
	{				
		case 0: 	if(val.length!=10)
					{
						popup("Alert","Invalid Starting Number.."+val,2);
						document.getElementById("txt"+cellnum+""+0).focus();
						flag=1;
						return;
					}
					else
					{
						startnums[cellnum]=val;
						startsig=val.substring(0,8);
						shortstartnums[cellnum]=val.slice(-2);
					}
					break;
		case 1:	if(val.length!=10)
					{
						popup("Alert",i+"Invalid Ending Number.."+val,2);
						document.getElementById("txt"+cellnum+""+1).focus();
						flag=2;
						return;
					}
					else 
					{
						endnums[cellnum]=val;
						endsig=val.substring(0,8);
						shortendnums[cellnum]=val.slice(-2);
					}
					break;
		case 2:	if(val!="")
					{
						if((val.lastIndexOf(',')+1)==val.length)
							val=val.substring(0,val.length-1);
						missnums[cellnum]=val.split(',');
						for(k=0;k<missnums[cellnum].length;k++)
						{
							missig[k]=missnums[cellnum][k].substring(0,8);
							if(missnums[cellnum][k].length!=10)
							{
								popup("Alert","Invalid Missing Number.."+missnums[cellnum][k],2);
								document.getElementById("txt"+cellnum+""+2).focus();
								flag=3;
								return;									
							}
							mstatus=1;
						}
					}
					else
						missnums[cellnum]=0;
					break;
		case 3:	if(val!="")
					{	
						if((val.lastIndexOf(',')+1)==val.length)
							val=val.substring(0,val.length-1);
						extranums[cellnum]=val.split(',');
						for(k=0;k<extranums[cellnum].length;k++)
						{
							if(extranums[cellnum][k].length!=10)
							{
								popup("Alert","Invalid Extra Number..."+extranums[cellnum][k],2);
								document.getElementById("txt"+cellnum+""+3).focus()
								flag=4;
								return;
							}
							estatus=1;
						}
					}
					else
						extranums[cellnum]=0;
						
	}			
}
if(flag==0)
{
if(startsig!=endsig)
{
	popup("Alert","Numbers are not identical..."+endsig,2);
	document.getElementById("txt"+cellnum+""+1).focus();
	flag=5;
	return;
}
else 
{
	for(var j=0;j<missig.length;j++)
	{
		if(startsig!=missig[j])
		{ 
			popup("Alert","Numbers are not identical..."+missig[j],2);
			document.getElementById("txt"+cellnum+""+2).focus();
			flag=5;
			break;
		}		
	}
}
if(flag==0) 
{
	brsum=(getCode(shortendnums[cellnum])-getCode(shortstartnums[cellnum]))+1;
	if(mstatus==1)
		brsum-=missnums[cellnum].length;
	if(estatus==1)		
		brsum+=extranums[cellnum].length;
	document.getElementById("countcell"+cellnum).innerHTML=brsum;
	brcount[cellnum]=brsum;
	document.getElementById("countcell"+cellnum).value=brsum;
	var tcnt=0;
	for(i=0;i<bid.length;i++)
		if(document.getElementById("countcell"+i).value!="")
			tcnt+=parseInt(document.getElementById("countcell"+i).value);
	document.getElementById("totalStudents").value=tcnt;
	document.getElementById("nofstudents").value=tcnt;
	document.getElementById("remainingstudents").value=tcnt;
}
}
}
function performNext(cur,evt) 
{
if(!($(cur).hasClass("buttonDisabled")))
{
	pos++;
	switch(pos) 
	{		 
		case 2:	var err=0;
					if(newplan1.starttime0.value==""||newplan1.endtime0.value==""||newplan1.exname.value==""||newplan1.month.value==""||newplan1.ac_yr.value==""||exavail==1)
						err=1;
					for(var i=1;i<=newplan1.excnt.value;i++)
					{
						if(document.getElementById("date"+i).value)
						{
							if(document.getElementById("date"+i).value=="")
							{
								err=1;
								break;
							}
						}
						else 
							err=1;						
					}
					if(err==1)
					{
						document.getElementById("prompt0").style.visibility='visible';
						document.getElementById("branches").style.visibility='hidden';
						document.getElementById("tx").style.visibility='hidden';
					}		
					else 
					{
						document.getElementById("prompt0").style.visibility='hidden';
						document.getElementById("branches").style.visibility='visible';
						document.getElementById("tx").style.visibility='visible';
						step=2;
					}		
					break;
		case 3: 	if (bid.length==0) 
					{	
						document.getElementById("prompt1").style.visibility='visible';
						document.getElementById("branchDetails").innerHTML="";
						step=2;
					}
					else
					{
						document.getElementById("prompt1").style.visibility='hidden';
						step=3;
					}
					break;
		case 4: 	var tot=document.getElementById("totalStudents").value;
					if(tot!="")
					{
						document.getElementById("prompt2").style.visibility='hidden';
						document.getElementById("step4").style.visibility="visible"
						step=3;
					}
					else 
					{
						document.getElementById("prompt2").style.visibility='visible';
						document.getElementById("step4").style.visibility="hidden"
						step=4;
					}
					break;
					
		case 5:	if(rmstatus==0)
					{
						document.getElementById("prompt3").style.visibility='visible';
						document.getElementById("rtitle").style.visibility='hidden';
						step=4;
					}
					else 
					{
						document.getElementById("prompt1").style.visibility='hidden';
						document.getElementById("rtitle").style.visibility='visible';
						step=5;
						seatTable();
					}
					break;
		case 6: 	var err=0,cnt1=0,cnt2=0;
					for(var i=0;i<bid.length;i++)
						if(document.getElementById("remaining"+bid[i]))					
							if(document.getElementById("remaining"+bid[i]).innerHTML!="0")
									err=1;	
					$(".branchPriority:checked").each(function () {
						cnt1++;				
					});
					for(var i=0;i<bid.length;i++)	
						for(var j=0;j<rid.length;j++)
							if(document.getElementById(rid[j]+""+bid[i]+"val"))			
								if((document.getElementById(rid[j]+""+bid[i]+"val")).value!="")
									cnt2++;
					if(cnt1!=cnt2)
						err=1;			
					if(err==1)
					{
						document.getElementById("prompt4").style.visibility="visible";
						document.getElementById("step6").style.visibility='hidden';
						step=5;
					}
					else 
					{
						setRoomPriority();
						document.getElementById("prompt4").style.visibility="hidden";
						document.getElementById("step6").style.visibility='visible';
						step=6;
					}
	}
}
}
function setRoomPriority() 
{
var table=document.getElementById("priority");
table.innerHTML="";
var table2=document.getElementById("priority2");
table2.innerHTML="";
var row,c1,c2,cntr;
var limit=Math.round(rid.length/2);
for(i=0;i<rid.length;i++)
{
	var brid=""
	row=table.insertRow(i)
	if(i>=limit)
	row=table2.insertRow(i-limit)
	c1=row.insertCell(0);
	c1.innerHTML=rid[i];
	cntr=1;
	for(j=0;j<bid.length;j++)
	{
		if(document.getElementById(rid[i]+""+bid[j]+"val").value!=""&&document.getElementById(rid[i]+""+bid[j]+"val").value!="0")
		{
			c2=row.insertCell(cntr++);
			if(brid!=bid[j])// to avoid duplication of branches
			{
				c2.innerHTML=bid[j]+"<br/><div class='checkBox'><input type='checkbox' checked='checked' value="+(cntr-1)+" style='opacity:0' class='roomPriority'  id='rmpri"+rid[i]+""+bid[j]+"' name='rmpri"+rid[i]+""+bid[j]+"' onclick=setPriority2(this,'"+rid[i]+"') /><label id='label2"+rid[i]+""+bid[j]+"' for='rmpri"+rid[i]+""+bid[j]+"' >"+(cntr-1)+"</label></div>";
				brid=bid[j];// to avoid duplication of branches
			}
		}
	}
}	
}
function performPrev(cur,evt) 
{
if(!($(cur).hasClass("buttonDisabled")))
{
	pos--;
	if(pos==4)
		setTimeout(function(){$( "#tabs" ).tabs("destroy");},2000);
}
}
function finish(cur,evt) 
{
 if(!($(cur).hasClass("buttonDisabled")))
 {
	if(step==6&&exavail==0)
	{
		document.getElementById("load").style.visibility="visible";
		if (window.XMLHttpRequest)
		{
			xmlhttp=new XMLHttpRequest();
		}
		else
		{	
 	 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(extype=="REG")
		{
			xmlhttp.onreadystatechange=function()
  			{
  				if(xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					regSeatingPlan(cur);
  				}
  			}
  			xmlhttp.open("GET","tempTables.jsp",false);
  			xmlhttp.send();
  		}
  		else
		{
			xmlhttp.onreadystatechange=function()
  			{
  				if(xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					supSeatingPlan(cur);
  				}
  			}
  			xmlhttp.open("GET","suptempTables.jsp",false);
  			xmlhttp.send();
  		}
  	}
  	else 
  	{
  		popup("Alert Message","Sorry..You Must Enter All Details<br/>Go to->Step:"+step+" Complete the Process",2);
  	}
  }
}
function regSeatingPlan(cur) 
{
var xargs="";
var misargs="";
var dates="";
var starttime="";
var endtime="";
	for(var i=1;i<=newplan1.excnt.value;i++)
	{
		dates+=document.getElementById("date"+i).value+",";
		starttime+=document.getElementById("starttime"+i).value+",";
		endtime+=document.getElementById("endtime"+i).value+",";
	}
	xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			for(i=0;i<bid.length;i++)
			{
				misargs="";
				xargs="";
				for(j=0;j<missnums[i].length;j++)
				{
					misargs+=missnums[i][j]+",";
				}
				for(j=0;j<extranums[i].length;j++)
				{
					xargs+=extranums[i][j]+",";
				}
				saveBranchData(bid[i],startnums[i],endnums[i],misargs,xargs)
			}				
  			}
  		}
  		xmlhttp.open("POST","exam_registration.jsp",false);
  		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("extype="+extype+"&exname="+newplan1.exname.value+"&month="+newplan1.month.value+"&ac_yr="+newplan1.ac_yr.value+"&excnt="+newplan1.excnt.value+"&dates="+dates+"&starttime="+starttime+"&endtime="+endtime);
	//document.write("extype="+extype+"&exname="+newplan1.exname.value+"&month="+newplan1.month.value+"&ac_yr="+newplan1.ac_yr.value+"&excnt="+newplan1.excnt.value+"&dates="+dates+"&starttime="+starttime+"&endtime="+endtime);
	var tbranch="";
			var trooms="";
			var tcapacity="";
			var tpriority="";
			for(k=0;k<bid.length;k++)
			{
				for(l=0;l<rid.length;l++)
				{
					if((document.getElementById(rid[l]+""+bid[k]+"val")).value!=""&&(document.getElementById(rid[l]+""+bid[k]+"val")).value!="0")			
					{
						tbranch+=bid[k]+",";
						trooms+=rid[l]+",";
						tcapacity+=(document.getElementById(rid[l]+""+bid[k]+"val")).value+",";
						tpriority+=(document.getElementById("pri"+rid[l]+""+bid[k])).value+",";
					}			
				}
			}
			saveTempBranch(tbranch,trooms,tcapacity,tpriority); 
}

function saveBranchData(arg1,arg2,arg3,arg4,arg5) 
{
	xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
  			}
  		}
  		xmlhttp.open("GET","saveBranchData.jsp?arg1="+arg1+"&arg2="+arg2+"&arg3="+arg3+"&arg4="+arg4+"&arg5="+arg5,false);
	xmlhttp.send();
}
function saveTempBranch(br,rm,cap,pri) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		var rmpri="";
		var tbranch="";
		var trooms="";
		for(var k=0;k<bid.length;k++)
		{
			for(var l=0;l<rid.length;l++)
			{
				if(document.getElementById("rmpri"+rid[l]+""+bid[k]))
				if((document.getElementById("rmpri"+rid[l]+""+bid[k])).checked)			
				{
					rmpri+=(document.getElementById("rmpri"+rid[l]+""+bid[k])).value+",";
					tbranch+=bid[k]+",";
					trooms+=rid[l]+",";
				}
			}
		}
		saveTempRooms(tbranch,trooms,rmpri);
  		}
  	}
  	xmlhttp.open("GET","saveTempBranch.jsp?bid="+br+"&rid="+rm+"&cap="+cap+"&pri="+pri,false);
xmlhttp.send();
}

function saveTempRooms(br,rm,pri) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		if(extype=="REG")
			SeatingPlanFinalStage()
		else
			supSeatingPlanFinalStage();
  		}
  	}
  	xmlhttp.open("GET","saveTempRooms.jsp?bid="+br+"&rid="+rm+"&pri="+pri,false);
xmlhttp.send();
}
function SeatingPlanFinalStage() 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("load").style.visibility="hidden";
		popup("Successfull","Your Seating plan is Successfully created...",1);
		setTimeout(function(){location.reload()},2000);
  		}
  	}
  	xmlhttp.open("GET","create_reg_SeatingPlan.jsp",false);
xmlhttp.send();
}
/***************************************************************************************************/
/************** For Supplementary Exams ************************************************************/
function supSeatingPlan(cur) 
{
var xargs="";
var dates="";
var starttime="";
var endtime="";
if(!($(cur).hasClass("buttonDisabled")))
{
	for(var i=1;i<=newplan1.excnt.value;i++)
	{
		dates+=document.getElementById("date"+i).value+",";
		starttime+=document.getElementById("starttime"+i).value+",";
		endtime+=document.getElementById("endtime"+i).value+",";
	}
	xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			for(i=0;i<bid.length;i++)
			{
				xargs="";
				for(j=0;j<extranums[i].length;j++)
				{
					xargs+=extranums[i][j]+",";
				}
				supBranchData(bid[i],xargs)
			}				
  			}
  		}
  		xmlhttp.open("POST","exam_registration.jsp",false);
  		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("extype="+extype+"&exname="+newplan1.exname.value+"&month="+newplan1.month.value+"&ac_yr="+newplan1.ac_yr.value+"&excnt="+newplan1.excnt.value+"&dates="+dates+"&starttime="+starttime+"&endtime="+endtime);
	//document.write("extype="+extype+"&exname="+newplan1.exname.value+"&month="+newplan1.month.value+"&ac_yr="+newplan1.ac_yr.value+"&excnt="+newplan1.excnt.value+"&dates="+dates+"&starttime="+starttime+"&endtime="+endtime);
	var tbranch="";
	var trooms="";
	var tcapacity="";
	var tpriority="";
	for(k=0;k<bid.length;k++)
	{
		for(l=0;l<rid.length;l++)
		{
			if((document.getElementById(rid[l]+""+bid[k]+"val")).value!=""&&(document.getElementById(rid[l]+""+bid[k]+"val")).value!="0")			
			{
				tbranch+=bid[k]+",";
				trooms+=rid[l]+",";
				tcapacity+=(document.getElementById(rid[l]+""+bid[k]+"val")).value+",";
				tpriority+=(document.getElementById("pri"+rid[l]+""+bid[k])).value+",";
			}			
		}
	}
	saveTempBranch(tbranch,trooms,tcapacity,tpriority);
} 
}

function supSeatingPlanFinalStage() 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("load").style.visibility="hidden";
		location.reload();
		popup("Successfull","Your Seating plan Successfully created...",1);
  		}
  	}
  	xmlhttp.open("GET","create_sup_SeatingPlan.jsp",false);
xmlhttp.send();
}
function supBranchData(br,nums) 
{
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
  		}
  	}
  	xmlhttp.open("GET","supBranchData.jsp?bid="+br+"&nums="+nums,false);
xmlhttp.send();
}
/********************************* End Here***********************************************************/

function popup(header,body,pstyle) 
{
var ele=document.createElement("div");
ele.setAttribute("class","popup");
ele.setAttribute("id","popup");
document.body.appendChild(ele);
var popupheader=document.createElement("div");
popupheader.setAttribute("class","pheader");
popupheader.innerHTML=header;
var popupbody=document.createElement("div");
popupbody.setAttribute("class","pbody");
popupbody.setAttribute("id","pbody");
popupbody.innerHTML=body
var pclose=document.createElement("b");	
pclose.setAttribute("class","pclose");
pclose.setAttribute("onclick","document.body.removeChild(document.getElementById('popup'));");
pclose.innerHTML="X"
ele.appendChild(pclose);
ele.appendChild(popupheader);
ele.appendChild(popupbody);
if(pstyle==1)
{
	popupheader.style.backgroundColor="#26ca28"
	var popimg=document.createElement("img");
	popimg.setAttribute("class","popimg")	
	popimg.setAttribute("src","pic/p1.jpg")
	popupbody.appendChild(popimg);	
}
else if(pstyle==2)
{
	popupheader.style.backgroundColor="red"
	var popimg=document.createElement("img");
	popimg.setAttribute("class","popimg")	
	popimg.setAttribute("src","pic/p2.png")
	popupbody.appendChild(popimg);	
}
}

function branchPriorityStatus() 
{
var ele=document.createElement("div");
ele.setAttribute("class","statuspopup");
ele.setAttribute("id","spopup");
document.body.appendChild(ele);
var popupheader=document.createElement("div");
popupheader.setAttribute("class","pheader");
popupheader.innerHTML="Current Status";
var popupbody=document.createElement("div");
popupbody.setAttribute("class","pbody");
popupbody.innerHTML="<table id='statustable1'></table><table id='statustable2'></table>";
var pclose=document.createElement("b");	
pclose.setAttribute("class","pclose");
pclose.setAttribute("onclick","document.body.removeChild(document.getElementById('spopup'));");
pclose.innerHTML="X"
ele.appendChild(pclose);
ele.appendChild(popupheader);
ele.appendChild(popupbody);
var table=document.getElementById("statustable1");
var row=table.insertRow(0);
var c=row.insertCell(0);
c.setAttribute("colspan","2")
c.setAttribute("style","background-color:#085592;font-size:20px;")
c.innerHTML="Rooms Status"
for(var i=0;i<rid.length;i++)
{
	row=table.insertRow(i+1);
	row.insertCell(0).innerHTML=rid[i];
	$(".rmremain"+rid[i]+":first").each(function () {
		c=row.insertCell(1);
		c.innerHTML=$(this).html();		
	});
}
table=document.getElementById("statustable2");
row=table.insertRow(0);
c=row.insertCell(0);
c.setAttribute("colspan","2")
c.setAttribute("style","background-color:#085592;font-size:20px;")
c.innerHTML="Branches Status"
for(var i=0;i<bid.length;i++)
{
	row=table.insertRow(i+1);
	row.insertCell(0).innerHTML=bid[i];
	c=row.insertCell(1);
	if(document.getElementById("remaining"+bid[i]).innerHTML)
	{
		if(parseInt(document.getElementById("remaining"+bid[i]).innerHTML)>0)
			c.innerHTML="Remaining<b>"+(document.getElementById('remaining'+bid[i]).innerHTML)+"</b>";
		else 		
			c.innerHTML="<b style='color:green;font-size:13px;'>Allottment</br/>Completed</b>";
	}
}		
}

function maximize() 
{
var ele=document.getElementById("step-5");
document.getElementById("tabs").style.height="100%";
document.getElementById("rtitle").style.top="32%";
$(".priordiv").css({"height":"400px"});
ele.style.position="fixed";
ele.style.top="0";
ele.style.left="-5px";
ele.style.width="100%";
ele.style.height="98%";
ele.style.zIndex="100"
$(".maxmin").each(function () {
$(this).html("Minimize");
$(this).attr("onclick","minimize()");
});
}
function minimize() 
{
var ele=document.getElementById("step-5");
document.getElementById("tabs").style.height="90%";
document.getElementById("rtitle").style.top="38%";
$(".priordiv").css({"height":"260px"});
ele.style.position="relative";
ele.style.top="0";
ele.style.left="0";
ele.style.width="968px";
ele.style.height="380px";
ele.style.zIndex="0"
$(".maxmin").each(function () {
$(this).html("Maximize");
$(this).attr("onclick","maximize()");
});
}
// End of  new seating plan's Java Script
/************************************************************************************************/
/************************Starting of View Seating plans******************************************/
function getExamBranches(exam,target) 
{
	selectedExam=exam;
	if (window.XMLHttpRequest)
	{
 		xmlhttp=new XMLHttpRequest();
	}
	else
	{	
 		 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target+"branchwise").innerHTML=xmlhttp.responseText;
 			getExamRooms(exam,"total",target+"roomwise");
 		}
  	}
	xmlhttp.open("GET","getExamBranches.jsp?exid="+exam,true);
	xmlhttp.send();
}
function getExamRooms(exam,branch,target) 
{
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML=xmlhttp.responseText;
 		}
  	}
	xmlhttp.open("GET","getExamRooms.jsp?exid="+exam+"&branch="+branch,true);
	xmlhttp.send();
}
function branchSeatingPlan(branch,target) 
{
	var eid=selectedExam.substring(0,3);
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML=xmlhttp.responseText;
 		}
  	}
  	if(eid=="REG")
		xmlhttp.open("GET","reg_branchSeatingPlans.jsp?exid="+selectedExam+"&bid="+branch,true);
	else
		xmlhttp.open("GET","sup_branchSeatingPlans.jsp?exid="+selectedExam+"&bid="+branch,true);		
	xmlhttp.send();
}
function roomSeatingPlan(val,target) 
{
	var eid=selectedExam.substring(0,3);
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML=xmlhttp.responseText;
 		}
  	}
  	if(eid=="REG")
		xmlhttp.open("GET","reg_roomSeatingPlans.jsp?exid="+selectedExam+"&rmid="+val,true);
	else
		xmlhttp.open("GET","sup_roomSeatingPlans.jsp?exid="+selectedExam+"&rmid="+val,true);		
	xmlhttp.send();
}
function getattendanceSheet(target) 
{
	var eid=document.getElementById("examsList").value;
	var rm=document.getElementById("attendanceSheet").value;
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML=xmlhttp.responseText;
 		}
  	}
  	if(eid.substring(0,3)=="REG")
		xmlhttp.open("GET","getattendanceSheet.jsp?exid="+eid+"&rmid="+rm,true);
	else
		xmlhttp.open("GET","sup_attendanceSheet.jsp?exid="+eid+"&rmid="+rm,true);		
	xmlhttp.send();
}
function mandatory(id) 
{
	var ele=document.getElementById(id);
if(ele.value=="")
	document.getElementById("exname").focus()
}
function examsList(target) 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
 			document.getElementById(target).innerHTML =xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","examsList.jsp",true);
xmlhttp.send();
}
function restoreList(target) 
{
if (window.XMLHttpRequest)
{
 		xmlhttp=new XMLHttpRequest();
}
else
{	
 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			document.getElementById(target).innerHTML =xmlhttp.responseText;
 		}
  	}
xmlhttp.open("GET","restoreList.jsp",true);
xmlhttp.send();
}
function restore(exid) 
{
	var loader=document.getElementById("load");
	loader.style.visibility="visible";
	xmlhttp.onreadystatechange=function()
  	{
  		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
 			loader.style.visibility="hidden";
 			var res=$.trim(xmlhttp.responseText).toLowerCase();
 			if(res=="false")
 				popup("Alert","Sorry..We are Unable Restore Now",2)
 			else 
 			{
 				popup("Successful","Examination is Successfully Restored",1)
 				restoreList("content5");
 			}
 		}
  	}
	xmlhttp.open("GET","restore.jsp?exid="+exid,true);
	xmlhttp.send();
}
function deleteExam(exid) 
{
	var ans=window.confirm("All the Examination Details are Permanently Deleted..Do you want to Continue?");
	if(ans)
	{
		xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
 				var res=$.trim(xmlhttp.responseText).toLowerCase();
 				if(res=="false")
 					popup("Alert","Sorry..Deletion Failed",2);
 				else 
 				{
 					popup("Successful","Examination is Successfully Deleted",1);
 					examsList("content4");
 				}
 			}
  		}
		xmlhttp.open("GET","deleteExam.jsp?exid="+exid,true);
		xmlhttp.send();
	}
}
function createBackup(exid) 
{
		xmlhttp.onreadystatechange=function()
  		{
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				var res=$.trim(xmlhttp.responseText).toLowerCase();
 				if(res=="false")
 					popup("Alert","Sorry..We are unable to create Backup",2)
 				else 
 				{
 					popup("Successful","Backup is Successfully created",1)
 					examsList("content4");
 				}
 			}
  		}
		xmlhttp.open("GET","createBackup.jsp?exid="+exid,true);
		xmlhttp.send();
}