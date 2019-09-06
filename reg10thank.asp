<%@LANGUAGE="JAVASCRIPT"%>
<%
if (String(Session("ContactName"))=="undefined"){Response.Redirect("reg10.asp")}
%>
<HTML>
<HEAD>
  <META NAME="GENERATOR" CONTENT="1GARD International Access Card">
  <TITLE>1GARD preregistration 1.0 Thank's</TITLE>
</HEAD>
<BODY BGCOLOR="#ffffff">

<H1><FONT SIZE="+0"><A HREF="index.asp">1GARD  RESEARCH NETWORK</A></FONT></H1>

<P><FONT COLOR="#5c7076" SIZE="-2"><HR ALIGN=LEFT><BR>
</FONT><FONT COLOR="#1d8971" SIZE="-1"><HR ALIGN=LEFT>
</FONT> 
<H2><CENTER>
    <FONT COLOR="#1d8971" SIZE="+0">1GARD  International Network<BR>
    </FONT><FONT COLOR="#1d8971">Preregistration form 1.0 is completed.</FONT> 
  </CENTER></H2>

<P><B>Congratulations</B>, <BR>
  <A NAME="repr_name10"></A><FONT SIZE="+1"><%=Session("ContactName")%></FONT> 
  <BR>
  You'v got member's <FONT COLOR="#1d8971"> </FONT>account. Now you have the right 
  to continue the opperations in members area. <br>
  Choose convenient way. You can start right now (enter in the members area from 
  <a href="index.asp">Network Central</a>).
<P>Please do not forget &quot;User name&quot; and &quot;Password&quot; you entered 
  in the form 1.0.<br>
  You can edit them later for convenience and better protection.<br>
  NOTE: We do not remind Passwords. <BR>
  <br>
  Ask us about problems or difficulties while your membership: <font color="#0000CC">member_service@1gard.com</font> 
  <br>
  In case of any trouble-shooting data we will contact to You for the resolution.
<P>&nbsp;
<P><b>Good luck!</b>
<HR ALIGN=LEFT>
<table width="100%" cellpadding="0" bordercolor="#FFFFFF">
  <tr> 
    <td rowspan="3" valign="top" align="center" width="38"><img src="images/Onegard_International_Mark3.gif" width="24" height="30"></td>
    <td colspan="4" bgcolor="#006666" width="952"> 
      <p><font face="Arial, Helvetica, sans-serif" color="#FF9933"><b><font size="-1"> 
        | <a href="#top"><font face="Arial, Helvetica, sans-serif" color="#FF9933"> 
        Top</font></a> | <a href="index.asp"><font face="Arial, Helvetica, sans-serif" color="#FF9933">Home</font></a> 
        | </font></b></font></p>
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
