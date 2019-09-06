<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<%
var Submit=String(Request.Form("Submit"))
var cid=Request.Form("cid")
if (Submit=="Back" || isNaN(parseInt(cid,10)) ||
   (Submit=="undefined"&& cid=="" ) ||
   (Submit=="Submit" && cid=="") ){Response.Redirect("complist.asp")}

var isFirst=Submit=="undefined"
var ShowForm=true
// is given cid is correct
%><!-- #include file="inc\is_comp_ok.inc" --><%

//select count subcompanys
tmp=new String("select count(*) as cnt  from company where member_id=%mem_id and high_id=%cid")
tmp=tmp.replace("%mem_id",Session("UserID"))
tmp=tmp.replace("%cid",cid)
Records.Source=tmp.toString()
Records.Open()
if (Records("CNT").Value>0){Response.Redirect("complist.asp")}
Records.Close()

if(!isFirst){
		tmp=new String("update  company  set deleted=1 where member_id=%mem_id and id=%cid")
		tmp=tmp.replace("%mem_id",Session("UserID"))
		tmp=tmp.replace("%cid",cid)
		Connect.Execute(tmp)
		Response.Redirect("complist.asp")
}

%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Delete company</TITLE>
<style type="text/css">
<!--
.blueband { background-color: #dadffc }
-->
</style>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
</HEAD>
<BODY BGCOLOR="#ffffff">
<p class="banner"><b><a href="index.asp">1GARD  RESEARCH NETWORK</a></b></p>
<center class="doctitle">Are you sure you want to delete company?</center> 
<form name="delform" method="post" action="compdel.asp">
  <table width="100%" border="0" cellspacing="0">
    <tr> 
      <td colspan="2" class="blueband"> <b>Delete company.</b> </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td width="9%" class="fieldtitle">Company:</td>
      <td width="91%" class="fielddata"><%=compname%></td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2" class="blueband"> 
        <div align="center"> 
          <input name="Submit" type="submit" value="Submit">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input name="Submit" type="submit" value="Back">
        </div>
      </td>
    </tr>
  </table>
  <input type="hidden" name="cid" value="<%=cid%>">
</form>
<h1 align="center">&nbsp;</h1>
</BODY>
</HTML>
