<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<%
var ErrorMsg=""
var cid=Request.Form("cid")
var pid=TextFormData(Request.Form("pid"),"")
var oper=TextFormData(Request.Form("oper"),"")

if (isNaN(parseInt(cid,10))  ){Response.Redirect("complist.asp")}
isFirst=String(Request.Form("Submit"))=="undefined"
%><!-- #include file="inc\is_comp_ok.inc" --><%
if(!isFirst){
		if(oper=="0"||oper=="1"){
				if(String(Request.Form("pname"))!="undefined" && Request.Form("pname")!="" ) {
					if (oper=="0"){sql="insert into  person(id,company_id,name,person_position,phone,e_mail) values(gen_id(universal,1),%cid,'%name','%position','%phone','%email')"}
					else {sql="update person set name='%name', person_position='%position',phone='%phone',e_mail='%email' where id=%pid and company_id=%cid"}
					sql=sql.replace('%name',Request.Form("pname"))
					sql=sql.replace('%position',Request.Form("position"))
					sql=sql.replace('%phone',Request.Form("phone"))
					sql=sql.replace('%email',Request.Form("email"))
					sql=sql.replace('%cid',cid)
					sql=sql.replace('%pid',pid)
					Connect.Execute(sql)
					oper=""
				}
				else{ErrorMsg="Name is reqiured."}
		}
		if(oper=="2"){
			Connect.Execute("delete from person where id="+pid+" and company_id="+cid)
			oper=""
		}
}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Modify company represintatives</TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="javascript">
function select(o,p){
	document.form.oper.value=o
	document.form.pid.value=p
	document.form.submit()
}
function check(){
	if(document.form.pname.value==""){alert("Name is reqiured."); return false}
  return true
}

</script>

</HEAD>
<BODY BGCOLOR="#ffffff">
<table width="100%" cellpadding="0" bordercolor="#FFFFFF">
  <tr> 
    <td valign="top" align="center" width="38"><img src="images/Onegard_International_Mark3.gif" width="24" height="30"></td>
    <td colspan="4" bgcolor="#006666" width="952"> 
      <p><font face="Arial, Helvetica, sans-serif" color="#FF9933"><b><font size="-1"> 
        <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
        </font></a> | <a href="index.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Home</font></a> 
        | <a href="area.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Members 
        Area</font></a> | <a href="complist.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Company 
        structure</font></a> |</font></b></font></p>
    </td>
  </tr>
</table>
<br>
<FORM action="comprep.asp" name="form" method="post" <%if(oper=="0" || oper=="1"){%>OnSubmit="return check()"<%}%>>
  <input type="hidden" name="cid" value="<%=cid%>">
  <input type="hidden" name="pid" value="<%=pid%>">
  <input type="hidden" name="oper" value="<%=oper%>">
  <center class="doctitle" >
<%
if(oper==""){Response.Write("Modify company profile.")}
if(oper=="0"){Response.Write("Create person.")}
if(oper=="1"){Response.Write("Edit person.")}
if(oper=="2"){Response.Write("Are you sure you want to delete person?")}
%>
     </center> <br>
   
  <%
		if(ErrorMsg!=""){%> 
  <h3 align="center"> <font color="#FF3333">Processing error<br>
    </font><font color="#1e4a7b"><%=ErrorMsg%></font><br>
  </h3>
<%
}
//-----------get representatives
if(oper==""){
Records.Source="select * from person where company_id="+cid+" order by name"
Records.Open()
%>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="146"> 
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="2" class="blueband"> 
              <p>General information</p>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%" height="2">Company name:</td>
            <td class="fielddata" height="2"><%=compname%></td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="6" class="blueband">Representatives</td>
          </tr>
          <tr> 
            <td class="fieldtitle_L" width="24%">Name</td>
            <td class="fieldtitle_L" width="36%">Position</td>
            <td class="fieldtitle_L" width="14%">Phone</td>
            <td class="fieldtitle_L" width="16%">E-Mail</td>
            <td class="fieldtitle_L" width="4%">&nbsp;</td>
            <td class="fieldtitle_L" width="6%">&nbsp;</td>
          </tr>
          <%i=0
	while(!Records.EOF){%> 
          <tr <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>> 
            <td class="fielddataST" width="24%" height="21"><%=Records("NAME").Value%></td>
            <td class="fielddataST" width="36%" height="21"><%=Records("PERSON_POSITION").Value%></td>
            <td class="fielddataST" width="14%" height="21"><%=Records("PHONE").Value%></td>
            <td class="fielddataST" width="16%" height="21"><%=Records("E_MAIL").Value%></td>
            <td class="fieldtitle_L" width="4%" height="21">
			<a OnMouseOver="window.status='Edit person';return true" 
			href="javascript:select('1','<%=Records("ID").Value%>')"
			OnMouseOut="window.status=''">edit</a></td>
            <td class="fieldtitle_L" width="6%" height="21">
			<a OnMouseOver="window.status='Delete person';return true" 
			href="javascript:select('2','<%=Records("ID").Value%>')"
			OnMouseOut="window.status=''">delete</a></td>
          </tr>
          <%i++;Records.MoveNext()}%> 
          <tr> 
            <td colspan="6"><a OnMouseOver="window.status='Add person';return true" 
			href="javascript:select('0','0')"
			OnMouseOut="window.status=''">Add person</a></td>
          </tr>
        </table>
        <center>
          <input type="Button" name="back" value="Back" OnClick="document.form.action='company.asp#rep';document.form.submit()">
        </center>
        </td>
    </tr>
  </table>
  <h5><%}// if oper==""
if(oper=="0" ||oper=="1"){
		if (oper=="1" && isFirst){
			Records.Source="select * from person where company_id="+cid+" and id="+pid
			Records.Open()
			if(Records.EOF){Response.Redirect("company.asp?cid="+cid)}
		}
%> <br>
  </h5>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="146"> 
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="2" class="blueband"> 
              <p>General information</p>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%" height="2">Company name:</td>
            <td class="fielddata" height="2"><%=compname%></td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="6" class="blueband">Person information</td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%">Name:</td>
            <td class="fieldtitle_L" colspan="5">
              <input type="text" name="pname" size="35" value="<%=oper=="1"? isFirst?Records("NAME").Value:Request.Form("pname"):""%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Position:</td>
            <td class="fieldtitle_L" colspan="5">
              <input type="text" name="position" size="35" value="<%=oper=="1"? isFirst?Records("PERSON_POSITION").Value:Request.Form("position"):""%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Phone:</td>
            <td class="fieldtitle_L" colspan="5">
              <input type="text" name="phone" size="35" value="<%=oper=="1"? isFirst?Records("PHONE").Value:Request.Form("phone"):""%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">E-mail:</td>
            <td class="fieldtitle_L" colspan="5">
              <input type="text" name="email" size="35" value="<%=oper=="1"? isFirst?Records("E_MAIL").Value:Request.Form("email"):""%>">
            </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" name="cancel" value="Cancel" onClick="document.form.oper.value='';document.form.pid.value='';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
  <%}// if oper= ins or edit
if(oper=="2"){
			Records.Source="select * from person where company_id="+cid+" and id="+pid
			Records.Open()
			if(Records.EOF){Response.Redirect("company.asp?cid="+cid)}
%> 
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="146"> 
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="2" class="blueband"> 
              <p>General information</p>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%" height="2">Company name:</td>
            <td class="fielddata" height="2"><%=compname%></td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="6" class="blueband">Person information</td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%">Name:</td>
            <td class="fielddata" colspan="5"> <%=Records("NAME").Value%> 
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Position:</td>
            <td class="fielddata" colspan="5"> <%=Records("PERSON_POSITION").Value%> 
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Phone:</td>
            <td class="fielddata" colspan="5"> <%=Records("PHONE").Value%> 
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">E-mail:</td>
            <td class="fielddata" colspan="5"> <%=Records("E_MAIL").Value%> 
            </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit" >
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="button" name="cancel2" value="Cancel" onClick="document.form.oper.value='';document.form.pid.value='';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
  <%}// if oper= del%> 
  <table width="100%" cellpadding="0" bordercolor="#FFFFFF">
    <tr> 
      <td rowspan="3" valign="top" align="center" width="38"><img src="images/Onegard_International_Mark3.gif" width="24" height="30"></td>
      <td colspan="4" bgcolor="#006666" width="952"> 
        <p><font face="Arial, Helvetica, sans-serif" color="#FF9933"><b><font size="-1"> 
          | <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
          Top</font></a> | <a href="index.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Home</font></a> 
          | <a href="area.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Members 
          Area</font></a> | <a href="complist.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Company 
          structure</font></a> |</font></b></font></p>
      </td>
    </tr>
    <tr align="center"> 
      <td colspan="4" width="952"> 
        <h4><font size="-1"><a href="index.asp"><font face="Arial, Helvetica, sans-serif" size="-5">1GARD 
          Network Home</font></a><font face="Arial, Helvetica, sans-serif" size="-5"> 
          | <a href="business%20news.htm">Business News</a> | <a href="business_search.asp">Business 
          Search</a> | <a href="international%20business%20promotion.htm">Promote 
          Your Business</a> | <a href="international%20marketing%20researches.htm">Marketing 
          surveys</a>| <a href="demographic_statistics.htm">MARKETCHART <sup><font size="-1">sm</font></sup> 
          Program </a> |</font></font></h4>
      </td>
    </tr>
    <tr valign="middle" align="center"> 
      <td colspan="4" width="952"> 
        <h5><font size="-4" face="Arial, Helvetica, sans-serif">&copy; 2000, 2001 Onegard 
          International Business LLC, USA</font></h5>
      </td>
    </tr>
  </table>
  <p>&nbsp; </p>
</FORM>

</BODY>
</HTML>
