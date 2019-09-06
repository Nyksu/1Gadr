<%
var comp_select="select c.id,c.member_id,c.country_id,c.company_type_id, c.country_state_id, "+
				"c.city_id, c.begin_date ,c.high_id,c.hierarchy_type, c.reg_date, c.discount_state_id, "+
				"c.name, c.stock_ticker,c.zip_code, c.city_area, c.street, c.megapolis, c.building, "+
				"c.office, c.boss, c.boss_type, c.shortname, "+
				"cr.name as country, ty.name as company_type, cs.name as country_state, "+
				"ct.name as city "+
			"from company c,sp_country cr, sp_company_type ty, sp_country_state cs, sp_city ct "+
			"where c.id=%cid and c.member_id=%mem_id and c.country_id=cr.id and "+
			"c.company_type_id=ty.id and c.country_state_id=cs.id and c.city_id=ct.id and "+
			"c.deleted=0"

var comp_insert="insert into company(ID, MEMBER_ID, NAME, COUNTRY_ID, COMPANY_TYPE_ID, "+
			"COUNTRY_STATE_ID, STOCK_TICKER, CITY_ID, ZIP_CODE, CITY_AREA, "+
			"STREET, MEGAPOLIS, BUILDING, OFFICE, BOSS, BOSS_TYPE, BEGIN_DATE, "+
			"HIGH_ID, HIERARCHY_TYPE, REG_DATE, DISCOUNT_STATE_ID,SHORTNAME)  "+
			"values(%ID, %MEMBER_ID, '%NAME', %COUNTRY_ID, %COMPANY_TYPE_ID, "+
			"%COUNTRY_STATE_ID, '%STOCK_TICKER', %CITY_ID, '%ZIP_CODE', '%CITY_AREA', "+
			"'%STREET', '%MEGAPOLIS', '%BUILDING', '%OFFICE', '%BOSS', '%BOSS_TYPE', %BEGIN_DATE, "+
			"%HIGH_ID, %HIERARCHY_TYPE, '%REG_DATE', %DISCOUNT_STATE_ID, '%SHORTNAME')  "
var comp_update="update company set %set_field where member_id=%mem_id and id=%cid"

%>