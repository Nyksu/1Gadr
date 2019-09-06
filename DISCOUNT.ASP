<%@language="javascript"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\dict_val.inc" -->
<!-- #include file="inc\acnt_sql.inc" -->
<!-- #include file="inc\next_id.inc" -->
<%
function InitValueStatus(isFirst,RequestValue){
	return !isFirst?RequestValue=="0"?"selected":"":"selected"
}

function NextValueStatus(isFirst,EqualPosition){
	return !isFirst && EqualPosition?"selected":""
}

function AddControlDigit(val){
	var Odds="",Evens=""
	for(i=18;i>=0;i--){
		if("13579".indexOf(val.charAt(i))!=-1){Odds+=val.charAt(i)}
		else{Evens+=val.charAt(i)}
	}
	Odds=String(parseInt(Odds,10)*2)
	all=Evens+Odds
	sum=0
	for(i=0;i<all.length;i++){ sum+=parseInt(all.charAt(i),10) }
	last=parseInt(sum.toString().charAt(sum.toString().length-1),10)
	if(last!=0){last=10-last}
	return val+last
}

var ErrorMsg=""
ShowForm=true
isFirst=String(Request.Form("Submit"))=="undefined"
if (!isFirst){
	email=TextFormData(Request.Form("demail"),"")
	if(email==""){ErrorMsg="E-mail address is required.<br>"}
	else{ 
		if( !/(\w+)@((\w+).)*(\w+)$/.test(email) ){ ErrorMsg="E-mail address is not valid.<br>" }
	}
	sex=IntFormData(Request.Form("sex"))
	if(sex==null){ErrorMsg+="Sex is required.<br>"}
	birthyear=IntFormData(Request.Form("birthyear"))
	if(birthyear==null || birthyear<1850 || birthyear>1987){ErrorMsg+="Illeagal age!<br>"}
	education=IntFormData(Request.Form("education"),0)
	if(education==0){ErrorMsg+="Education is required.<br>"}
	ccount=IntFormData(Request.Form("ccount"),0)
	if(ccount==null || ccount<0 || ccount>12){ErrorMsg+="Incorrect number of children.<br>"}
	married=IntFormData(Request.Form("married"),0)
	if(married==0){ErrorMsg+="Married status is required.<br>"}

	webshop=IntFormData(Request.Form("webshop"))
	if(webshop==null){ErrorMsg+="\"Use web shop\" is required.<br>"}
	prof=IntFormData(Request.Form("prof"),"")
	if(prof==0){ErrorMsg+="Proffesion is required.<br>"}

	profmag=IntFormData(Request.Form("profmag"))
	if(profmag==null){ErrorMsg+="\"Do you read spaciality magazines?\" is required.<br>"}
	bcountry=IntFormData(Request.Form("bcountry"))
	if(bcountry==0){ErrorMsg+="Birth country is required.<br>"}

	country=IntFormData(Request.Form("country"))
	if(country==0){ErrorMsg+="Country is required.<br>"}
	if(country!=0){
		if(country==133){
			state=IntFormData(Request.Form("state"))
			if(state==0){ErrorMsg+="State is required.<br>"}
		}
		else{
			region=TextFormData(Request.Form("Region"),"")
			if(region==""){ErrorMsg+="Province is required.<br>"}
			else{
				state=DictValue("SP_COUNTRY_STATE","NAME",region,"and shortname is null")
			}
		}
	}

	abroad=IntFormData(Request.Form("abroad"))
	if(abroad==0){ErrorMsg+="Abroads is required.<br>"}
	stag=IntFormData(Request.Form("stag"))
	if(stag==0){ErrorMsg+="Years of experience is required.<br>"}

	work=IntFormData(Request.Form("work"))
	if(work==0){ErrorMsg+="Working status is required.<br>"}
	income=IntFormData(Request.Form("income"),"")
	if(income==0){ErrorMsg+="Year income is required.<br>"}

	media=IntFormData(Request.Form("media"))
	if(media==0){ErrorMsg+="Favorite media is required.<br>"}
	ccountry=IntFormData(Request.Form("ccountry"))
	if(ccountry==0){ErrorMsg+="Country of car manufacturer is required.<br>"}

	iplace=IntFormData(Request.Form("iplace"))
	if(iplace==0){ErrorMsg+="\"Access internet from\" is required.<br>"}
	inetyear=IntFormData(Request.Form("inetyear"))
	if(inetyear==0){ErrorMsg+="\"Years of use internet\" is required.<br>"}

	inettimes=IntFormData(Request.Form("inettimes"))
	if(inettimes==0){ErrorMsg+="\"Use internet\" is required.<br>"}
	pc=IntFormData(Request.Form("pc"))
	if(pc==0){ErrorMsg+="Computer type is required.<br>"}

	hobby=TextFormData(Request.Form("hobby"),"")

	if(ErrorMsg==""){
		sql=account_insert
		dt=new Date
		year_last_digit=dt.toString().substr(dt.toString().length-1,1)
		recs=CreateRecordSet()		
		//get new ID
		id=NextID()
		// cycle for search new CARD NUMBER
		while(true){
			// build new CARD NUMBER
			for(country_code=String(country);country_code.length<3;){country_code="0"+country_code}
			cnumber=AddControlDigit( country_code +birthyear +sex+year_last_digit+String(Math.random()).substr(3,10) )
			recs.Source="select id from account where id="+id
			try{
				recs.Open()
				if( recs.EOF) {break} // if no such ID break cycle
			}
			finally{ recs.Close() }
		}
		sql=sql.replace("%id",id)
		sql=sql.replace("%cnumber",cnumber)
		sql=sql.replace("%cseries","A")
		sql=sql.replace("%email",email)
		sql=sql.replace("%sex",sex)
		sql=sql.replace("%birthyear",birthyear)
		sql=sql.replace("%bcountry",bcountry)
		sql=sql.replace("%country",country)
		sql=sql.replace("%state",state)
		sql=sql.replace("%married",married)
		sql=sql.replace("%abroad",abroad)
		sql=sql.replace("%ccount",ccount)
		sql=sql.replace("%education",education)
		sql=sql.replace("%prof",prof)
		sql=sql.replace("%stag",stag)
		sql=sql.replace("%work",work)
		sql=sql.replace("%income",income)
		sql=sql.replace("%profmag",profmag)
		sql=sql.replace("%media",media)
		sql=sql.replace("%ccountry",ccountry)
		sql=sql.replace("%pc",pc)
		sql=sql.replace("%inetyear",inetyear)
		sql=sql.replace("%iplace",iplace)
		sql=sql.replace("%webshop",webshop)
		sql=sql.replace("%hobby",hobby)
		sql=sql.replace("%inettimes",inettimes)
		try{
			//ErrorMsg=sql
			Connect.Execute(sql)
			ShowForm=false
		}
		catch(e){
			ErrorMsg=String(e.message)=="undefined"?e:e.message
		}
	}
}
%>
<html>
<head>
<title>Register Access Account</title>
<meta http-equiv="Content-Type" content="text/html">
<link href="account.css" rel="stylesheet" type="text/css" title="Account">
</head>

<body bgcolor="#FFFFFF">
<form name="form" method="post" action="<%=ShowForm?"discount.asp":"access_card.asp"%>">
<% if(ShowForm){ %>
  <center class="doctitle">
    Register 1GARD Access Card 
  </center> 
  <%if(ErrorMsg!=""){%> <p>
  </p><h3 align="center"> <font color="#FF3333">Processing error<br>
    </font><font color="#1e4a7b"><%=ErrorMsg%></font><br>
  </h3>
  <%}%> 
  *- required fields 
  <table width="100%" border="1" cellspacing="0" height="483" bordercolordark="#666666" bordercolorlight="#CCCCCC">
    <tr> 
      <td height="628"> 
        <table width="100%" cellspacing="1" height="384">
          <tr> 
            <td class="blueband"  colspan="2">Required information</td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">E-mail address:</td>
            <td width="75%"> 
              <input type="text" size="70" name="demail" value="<%=isFirst?"":Request.Form("demail")%>">
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Gender:</td>
            <td> 
              <input type="radio" name="sex" value="1" <%=!isFirst && Request.Form("sex")=="1"?"checked":""%>>
              Male 
              <input type="radio" name="sex" value="0" <%=!isFirst && Request.Form("sex")=="0"?"checked":""%>>
              Female *</td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle"> Year of birth (4 digits):</td>
            <td > 
              <input type="text" name="birthyear" value="<%=isFirst?"":Request.Form("birthyear")%>">
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle" >Profession occupation:</td>
            <td> 
              <select name="prof">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("prof"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_profession order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("prof"))%>> 
                <%=Records("NAME").Value%> </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Family status: :</td>
            <td> 
              <select name="married">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("married"))%>>Select 
                one</option>
                <option value="1" <%=NextValueStatus(isFirst,Request.Form("married")=="1")%>>Married</option>
                <option value="2" <%=NextValueStatus(isFirst,Request.Form("married")=="2")%>>Single</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Number of children</td>
            <td>
              <input type="text" name="ccount" size="50" value="<%=isFirst?"":Request.Form("ccount")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Have you ever purchased<br>
              nything on the web:</td>
            <td> 
              <input type="radio" name="webshop" value="1" <%=!isFirst && Request.Form("webshop")=="1"?"checked":""%>>
              Yes 
              <input type="radio" name="webshop" value="0" <%=!isFirst && Request.Form("webshop")=="0"?"checked":""%>>
              No </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle" >Education:</td>
            <td> 
              <select name="education">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("education"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_education order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("education"))%>> 
                <%=Records("NAME").Value%> </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Do you read professional magazines?:</td>
            <td> 
              <input type="radio" name="profmag" value="1" <%=!isFirst && Request.Form("profmag")=="1"?"checked":""%>>
              Yes 
              <input type="radio" name="profmag" value="0" <%=!isFirst && Request.Form("profmag")=="0"?"checked":""%>>
              No *</td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Country of birth: </td>
            <td> 
              <select name="bcountry">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("bcountry"))%>>Select 
                country</option>
                <%
				Records.Source="select * from sp_country where not shortname is null order by name"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("bcountry"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Country of residence: </td>
            <td> 
              <select name="country">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("country"))%>>Select 
                country</option>
                <%
				Records.Source="select * from sp_country where not shortname is null order by name"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("country"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">State:</td>
            <td> 
              <select name="state">
                <option value="0" <%=Request.Form("country")!="133"||Request.Form("state")=="0"?"selected":""%> selected>Select 
                state</option>
                <%
				Records.Source="select * from sp_country_state where not shortname is null order by name"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=(Request.Form("country")=="133")&&((isFirst&&Records("ID").Value==state_id)||Request.Form("state")==Records("ID").Value)?"selected":""%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * (US only)</td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Province:</td>
            <td> 
              <input type="text" name="region" size="50" value="<%=!isFirst&&Request.Form("country")!="133"?Request.Form("region"):""%>">
              *(not US only) </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">How often you travel abroad?: </td>
            <td> 
              <select name="abroad">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("abroad"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_times order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("abroad"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Years of professional experience: 
            </td>
            <td> 
              <select name="stag">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("stag"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_year_count order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("stag"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Working status: </td>
            <td> 
              <select name="work">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("work"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_work_state order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("work"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Annual income: </td>
            <td> 
              <select name="income">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("income"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_year_income order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("income"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Favorite news media: </td>
            <td> 
              <select name="media">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("media"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_media order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("media"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Brend name of your car:</td>
            <td> 
              <select name="ccountry">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("ccountry"))%>>Select 
                one</option>
                <%
				Records.Source="select * from SP_CARS_COUNTRY order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("ccountry"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Your regular Internet access: </td>
            <td> 
              <select name="iplace">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("iplace"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_internet_place order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("iplace"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Years of Internet experience: </td>
            <td> 
              <select name="inetyear">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("inetyear"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_year_count order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("inetyear"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Frequency of Internet Usage : </td>
            <td> 
              <select name="inettimes">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("inettimes"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sp_times order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("inettimes"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>

          <tr> 
            <td width="25%" class="fieldtitle">Your favorite hobby:</td>
            <td width="75%"> 
              <input type="text" size="70" name="hobby" value="<%=isFirst?"":Request.Form("hobby")%>">
            </td>
          </tr>
          <tr> 
            <td width="25%" class="fieldtitle">Computer type you use at home: 
            </td>
            <td> 
              <select name="pc">
                <option value="0" <%=InitValueStatus(isFirst,Request.Form("pc"))%>>Select 
                one</option>
                <%
				Records.Source="select * from sr_computer_type order by id"
				Records.Open()
				while(!Records.EOF){%> 
                <option value="<%=Records("ID").Value%>" 
					<%=NextValueStatus(isFirst,Records("ID").Value==Request.Form("pc"))%>> 
                <%=Records("NAME").Value%> 
                </option>
                <%	Records.MoveNext()
				}
				Records.Close()
				%> 
              </select>
              * </td>
          </tr>
        </table>
        <center>
          <input type="submit" name="Submit" value="Submit">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="button" name="Button" value="Back" onClick="document.form.action='index.asp';document.form.submit()">
        </center>
      </td>
    </tr>
  </table>
  <%} 
else {%>
<center class="doctitle">
    <p>Your 1GARD Access Card successfully registered.</p>
    <p>Please print or remember your card number:<br>
      <%=cnumber%> 
    </p>
    <p>
      <input type="submit" name="Submit2" value="Continue">
    </p>
  </center>
<%}%> 
</form>

</body>
</html>
