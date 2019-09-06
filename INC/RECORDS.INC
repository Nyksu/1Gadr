<!-- #include file="connect.inc" -->
<%
var Records=Server.CreateObject("ADODB.Recordset")
Records.ActiveConnection=Connect
Records.CursorType = 0
Records.CursorLocation = 2
Records.LockType = 3
%>