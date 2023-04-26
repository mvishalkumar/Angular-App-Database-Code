CREATE OR REPLACE FUNCTION angularapi.ext_lov_country()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT COUNTRY_CODE,COUNTRY FROM GE_COUNTRY_CODES WHERE COALESCE(NULLIF(INACTIVE,''),'Y')='N' ORDER BY COUNTRY) row;
	 
return V_JSON; 
END $function$
;
