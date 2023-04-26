CREATE OR REPLACE PROCEDURE angularapi.sp_update_po_header_json(p_po_ord json)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
	v_cnt numeric;
	v_amt numeric(20,2);
	V_NAME VARCHAR(200);
	C_ORD CURSOR IS
		select a."poNo" as PO_NO,a."businessUnitcode" as BUSINESS_UNIT_CODE,
			a."poDate" as PO_DATE,a."expectedDate" as EXPECTED_DATE,a."vendorConfirmeddate" as VENDOR_CONFIRMED_DATE,a."vendorNo" as VENDOR_NO,
			a."name" as NAME,a."internalNotes" as INTERNAL_NOTES,a."poNotes" as PO_NOTES,a."shippingNotes" as SHIPPING_NOTES,a."contactName" as CONTACT_NAME,a."street" as STREET,a."city" as CITY,
			a."stateCode" as STATE_CODE,a."postalCode" as POSTAL_CODE,a."country" as COUNTRY,a."phone" as PHONE,a."fax" as FAX,a."email" as EMAIL,
            a."termsCode" as TERMS_CODE,a."shipVia" as SHIP_VIA,a."fob" as FOB,a."paymentMethod" as PAYMENT_METHOD,a."vendorReference" as VENDOR_REFERENCE,
            a."requestedBy" as REQUESTED_BY,a."buyer" as BUYER,a."authorizedBy" as AUTHORIZED_BY,a."authorizeDate" as AUTHORIZED_DATE,a."differentRemitToAddress" as DIFFERENT_REMIT_TO_ADDRESS,
            a."remitToname" as REMIT_TO_NAME,a."remittoContactname" as REMIT_TO_CONTACT_NAME,a."remittoStreet" as REMIT_TO_STREET,a."remittoCity" as REMIT_TO_CITY,a."remittoStatecode" as REMIT_TO_STATE_CODE,
            a."remittoPostalcode" as REMIT_TO_POSTAL_CODE,a."remittoCountry" as REMIT_TO_COUNTRY,a."remittoPhone" as REMIT_TO_PHONE,a."remittoFax" as REMIT_TO_FAX,a."remittoEmail" as REMIT_TO_EMAIL,
            a."differentShippingaddress" as DIFFERENT_SHIPPING_ADDRESS,a."shiptoCode" as SHIPTO_CODE,a."shippingName" as SHIPPING_NAME,a."shippingContactname" as SHIPPING_CONTACT_NAME,a."shippingStreet" as SHIPPING_STREET,
            a."shippingCity" as SHIPPING_CITY,a."shippingStatecode" as SHIPPING_STATE_CODE,a."shippingPostalcode" as SHIPPING_POSTAL_CODE,a."shippingCountry" as SHIPPING_COUNTRY,a."shippingPhone" as SHIPPING_PHONE,a."shippingFax" as SHIPPING_FAX,
            a."shippingEmail" as SHIPPING_EMAIL,a."differentFreightBillAddress" as DIFFERENT_FREIGHT_BILL_ADDRESS,a."differentFreightBillName" as FREIGHT_BILLING_NAME,a."differentFreightBillContact" as FREIGHT_BILLING_CONTACT_NAME,
            a."freightBillStreet" as FREIGHT_BILLING_STREET,a."freightBillCity" as FREIGHT_BILLING_CITY,
                       a."freightBillStateCode" as FREIGHT_BILLING_STATE_CODE,
                       a."freightBillPostal" as FREIGHT_BILLING_POSTAL_CODE,
                       a."freightBillCountry" as FREIGHT_BILLING_COUNTRY,
                       a."freightBillPhone" as FREIGHT_BILLING_PHONE,
                       a."freightBillFax" as FREIGHT_BILLING_FAX,
                       a."freightBillEmail" as FREIGHT_BILLING_EMAIL,
                       a."blabketOrder" as BLANKET_ORDER,
                       a."itemNo" as ITEM_NO,
                       a."blanketQty" as BLANKET_QTY,
                       a."orderingUom" as ORDERING_UOM,
                       a."purchasePrice" as PURCHASE_PRICE,
                       a."pricingUom" as PRICING_UOM,
                       a."blanketEffectivefrom" as BLANKET_EFFECTIVE_FROM,
                       a."blanketeffectiveTill" as BLANKET_EFFECTIVE_TILL,
                       a."blanketReleaseno" as BLANKET_RELEASE_NO,
                       a."message" as MESSAGE,
                       a."createdBy" as CREATED_BY,
                       a."createdDate" as CREATED_DATE,
                       a."changedBy" as CHANGED_BY,
                       a."changedDate" as CHANGED_DATE,
                       a."poType" as PO_TYPE,
                       a."warehouseNumber" as WAREHOUSE_NUMBER,
                       a."dimnsionalInv" as DIMENSIONAL_INV_REQUIRED
			from (select * from json_to_recordset(p_po_ord)  as x("poNo" text,"businessUnitcode" text,"poDate" date,"expectedDate" date,"vendorConfirmeddate" date,"vendorNo" text,"name" text,"internalNotes" text,"poNotes" text,"shippingNotes" text,"contactName" text,"street" text,"city" text,"stateCode" text,"postalCode" text,"country" text,"phone" text,"fax" text,"email" text,"termsCode" text,"shipVia" text,"fob" text,"paymentMethod" text,"vendorReference" text,
            "requestedBy" text,"buyer" text,"authorizedBy" text,"authorizeDate" date,"differentRemitToAddress" text,
            "remitToname" text,"remittoContactname" text,"remittoStreet" text,"remittoCity" text,"remittoStatecode" text,
            "remittoPostalcode" text,"remittoCountry" text,"remittoPhone" text,"remittoFax" text,"remittoEmail" text,
            "differentShippingaddress" text,"shiptoCode" text,"shippingName" text,"shippingContactname" text,"shippingStreet" text,
            "shippingCity" text,"shippingStatecode" text,"shippingPostalcode" text,"shippingCountry" text,"shippingPhone" text,"shippingFax" text ,
            "shippingEmail" text,"differentFreightBillAddress" text,"differentFreightBillName" text,"differentFreightBillContact" text,
            "freightBillStreet" text,"freightBillCity" text,
                       "freightBillStateCode" text ,
                       "freightBillPostal" text,
                       "freightBillCountry" text,
                       "freightBillPhone" text,
                       "freightBillFax" text ,
                       "freightBillEmail" text ,
                       "blabketOrder" text ,
                       "itemNo" text ,
                       "blanketQty" numeric ,
                       "orderingUom" text ,
                       "purchasePrice" numeric ,
                       "pricingUom" text ,
                       "blanketEffectivefrom" date,
                       "blanketeffectiveTill" date ,
                       "blanketReleaseno" text,
                       "message" text ,
                       "createdBy" text ,
                       "createdDate" date ,
                       "changedBy" text ,
                       "changedDate" date ,
                       "poType" text, 
                       "warehouseNumber" text ,
                       "dimnsionalInv" text )) a;
BEGIN
	for i in c_ord LOOP
		select count(1) INTO V_CNT
		FROM PO_HEADER
		WHERE PO_NO=I.PO_NO::text;
		

		IF V_CNT=0 THEN
			INSERT INTO PO_HEADER(
                       PO_NO,
                       BUSINESS_UNIT_CODE,
                       PO_DATE,
                       EXPECTED_DATE,
                       VENDOR_CONFIRMED_DATE,
                       VENDOR_NO,
                       NAME,
                       INTERNAL_NOTES,
                       PO_NOTES,
                       SHIPPING_NOTES,
                       CONTACT_NAME,
                       STREET,
                       CITY,
                       STATE_CODE,
                       POSTAL_CODE,
                       COUNTRY,
                       PHONE,
                       FAX,
                       EMAIL,
                       TERMS_CODE,
                       SHIP_VIA,
                       FOB,
                       PAYMENT_METHOD,
                       VENDOR_REFERENCE,
                       REQUESTED_BY,
                       BUYER,
                       AUTHORIZED_BY,
                       AUTHORIZED_DATE,
                       DIFFERENT_REMIT_TO_ADDRESS,
                       REMIT_TO_NAME,
                       REMIT_TO_CONTACT_NAME,
                       REMIT_TO_STREET,
                       REMIT_TO_CITY,
                       REMIT_TO_STATE_CODE,
                       REMIT_TO_POSTAL_CODE,
                       REMIT_TO_COUNTRY,
                       REMIT_TO_PHONE,
                       REMIT_TO_FAX,
                       REMIT_TO_EMAIL,
                       DIFFERENT_SHIPPING_ADDRESS,
                       SHIPTO_CODE,
                       SHIPPING_NAME,
                       SHIPPING_CONTACT_NAME,
                       SHIPPING_STREET,
                       SHIPPING_CITY,
                       SHIPPING_STATE_CODE,
                       SHIPPING_POSTAL_CODE,
                       SHIPPING_COUNTRY,
                       SHIPPING_PHONE,
                       SHIPPING_FAX,
                       SHIPPING_EMAIL,
                       DIFFERENT_FREIGHT_BILL_ADDRESS,
                       FREIGHT_BILLING_NAME,
                       FREIGHT_BILLING_CONTACT_NAME,
                       FREIGHT_BILLING_STREET,
                       FREIGHT_BILLING_CITY,
                       FREIGHT_BILLING_STATE_CODE,
                       FREIGHT_BILLING_POSTAL_CODE,
                       FREIGHT_BILLING_COUNTRY,
                       FREIGHT_BILLING_PHONE,
                       FREIGHT_BILLING_FAX,
                       FREIGHT_BILLING_EMAIL,
                       BLANKET_ORDER,
                       ITEM_NO,
                       BLANKET_QTY,
                       ORDERING_UOM,
                       PURCHASE_PRICE,
                       PRICING_UOM,
                       BLANKET_EFFECTIVE_FROM,
                       BLANKET_EFFECTIVE_TILL,
                       BLANKET_RELEASE_NO,
                       MESSAGE,
                       CREATED_BY,
                       CREATED_DATE,
                       CHANGED_BY,
                       CHANGED_DATE,
                       PO_TYPE,
                       WAREHOUSE_NUMBER,
                       DIMENSIONAL_INV_REQUIRED)
                      VALUES(
                     i.PO_NO,
                     i.BUSINESS_UNIT_CODE,
                     i.PO_DATE,
                     i.EXPECTED_DATE,
                     i.VENDOR_CONFIRMED_DATE,
                     i.VENDOR_NO,
                     i.NAME,
                     i.INTERNAL_NOTES,
                     i.PO_NOTES,
                     i.SHIPPING_NOTES,
                     i.CONTACT_NAME,
                     i.STREET,
                     i.CITY,
                     i.STATE_CODE,
                     i.POSTAL_CODE,
                     i.COUNTRY,
                     i.PHONE,
                     i.FAX,
                     i.EMAIL,
                     i.TERMS_CODE,
                     i.SHIP_VIA,
                     i.FOB,
                     i.PAYMENT_METHOD,
                     i.VENDOR_REFERENCE,
                     i.REQUESTED_BY,
                     i.BUYER,
                     i.AUTHORIZED_BY,
                     i.AUTHORIZED_DATE,
                     i.DIFFERENT_REMIT_TO_ADDRESS,
                     i.REMIT_TO_NAME,
                     i.REMIT_TO_CONTACT_NAME,
                     i.REMIT_TO_STREET,
                     i.REMIT_TO_CITY,
                     i.REMIT_TO_STATE_CODE,
                     i.REMIT_TO_POSTAL_CODE,
                     i.REMIT_TO_COUNTRY,
                     i.REMIT_TO_PHONE,
                     i.REMIT_TO_FAX,
                     i.REMIT_TO_EMAIL,
                     i.DIFFERENT_SHIPPING_ADDRESS,
                     i.SHIPTO_CODE,
                     i.SHIPPING_NAME,
                     i.SHIPPING_CONTACT_NAME,
                     i.SHIPPING_STREET,
                     i.SHIPPING_CITY,
                     i.SHIPPING_STATE_CODE,
                     i.SHIPPING_POSTAL_CODE,
                     i.SHIPPING_COUNTRY,
                     i.SHIPPING_PHONE,
                     i.SHIPPING_FAX,
                     i.SHIPPING_EMAIL,
                     i.DIFFERENT_FREIGHT_BILL_ADDRESS,
                     i.FREIGHT_BILLING_NAME,
                     i.FREIGHT_BILLING_CONTACT_NAME,
                     i.FREIGHT_BILLING_STREET,
                     i.FREIGHT_BILLING_CITY,
                     i.FREIGHT_BILLING_STATE_CODE,
                     i.FREIGHT_BILLING_POSTAL_CODE,
                     i.FREIGHT_BILLING_COUNTRY,
                     i.FREIGHT_BILLING_PHONE,
                     i.FREIGHT_BILLING_FAX,
                     i.FREIGHT_BILLING_EMAIL,
                     i.BLANKET_ORDER,
                     i.ITEM_NO,
                     i.BLANKET_QTY,
                     i.ORDERING_UOM,
                     i.PURCHASE_PRICE,
                     i.PRICING_UOM,
                     i.BLANKET_EFFECTIVE_FROM,
                     i.BLANKET_EFFECTIVE_TILL,
                     i.BLANKET_RELEASE_NO,
                     i.MESSAGE,
                     i.CREATED_BY,
                     i.CREATED_DATE,
                     i.CHANGED_BY,
                     i.CHANGED_DATE,
                     i.PO_TYPE   ,
                     i.WAREHOUSE_NUMBER,
                     i.DIMENSIONAL_INV_REQUIRED);	
		else
			
			UPDATE PO_HEADER 
			SET (
                       BUSINESS_UNIT_CODE,
                       PO_DATE,
                       EXPECTED_DATE,
                       VENDOR_CONFIRMED_DATE,
                       VENDOR_NO,
                       NAME,
                       INTERNAL_NOTES,
                       PO_NOTES,
                       SHIPPING_NOTES,
                       CONTACT_NAME,
                       STREET,
                       CITY,
                       STATE_CODE,
                       POSTAL_CODE,
                       COUNTRY,
                       PHONE,
                       FAX,
                       EMAIL,
                       TERMS_CODE,
                       SHIP_VIA,
                       FOB,
                       PAYMENT_METHOD,
                       VENDOR_REFERENCE,
                       REQUESTED_BY,
                       BUYER,
                       AUTHORIZED_BY,
                       AUTHORIZED_DATE,
                       DIFFERENT_REMIT_TO_ADDRESS,
                       REMIT_TO_NAME,
                       REMIT_TO_CONTACT_NAME,
                       REMIT_TO_STREET,
                       REMIT_TO_CITY,
                       REMIT_TO_STATE_CODE,
                       REMIT_TO_POSTAL_CODE,
                       REMIT_TO_COUNTRY,
                       REMIT_TO_PHONE,
                       REMIT_TO_FAX,
                       REMIT_TO_EMAIL,
                       DIFFERENT_SHIPPING_ADDRESS,
                       SHIPTO_CODE,
                       SHIPPING_NAME,
                       SHIPPING_CONTACT_NAME,
                       SHIPPING_STREET,
                       SHIPPING_CITY,
                       SHIPPING_STATE_CODE,
                       SHIPPING_POSTAL_CODE,
                       SHIPPING_COUNTRY,
                       SHIPPING_PHONE,
                       SHIPPING_FAX,
                       SHIPPING_EMAIL,
                       DIFFERENT_FREIGHT_BILL_ADDRESS,
                       FREIGHT_BILLING_NAME,
                       FREIGHT_BILLING_CONTACT_NAME,
                       FREIGHT_BILLING_STREET,
                       FREIGHT_BILLING_CITY,
                       FREIGHT_BILLING_STATE_CODE,
                       FREIGHT_BILLING_POSTAL_CODE,
                       FREIGHT_BILLING_COUNTRY,
                       FREIGHT_BILLING_PHONE,
                       FREIGHT_BILLING_FAX,
                       FREIGHT_BILLING_EMAIL,
                       BLANKET_ORDER,
                       ITEM_NO,
                       BLANKET_QTY,
                       ORDERING_UOM,
                       PURCHASE_PRICE,
                       PRICING_UOM,
                       BLANKET_EFFECTIVE_FROM,
                       BLANKET_EFFECTIVE_TILL,
                       BLANKET_RELEASE_NO,
                       MESSAGE,
                       CREATED_BY,
                       CREATED_DATE,
                       CHANGED_BY,
                       CHANGED_DATE,
                       PO_TYPE,
                       WAREHOUSE_NUMBER,
                       DIMENSIONAL_INV_REQUIRED)=
			(
                     i.BUSINESS_UNIT_CODE,
                     i.PO_DATE,
                     i.EXPECTED_DATE,
                     i.VENDOR_CONFIRMED_DATE,
                     i.VENDOR_NO,
                     i.NAME,
                     i.INTERNAL_NOTES,
                     i.PO_NOTES,
                     i.SHIPPING_NOTES,
                     i.CONTACT_NAME,
                     i.STREET,
                     i.CITY,
                     i.STATE_CODE,
                     i.POSTAL_CODE,
                     i.COUNTRY,
                     i.PHONE,
                     i.FAX,
                     i.EMAIL,
                     i.TERMS_CODE,
                     i.SHIP_VIA,
                     i.FOB,
                     i.PAYMENT_METHOD,
                     i.VENDOR_REFERENCE,
                     i.REQUESTED_BY,
                     i.BUYER,
                     i.AUTHORIZED_BY,
                     i.AUTHORIZED_DATE,
                     i.DIFFERENT_REMIT_TO_ADDRESS,
                     i.REMIT_TO_NAME,
                     i.REMIT_TO_CONTACT_NAME,
                     i.REMIT_TO_STREET,
                     i.REMIT_TO_CITY,
                     i.REMIT_TO_STATE_CODE,
                     i.REMIT_TO_POSTAL_CODE,
                     i.REMIT_TO_COUNTRY,
                     i.REMIT_TO_PHONE,
                     i.REMIT_TO_FAX,
                     i.REMIT_TO_EMAIL,
                     i.DIFFERENT_SHIPPING_ADDRESS,
                     i.SHIPTO_CODE,
                     i.SHIPPING_NAME,
                     i.SHIPPING_CONTACT_NAME,
                     i.SHIPPING_STREET,
                     i.SHIPPING_CITY,
                     i.SHIPPING_STATE_CODE,
                     i.SHIPPING_POSTAL_CODE,
                     i.SHIPPING_COUNTRY,
                     i.SHIPPING_PHONE,
                     i.SHIPPING_FAX,
                     i.SHIPPING_EMAIL,
                     i.DIFFERENT_FREIGHT_BILL_ADDRESS,
                     i.FREIGHT_BILLING_NAME,
                     i.FREIGHT_BILLING_CONTACT_NAME,
                     i.FREIGHT_BILLING_STREET,
                     i.FREIGHT_BILLING_CITY,
                     i.FREIGHT_BILLING_STATE_CODE,
                     i.FREIGHT_BILLING_POSTAL_CODE,
                     i.FREIGHT_BILLING_COUNTRY,
                     i.FREIGHT_BILLING_PHONE,
                     i.FREIGHT_BILLING_FAX,
                     i.FREIGHT_BILLING_EMAIL,
                     i.BLANKET_ORDER,
                     i.ITEM_NO,
                     i.BLANKET_QTY,
                     i.ORDERING_UOM,
                     i.PURCHASE_PRICE,
                     i.PRICING_UOM,
                     i.BLANKET_EFFECTIVE_FROM,
                     i.BLANKET_EFFECTIVE_TILL,
                     i.BLANKET_RELEASE_NO,
                     i.MESSAGE,
                     i.CREATED_BY,
                     i.CREATED_DATE,
                     i.CHANGED_BY,
                     i.CHANGED_DATE,
                     i.PO_TYPE   ,
                     i.WAREHOUSE_NUMBER,
                     i.DIMENSIONAL_INV_REQUIRED)
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