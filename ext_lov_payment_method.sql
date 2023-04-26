CREATE OR REPLACE FUNCTION angularapi.ext_lov_payment_method()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (select PAYMENT_METHOD from GE_PAYMENT_METHOD where COALESCE(NULLIF(INACTIVE,''::TEXT),'N')='N') row;
	 
return V_JSON; 
END $function$
;
