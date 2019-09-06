<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<HTML>
<HEAD>
  <META NAME="GENERATOR" CONTENT="1GARD International Access Card">
  
<TITLE>1GARD International Marketing Network members area</TITLE>
  
<SCRIPT Language="JavaScript">


function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</SCRIPT>
</HEAD>
<BODY BGCOLOR="#ffffff" onLoad="">
<font face="Arial, Helvetica, sans-serif"><a name="top"></a></font>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="20">
  <tr bgcolor="#1d8971"> 
    <td height="30"> 
      <div align="left"><a href="index.asp"></a> <font color="#000099" size="+1" face="Arial, Helvetica, sans-serif"><a href="index.asp">1GRAD 
        International Marketing Network</a></font></div>
    </td>
  </tr>
</table>
<BASEFONT FACE="Arial"> 
<FORM ACTION="chart.htm" METHOD="GET">
  <TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="0" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
    <TR> 
      <TD WIDTH="32%" VALIGN="top"><font face="Arial, Helvetica, sans-serif" color="#006666"><b><font face="Arial, Helvetica, sans-serif" color="#1d8971" size="5">Members 
        area</font></b></font><font color="#c0c0c0" size="5"> </font></TD>
      <TD WIDTH="36%" VALIGN="middle" align="center"> 
        <div align="center"><b><font color="#006666">Welcome, <%=Session("UserFIO")%>.</font></b></div>
      </TD>
      <TD COLSPAN="2" width="32%" valign="middle"> 
        <div align="right"> </div>
      </TD>
    </TR>
    <TR> 
      <TD colspan="4" VALIGN="TOP" bgcolor="#1d8971" bordercolor="#FF9900"> 
        <div align="left"><b><font face="Arial, Helvetica, sans-serif" color="#FFCC99"><img src="images/chart.gif" width="32" height="30" align="absbottom"> 
          Chart Monitor</font></b><font face="Arial, Helvetica, sans-serif" size="-1"> 
          Company : 
          <input type="text" name="textfield" size="12" maxlength="12">
          Extension: 
          <input type="text" name="textfield22" maxlength="4" size="12">
          period: 
          <select name="month" onChange="MM_jumpMenu('parent',this,0)">
            <option value="chart.htm" selected><font color="#FFCC99">September</font></option>
            <option value="chartoct.htm"><font color="#FFCC99">October</font></option>
            <option value="chartoct.htm"><font color="#FFCC99">November</font></option>
            <option value="chartoct.htm"><font color="#FFCC99">December</font></option>
            <option value="chartoct.htm"><font color="#FFCC99">Year 2000</font></option>
          </select>
          <input type="submit" name="Submit" value="Submit">
          </font> 
          <hr>
        </div>
      </TD>
    </TR>
    <TR> 
      <TD COLSPAN="4" BGCOLOR="#1d8971"></TD>
    </TR>
    <TR valign="middle" align="center"> 
      <TD width="32%" bgcolor="#a3c9c1" bordercolor="#1d8971"> 
        <div align="center"> 
          <p><font color="#1e4a7b" face="Arial, Helvetica, sans-serif"><b>1GARD 
            Promotion</b></font><font color="#1e4a7b" face="Arial, Helvetica, sans-serif"><b><br>
            operations</b></font></p>
        </div>
      </TD>
      <TD width="36%" bgcolor="#a3c9c1" bordercolor="#1d8971"><font color="#1e4a7b" face="Arial, Helvetica, sans-serif"><b>Member's 
        account <br>
        operations</b></font></TD>
      <TD COLSPAN="2" width="32%" bgcolor="#a3c9c1" bordercolor="#1d8971"> 
        <div align="center"><font color="#1e4a7b" face="Arial, Helvetica, sans-serif"><b>MARKETCHART 
          <sup><font size="-1">sm</font></sup> International Access Program operations</b></font> 
        </div>
      </TD>
    </TR>
    <TR> 
      <TD VALIGN="TOP" colspan="4"> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" color="#006633">Free 
          services</font></div>
      </TD>
    </TR>
    <TR> 
      <TD VALIGN="TOP" width="32%" bgcolor="#e7e3be"> 
        <ul>
          <li> <font face="Arial, Helvetica, sans-serif" size="-1"><a href="company.asp">View/Modify 
            your company structure</a><br>
            </font></li>
          <li><font face="Arial, Helvetica, sans-serif" size="-1"><a href="sendnews.asp"> 
            Place the press release</a> </font></li>
          <li><font face="Arial, Helvetica, sans-serif" size="-1"><a href="member_1gard_ship.asp">Add 
            the 1GARD Network Member's Logo</a></font></li>
        </ul>
        <div align="center"><img src="images/Network_Member_logo.gif" width="73" height="38" alt="1GARD Network Member Log"><br>
        </div>
      </TD>
      <TD VALIGN="TOP" width="36%" bgcolor="#e7e3be"> 
        <ul>
          <li><font face="Arial, Helvetica, sans-serif" size="-1"><a href="account.asp">Modify 
            account information</a></font></li>
          <li><font face="Arial, Helvetica, sans-serif" size="-1"> <a href="pswd.asp">Modify 
            password</a></font></li>
        </ul>
        </TD>
      <TD COLSPAN="2" VALIGN="TOP" width="32%" bgcolor="#e7e3be"> 
        <ol>
          <li><font face="Arial, Helvetica, sans-serif" size="-1"><a href="company.asp">View/Modify 
            your company structure</a></font></li>
          <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="compdisc.asp">Apply 
            to Access Program </a></font></li>
          <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="member_1gard_card.asp">Add 
            the 1GARD card sign to your site</a> </font></li>
          <li><font face="Arial, Helvetica, sans-serif" size="2">Setup on-line 
            account verification</font> 
            <p><font face="Arial, Helvetica, sans-serif" size="1">See sample: 
              <a href="business_search.asp">1GARD Business search</a><br>
              More Info<br>
              <a href="marketchartagree.asp" target="_blank">Ageement</a></font></p>
          </li>
        </ol>
      </TD>
    </TR>
    <TR> 
      <TD VALIGN="TOP" colspan="4"> 
        <div align="center"></div>
      </TD>
    </TR>
    <TR> 
      <TD VALIGN="TOP" width="32%" bgcolor="#e7e3be">
        <blockquote>
          <p>&nbsp;</p>
        </blockquote>
      </TD>
      <TD VALIGN="TOP" width="36%" bgcolor="#e7e3be">
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="-1"><a href="mailto:member_service@1gard.com">customer 
          service</a></font></div>
      </TD>
      <TD COLSPAN="2" VALIGN="TOP" width="32%" bgcolor="#e7e3be">
        <blockquote> 
          <p>&nbsp;</p>
        </blockquote>
      </TD>
    </TR>
  </TABLE>
  <p align="right"><a href="http://www.amazon.com/exec/obidos/redirect?tag=1gardmarketingne&path=ts/browse-books/3">Business 
    & Investing books</a> <a href="http://www.amazon.com/exec/obidos/redirect?tag=1gardmarketingne&path=subst/lists/best/amazon-bestsellers.html"><br>
    Amazon.com 100 Hot Books</a><br>
    <a href="http://www.amazon.com/exec/obidos/redirect?tag=1gardmarketingne&path=subst/video/sellers/amazon-top-100-video.html">Amazon.com 
    100 Hot Videos</a></p>
  <table width="100%" border="2" cellspacing="1" cellpadding="0" bordercolor="#FFFFFF">
    <tr> 
      <td rowspan="3" valign="top" align="center" width="38"> <img src="images/Onegard_International_Mark3.gif" width="24" height="30"></td>
      <td colspan="4" bgcolor="#006666" width="952" height="19"><font face="Arial, Helvetica, sans-serif" color="#FF9933"><a href="javascript:history.go(-1)"><font face="Arial, Helvetica, sans-serif" color="#FF9933" size="-1">&lt;&lt; 
        Back</font></a><font size="-1"> | <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
        Top</font></a> | <a href="index.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Home</font></a> 
        | </font></font></td>
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
</FORM>

<p>&nbsp;</p>
</BODY>
</HTML>
