<%
var account_insert="insert into ACCOUNT (ID, CARD_NUMBER,  CARD_SERIES,  E_MAIL,   SEX,  BIRTH_YEAR, "+
  "BIRTH_LAND, LIVE_LAND, STATE_ID, MARRIED, ABROADS_TIMES, CHILDREN_COUNT, "+
  "EDUCATION_ID, PROFESSION_ID, STAG_ID, WORK_STATE_ID, YEAR_INCOME_ID, READER_PROF, "+
  "MEDIA_ID, CAR_LAND, COMPUTER_TYPE_ID, INTERNET_YEARS, INTERNET_PLACE_ID, "+
  "USE_WEB_SHOP, HOBBY, REG_DATE, STATE, INTERNET_TIMES) "+
"values(%id, '%cnumber',  '%cseries',  '%email',  %sex, %birthyear, "+
  "%bcountry, %country, %state, %married, %abroad, %ccount, "+
  "%education, %prof, %stag, %work, %income, %profmag, "+
  "%media, %ccountry, %pc, %inetyear, %iplace, "+
  "%webshop, '%hobby', 'now', 1, %inettimes)"
%>