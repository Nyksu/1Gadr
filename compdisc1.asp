<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->


<%
function isCompanyApplicable(cid,rec){
	result=0
	rec.Source="select count(*) as cnt from j_branch where company_id="+cid
	rec.Open()
	result=rec("CNT").Value
	rec.Close()
	if(result==0){
		rec.Source="select count(*) as cnt from j_goods_group where company_id="+cid
		rec.Open()
		result=rec("CNT").Value
		rec.Close()
	}
	return result
}
function TableRows(HighID,Level,LeadSpace,lines_cnt){
	var lines=""

	var Recs=CreateRecordSet()
	var rr=CreateRecordSet()
	//------------get discount state options to array
	rr.Source="select count(*) as cnt from sp_discount_state"
	rr.Open()
	var state_cnt=rr("CNT").Value
	var DState = new Array(state_cnt)
	rr.Close()
	rr.Source ="select * from sp_discount_state order by id"
	rr.Open()
	for(i=0;!rr.EOF;i++){
		DState[i]=new Array(2)
		DState[i][0]=rr("ID").Value
		DState[i][1]=rr("NAME").Value
		rr.MoveNext()
	}
	rr.Close()
	//-----------------------
	Recs.Source="select id, name, discount_state_id from company where deleted=0 and member_id="+Session("UserID")+" and high_id="+HighID
	Recs.Open()
	while(!Recs.EOF){
		tr="<tr %color><td %width1 class=\"fielddata\">%lspace %cname</td> <td %width2> %select</td></tr>\n"
		select="Read note above"
		if(isCompanyApplicable(Recs("ID").Value,rr)!=0){
			select ="<select name=\"cid%cid\"> %option </select>"
			select=select.replace("%cid",Recs("ID").Value)
			for(i=0;i<state_cnt;i++){
				option ="<option value=\"%value\" %selected> %option_title</option>\n %option"
				option=option.replace("%value",DState[i][0])
				option=option.replace("%option_title",DState[i][1])
				selected=""
				if(Recs("DISCOUNT_STATE_ID").Value==DState[i][0]){selected="selected"}
				option=option.replace("%selected",selected)
				select=select.replace("%option",option)
			}
			select=select.replace("%option","")
		}
		tr=tr.replace("%color",lines_cnt%2==1? "bgcolor=\"#E9E9E9\"": "")
		tr=tr.replace("%select",select)
		tr=tr.replace("%lspace",LeadSpace)
		tr=tr.replace("%cname",Recs("NAME").Value)
		tr=tr.replace("%width1",Level==0?"width=\"80%\"":"")
		tr=tr.replace("%width2", Level==0?"width=\"20%\"":"")
		lines_cnt++
		lines+=tr+TableRows(Recs("ID").Value,Level+1,LeadSpace+"     ",lines_cnt)
		Recs.MoveNext()
	}
	Recs.Close()
	return lines
}
//---------------------------
btn=String(Request.Form("Submit"))
var isFirst=btn=="undefined"
var ShowAgrement=false
var ErrorMsg=""
if(isFirst){
	Records.Source="select count(*) as cnt from company where member_id="+Session("UserID")+" and deleted=0 and discount_state_id<>0"
	Records.Open()
	ShowAgrement=Records("CNT").Value==0
	Records.Close()
}
else{
	//---------apply updates-------------
	if(btn=="Submit"){
		Connect.BeginTrans()
		try{
			rec=CreateRecordSet()
			rec.Source="select id, discount_state_id as state from company where member_id="+Session("UserID")+" and deleted=0"
			rec.Open()
			while(!rec.EOF){
				new_state=TextFormData(Request.Form("cid"+rec("ID").Value),null)
				if(new_state!=null && new_state!=String(rec("STATE").Value)){
					Connect.Execute("update company set discount_state_id="+new_state+" where id="+rec("ID").Value)
				}
				rec.MoveNext()
			}
			rec.Close()
			Connect.CommitTrans()
			Response.Redirect("area.asp")
		}
		catch(e){		
			ErrorMsg+=ListAdoErrors()
			Connect.RollbackTrans()		
		}
	}
}

%>
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="1GARD International Access Card">
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
<title>Apply company to discount system.</title>
</HEAD>
<BODY BGCOLOR="#ffffff">
<font size="+0"><a href="index.asp"> </a></font> 
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
<form name="form" method="post" action="compdisc.asp">
<%
if(!ShowAgrement){
%>
<center class="doctitle">
    Apply to access program. 
  </center>
  <%
if(ErrorMsg!=""){
%><center><h3><font color="#FF3333">Processing error</font> 
  <font color="#1e4a7b"><%=ErrorMsg%></font></h3></center>
  <%}%> 
  <p><b>Impotant note</b>:<br>
    Make sure Your company is registred in 1GARD data base. / <a href="company.asp">Register 
    - Modify</a> / <br>
    Companies for which specified main branches or group of goods can be applied 
    to &quot;MARKETCHART access program&quot; only.<br>
  </p>
  <table width="100%" border="1" cellspacing="0">
    <tr> 
      <td colspan="2" height="61"> 
        <center>
          <table width="100%" border="0" cellspacing="3">
            <tr>
              <td  colspan="2" class="blueband">Companies</td>
            
            <tr> 
              <td width="80%" class="fieldtitle_L">Name </td>
              <td width="20%" class="fieldtitle_L">Status </td>
              <% 
var temp=TableRows(0,0,"",1)
if (temp==""){
%> 
            <tr> 
              <td width="80%">No company.</td>
              <td width="20%">&nbsp; </td>
            </tr>
            <%
}
else {Response.Write(temp)}
%> 
          </table>
          <center>
            <input type="submit" name="Submit" value="Submit" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" name="Back" value="Back" onClick="document.form.action='area.asp';document.form.submit()">
          </center>
        </center>
      </td>
    </tr>
  </table>
<%
}
else{%>
<center>
    <p>The agreement of the participant MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM.</p>
    <p align="left">You agree to participate in MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM, giving the 
      discounts on the price at purchase of the goods, or services to the holders 
      of a virtual card MARKETCHART  <sup><font size="-1">sm</font></sup> or to give to him free-of-charge access to 
      the information resources, specified by you. The norm of the discounts is 
      announced by the Company - Member of the program between 1 and 20 %. MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM provides you with statistics of marketing and reports of marketing 
      as it is ordered during registration. You agree to fill in all fields in 
      the form of registration of the participant MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM as it is 
      required. You as the participant are bound by all further conditions of 
      development MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM. MARKETCHART PROGRAM reserves the right 
      to itself to change the conditions and terms of participation in PROGRAM, 
      terms, periodicity, containce and design of the reports, without notice. 
      MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM publishes the information on all changes of conditions 
      and terms of service in MEMBER'S AREA of THE 1GARD  NETWORK. Privacy of 
      card bearers You agree that MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM does not transfer you and 
      third persons and does not allow to use to you and third persons the received 
      elements of the information from the holder of a card MARKETCHART  <sup><font size="-1">sm</font></sup> such as, 
      names, address, residences and other information which can identify of the 
      holder of a card as the certain person or allowing to enter with him in 
      the personal contact. The company uses the received elements of the information 
      from the holder of a card as a part for creation of the statistical, demographic 
      reports and researches of marketing stipulated MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM only. 
      Clause of the responsibility. 1GARD  the Company is not responsible for 
      damage, losses, expences related with: - Quality of the goods or services 
      of the participants MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM; - The facts of failure(refusal) 
      in the right of the Bearer of a Card to the discounts, category of the discount 
      or access to resources of a network as it is announced by the participants. 
      They are under the regulations of national trade rules, instructions and 
      laws; - Hope or intention to the certain economy or savings, through being 
      the participant of the MARKETCHART  <sup><font size="-1">sm</font></sup> PROGRAM. </p>
  </center>
<center>
            
    <input type="submit" name="Submit" value="I agree" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            
    <input type="button" name="Back" value="Disagree" onClick="document.form.action='area.asp';document.form.submit()">
</center>
<%}%>
  </form>
<font size="+0"><a href="index.asp"> </a></font><br>
</BODY>
</HTML>
