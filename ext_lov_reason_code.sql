CREATE OR REPLACE FUNCTION angularapi.ext_lov_reason_code()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT REASON_CODE,CODE_CATEGORY FROM GE_REASON_CODES WHERE nullif(INACTIVE,'')='N' ORDER BY REASON_CODE) row;
	 
return V_JSON; 
END $function$
;
