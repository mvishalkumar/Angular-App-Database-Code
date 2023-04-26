CREATE OR REPLACE FUNCTION angularapi.ext_oper_no(p_work_order_no character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT STEP_ID, OPERATION_CODE,OPERATION_DESCRIPTION,OPERATION_TYPE FROM MFG_WO_ROUTING WHERE OPERATION_TYPE  = 'OP' AND WORK_ORDER_NO = p_work_order_no ORDER BY OPERATION_CODE ) row;
	 
return V_JSON; 
END $function$
;
