<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<%
var ShowForm=true
var ErrorMsg=""
var isFirst=(String(Request.Form("RegSubmit"))=="undefined")
if (!isFirst){
		while(1){
			if (Request.Form("contactname") == "") {ErrorMsg="Contact representative  is not specified.";break}
			if (Request.Form("email") == "") {ErrorMsg="E-mail  is not specified.";break}
			if (Request.Form("address") == "") {ErrorMsg="Post address  is not specified.";break}
			var re = new RegExp("(\\w+)@((\\w+).)*(\\w+)$")
			if (!re.test(Request.Form("email"))){ErrorMsg="E-mail  is not  valid.";break}%>
			<!-- #include file="inc\records.inc" -->
<%
			var SqlStr=new String("update member set member_fio='%member_fio', e_mail='%e_mail', phone='%phone', "+
								"phone2='%phone2',  address='%address', fax='%fax'  where id=%id ")

			SqlStr=SqlStr.replace("%id",Session("UserID"))
			SqlStr=SqlStr.replace("%member_fio",Request.Form("contactname"))
			SqlStr=SqlStr.replace("%e_mail", Request.Form("email"))
			SqlStr=SqlStr.replace("%phone", Request.Form("phone1"))
			SqlStr=SqlStr.replace("%phone2", Request.Form("phone2"))
			SqlStr=SqlStr.replace("%address", Request.Form("address"))
			SqlStr=SqlStr.replace("%fax", Request.Form("fax"))
			Connect.Execute(SqlStr)

			Session("UserFIO")=String(Request.Form("contactname"))
			Session("UserEmail")=String(Request.Form("email"))
			Session("UserPhone")=String(Request.Form("phone1"))
			Session("UserPhone2")=String(Request.Form("phone2"))
			Session("UserFax")=String(Request.Form("fax"))
			Session("UserAddress")=String(Request.Form("address"))
			ShowForm=false
			break
		}


 
		//if (ErrorMsg=="" ){Response.Redirect("area.asp")}
}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Modify account information</TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="JavaScript">
function check(){
if (document.form.contactname.value==""){
	alert("Contact name requred.")
	document.form.contactname.focus()
	return false
}
if (document.form.email.value==""){
	alert("E-mail requred.")
	document.form.email.focus()
	return false
}
var re = new RegExp("(\\w+)@((\\w+).)*(\\w+)$")
if (!re.test(document.form.email.value)){
	alert("Invalid e-mail address.")
	document.form.email.focus()
	return false
}

if (document.form.address.value==""){
	alert("Address requred.")
	document.form.address.focus()
	return false
}
return true
}
</script>
</HEAD>
<BODY BGCOLOR="#ffffff">
<font face="Arial, Helvetica, sans-serif"><a name="top"></a></font>
<table width="100%" cellpadding="0" bordercolor="#FFFFFF">
  <tr> 
    <td valign="top" align="center" width="38"><img src="images/Onegard_International_Mark3.gif" width="24" height="30"></td>
    <td colspan="4" bgcolor="#006666" width="952"> 
      <p><font face="Arial, Helvetica, sans-serif" color="#FF9933"><b><font size="-1"> 
        <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
        </font></a> | <a href="index.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Home</font></a> 
        | <a href="area.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Members 
        Area</font></a> | </font></b></font></p>
    </td>
  </tr>
</table>
<br>
<% if (ShowForm){ %> 
<FORM name="form" METHOD="post" ACTION="account.asp" OnSubmit="return check()">
  <center class="doctitle">Modify account information.</center> 
  <%if (  !isFirst ) {%> 
  <hr align="center">
  <h3 align="center"><FONT COLOR="#ff0000">Proccesing error!</FONT><FONT
 COLOR="#1d8971"><BR>
    <%=ErrorMsg%></FONT> 
  </h3>
  <%   }    %> 
  <font size="-1"> 
  <hr align="center">
  </font> 
  <P> 
  <TABLE BORDER="0" CELLSPACING="6" CELLPADDING="0"
WIDTH="97%" HEIGHT="240">
    <CAPTION ALIGN="TOP"> 
    <P ALIGN=LEFT>*-required fields 
    </CAPTION>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="23" class="blueband"> <B>&nbsp;Contact 
        information</B></TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" VALIGN="TOP" ALIGN="RIGHT" HEIGHT="2" class="fieldtitle"> 
        The contact representative of company</TD>
      <TD WIDTH="66%" VALIGN="TOP" HEIGHT="2"> 
        <INPUT NAME="contactname" TYPE="text" SIZE="31" value="<%=isFirst?Session("UserFIO"):Request.Form("contactname")%>">
        * </TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" VALIGN="TOP" class="fieldtitle" HEIGHT="5"> Contact e-mail:</TD>
      <TD WIDTH="66%" VALIGN="TOP" HEIGHT="5"> 
        <INPUT NAME="email" TYPE="text" SIZE="31" value="<%=isFirst?Session("UserEmail"):Request.Form("email")%>">
        *</TD>
    </TR>
    <TR> 
      <TD VALIGN="TOP" ALIGN="RIGHT" WIDTH="34%" HEIGHT="2" class="fieldtitle"> 
        Contact phone: </TD>
      <TD WIDTH="66%" VALIGN="TOP" HEIGHT="2"> 
        <INPUT NAME="phone1" TYPE="text" SIZE="31" value="<%=isFirst?Session("UserPhone"):Request.Form("phone1")%>">
        
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" HEIGHT="2" class="fieldtitle"> Second phone: </TD>
      <TD WIDTH="66%" HEIGHT="2"> 
        <INPUT NAME="phone2" TYPE="text" SIZE="31" value="<%=isFirst?Session("UserPhone2"):Request.Form("phone2")%>">
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" HEIGHT="2" class="fieldtitle"> Fax: </TD>
      <TD WIDTH="66%" HEIGHT="2"> 
        <INPUT NAME="fax" TYPE="text" SIZE="31" value="<%=isFirst?Session("UserFax"):Request.Form("fax")%>">
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" HEIGHT="2" class="fieldtitle"> Post address: </TD>
      <TD WIDTH="66%" HEIGHT="2"> 
        <INPUT NAME="address" TYPE="text" SIZE="54" value="<%=isFirst?Session("UserAddress"):Request.Form("address")%>">
        *</TD>
    </TR>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="2" class="blueband"> 
         
        <CENTER>
        
            <INPUT NAME="RegSubmit" TYPE="submit" VALUE="Submit">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <INPUT NAME="Button" TYPE="button" VALUE="Back" OnClick="document.form.action='area.asp';document.form.submit()">
           
        </CENTER>
      </TD>
    </TR>
  </TABLE>
</FORM>
<%}
else{
%> <span class="doctitle"><center>Account information 
successfully changed.</center></span> 
<table border="0" cellspacing="6" cellpadding="0"
width="97%" height="220">
  <caption align="TOP"> 
  <p align=LEFT>&nbsp; 
  </caption>
  <tr> 
    <td colspan="2" bgcolor="#dadffc" height="23" class="blueband"> <b>&nbsp;Contact 
      information</b></td>
  </tr>
  <tr> 
    <td width="34%" valign="TOP" align="RIGHT" height="2" class="fieldtitle"> 
      The contact representative of company:</td>
    <td width="66%" valign="TOP" height="2" class="fielddata"> <%=Session("UserFIO")%> 
       </td>
  </tr>
  <tr> 
    <td width="34%" valign="TOP" align="RIGHT" height="2" class="fieldtitle"> 
      Contact e-mail:</td>
    <td width="66%" valign="TOP" height="2" class="fielddata"><%=Session("UserEmail")%></td>
  </tr>
  <tr> 
    <td valign="TOP" align="RIGHT" width="34%" height="2"> 
      <p class="fieldtitle">Contact phone:</p>
    </td>
    <td width="66%" valign="TOP" height="2" class="fielddata"> <%=Session("UserPhone")%> 
    </td>
  </tr>
  <tr> 
    <td width="34%" height="2"> 
      <p align=RIGHT class="fieldtitle">&nbsp;Second phone: 
    </td>
    <td width="66%" height="2" class="fielddata"><%=Session("UserPhone2")%> 
    </td>
  </tr>
  <tr> 
    <td width="34%" height="2"> 
      <p align=RIGHT class="fieldtitle">&nbsp;Fax: 
    </td>
    <td width="66%" height="2" class="fielddata"><%=Session("UserFax")%></td>
  </tr>
  <tr> 
    <td width="34%" height="2"> 
      <p align=RIGHT class="fieldtitle">&nbsp;Post address: 
    </td>
    <td width="66%" height="2" class="fielddata"><%=Session("UserAddress")%></td>
  </tr>
  <tr bgcolor="#dadffc"> 
    <td colspan="2" class="blueband"> 
      <div align="center"><a href="area.asp">Continue</a> </div>
    </td>
  </tr>
</table>
<%}%> 
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
<h1 align="center">&nbsp;</h1>
</BODY>
</HTML>
