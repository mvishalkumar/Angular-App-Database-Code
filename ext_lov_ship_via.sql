CREATE OR REPLACE FUNCTION angularapi.ext_lov_ship_via()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (select SHIP_VIA from  GE_SHIP_VIA where COALESCE(NULLIF(INACTIVE,''::TEXT),'N')='N') row;
	 
return V_JSON; 
END $function$
;
