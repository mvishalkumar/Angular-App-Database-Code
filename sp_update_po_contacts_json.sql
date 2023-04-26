CREATE OR REPLACE PROCEDURE angularapi.sp_update_po_contacts_json(p_po_contacts json)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
	v_cnt numeric;
	v_amt numeric(20,2);
	V_NAME VARCHAR(200);
	v_line_extend numeric(20,0);
	C_ORD CURSOR IS
		select a."vendorNo" as vendor_no,a."contactId" as contact_id,a."salutation" as salutation,a."inactive" as inactive,a."firstName" as first_name,a."middleName" as middle_name,a."lastName" as last_name,
	   a."department" as department,a."title" as title,a."mobile" as mobile,a."phone" as phone,a."fax" as fax,a."email" as email,a."website" as website,a."contactMethod" as contact_method,
	   a."mailingStreet" as mailing_street,a."mailingCity" as mailing_city,a."mailingStatecode" as mailing_state_code,a."mailingPostalcode" as mailing_postal_code,
       a."mailingCountry" as mailing_country,a."otherStreet" as other_street,a."otherCity" as other_city,a."otherStatecode" as other_state_code,a."otherPostalcode" as other_postal_code,
	   a."otherCountry" as other_country,a."otherPhone" as other_phone,a."otherFax" as other_fax,a."otherEmail" as other_email,a."internalNotes" as internal_notes,
       a."createdBy" as created_by, a."createdDate" as created_date,a."changedBy" as changed_by,a."changedDate" as changed_date,a."userId" as user_id,a."userPassword" as user_password,
	   a."serviceProvider" as service_provider,a."userGroup" as user_group,a."homeUrl" as home_url,a."contactName" as contact_name,a."ext" as ext,a."mobileNo" as mobile_no,a."pagerNo" as pager_no
			from (select * from json_to_recordset(p_po_contacts)  as x("vendorNo" text,"contactId" numeric,"salutation" text,"vendorType" text,"inactive" text,"firstName" text,"middleName" text,"lastName" text,
"department" text,"title" text,"mobile" text,"phone" text,"fax" text,"email" text,"website" text,
"contactMethod" text,"mailingStreet" text,"mailingCity" text,"mailingStatecode" text,"mailingPostalcode" text,"mailingCountry" text,"otherStreet" text,"otherCity" text,"otherStatecode" text,"otherPostalcode" text,
"otherCountry" text,"otherPhone" text,"otherFax" text,"otherEmail" text,"internalNotes" text,
"createdBy" text,"createdDate" date,"changedBy" text,"changedDate" date,"userId" text,"userPassword" text,"serviceProvider" text,"userGroup" text,"homeUrl" text,"contactName" text,
"ext" text,"mobileNo" text,"pagerNo" text)) a;
BEGIN
	for i in c_ord LOOP
		select count(1) INTO V_CNT
		FROM po_contacts
		WHERE contact_id=I.contact_id::numeric and vendor_no=I.vendor_no::text;
		

		IF V_CNT=0 THEN
			 INSERT   INTO  po_contacts(
                                vendor_no,
								contact_id,
								salutation,
								first_name,
								middle_name,
								last_name,
								inactive,
								department,
								title,
								phone,
								mobile,
								fax,
								email,
								contact_method,
								mailing_street,
								mailing_city,
								mailing_state_code,
								mailing_postal_code,
								mailing_country,
								other_street,
								other_city,
								other_state_code,
								other_postal_code,
								other_country,
								other_phone,
								other_fax,
								other_email,
								internal_notes,
								created_by,
								created_date,
								changed_by,
								changed_date,
								user_id,
								user_password,
								service_provider,
								user_group,
								home_url,
								contact_name,
								ext,
								mobile_no,
								pager_no
                                   )
                            VALUES(
                                   i.vendor_no,
									i.contact_id,
									i.salutation,
									i.first_name,
									i.middle_name,
									i.last_name,
									i.inactive,
									i.department,
									i.title,
									i.phone,
									i.mobile,
									i.fax,
									i.email,
									i.contact_method,
									i.mailing_street,
									i.mailing_city,
									i.mailing_state_code,
									i.mailing_postal_code,
									i.mailing_country,
									i.other_street,
									i.other_city,
									i.other_state_code,
									i.other_postal_code,
									i.other_country,
									i.other_phone,
									i.other_fax,
									i.other_email,
									i.internal_notes,
									i.created_by,
									i.created_date,
									i.changed_by,
									i.changed_date,
									i.user_id,
									i.user_password,
									i.service_provider,
									i.user_group,
									i.home_url,
									i.contact_name,
									i.ext,
									i.mobile_no,
									i.pager_no
                                   );	
		else
			
			UPDATE po_contacts 
			SET (
                       
								salutation,
								first_name,
								middle_name,
								last_name,
								inactive,
								department,
								title,
								phone,
								mobile,
								fax,
								email,
								contact_method,
								mailing_street,
								mailing_city,
								mailing_state_code,
								mailing_postal_code,
								mailing_country,
								other_street,
								other_city,
								other_state_code,
								other_postal_code,
								other_country,
								other_phone,
								other_fax,
								other_email,
								internal_notes,
								created_by,
								created_date,
								changed_by,
								changed_date,
								user_id,
								user_password,
								service_provider,
								user_group,
								home_url,
								contact_name,
								ext,
								mobile_no,
								pager_no)=
			(
                                  
									i.salutation,
									i.first_name,
									i.middle_name,
									i.last_name,
									i.inactive,
									i.department,
									i.title,
									i.phone,
									i.mobile,
									i.fax,
									i.email,
									i.contact_method,
									i.mailing_street,
									i.mailing_city,
									i.mailing_state_code,
									i.mailing_postal_code,
									i.mailing_country,
									i.other_street,
									i.other_city,
									i.other_state_code,
									i.other_postal_code,
									i.other_country,
									i.other_phone,
									i.other_fax,
									i.other_email,
									i.internal_notes,
									i.created_by,
									i.created_date,
									i.changed_by,
									i.changed_date,
									i.user_id,
									i.user_password,
									i.service_provider,
									i.user_group,
									i.home_url,
									i.contact_name,
									i.ext,
									i.mobile_no,
									i.pager_no)
			WHERE contact_id=I.contact_id::numeric and vendor_no=I.vendor_no::text;
		
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
