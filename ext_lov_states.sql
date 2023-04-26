CREATE OR REPLACE FUNCTION angularapi.ext_lov_states()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT STATE_CODE,STATE_NAME,COUNTRY FROM R_STATE_CODES WHERE COALESCE(NULLIF(INACTIVE,''),'Y')='N' ORDER BY STATE_CODE) row;
	 
return V_JSON; 
END $function$
;
