CREATE OR REPLACE FUNCTION angularapi.ext_lov_city()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT DISTINCT CITY, STATE_CODE, COUNTRY FROM GE_CITY WHERE COALESCE(NULLIF(INACTIVE,''),'Y')='N' ORDER BY CITY , STATE_CODE ,COUNTRY ) row;
	 
return V_JSON; 
END $function$
;
