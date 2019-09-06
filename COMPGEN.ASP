<%@LANGUAGE="JAVASCRIPT"%>

<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\comp_sql.inc" -->
<!-- #include file="inc\next_id.inc" -->
<!-- #include file="inc\dict_val.inc" -->
<!-- #include file="inc\getfield.inc" -->
<!-- #include file="inc\err.inc" -->



<%
var tmp,compname, shortname, stock, country_id, comp_type_id, bossname, bosstype,begindate,
	state_id, region, zip, metro, city, city_id, district, street, building, office;

function RedirectOnError(){Response.Redirect("complist.asp")}

var cid=Request.Form("cid")
var high=Request.Form("high")
var ErrorMsg=""
//is input ids correct 
if (isNaN(parseInt(cid,10))||(cid=="0" && isNaN(parseInt(high,10)) )) {RedirectOnError()}
//-------------------
ShowForm=true
isFirst=String(Request.Form("Submit"))=="undefined"
backlink="area.asp"
if (Request.Form("back")=="0"){backlink="complist.asp"}
if (Request.Form("back")=="1"){backlink="company.asp"}
tmp=""
//if request to create first company then check is any company exists
if(cid=="0" && high=="0"){
	tmp=new String("select count(*) as cnt from company where member_id=%mem_id and deleted=0")
	Records.Source=(tmp.replace("%mem_id",Session("UserID"))).toString()
	Records.Open()
	if (Records("CNT").Value!=0){Records.Close();RedirectOnError()}
	Records.Close()
}
//if request to create next company then check is high company exists
if(cid=="0" && high!="0"){
	tmp=new String("select count(*) as cnt from company where member_id=%mem_id and id=%high and deleted=0")
	tmp=tmp.replace("%mem_id",Session("UserID"))
	tmp=tmp.replace("%high",high)
	Records.Source=tmp.toString()
	Records.Open()
	if (Records("CNT").Value==0){Records.Close();RedirectOnError()}
	Records.Close()
}

//form was submited
if(!isFirst){
	//validate user input------------------------------------------------------
	if(Request.Form("compname")==""){ErrorMsg="Company name requred.<br>"}
	if (Request.Form("comptype")==0){ErrorMsg=ErrorMsg+"Company type requred.<br>"}
	if (Request.Form("country")==0){ErrorMsg=ErrorMsg+"Country requred.<br>"}
	else{
		if(Request.Form("country")==133){
			if(Request.Form("state")==0){ErrorMsg=ErrorMsg+"State requred.<br>"}
		}	
		else{
			if(Request.Form("region")==""){ErrorMsg=ErrorMsg+"Province requred.<br>"}
		}
	}
	if(Request.Form("city")==""){ErrorMsg=ErrorMsg+"City requred.<br>"}
	if(Request.Form("begindate")!="" && !/(\d{1,2}).(\d{1,2}).(\d{4})$/.test(Request.Form("begindate"))){ErrorMsg=ErrorMsg+"Invalid establishment date.<br>"}
	//--------------save country and state info ----------------------------
	country_id=Request.Form("country");
	country_id_new=country_id
	if(country_id=="133"){state_id=Request.Form("state")}
}
//if edit first request or submit with good validation
if(ErrorMsg==""){
	//-----first edit request not create
	if(cid!="0"){
		tmp=new String(comp_select)
		tmp=tmp.replace("%mem_id",Session("UserID"))
		tmp=tmp.replace("%cid",cid)
		Records.Source=tmp.toString()
		Records.Open()
		if (Records.EOF){Records.Close();RedirectOnError()}
		country_id=Records("COUNTRY_ID").Value
		comp_type_id=Records("COMPANY_TYPE_ID").Value
		state_id=Records("COUNTRY_STATE_ID").Value
		city=Records("CITY").Value
		city_id=Records("CITY_ID").Value
		begindate=DateField(Records("BEGIN_DATE"))
		region=Records("COUNTRY_STATE").Value
		shortname=TextField(Records("SHORTNAME"))
		bosstype=TextField(Records("BOSS_TYPE"))
		bossname=TextField(Records("BOSS"))
		office=TextField(Records("OFFICE"))
		building=TextField(Records("BUILDING"))
		metro=TextField(Records("MEGAPOLIS"))
		street=TextField(Records("STREET"))
		district=TextField(Records("CITY_AREA"))
		zip=TextField(Records("ZIP_CODE"))
		stock=TextField(Records("STOCK_TICKER"))
		compname=TextField(Records("NAME"))
		Records.Close()
	}
	//------submit with good validation----------
	if(!isFirst){
		// get hierarhy_type-------------------------
		if(high==0){htype=0}
		else{
			var rs=CreateRecordSet()
			rs.Source="select hierarchy_type as htype from company where id="+high+" and member_id="+Session("UserID")
			rs.Open()
			if(rs.EOF){RedirectOnError()}
			htype=rs("HTYPE").Value+1
			rs.Close()
			delete rs
		} 
		//-------------------------------------------------
		Connect.BeginTrans()
		try{
			//-------register values in dicts
			//get dict value for city
			city_id_new=DictValue("SP_CITY","NAME",Request.Form("city"))
			//get dict value for state or region
			if(country_id_new!="133"){state_id_new=DictValue("SP_COUNTRY_STATE","NAME",Request.Form("region"),"and shortname is null")}
			else{state_id_new=Request.Form("state")}
			//--------create new company----------
			var oper
			if(cid=="0"){
				oper=0
				tmp=new String(comp_insert)
				id_new=NextID()
				tmp=tmp.replace("%ID",id_new)
				tmp=tmp.replace("%MEMBER_ID",Session("UserID"))
				tmp=tmp.replace("%NAME",Request.Form("compname"))
				tmp=tmp.replace("%COUNTRY_ID",country_id_new)
				tmp=tmp.replace("%COMPANY_TYPE_ID",Request.Form("comptype"))
				tmp=tmp.replace("%COUNTRY_STATE_ID",state_id_new)
				tmp=tmp.replace("%STOCK_TICKER",Request.Form("stock"))
				tmp=tmp.replace("%CITY_ID",city_id_new)
				tmp=tmp.replace("%ZIP_CODE",Request.Form("zip"))
				tmp=tmp.replace("%CITY_AREA",Request.Form("district"))
				tmp=tmp.replace("%STREET",Request.Form("street"))
				tmp=tmp.replace("%MEGAPOLIS",Request.Form("metro"))
				tmp=tmp.replace("%BUILDING",Request.Form("building"))
				tmp=tmp.replace("%OFFICE",Request.Form("office"))
				tmp=tmp.replace("%BOSS",Request.Form("bossname"))
				tmp=tmp.replace("%BOSS_TYPE",Request.Form("bosstype"))
				tmp=tmp.replace("%BEGIN_DATE",Request.Form("begindate")==""?"null": "'"+Request.Form("begindate")+"'")
				tmp=tmp.replace("%HIGH_ID",high)
				tmp=tmp.replace("%HIERARCHY_TYPE",htype)
				tmp=tmp.replace("%REG_DATE","Now")
				tmp=tmp.replace("%DISCOUNT_STATE_ID","0")
				tmp=tmp.replace("%SHORTNAME",Request.Form("shortname"))
				Connect.Execute(tmp.toString())
				ShowForm=false
				cid=id_new
			}
			//--------update company---------------
			else{
				var set=""
				oper=1
				if(compname!=Request.Form("compname")){set+="name='"+Request.Form("compname")+"',"}
				if(shortname!=Request.Form("shortname")){set+="shortname='"+Request.Form("shortname")+"',"}
				if(comp_type_id!=Request.Form("comptype")){set+="company_type_id="+Request.Form("comptype")+","}
				if(bossname!=Request.Form("bossname")){set+="boss='"+Request.Form("bossname")+"',"}
				if(String(bosstype)!=Request.Form("bosstype")){set+="boss_type='"+Request.Form("bosstype")+"',"}
				if(begindate!=Request.Form("begindate")){set+="begin_date='"+Request.Form("begindate")+"',"}
				if(stock!=Request.Form("stock")){set+="stock_ticket='"+Request.Form("stock")+"',"}
				if(country_id!=country_id_new){set+="country_id="+country_id_new+","}
				if(state_id!=state_id_new){set+="country_state_id="+state_id_new+","}
				if(zip!=Request.Form("zip")){set+="zip_code='"+Request.Form("zip")+"',"}
				if(metro!=Request.Form("metro")){set+="megapolis='"+Request.Form("metro")+"',"}
				if(city!=Request.Form("city")){set+="city_id="+city_id_new+","}
				if(district!=Request.Form("district")){set+="city_area='"+Request.Form("district")+"',"}
				if(street!=Request.Form("street")){set+="street='"+Request.Form("street")+"',"}
				if(building!=Request.Form("building")){set+="building='"+Request.Form("building")+"',"}
				if(office!=Request.Form("office")){set+="office='"+Request.Form("office")+"',"}
				set=set.replace(/,$/,"")
				if (set!=""){
					sql=comp_update.replace("%set_field",set)
					sql=sql.replace("%mem_id",Session("UserID"))
					sql=sql.replace("%cid",cid)
					Connect.Execute(sql)
				}
			}
			Connect.CommitTrans()
			if(oper==1) {Response.Redirect("company.asp?cid="+cid)}
		}
		catch(e){
			Connect.RollbackTrans()
			ErrorMsg+=ListAdoErrors()
			//Response.Redirect("complist.asp")
		}
	}
}
//--------------------------------------------
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE><%=cid=="0"?"Create":"Modify"%> 
company profile</TITLE>
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<script language="JavaScript">
function check(){
	//return true
	ErrorMsg=""
	if (document.form.compname.value==""){
		alert("Company name requred.")
		document.form.compname.focus()
		return false
	}
	if (document.form.comptype.value=="0"){
		alert("Company type is requred.")
		document.form.comptype.focus()
		return false
	}
	si=document.form.country.selectedIndex
	if (document.form.country.selectedIndex==0){
		alert("Country is requred.")
		document.form.country.focus()
		return false
	}
	if (si!=0){
		if(document.form.country.options[si].value==133){
			if(document.form.state.selectedIndex==0){
				alert("State is requred.")
				document.form.state.focus()
				return false
			}
		}
		else{
			if(document.form.region.value==""){
				alert("Province is requred.")
				document.form.region.focus()
				return false
			}
		}
	}
	if (document.form.city.value==""){
		ErrorMsg="City is requred."
		alert("City is requred.")
		document.form.city.focus()
		return false
	}
	if(document.form.begindate.value!=""){
		re=/(\d{1,2}).(\d{1,2}).(\d{4})$/
		re.exec(document.form.begindate.value)
		if(RegExp.$1<1||RegExp.$1>31||RegExp.$2<1||RegExp.$2>12){
			alert("Invalid establishment date format.")
			document.form.begindate.focus()
			return false
		}
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
        | <a href="index.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Home</font></a> 
        | <a href="area.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Members 
        Area</font></a> | <a href="complist.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Company 
        structure</font></a> |</font></b></font></p>
    </td>
  </tr>
</table>
<br>
<FORM action="compgen.asp" name="form" method="post" OnSubmit="return check()">
<%if(ShowForm){%>
  <center class="doctitle">
    <%=cid=="0"?"Create":"Modify"%> 
      company profile.
  </center> 
   <%if(ErrorMsg!=""){%> 
  <h3 align="center"> <font color="#FF3333">Processing error<br>
    </font><font color="#1e4a7b"><%=ErrorMsg%></font><br>
  </h3>
<%}%>
  *-requred fields<br>
  <table width="100%" border="1" cellspacing="0" height="483" bordercolordark="#666666" bordercolorlight="#CCCCCC">
    <tr>
      <td height="524"> 
        <table width="100%" cellspacing="1" height="384">
          <tr> 
            <td class="blueband"  colspan="2">General information</td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Company name:</td>
            <td width="75%"> 
              <input type="text" size="70" name="compname" value="<%=isFirst?compname:Request.Form("compname")%>">
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Short company name:</td>
            <td > 
              <input type="text" name="shortname" value="<%=isFirst?shortname:Request.Form("shortname")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle" >Company type:</td>
            <td> 
              <select name="comptype">
                <option value="0" <%=cid=="0"||Request.Form("comptype")=="0"?"selected":""%>>Select 
                company type</option>
                <%
				Records.Source="select * from sp_company_type order by name"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=(isFirst&&Records("ID").Value==comp_type_id)||Request.Form("comptype")==Records("ID").Value?"selected":""%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Boss name:</td>
            <td> 
              <input type="text" name="bossname" size="50" value="<%=isFirst?bossname:Request.Form("bossname")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Boss position:</td>
            <td> 
              <input type="text" name="bosstype" size="50" value="<%=isFirst?bosstype:Request.Form("bosstype")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Date of establishment: </td>
            <td> 
              <input type="text" name="begindate" value="<%=isFirst?begindate:Request.Form("begindate")%>">
              (format DD.MM.YYYY) </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Stock ticker:</td>
            <td> 
              <input type="text" name="stock" value="<%=isFirst?stock:Request.Form("stock")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="blueband" colspan="2">Address </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Country: </td>
            <td> 
              <select name="country">
                <option value="0" <%=cid=="0"||Request.Form("country")=="0"?"selected":""%>>Select 
                country</option>
                <%
				Records.Source="select * from sp_country where not shortname is null order by name"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=(isFirst&&Records("ID").Value==country_id)||Request.Form("country")==Records("ID").Value?"selected":""%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">State:</td>
            <td> 
              <select name="state">
                <option value="0" <%=cid=="0"||country_id!="133"||Request.Form("state")=="0"?"selected":""%> selected>Select 
                state</option>
                <%
				Records.Source="select * from sp_country_state where not shortname is null order by name"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=(country_id=="133")&&((isFirst&&Records("ID").Value==state_id)||Request.Form("state")==Records("ID").Value)?"selected":""%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * (US only)</td>
          </tr>
          <tr>
            <td width="25%" class="fieldtitle">Province:</td>
            <td>
              <input type="text" name="region" size="50" value="<%=isFirst&&country_id!="133"?region:Request.Form("region")%>">
              *(not US only) </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Zip/post code:</td>
            <td> 
              <input type="text" name="zip" value="<%=isFirst?zip:Request.Form("zip")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Metro area:</td>
            <td> 
              <input type="text" name="metro" size="50" value="<%=isFirst?metro:Request.Form("metro")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">City, town:</td>
            <td> 
              <input type="text" name="city" size="30" value="<%=isFirst?city:Request.Form("city")%>">
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">District area:</td>
            <td> 
              <input type="text" name="district" size="30" value="<%=isFirst?district:Request.Form("district")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Street:</td>
            <td> 
              <input type="text" name="street" size="30" value="<%=isFirst?street:Request.Form("street")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Building:</td>
            <td> 
              <input type="text" name="building" value="<%=isFirst?building:Request.Form("building")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Office:</td>
            <td> 
              <input type="text" name="office" value="<%=isFirst?office:Request.Form("office")%>">
            </td>
          </tr>
        </table>  
        <center>
          <input type="submit" name="Submit" value="Submit">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="button" name="Button" value="Back" OnClick="document.form.action='<%=backlink%>';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
<%}
else{%>
  <table width="100%" border="0" cellspacing="0">
    <tr>
      <td class="blueband" height="40">&nbsp;</td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
    </tr>
    <tr>
      <td height="40"> 
        <center class="doctitle" valign="center">Company profile successfuly created.</center>.</td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
    </tr>
    <tr>
      <td class="blueband" height="40">
        <center><input type="button" name="Submit2" value="Continue" OnClick="document.form.action='company.asp';document.form.submit()"></center>
      </td>
    </tr>
  </table>
<%}%>
  <p>&nbsp;</p>
  <p>
    <input type="hidden" name="cid" value="<%=cid%>">
    <input type="hidden" name="high" value="<%=high%>">
    <input type="hidden" name="back" value="<%=Request.Form("back")%>">
    <br>
  </p>
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
      <h5><font size="-4" face="Arial, Helvetica, sans-serif">&copy; 2000, 2001 Onegard International Business LLC, USA</font></h5>
    </td>
  </tr>
</table>
</BODY>
</HTML>
