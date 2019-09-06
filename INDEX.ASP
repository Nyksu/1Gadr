<%@LANGUAGE="JAVASCRIPT"%>
<%
var ErrorMsg="";
var isFirst=(String(Request.Form("Login"))=="undefined")
if(!isFirst){
	while(1){
		if(Request.Form("username")=="" ||
       	           Request.Form("password")==""){ErrorMsg="Please enter username and password.";break}
%>
<!-- #include file="inc\records.inc" -->
<%
		var SqlStr=new String("select id, is_corp, member_fio, e_mail, phone, phone2, fax, address  from member where logname='%logname' and psw='%psw'")
		SqlStr=SqlStr.replace("%logname",Request.Form("username"))
		SqlStr=SqlStr.replace("%psw",Request.Form("password"))
		Records.Source=SqlStr.toString()
		Records.Open()
		if (Records.EOF){ErrorMsg="Please enter valid username and password.";break}
		Session("UserID")=String(Records("ID").Value)
		Session("UserFIO")=Records("MEMBER_FIO").Value
		Session("UserEmail")=Records("E_MAIL").Value
		Session("UserPhone")=Records("PHONE").Value
		Session("UserPhone2")=Records("PHONE2").Value
		Session("UserFax")=Records("FAX").Value
		Session("UserAddress")=Records("ADDRESS").Value
		Session("UserIsCorp")=Records("IS_CORP").Value
		Records.Close()
		break
	}
	if (ErrorMsg==""){Response.Redirect("area.asp")}
}
%>
<HTML>
<HEAD>
<meta name="keywords" content="Onegard International Marketing  Network, Marketing data, Demographic data, Statistic data">
<TITLE>1gard Marketing Network, Marketing data, Demographic data, Statistic data, 
submit news</TITLE>
<meta name="description" content="1GARD International Marketing  Network, Marketing data, Demographic data, Statistic data, trademark registration, trademark improvement, submit PR news, send news, submit news,  business news collection.">
<Script Language="JavaScript">
<!--Adobe(R) ImageStyler(TM) 1.0 Generated JavaScript. Please do not edit.
isamap = new Object();
isamap[0] = "_df"
isamap[1] = "_ov"
isamap[2] = "_ot"
isamap[3] = "_dn"

function isimgact(id, act)
{
	if(document.images) document.images[id].src = eval( "isimages." + id + isamap[act] + ".src");
}

if (document.images) { // ensure browser can do JavaScript rollovers.
isimages = new Object();
isimages.Onegard_International_Marketing_df = new Image();
isimages.Onegard_International_Marketing_df.src = "images/marketing_promotion_members.gif";

isimages.Onegard_International_Marketing_ov = new Image();
isimages.Onegard_International_Marketing_ov.src = "images/marketing_promotion_membeov.gif";

isimages.Onegard_International_Marketing2_df = new Image();
isimages.Onegard_International_Marketing2_df.src = "images/marketing_resours.gif";

isimages.Onegard_International_Marketing2_ov = new Image();
isimages.Onegard_International_Marketing2_ov.src = "images/marketing_resoursov.gif";

isimages.Onegard_International_Marketing4_df = new Image();
isimages.Onegard_International_Marketing4_df.src = "images/business_search.gif";

isimages.Onegard_International_Marketing4_ov = new Image();
isimages.Onegard_International_Marketing4_ov.src = "images/business_searchov.gif";

isimages.Onegard_International_Marketing5_df = new Image();
isimages.Onegard_International_Marketing5_df.src = "images/discount_network.gif";

isimages.Onegard_International_Marketing5_ov = new Image();
isimages.Onegard_International_Marketing5_ov.src = "images/discount_networkov.gif";

isimages.Onegard_International_Marketing6_df = new Image();
isimages.Onegard_International_Marketing6_df.src = "images/international_business_rela.gif";

isimages.Onegard_International_Marketing6_ov = new Image();
isimages.Onegard_International_Marketing6_ov.src = "images/international_business_reov.gif";

isimages.Onegard_International_Marketing8_df = new Image();
isimages.Onegard_International_Marketing8_df.src = "images/market_researcher.gif";

isimages.Onegard_International_Marketing8_ov = new Image();
isimages.Onegard_International_Marketing8_ov.src = "images/market_researcherov.gif";

}
// end generated JavaScript. -->
</Script>
</HEAD>
<BODY BGCOLOR="#ffffff">
<h1 align="left"><font color="#666666" size="+1" face="Arial, Helvetica, sans-serif">International 
  Marketing Network: On-line Marketing Data &amp; Demographic Data </font></h1>
<FORM ACTION="index.asp" METHOD="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td rowspan="4" width="197" align="left" valign="bottom"><font size="-1"><font size="-1"><font color="#a3c9c1" size="+1"><b><font color="#a3c9c1" size="+1"><b><font size="-1"><font color="#a3c9c1" size="+1"><b><font color="#a3c9c1" size="+1"><b><font color="#a3c9c1" size="+1"><a href="membership.htm" onMouseOut="isimgact( 'Onegard_International_Marketing',0)"  onMouseOver="isimgact( 'Onegard_International_Marketing',1)"  ><img src="images/marketing_promotion_members.gif" border="0" height="27" width="196" name="Onegard_International_Marketing" alt="About  International Business Promotion  and Marketing Research Opportunity"><br>
        </a></font></b></font></b></font></font></b></font></b></font></font></font><font face="Arial, Helvetica, sans-serif"><img src="images/Onegard_International_Mark2.gif" border="0" name="Onegard_International_Marketing7" alt="Onegard International Marketing Network"></font></td>
      <td width="253" valign="top" height="24"><a href="business.htm" onMouseOut="isimgact( 'Onegard_International_Marketing2',0)"  onMouseOver="isimgact( 'Onegard_International_Marketing2',1)"  ><img src="images/marketing_resours.gif" border="0" height="16" width="89" name="Onegard_International_Marketing2" alt="Online marketing resource"></a></td>
      <td width="257" valign="top" height="24">&nbsp;</td>
      <td rowspan="4" valign="top" width="280"> 
        <div align="right"> 
          <p align="right"><b><b><font face="Arial, Helvetica, sans-serif"><b><b></b></b></font></b></b></p>
        </div>
      </td>
    </tr>
    <tr> 
      <td width="253" valign="top" height="24"><a href="business_search.asp" onMouseOut="isimgact( 'Onegard_International_Marketing4',0)"  onMouseOver="isimgact( 'Onegard_International_Marketing4',1)"  ><img src="images/business_search.gif" border="0" height="14" width="99" name="Onegard_International_Marketing4" alt="International Business Search Tool"></a></td>
      <td width="257" valign="top" height="24">&nbsp;</td>
    </tr>
    <tr> 
      <td width="253" valign="top" height="21"><a href="business_partner.htm" onMouseOut="isimgact( 'Onegard_International_Marketing6',0)"  onMouseOver="isimgact( 'Onegard_International_Marketing6',1)"  ><img src="images/international_business_rela.gif" border="0" name="Onegard_International_Marketing6" alt="Business Partnership, International relations, International marketing agencies"></a></td>
      <td width="257" valign="top" height="21">&nbsp;</td>
    </tr>
    <tr> 
      <td width="253" valign="top"><a href="market_researcher.htm" onMouseOut="isimgact( 'Onegard_International_Marketing8',0)"  onMouseOver="isimgact( 'Onegard_International_Marketing8',1)"  ><img src="images/market_researcher.gif" border="0" name="Onegard_International_Marketing8" alt="Onegard International Business hires market researchers"></a></td>
      <td width="257" valign="top">&nbsp;</td>
    </tr>
    <tr align="left"> 
      <td colspan="4" valign="middle" bgcolor="#1d8971"><b><font face="Arial, Helvetica, sans-serif"><%if(ErrorMsg!=""){ %> 
        <font color="#FF0033"><%=ErrorMsg%></font></font> 
        <font face="Arial, Helvetica, sans-serif"><%}%> 
        <%=ErrorMsg!=""?"<br>":""%> 
        <font color="#c2c2fe">access to member's area:</font></font></b> <font color="#FFCC00" face="Arial, Helvetica, sans-serif">user 
        name</font> <font face="Arial, Helvetica, sans-serif"> 
        <input
    name="username" type="text" size="15" value="<%=Request.Form("username")%>">
        <font color="#FFCC00">password</font></font> <font face="Arial, Helvetica, sans-serif"> 
        <input type="password" name="password" size="15">
        <input
    name="Login" type="submit" value="Login">
        </font> <b><b><font face="Arial, Helvetica, sans-serif"><b><b><font face="Arial, Helvetica, sans-serif"><b><b><b><b><b><font face="Arial, Helvetica, sans-serif"><b><b><font face="Arial, Helvetica, sans-serif"><b><a href="agrememb.htm"><font color="#FFCC00">Join</font></a></b></font></b></b></font></b></b></b></b></b></font></b></b></font></b> 
        </b> </td>
    </tr>
  </table>


  <table width="100%" border="2" cellspacing="1" cellpadding="0"
height="24" bordercolor="#336633">
    <tr> 
      <td height="1" colspan="4" bgcolor="#1d8971"></td>
    </tr>
    <tr> 
      <td colspan="4" bgcolor="#a3c9c1" height="2"> 
        <p><font size="-1"><font face="Arial, Helvetica, sans-serif"> <a href="business%20news.htm">Business 
          News</a> | <a href="business_search.asp">Business Search</a> | <a href="international%20business%20promotion.htm">Promote 
          Your Business</a> | <a href="international%20marketing%20researches.htm">On-line 
          Marketing Data &amp; Marketing surveys</a>| <a href="demographic_statistics.htm">MARKETCHART 
          <sup><font size="-1">sm</font></sup> <font size="-4"><font size="-1">Program</font></font> 
          </a> |</font></font></p>
      </td>
    </tr>
  </table>
</form>
  
<table border="0" cellspacing="2" cellpadding="0" width="100%">
  <tr> 
    <td colspan="2" align="left" bordercolor="#009933" valign="top" rowspan="5"> 
      <table width="99%" border="1" cellspacing="0" cellpadding="0" bordercolor="#009933" height="4%">
        <tr> 
          <td height="45" width="44%" bgcolor="#dfeae8" bordercolor="#dfeae8"> 
            <div align="center"><font color="#ff0000"><a href="access_card.htm"><img src="images/cardbot.gif" border="0" alt="get personal access Onegard card"></a></font></div>
          </td>
          <td height="45" width="48%" bgcolor="#dfeae8" bordercolor="#dfeae8" valign="middle"><font color="#ff0000"><b><a href="access_card.htm"><font size="-7" face="Arial, Helvetica, sans-serif">Get 
            personal Access Card</font></a></b></font></td>
        </tr>
      </table>
      <font color="#ff0000"></font><font face="Arial, Helvetica, sans-serif" size="1"><b><a href="demographic_statistics.htm">Marketchart</a></b><b></b></font><font face="Arial, Helvetica, sans-serif" size="1"><b> 
      &#153;</b></font><font face="Arial, Helvetica, sans-serif" size="1"><b> 
      </b></font> 
      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#1d8971">
        <tr bordercolor="#a3c9c1" bgcolor="#a3c9c1"> 
          <td> 
            <div align="center"><font face="Arial, Helvetica, sans-serif"><a href="business%20news.htm"><font size="2"><b>OUR 
              HEADLINES :</b></font></a></font></div>
          </td>
        </tr>
        <tr bordercolor="#FFFFFF" valign="top"> 
          <td height="163"> 
            <p align="left"><font face="Arial, Helvetica, sans-serif" size="2">Charitableway 
              Is Bringing Automated Giving to the Workplace and $36 Million to 
              Charity<br>
              <font size="1"><a href="news/businessnews01.02.asp">read story</a><br>
              </font><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font color="#339900">_______________________</font></b></font></font><font size="2"></font></b></font></font><font size="1"> 
              </font></font></p>
            <p align="left"><font face="Arial, Helvetica, sans-serif" size="2">Intel 
              Achieves InfiniBand Milestone, Ships Product Samples to the Industry<br>
              <font size="1"><b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><a href="business%20news.htm#j">read 
              story</a><font color="#339900"></font></b></font></font></b></font> 
              <br>
              <font size="1"><b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font color="#339900">_______________________</font></b></font></font><font size="2"></font></b></font><br>
              </font><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font size="2">junum 
              </font></b></font></font></b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><font size="2">Completes 
              Development of Electronic Signatures Integration</font><font color="#339900" size="2"></font></font></font><b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><br>
              <a href="business%20news.htm#j">read story</a><font color="#339900"> 
              <br>
              _______________________</font></b></font></font><font size="2"><br>
              PrinterOn </font></b><font size="2">Demos New Way to Deliver Documents 
              Using Internet Printing with </font><br>
              <font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><font size="2">PrintWhere</font></font></font><b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font size="2">.<br>
              </font></b></font></font></b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><font size="2"><a href="business%20news.htm"><font size="1">read 
              story</font></a></font></font></font><b> <br>
              </b></font><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font face="Arial, Helvetica, sans-serif" size="2"><font size="1"><b><font color="#339900">_______________________</font></b></font></font><font size="2"></font></b></font></font><font size="1"><b> 
              </b></font></font><font size="2"><br>
              <font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><b>eMarketer</b> 
              Names Allstate.com Best Insurance Website</font><b><br>
              </b><a href="business%20news.htm#ipr"><font size="1">read story</font></a><b><br>
              </b></font></font></p>
          </td>
        </tr>
      </table>
      <p align="left"><font color="#a3c9c1" face="Arial, Helvetica, sans-serif" size="1"><font color="#FF3300"><a href="agrememb.htm">Submit 
        PR News <br>
        Attach Photo</a></font></font><font face="Arial, Helvetica, sans-serif" size="1"><a href="actuality.htm"><br>
        Policy of the data actuality</a><br>
        <br>
        <a href="business.htm">promotion<br>
        power search<br>
        public relations<br>
        International Marketing Research <br>
        advertising</a></font></p>
      <br>
      &nbsp;<font size="2"><a href="banner_exchange.htm"><font face="Arial, Helvetica, sans-serif">Banner 
      exchange</font></a></font></td>
    <td width="60%" rowspan="5" valign="TOP"> 
      <blockquote> 
        <h2><font color="#1e4a7b" face="Arial, Helvetica, sans-serif" size="3">1GARD 
          launch business society into the brand-new&nbsp;marketing system.</font></h2>
        <p><font face="Arial, Helvetica, sans-serif" size="2">1GARD represents 
          an absolutely new approach of collecting, processing and distribution 
          of marketing data by using the 1GARD Marketing technology. We invite 
          your business to join the 1GARD 's System.</font></p>
        <p><font face="Arial, Helvetica, sans-serif" size="2">1GARD 's International 
          Access Program renders the advantages for members to economize International 
          Marketing Research budget, and to reduce the prime cost of products 
          and services as a result. This System initiates great moneysaving opportunity 
          for the member's audience.</font> </p>
        <p> 
          <center>
          </center>
        </p>
      </blockquote>
      <p> 
      <blockquote><font face="Arial"> 
        <hr align=LEFT size="1" noshade>
        </font> 
        <p><font face="Arial" size="2">The first results of researches carried 
          out by the research team of 1GARD exceed all expectations.</font></p>
        <p><font face="Arial" size="2">We have met an interest from the side of 
          the business people for such detailed and accessible data. We also have 
          felt the great optimism on the occassion of using the System of discounts 
          and free services access from the companies engaged in electronic on-line 
          commerce. They need &quot;sense of trends&quot; because of the dynamic 
          distinctive features of industry. The companies involved into new markets 
          require the urgent and frequently indexing data.</font></p>
        <h6> 
          <center>
            <font face="Arial"> 
            <hr noshade size="1">
            </font> 
          </center>
        </h6>
      </blockquote>
    </td>
    <td width="1" rowspan="5" bgcolor="#1d8971"></td>
    <td width="25%" rowspan="3" valign="TOP" bgcolor="#e7e3be"> 
      <form action="http://directory.wwwresources.com/directory.cgi">
        <table width="96%" border="1" cellspacing="0" cellpadding="0" bordercolor="#1d8971" align="center">
          <tr bordercolor="#a3c9c1" bgcolor="#a3c9c1"> 
            <td> 
              <div align="center"> 
                <input type=hidden name=user value="onegard">
                <font face=Arial size=2><b>Search the Web: 
                <input type=text name=search2>
                </b></font></div>
            </td>
          </tr>
          <tr bordercolor="#FFFFFF" valign="top"> 
            <td height="28"> 
              <div align="right"> 
                <p align="center"> 
                  <input type=submit value=Search name="submit">
                  <font size="2"><font face="Arial, Helvetica, sans-serif"><b> 
                  </b></font></font></p>
              </div>
            </td>
          </tr>
        </table>
      </form>
      <blockquote> 
        <h5><font face="Arial, Helvetica, sans-serif" size="2"><a href="business%20news.htm#InfiniBand"><b>Intel 
          Achieves InfiniBand Milestone, Ships Product Samples to the Industry</b></a></font><font color="#1d8971" size="1" face="Arial, Helvetica, sans-serif"><br>
          </font><font color="#1d8971"> </font></h5>
        <h5><font color="#1d8971"> 
          <hr align=LEFT>
          </font><font size="1" face="Arial, Helvetica, sans-serif">The administration 
          of the Onegard International Business has resolved to launch into the 
          first stage of the development of the international Access Program MARCETCHART.<br>
          <a href="demographic_statistics.htm">See details</a>.</font></h5>
        <h5><font size="1" face="Arial, Helvetica, sans-serif">1GARD.NET is glad 
          to inform you about new features added to our web server:<br>
          <a href="business_search.asp">Power Search Box </a><br>
          - business search service</font></h5>
        <h5><font size="1" face="Arial, Helvetica, sans-serif"><a href="international%20business%20promotion.htm">MARKET 
          SHARE<br>
          free promotion program<br>
          </a> is the market positioning tool<br>
          </font></h5>
        <h5><font size="2"><a href="banner_exchange.htm"><font face="Arial, Helvetica, sans-serif">Marketing 
          Banner exchange</font></a></font></h5>
      </blockquote>
    </td>
  </tr>
  <tr> </tr>
  <tr> </tr>
  <tr> 
    <td width="25%" bgcolor="#a3c9c1" valign="TOP"> 
      <blockquote> 
        <p><font size="1" face="Arial, Helvetica, sans-serif">&nbsp;1GARD has 
          started to hire the regional representatives.<br>
          <a href="market_researcher.htm">See details.</a></font></p>
      </blockquote>
    </td>
  </tr>
  <tr> 
    <td width="25%" valign="top"> 
      <p><font color="#a3c9c1" size="1" face="Arial, Helvetica, sans-serif">....</font><font color="#015898" size="1" face="Arial, Helvetica, sans-serif">.</font><font size="1" face="Arial, Helvetica, sans-serif">...powerful..</font><font color="#a3c9c1" size="1" face="Arial, Helvetica, sans-serif">..<br>
        </font><font size="1" face="Arial, Helvetica, sans-serif"><a href="business_search.asp">business 
        search&nbsp;box</a></font><font color="#1e4a7b" size="1" face="Arial, Helvetica, sans-serif">____<br>
        </font><font size="1" face="Arial, Helvetica, sans-serif">service of Access 
        for Cardholders only</font></p>
      <p><a href="http://www.amazon.com/exec/obidos/redirect?tag=1gardmarketingne&path=ts/browse-books/3"><font face="Arial, Helvetica, sans-serif" size="2">Business 
        & Investing books<br>
        </font></a><a href="http://www.freebizsites.com/home.htm"><font face="Arial, Helvetica, sans-serif" size="2">FreeBizSites.com</font></a></p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
    <tr> 
      <td rowspan="3" valign="top" align="center" width="38"><a href="access_card.htm"><img src="images/cardbot.gif" border="0" alt="get personal access Onegard card"></a></td>
      <td colspan="4" bgcolor="#006666" width="952"><font face="Arial, Helvetica, sans-serif" color="#FF9933"><a href="javascript:history.go(-1)"><font face="Arial, Helvetica, sans-serif" color="#FF9933" size="-1">&lt;&lt; 
        Back</font></a><font size="-1"> | <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
        Top</font></a> |</font></font></td>
    </tr>
    <tr align="center"> 
      <td colspan="4" width="952"> 
        <h4><font size="-1"><font face="Arial, Helvetica, sans-serif" size="-5"> 
          | <a href="business%20news.htm">Business News</a> | <a href="business_search.asp">Business 
          Search</a> | <a href="international%20business%20promotion.htm">Promote 
          Your Business</a> | <a href="international%20marketing%20researches.htm">Marketing 
          surveys</a>| <a href="demographic_statistics.htm">MARKETCHART <sup><font size="-1">sm</font></sup> 
          Program </a> |</font></font></h4>
      </td>
    </tr>
    <tr valign="middle" align="center"> 
      <td colspan="4" width="952"> 
        <h5><font size="-4" face="Arial, Helvetica, sans-serif">&copy; 2000, 2001 Onegard<a href="http://www.1gard.com"> 
          International Business</a> LLC, USA</font></h5>
      </td>
    </tr>
  </table>


</BODY>
</HTML>
