<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getfield.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\getform.inc" -->

<%
function getNextYear(){
	var result=0
	rec=CreateRecordSet()	
	rec.Source="select max(fin_year) as maxyear from fin_info where company_id="+cid
	rec.Open()
	if(rec("MAXYEAR").Value!=null){
		result=new Number(DateField(rec("MAXYEAR")).substring(6,10))
		result++
	}
	rec.Close()
	return result
}
var ErrorMsg="",year=0
var cid=Request.Form("cid")
var yid=TextFormData(Request.Form("yid"),"")
var oper=TextFormData(Request.Form("oper"),"")

if (isNaN(parseInt(cid,10))  ){Response.Redirect("complist.asp?cid="+cid)}
isFirst=String(Request.Form("Submit"))=="undefined"
%><!-- #include file="inc\is_comp_ok.inc" --><%
//---------------------------------------
year=0
nextyear=0
if (oper=="1"){
	Records.Source="select * from fin_info where company_id="+cid+" order by fin_year desc"
	Records.Open()
	if(Records.EOF){
		Records.Close()
		oper=0
	}
	else{
		year=new Number(DateField(Records("FIN_YEAR")).substring(6,10))
	}
}
if(oper=="0"){
	year=getNextYear()
	nextyear=year
}
//--------------------------------------
if(!isFirst){
	//---------check entered values---------
	if(oper=="0"){
		//year=getNextYear()
		year=year==0?FloatFormData(Request.Form("year")):year
		if(isNaN(year)|| year==null){ErrorMsg+="Year is reqiured.<br>"}
		if(ErrorMsg=="" && year<=1900){ErrorMsg+="Year must be greater 1900.<br>"}
	}
	sales=FloatFormData(Request.Form("sales"))
	if(isNaN(sales) ){ErrorMsg+="Invalid sales format.<br>"}
	salesg=FloatFormData(Request.Form("salesg"))
	if(isNaN(salesg) ){ErrorMsg+="Invalid sales growth format.<br>"}
	income=FloatFormData(Request.Form("income"))
	if(isNaN(income) ){ErrorMsg+="Invalid income format.<br>"}
	incomeg=FloatFormData(Request.Form("incomeg"))
	if(isNaN(incomeg) ){ErrorMsg+="Invalid income growth format.<br>"}
	wcount=FloatFormData(Request.Form("wcount"))
	if(isNaN(wcount) ){ErrorMsg+="Invalid emploies count format.<br>"}
	if(sales==null && 
		salesg==null &&
		income==null &&
		incomeg==null && 
		wcount==null &&
		ErrorMsg==""){ErrorMsg+="No one field specified.<br>"}
	//--------apply updates---------------
	if(ErrorMsg==""){
		if(oper==0){
			sql="insert into fin_info(id,company_id,fin_year,sales,sales_growth,net_income,net_income_growth, worker_count)"+
				"values(gen_id(universal,1),%cid,'%year',%sales,%salesg,%income,%incomeg,%wcount)"
		}
		if(oper==1){
			sql="update fin_info set sales=%sales,sales_growth=%salesg,net_income=%income,"+
				"net_income_growth=%incomeg, worker_count=%wcount "+
				"where company_id=%cid and fin_year='%year'"
				Records.Close()
		}

		sql=sql.replace("%cid",cid)
		sql=sql.replace("%year","01.01."+year)
		sql=sql.replace("%sales",sales)
		sql=sql.replace("%salesg",salesg)
		sql=sql.replace("%income",income)
		sql=sql.replace("%incomeg",incomeg)
		sql=sql.replace("%wcount",wcount)
		Connect.Execute(sql)
		oper=""
	}
	//------------------------------------
}
//-------------------
if(oper==""){
	Records.Source="select * from fin_info where company_id="+cid+" order by fin_year"
	Records.Open()
}
//------------------
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Company finance information<%=oper%></TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="javascript">
function select(o){
	document.form.oper.value=o
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
<FORM action="compfall.asp" name="form" method="post">
  <input type="hidden" name="cid" value="<%=cid%>">
  <input type="hidden" name="oper" value="<%=oper%>">
  <input type="hidden" name="yid" value="<%=yid%>">
  <center class="doctitle" >
<%
if(oper==""){Response.Write("Modify company profile.")}
if(oper=="0"){Response.Write("Add next year.")}
if(oper=="1"){Response.Write("Edit last year.")}
%>
      
<%if(ErrorMsg!=0){%>
 <h3><font color="#FF3333">Processing error.<br></font>
	 <font color="#1e4a7b"><%=ErrorMsg%></font></h3>
	
<%}%></center><br>
<%if (oper==""){
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
            <td colspan="6" class="blueband">Finance information</td>
          </tr>
          <tr> 
            <td class="fieldtitle_L" width="5%">Year</td>
            <td class="fieldtitle_L" width="15%">Sales (US$)</td>
            <td class="fieldtitle_L" width="15%">Sales growth (%)</td>
            <td class="fieldtitle_L" width="16%">Net income (US$)</td>
            <td class="fieldtitle_L" width="24%">Net incone growth (%)</td>
            <td class="fieldtitle_L" width="25%">Emploies count</td>
          </tr>
          <%
			var i=0
			while(!Records.EOF){%> 
          <tr <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>> 
            <td class="fielddataST" width="5%" height="21"><%=DateField(Records("FIN_YEAR")).substring(6,10)%></td>
            <td class="fielddataST" width="15%" height="21"><%=Records("SALES").Value%></td>
            <td class="fielddataST" width="15%" height="21"><%=Records("SALES_GROWTH").Value%></td>
            <td class="fielddataST" width="16%" height="21"><%=Records("NET_INCOME").Value%></td>
            <td class="fielddataST" width="24%" height="21"><%=Records("NET_INCOME_GROWTH").Value%> 
            </td>
            <td class="fielddataST" width="25%" height="21"><%=Records("WORKER_COUNT").Value%> 
            </td>
          </tr>
          <%
			i++
			Records.MoveNext()}
			%> 
          <tr> 
            <td colspan="6"><a OnMouseOver="window.status='Add next year';return true" 
			href="javascript:select('0')"
			OnMouseOut="window.status=''">Add next year</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%if(i!=0){%>
			<a OnMouseOver="window.status='Edit last year';return true" 
			href="javascript:select('1')"
			OnMouseOut="window.status=''">Edit last year</a>
			<%}%></td>
          </tr>
        </table>
        <center>
          <input type="Button" name="back" value="Back" OnClick="document.form.action='company.asp#fin';document.form.submit()">
        </center>
        </td>
    </tr>
  </table>
  <%}
	else{
%> 
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="245"> 
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
            <td colspan="2" class="blueband"> 
              <p>Year finance information</p>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="21%" height="2">Year:</td>
            <td class="fielddata" height="2" width="79%">
				<%if(nextyear=="0"&&oper==0){%>
              <input type="text" name="year" size="35" value="<%=oper=="0"?Request.Form("year"):""%>">
				<%} else {Response.Write(year)}%>
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="21%" height="2">Sales (US$):</td>
            <td class="fielddata" height="2" width="79%">
              <input type="text" name="sales" size="35" value="<%=isFirst&&oper=="1"?Records("SALES").Value:Request.Form("sales")%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="21%" height="2">Sales growth (%):</td>
            <td class="fielddata" height="2" width="79%">
              <input type="text" name="salesg" size="35" value="<%=isFirst&&oper=="1"?Records("SALES_GROWTH").Value:Request.Form("salesg")%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="21%" height="2">Net income (US$):</td>
            <td class="fielddata" height="2" width="79%">
              <input type="text" name="income" size="35" value="<%=isFirst&&oper=="1"?Records("NET_INCOME").Value:Request.Form("income")%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="21%" height="2">Net income growth (%):</td>
            <td class="fielddata" height="2" width="79%">
              <input type="text" name="incomeg" size="35" value="<%=isFirst&&oper=="1"?Records("NET_INCOME_GROWTH").Value:Request.Form("incomeg")%>">
            </td>
          </tr>
          <tr> 
            <td class="fieldtitle" width="21%" height="2">Empoloies count:</td>
            <td class="fielddata" height="2" width="79%">
              <input type="text" name="wcount" size="35" value="<%=isFirst&&oper=="1"?Records("WORKER_COUNT").Value:Request.Form("wcount")%>">
            </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" name="cancel" value="Cancel" onClick="document.form.oper.value='';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
<%}%>
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
