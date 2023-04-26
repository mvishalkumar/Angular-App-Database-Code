CREATE OR REPLACE FUNCTION angularapi.ext_lov_tax_code()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT TAX_CODE, DESCRIPTION,TAX_PERCENTAGE FROM GE_TAX_CODES ORDER BY RECORD_NO) row;
	 
return V_JSON; 
END $function$
;
