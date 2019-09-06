<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->


<%
var www1,www2,www3,www4,dsc1,dsc2,dsc3,dsc4
var ErrorMsg=""
var cid=Request.Form("cid")
if (isNaN(parseInt(cid,10))  ){Response.Redirect("complist.asp")}
isFirst=String(Request.Form("Submit"))=="undefined"
%><!-- #include file="inc\is_comp_ok.inc" --><%
//-----------get web pages
Records.Source="select id,name,DESCRIPTION from web_page where company_id="+cid+" order by id"
Records.Open()
var wwwid=new Array(4)
var www=new Array(4)
var dsc=new Array(4)
var i,j
for(i=0;i<4;i++){
	if(!Records.EOF){
		wwwid[i]=Records("ID").Value
		www[i]=Records("NAME").Value
		dsc[i]=Records("DESCRIPTION").Value
		Records.MoveNext()
	}
	else{break}
}
Records.Close()
//----apply updates
if(!isFirst){
	var wwwnew=new Array(4)
	var dscnew=new Array(4)
	i=0
	tmp=TextFormData(Request.Form("www1"),null)
	if(tmp!=null){
		wwwnew[i]=tmp
		dscnew[i]=TextFormData(Request.Form("dsc1"),"")
		i++
	}
	tmp=TextFormData(Request.Form("www2"),null)
	if(tmp!=null){
		wwwnew[i]=tmp
		dscnew[i]=TextFormData(Request.Form("dsc2"),"")
		i++
	}
	tmp=TextFormData(Request.Form("www3"),null)
	if(tmp!=null){
		wwwnew[i]=tmp
		dscnew[i]=TextFormData(Request.Form("dsc3"),"")
		i++
	}
	tmp=TextFormData(Request.Form("www4"),null)
	if(tmp!=null){
		wwwnew[i]=tmp
		dscnew[i]=TextFormData(Request.Form("dsc4"),"")
		i++
	}
	//-----------------------
	Connect.BeginTrans()
	try{
		//-----update which changed DESCRIPTION in form-------
		for(i=0;i<4;i++){
			if(www[i]!=null && dsc[i]!=dscnew[i]){
				Connect.Execute("update web_page set DESCRIPTION='"+dscnew[i]+"' where id="+wwwid[i])
			}
		}

		//-----delete which not present in form-------
		for(i=0;i<4;i++){
			if(www[i]!=null){
				for(j=0;j<4 && www[i]!=wwwnew[j];j++){}
				if(j==4){Connect.Execute("delete from web_page where id="+wwwid[i])}
			}
		}
		//-----insert new in form-----
		for(i=0;i<4;i++){
			if(wwwnew[i]!=null){
				for(j=0;j<4 && wwwnew[i]!=www[j];j++){}
				if(j==4){Connect.Execute("insert into web_page(id,company_id,name,DESCRIPTION)values(gen_id(universal,1),"+cid+",'"+wwwnew[i]+"','"+dscnew[i]+"')")}
			}
		}
		//----------------
		Connect.CommitTrans()

		Response.Redirect("company.asp?cid="+cid)
	}
	catch(e){
		Connect.RollbackTrans()
		ErrorMsg+=ListAdoErrors()
	}
}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<TITLE>Modify company web sites</TITLE>
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
<FORM action="compweb.asp" name="form" method="post">
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
              <p>Company Web sites</p>
            </td>
          </tr>
          <tr class="fieldtitle_L"> 
            <td width="50%" class="fieldtitle_L" ><center>http://
              <input type="text" name="www1" size="30" value="<%=www[0]%>">
                <br>
                coment: 
                <input type="text" name="dsc1" size="30" value="<%=dsc[0]%>">
              </center>
            </td>
            <td width="50%" class="fieldtitle_L" ><center>http://
              <input type="text" name="www2" size="30" value="<%=www[1]%>">
                <br>
                coment: 
                <input type="text" name="dsc2" size="30" value="<%=dsc[1]%>">
              </center>
            </td>
          </tr>
          <tr class="fieldtitle_L"> 
            <td  width="50%" height="2" class="fieldtitle_L"><center>http://
              <input type="text" name="www3" size="30" value="<%=www[2]%>">
                <br>
                coment: 
                <input type="text" name="dsc3" size="30" value="<%=dsc[2]%>">
              </center>
            </td>
            <td  width="50%" height="2" class="fieldtitle_L"><center>http://
              <input type="text" name="www4" size="30" value="<%=www[3]%>">
                <br>
                coment: 
                <input type="text" name="dsc4" size="30" value="<%=dsc[3]%>">
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
