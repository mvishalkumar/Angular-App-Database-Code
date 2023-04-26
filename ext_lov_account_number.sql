CREATE OR REPLACE FUNCTION angularapi.ext_lov_account_number()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT GL_ACCOUNT_NUMBER,DESCRIPTION, ACCOUNT_TYPE,BUSINESS_UNIT_CODE FROM V_GL_ACCOUNTS WHERE COALESCE(NULLIF(INACTIVE,''::TEXT),'N')='N' ORDER BY GL_ACCOUNT_NUMBER) row;
	 
return V_JSON; 
END $function$
;
