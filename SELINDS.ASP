<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<%
var ErrorMsg=""
var cid=Request.Form("cid")
var iid=TextFormData(Request.Form("iid"),"0")
var oper=TextFormData(Request.Form("oper"),"0")
//---------------------------------------
Records.Source="select * from branch_list("+iid+","+oper+") order by subject "
Records.Open()
//--------------------------------------

%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Select company industries</TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="javascript">
function select(i){
		document.form.oper.value="0"
		document.form.iid.value=i
		document.form.action="compind.asp"
		document.form.submit()
}
function list(o,i){
		document.form.oper.value=o
		document.form.iid.value=i
		document.form.submit()
}

function SetStatus(i){
if(i==1){window.status="List industries"}
if(i==2){window.status="Select industry"}
	return true
}
function NoStatus(){
	window.status=""
}
</script>
</HEAD>
<BODY BGCOLOR="#ffffff">
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td width="33%" height="2"> <font size="+0"><a href="index.asp">Home</a></font></td>
    <td width="33%" height="2"> 
      <div align="center"><a href="area.asp">Members 
        area </a></div>
    </td>
    <td height="2"> 
      <div align="right"><a href="complist.asp">Company structure</a></div>
    </td>
  </tr>
</table>
<br>
<FORM action="selinds.asp" name="form" method="post">
  <input type="hidden" name="cid" value="<%=cid%>">
  <input type="hidden" name="oper" >
  <input type="hidden" name="iid">
  <center class="doctitle" >
    Select industry. 
  </center>
  <br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="30"> 
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="8" class="blueband">Available industries</td>
          </tr>
          <%i=0
			while(!Records.EOF){
			title=Records("SUBJECT").Value
			fparams=(Records("ID").Value==-1?-1:0)+","+(Records("ID").Value==-1?Records("HIGH_ID").Value:Records("ID").Value)
			%> 
          <tr <%= i%2==0?"bgcolor=\"#F4F4F4\"":""%>> 
            <td class="fielddata" width="96%" height="7" >
				<%if(Records("SUBTREE").Value==1){%>
				<a href="javascript:list(<%=fparams%>)" OnMouseOver="return SetStatus(1)" OnMouseOut="NoStatus()"><%=title%></a>
				<%}
				else{%><%=title%><%}%>
				</td>
            <td width="4%" height="7" >
				<%if(Records("SUBTREE").Value!=1){%>
				<a href="javascript:select(<%=Records("ID").Value%>)" OnMouseOver="return SetStatus(2)" OnMouseOut="NoStatus()">Select</a>
				<%}%>
				</td>
          </tr>
          <%i++
			Records.MoveNext()
			}%> 
        </table>
        <center>
          <input type="Button" name="back" value="Back" OnClick="document.form.action='compind.asp';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
  </FORM>

</BODY>
</HTML>
