<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\getform.inc" -->

<%
var HTTPObj=Server.CreateObject("AspHTTP.Conn")
HTTPObj.RequestMethod="GET"

var ErrorMsg=""
var strResult=""

isFirst=String(Request.Form("Submit"))=="undefined"
if(!isFirst){
		card=TextFormData(Request.Form("card"),"")
		ext=IntFormData(Request.Form("ext"))
		comp=IntFormData(Request.Form("comp"))
		ver=IntFormData(Request.Form("ver"))

		if(card ==""){ErrorMsg+="Error. Field 'Card number' must be filled in.<br>"}

		if (ErrorMsg==""){
			HTTPObj.Url="HTTP://www.1gard.net/bill.asp?ver="+ver+"&comp="+comp+"&ext="+ext+"&card="+card
			try{
				strResult=HTTPObj.GetURL()
			}
			catch(e){
				ErrorMsg+="Error. Can't connect to the URL.<br>"+HTTPObj.Url
			}

			if (strResult==1) {ErrorMsg+="Successful card number!!.<br>"}
			if(strResult==0){ErrorMsg+="Card is not Exist.<br>"}
			if (strResult==3) {ErrorMsg+="Invalid parameters.<br>"}
			if (strResult==4) {ErrorMsg+="Invalid client version.<br>"}
			if (strResult=="") {ErrorMsg+="Answer was not ressived.<br>"}
			
		}
}
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
<p align="center"><font size="5"><b>Test card accept</b></font></p>
<%if(ErrorMsg!=""){%> 
  <h3 align="center"><font color="#1e4a7b"><%=ErrorMsg%></font><br>
  </h3>
<%}%>
<form name="form1" method="POST" action="test_card.asp">
  <p align="center"> 
    <input type="hidden" name="ver" value="1">
    <input type="hidden" name="comp" value="5796">
    <input type="hidden" name="ext" value="111">
  </p>
  <p align="center">Insert card number: 
    <input type="text" name="card" value="<%=isFirst?"":Request.Form("card")%>" size="20" maxlength="20">
  </p>
  <p align="center"> 
    <input type="submit" name="Submit" value="Submit">
  </p>
</form>
<p>&nbsp;</p>
<p>&nbsp; </p>
</body>
</html>
