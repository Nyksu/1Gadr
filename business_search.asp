<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\next_id.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<%
var ErrorMsg=""
var strResult=""
var HTTPObj=Server.CreateObject("khttp.inet")
isFirst=String(Request.Form("Submit"))=="undefined"
ShowForm=true
if(!isFirst){
	while(1){
		//-------------input validation-----------
		compname=TextFormData(Request.Form("compname"),"")
		partname=TextFormData(Request.Form("partname"),"")
		comptype=TextFormData(Request.Form("comptype"),"")
		country=TextFormData(Request.Form("country"),"")
		city=TextFormData(Request.Form("city"),"")
		industry=TextFormData(Request.Form("industry"),"")
		products=TextFormData(Request.Form("products"),"")
		trades=TextFormData(Request.Form("trades"),"")
		head=TextFormData(Request.Form("head"),"")
		if(compname=="" && partname=="" && 
			comptype=="" && country==0 && 
			city=="" && industry=="" &&	
			products=="" && trades==""){ErrorMsg="No one search field specified."}
		if(compname.length>80){ErrorMsg+="Field 'Company name' is too long.<br>"}
		if(partname.length>80){ErrorMsg+="Field 'Parts of company name' is too long.<br>"}
		if(comptype.length>20){ErrorMsg+="Field 'Company type' is too long.<br>"}
		if(city.length>80){ErrorMsg+="Field 'City' is too long.<br>"}
		if(industry.length>80){ErrorMsg+="Field 'Industry' is too long.<br>"}
		if(products.length>80){ErrorMsg+="Field 'Kinds of products' is too long.<br>"}
		if(trades.length>80){ErrorMsg+="Field 'Trademarks' is too long.<br>"}

		card=TextFormData(Request.Form("card"),"")
		if(card.length!=20){ErrorMsg+="Card number must be 20 digits.<br>"}
		email=TextFormData(Request.Form("email"),"")
		if(!/(\w+)@((\w+).)*(\w+)$/.test(email)){ErrorMsg+="Invalid e-mail address.<br>"}
		if(ErrorMsg!=""){break}

		HTTPObj.addpostvars("ver","1")
		HTTPObj.addpostvars("comp","5796")
		HTTPObj.addpostvars("ext","2")
		HTTPObj.addpostvars("card",card)
		try{
			HTTPObj.openurl("HTTP://www.1gard.net/bill.asp","POST")
			strResult=HTTPObj.content
		}
		catch(e){
			ErrorMsg+="Error. Can't connect to the URL.<br>"
			break
		}
		if(strResult==0){ErrorMsg+="Card is not Exist.<br>";break}
		if (strResult==3) {ErrorMsg+="Invalid parameters.<br>";break}
		if (strResult==4) {ErrorMsg+="Invalid client version.<br>";break}
		if (strResult=="") {ErrorMsg+="Answer was not ressived.<br>";break}
		if (strResult!=1) {ErrorMsg+="Unknown error.<br>";break}

		//-----------insert request-----------		
		sql="insert into power_search(ID,COMPANY_NAME, PART_NAME, TYPE, "+
							"TP_SEARCH, COUNTRY_ID, CITY, "+
							"INDUSTRY, GOODS, TRADEMARK, "+
							"TIME_SEARCH, E_MAIL, CARD_NUMBER) "+ 
			"values(%id,'%compname','%partname','%comptype',%tp,%country,"+
				"'%city','%industry','%products','%trades','NOW','%email','%card')"
		sql=sql.replace("%id",NextID("JURNAL_ID"))
		sql=sql.replace("%compname",compname)
		sql=sql.replace("%partname",partname)
		sql=sql.replace("%comptype",comptype)
		sql=sql.replace("%tp",IntFormData(Request.Form("head"))+IntFormData(Request.Form("head2")))
		sql=sql.replace("%country",country==0?"null":country)
		sql=sql.replace("%city",city)
		sql=sql.replace("%industry",industry)
		sql=sql.replace("%products",products)
		sql=sql.replace("%trades",trades)
		sql=sql.replace("%email",email)
		sql=sql.replace("%card",card)
		ss=0
		try{
			Connect.Execute(sql)
	 		ShowForm=false
		}
		catch(e){
			ErrorMsg+=ListAdoErrors()
		}
		break
	}
}
%>
<HTML>
<HEAD>
<META NAME="KEYWORDS" CONTENT="1GARD International Access Card">
  
<TITLE>1GARD Poweful Business Searching System</TITLE>
</HEAD>
<BODY BGCOLOR="#ffffff" LINK="#1e4a7b">
<h1><font face="Arial, Helvetica, sans-serif"><a name="top"></a><a href="index.asp"><img src="images/Onegard_International_Mark2.gif" border="0" name="Onegard_International_Marketing7" alt="Onegard International Marketing Network" align="texttop"></a></font> 
</h1>
<FORM ACTION="business_search.asp" METHOD="post" name="form">
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="0">
    <TR> 
      <TD WIDTH="235" VALIGN="TOP"><font size="+2" face="Arial, Helvetica, sans-serif">&nbsp;&nbsp;</font><font color="#a3c9c1" size="+2" face="Arial, Helvetica, sans-serif">....</font><font color="#015898" size="+2" face="Arial, Helvetica, sans-serif">.</font><font size="+2" face="Arial, Helvetica, sans-serif">..</font><font size="+3" face="Arial, Helvetica, sans-serif">.</font><font size="+2" face="Arial, Helvetica, sans-serif">powerful</font><font size="+3" face="Arial, Helvetica, sans-serif">.</font><font size="+2" face="Arial, Helvetica, sans-serif">.</font><font color="#a3c9c1" size="+2" face="Arial, Helvetica, sans-serif">..<br>
        </font><font color="#1e4a7b" size="+1" face="Arial, Helvetica, sans-serif">business 
        search&nbsp; box</font><font color="#1e4a7b" face="Arial, Helvetica, sans-serif">_____<br>
        </font><font size="-2" face="Arial, Helvetica, sans-serif">service for 
        account holders only</font> </TD>
      <TD WIDTH="455" VALIGN="TOP" align="center"><font face="Arial, Helvetica, sans-serif"></font> 
      </TD>
      <TD WIDTH="290" ALIGN="CENTER" VALIGN="TOP"> 
        <P ALIGN=LEFT><font face="Arial, Helvetica, sans-serif"><a href="business%20search%20info.htm">How 
          to use Business Search</a> <br>
          <a href="actuality.htm">Policy of the data actuality<br>
          </a></font><a href="copyrights.htm"><font face="Arial, Helvetica, sans-serif">Copyright 
          notice</font></a> 
        </TD>
    </TR>
    <TR> 
      <TD COLSPAN="3" BGCOLOR="#1d8971"></TD>
    </TR>
    <TR> 
      <TD COLSPAN="3" BGCOLOR="#1d8971"></TD>
    </TR>
  </TABLE>
  <table width="100%" border="2" cellspacing="1" cellpadding="0"
height="24" bordercolor="#336633">
    <tr> 
      <td height="1" colspan="4" bgcolor="#1d8971"></td>
    </tr>
    <tr> 
      <td colspan="4" bgcolor="#a3c9c1" height="2"> 
        <p><font size="-1"><a href="index.asp"><font face="Arial, Helvetica, sans-serif">Network 
          Home</font></a><font face="Arial, Helvetica, sans-serif"> | <a href="business%20news.htm">Business News</a> | <a href="international%20business%20promotion.htm">Promote 
          Your Business</a> | <a href="international%20marketing%20researches.htm">Marketing 
          surveys</a>| <a href="demographic_statistics.htm">MARKETCHART  <sup><font size="-1">sm</font></sup> <font size="-4"><font size="-1">Program</font></font> </a> |</font></font></p>
      </td>
    </tr>
  </table>
<%if(ShowForm){%>
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="4" CELLPADDING="0"
HEIGHT="784">
    <TR> 
      <TD WIDTH="10%" HEIGHT="12">&nbsp; </TD>
      <TD WIDTH="61%" BGCOLOR="#a3c9c1" HEIGHT="12"> 
        <p><!-- impressionz 468x60 code PAGE 1--> </p>
        <center>
          <table cellpadding=0 cellspacing=0 border=0>
            <tr> 
              <td bgcolor=#663399><a href="http://www.impressionz.com/cgi-bin/adnet/rd2.cgi?a=854p1&s=468x60" target="_top"><img src="http://www.impressionz.com/cgi-bin/adnet/bi2.cgi?a=854p1&s=468x60" width="468" height="60" border=0 hspace=0 vspace=0 alt="Impressionz.com - Internet Advertising Exchange"></a></td>
            </tr>
            <tr> 
              <td><a href="http://www.impressionz.com/cgi-bin/adnet/map/clickimage.pl" target="_top"><img src="http://www.impressionz.com/images/468bar.gif" width=468 height=16 ismap border=0 alt="impressionz sponsor bar"></a></td>
            </tr>
          </table>
        </center>
        <!-- end code --> </TD>
      <TD rowspan="4" BGCOLOR="#a3c9c1" HEIGHT="316" valign="top" align="center"> 
        <P>&nbsp; 
        <P>&nbsp; 
        <P>&nbsp; 
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="10%" HEIGHT="412" VALIGN="TOP">&nbsp; </TD>
      <TD WIDTH="61%" ROWSPAN="3" VALIGN="TOP"> 
        <P><FONT FACE="Arial">&nbsp;&nbsp;</FONT><FONT COLOR="#a3c9c1"
     FACE="Arial">....</FONT><FONT COLOR="#015898" FACE="Arial">.</FONT><FONT
     FACE="Arial">..</FONT><FONT SIZE="+1" FACE="Arial">.</FONT><FONT
     FACE="Arial">powerful</FONT><FONT SIZE="+1" FACE="Arial">.</FONT><FONT
     FACE="Arial">.</FONT><FONT COLOR="#a3c9c1" FACE="Arial">..<BR>
          </FONT><FONT COLOR="#1e4a7b" SIZE="-1" FACE="Arial">business search&nbsp; 
          box</FONT><FONT COLOR="#1e4a7b" SIZE="-2" FACE="Arial">_____</FONT><FONT
     SIZE="-2" FACE="Arial">service for account holders only</FONT> 
        <P align="center"> <%if(ErrorMsg!=""){%> 
        <center>
          <h2> 
            <p> <font color="#FF3300">Processing error.</font> <br>
              <%=ErrorMsg%></p>
          </h2>
        </center>
        <%}%> <FONT
     SIZE="-1"> 
        <HR ALIGN=LEFT>
        </FONT><font size="-1"> </font> 
        <OL>
          <LI><FONT SIZE="-1">Specify the name of the company you are interested 
            in. <BR>
            </FONT> 
            <INPUT NAME="compname" TYPE="text" SIZE="30" value="<%=isFirst?"":Request.Form("compname")%>">
          <LI><FONT SIZE="-1">If you do not know the exact name of the company, 
            specify known parts of the name. <BR>
            <INPUT NAME="partname" TYPE="text" SIZE="37" value="<%=isFirst?"":Request.Form("partname")%>">
            </FONT> 
          <LI><FONT SIZE="-1">Type of organization<BR>
            <INPUT NAME="comptype" TYPE="text" SIZE="37" value="<%=isFirst?"":Request.Form("comptype")%>">
            </FONT> 
          <LI><FONT SIZE="-1">You search for <BR>
            head office 
            <INPUT TYPE="checkbox" NAME="head" VALUE="1" <%=!isFirst&&Request.Form("head")!="1"?"":"CHECKED"%>>
            or regional division 
            <INPUT TYPE="checkbox" NAME="head2" VALUE="2" <%=!isFirst&&Request.Form("head2")=="2"?"CHECKED":""%>>
            of the company.</FONT> 
          <LI><FONT SIZE="-1">The country of a possible location of the company 
            or division.<BR>
            <select name="country">
              <option value="0" <%=Request.Form("country")=="0"?"selected":""%>>Select 
              country</option>
              <%
				Records.Source="select * from sp_country where not shortname is null order by name"
				Records.Open()
				while(!Records.EOF){%> 
              <option value="<%=Records("ID").Value%>" 
					<%=!isFirst&&Records("ID").Value==Request.Form("country")?"selected":""%>> 
              <%=Records("NAME").Value%> </option>
              <%	Records.MoveNext()
				}
				Records.Close()
				%> 
            </select>
            </FONT> 
          <LI><FONT SIZE="-1">City<BR>
            <INPUT NAME="city" TYPE="text" SIZE="37" value="<%=isFirst?"":Request.Form("city")%>">
            </FONT> 
          <LI><FONT SIZE="-1">What industry does the company work in?<BR>
            <INPUT NAME="industry" TYPE="text" SIZE="37" value="<%=isFirst?"":Request.Form("industry")%>">
            </FONT> 
          <LI><FONT SIZE="-1">Specify kinds of product(s) or service(s) of the 
            company.<BR>
            <INPUT NAME="products" TYPE="text" SIZE="37" value="<%=isFirst?"":Request.Form("products")%>">
            </FONT> 
          <LI><FONT SIZE="-1">Trademarks.<BR>
            <INPUT NAME="trades" TYPE="text" SIZE="37" value="<%=isFirst?"":Request.Form("trades")%>">
            <BR>
            <HR ALIGN=LEFT WIDTH="78%">
            <BR>
            </FONT> 
          <LI><FONT SIZE="-1">Indicate your e-mail to receive report <BR>
            </FONT> 
            <INPUT NAME="email" TYPE="text" SIZE="30" value="<%=isFirst?"":Request.Form("email")%>">
            <br>
            <FONT SIZE="-1"><font face="Arial, Helvetica, sans-serif"> </font> 
            </FONT> 
          <LI> 
            <table width="388" border="1" cellpadding="0" cellspacing="0" bgcolor="#FFCC33" bordercolor="#339966" height="43">
              <tr valign="middle" align="center"> 
                <td colspan="2" height="23"><a href="access_card.htm"><img src="images/cardbot.gif" align="absmiddle" border="0" alt="Get personal access card"></a><b><font size="-1"><font face="Arial, Helvetica, sans-serif"> 
                  Access Card :</font></font><font color="#015898"> </font><font size="-1"> 
                  <input name="card"
      type="password" size="30" value="<%=isFirst?"":Request.Form("card")%>">
                  </font></b></td>
              </tr>
            </table>
            <FONT SIZE="-1"><BR>
            </FONT> 
        </OL>
        <CENTER>
          <INPUT NAME="Submit" TYPE="submit" VALUE="Research ">
          <INPUT NAME="name"
    TYPE="reset" VALUE="Clear">
          <HR WIDTH="99%">
          <BR>
          <FONT SIZE="-1">The requests will be processed in the sequence in which 
          they have arrived. Thus you can receive a complete report in 2-3 days.</FONT> 
        </CENTER>
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="10%" HEIGHT="19" VALIGN="TOP">&nbsp; </TD>
    </TR>
    <TR> 
      <TD WIDTH="10%" HEIGHT="304" VALIGN="TOP">&nbsp; </TD>
    </TR>
  </TABLE>
  <%}
else{%>
  <center>
    <h2>Thank You!<br>
      Your request submited.</h2>
    <p><font size="-1">The requests will be processed in the sequence in which 
      they have arrived. Thus you can receive a complete report in 2-3 days.</font></p>
    <p><font face="Arial, Helvetica, sans-serif"><a href="index.html">Network 
      Central</a><br>
      <a href="business%20news.htm">International Business News</a></font> </p>
  </center>
  <%}%> 
  <table width="100%" border="0" cellspacing="1" cellpadding="0">
    <tr> 
      <td rowspan="3" valign="top" align="center" width="38"><a href="access_card.htm"><img src="images/cardbot.gif" border="1" alt="get personal access Onegard card"></a></td>
      <td colspan="4" bgcolor="#006666" width="952"><font face="Arial, Helvetica, sans-serif" color="#FF9933"><a href="javascript:history.go(-1)"><font face="Arial, Helvetica, sans-serif" color="#FF9933" size="-1">&lt;&lt; 
        Back</font></a><font size="-1"> | <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
        Top</font></a> | </font></font></td>
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
        <h5><font size="-4" face="Arial, Helvetica, sans-serif">&copy; 2000 Onegard International Business LLC, USA</font></h5>
      </td>
    </tr>
  </table>
</FORM>

</BODY>
</HTML>
