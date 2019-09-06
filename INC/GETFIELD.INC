<%
function TextField(field,def_value){
def_value=String(def_value)=="undefined"?"":def_value
return field.Value==null?def_value:field.Value
}
function DateField(field){
	if (field.Value==null){return ""}
	else{
		tmp=new Date(field.Value)
		day=String(tmp.getDate()).length==1?"0"+tmp.getDate():tmp.getDate()
		month=String(tmp.getMonth()+1).length==1?"0"+(tmp.getMonth()+1):tmp.getMonth()+1
		year=tmp.getYear()>1000?tmp.getYear():tmp.getYear()+1900
		return  day+"."+month+"."+year
	}
}
%>