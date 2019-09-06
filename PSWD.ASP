<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<%
//if (String(Request.Form("RegSubmit"))=="Back"){Response.Redirect("area.asp")}
var ErrorMsg=""
var ShowForm=true
var isFirst=(String(Request.Form("RegSubmit"))=="undefined")
if (!isFirst){
		while(1){
			if ( (String( Request.Form("password1")) != String(Request.Form("password2")) ||  Request.Form("password1"))=="" ){
				ErrorMsg="Password does not match."
				break
			}
			if (String(Request.Form("password1")).length<5){ErrorMsg="Password must be at least 5 characters.";break}%>
			<!-- #include file="inc\records.inc" -->
<%
			var SqlStr=new String("update member set psw='%psw'  where id=%id ")

			SqlStr=SqlStr.replace("%id",Session("UserID"))
			SqlStr=SqlStr.replace("%psw",Request.Form("password1"))
			Connect.Execute(SqlStr)
			ShowForm=false
			break
		}


 
		//if (ErrorMsg=="" ){Response.Redirect("area.asp")}
}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Modify members password</TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="javascript">
function check(){
if (document.form.password1.value!=document.form.password2.value ||  document.form.password1.value==""){
	alert("Password is not match.")
	document.form.password1.focus()
	return false
}
if (String(document.form.password1.value).length<5){
	alert("Password must be at least 5 characters.")
	document.form.password1.focus()
	return false
}
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
        Area</font></a> |</font></b></font></p>
    </td>
  </tr>
</table>
<br>
<%if (ShowForm){%> 
<FORM NAME="form" METHOD="post" ACTION="pswd.asp" OnSubmit="return check()">
  <center class="doctitle">
    Modify members password. 
  </center>
  <p><%if (  !isFirst ) {%> 
  </p>
  <p><font size="-1"> </font></p>
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
WIDTH="97%" HEIGHT="11">
    <CAPTION ALIGN="TOP"> 
    <P ALIGN=LEFT>*-required fields 
    </CAPTION>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="23" class="blueband"> &nbsp;Members 
        password</TD>
    </TR>
    <TR> 
      <TD class="fieldtitle" width="30%"> New password:</td>
      <TD > 
        <INPUT NAME="password1" TYPE="password" SIZE="31">
        * </td>
    </TR>
    <TR> 
      <TD class="fieldtitle"> Conform new password:</td>
      <TD > 
        <INPUT NAME="password2" TYPE="password" SIZE="31">
        *</td>
    </TR>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="8"> 
        <CENTER>
          <INPUT NAME="RegSubmit" TYPE="submit" VALUE="Submit">
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <INPUT NAME="Button" TYPE="button" VALUE="Back" OnClick="document.form.action='area.asp';document.form.submit()">
        </CENTER>
      </TD>
    </TR>
  </TABLE>
</FORM>
<%}
else {%>
<table border="0" cellspacing="6" cellpadding="0"
width="97%" height="109">
  <caption align="TOP"> 
  <p align=LEFT>&nbsp; 
  </caption>
  <tr> 
    <td  height="36" class="blueband">&nbsp; </td>
  </tr>
  <tr> 
    <td height="36"> 
      <h1 align="center">&nbsp; </h1>
    </td>
  </tr>
  <tr> 
    <td  height="36" class="doctitle"> Members password successfully 
      changed. </td>
  </tr>
  <tr> 
    <td height="36"> 
          </td>
  </tr>
  <tr> 
    <td  height="36" class="blueband"> 
      <center>
        <h4><a href="area.asp">Continue</a></h4>
      </center>
    </td>
  </tr>
</table>
<p><%}%> 
</p>
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
</BODY>
</HTML>
