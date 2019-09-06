<%
function DictValue(TableName,FieldName,Value,ExtraCondition){
	var recs=CreateRecordSet()
	//search value in dictionary
	if (String(ExtraCondition)=="undefined"){ExtraCondition=""}
	recs.Source="select id from "+TableName+" where "+FieldName+"='"+Value+"' "+ExtraCondition
	recs.Open()
	if(!recs.EOF){
		retval=recs("ID").Value
	}
	else{
		retval=NextID()
		Connect.Execute("insert into "+TableName+"(id,"+FieldName+")values ("+retval+",'"+Value+"')")
	}
	recs.Close()
	delete recs
	return retval
}
%>