<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<%
var ErrorMsg=""
var cid=Request.Form("cid")
var pid=TextFormData(Request.Form("pid"),"")
var oper=TextFormData(Request.Form("oper"),"")
var oper_0_with_state=false;
var oper_prev;

if (isNaN(parseInt(cid,10))  ){Response.Redirect("area.asp")}
isFirst=String(Request.Form("Submit"))=="undefined"
//--- is company ok and get company data ---
Records.Source="select c.name , c.discount_state_id, s.name as discount_state from company c, sp_discount_state s "+
			"where c.discount_state_id=s.id and c.member_id="+Session("UserID")+
			" and c.id="+cid+" and c.deleted=0"
Records.Open()
if (Records.EOF){Response.Redirect("complist.asp")}
var compname=Records("NAME").Value
var discount_state=Records("DISCOUNT_STATE_ID").Value
Records.Close()
//---
if(!isFirst){
	// --- verify form data ---	
	if(oper==0 && String(Request.Form("state"))!="undefined"){ oper_0_with_state=true;}
	if(oper=="0"||oper=="1"){
  		if(TextFormData(Request.Form("url"),"")==""){ErrorMsg+="URL requred.<br>";}
		rate=FloatFormData(String(Request.Form("rate")).replace(',','.'));
		if(isNaN(rate) || String(rate).length!=String(Request.Form("rate")).length ) {ErrorMsg+="Invalid discount rate value.<br>";}
	}
	if(ErrorMsg==""){
		try{
		if(oper=="" || oper=="0"){
			tmp=IntFormData(Request.Form("state"));
			if((discount_state=(tmp==null?discount_state:tmp))!=null){
				Connect.Execute("update company set discount_state_id="+discount_state+" where id="+cid);
			}
		}
		if(oper=="0"||oper=="1"){
			if (oper=="0"){sql="insert into  access_link(id,url,rate,type,description,company_id,date_change) values(gen_id(universal,1),'%url',%rate,%type,'%desc',%cid,'now')"}
			else {sql="update access_link set url='%url', rate=%rate,type=%type,description='%desc',date_change='now' where id=%pid and company_id=%cid"}
			sql=sql.replace('%url',TextFormData(Request.Form("url"),""))
			sql=sql.replace('%rate',rate)
			sql=sql.replace('%type',Request.Form("cardtype"))
			sql=sql.replace('%desc',TextFormData(Request.Form("desc"),""))
			sql=sql.replace('%cid',cid)
			sql=sql.replace('%pid',pid)
			Connect.Execute(sql)
		}
		if(oper=="2"){
			Connect.Execute("delete from access_link where id="+pid+" and company_id="+cid)
		}

		oper_prev=oper;
		if(oper=="" ){Response.Redirect("compdisc.asp");}
		else{oper="";}
		} // --- try
		catch(e){
			ErrorMsg+=ListAdoErrors();
		}
	}
}
//------------------------------
if(oper==""){
	Records.Source="select * from access_link where company_id="+cid+" order by url"
	Records.Open()
	if(Records.EOF){
		if(oper_prev==2){ Response.Redirect("compdisc.asp");}
		oper="0";
		oper_0_with_state=true;
		Records.Close;
	}
}
//------------------------------
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
	//if(document.form.pname.value==""){alert("Name is reqiured."); return false}
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
<FORM action="discstts.asp" name="form" method="post" <%if(oper=="0" || oper=="1"){%>OnSubmit="return check()"<%}%>>
  <input type="hidden" name="cid" value="<%=cid%>">
  <input type="hidden" name="pid" value="<%=pid%>">
  <input type="hidden" name="oper" value="<%=oper%>">
  <center class="doctitle" >
<%
if(oper==""){Response.Write("Modify discount system status.")}
if(oper=="0"){Response.Write("Create access link.")}
if(oper=="1"){Response.Write("Edit access link.")}
if(oper=="2"){Response.Write("Are you sure you want to delete access link?")}
%>
     </center> <br>
   
  <%
		if(ErrorMsg!=""){%> 
  <h3 align="center"> <font color="#FF3333">Processing error<br>
    </font><font color="#1e4a7b"><%=ErrorMsg%></font><br>
  </h3>
<%
}
//--- access link list --- 
if(oper==""){
%>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td > 
        <table width="100%" border="0" cellspacing="3">
	  <tr> 
	    <td colspan="2" class="blueband"> 
	      <p>General information</p>
	    </td>
	  </tr>
	  <tr> 
	    <td class="fieldtitle" width=22% >Company name:</td>
	    <td class="fielddata" ><%=compname%></td>
	  </tr>
	<tr>
	<td class="fieldtitle"  >Discount program status:</td>
	<td class="fielddata" >
		<select name="state"> 
		<% 
		rr=CreateRecordSet();
		rr.Source="select * from sp_discount_state order by id";
		rr.Open();
		while(!rr.EOF){ 
		%>
			<option value="<%=rr("ID").Value%>" <%=rr("ID").Value==discount_state?"selected":""%>> 
				<%=rr("NAME").Value%>
			</option> 
		<% 
			rr.MoveNext();
	 	} 
		rr.Close();
		%>
		</select>
	</td>
	</tr>
	</table>
	<center>
	<input type=submit name=Submit value=Submit>
	</center>
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="6" class="blueband">Access links</td>
          </tr>
          <tr> 
            <td class="fieldtitle_L" >URL</td>
            <td class="fieldtitle_L" width=15%>Discount rate,%</td>
            <td class="fieldtitle_L" width=15%>Card type</td>
            <td class="fieldtitle_L" width=6%>&nbsp;</td>
            <td class="fieldtitle_L" width=6%>&nbsp;</td>
          </tr>
          <%i=0
	while(!Records.EOF){%> 
          <tr <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>> 
            <td class="fielddataST"><%=Records("URL").Value%>
            <td class="fielddataST"><%=Records("RATE").Value%>
            <td class="fielddataST"><%=Records("TYPE").Value==0?"Discount":"Access"%>
            <td class="fieldtitle_L"  >
			<a OnMouseOver="window.status='Edit access link';return true" 
			href="javascript:select('1','<%=Records("ID").Value%>')"
			OnMouseOut="window.status=''">edit</a></td>
            <td class="fieldtitle_L" width="6%" >
			<a OnMouseOver="window.status='Delete access link';return true" 
			href="javascript:select('2','<%=Records("ID").Value%>')"
			OnMouseOut="window.status=''">delete</a></td>
          </tr>
          <%i++;Records.MoveNext()}%> 
          <tr> 
            <td colspan="6"><a OnMouseOver="window.status='Add access link';return true" 
			href="javascript:select('0','0')"
			OnMouseOut="window.status=''">Add access link</a></td>
          </tr>
        </table>
        <center>
          <input type="Button" name="back" value="Back" OnClick="document.form.action='compdisc.asp';document.form.submit()">
        </center>
        </td>
    </tr>
  </table>
  <h5>
<%}// if oper==""
// --- insert / edit ---
if(oper=="0" ||oper=="1"){
		if (oper=="1" && isFirst){
			Records.Source="select * from access_link where company_id="+cid+" and id="+pid
			Records.Open()
			if(Records.EOF){Response.Redirect("compdisc.asp")}
		}
%> <br>
  </h5>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td > 
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="2" class="blueband"> 
              <p>General information</p>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width=22% >Company name:</td>
            <td class="fielddata" ><%=compname%></td>
          </tr>
<% if(oper_0_with_state){ %>
	<tr>
	<td class="fieldtitle"  >Discount program status:</td>
	<td class="fielddata" >
		<select name="state"> 
		<% 
		tmp=isFirst?0:Request.Form("state")
		rr=CreateRecordSet();
		rr.Source="select * from sp_discount_state order by id";
		rr.Open();
		while(!rr.EOF){ 
		%>
			<option value="<%=rr("ID").Value%>" <%=rr("ID").Value==tmp?"selected":""%>> 
				<%=rr("NAME").Value%>
			</option> 
		<% 
			rr.MoveNext();
	 	} 
		rr.Close();
		%>
		</select>
	</td>
	</tr>
<% } %>
        </table>
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="6" class="blueband">Access link information</td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%">URL:</td>
            <td class="fieldtitle_L" colspan="5">
              <input type="text" name="url" size="35" value="<%=isFirst?oper==1?Records("URL").Value:"":Request.Form("url")%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Discount rate:</td>
            <td class="fieldtitle_L" colspan="5">
              <input type="text" name="rate" size="35" value="<%=isFirst?oper==1?Records("RATE").Value:"":Request.Form("rate")%>">
	      % </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Card type:</td>
            <td class="fieldtitle_L" colspan="5">
			<select name=cardtype>
				<% tmp=isFirst?oper==1?Records("TYPE").Value:0:Request.Form("cardtype")%>
				<option value=0 <%=tmp==0?"selected":""%>>Discount</option>
				<option value=1 <%=tmp==1?"selected":""%>>Access  </option>
			</select>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Description:</td>
            <td class="fieldtitle_L" colspan="5">
              <textarea name="desc" rows=10 cols=70><%=isFirst?oper==1?Records("DESCRIPTION").Value:"":Request.Form("desc")%></textarea>
            </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
		if(oper_0_with_state){tmp="document.form.action='compdisc.asp';document.form.submit();";}
		else{tmp="document.form.oper.value='';document.form.pid.value='';document.form.submit()";}
		%>		
          <input type="button" name="cancel" value="Cancel" onClick="<%=tmp%>">
        </center>
      </td>
    </tr>
  </table>
  <%}// if oper= ins or edit
// --- delete ---
if(oper=="2"){
			Records.Source="select * from access_link where company_id="+cid+" and id="+pid
			Records.Open()
			if(Records.EOF){Response.Redirect("company.asp?cid="+cid)}
%>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td > 
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="2" class="blueband"> 
              <p>General information</p>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width=22% height="2">Company name:</td>
            <td class="fielddata" ><%=compname%></td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="6" class="blueband">Access link information</td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="20%">URL:</td>
            <td class="fielddata" colspan="5"> <%=Records("URL").Value%> 
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">RATE:</td>
            <td class="fielddata" colspan="5"> <%=Records("RATE").Value%> 
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle">Card type:</td>
            <td class="fielddata" colspan="5"> <%=Records("TYPE").Value==0?"Discount":"Access"%> 
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
        <h5><font size="-4" face="Arial, Helvetica, sans-serif">&copy; 2000 Onegard 
          International Business LLC, USA</font></h5>
      </td>
    </tr>
  </table>
  <p>&nbsp; </p>
</FORM>

</BODY>
</HTML>
