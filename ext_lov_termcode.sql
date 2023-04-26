CREATE OR REPLACE FUNCTION angularapi.ext_lov_termcode()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (select TERMS_CODE,DESCRIPTION,inactive  from GE_TERMS_CODES order by TERMS_CODE) row;
	 
return V_JSON; 
END $function$
;
