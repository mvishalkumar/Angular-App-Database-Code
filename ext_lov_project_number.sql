CREATE OR REPLACE FUNCTION angularapi.ext_lov_project_number()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT PROJECT_NO ,PROJECT_DESCRIPTION ,CUSTOMER_NO FROM PM_PROJECT_HEADER WHERE pkg_status$sf_project_master_status('PM_PROJECT_HEADER'::varchar,RECORD_NO::varchar,NULL::varchar,NULL::varchar,NULL::varchar,NULL::varchar,NULL::varchar) ='Open' ORDER BY PROJECT_NO ) row;
	 
return V_JSON; 
END $function$
;
