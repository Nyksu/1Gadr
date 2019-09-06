<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\connect.inc" -->
<%
function TableRows(HighID,Level,LeadSpace){
	var lines=""
	var tr_tag="<tr><td %width1>%lspace<a href=\"javascript:select(%cid,0,0)\" OnMouseOver=\"window.status='View company profile';return true\" OnMouseOut=\"window.status=''\">%cname</a>&nbsp%id</td> <td %width2> %plus</td> <td %width3> %minus </td></tr>"

	var plus  ="<a href=\"javascript:select(0,%cid,1)\" OnMouseOver=\"window.status='Add child company';return true\" OnMouseOut=\"window.status=''\"><img src=\"images/plus.jpg\" width=\"20\" height=\"20\" border=\"0\" alt=\"Add company... \"></a> "
	var empty  ="<img src=\"images/e2020.jpg\" width=\"20\" height=\"20\" border=\"0\"> "
	var minus="<a href=\"javascript:select(%cid,0,2)\" OnMouseOver=\"window.status='Delete company';return true\" OnMouseOut=\"window.status=''\"><img src=\"images/minus.jpg\" width=\"20\" height=\"20\" border=\"0\" alt=\"Delete company... \"></a> "

	var Recs=Server.CreateObject("ADODB.RecordSet")
	Recs.ActiveConnection=Connect
	Recs.CursorType = 0
	Recs.CursorLocation = 2
	Recs.LockType = 3
	Recs.Source="select id, name from company where deleted=0 and member_id="+Session("UserID")+" and high_id="+HighID
	Recs.Open()
	while(!Recs.EOF){
		var tmp=TableRows(Recs("ID").Value,Level+1,LeadSpace+"     ")
		var trtmp=new String(tr_tag)
		trtmp=trtmp.replace("%plus",Session("UserIsCorp")=="1" ? plus : empty )    
		trtmp=trtmp.replace("%minus",tmp==""? minus : empty)    
		trtmp=trtmp.replace("%cid",Recs("ID").Value)
		trtmp=trtmp.replace("%cid",Recs("ID").Value)
		trtmp=trtmp.replace("%cid",Recs("ID").Value)
		trtmp=trtmp.replace("%lspace",LeadSpace)
		trtmp=trtmp.replace("%cname",Recs("NAME").Value)
		trtmp=trtmp.replace("%id","(ID "+Recs("ID").Value+")")
		trtmp=trtmp.replace("%width1",Level==0?"width=\"94%\"":"")
		trtmp=trtmp.replace("%width2", Level==0?"width=\"3%\"":"")
		trtmp=trtmp.replace("%width3", Level==0?"width=\"3%\"":"")
		lines=lines+trtmp.toString()+tmp
		Recs.MoveNext()
	}
	Recs.Close()
	return lines
}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<title>Company structure.</title>
<script language="JavaScript">
function select(cid,hid,oper){
	document.complist.cid.value=cid
	document.complist.high.value=hid
	if(oper=="0"){document.complist.action="company.asp"}
	if(oper=="1"){document.complist.action="compgen.asp"}
	if(oper=="2"){document.complist.action="compdel.asp"}
	document.complist.submit()
}
</script>
</HEAD>
<BODY BGCOLOR="#ffffff">
<font size="+0"><a href="index.asp"> </a></font> 
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
<center class="doctitle">
  Company structure.
</center>
<form name="complist" method="post" action="">
  <table width="100%" border="1" cellspacing="0">
    <tr> 
      <td bgcolor="#dadffc" colspan="3" class="blueband"> Company hierarhy.</td>
      <% 
var temp=TableRows(0,0,"")
if (temp==""){
%> 
    <tr> 
      <td width="94%"><font face="Arial, Helvetica, sans-serif">No company.</font></td>
      <td width="3%"><a href="javascript:select(0,0,1)" OnMouseOver="window.status='Create company profile';return true" OnMouseOut="window.status=''"><img src="images/plus.jpg" width="20" height="20" border="0" alt="Create first company..."></a></td>
      <td width="3%">&nbsp;</td>
    </tr>
    <%
}
else {Response.Write(temp)}
%> 
    <tr> 
      <td colspan="3" class="blueband"> 
        <div align="center"><a href="area.asp">Back</a></div>
      </td>
    </tr>
  </table>
  <input type="hidden" name="cid">
  <input type="hidden" name="high">
  <input type="hidden" name="back" value="0">
</form>
<font size="+0"><a href="index.asp"> </a></font><br>
<table width="100%" cellpadding="0" bordercolor="#FFFFFF">
  <tr> 
    <td rowspan="3" valign="top" align="center" width="38"><img src="images/Onegard_International_Mark3.gif" width="24" height="30"></td>
    <td colspan="4" bgcolor="#006666" width="952"> 
      <p><font face="Arial, Helvetica, sans-serif" color="#FF9933"><b><font size="-1"> 
        | <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
        Top</font></a> | <a href="index.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Home</font></a> 
        | <a href="area.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Members 
        Area</font></a> | </font></b></font></p>
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
</BODY>
</HTML>
