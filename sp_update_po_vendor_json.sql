CREATE OR REPLACE PROCEDURE angularapi.sp_update_po_vendor_json(p_po_line json)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
	v_cnt numeric;
	v_amt numeric(20,2);
	V_NAME VARCHAR(200);
	v_line_extend numeric(20,0);
	C_ORD CURSOR IS
		select a."vendorNo" as vendor_no,a."name" as name,
			a."shortnamforReports" as short_name_for_reports,a."vendorType" as vendor_type,a."inactive" as inactive,a."salutation" as salutation,
			a."firstName" as first_name,a."middleName" as middle_name,a."lastName" as last_name,
			a."street" as street,a."city" as city,a."stateCode" as state_code,a."postal_code" as postal_code,a."country" as country,
			a."phone" as phone,a."fax" as fax,a."email" as email,a."website" as website,
            a."contactMethod" as contact_method,a."differentRemittoaddress" as different_remit_to_address,a."remitToname" as remit_to_name,a."remitTostreet" as remit_to_street,a."remitTocity" as remit_to_city,
            a."remittoStatecode" as remit_to_state_code,a."remittoPostalcode" as remit_to_postal_code,a."remittoCountry" as remit_to_country,a."remitTophone" as remit_to_phone,a."remitTofax" as remit_to_fax,
            a."remitToemail" as remit_to_email,a."termsCode" as terms_code,a."shipVia" as ship_via,a."fob" as fob,a."paymentMethod" as payment_method,
            a."priceLevel" as price_level,a."exempt1099" as exempt_1099,a."taxExemptno" as tax_exempt_no,a."taxCode" as tax_code,a."taxPayerid" as tax_payer_id,
            a."creditLimit" as credit_limit,a."customerCode" as customer_code,a."leadtimeIndays" as lead_time_in_days,a."defaultPolinetype" as default_po_line_type,a."internalNotes" as internal_notes,
            a."poNotes" as po_notes,a."shippingNotes" as shipping_notes,a."createdBy" as created_by, a."createdDate" as created_date,a."changedBy" as changed_by,a."changedDate" as changed_date,
			a."glaccountNumber" as gl_account_number,a."approvedVendor" as approved_vendor,a."report1099" as report_1099, a."dimensionalInvrequired" as dimensional_inv_required,
			a."bankRoutingno" as bank_routing_no
			from (select * from json_to_recordset(p_po_line)  as x("vendorNo" text,"name" text,"shortnamforReports" text,"vendorType" text,"inactive" text,"salutation" text,"firstName" text,"middleName" text,"lastName" text,
"street" text,"city" text,"stateCode" text,"postal_code" text,"country" text,"phone" text,"fax" text,"email" text,"website" text,
"contactMethod" text,"differentRemittoaddress" text,"remitToname" text,"remitTostreet" text,"remitTocity" text,"remittoStatecode" text,"remittoPostalcode" text,"remittoCountry" text,"remitTophone" text,"remitTofax" text,
"remitToemail" text,"termsCode" text,"shipVia" text,"fob" text,"paymentMethod" text,"priceLevel" text,"exempt1099" text,"taxExemptno" text,"taxCode" text,"taxPayerid" text,
"creditLimit" numeric,"customerCode" text,"leadtimeIndays" numeric,"defaultPolinetype" text,"internalNotes" text,"poNotes" text,"shippingNotes" text,"createdBy" text, "createdDate" date,"changedBy" text,"changedDate" date,
"glaccountNumber" text,"approvedVendor" text,"report1099" text, "dimensionalInvrequired" text,"bankRoutingno" text)) a;
BEGIN
	for i in c_ord LOOP
		select count(1) INTO V_CNT
		FROM po_vendors
		WHERE vendor_no=I.vendor_no::text;
		

		IF V_CNT=0 THEN
			 INSERT   INTO  po_vendors(
                                   vendor_no,
                                   "name",
                                   short_name_for_reports,
                                   vendor_type,
                                   inactive,
                                   salutation,
                                   first_name,
                                   middle_name,
                                   last_name,
                                   street,
                                   city,
                                   state_code,
                                   postal_code,
                                   country,
                                   phone,
                                   fax,
                                   email,
                                   website,
                                   contact_method,
                                   different_remit_to_address,
                                   remit_to_name,
                              remit_to_street,
                              remit_to_city,
                              remit_to_state_code,
                              remit_to_postal_code,
                              remit_to_country,
                              remit_to_phone,
                                   remit_to_fax,
                                   remit_to_email,
                                   terms_code,
                                   ship_via,
                                   fob,
                                   payment_method,
                                   price_level,
                                   exempt_1099,
                                   tax_exempt_no,
                                   tax_code,
                                   tax_payer_id,
                                   credit_limit,
                                   customer_code ,
                                   lead_time_in_days ,
                                    default_po_line_type ,
                                   internal_notes,
                                   po_notes ,
                                    shipping_notes,
                                    created_by,
									created_date,
									changed_by,
									changed_date,
									gl_account_number,
									approved_vendor,
									report_1099,
									dimensional_inv_required,
									bank_routing_no
									
                                   )
                            VALUES(
                                   i.vendor_no,
                                   i."name",
                                   i.short_name_for_reports,
                                   i.vendor_type,
                                   i.inactive,
                                   i.salutation,
                                   i.first_name,
                                   i.middle_name,
                                   i.last_name,
                                   i.street,
                                   i.city,
                                   i.state_code,
                                   i.postal_code,
                                   i.country,
                                   i.phone,
                                   i.fax,
                                   i.email,
                                   i.website,
                                   i.contact_method,
                                   i.different_remit_to_address,
                                   i.remit_to_name,
                              i.remit_to_street,
                              i.remit_to_city,
                              i.remit_to_state_code,
                              i.remit_to_postal_code,
                              i.remit_to_country,
                              i.remit_to_phone,
                                   i.remit_to_fax,
                                   i.remit_to_email,
                                   i.terms_code,
                                   i.ship_via,
                                   i.fob,
                                   i.payment_method,
                                   i.price_level,
                                   i.exempt_1099,
                                   i.tax_exempt_no,
                                   i.tax_code,
                                   i.tax_payer_id,
                                   i.credit_limit,
                                   i.customer_code ,
                                   i.lead_time_in_days ,
                                   i.default_po_line_type ,
                                   i.internal_notes,
                                   i.po_notes ,
                                   i.shipping_notes,
                                    i.created_by,
									i.created_date,
									i.changed_by,
									i.changed_date,
									i.gl_account_number,
									i.approved_vendor,
									i.report_1099,
									i.dimensional_inv_required,
									i.bank_routing_no
                                   );	
		else
			
			UPDATE po_vendors 
			SET (
                      
                                    "name",
                                   short_name_for_reports,
                                   vendor_type,
                                   inactive,
                                   salutation,
                                   first_name,
                                   middle_name,
                                   last_name,
                                   street,
                                   city,
                                   state_code,
                                   postal_code,
                                   country,
                                   phone,
                                   fax,
                                   email,
                                   website,
                                   contact_method,
                                   different_remit_to_address,
                                   remit_to_name,
                              remit_to_street,
                              remit_to_city,
                              remit_to_state_code,
                              remit_to_postal_code,
                              remit_to_country,
                              remit_to_phone,
                                   remit_to_fax,
                                   remit_to_email,
                                   terms_code,
                                   ship_via,
                                   fob,
                                   payment_method,
                                   price_level,
                                   exempt_1099,
                                   tax_exempt_no,
                                   tax_code,
                                   tax_payer_id,
                                   credit_limit,
                                   customer_code ,
                                   lead_time_in_days ,
                                    default_po_line_type ,
                                   internal_notes,
                                   po_notes ,
                                    shipping_notes,
                                    created_by,
									created_date,
									changed_by,
									changed_date,
									gl_account_number,
									approved_vendor,
									report_1099,
									dimensional_inv_required,
									bank_routing_no)=
			(
                                  i."name",
                                   i.short_name_for_reports,
                                   i.vendor_type,
                                   i.inactive,
                                   i.salutation,
                                   i.first_name,
                                   i.middle_name,
                                   i.last_name,
                                   i.street,
                                   i.city,
                                   i.state_code,
                                   i.postal_code,
                                   i.country,
                                   i.phone,
                                   i.fax,
                                   i.email,
                                   i.website,
                                   i.contact_method,
                                   i.different_remit_to_address,
                                   i.remit_to_name,
                              i.remit_to_street,
                              i.remit_to_city,
                              i.remit_to_state_code,
                              i.remit_to_postal_code,
                              i.remit_to_country,
                              i.remit_to_phone,
                                   i.remit_to_fax,
                                   i.remit_to_email,
                                   i.terms_code,
                                   i.ship_via,
                                   i.fob,
                                   i.payment_method,
                                   i.price_level,
                                   i.exempt_1099,
                                   i.tax_exempt_no,
                                   i.tax_code,
                                   i.tax_payer_id,
                                   i.credit_limit,
                                   i.customer_code ,
                                   i.lead_time_in_days ,
                                   i.default_po_line_type ,
                                   i.internal_notes,
                                   i.po_notes ,
                                   i.shipping_notes,
                                    i.created_by,
									i.created_date,
									i.changed_by,
									i.changed_date,
									i.gl_account_number,
									i.approved_vendor,
									i.report_1099,
									i.dimensional_inv_required,
									i.bank_routing_no)
			WHERE vendor_no=i.vendor_no::text;
		
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
