<%@LANGUAGE="JAVASCRIPT"%>
<%
var ErrorMsg=""
var isFirst=(String(Request.Form("RegSubmit"))=="undefined")
if (!isFirst){
		while(1){
			if (Request.Form("proxy") == "1"){
				ErrorMsg="You must to be the proxy representative or owner of the company to make this registration."
				break
			}
			if (Request.Form("username") == "") {ErrorMsg="User name is not specified.";	break}
			if ( (String( Request.Form("password1")) != String(Request.Form("password2")) ||  Request.Form("password1"))=="" ){
				ErrorMsg="Password does not match."
				break
			}
			if (String(Request.Form("password1")).length<5){ErrorMsg="Password must be at least 5 characters.";break}
			if (Request.Form("contactname") == "") {ErrorMsg="Contact representative  is not specified.";break}
			if (Request.Form("email") == "") {ErrorMsg="E-mail  is not specified.";break}
			if (Request.Form("address") == "") {ErrorMsg="Post address  is not specified.";break}
			var re = new RegExp("(\\w+)@((\\w+).)*(\\w+)$")
			if (!re.test(Request.Form("email"))){ErrorMsg="E-mail  is not  valid.";break}%>
			<!-- #include file="inc\records.inc" -->
<%	Records.Source="select count(*) as cnt from member where logname='"+Request.Form("username")+"'"
			Records.Open()
			var NameCnt=Records("CNT").Value
			Records.Close()

			Records.Source="select gen_id(universal,1) as next_id from dual"
			Records.Open()
			var id=Records("NEXT_ID").Value
			Records.Close()
	
			if (NameCnt>0){ErrorMsg="This username already used by other user.";break}
			var SqlStr=new String("insert into member(id, logname, codeword, psw, member_fio, reg_type_id, is_corp, reg_date,"+
			                     "e_mail, phone, phone2, state, address, fax) "+
								"values(%id, '%logname', '%codeword', '%psw', '%member_fio', 1, %is_corp, 'now',"+
								"'%e_mail', '%phone', '%phone2', %state, '%address', '%fax')")

			SqlStr=SqlStr.replace("%id",String(id))
			SqlStr=SqlStr.replace("%logname",Request.Form("username"))
			SqlStr=SqlStr.replace("%codeword","empty")
			SqlStr=SqlStr.replace("%psw",Request.Form("password1"))
			SqlStr=SqlStr.replace("%member_fio",Request.Form("contactname"))
			SqlStr=SqlStr.replace("%is_corp", Request.Form("corpsign") )
			SqlStr=SqlStr.replace("%e_mail", Request.Form("email"))
			SqlStr=SqlStr.replace("%phone", Request.Form("phone1"))
			SqlStr=SqlStr.replace("%phone2", Request.Form("phone2"))
			SqlStr=SqlStr.replace("%state","1")
			SqlStr=SqlStr.replace("%address", Request.Form("address"))
			SqlStr=SqlStr.replace("%fax", Request.Form("fax"))
			Connect.Execute(SqlStr)
			Session("ContactName")=String(Request.Form("contactname"))
			break
		}


 
		if (ErrorMsg=="" ){Response.Redirect("reg10thank.asp")}
}
%>
<HTML>
<HEAD>
  <META NAME="GENERATOR" CONTENT="1GARD International Access Card">
  <TITLE>Onegard member preregistration 1.0</TITLE>
</HEAD>
<BODY BGCOLOR="#ffffff">
<font face="Arial, Helvetica, sans-serif"><a name="top"></a></font> 
<FORM METHOD="post" ACTION="reg10.asp">
  <H1><FONT SIZE="+0"><A HREF="index.asp">1GARD  RESEARCH NETWORK</A> </FONT></H1>
  <p>
  <font color="#5c7076" size="-2">
  <hr align=LEFT>
  </font><FONT SIZE="+0">Before you start filling in this form You need to read 
  the Agreement and Rule of the Membership.</FONT> 
  <P><FONT COLOR="#5c7076" SIZE="-2"><HR ALIGN=LEFT>
  </FONT>
<H2><CENTER>
      <FONT COLOR="#1d8971" SIZE="+0">1GARD  International Network<BR>
      </FONT><FONT COLOR="#1d8971">Registration form 1.0<BR>
      &quot;Membership in 1GARD  Marketing Network&quot;.</FONT> 
    </CENTER></H2>
  <%if (  !isFirst ) {%> 
  <H2><CENTER><FONT COLOR="#ff0000">Registration Error!</FONT><FONT
 COLOR="#1d8971"><BR>
      <%=ErrorMsg%></FONT> 
    </CENTER></H2>
  <%   }    %> 
  <hr>
  <div align="center"><br>
    <b>You must be the proxy representative or owner of the company to make this 
    registration.<br>
    Are You?<br>
    </b> 
    <input type="radio" value="0" name="proxy" <%=Request.Form("proxy")=="0"? "checked" : "" %>>
    Yes I am. 
    <input type="radio" value="1" name="proxy" <%=Request.Form("proxy")=="1" || isFirst? "checked" : "" %>>
    No, I am not.<font size="-1"> </font></div>
  <font size="-1"> 
  <hr align="center">
  </font> 
  <P> 
  <TABLE BORDER="0" CELLSPACING="6" CELLPADDING="0"
WIDTH="97%" HEIGHT="629">
    <CAPTION ALIGN="TOP"> 
    <P ALIGN=LEFT>*-required fields 
    </CAPTION>
    <TR> 
      <TD ROWSPAN="2" VALIGN="TOP" WIDTH="34%"> 
        <p><B>User name is</B> the word which you will use to access the member's 
          area.<BR>
          <B>Password</B> is the secret word.<BR>
          No spaces. At list 5 characters.</p>
        </TD>
      <TH WIDTH="66%" BGCOLOR="#a3c9c1" HEIGHT="52"> 
        <P ALIGN=LEFT>&nbsp; 
          <INPUT NAME="username" TYPE="text" SIZE="25" value="<%=Request.Form("username")%>">
          *<BR>
          user name 
      </TH>
    </TR>
    <TR> 
      <TH WIDTH="66%" BGCOLOR="#a3c9c1" HEIGHT="52"> 
        <P ALIGN=LEFT>&nbsp; 
          <INPUT NAME="password1" TYPE="password"
    SIZE="25">
          *<BR>
          <B>password</B> 
      </TH>
    </TR>
    <TR> 
      <TD WIDTH="34%" HEIGHT="52" BGCOLOR="#a3c9c1">&nbsp; </TD>
      <TD WIDTH="66%" HEIGHT="52" BGCOLOR="#a3c9c1"> &nbsp; 
        <INPUT NAME="password2" TYPE="password" SIZE="25">
        *<BR>
        <B>confirm</B> <B>password</B></TD>
    </TR>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="23"> <B>indicate type of registration</B></TD>
    </TR>
    <TR> 
      <TD ROWSPAN="2" VALIGN="TOP"> 
        <P ALIGN=RIGHT>Will your register<br>
          subsidiaries or branches of your company?<BR>
        
      </TD>
      <TD WIDTH="66%" VALIGN="TOP" HEIGHT="28"> 
        <INPUT TYPE="radio" VALUE="1" NAME="corpsign" <%=Request.Form("corpsign")=="1"? "checked" : "" %>>
        Yes 
        <INPUT TYPE="radio" VALUE="0" NAME="corpsign" <%=Request.Form("corpsign")=="0" || isFirst ? "checked" : "" %>>
        No *</TD>
    </TR>
    <TR> 
      <TD WIDTH="66%" HEIGHT="28">&nbsp; </TD>
    </TR>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="23"> <B>&nbsp;Contact information</B></TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" VALIGN="TOP" ALIGN="RIGHT" HEIGHT="33"> The contact representative 
        of the company</TD>
      <TD WIDTH="66%" VALIGN="TOP" HEIGHT="33"> 
        <INPUT NAME="contactname" TYPE="text" SIZE="31" value="<%=Request.Form("contactname")%>">
        * <FONT SIZE="-1">Name and position</FONT></TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" VALIGN="TOP" ALIGN="RIGHT" HEIGHT="33"> Contact e-mail:</TD>
      <TD WIDTH="66%" VALIGN="TOP" HEIGHT="33"> 
        <INPUT NAME="email" TYPE="text" SIZE="31" value="<%=Request.Form("email")%>">
        *</TD>
    </TR>
    <TR> 
      <TD VALIGN="TOP" ALIGN="RIGHT" WIDTH="34%" HEIGHT="26"> 
        <p>Contact phone:</p>
      </TD>
      <TD WIDTH="66%" VALIGN="TOP" HEIGHT="26"> 
        <p> 
          <INPUT NAME="phone1" TYPE="text" SIZE="31" value="<%=Request.Form("phone1")%>">
        </p>
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" HEIGHT="33"> 
        <P ALIGN=RIGHT>&nbsp;Second phone: 
      </TD>
      <TD WIDTH="66%" HEIGHT="33"> 
        <INPUT NAME="phone2" TYPE="text" SIZE="31" value="<%=Request.Form("phone2")%>">
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" HEIGHT="33"> 
        <P ALIGN=RIGHT>&nbsp;Fax: 
      </TD>
      <TD WIDTH="66%" HEIGHT="33"> 
        <INPUT NAME="fax" TYPE="text" SIZE="31" value="<%=Request.Form("fax")%>">
      </TD>
    </TR>
    <TR> 
      <TD WIDTH="34%" HEIGHT="33"> 
        <P ALIGN=RIGHT>&nbsp;Post address: 
      </TD>
      <TD WIDTH="66%" HEIGHT="33"> 
        <INPUT NAME="address" TYPE="text" SIZE="54" value="<%=Request.Form("address")%>">
        *</TD>
    </TR>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="33"> 
        <P> 
          <CENTER>
            <B> 
            <INPUT NAME="RegSubmit" TYPE="submit" VALUE="Submit">
            <INPUT NAME="name" TYPE="reset" VALUE="Reset">
            </B> 
          </CENTER>
      </TD>
    </TR>
    <TR> 
      <TD COLSPAN="2" HEIGHT="10"></TD>
    </TR>
    <TR> 
      <TD COLSPAN="2" BGCOLOR="#dadffc" HEIGHT="23"></TD>
    </TR>
  </TABLE>
</FORM>

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
