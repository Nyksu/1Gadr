<%@LANGUAGE="JavaScript"%>
<!-- #include file="inc\is_login.inc" -->
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\path.inc" -->
<%
var cid=Request("cid")
var updown=  Server.CreateObject("aspSmartUpload.SmartUpload")
filename="noimg.jpg"
CType="image/JPG"
try{
	Records.Source="select name from company where member_id="+Session("UserID")+" and id="+cid+" and deleted=0"
	Records.Open()
	if (Records.EOF){throw "no company"}
	Records.Close()
	var fs = new ActiveXObject("Scripting.FileSystemObject")
	if(fs.FileExists(ImageFilePath+cid+".JPG")){ filename=cid+".jpg" }
	else{
		if(fs.FileExists(ImageFilePath+cid+".gif")){ filename=cid+".gif"; CType="image/GIF" }
	}
}
catch(e){
}
Response.ContentType=CType
updown.DownloadFile(DownloadFilePath+filename)

%>