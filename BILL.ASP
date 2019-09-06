<%@LANGUAGE="JavaScript"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\err.inc" -->

<%
//---------------------------
resCardNotExist		="0"; // возвращаемые коды 
resOk				="1";
resInvalidParams		="3";
resInvalidClient		="4";

parCardNumber		="card"; //имена GET параметров
parClientVersion		="ver";
parCompany			="comp";
parExtention		="ext";

EnableDebugMessages	=false; //¬ключает-выключает отладочные сообщени€

MinSupportedClient	=1;
//----------------------------
function SendResponse(resStr){
	Response.Write(resStr);
	Response.End;
}
//---------------------------
result=resOk;
Card=Request(parCardNumber)+"";
Company=parseInt(Request(parCompany));
ClientVer=parseInt(Request(parClientVersion));
Extention=parseInt(Request(parExtention));


//---validate card number length---
if(Card.length<20){
	if(EnableDebugMessages){Response.Write("Invalid card number.<p>");}
	SendResponse(resInvalidParams);
}

//---validate client version value---
if(isNaN(ClientVer)){
	if(EnableDebugMessages){Response.Write("Invalid client version.<p>");}
	SendResponse(resInvalidParams);
}

//---validate compuny number value---
if(isNaN(Company)){
	if(EnableDebugMessages){Response.Write("Invalid company number.<p>");}
	SendResponse(resInvalidParams);
}

//---validate extention value---
if(isNaN(Extention)){
	if(EnableDebugMessages){Response.Write("Invalid extention number.<p>");}
	SendResponse(resInvalidParams);
}

//---is client version supported---
if(ClientVer>MinSupportedClient){
	if(EnableDebugMessages){Response.Write("Client not supported.<p>");}
	SendResponse(resInvalidClient);
}


//---is card exist---
Records.Source="select id from account where state=1 and card_number="+Card;
try{
	Records.Open();
	if(Records.EOF){ 
		if(EnableDebugMessages){Response.Write("Card not exists.<p>");}
		SendResponse(resCardNotExist);
	}
	CardID=Records("ID").Value;
	Records.Close();
}
catch(e){	
	if(EnableDebugMessages){Response.Write("Internal error on card check.<p>");}
	SendResponse(resInvalidParams);
}

//---is company exist and in discount program---
Records.Source="select id from company where deleted=0 and discount_state_id>0 and id="+Company;
try{
	Records.Open();
	if(Records.EOF){ 
		if(EnableDebugMessages){Response.Write("Company not exists or not in discount program.<p>");}
		SendResponse(resInvalidParams);
	}
	CompanyID=Records("ID").Value;
	Records.Close();
}
catch(e){	
	if(EnableDebugMessages){Response.Write("Internal error on company check.<p>");}
	SendResponse(resInvalidParams);
}
//---save transaction---
//---TransID=NextID("BILLING_ID");---
Records.Source="select gen_id(BILLING_ID,1) as id from dual";
try{
	Records.Open();
	if(Records.EOF){ 
		if(EnableDebugMessages){Response.Write("Do not find ID.<p>");}
		SendResponse(resInvalidParams);
	}
	TransID=Records("ID").Value;
	Records.Close();
}
catch(e){	
	if(EnableDebugMessages){Response.Write("Internal error on ID get.<p>");}
	SendResponse(resInvalidParams);
}
sql="insert into biling(id,transaction_time,account_id,company_id,param_transaction) "+
    "values("+TransID+",'NOW',"+CardID+","+CompanyID+",null)";
Connect.Execute(sql);

//---is extention exist and company cat use it---
Records.Source="select id from extention where state=1 and company_id="+Company+" and param_transaction="+Extention;
try{
	Records.Open();
	if(!Records.EOF){ 
		ExtentionID=Records("ID").Value;
		//--- save extention to transaction---
		sql="update biling set param_transaction="+Extention+" where id="+TransID;
		Connect.Execute(sql);
	}
	Records.Close();
}
catch(e){	
	if(EnableDebugMessages){Response.Write("Internal error on extention check.<p>");}
	SendResponse(resInvalidParams);
}
SendResponse(resOk);
%>
