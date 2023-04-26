CREATE OR REPLACE FUNCTION angularapi.ext_worker_order(p_item_no character varying, p_po_type character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT WORK_ORDER_NO,WORK_ORDER_TYPE FROM V_PO_WORK_ORDER where ITEM_NO=p_item_no and po_type=p_po_type ORDER BY WORK_ORDER_NO ) row;
	 
return V_JSON; 
END $function$
;
