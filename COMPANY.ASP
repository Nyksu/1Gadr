<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\comp_sql.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\getfield.inc" -->
<!-- #include file="inc\path.inc" -->
<%
var cid=Request("cid")
if (isNaN(parseInt(cid,10))  ){Response.Redirect("complist.asp")}

var tmp
Records.Source=comp_select.replace("%mem_id",Session("UserID")).replace("%cid",cid)
Records.Open()
if (Records.EOF){Records.Close();Response.Redirect("complist.asp")}
//-----------get web pages
rec=CreateRecordSet()
rec.Source="select id,name,DESCRIPTION from web_page where company_id="+cid+" order by id"
rec.Open()
var www=new Array(4)
var dsc=new Array(4)
var i
for(i=0;i<4;i++){
	if(!rec.EOF){
		www[i]=rec("NAME").Value
		dsc[i]=www[i]+" ("+rec("DESCRIPTION").Value+")"
		rec.MoveNext()
	}
}
rec.Close()
//-------------
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Company profile</TITLE>
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
<FORM action="" name="form" method="post">
  <input type="hidden" name="cid" value="<%=cid%>">
  <input type="hidden" name="back" value="1">
  <center class="doctitle">
    <p>Company profile.</p>
    <div align="left"><font size="3">No inverted commas</font></div>
  </center> 
  <div align="left"><br>
  </div>
  <table width="100%" border="1" cellspacing="0" height="483" bordercolordark="#666666" bordercolorlight="#CCCCCC">
    <tr>
      <td height="462"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td class="blueband"  colspan="2">General information</td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Company name:</td>
            <td class="fielddata"><%=Records("NAME").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Short company name:</td>
            <td  class="fielddata"><%=Records("SHORTNAME").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle" height="2">Company type:</td>
            <td   class="fielddata" height="2"><%=Records("COMPANY_TYPE").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Boss name:</td>
            <td   class="fielddata"><%=Records("BOSS").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Boss position:</td>
            <td   class="fielddata"><%=Records("BOSS_TYPE").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle" height="23">Date of establishment: 
            </td>
            <td width="80%" class="fielddata" height="23" ><%=Records("BEGIN_DATE").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Stock ticker:</td>
            <td width="80%" class="fielddata" ><%=Records("STOCK_TICKER").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="blueband" colspan="2">Address </td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Country: </td>
            <td width="80%" class="fielddata" ><%=Records("COUNTRY").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">State/Province:</td>
            <td width="80%" class="fielddata" ><%=Records("COUNTRY_STATE").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Zip/post code:</td>
            <td width="80%" class="fielddata" ><%=Records("ZIP_CODE").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Metro area:</td>
            <td width="80%" class="fielddata" ><%=Records("MEGAPOLIS").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">City, town:</td>
            <td width="80%" class="fielddata" ><%=Records("CITY").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">District area:</td>
            <td width="80%" class="fielddata" ><%=Records("CITY_AREA").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Street:</td>
            <td width="80%" class="fielddata" ><%=Records("STREET").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Building:</td>
            <td width="80%" class="fielddata" ><%=Records("BUILDING").Value%></td>
          </tr>
          <tr> 
            <td width="20%" class="fieldtitle">Office:</td>
            <td width="80%" class="fielddata" ><%=Records("OFFICE").Value%></td>
          </tr>
        </table>  
        <center>
          <input type="button" name="Button" value="Edit" onClick="document.form.action='compgen.asp';document.form.submit()">
		</center>
      </td>
    </tr>
  </table>
<%
//-----------about---------
%>
<br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="53"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband">About company</td>
          </tr>
          <tr> 
            <td>
<%
var fs = new ActiveXObject("Scripting.FileSystemObject")
try{
	var ts = fs.OpenTextFile(TextFilePath+Records("ID").Value+AboutExt)
	txt=ts.ReadAll()
	if (txt.length>180){
		txt=txt.substring(0,180)
		arr=/\s\w*$/.exec(txt)
		txt=txt.substring(0,txt.length-arr[0].length)+".........."
	}
	Response.Write(txt)

	ts.Close()
}
catch(e){}
%>
	</td>
          </tr>
        </table>
        <div align="center"> 
          <input type="button" name="Abiut" value="View / Edit" onClick="document.form.action='compabt.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>

<%//-----------web----------%>
<br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td>
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td width="50%" class="blueband" colspan="2">  <a name="web">Company`s Web sites</a></td>
          </tr>
          <tr class="fielddata"> 
            <td width="50%"><a href="http://<%=www[0]%>" target=_blank><%=dsc[0]%></a></td>
            <td width="50%"><a href="http://<%=www[1]%>" target=_blank><%=dsc[1]%></a></td>
          </tr>
          <tr class="fielddata"> 
            <td class="fielddata" width="50%"><a href="http://<%=www[2]%>" target=_blank><%=dsc[2]%></a></td>
            <td class="fielddata" width="50%"><a href="http://<%=www[3]%>" target=_blank><%=dsc[3]%></a></td>
          </tr>
        </table>
        <div align="center"> 
          <input type="button" name="Button3" value="Edit" onClick="document.form.action='compweb.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>
<%
//-----------get representatives
rec.Source="select * from person where company_id="+cid+" order by name"
rec.Open()
%><br>
  <table width="100%" border="1" cellspacing="0" height="73" bordercolordark="#666666" bordercolorlight="#CCCCCC">
    <tr> 
      <td height="51"> 
        <table width="100%" border="0" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband">  <a name="rep">Representatives</a></td>
          </tr>
          <tr> 
            <td class="fieldtitle_L" width="25%">Name</td>
            <td class="fieldtitle_L">Position</td>
            <td class="fieldtitle_L" width="15%">Phone</td>
            <td class="fieldtitle_L" width="20%">E-Mail</td>
          </tr>
<%i=0;while(!rec.EOF){%>
          <tr <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>> 
            <td class="fielddata"><%=rec("NAME").Value%></td>
            <td class="fielddata"><%=rec("PERSON_POSITION").Value%></td>
            <td class="fielddata"><%=rec("PHONE").Value%></td>
            <td class="fielddata"><%=rec("E_MAIL").Value%></td>
          </tr>
<%i++;rec.MoveNext()}%>
        </table>
        <div align="center"> 
          <input type="button" name="Button2" value="Edit" onClick="document.form.action='comprep.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>
<%
rec.Close()
//-----------last year fin info
rec.Source="select * from fin_info where company_id="+cid+" order by fin_year desc"
rec.Open()
%><br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr>
      <td height="120"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband">  <a name="fin">Finance information</a></td>
          </tr>
          <tr> 
            <td width="23%" class="fieldtitle">Year:</td>
            <td colspan="3" class="fielddata"><%=rec.EOF?"":DateField(rec("FIN_YEAR")).substring(6,10)%></td>
          </tr>
          <tr> 
            <td width="23%" class="fieldtitle">Sales last year (US$):</td>
            <td width="22%" class="fielddata"><%=rec.EOF?"":rec("SALES").Value%></td>
            <td width="27%" class="fieldtitle">Net income last year (US$):</td>
            <td width="28%" class="fielddata"><%=rec.EOF?"":rec("NET_INCOME").Value%></td>
          </tr>
          <tr> 
            <td width="23%" class="fieldtitle">Sales growth last year (%):</td>
            <td width="22%" class="fielddata"><%=rec.EOF?"":rec("SALES_GROWTH").Value%></td>
            <td width="27%" class="fieldtitle">Net income grows last year (%):</td>
            <td width="28%" class="fielddata"><%=rec.EOF?"":rec("NET_INCOME_GROWTH").Value%></td>
          </tr>
          <tr> 
            <td width="23%" class="fieldtitle">Emploees number:</td>
            <td colspan="3" class="fielddata"><%=rec.EOF?"":rec("WORKER_COUNT").Value%></td>
          </tr>
        </table>
        <div align="center"> 
          <input type="button" name="FinInfo" value="More info / Edit" onClick="document.form.action='compfall.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>
<%
rec.Close()
//-----------indusries---------
rec.Source="select s.subject from sp_branch s, j_branch j where (j.company_id="+cid+")and (j.branch_id=s.id) order by 1"
rec.Open()
%><br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="53"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband"> <a name="ind">Main industries</a></td>
          </tr>
	<%i=0
	while(!rec.EOF){%>
          <tr> 
            <td  class="fielddataST" <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>><%=!rec.EOF?i+1+". "+rec("SUBJECT").Value:""%></td>
          </tr>
	<%
	i++
	if(!rec.EOF){ rec.MoveNext()}
	}%>
        </table>
        <div align="center"> 
          <input type="button" name="Industry" value="Edit" onClick="document.form.action='compind.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>
 <%
rec.Close()
//-----------goods---------
rec.Source="select s.subject from sp_goods_group s, j_goods_group j where (j.company_id="+cid+")and (j.goods_group_id=s.id) order by 1"
rec.Open()
%><br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="53"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband"><a name="good">Main groups of products 
              and services</a></td>
          </tr>
          <%i=0
	while(!rec.EOF){%> 
          <tr> 
            <td  class="fielddataST" <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>><%=!rec.EOF?i+1+". "+rec("SUBJECT").Value:""%></td>
          </tr>
          <%
	i++
	if(!rec.EOF){ rec.MoveNext()}
	}%> 
        </table>
        <div align="center"> 
          <input type="button" name="Goods" value="Edit" onClick="document.form.action='compgood.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>
 <%
rec.Close()
//-----------brandnames---------
rec.Source="select s.name,j.is_self_make from sp_brandname s, j_brandname j where (j.company_id="+cid+")and (j.brandnames_id=s.id) order by 1"
rec.Open()
%><br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="53"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband"><a name="brand">Trademarks and Servicemarks 
              </a></td>
          </tr>
          <%i=0
	while(!rec.EOF){%> 
          <tr> 
            <td  class="fielddataST" <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>><%=!rec.EOF?i+1+". "+rec("NAME").Value:""%></td>
          </tr>
          <%
	i++
	if(!rec.EOF){ rec.MoveNext()}
	}%> 
        </table>
        <div align="center"> 
          <input type="button" name="Brand" value="Edit" onClick="document.form.action='compbrnd.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>
 <%
rec.Close()
//-----------customers---------
rec.Source="select s.name from sp_customer s, j_customer j where (j.company_id="+cid+")and (j.customer_id=s.id) order by 1"
rec.Open()
%><br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="53"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband"><a name="cust">Main customers</a></td>
          </tr>
          <%i=0
	while(!rec.EOF){%> 
          <tr> 
            <td  class="fielddataST" <%= i%2==0?"bgcolor=\"#E9E9E9\"":""%>><%=!rec.EOF?i+1+". "+rec("NAME").Value:""%></td>
          </tr>
          <%
	i++
	if(!rec.EOF){ rec.MoveNext()}
	}%> 
        </table>
        <div align="center"> 
          <input type="button" name="Customer" value="Edit" onClick="document.form.action='compcust.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>
 <%
rec.Close()
//-----------features---------
%><br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="53"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband">Features</td>
          </tr>
          <tr> 
            <td>
<%
var fs = new ActiveXObject("Scripting.FileSystemObject")
try{
	var ts = fs.OpenTextFile(TextFilePath+Records("ID").Value+FeaturesExt)
	txt=ts.ReadAll()
	if (txt.length>180){
		txt=txt.substring(0,180)
		arr=/\s\w*$/.exec(txt)
		txt=txt.substring(0,txt.length-arr[0].length)+".........."
	}
	Response.Write(txt)
	ts.Close()
}
catch(e){}
%>
	</td>
          </tr>
        </table>
        <div align="center"> 
          <input type="button" name="Feature" value="View / Edit" onClick="document.form.action='compfeat.asp';document.form.submit()">
        </div>
      </td>
    </tr>
  </table>

<%//-----------image---------%>
<br>
  <table width="100%" border="1" cellspacing="0" bordercolorlight="#CCCCCC" bordercolordark="#666666">
    <tr> 
      <td height="53"> 
        <table width="100%" cellspacing="3">
          <tr> 
            <td colspan="4" class="blueband">Company image</td>
          </tr>
          <tr> 
            <td>
<%
var fs = new ActiveXObject("Scripting.FileSystemObject")
is_present=false
if(fs.FileExists(ImageFilePath+cid+".JPG")){ is_present=true }
else{
	if(fs.FileExists(ImageFilePath+cid+".gif")){ is_present=true }
}

%><center>
                <b><%=is_present?"Image is presented.":"Image is not presented."%></b>
</center>
	</td>
          </tr>
        </table>
        <div align="center"> 
          <input type="button" name="Image" value="View / Replace" 
	onClick="document.form.encoding='multipart/form-data';document.form.action='compimg.asp';document.form.submit()">
        </div>
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
      <h5><font size="-4" face="Arial, Helvetica, sans-serif">&copy; 2000, 2001 Onegard International Business LLC, USA</font></h5>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</BODY>
</HTML>
