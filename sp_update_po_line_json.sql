CREATE OR REPLACE PROCEDURE angularapi.sp_update_po_line_json(p_po_line json)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
	v_cnt numeric;
	v_amt numeric(20,2);
	V_NAME VARCHAR(200);
	C_ORD CURSOR IS
		select a."poNo" as PO_NO,a."lineNo" as LINE_NO,
			a."polineType" as PO_LINE_TYPE,a."itemNo" as ITEM_NO,a."itemrevisionNo" as ITEM_REVISION_NO,a."description" as DESCRIPTION,
			a."baseUom" as BASE_UOM,a."orderQty" as ORDER_QTY,a."uom" as UOM,
			a."qtybaseUom" as QTY_BASE_UOM,a."purchasePrice" as PURCHASE_PRICE,a."priceUom" as PRICING_UOM,a."lineextendedAmount" as LINE_EXTENDED_AMOUNT,a."taxCode" as TAX_CODE,
			a."taxAmount" as TAX_AMOUNT,a."extrachargeAmount" as EXTRA_CHARGE_AMOUNT,a."lineTotalamount" as LINE_TOTAL_AMOUNT,a."expectedDate" as EXPECTED_DATE,
            a."promisedDate" as PROMISED_DATE,a."canceledQty" as CANCELED_QTY,a."canceledqtyBaseuom" as CANCELED_QTY_BASE_UOM,a."reasonCode" as REASON_CODE,a."reasonNotes" as REASON_NOTES,
            a."workorderNo" as WORK_ORDER_NO,a."oprationNo" as OPERATION_NO,a."projectNo" as PROJECT_NO,a."receivinginspectoinRequired" as RECEIVING_INSPECTION_REQUIRED,a."trackHeatNo" as TRACK_HEAT_NO,
            a."cretedBy" as CREATED_BY,a."createdDate" as CREATED_DATE,a."changedBy" as CHANGED_BY,a."changedDate" as CHANGED_DATE,a."glaccountNumber" as GL_ACCOUNT_NUMBER,
            a."requistionNo" as REQUISITION_NO,a."reqLineno" as REQ_LINE_NO,a."reqNo" as RFQ_NO,a."reflineNo" as RFQ_LINE_NO,a."projectRecordNo" as PROJECT_RECORD_NO,
            a."projectLineno" as PROJECT_LINE_NO,a."destructionveTestingflag" as DESTRUCTIVE_TESTING_FLAG,a."orderbydate" as ORDER_BY_DATE,a."noofpiedces" as NO_OF_PIECES,a."thickdiam" as THICK_DIAM,
            a."width" as WIDTH,a."length" as LENGTH,a."weight" as WEIGHT
			from (select * from json_to_recordset(p_po_line)  as x("poNo" text,"lineNo" numeric,"polineType" text,"itemNo" text,"itemrevisionNo" text,"description" text,"baseUom" text,"orderQty" numeric,"uom" text,
            "qtybaseUom" numeric,"purchasePrice" numeric,"priceUom" text,"lineextendedAmount" numeric,"taxCode" text,"taxAmount" numeric,"extrachargeAmount" numeric,"lineTotalamount" numeric,"expectedDate" date,
            "promisedDate" date,"canceledQty" numeric,"canceledqtyBaseuom" numeric,"reasonCode" text,"reasonNotes" text,"workorderNo" text,"oprationNo" numeric,"projectNo" text,
            "receivinginspectoinRequired" text,"trackHeatNo" text,"cretedBy" text,"createdDate" date,"changedBy" text,"changedDate" date,"glaccountNumber" text,
            "requistionNo" text,"reqLineno" numeric,"reqNo" text,"reflineNo" numeric,"projectRecordNo" numeric,"projectLineno" numeric,"destructionveTestingflag" text,"orderbydate" date,
            "noofpiedces" numeric,"thickdiam" numeric,"width" numeric,"length" numeric,"weight" numeric)) a;
BEGIN
	for i in c_ord LOOP
		select count(1) INTO V_CNT
		FROM PO_LINE
		WHERE PO_NO=I.PO_NO::text;
		i.QTY_BASE_UOM=sf_calc_qty_base_uom(i.ITEM_NO, i.BASE_UOM, i.UOM,i.ORDER_QTY);
	    i.LINE_EXTENDED_AMOUNT=SF_CALC_EXTENDED_PRICE(i.ITEM_NO,i.BASE_UOM,i.PRICING_UOM,i.PURCHASE_PRICE,i.QTY_BASE_UOM);
	    i.TAX_AMOUNT=SF_GET_TAX_AMOUNT(i.TAX_CODE,i.LINE_EXTENDED_AMOUNT);
	    i.LINE_TOTAL_AMOUNT=COALESCE(i.LINE_EXTENDED_AMOUNT,0) + COALESCE(i.TAX_AMOUNT,0) + COALESCE(i.EXTRA_CHARGE_AMOUNT,0) ;

		IF V_CNT=0 THEN
			 INSERT   INTO  PO_LINE(
                                   PO_NO,
                                   LINE_NO,
                                   PO_LINE_TYPE,
                                   ITEM_NO,
                                   ITEM_REVISION_NO,
                                   DESCRIPTION,
                                   BASE_UOM,
                                   ORDER_QTY,
                                   UOM,
                                   QTY_BASE_UOM,
                                   PURCHASE_PRICE,
                                   PRICING_UOM,
                                   LINE_EXTENDED_AMOUNT,
                                   TAX_CODE,
                                   TAX_AMOUNT,
                                   EXTRA_CHARGE_AMOUNT,
                                   LINE_TOTAL_AMOUNT,
                                   EXPECTED_DATE,
                                   PROMISED_DATE,
                                   CANCELED_QTY,
                                   CANCELED_QTY_BASE_UOM,
                              REASON_CODE,
                              REASON_NOTES,
                              WORK_ORDER_NO,
                              OPERATION_NO,
                              PROJECT_NO,
                              RECEIVING_INSPECTION_REQUIRED,
                                   TRACK_HEAT_NO,
                                   CREATED_BY,
                                   CREATED_DATE,
                                   CHANGED_BY,
                                   CHANGED_DATE,
                                   GL_ACCOUNT_NUMBER,
                                   REQUISITION_NO,
                                   REQ_LINE_NO,
                                   RFQ_NO,
                                   RFQ_LINE_NO,
                                   PROJECT_RECORD_NO,
                                   PROJECT_LINE_NO,
                                   DESTRUCTIVE_TESTING_FLAG ,
                                   ORDER_BY_DATE ,
                                    NO_OF_PIECES ,
                                   THICK_DIAM,
                                   WIDTH ,
                                    LENGTH,
                                    WEIGHT
                                   )
                            VALUES(
                                   i.PO_NO,
                                   i.LINE_NO,
                                   i.PO_LINE_TYPE,
                                   i.ITEM_NO,
                                   i.ITEM_REVISION_NO,
                                   i.DESCRIPTION,
                                   i.BASE_UOM,
                                   i.ORDER_QTY,
                                   i.UOM,
                                   i.QTY_BASE_UOM,
                                   i.PURCHASE_PRICE,
                                   i.PRICING_UOM,
                                   COALESCE(i.LINE_EXTENDED_AMOUNT,0),
                                   i.TAX_CODE,
                                   COALESCE(i.TAX_AMOUNT,0),
                                   COALESCE(i.EXTRA_CHARGE_AMOUNT,0),
                                   i.LINE_TOTAL_AMOUNT,
                                   COALESCE(i.EXPECTED_DATE,CURRENT_DATE),
                                   i.PROMISED_DATE,
                                   i.CANCELED_QTY,
                                   i.CANCELED_QTY_BASE_UOM,
                              i.REASON_CODE,
                              i.REASON_NOTES,
                              i.WORK_ORDER_NO,
                              i.OPERATION_NO,
                              i.PROJECT_NO,
                              i.RECEIVING_INSPECTION_REQUIRED,
                                   i.TRACK_HEAT_NO,
                                   i.CREATED_BY,
                                   i.CREATED_DATE,
                                   i.CHANGED_BY,
                                   i.CHANGED_DATE,
                                   i.GL_ACCOUNT_NUMBER,
                                   i.REQUISITION_NO,
                                   i.REQ_LINE_NO,
                                   i.RFQ_NO,
                                   i.RFQ_LINE_NO ,
                                   i.PROJECT_RECORD_NO,
                                   i.PROJECT_LINE_NO,
                                   i.DESTRUCTIVE_TESTING_FLAG,
                                   i.ORDER_BY_DATE ,
                                     i.NO_OF_PIECES ,
                                   i.THICK_DIAM,
                                   i.WIDTH ,
                                    i.LENGTH,
                                    i.WEIGHT
                                   );	
		else
			
			UPDATE PO_LINE 
			SET (
                      
                                   LINE_NO,
                                   PO_LINE_TYPE,
                                   ITEM_NO,
                                   ITEM_REVISION_NO,
                                   DESCRIPTION,
                                   BASE_UOM,
                                   ORDER_QTY,
                                   UOM,
                                   QTY_BASE_UOM,
                                   PURCHASE_PRICE,
                                   PRICING_UOM,
                                   LINE_EXTENDED_AMOUNT,
                                   TAX_CODE,
                                   TAX_AMOUNT,
                                   EXTRA_CHARGE_AMOUNT,
                                   LINE_TOTAL_AMOUNT,
                                   EXPECTED_DATE,
                                   PROMISED_DATE,
                                   CANCELED_QTY,
                                   CANCELED_QTY_BASE_UOM,
                              REASON_CODE,
                              REASON_NOTES,
                              WORK_ORDER_NO,
                              OPERATION_NO,
                              PROJECT_NO,
                              RECEIVING_INSPECTION_REQUIRED,
                                   TRACK_HEAT_NO,
                                   CREATED_BY,
                                   CREATED_DATE,
                                   CHANGED_BY,
                                   CHANGED_DATE,
                                   GL_ACCOUNT_NUMBER,
                                   REQUISITION_NO,
                                   REQ_LINE_NO,
                                   RFQ_NO,
                                   RFQ_LINE_NO,
                                   PROJECT_RECORD_NO,
                                   PROJECT_LINE_NO,
                                   DESTRUCTIVE_TESTING_FLAG ,
                                   ORDER_BY_DATE ,
                                    NO_OF_PIECES ,
                                   THICK_DIAM,
                                   WIDTH ,
                                    LENGTH,
                                    WEIGHT)=
			(
                                   i.LINE_NO,
                                   i.PO_LINE_TYPE,
                                   i.ITEM_NO,
                                   i.ITEM_REVISION_NO,
                                   i.DESCRIPTION,
                                   i.BASE_UOM,
                                   i.ORDER_QTY,
                                   i.UOM,
                                   i.QTY_BASE_UOM,
                                   i.PURCHASE_PRICE,
                                   i.PRICING_UOM,
                                   COALESCE(i.LINE_EXTENDED_AMOUNT,0),
                                   i.TAX_CODE,
                                   COALESCE(i.TAX_AMOUNT,0),
                                   COALESCE(i.EXTRA_CHARGE_AMOUNT,0),
                                   i.LINE_TOTAL_AMOUNT,
                                   COALESCE(i.EXPECTED_DATE,CURRENT_DATE),
                                   i.PROMISED_DATE,
                                   i.CANCELED_QTY,
                                   i.CANCELED_QTY_BASE_UOM,
                              i.REASON_CODE,
                              i.REASON_NOTES,
                              i.WORK_ORDER_NO,
                              i.OPERATION_NO,
                              i.PROJECT_NO,
                              i.RECEIVING_INSPECTION_REQUIRED,
                                   i.TRACK_HEAT_NO,
                                   i.CREATED_BY,
                                   i.CREATED_DATE,
                                   i.CHANGED_BY,
                                   i.CHANGED_DATE,
                                   i.GL_ACCOUNT_NUMBER,
                                   i.REQUISITION_NO,
                                   i.REQ_LINE_NO,
                                   i.RFQ_NO,
                                   i.RFQ_LINE_NO ,
                                   i.PROJECT_RECORD_NO,
                                   i.PROJECT_LINE_NO,
                                   i.DESTRUCTIVE_TESTING_FLAG,
                                   i.ORDER_BY_DATE ,
                                     i.NO_OF_PIECES ,
                                   i.THICK_DIAM,
                                   i.WIDTH ,
                                    i.LENGTH,
                                    i.WEIGHT)
			WHERE PO_NO=I.PO_NO::text;
		
			-- select sum(line_total_cost) into v_amt  
				-- from ext_order_lines
				-- where order_no=i.order_no::TEXT;
	
				-- update ext_order_header 
				-- set ordertotal =v_amt
					-- where order_no=i.order_no::TEXT;
		END IF;
		/*select coalesce(sum(line_total_cost),0) into v_amt  
		from ext_order_lines
		where order_no=i.order_no;
	
		update ext_order_header 
		set ordertotal =v_amt
			where order_no=i.order_no;*/
	end loop;
--exception
	--when others THEN
--	null;
end;
$procedure$
;
