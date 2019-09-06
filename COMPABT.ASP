<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\path.inc" -->


<%
var ErrorMsg=""
var cid=Request.Form("cid")
if (isNaN(parseInt(cid,10))  ){Response.Redirect("complist.asp")}
isFirst=String(Request.Form("Submit"))=="undefined"
%><!-- #include file="inc\is_comp_ok.inc" --><%
var filename=TextFilePath+cid+AboutExt
var text="", ts
var fs= new ActiveXObject("Scripting.FileSystemObject")
//-----------get features text
try{
	ts= fs.OpenTextFile(filename,1)
	text=ts.ReadAll()
	ts.Close()
}
catch(e){}

//----apply updates
if(!isFirst){
	newtext=TextFormData(Request.Form("textinfo"),"")
	if (newtext.length<=8000){
		if(text!=newtext){
			if(fs.FileExists(filename)){fs.DeleteFile(filename)}
			ts= fs.OpenTextFile(filename,2,true)
			ts.Write(newtext)
			ts.Close()
		}
		Response.Redirect("company.asp?cid="+cid)
	}
	ErrorMsg="Text can't be more than 8000 characters."
	text=newtext
}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Modify company about information</TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
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
<FORM action="compabt.asp" name="form" method="post">
  <input type="hidden" name="cid" value="<%=cid%>">
  <center class="doctitle">
    Modify company profile. 
  </center> 
   <%if(ErrorMsg!=""){%> 
  <h3 align="center"> <font color="#FF3333">Processing error<br>
    </font><font color="#1e4a7b"><%=ErrorMsg%></font><br>
  </h3>
<%}%>
  <br>
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
            <td class="blueband" colspan="2"> 
              <p>About company</p>
            </td>
          </tr>
          <tr class="fieldtitle_L"> 
            <td colspan="2" class="fieldtitle_L" >
              <center>
                <textarea name="textinfo" cols="70" rows="20"><%=text%></textarea>
              </center>
            </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
          <input type="button" name="Back" value="Back" OnClick="document.form.action='company.asp';document.form.submit()">
        </center>
        </td>
    </tr>
  </table>
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
        <h5><font size="-4" face="Arial, Helvetica, sans-serif">&copy; 2000, 2001 Onegard International Business LLC, USA</font></h5>
      </td>
    </tr>
  </table>
</FORM>

</BODY>
</HTML>
