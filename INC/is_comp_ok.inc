<%
Records.Source="select name from company where member_id="+Session("UserID")+" and id="+cid+" and deleted=0"
Records.Open()
if (Records.EOF){Response.Redirect("complist.asp")}
var compname=Records("NAME").Value
Records.Close()
%>