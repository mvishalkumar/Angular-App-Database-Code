CREATE OR REPLACE FUNCTION angularapi.ext_lov_requested_by()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT EMPLOYEE_NUMBER, NAME,DEPARTMENT FROM R_GL_EMPLOYEE ORDER BY EMPLOYEE_NUMBER) row;
	 
return V_JSON; 
END $function$
;
