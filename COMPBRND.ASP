<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\next_id.inc" -->
<!-- #include file="inc\dict_val.inc" -->
<!-- #include file="inc\err.inc" -->


<%
var ErrorMsg=""
var cid=Request.Form("cid")
var bid=TextFormData(Request.Form("bid"),"")
var oper=TextFormData(Request.Form("oper"),"")

if (isNaN(parseInt(cid,10))  ){Response.Redirect("complist.asp")}
isFirst=String(Request.Form("Submit"))=="undefined"
%><!-- #include file="inc\is_comp_ok.inc" --><%
//----apply updates---------
if(!isFirst){
	//----check values--------
	if(oper=="0"||oper=="1"){
		bname=StrFormData(Request.Form("bname"))
		if(bname==null){ErrorMsg="Name is reqiured."}
		else{
			Connect.BeginTrans()
			try{
				if(bid!=0){Connect.Execute("delete from j_brandname where brandnames_id="+bid+" and company_id="+cid)}
				bid=DictValue("sp_brandname","name",bname,"")
				Records.Source="select count(*) as cnt from j_brandname where company_id="+cid+" and brandnames_id="+bid
				Records.Open()
				if(Records("CNT").Value==0){
					Connect.Execute("insert into j_brandname(brandnames_id,company_id,is_self_make) values("+bid+","+cid+","+TextFormData(Request.Form("status"),"0")+")")
				}
				Records.Close()
				oper=""
				Connect.CommitTrans()
			}
			catch(e){
				ErrorMsg+=ListAdoErrors()
				Connect.RollbackTrans()
			}
		}
	}
	if(oper=="2"){
		Connect.Execute("delete from j_brandname where brandnames_id="+bid+" and company_id="+cid)
		oper=""
	}
}
//-------------------------------
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Modify company owned brandnames</TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="javascript">
function select(o,p){
	document.form.oper.value=o
	document.form.bid.value=p
	document.form.submit()
}
function check(){
	if(document.form.bname.value==""){alert("Name is reqiured."); return false}
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
<FORM action="compbrnd.asp" name="form" method="post" <%if(oper=="0" || oper=="1"){%>OnSubmit="return check()"<%}%>>
  <input type="hidden" name="cid" value="<%=cid%>">
  <input type="hidden" name="bid" value="<%=bid%>">
  <input type="hidden" name="oper" value="<%=oper%>">
  <center class="doctitle" >
<%
if(oper==""){Response.Write("Modify company profile.")}
if(oper=="0"){Response.Write("Add brandname.")}
if(oper=="1"){Response.Write("Edit brandname.")}
if(oper=="2"){Response.Write("Are you sure you want to delete brandname?")}
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
Records.Source="select s.id, s.name, j.is_self_make from sp_brandname s, j_brandname j where (j.company_id="+cid+")and (j.brandnames_id=s.id) order by name"
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
            <td colspan="4" class="blueband">Trademarks &amp; Servicemarks</td>
          </tr>
          <tr> 
            <td class="fieldtitle_L" width="57%">Name</td>
            <td class="fieldtitle_L" >Statement of federal or international USE</td>
            <td class="fieldtitle_L" width="3%">&nbsp;</td>
            <td class="fieldtitle_L" width="13%">&nbsp;</td>
          </tr>
          <%i=0
	while(!Records.EOF){%> 
          <tr <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>> 
            <td class="fielddataST" width="57%" height="21"><%=Records("NAME").Value%></td>
            <td class="fielddataST"  height="21"><%=Records("IS_SELF_MAKE").Value==0?"In use":"Bona fide intention to use"%></td>
            <td class="fieldtitle_L" width="3%" height="21"> <a OnMouseOver="window.status='Edit brandname';return true" 
			href="javascript:select('1','<%=Records("ID").Value%>')"
			OnMouseOut="window.status=''">edit</a></td>
            <td class="fieldtitle_L" width="13%" height="21"> <a OnMouseOver="window.status='Delete brandname';return true" 
			href="javascript:select('2','<%=Records("ID").Value%>')"
			OnMouseOut="window.status=''">delete</a></td>
          </tr>
          <%i++;Records.MoveNext()}%> 
          <tr> 
            <td colspan="4"><a OnMouseOver="window.status='Add brandname';return true" 
			href="javascript:select('0','0')"
			OnMouseOut="window.status=''">Add brandname</a></td>
          </tr>
        </table>
        <center>
          <input type="Button" name="back" value="Back" OnClick="document.form.action='company.asp#brand';document.form.submit()">
        </center>
        </td>
    </tr>
  </table>
  <h5><%}// if oper==""
if(oper=="0" ||oper=="1"){
		if (oper=="1" && isFirst){
			Records.Source="select s.id, s.name, j.is_self_make from sp_brandname s, j_brandname j where (j.company_id="+cid+")and (j.brandnames_id=s.id) and s.id="+bid
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
            <td colspan="6" class="blueband">Trademarks &amp; Servicemarks</td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%">Name:</td>
            <td class="fieldtitle_L" colspan="5"> 
              <input type="text" name="bname" size="35" value="<%=!isFirst?Request.Form("bname"):oper==1?Records("NAME").Value:""%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Statement of federal or international USE:</td>
            <td class="fieldtitle_L" colspan="5"> 
              <select name="status">
                <option value="0">In use</option>
                <option value="1">Bona fide intention to use</option>
              </select>
            </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" name="cancel" value="Cancel" onClick="document.form.oper.value='';document.form.bid.value='';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
  <%}// if oper= ins or edit
if(oper=="2"){
			Records.Source="select s.id, s.name, j.is_self_make from sp_brandname s, j_brandname j where (j.company_id="+cid+")and (j.brandnames_id=s.id) and s.id="+bid
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
            <td colspan="2" class="blueband">Person information</td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%">Name:</td>
            <td class="fielddata" > <%=Records("NAME").Value%> 
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Status:</td>
            <td class="fielddata" > <%=Records("IS_SELF_MAKE").Value==0?"In use":"Bona fide intention to use"%>
            </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit" >
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="button" name="cancel2" value="Cancel" onClick="document.form.oper.value='';document.form.bid.value='';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
  <%}// if oper= del%> 
  <p>&nbsp; </p>
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
</FORM>

</BODY>
</HTML>
