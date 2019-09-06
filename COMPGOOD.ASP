<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\getform.inc" -->

<%
var cid=Request.Form("cid")
var gid=TextFormData(Request.Form("gid"),"")
var oper=TextFormData(Request.Form("oper"),"")

if (isNaN(parseInt(cid,10))  ){Response.Redirect("complist.asp?cid="+cid)}
isFirst=String(Request.Form("Submit"))=="undefined"
%><!-- #include file="inc\is_comp_ok.inc" --><%
//------------------
	if (oper=="1"){Connect.Execute("delete from j_goods_group where company_id="+cid+" and goods_group_id="+gid)}
	if(oper=="0"){
	try{
		Connect.Execute("insert into j_goods_group(goods_group_id,company_id) values("+gid+","+cid+")")
	}
	catch(e){}
	}

//---------------------------------------
Records.Source="select s.subject, s.id from sp_goods_group s, j_goods_group j where (j.company_id="+cid+")and (j.goods_group_id=s.id) order by 1"
Records.Open()
//--------------------------------------

%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Company main groups of goods <%=oper%></TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="javascript">
function select(o,i,t){
	if(confirm("Delete group?\n\n"+t)){
		document.form.oper.value=o
		document.form.gid.value=i
		document.form.submit()
	}
}
function SetStatus(){
	window.status="Delete group"
	return true
}
function NoStatus(){
	window.status=""
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
<FORM action="compgood.asp" name="form" method="post">
  <input type="hidden" name="cid" value="<%=cid%>">
  <input type="hidden" name="oper" value="">
  <input type="hidden" name="gid" value="">
  <center class="doctitle" >
Modify company profile.
 </center> <br>    
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="102"> 
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
            <td colspan="8" class="blueband">Main groups of product or services</td>
          </tr>
			<%i=0
			while(!Records.EOF){
			title=Records("SUBJECT").Value
			%>
          <tr <%= i%2==0?"bgcolor=\"#F4F4F4\"":""%>> 
            <td class="fielddata" width="96%" height="7" ><%=i+1+". "+title%></td>
            <td width="4%" height="7" ><a href="javascript:select(1,<%=Records("ID").Value+",'"+title+"'"%>)" OnMouseOver="return SetStatus()" OnMouseOut="NoStatus()">Delete</a></td>
          </tr>
			<%i++
			Records.MoveNext()
			}%>
          <tr> 
            <td class="fieldtitle_L" colspan="4" >
	<a href="javascript:document.form.action='selggrp.asp';document.form.submit()" OnMouseOver="window.status='Add group';return true" OnMouseOut="window.status=''">Add group</a>
	</td>
          </tr>
        </table>
        <center>
          <input type="Button" name="back" value="Back" OnClick="document.form.action='company.asp#good';document.form.submit()">
        </center>
        </td>
    </tr>
  </table>
  </FORM>

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
</BODY>
</HTML>
