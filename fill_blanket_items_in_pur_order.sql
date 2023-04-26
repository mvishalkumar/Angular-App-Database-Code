CREATE OR REPLACE FUNCTION angularapi.fill_blanket_items_in_pur_order(p_item_no character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT ITEM_DESCRIPTION, BASE_UOM,CURRENT_REVISION_NO,CURRENT_REVISION_NO,PURCHASE_PRICE_UOM,ORDERING_UOM,PURCHASE_COST,PURCHASE_PRICE_UOM,THICK_DIAM,WIDTH,LENGTH FROM IM_ITEMS WHERE ITEM_NO=p_item_no) row;
	 
return V_JSON; 
END $function$
;
