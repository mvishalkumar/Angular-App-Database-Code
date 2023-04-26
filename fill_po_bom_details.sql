CREATE OR REPLACE FUNCTION angularapi.fill_po_bom_details(p_parent_item_no character varying, p_parent_rev_no character varying, p_bom_routing_id character varying, p_version_id character varying, p_bom_routing_rev_no character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (select ITEM_NO,ITEM_REVISION_NO,DESCRIPTION,QTY_REQUIRED,TOTAL_QTY,VENDOR_SUPPLIED,PO_NO,PO_LINE_NO,LINE_NO,BOM_ROUTING_ID,BOM_TYPE,BATCH_SIZE from V_MFG_BOM_ITEMS where PARENT_ITEM_NO = p_parent_item_no AND PARENT_REV_NO = p_parent_rev_no AND BOM_ROUTING_ID = p_bom_routing_id AND VERSION_ID = p_version_id AND BOM_ROUTING_REV_NO =p_bom_routing_rev_no) row;
	 
return V_JSON; 
END $function$
;
