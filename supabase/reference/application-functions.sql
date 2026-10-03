-- AMFCC application function reference captured 2026-10-04
-- Reference only. This omits table definitions, trigger bindings and migration order.
-- Never replay this file as a restore. Make changes through a reviewed migration.

CREATE OR REPLACE FUNCTION it_admin_private.bootstrap(p_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $function$
begin
 perform it_admin_private.context(p_token);
 return jsonb_build_object('status','success','entities',it_admin_private.catalog());
end $function$
;

CREATE OR REPLACE FUNCTION it_admin_private.catalog()
 RETURNS jsonb
 LANGUAGE sql
 IMMUTABLE
 SET search_path TO 'pg_catalog'
AS $function$
 select '[{"key":"students","table":"students","title":"Students","group":"People","editable":["registration_number","full_name","gender","is_active"],"help":"Add students, correct names and gender, archive leavers, restore students or remove unused records.","archive_field":"is_active","primary_keys":["id"],"fields":[{"name":"registration_number","label":"Registration number","type":"bigint","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"full_name","label":"Full name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"is_active","label":"Is active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"gender","label":"Gender","type":"text","required":false,"default":null,"options":["Male","Female"],"reference":null,"primary":false}],"display_fields":["registration_number","full_name","gender","is_active"]},{"key":"ops_staff_directory","table":"ops_staff_directory","title":"Staff reporting directory","group":"People","editable":["department_id","full_name","title","staff_number","gender","active"],"help":"These staff choices are used in reporting. Staff are separate from student allocations.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"full_name","label":"Full name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"title","label":"Title","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"staff_number","label":"Staff number","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"gender","label":"Gender","type":"text","required":false,"default":null,"options":["F","M"],"reference":null,"primary":false}],"display_fields":["department_id","full_name","title","staff_number","gender"]},{"key":"sponsors","table":"sponsors","title":"Sponsors","group":"People","editable":["name","phone","email","relationship_to_student","address","notes"],"help":"Maintain sponsor contact details. Link sponsors to students separately.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"name","label":"Name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"phone","label":"Phone","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"email","label":"Email","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"relationship_to_student","label":"Relationship to student","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"address","label":"Address","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["name","phone","email","relationship_to_student","address"]},{"key":"student_term_sponsors","table":"student_term_sponsors","title":"Student sponsor links","group":"People","editable":["student_id","term_id","sponsor_id","sponsor_name_snapshot","sponsor_phone_snapshot"],"help":"Choose the exact student, term and sponsor.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"term_id","label":"Term","type":"bigint","required":true,"default":null,"options":[],"reference":{"table":"academic_terms","column":"id"},"primary":false},{"name":"sponsor_id","label":"Sponsor","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"sponsors","column":"id"},"primary":false},{"name":"sponsor_name_snapshot","label":"Sponsor name snapshot","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"sponsor_phone_snapshot","label":"Sponsor phone snapshot","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","term_id","sponsor_id","sponsor_name_snapshot","sponsor_phone_snapshot"]},{"key":"student_class_year_overrides","table":"student_class_year_overrides","title":"Student class corrections","group":"People","editable":["registration_number","academic_year","class_year"],"help":"Correct a student class for a specific academic year.","archive_field":null,"primary_keys":["registration_number","academic_year"],"fields":[{"name":"registration_number","label":"Registration number","type":"bigint","required":true,"default":null,"options":[],"reference":null,"primary":true},{"name":"academic_year","label":"Academic year","type":"integer","required":true,"default":null,"options":[],"reference":null,"primary":true},{"name":"class_year","label":"Class year","type":"integer","required":true,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["registration_number","academic_year","class_year"]},{"key":"student_support_statuses","table":"student_support_statuses","title":"Student support and bed rest","group":"People","editable":["student_id","status_type","status_label","started_at","expected_end_at","ended_at","is_active","notes"],"help":"Sensitive support records. Clinical notes remain restricted to authorised staff.","archive_field":"is_active","primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"status_type","label":"Status type","type":"text","required":true,"default":null,"options":["maternity","bed_rest","other"],"reference":null,"primary":false},{"name":"status_label","label":"Status label","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"started_at","label":"Started at","type":"timestamp with time zone","required":true,"default":"__now__","options":[],"reference":null,"primary":false},{"name":"expected_end_at","label":"Expected end at","type":"timestamp with time zone","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"ended_at","label":"Ended at","type":"timestamp with time zone","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"is_active","label":"Is active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","status_type","status_label","started_at","expected_end_at"]},{"key":"accommodation_allocations","table":"accommodation_allocations","title":"Accommodation allocations","group":"People","editable":["student_id","residence","room","bed","term_label","allocation_status","is_active","notes"],"help":"Enter a hostel or building, room and bed. Use the normal accommodation screen for daily work.","archive_field":"is_active","primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"residence","label":"Residence","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"room","label":"Room","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"bed","label":"Bed","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"term_label","label":"Term label","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"allocation_status","label":"Allocation status","type":"text","required":true,"default":"allocated","options":["waiting","allocated","checked_in","checked_out","cancelled"],"reference":null,"primary":false},{"name":"is_active","label":"Is active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","residence","room","bed","term_label"]},{"key":"student_immigration_profiles","table":"student_immigration_profiles","title":"Immigration profiles","group":"People","editable":["student_id","residency_status","country","nationality","sponsor_id","passport_number","passport_issue_date","passport_expiry_date","permit_type","permit_number","permit_issue_date","permit_expiry_date","next_action","next_action_date","notes"],"help":"Correct immigration details here. Upload files through the Immigration document tool.","archive_field":null,"primary_keys":["student_id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":true},{"name":"residency_status","label":"Residency status","type":"text","required":true,"default":"local","options":["local","international"],"reference":null,"primary":false},{"name":"country","label":"Country","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"nationality","label":"Nationality","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"sponsor_id","label":"Sponsor","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"sponsors","column":"id"},"primary":false},{"name":"passport_number","label":"Passport number","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"passport_issue_date","label":"Passport issue date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"passport_expiry_date","label":"Passport expiry date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"permit_type","label":"Permit type","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"permit_number","label":"Permit number","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"permit_issue_date","label":"Permit issue date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"permit_expiry_date","label":"Permit expiry date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"next_action","label":"Next action","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"next_action_date","label":"Next action date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","residency_status","country","nationality","sponsor_id"]},{"key":"ops_student_leadership_roles","table":"ops_student_leadership_roles","title":"Student leadership appointments","group":"Duties","editable":["student_id","leadership_role","display_order","active"],"help":"Appoint or retire leadership roles. Choose an exact active student.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"leadership_role","label":"Leadership role","type":"text","required":true,"default":null,"options":["senior_prefect","chairman","chairman_vice","chairlady","chairlady_vice","campus_manager"],"reference":null,"primary":false},{"name":"display_order","label":"Display order","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","leadership_role","display_order","active"]},{"key":"ops_weekly_duty_roster","table":"ops_weekly_duty_roster","title":"Prefect duty weeks","group":"Duties","editable":["week_start","prefect_student_id","senior_prefect_student_id","notes"],"help":"Create or correct the Prefect and Senior Prefect on Duty for a Monday beginning week.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"week_start","label":"Week start","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"prefect_student_id","label":"Prefect student","type":"text","required":false,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"senior_prefect_student_id","label":"Senior prefect student","type":"text","required":false,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false}],"display_fields":["week_start","prefect_student_id","senior_prefect_student_id","notes"]},{"key":"ops_service_duty_weeks","table":"ops_service_duty_weeks","title":"Bell kitchen and toilet duty weeks","group":"Duties","editable":["week_start","bell_ringer_student_id","bell_ringer_2_student_id","kitchen_department_id","toilet_department_id"],"help":"Create the duty week first, then add its kitchen and toilet duty members. Removing a week also removes its own duty members.","archive_field":null,"primary_keys":["week_start"],"fields":[{"name":"week_start","label":"Week start","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":true},{"name":"bell_ringer_student_id","label":"Bell ringer student","type":"text","required":false,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"kitchen_department_id","label":"Kitchen department","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"toilet_department_id","label":"Toilet department","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"bell_ringer_2_student_id","label":"Bell ringer 2 student","type":"text","required":false,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false}],"display_fields":["week_start","bell_ringer_student_id","bell_ringer_2_student_id","kitchen_department_id","toilet_department_id"]},{"key":"ops_service_duty_members","table":"ops_service_duty_members","title":"Kitchen and toilet duty members","group":"Duties","editable":["week_start","duty_type","student_id","sort_order"],"help":"Add up to four students per duty, with no more than two men and two women. Remove an individual assignment here.","archive_field":null,"primary_keys":["week_start","duty_type","student_id"],"fields":[{"name":"week_start","label":"Week start","type":"date","required":true,"default":null,"options":[],"reference":{"table":"ops_service_duty_weeks","column":"week_start"},"primary":true},{"name":"duty_type","label":"Duty type","type":"text","required":true,"default":null,"options":["kitchen","toilet"],"reference":null,"primary":true},{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":true},{"name":"sort_order","label":"Sort order","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false}],"display_fields":["week_start","duty_type","student_id","sort_order"]},{"key":"ops_gate_duty_assignments","table":"ops_gate_duty_assignments","title":"Night gate duty assignments","group":"Duties","editable":["duty_date","slot_code","student_id"],"help":"Create or correct one student per night gate slot. Your IT identity and name are recorded automatically.","archive_field":null,"primary_keys":["duty_date","slot_code"],"fields":[{"name":"duty_date","label":"Duty date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":true},{"name":"slot_code","label":"Slot code","type":"text","required":true,"default":null,"options":["22_00","00_02","02_04"],"reference":null,"primary":true},{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false}],"display_fields":["duty_date","slot_code","student_id"]},{"key":"ops_department_memberships","table":"ops_department_memberships","title":"Department student members","group":"Duties","editable":["department_id","student_id","member_role","starts_on","ends_on","active"],"help":"Assign students and HODs to departments. Use end dates or archive to retain history.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"member_role","label":"Member role","type":"text","required":true,"default":"member","options":["member","hod","student_leader","assistant","hod_delegate"],"reference":null,"primary":false},{"name":"starts_on","label":"Starts on","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"ends_on","label":"Ends on","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false}],"display_fields":["department_id","student_id","member_role","starts_on","ends_on"]},{"key":"ops_departments","table":"ops_departments","title":"Department directory","group":"Configuration","editable":["slug","name","short_name","parent_department_id","department_kind","workspace_enabled","restricted_data","active","sort_order","jira_operations_value","jira_operations_option_id","jira_project_value","jira_project_option_id"],"help":"Maintain names and reporting sections. Set a new department PIN separately in PIN access.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"slug","label":"Slug","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"name","label":"Name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"short_name","label":"Short name","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"parent_department_id","label":"Parent department","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"department_kind","label":"Department kind","type":"text","required":true,"default":"operations","options":["operations","project","both","administration"],"reference":null,"primary":false},{"name":"workspace_enabled","label":"Workspace enabled","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"restricted_data","label":"Restricted data","type":"boolean","required":true,"default":false,"options":[],"reference":null,"primary":false},{"name":"jira_operations_value","label":"Jira operations value","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"jira_operations_option_id","label":"Jira operations option","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"jira_project_value","label":"Jira project value","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"jira_project_option_id","label":"Jira project option","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"sort_order","label":"Sort order","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false}],"display_fields":["slug","name","short_name","parent_department_id","department_kind"]},{"key":"ops_time_slots","table":"ops_time_slots","title":"Work session timetable","group":"Configuration","editable":["code","name","start_time","end_time","sort_order","active"],"help":"Enter session times. The end time must be later than the start time.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"code","label":"Code","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"name","label":"Name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"start_time","label":"Start time","type":"time without time zone","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"end_time","label":"End time","type":"time without time zone","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"sort_order","label":"Sort order","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false}],"display_fields":["code","name","start_time","end_time","sort_order"]},{"key":"ops_units","table":"ops_units","title":"Department reporting units","group":"Configuration","editable":["department_id","unit_type","code","name","metadata","active","sort_order"],"help":"Enter units used by activity and reporting records.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"unit_type","label":"Unit type","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"code","label":"Code","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"name","label":"Name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"metadata","label":"Metadata","type":"jsonb","required":true,"default":{},"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"sort_order","label":"Sort order","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false}],"display_fields":["department_id","unit_type","code","name","metadata"]},{"key":"ops_metric_definitions","table":"ops_metric_definitions","title":"Reporting figure definitions","group":"Configuration","editable":["department_id","code","label","unit","value_type","aggregation","direction","amber_threshold","red_threshold","configuration","sort_order","active"],"help":"Define reporting figures and how period reports aggregate them.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"code","label":"Code","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"label","label":"Label","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"unit","label":"Unit","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"value_type","label":"Value type","type":"text","required":true,"default":"number","options":["number","text","boolean"],"reference":null,"primary":false},{"name":"aggregation","label":"Aggregation","type":"text","required":true,"default":"sum","options":["sum","average","latest","minimum","maximum","manual"],"reference":null,"primary":false},{"name":"direction","label":"Direction","type":"text","required":true,"default":"informational","options":["higher_is_better","lower_is_better","target_range","informational"],"reference":null,"primary":false},{"name":"amber_threshold","label":"Amber threshold","type":"numeric","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"red_threshold","label":"Red threshold","type":"numeric","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"configuration","label":"Configuration","type":"jsonb","required":true,"default":{},"options":[],"reference":null,"primary":false},{"name":"sort_order","label":"Sort order","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false}],"display_fields":["department_id","code","label","unit","value_type"]},{"key":"ops_department_group_counts","table":"ops_department_group_counts","title":"Department cohort totals","group":"Configuration","editable":["department_id","group_code","member_count"],"help":"Correct standing cohort totals only after reviewing membership.","archive_field":null,"primary_keys":["department_id","group_code"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":true},{"name":"group_code","label":"Group code","type":"text","required":true,"default":null,"options":["year1_men","year1_ladies","year2_men","year2_ladies"],"reference":null,"primary":true},{"name":"member_count","label":"Member count","type":"integer","required":true,"default":0,"options":[],"reference":null,"primary":false}],"display_fields":["department_id","group_code","member_count"]},{"key":"ops_department_schedule_rules","table":"ops_department_schedule_rules","title":"Standing work schedules","group":"Configuration","editable":["department_id","active","days_of_week","slot_codes"],"help":"Choose the days and sessions when a department is always on.","archive_field":"active","primary_keys":["department_id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":true},{"name":"active","label":"Active","type":"boolean","required":true,"default":false,"options":[],"reference":null,"primary":false},{"name":"days_of_week","label":"Days of week","type":"ARRAY","required":true,"default":null,"options":[],"reference":null,"primary":false,"array_options":[{"value":1,"label":"Monday"},{"value":2,"label":"Tuesday"},{"value":3,"label":"Wednesday"},{"value":4,"label":"Thursday"},{"value":5,"label":"Friday"},{"value":6,"label":"Saturday"},{"value":7,"label":"Sunday"}]},{"name":"slot_codes","label":"Slot codes","type":"ARRAY","required":true,"default":"{}","options":[],"reference":null,"primary":false,"array_reference":"ops_time_slots"}],"display_fields":["department_id","active","days_of_week","slot_codes"]},{"key":"ops_department_plans","table":"ops_department_plans","title":"Department plans","group":"Operations","editable":["department_id","starts_on","ends_on","plan_type","title","details","status"],"help":"Create and correct daily or weekly plans.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"starts_on","label":"Starts on","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"ends_on","label":"Ends on","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"plan_type","label":"Plan type","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"title","label":"Title","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"details","label":"Details","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"planned","options":["planned","in_progress","completed","cancelled"],"reference":null,"primary":false}],"display_fields":["department_id","starts_on","ends_on","plan_type","title"]},{"key":"ops_stock_items","table":"ops_stock_items","title":"Department stock catalogue","group":"Operations","editable":["department_id","item_name","category","unit","reorder_level","active"],"help":"Configure stock names and minimum levels. IT assets have their own register.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"item_name","label":"Item name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"category","label":"Category","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"unit","label":"Unit","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"reorder_level","label":"Reorder level","type":"numeric","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false}],"display_fields":["department_id","item_name","category","unit","reorder_level"]},{"key":"ops_stock_movements","table":"ops_stock_movements","title":"Department stock movements","group":"Operations","editable":["stock_item_id","department_id","movement_date","movement_type","quantity_delta","notes"],"help":"Record receipts as positive amounts and usage as negative amounts.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"stock_item_id","label":"Stock item","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_stock_items","column":"id"},"primary":false},{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"movement_date","label":"Movement date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"movement_type","label":"Movement type","type":"text","required":true,"default":null,"options":["received","used","wasted","adjustment"],"reference":null,"primary":false},{"name":"quantity_delta","label":"Quantity delta","type":"numeric","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["stock_item_id","department_id","movement_date","movement_type","quantity_delta"]},{"key":"ops_operational_logs","table":"ops_operational_logs","title":"Department activity logs","group":"Operations","editable":["department_id","record_date","log_type","title","quantity","unit","notes"],"help":"Enter operational quantities and notes.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"record_date","label":"Record date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"log_type","label":"Log type","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"title","label":"Title","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"quantity","label":"Quantity","type":"numeric","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"unit","label":"Unit","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["department_id","record_date","log_type","title","quantity"]},{"key":"ops_activity_records","table":"ops_activity_records","title":"Reporting activity records","group":"Operations","editable":["department_id","record_date","entry_type","unit_id","task_id","session_id","report_id","staff_name","payload"],"help":"Enter activity data through named form fields.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"record_date","label":"Record date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"entry_type","label":"Entry type","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"unit_id","label":"Unit","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_units","column":"id"},"primary":false},{"name":"task_id","label":"Task","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_tasks","column":"id"},"primary":false},{"name":"session_id","label":"Session","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_work_sessions","column":"id"},"primary":false},{"name":"report_id","label":"Report","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_reports","column":"id"},"primary":false},{"name":"staff_name","label":"Staff name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"payload","label":"Payload","type":"jsonb","required":true,"default":{},"options":[],"reference":null,"primary":false}],"display_fields":["department_id","record_date","entry_type","unit_id","task_id"]},{"key":"ops_tasks","table":"ops_tasks","title":"Work tasks","group":"Operations","editable":["department_id","parent_task_id","title","description","task_type","cadence","priority","status","due_date","requested_people","external_people_allowed","owner_name","metadata"],"help":"Use work submission for normal scheduling. IT can correct or cancel records here.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"parent_task_id","label":"Parent task","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_tasks","column":"id"},"primary":false},{"name":"title","label":"Title","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"description","label":"Description","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"task_type","label":"Task type","type":"text","required":true,"default":"ad_hoc","options":["regular","ad_hoc","project","maintenance","building","incident_follow_up","emergency"],"reference":null,"primary":false},{"name":"cadence","label":"Cadence","type":"text","required":true,"default":"once","options":["once","daily","weekly","monthly","quarterly"],"reference":null,"primary":false},{"name":"priority","label":"Priority","type":"text","required":true,"default":"medium","options":["low","medium","high","critical"],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"backlog","options":["backlog","ready","requested","planned","in_progress","blocked","done","cancelled"],"reference":null,"primary":false},{"name":"due_date","label":"Due date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"requested_people","label":"Requested people","type":"integer","required":true,"default":0,"options":[],"reference":null,"primary":false},{"name":"external_people_allowed","label":"External people allowed","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"owner_name","label":"Owner name","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"metadata","label":"Metadata","type":"jsonb","required":true,"default":{},"options":[],"reference":null,"primary":false}],"display_fields":["department_id","parent_task_id","title","description","task_type"]},{"key":"ops_session_requests","table":"ops_session_requests","title":"Work requests","group":"Operations","editable":["department_id","work_date","slot_id","requested_headcount","allocated_headcount","request_notes","decision_notes","requested_by_name","status","request_kind"],"help":"Correct work requests after reviewing their linked sessions.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"work_date","label":"Work date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"slot_id","label":"Slot","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_time_slots","column":"id"},"primary":false},{"name":"requested_headcount","label":"Requested headcount","type":"integer","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"allocated_headcount","label":"Allocated headcount","type":"integer","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"request_notes","label":"Request notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"decision_notes","label":"Decision notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"requested_by_name","label":"Requested by name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"pending","options":["pending","approved","partially_approved","declined","cancelled"],"reference":null,"primary":false},{"name":"request_kind","label":"Request kind","type":"text","required":true,"default":"planned","options":["planned","unexpected"],"reference":null,"primary":false}],"display_fields":["department_id","work_date","slot_id","requested_headcount","allocated_headcount"]},{"key":"ops_session_request_tasks","table":"ops_session_request_tasks","title":"Tasks attached to requests","group":"Operations","editable":["request_id","task_id","people_needed"],"help":"Attach an existing task to an existing request.","archive_field":null,"primary_keys":["request_id","task_id"],"fields":[{"name":"request_id","label":"Request","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_session_requests","column":"id"},"primary":true},{"name":"task_id","label":"Task","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_tasks","column":"id"},"primary":true},{"name":"people_needed","label":"People needed","type":"integer","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["request_id","task_id","people_needed"]},{"key":"ops_work_sessions","table":"ops_work_sessions","title":"Published work sessions","group":"Operations","editable":["request_id","department_id","work_date","slot_id","allocated_headcount","status","leadership_notes","department_notes","allocation_model"],"help":"Correct existing published sessions. Conference Mode still enforces server rules.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"request_id","label":"Request","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_session_requests","column":"id"},"primary":false},{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"work_date","label":"Work date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"slot_id","label":"Slot","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_time_slots","column":"id"},"primary":false},{"name":"allocated_headcount","label":"Allocated headcount","type":"integer","required":true,"default":0,"options":[],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"draft","options":["draft","published","in_progress","completed","cancelled"],"reference":null,"primary":false},{"name":"leadership_notes","label":"Leadership notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"department_notes","label":"Department notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"allocation_model","label":"Allocation model","type":"text","required":true,"default":"legacy","options":["legacy","members_plus_groups"],"reference":null,"primary":false}],"display_fields":["request_id","department_id","work_date","slot_id","allocated_headcount"]},{"key":"ops_session_tasks","table":"ops_session_tasks","title":"Tasks attached to sessions","group":"Operations","editable":["session_id","task_id","planned_people","sequence"],"help":"Maintain task links and order within sessions.","archive_field":null,"primary_keys":["session_id","task_id"],"fields":[{"name":"session_id","label":"Session","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_work_sessions","column":"id"},"primary":true},{"name":"task_id","label":"Task","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_tasks","column":"id"},"primary":true},{"name":"planned_people","label":"Planned people","type":"integer","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"sequence","label":"Sequence","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false}],"display_fields":["session_id","task_id","planned_people","sequence"]},{"key":"ops_session_assignments","table":"ops_session_assignments","title":"Named session assignments","group":"Operations","editable":["session_id","student_id","home_department_id","assignment_source","attendance","notes"],"help":"Correct named assignments. Normal leadership allocation uses cohort totals.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"session_id","label":"Session","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_work_sessions","column":"id"},"primary":false},{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"home_department_id","label":"Home department","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"assignment_source","label":"Assignment source","type":"text","required":true,"default":"manual","options":["home_department","external","manual"],"reference":null,"primary":false},{"name":"attendance","label":"Attendance","type":"text","required":true,"default":"planned","options":["planned","present","absent","excused"],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["session_id","student_id","home_department_id","assignment_source","attendance"]},{"key":"ops_session_group_allocations","table":"ops_session_group_allocations","title":"Session cohort allocations","group":"Operations","editable":["session_id","group_code","headcount"],"help":"Correct cohort totals assigned to a published session.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"session_id","label":"Session","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_work_sessions","column":"id"},"primary":false},{"name":"group_code","label":"Group code","type":"text","required":true,"default":null,"options":["year1_men","year1_ladies","year2_men","year2_ladies"],"reference":null,"primary":false},{"name":"headcount","label":"Headcount","type":"integer","required":true,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["session_id","group_code","headcount"]},{"key":"ops_session_department_members","table":"ops_session_department_members","title":"Session department members","group":"Operations","editable":["session_id","student_id","member_role"],"help":"Maintain the department members attached to a published session.","archive_field":null,"primary_keys":["session_id","student_id"],"fields":[{"name":"session_id","label":"Session","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_work_sessions","column":"id"},"primary":true},{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":true},{"name":"member_role","label":"Member role","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["session_id","student_id","member_role"]},{"key":"ops_reports","table":"ops_reports","title":"Department reports","group":"Operations","editable":["department_id","report_type","period_start","period_end","report_date","prepared_by_name","staff_on_duty","summary","work_completed","work_open","challenges","action_required","stock_equipment","risks","support_required","next_period_plan","payload"],"help":"Correct report content. Report approval transitions remain in the normal reporting screen.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"report_type","label":"Report type","type":"text","required":true,"default":null,"options":["daily","weekly","monthly"],"reference":null,"primary":false},{"name":"period_start","label":"Period start","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"period_end","label":"Period end","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"report_date","label":"Report date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"prepared_by_name","label":"Prepared by name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"staff_on_duty","label":"Staff on duty","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"summary","label":"Summary","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"work_completed","label":"Work completed","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"work_open","label":"Work open","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"challenges","label":"Challenges","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"action_required","label":"Action required","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"stock_equipment","label":"Stock equipment","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"risks","label":"Risks","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"support_required","label":"Support required","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"next_period_plan","label":"Next period plan","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"payload","label":"Payload","type":"jsonb","required":true,"default":{},"options":[],"reference":null,"primary":false}],"display_fields":["department_id","report_type","period_start","period_end","report_date"]},{"key":"ops_report_metrics","table":"ops_report_metrics","title":"Report figures","group":"Operations","editable":["report_id","metric_definition_id","metric_name","unit","target_value","actual_value","status","commentary","source","sort_order"],"help":"Enter targets, actual figures and explanatory notes.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"report_id","label":"Report","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_reports","column":"id"},"primary":false},{"name":"metric_definition_id","label":"Metric definition","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_metric_definitions","column":"id"},"primary":false},{"name":"metric_name","label":"Metric name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"unit","label":"Unit","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"target_value","label":"Target value","type":"numeric","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"actual_value","label":"Actual value","type":"numeric","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"not_set","options":["green","amber","red","not_set"],"reference":null,"primary":false},{"name":"commentary","label":"Commentary","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"source","label":"Source","type":"text","required":true,"default":"manual","options":["manual","activity","calculated"],"reference":null,"primary":false},{"name":"sort_order","label":"Sort order","type":"integer","required":true,"default":100,"options":[],"reference":null,"primary":false}],"display_fields":["report_id","metric_definition_id","metric_name","unit","target_value"]},{"key":"ops_management_actions","table":"ops_management_actions","title":"Management follow up actions","group":"Operations","editable":["department_id","report_id","task_id","summary","description","priority","status","owner_name","due_date"],"help":"Maintain follow up work and its owner.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"department_id","label":"Department","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"report_id","label":"Report","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_reports","column":"id"},"primary":false},{"name":"task_id","label":"Task","type":"uuid","required":false,"default":null,"options":[],"reference":{"table":"ops_tasks","column":"id"},"primary":false},{"name":"summary","label":"Summary","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"description","label":"Description","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"priority","label":"Priority","type":"text","required":true,"default":"medium","options":["low","medium","high","critical"],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"open","options":["open","in_progress","blocked","done","cancelled"],"reference":null,"primary":false},{"name":"owner_name","label":"Owner name","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"due_date","label":"Due date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["department_id","report_id","task_id","summary","description"]},{"key":"ops_transfers","table":"ops_transfers","title":"Transfers between departments","group":"Operations","editable":["transfer_date","from_department_id","to_department_id","reference","status","sent_by_name","received_by_name","notes"],"help":"Correct the transfer header after checking the receiving department.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"transfer_date","label":"Transfer date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"from_department_id","label":"From department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"to_department_id","label":"To department","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_departments","column":"id"},"primary":false},{"name":"reference","label":"Reference","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"sent","options":["draft","sent","received","disputed","cancelled"],"reference":null,"primary":false},{"name":"sent_by_name","label":"Sent by name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"received_by_name","label":"Received by name","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["transfer_date","from_department_id","to_department_id","reference","status"]},{"key":"ops_transfer_items","table":"ops_transfer_items","title":"Transfer items","group":"Operations","editable":["transfer_id","item_name","quantity","unit","notes"],"help":"Enter the items and quantities attached to a transfer.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"transfer_id","label":"Transfer","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"ops_transfers","column":"id"},"primary":false},{"name":"item_name","label":"Item name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"quantity","label":"Quantity","type":"numeric","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"unit","label":"Unit","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["transfer_id","item_name","quantity","unit","notes"]},{"key":"student_term_fee_status","table":"student_term_fee_status","title":"Student fee records","group":"Student services","editable":["student_id","term_id","fees_paid","notes","arrears_previous_terms","amount_paid_current_term","outstanding_balance","payment_plan","notice_text","notice_source_date","notice_source_row","notice_export_name"],"help":"Enter fee and notice information manually. This form never sends a notice.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"term_id","label":"Term","type":"bigint","required":true,"default":null,"options":[],"reference":{"table":"academic_terms","column":"id"},"primary":false},{"name":"fees_paid","label":"Fees paid","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"arrears_previous_terms","label":"Arrears previous terms","type":"numeric","required":true,"default":0,"options":[],"reference":null,"primary":false},{"name":"amount_paid_current_term","label":"Amount paid current term","type":"numeric","required":true,"default":0,"options":[],"reference":null,"primary":false},{"name":"outstanding_balance","label":"Outstanding balance","type":"numeric","required":true,"default":0,"options":[],"reference":null,"primary":false},{"name":"payment_plan","label":"Payment plan","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notice_text","label":"Notice text","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notice_source_date","label":"Notice source date","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notice_source_row","label":"Notice source row","type":"integer","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notice_export_name","label":"Notice export name","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","term_id","fees_paid","notes","arrears_previous_terms"]},{"key":"academic_terms","table":"academic_terms","title":"Academic terms","group":"Student services","editable":["academic_year","term_number","term_name","fees_due_date","registration_form_schema"],"help":"Maintain term names fee deadlines and form field definitions. Open or close enrolment using Term enrolment.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"academic_year","label":"Academic year","type":"integer","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"term_number","label":"Term number","type":"integer","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"term_name","label":"Term name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"fees_due_date","label":"Fees due date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"registration_form_schema","label":"Registration form schema","type":"jsonb","required":true,"default":{"fees":[],"admin":[],"final":[],"student":[],"configured":false},"options":[],"reference":null,"primary":false}],"display_fields":["academic_year","term_number","term_name","fees_due_date","registration_form_schema"]},{"key":"check_ins","table":"check_ins","title":"Meal collection records","group":"Student services","editable":["student_id","service_date","meal_session","check_in_source","child_portions"],"help":"Correct an individual collection record. Conference rules remain enforced.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"meal_session","label":"Meal session","type":"text","required":true,"default":null,"options":["Breakfast","Lunch","Break-fast 4pm","Supper"],"reference":null,"primary":false},{"name":"service_date","label":"Service date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"check_in_source","label":"Check in source","type":"text","required":true,"default":"staff","options":["staff","student_self","student_collection","operations_scanner","operations_camera","operations_manual"],"reference":null,"primary":false},{"name":"child_portions","label":"Child portions","type":"integer","required":true,"default":0,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","service_date","meal_session","check_in_source","child_portions"]},{"key":"meal_plans","table":"meal_plans","title":"Advance meal check in records","group":"Student services","editable":["student_id","service_date","meal_session","plan_source"],"help":"Correct preparation check in records separately from meal collection.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"service_date","label":"Service date","type":"date","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"meal_session","label":"Meal session","type":"text","required":true,"default":null,"options":["Breakfast","Lunch","Break-fast 4pm"],"reference":null,"primary":false},{"name":"plan_source","label":"Plan source","type":"text","required":true,"default":"student_self","options":["student_self","staff"],"reference":null,"primary":false}],"display_fields":["student_id","service_date","meal_session","plan_source"]},{"key":"campus_movements","table":"campus_movements","title":"Campus movements","group":"Student services","editable":["student_id","direction","gate_device_id","scanned_at","movement_source"],"help":"Correct campus movement records. Choose the actual direction and time.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"direction","label":"Direction","type":"text","required":true,"default":null,"options":["IN","OUT"],"reference":null,"primary":false},{"name":"scanned_at","label":"Scanned at","type":"timestamp with time zone","required":true,"default":"__now__","options":[],"reference":null,"primary":false},{"name":"gate_device_id","label":"Gate device","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"gate_devices","column":"id"},"primary":false},{"name":"movement_source","label":"Movement source","type":"text","required":true,"default":"scanner","options":["scanner","camera","manual","administrative_update"],"reference":null,"primary":false}],"display_fields":["student_id","direction","gate_device_id","scanned_at","movement_source"]},{"key":"gate_passes","table":"gate_passes","title":"Gate pass records","group":"Student services","editable":["student_id","destination","reason","departure_at","expected_return_at","contact_details","paper_pass_checked"],"help":"Correct pass details. Use the approval screens for decisions and returns.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"destination","label":"Destination","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"reason","label":"Reason","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"departure_at","label":"Departure at","type":"timestamp with time zone","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"expected_return_at","label":"Expected return at","type":"timestamp with time zone","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"contact_details","label":"Contact details","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"paper_pass_checked","label":"Paper pass checked","type":"boolean","required":true,"default":false,"options":[],"reference":null,"primary":false}],"display_fields":["student_id","destination","reason","departure_at","expected_return_at"]},{"key":"gate_pass_members","table":"gate_pass_members","title":"Group gate pass members","group":"Student services","editable":["pass_id","student_id","is_primary"],"help":"Maintain group membership after checking the whole pass.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"pass_id","label":"Pass","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"gate_passes","column":"id"},"primary":false},{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"is_primary","label":"Is primary","type":"boolean","required":true,"default":false,"options":[],"reference":null,"primary":false}],"display_fields":["pass_id","student_id","is_primary"]},{"key":"gate_devices","table":"gate_devices","title":"Gate terminal devices","group":"Student services","editable":["device_name","location","is_active"],"help":"Create an authorised gate device here and use its pairing token on the terminal. Existing device tokens can be replaced through the protected form.","archive_field":"is_active","primary_keys":["id"],"fields":[{"name":"device_name","label":"Device name","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"location","label":"Location","type":"text","required":true,"default":"Main Gate","options":[],"reference":null,"primary":false},{"name":"is_active","label":"Is active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false}],"display_fields":["device_name","location","is_active"]},{"key":"gate_duty_records","table":"gate_duty_records","title":"Gate duty attendance records","group":"Student services","editable":["student_id","direction","scanned_at","gate_device_id","record_source"],"help":"Correct or remove an individual duty attendance record after reviewing the scan time.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"student_id","label":"Student","type":"text","required":true,"default":null,"options":[],"reference":{"table":"students","column":"id"},"primary":false},{"name":"direction","label":"Direction","type":"text","required":true,"default":null,"options":["IN","OUT"],"reference":null,"primary":false},{"name":"scanned_at","label":"Scanned at","type":"timestamp with time zone","required":true,"default":"__now__","options":[],"reference":null,"primary":false},{"name":"gate_device_id","label":"Gate device","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"gate_devices","column":"id"},"primary":false},{"name":"record_source","label":"Record source","type":"text","required":true,"default":"scanner","options":["scanner","manual"],"reference":null,"primary":false}],"display_fields":["student_id","direction","scanned_at","gate_device_id","record_source"]},{"key":"library_titles","table":"library_titles","title":"Library titles","group":"Library","editable":["isbn","title","subtitle","author","publisher","publication_year","category","shelf_location","notes","active"],"help":"Enter book details manually or use ISBN lookup in Library.","archive_field":"active","primary_keys":["id"],"fields":[{"name":"isbn","label":"Isbn","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"title","label":"Title","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"subtitle","label":"Subtitle","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"author","label":"Author","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"publisher","label":"Publisher","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"publication_year","label":"Publication year","type":"integer","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"category","label":"Category","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"shelf_location","label":"Shelf location","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"notes","label":"Notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"active","label":"Active","type":"boolean","required":true,"default":true,"options":[],"reference":null,"primary":false}],"display_fields":["isbn","title","subtitle","author","publisher"]},{"key":"library_copies","table":"library_copies","title":"Library physical copies","group":"Library","editable":["title_id","barcode","accession_number","status","condition_notes","acquired_on"],"help":"Correct copy details and condition. Use normal checkout and return for circulation.","archive_field":null,"primary_keys":["id"],"fields":[{"name":"title_id","label":"Title","type":"uuid","required":true,"default":null,"options":[],"reference":{"table":"library_titles","column":"id"},"primary":false},{"name":"barcode","label":"Barcode","type":"text","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"accession_number","label":"Accession number","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"status","label":"Status","type":"text","required":true,"default":"available","options":["available","on_loan","missing","damaged","withdrawn"],"reference":null,"primary":false},{"name":"condition_notes","label":"Condition notes","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false},{"name":"acquired_on","label":"Acquired on","type":"date","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["title_id","barcode","accession_number","status","condition_notes"]},{"key":"ops_settings","table":"ops_settings","title":"Operations configuration","group":"Configuration","editable":["setting_key","setting_value","description"],"help":"Maintain approved operations settings. Choose a value type and enter the value through the form.","archive_field":null,"primary_keys":["setting_key"],"fields":[{"name":"setting_key","label":"Setting key","type":"text","required":true,"default":null,"options":["finance_enabled","jira_project_key","report_week_starts_on","school_timezone","session_hours"],"reference":null,"primary":true},{"name":"setting_value","label":"Setting value","type":"jsonb","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"description","label":"Description","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["setting_key","setting_value","description"]},{"key":"library_settings","table":"library_settings","title":"Library configuration","group":"Library","editable":["setting_key","setting_value","description"],"help":"Maintain library loan rules and catalogue visibility. Daily rule changes can also be made in Library settings.","archive_field":null,"primary_keys":["setting_key"],"fields":[{"name":"setting_key","label":"Setting key","type":"text","required":true,"default":null,"options":["loan_days","max_active_loans","max_renewals","public_catalog_enabled"],"reference":null,"primary":true},{"name":"setting_value","label":"Setting value","type":"jsonb","required":true,"default":null,"options":[],"reference":null,"primary":false},{"name":"description","label":"Description","type":"text","required":false,"default":null,"options":[],"reference":null,"primary":false}],"display_fields":["setting_key","setting_value","description"]}]'::jsonb;
$function$
;

CREATE OR REPLACE FUNCTION it_admin_private.command(p_token text, p_entity text, p_action text, p_key jsonb, p_values jsonb, p_revision text, p_actor text, p_reason text, p_confirmation text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'private'
AS $function$
declare e jsonb; old_row jsonb; new_row jsonb; v jsonb; deps jsonb; pred text; cols text; vals text; assignments text; c text; f jsonb; r record; fk text; ref_table text; changed int; active_col text; confirmation text; saved_key jsonb; supplemental jsonb:='{}'; generated_secret text; v_count int; v_male int; v_female int;
begin
 perform it_admin_private.context(p_token);e:=it_admin_private.entity(p_entity);
 if p_action not in ('create','save','preview','delete','archive','restore','rotate_device') then raise exception 'Choose a supported record action.' using errcode='22023'; end if;
 if p_action='rotate_device' and p_entity<>'gate_devices' then raise exception 'Pairing tokens belong to gate devices.' using errcode='42501'; end if;
 if p_action<>'preview' and (length(btrim(coalesce(p_actor,'')))<2 or length(btrim(coalesce(p_reason,'')))<5) then
  return jsonb_build_object('status','invalid','message','Enter your name and a change reason of at least five characters.');
 end if;
 select string_agg(format('t.%I::text=$1->>%L',value#>>'{}',value#>>'{}'),' and ') into pred from jsonb_array_elements(e->'primary_keys');
 if p_action<>'create' then
  if jsonb_typeof(p_key)<>'object' or exists(select 1 from jsonb_array_elements_text(e->'primary_keys') pk where not p_key?pk) then return jsonb_build_object('status','invalid','message','Choose an existing record.'); end if;
  execute format('select to_jsonb(t) from public.%I t where %s for update',e->>'table',pred) into old_row using p_key;
  if old_row is null then return jsonb_build_object('status','not_found','message','This record has already been removed. Refresh the list.'); end if;
  if p_action<>'preview' and (p_revision is null or p_revision<>md5((old_row-'last_seen_at')::text)) then return jsonb_build_object('status','conflict','message','Someone changed this record. Refresh and review their changes before saving.'); end if;
 end if;
 if p_action in ('preview','delete','archive','restore','rotate_device') then
  deps:=it_admin_private.dependencies(p_entity,old_row);
  confirmation:=case when p_entity='students' then old_row->>'registration_number' else 'REMOVE' end;
  if p_action='preview' then return jsonb_build_object('status','success','dependencies',deps,'confirmation',confirmation,'can_delete',not exists(select 1 from jsonb_array_elements(deps) d where not(d->>'owned')::boolean),'can_archive',e->>'archive_field' is not null); end if;
  if p_confirmation<>confirmation or p_confirmation is null then return jsonb_build_object('status','invalid','message','Type the confirmation exactly as displayed.'); end if;
 end if;
 if p_action='delete' then
  if exists(select 1 from jsonb_array_elements(deps) d where not(d->>'owned')::boolean) then
   return jsonb_build_object('status','linked','message','This record has linked history or assignments. Archive it where available, or review the linked records before removal.','dependencies',deps);
  end if;
  if p_entity='ops_service_duty_weeks' then
   select coalesce(jsonb_agg(to_jsonb(m)),'[]'::jsonb) into supplemental from public.ops_service_duty_members m where m.week_start=(old_row->>'week_start')::date;
  end if;
  execute format('delete from public.%I t where %s',e->>'table',pred) using p_key;
  perform private.ops_audit('it_admin',null,btrim(p_actor),'it_record_delete',p_entity,p_key::text,jsonb_build_object('reason',btrim(p_reason),'before',old_row,'owned_duty_members',supplemental));
  return jsonb_build_object('status','success','message','Record removed. Its audit record is retained.');
 end if;
 if p_action='rotate_device' then
  v:='{}'::jsonb;
 elsif p_action in ('archive','restore') then
  active_col:=e->>'archive_field'; if active_col is null then return jsonb_build_object('status','invalid','message','This record has no archive action.'); end if;
  v:=jsonb_build_object(active_col,p_action='restore');
 else
  if jsonb_typeof(p_values)<>'object' then return jsonb_build_object('status','invalid','message','Enter values using the record form.'); end if;
  if exists(select 1 from jsonb_object_keys(p_values) k where not(e->'editable'?k)) then return jsonb_build_object('status','invalid','message','The form includes a field that cannot be edited. Refresh the page.'); end if;
  v:=p_values;
  if p_action='save' then
   for c in select jsonb_array_elements_text(e->'primary_keys') loop
    if v?c and v->c is distinct from old_row->c then return jsonb_build_object('status','invalid','message','Record identifiers cannot be changed. Create the correct record and remove the mistaken record.'); end if;
    v:=v-c;
   end loop;
  end if;
 end if;
 if p_entity='gate_devices' and p_action in ('create','rotate_device') then
  generated_secret:=encode(extensions.gen_random_bytes(32),'hex');
  v:=v||jsonb_build_object('token_hash',encode(extensions.digest(generated_secret,'sha256'),'hex'));
 end if;
 if p_entity in ('ops_settings','library_settings') then
  c:=coalesce(v->>'setting_key',old_row->>'setting_key');
  if (p_entity='ops_settings' and c not in ('finance_enabled','jira_project_key','report_week_starts_on','school_timezone','session_hours')) or
    (p_entity='library_settings' and c not in ('loan_days','max_active_loans','max_renewals','public_catalog_enabled')) then
   return jsonb_build_object('status','invalid','message','Choose an approved configuration setting.');
  end if;
  if v?'setting_value' and c in ('finance_enabled','public_catalog_enabled') and jsonb_typeof(v->'setting_value')<>'boolean' then return jsonb_build_object('status','invalid','message','Choose Yes or no for this setting.');end if;
  if v?'setting_value' and c in ('loan_days','max_active_loans','max_renewals','report_week_starts_on') and (jsonb_typeof(v->'setting_value')<>'number' or (v->>'setting_value')::numeric<0 or (v->>'setting_value')::numeric>365 or (v->>'setting_value')::numeric<>trunc((v->>'setting_value')::numeric)) then return jsonb_build_object('status','invalid','message','Enter a whole number from zero to 365.');end if;
  if v?'setting_value' and c='school_timezone' and not exists(select 1 from pg_timezone_names where name=v->>'setting_value') then return jsonb_build_object('status','invalid','message','Enter a recognised time zone such as Africa/Harare.');end if;
 end if;
 if p_entity='students' then
  if p_action='create' then v:=v||jsonb_build_object('id',gen_random_uuid()::text); end if;
  if v?'registration_number' then
   if coalesce(v->>'registration_number','')!~'^[0-9]{5}$' then return jsonb_build_object('status','invalid','message','Enter a five digit registration number.'); end if;
   if exists(select 1 from public.students s where s.registration_number=(v->>'registration_number')::bigint and (old_row is null or s.id<>old_row->>'id')) then return jsonb_build_object('status','invalid','message','That registration number already belongs to a student.'); end if;
  end if;
  if v?'full_name' and length(btrim(coalesce(v->>'full_name','')))<2 then return jsonb_build_object('status','invalid','message','Enter the student full name.'); end if;
 end if;
 if p_entity in ('ops_weekly_duty_roster','ops_service_duty_weeks','ops_service_duty_members') and v?'week_start' and extract(isodow from (v->>'week_start')::date)<>1 then return jsonb_build_object('status','invalid','message','Choose the Monday beginning this duty week.'); end if;
 -- Verify selected people rather than accepting free text or inactive students.
 for f in select value from jsonb_array_elements(e->'fields') loop
  if f->'reference'->>'table'='students' and v?(f->>'name') and v->(f->>'name')<>'null'::jsonb then
   if not exists(select 1 from public.students s where s.id=v->>(f->>'name') and s.is_active) then return jsonb_build_object('status','invalid','message','Choose an exact active student record.'); end if;
  end if;
 end loop;
 if p_entity='ops_weekly_duty_roster' then
  if v?'prefect_student_id' then select full_name into c from public.students where id=v->>'prefect_student_id';v:=v||jsonb_build_object('prefect_on_duty',coalesce(c,'')); end if;
  if v?'senior_prefect_student_id' then select full_name into c from public.students where id=v->>'senior_prefect_student_id';v:=v||jsonb_build_object('senior_prefect_on_duty',coalesce(c,'')); end if;
 end if;
 if p_entity='ops_service_duty_weeks' and coalesce(v->>'bell_ringer_student_id',old_row->>'bell_ringer_student_id') is not null and coalesce(v->>'bell_ringer_student_id',old_row->>'bell_ringer_student_id')=coalesce(v->>'bell_ringer_2_student_id',old_row->>'bell_ringer_2_student_id') then return jsonb_build_object('status','invalid','message','Choose two different bell ringers.'); end if;
 if p_entity='ops_service_duty_members' then
  select count(*),count(*) filter(where s.gender='Male'),count(*) filter(where s.gender='Female') into v_count,v_male,v_female
  from public.ops_service_duty_members m join public.students s on s.id=m.student_id
  where m.week_start=(coalesce(v->>'week_start',old_row->>'week_start'))::date and m.duty_type=coalesce(v->>'duty_type',old_row->>'duty_type')
   and (old_row is null or m.student_id<>old_row->>'student_id');
  select gender into c from public.students where id=coalesce(v->>'student_id',old_row->>'student_id');
  if v_count>=4 or c is null or (c='Male' and v_male>=2) or (c='Female' and v_female>=2) then return jsonb_build_object('status','invalid','message','Each duty can contain up to two men and two women. Check the student gender and current assignments.'); end if;
 end if;
 -- Actor fields are derived from the validated IT session and operator name.
 for r in select a.attname from pg_attribute a where a.attrelid=format('public.%I',e->>'table')::regclass and a.attnum>0 and not a.attisdropped loop
  if r.attname in ('recorded_by_name','updated_by_name','assigned_by_name') or (r.attname='created_by_name' and p_action='create') then v:=v||jsonb_build_object(r.attname,btrim(p_actor));
  elsif r.attname in ('updated_by_role','allocated_by_role','set_by_role','assigned_by_role') or (r.attname='created_by_role' and p_action='create') then v:=v||jsonb_build_object(r.attname,'it_admin');
  elsif r.attname='updated_at' then v:=v||jsonb_build_object(r.attname,now()); end if;
 end loop;
 if p_entity='ops_session_department_members' then
  select full_name into c from public.students where id=coalesce(v->>'student_id',old_row->>'student_id');
  v:=v||jsonb_build_object('member_name',c);
 end if;
 if p_entity='ops_gate_duty_assignments' then v:=v||jsonb_build_object('updated_by_student_id',null); end if;
 if p_action='create' then
  select string_agg(format('%I',k),','),string_agg(format('x.%I',k),',') into cols,vals from jsonb_object_keys(v) k;
  execute format('insert into public.%I (%s) select %s from jsonb_populate_record(null::public.%I,$1) x returning to_jsonb(%I.*)',e->>'table',cols,vals,e->>'table',e->>'table') into new_row using v;
 else
  select string_agg(format('%I=x.%I',k,k),',') into assignments from jsonb_object_keys(v) k;
  execute format('update public.%I t set %s from jsonb_populate_record(null::public.%I,$2) x where %s returning to_jsonb(t)',e->>'table',assignments,e->>'table',pred) into new_row using p_key,v;
 end if;
 if p_entity='student_term_fee_status' then
  update public.term_registrations set fees_answers=fees_answers||jsonb_build_object(
   'arrears_previous_terms',new_row->'arrears_previous_terms','amount_paid_current_term',new_row->'amount_paid_current_term',
   'outstanding_balance',new_row->'outstanding_balance','payment_plan',new_row->'payment_plan'),updated_at=now()
  where student_id=new_row->>'student_id' and term_id=(new_row->>'term_id')::bigint;
  for r in select id from public.term_registrations where student_id=new_row->>'student_id' and term_id=(new_row->>'term_id')::bigint loop
   perform private.tr_write_history(r.id,'it_admin','it_fee_record_corrected','fees',old_row,new_row,p_reason);
  end loop;
 end if;
 if p_entity='students' and not(new_row->>'is_active')::boolean and (old_row is null or (old_row->>'is_active')::boolean) then
  -- Preserve history and remove current and future duty appearances.
  supplemental:=jsonb_build_object('future_gate_duties',(select coalesce(jsonb_agg(to_jsonb(g)),'[]') from public.ops_gate_duty_assignments g where g.student_id=new_row->>'id' and g.duty_date>=current_date),
   'current_and_future_service_members',(select coalesce(jsonb_agg(to_jsonb(m)),'[]') from public.ops_service_duty_members m where m.student_id=new_row->>'id' and m.week_start+6>=current_date));
  delete from public.ops_gate_duty_assignments where student_id=new_row->>'id' and duty_date>=current_date;
  delete from public.ops_service_duty_members where student_id=new_row->>'id' and week_start+6>=current_date;
  update public.ops_service_duty_weeks set bell_ringer_student_id=case when bell_ringer_student_id=new_row->>'id' then null else bell_ringer_student_id end,
   bell_ringer_2_student_id=case when bell_ringer_2_student_id=new_row->>'id' then null else bell_ringer_2_student_id end,updated_at=now()
   where week_start+6>=current_date and (bell_ringer_student_id=new_row->>'id' or bell_ringer_2_student_id=new_row->>'id');
  update public.ops_weekly_duty_roster set prefect_student_id=case when prefect_student_id=new_row->>'id' then null else prefect_student_id end,
   prefect_on_duty=case when prefect_student_id=new_row->>'id' then '' else prefect_on_duty end,
   senior_prefect_student_id=case when senior_prefect_student_id=new_row->>'id' then null else senior_prefect_student_id end,
   senior_prefect_on_duty=case when senior_prefect_student_id=new_row->>'id' then '' else senior_prefect_on_duty end,updated_at=now()
   where week_start+6>=current_date and (prefect_student_id=new_row->>'id' or senior_prefect_student_id=new_row->>'id');
  update public.ops_department_memberships set active=false,ends_on=case when ends_on is null or ends_on>current_date then current_date else ends_on end where student_id=new_row->>'id' and active;
  update public.ops_student_leadership_roles set active=false,updated_at=now() where student_id=new_row->>'id' and active;
  for r in select distinct department_id from public.ops_department_memberships where student_id=new_row->>'id' loop perform private.ops_refresh_department_group_counts(r.department_id,p_actor);end loop;
  delete from public.ops_session_assignments a using public.ops_work_sessions s where a.session_id=s.id and a.student_id=new_row->>'id' and s.work_date>=current_date;
  delete from public.ops_session_department_members m using public.ops_work_sessions s where m.session_id=s.id and m.student_id=new_row->>'id' and s.work_date>=current_date;
 end if;
 select jsonb_object_agg(pk,new_row->pk) into saved_key from jsonb_array_elements_text(e->'primary_keys') pk;
 perform private.ops_audit('it_admin',null,btrim(p_actor),'it_record_'||p_action,p_entity,saved_key::text,jsonb_build_object('reason',btrim(p_reason),'before',old_row-'token_hash','after',new_row-'token_hash','archive_changes',supplemental));
 return jsonb_build_object('status','success','message',case p_action when 'archive' then 'Record archived. History is retained.' when 'restore' then 'Record restored. Reassign duties separately if needed.' else 'Record saved.' end,'key',saved_key,'revision',md5((new_row-'last_seen_at')::text),'pairing_token',generated_secret);
exception
 when unique_violation then return jsonb_build_object('status','invalid','message','A record with those identifiers already exists. Edit the existing record.');
 when foreign_key_violation then return jsonb_build_object('status','linked','message','This change has a linked record. Choose an existing related record or review its linked history.');
 when check_violation or not_null_violation or invalid_text_representation or numeric_value_out_of_range or datetime_field_overflow then
  return jsonb_build_object('status','invalid','message','Check required fields, dates, numbers and the selected options. '||coalesce(SQLERRM,''));
end $function$
;

CREATE OR REPLACE FUNCTION it_admin_private.context(p_token text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'private'
AS $function$
declare c record;
begin
 select * into c from private.system_session_context(p_token,array['it_admin']);
 if not found then raise exception 'Sign in to IT Administration again.' using errcode='28000'; end if;
 if c.must_change_pin then raise exception 'Change the temporary IT Administrator PIN before managing records.' using errcode='42501'; end if;
end $function$
;

CREATE OR REPLACE FUNCTION it_admin_private.dependencies(p_entity text, p_row jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public'
AS $function$
declare e jsonb; c record; pred text; n bigint; out jsonb:='[]'; child_title text;
begin
 e:=it_admin_private.entity(p_entity);
 for c in
  select pc.oid,cn.nspname child_schema,cl.relname child_table,pc.conkey,pc.confkey
  from pg_constraint pc join pg_class cl on cl.oid=pc.conrelid join pg_namespace cn on cn.oid=cl.relnamespace
  where pc.contype='f' and pc.confrelid=format('public.%I',e->>'table')::regclass
 loop
  select string_agg(format('child.%I::text = $1->>%L',ca.attname,pa.attname),' and ') into pred
  from unnest(c.conkey,c.confkey) x(child_att,parent_att)
  join pg_attribute ca on ca.attrelid=format('%I.%I',c.child_schema,c.child_table)::regclass and ca.attnum=x.child_att
  join pg_attribute pa on pa.attrelid=format('public.%I',e->>'table')::regclass and pa.attnum=x.parent_att;
  execute format('select count(*) from %I.%I child where %s',c.child_schema,c.child_table,pred) into n using p_row;
  if n>0 then
   select value->>'title' into child_title from jsonb_array_elements(it_admin_private.catalog()) where value->>'table'=c.child_table;
   out:=out||jsonb_build_array(jsonb_build_object('area',coalesce(child_title,replace(c.child_table,'_',' ')),'count',n,
    'owned',p_entity='ops_service_duty_weeks' and c.child_table='ops_service_duty_members'));
  end if;
 end loop;
 return out;
end $function$
;

CREATE OR REPLACE FUNCTION it_admin_private.entity(p_entity text)
 RETURNS jsonb
 LANGUAGE plpgsql
 IMMUTABLE
 SET search_path TO 'pg_catalog'
AS $function$
declare e jsonb;
begin
 select value into e from jsonb_array_elements(it_admin_private.catalog()) where value->>'key'=p_entity;
 if e is null then raise exception 'This record area is not available.' using errcode='42501'; end if;
 return e;
end $function$
;

CREATE OR REPLACE FUNCTION it_admin_private.lookups(p_token text, p_entity text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public'
AS $function$
declare e jsonb; f jsonb; t text; k text; items jsonb; result jsonb:='{}'; label_expr text;
begin
 perform it_admin_private.context(p_token); e:=it_admin_private.entity(p_entity);
 for f in select value from jsonb_array_elements(e->'fields') loop
  if f->'reference' is not null and f->'reference'<>'null'::jsonb then
   t:=f->'reference'->>'table'; k:=f->'reference'->>'column';
  elsif f->>'array_reference' is not null then t:=f->>'array_reference'; k:='code';
  else continue; end if;
  label_expr:=case t
   when 'students' then 'concat(full_name,'' · '',registration_number,case when is_active then '''' else '' · archived'' end)'
   when 'sponsors' then 'concat(name,'' · '',phone)'
   when 'academic_terms' then 'term_name'
   when 'ops_departments' then 'name'
   when 'ops_time_slots' then 'name'
   when 'library_titles' then 'concat(title,'' · '',coalesce(author,''Author not entered''))'
   when 'library_copies' then 'barcode'
   when 'ops_stock_items' then 'concat(item_name,'' · '',coalesce(unit,''''))'
   when 'ops_units' then 'name'
   when 'ops_metric_definitions' then 'label'
   when 'ops_tasks' then 'title'
   when 'ops_reports' then 'concat(report_type,'' · '',period_start,'' to '',period_end)'
   when 'ops_session_requests' then 'concat(work_date,'' · '',requested_by_name)'
   when 'ops_work_sessions' then 'concat(work_date,'' · '',status)'
   when 'ops_transfers' then 'concat(transfer_date,'' · '',coalesce(reference,''Transfer''))'
   when 'gate_passes' then 'concat(departure_at::date,'' · '',destination,'' · '',status)'
   when 'gate_devices' then 'concat(device_name,'' · '',location)'
   else format('%I::text',k) end;
  execute format('select coalesce(jsonb_agg(v order by v->>''label''),''[]''::jsonb) from (select jsonb_build_object(''value'',%I::text,''label'',%s) v from public.%I limit 5000) q',k,label_expr,t) into items;
  result:=result||jsonb_build_object(f->>'name',items);
 end loop;
 return jsonb_build_object('status','success','choices',result);
end $function$
;

CREATE OR REPLACE FUNCTION it_admin_private.records(p_token text, p_entity text, p_query text, p_page integer)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public'
AS $function$
declare e jsonb; fields text[]; rows jsonb; total bigint; history jsonb; order_cols text; label_expr text; key_expr text; search_expr text;
begin
 perform it_admin_private.context(p_token);e:=it_admin_private.entity(p_entity);
 fields:=array(select value#>>'{}' from jsonb_array_elements(e->'editable'))||array(select value#>>'{}' from jsonb_array_elements(e->'primary_keys'));
 select string_agg(format('t.%I',value#>>'{}'),',') into order_cols from jsonb_array_elements(e->'primary_keys');
 select 'jsonb_build_object('||string_agg(format('%L,t.%I',value#>>'{}',value#>>'{}'),',')||')' into key_expr from jsonb_array_elements(e->'primary_keys');
 search_expr:='(select jsonb_object_agg(k,v) from jsonb_each(to_jsonb(t)) x(k,v) where k=any($2))::text';
 execute format('select count(*) from public.%I t where $1='''' or %s ilike ''%%''||$1||''%%''',e->>'table',search_expr) into total using left(coalesce(p_query,''),200),fields;
 execute format('select coalesce(jsonb_agg(q.record),''[]''::jsonb) from (select jsonb_build_object(''data'',(select jsonb_object_agg(k,v) from jsonb_each(to_jsonb(t)) x(k,v) where k=any($2)),''key'',%s,''revision'',md5((to_jsonb(t)-''last_seen_at'')::text)) record from public.%I t where $1='''' or %s ilike ''%%''||$1||''%%'' order by %s limit 50 offset $3) q',key_expr,e->>'table',search_expr,order_cols)
 into rows using left(coalesce(p_query,''),200),fields,greatest(0,least(coalesce(p_page,0),10000))*50;
 select coalesce(jsonb_agg(to_jsonb(a) order by a.created_at desc),'[]'::jsonb) into history from (
  select event_at as created_at,actor_name,action,details->>'reason' reason,
   (select jsonb_object_agg(k,v) from jsonb_each(case when jsonb_typeof(details->'before')='object' then details->'before' else '{}'::jsonb end) x(k,v) where k=any(fields)) before_values,
   (select jsonb_object_agg(k,v) from jsonb_each(case when jsonb_typeof(details->'after')='object' then details->'after' else '{}'::jsonb end) x(k,v) where k=any(fields)) after_values
  from public.ops_audit_log where actor_role='it_admin' and entity_type=p_entity and action like 'it_record_%' order by event_at desc limit 50
 ) a;
 return jsonb_build_object('status','success','records',rows,'total',total,'page',greatest(0,coalesce(p_page,0)),'page_size',50,'history',history);
end $function$
;

CREATE OR REPLACE FUNCTION it_documents_private.authorize(p_token text, p_write boolean, p_version_id uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare c jsonb; v public.ops_it_document_versions%rowtype;
begin
 c := it_documents_private.context(p_token,p_write);
 if p_version_id is not null then
  select * into v from public.ops_it_document_versions where id=p_version_id;
  if not found then raise exception 'Document version was not found.' using errcode='P0002'; end if;
  return c || jsonb_build_object('version',to_jsonb(v));
 end if;
 return c;
end;
$function$
;

CREATE OR REPLACE FUNCTION it_documents_private.bootstrap(p_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare c jsonb;
begin
 c := it_documents_private.context(p_token,false);
 return jsonb_build_object('status','success','can_write',c->'can_write','items',(
  select coalesce(jsonb_agg((to_jsonb(d)-'source_key') || jsonb_build_object('versions',
   (select coalesce(jsonb_agg(to_jsonb(v)-'storage_path'-'sha256' order by v.version_number desc),'[]'::jsonb)
    from public.ops_it_document_versions v where v.document_id=d.id)) order by lower(d.title)),'[]'::jsonb)
   from public.ops_it_documents d where d.current_version_id is not null));
end;
$function$
;

CREATE OR REPLACE FUNCTION it_documents_private.commit_version(p_token text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare c jsonb; d public.ops_it_documents%rowtype; v public.ops_it_document_versions%rowtype;
 did uuid := (p_payload->>'document_id')::uuid; vid uuid := (p_payload->>'version_id')::uuid;
 old_id uuid; next_number integer; author text;
begin
 c := it_documents_private.context(p_token,true);
 select * into d from public.ops_it_documents where id=did for update;
 if found then
  if d.current_version_id is distinct from nullif(p_payload->>'expected_current_version_id','')::uuid then
   return jsonb_build_object('status','conflict','message','A newer version was uploaded while you were working. Refresh the register and try again.');
  end if;
  old_id := d.current_version_id;
  if exists(select 1 from public.ops_it_document_versions where id=old_id and sha256=p_payload->>'sha256') then
   return jsonb_build_object('status','invalid','message','This file is identical to the current version. Choose the revised document.');
  end if;
  if nullif(btrim(p_payload->>'change_note'),'') is null then
   return jsonb_build_object('status','invalid','message','Describe what changed in this version.');
  end if;
 else
  if nullif(p_payload->>'expected_current_version_id','') is not null then
   return jsonb_build_object('status','invalid','message','The original document was not found. Refresh and try again.');
  end if;
  insert into public.ops_it_documents(id,title,section,category,document_type)
   values(did,btrim(p_payload->>'title'),p_payload->>'section',btrim(p_payload->>'category'),p_payload->>'document_type') returning * into d;
 end if;
 if p_payload->>'storage_path' <> did::text||'/'||vid::text||'/'||(p_payload->>'file_name') or not exists(
  select 1 from storage.objects o where o.bucket_id='it-technical-documents' and o.name=p_payload->>'storage_path') then
  raise exception 'The document file has not finished uploading.';
 end if;
 select coalesce(max(version_number),0)+1 into next_number from public.ops_it_document_versions where document_id=did;
 author := case when c->>'role'='administrator' then 'School Administration' else 'IT Department' end;
 insert into public.ops_it_document_versions(id,document_id,version_number,storage_path,file_name,mime_type,file_size,sha256,change_note,uploaded_by)
 values(vid,did,next_number,p_payload->>'storage_path',p_payload->>'file_name',p_payload->>'mime_type',(p_payload->>'file_size')::integer,p_payload->>'sha256',coalesce(btrim(p_payload->>'change_note'),''),author) returning * into v;
 update public.ops_it_documents set current_version_id=vid,updated_at=now() where id=did;
 perform private.ops_audit(c->>'role',(c->>'department_id')::uuid,author,'it_document_version','it_document',did::text,
  jsonb_build_object('old_version_id',old_id,'version_id',vid,'version_number',next_number,'file_name',v.file_name,'sha256',v.sha256,'change_note',v.change_note));
 return jsonb_build_object('status','success','document_id',did,'version_number',next_number,'archived_version_id',old_id);
exception when unique_violation then
 return jsonb_build_object('status','invalid','message','A document with this title already exists. Use Upload new version on that document.');
end;
$function$
;

CREATE OR REPLACE FUNCTION it_documents_private.context(p_token text, p_write boolean DEFAULT false)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare c record; is_it boolean; writable boolean;
begin
 select * into c from private.ops_session_context(p_token);
 select exists(select 1 from public.ops_departments d where d.id=c.actor_department_id and d.slug='it-department' and d.active) into is_it;
 writable := (c.actor_role='department' and is_it) or c.actor_role='administrator';
 if not (writable or (not p_write and c.actor_role='management')) then
  raise exception 'Sign in to IT Department or School Administration to manage technical documents.' using errcode='42501';
 end if;
 return jsonb_build_object('role',c.actor_role,'department_id',c.actor_department_id,'can_write',writable);
end;
$function$
;

CREATE OR REPLACE FUNCTION private.block_meal_collection_during_conference()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'private', 'public', 'pg_catalog'
AS $function$
begin
  if not private.meal_feature_enabled('meal_collection_enabled') then
    raise exception 'Meal collection is turned off.' using errcode='P0001';
  end if;
  if private.conference_mode() then
    raise exception 'Meal collection is unavailable while Conference Mode is on.' using errcode='P0001';
  end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.conference_mode()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select coalesce((
    select (setting_value #>> '{}')::boolean
    from public.system_settings
    where setting_key='conference_mode'
  ),false)
$function$
;

CREATE OR REPLACE FUNCTION private.fee_dashboard_for_term(p_term_id bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_term public.academic_terms%rowtype;
  v_rows jsonb;
begin
  select * into v_term from public.academic_terms where id=p_term_id;
  if not found then
    return jsonb_build_object('status','not_found','message','Academic term not found.');
  end if;

  select coalesce(jsonb_agg(jsonb_build_object(
    'registration_id',tr.id,
    'student_id',tr.student_id,
    'student_name',tr.student_name_snapshot,
    'registration_number',tr.registration_number_snapshot,
    'class_year',tr.class_year_snapshot,
    'student_email',nullif(btrim(coalesce(tr.student_answers->>'student_email','')),''),
    'fees_paid',coalesce(fs.fees_paid,false),
    'outstanding_balance',coalesce(fs.outstanding_balance,0),
    'arrears_previous_terms',coalesce(fs.arrears_previous_terms,0),
    'amount_paid_current_term',coalesce(fs.amount_paid_current_term,0),
    'payment_plan',fs.payment_plan,
    'notes',fs.notes,
    'notice_text',fs.notice_text,
    'notice_source_date',fs.notice_source_date,
    'notice_source_row',fs.notice_source_row,
    'notice_export_name',fs.notice_export_name,
    'notice_last_queued_at',fs.notice_last_queued_at,
    'notice_last_sent_at',fs.notice_last_sent_at,
    'notice_last_recipient',fs.notice_last_recipient,
    'notice_last_delivery_status',fs.notice_last_delivery_status,
    'notice_last_error',fs.notice_last_error,
    'fee_status',case
      when fs.student_id is null then 'not_recorded'
      when coalesce(fs.fees_paid,false) or coalesce(fs.outstanding_balance,0)<=0 then 'paid'
      else 'arrears'
    end,
    'send_eligible',(
      fs.student_id is not null
      and not coalesce(fs.fees_paid,false)
      and coalesce(fs.outstanding_balance,0)>0
      and nullif(btrim(coalesce(fs.notice_text,'')),'') is not null
      and lower(btrim(coalesce(tr.student_answers->>'student_email',''))) ~ '^[^[:space:]@]+@[^[:space:]@]+[.][^[:space:]@]+$'
    )
  ) order by tr.student_name_snapshot),'[]'::jsonb)
  into v_rows
  from public.term_registrations tr
  left join public.student_term_fee_status fs
    on fs.student_id=tr.student_id and fs.term_id=tr.term_id
  where tr.term_id=v_term.id;

  return jsonb_build_object(
    'status','success',
    'selected_term',jsonb_build_object(
      'id',v_term.id,'term_name',v_term.term_name,'academic_year',v_term.academic_year,
      'term_number',v_term.term_number,'fees_due_date',v_term.fees_due_date
    ),
    'registrations',v_rows
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION private.immigration_session_context(p_token text, p_write boolean DEFAULT false)
 RETURNS TABLE(actor_role text, can_edit boolean)
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_slug text;
begin
  select * into v_context from private.ops_session_context(p_token);
  if not found then raise exception 'Your Department Operations session has expired.' using errcode='28000'; end if;
  if v_context.actor_role='department' then
    select slug into v_slug from public.ops_departments where id=v_context.actor_department_id;
    if v_slug<>'immigration' then raise exception 'Immigration access is required.' using errcode='42501'; end if;
    actor_role:='immigration'; can_edit:=true;
  elsif v_context.actor_role='administrator' then actor_role:='administrator'; can_edit:=true;
  elsif v_context.actor_role='management' then actor_role:='management'; can_edit:=false;
  else raise exception 'Immigration access is required.' using errcode='42501';
  end if;
  if p_write and not can_edit then raise exception 'Management access is read-only.' using errcode='42501'; end if;
  return next;
end
$function$
;

CREATE OR REPLACE FUNCTION private.library_audit(p_role text, p_actor_name text, p_action text, p_entity_type text, p_entity_id text, p_details jsonb)
 RETURNS void
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  insert into public.library_audit_log(actor_role,actor_name,action,entity_type,entity_id,details)
  values(p_role,nullif(btrim(coalesce(p_actor_name,'')),''),p_action,p_entity_type,p_entity_id,coalesce(p_details,'{}'::jsonb))
$function$
;

CREATE OR REPLACE FUNCTION private.library_context(p_token text)
 RETURNS TABLE(role_key text, role_label text, can_manage_settings boolean)
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record;
begin
  select * into v_context
  from private.system_session_context(p_token,array['library_staff','administrator','it_admin']);
  if not found then return; end if;
  return query
  select v_context.role_key,c.role_label,v_context.role_key in ('administrator','it_admin')
  from public.system_access_credentials c
  where c.role_key=v_context.role_key;
end
$function$
;

CREATE OR REPLACE FUNCTION private.library_touch_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
begin new.updated_at:=now(); return new; end
$function$
;

CREATE OR REPLACE FUNCTION private.meal_feature_enabled(p_setting_key text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select coalesce((select (setting_value #>> '{}')::boolean from public.system_settings where setting_key=p_setting_key),false)
$function$
;

CREATE OR REPLACE FUNCTION private.meal_holiday_mode()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'private', 'public', 'pg_catalog'
AS $function$
  select private.school_operating_mode()='holiday'
$function$
;

CREATE OR REPLACE FUNCTION private.meal_plan_save(p_registration_number text, p_meal_session text, p_service_date date, p_source text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_student public.students%rowtype;
  v_window jsonb;
  v_existing public.meal_plans%rowtype;
begin
  if not private.meal_feature_enabled('meal_check_in_enabled') then
    return jsonb_build_object('status','feature_disabled','message','Meal check-in is turned off.');
  end if;
  if p_registration_number !~ '^[0-9]{5}$' then return jsonb_build_object('status','invalid','message','Enter a five-digit registration number.'); end if;
  if p_meal_session not in ('Breakfast','Lunch','Break-fast 4pm') then return jsonb_build_object('status','invalid','message','Choose Breakfast, Lunch or Break-fast 4pm.'); end if;
  if p_source not in ('student_self','staff') then return jsonb_build_object('status','invalid','message','Invalid source.'); end if;
  select * into v_student from public.students where registration_number=p_registration_number::bigint and is_active=true limit 1;
  if not found then return jsonb_build_object('status','not_found','message','This registration number is not on the active student list.'); end if;
  v_window:=private.meal_plan_window(p_service_date,p_meal_session);
  if v_window->>'status' in ('holiday_disabled','conference_disabled') then return jsonb_build_object('status',v_window->>'status','message',v_window->>'message'); end if;
  if not coalesce((v_window->>'is_today')::boolean,false) then return jsonb_build_object('status','wrong_day','message','Meal numbers can only be entered for today.'); end if;
  if not coalesce((v_window->>'is_open')::boolean,false) then return jsonb_build_object('status','closed','full_name',v_student.full_name,'registration_number',v_student.registration_number::text,'meal_session',p_meal_session,'message','The meal-number window closed at '||(v_window->>'cutoff_label')||'.'); end if;
  select * into v_existing from public.meal_plans where student_id=v_student.id and service_date=p_service_date and meal_session=p_meal_session limit 1;
  if found then return jsonb_build_object('status','duplicate','full_name',v_student.full_name,'registration_number',v_student.registration_number::text,'meal_session',p_meal_session,'planned_at',v_existing.planned_at,'message','You are already included in this meal number.'); end if;
  begin
    insert into public.meal_plans(student_id,service_date,meal_session,plan_source) values(v_student.id,p_service_date,p_meal_session,p_source);
  exception when unique_violation then
    return jsonb_build_object('status','duplicate','full_name',v_student.full_name,'registration_number',v_student.registration_number::text,'meal_session',p_meal_session,'message','You are already included in this meal number.');
  end;
  return jsonb_build_object('status','planned','full_name',v_student.full_name,'registration_number',v_student.registration_number::text,'meal_session',p_meal_session,'cutoff_label',v_window->>'cutoff_label','message','You are included in the meal number.');
end
$function$
;

CREATE OR REPLACE FUNCTION private.meal_plan_window(p_service_date date, p_meal_session text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_base text:=private.school_operating_mode();
  v_holiday boolean:=v_base='holiday';
  v_conference boolean:=private.conference_mode();
  v_now_local timestamp:=timezone('Africa/Harare',now());
  v_cutoff timestamp;
  v_label text;
begin
  if p_meal_session not in ('Breakfast','Lunch','Break-fast 4pm') then
    return jsonb_build_object(
      'status','not_needed','message','No meal number is needed for this meal.',
      'operating_mode',v_base,'base_mode',v_base,'conference_mode',v_conference
    );
  end if;

  if v_conference or v_holiday then
    return jsonb_build_object('status',case when v_conference then 'conference_disabled' else 'holiday_disabled' end,
      'message',case when v_conference then 'Meal check-in is unavailable during Conference Mode.' else 'Advance meal check-in is not used during Holiday Mode.' end,
      'operating_mode',v_base,'base_mode',v_base,'holiday_mode',v_holiday,'conference_mode',v_conference,
      'cutoff_label',null,'cutoff_local',null,'is_today',p_service_date=v_now_local::date,'is_open',false);
  end if;
  if p_meal_session='Lunch' then
    return jsonb_build_object('status','success','operating_mode',v_base,'base_mode',v_base,
      'holiday_mode',false,'conference_mode',false,'cutoff_label','Open today','cutoff_local',null,
      'is_today',p_service_date=v_now_local::date,'is_open',p_service_date=v_now_local::date);
  end if;

  if p_meal_session='Breakfast' then
    v_cutoff:=p_service_date + case when v_holiday then time '07:00' else time '05:00' end;
    v_label:=case when v_holiday then '7:00 AM' else '5:00 AM' end;
  else
    v_cutoff:=p_service_date + time '15:30';
    v_label:='3:30 PM';
  end if;

  return jsonb_build_object(
    'status','success','operating_mode',v_base,'base_mode',v_base,
    'holiday_mode',v_holiday,'conference_mode',false,
    'cutoff_label',v_label,'cutoff_local',to_char(v_cutoff,'YYYY-MM-DD HH24:MI:SS'),
    'is_today',p_service_date=v_now_local::date,
    'is_open',p_service_date=v_now_local::date and v_now_local<=v_cutoff
  );
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_audit(p_actor_role text, p_actor_department_id uuid, p_actor_name text, p_action text, p_entity_type text, p_entity_id text, p_details jsonb DEFAULT '{}'::jsonb)
 RETURNS void
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  insert into public.ops_audit_log(
    actor_role, actor_department_id, actor_name, action, entity_type, entity_id, details
  ) values (
    p_actor_role, p_actor_department_id, nullif(btrim(p_actor_name), ''),
    p_action, p_entity_type, p_entity_id, coalesce(p_details, '{}'::jsonb)
  );
$function$
;

CREATE OR REPLACE FUNCTION private.ops_block_conference_allocations()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
begin
  if private.conference_mode() then
    raise exception 'Manual-work group allocations are unavailable while Conference Mode is on.';
  end if;
  if tg_op='DELETE' then return old; end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_block_conference_session_activity()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
begin
  if private.conference_mode() then
    if tg_op='UPDATE' and new.status='cancelled' then return new; end if;
    raise exception 'Manual-work sessions are unavailable while Conference Mode is on. Add the work as an Emergency task.';
  end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_can_access_department(p_actor_role text, p_actor_department_id uuid, p_target_department_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select coalesce(
    p_actor_role<>'department'
    or (
      p_actor_department_id is not null
      and p_target_department_id is not null
      and exists(
        with recursive lineage(id,parent_department_id) as (
          select d.id,d.parent_department_id
          from public.ops_departments d
          where d.id=p_target_department_id
          union
          select parent.id,parent.parent_department_id
          from public.ops_departments parent
          join lineage child on child.parent_department_id=parent.id
        )
        select 1 from lineage where id=p_actor_department_id
      )
    ),false
  )
$function$
;

CREATE OR REPLACE FUNCTION private.ops_enforce_mode_task()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
begin
  if private.conference_mode() then
    new.metadata:=coalesce(new.metadata,'{}'::jsonb);
    if not (new.metadata ? 'pre_conference_task_type') then
      new.metadata:=new.metadata || jsonb_build_object(
        'pre_conference_task_type',new.task_type,
        'pre_conference_priority',new.priority
      );
    end if;
    new.task_type:='emergency';
    new.priority:='critical';
    new.metadata:=new.metadata || jsonb_build_object('conference_mode',true);
  end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_enforce_request_timing()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_timezone text:=coalesce((
    select setting_value #>> '{}'
    from public.ops_settings
    where setting_key='school_timezone'
  ),'Africa/Harare');
  v_local_now timestamp;
  v_base text:=private.school_operating_mode();
  v_slot_code text;
  v_check_submission boolean;
begin
  if private.conference_mode() then
    if tg_op='INSERT' then
      raise exception 'Manual-work sessions are unavailable while Conference Mode is on. Add the work as an Emergency task.';
    elsif new.slot_id is distinct from old.slot_id
       or (new.status in ('approved','partially_approved') and new.status is distinct from old.status) then
      raise exception 'Manual-work sessions are unavailable while Conference Mode is on.';
    end if;
  end if;

  v_local_now:=clock_timestamp() at time zone v_timezone;
  -- Department timing is checked when the request is submitted. Authorised
  -- Student Leadership planning functions may move it later without making the
  -- department resubmit the task.
  v_check_submission:=tg_op='INSERT';

  if v_check_submission then
    if new.work_date<v_local_now::date then
      raise exception 'A task cannot be requested for a past date.';
    end if;
    if new.request_kind='planned' then
      if new.work_date<v_local_now::date+1 then
        raise exception 'Same-day work belongs under Unexpected tasks.';
      end if;
      if new.work_date=v_local_now::date+1 and v_local_now::time>=time '18:00' then
        raise exception 'Next-day task requests close at 6:00 pm. Use Unexpected tasks only if the work was genuinely unforeseen.';
      end if;
    end if;
  end if;

  if new.slot_id is not null then
    select code into v_slot_code from public.ops_time_slots where id=new.slot_id and active;
    if v_slot_code is null then
      raise exception 'Choose an active work session.';
    end if;
    if v_base='holiday' and v_slot_code not in ('morning','afternoon') then
      raise exception 'Holiday Mode allows Morning and Afternoon task slots only.';
    end if;
  end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_group_code(p_registration_number bigint, p_gender text)
 RETURNS text
 LANGUAGE sql
 STABLE
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select case
    when public._student_year_number(p_registration_number, public._current_academic_year())=1 and p_gender='Male' then 'year1_men'
    when public._student_year_number(p_registration_number, public._current_academic_year())=1 and p_gender='Female' then 'year1_ladies'
    when public._student_year_number(p_registration_number, public._current_academic_year())=2 and p_gender='Male' then 'year2_men'
    when public._student_year_number(p_registration_number, public._current_academic_year())=2 and p_gender='Female' then 'year2_ladies'
    else null
  end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_hash_token(p_token text)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE STRICT
 SET search_path TO 'pg_catalog', 'extensions'
AS $function$
  select encode(extensions.digest(p_token, 'sha256'), 'hex');
$function$
;

CREATE OR REPLACE FUNCTION private.ops_refresh_department_group_counts(p_department_id uuid, p_actor_name text DEFAULT 'System'::text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_code text;
begin
  foreach v_code in array array['year1_men','year1_ladies','year2_men','year2_ladies'] loop
    insert into public.ops_department_group_counts(
      department_id,group_code,member_count,updated_by_name,updated_at
    )
    select p_department_id,v_code,count(*)::integer,p_actor_name,now()
    from public.ops_department_memberships m
    join public.students s on s.id=m.student_id
    where m.department_id=p_department_id and m.active
      and (m.ends_on is null or m.ends_on>=current_date)
      and s.is_active
      and private.ops_group_code(s.registration_number,s.gender)=v_code
    on conflict(department_id,group_code) do update set
      member_count=excluded.member_count,updated_by_name=excluded.updated_by_name,
      updated_at=now();
  end loop;
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_require_workspace_department_credential()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pg_catalog'
AS $function$
begin
  if not exists(
    select 1 from public.ops_departments d
    where d.id=new.department_id and d.active and d.workspace_enabled
  ) then
    raise exception 'A PIN can only be assigned to an active department workspace.'
      using errcode='23514';
  end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_route_section_notification()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pg_catalog'
AS $function$
declare
  v_original_id uuid:=new.department_id;
  v_workspace_id uuid;
  v_section_name text;
begin
  if new.department_id is null then return new; end if;

  select name into v_section_name
  from public.ops_departments where id=v_original_id;

  with recursive lineage(id,parent_department_id,workspace_enabled,active,depth) as (
    select d.id,d.parent_department_id,d.workspace_enabled,d.active,0
    from public.ops_departments d where d.id=v_original_id
    union
    select parent.id,parent.parent_department_id,parent.workspace_enabled,parent.active,child.depth+1
    from public.ops_departments parent
    join lineage child on child.parent_department_id=parent.id
  )
  select id into v_workspace_id
  from lineage
  where workspace_enabled and active
  order by depth
  limit 1;

  if v_workspace_id is not null and v_workspace_id<>v_original_id then
    new.department_id:=v_workspace_id;
    if v_section_name is not null
       and position(v_section_name || ':' in coalesce(new.title,''))<>1 then
      new.title:=v_section_name || ': ' || new.title;
    end if;
  end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.ops_session_context(p_token text)
 RETURNS TABLE(actor_role text, actor_department_id uuid, access_session_id uuid)
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog', 'extensions'
AS $function$
begin
  if p_token is null or length(p_token) < 32 then
    raise exception 'Your session is missing or invalid.' using errcode = '28000';
  end if;

  return query
  update public.ops_access_sessions s
  set last_seen_at = now()
  where s.token_hash = private.ops_hash_token(p_token)
    and s.revoked_at is null
    and s.expires_at > now()
  returning s.actor_role, s.department_id, s.id;

  if not found then
    raise exception 'Your session has expired. Sign in again.' using errcode = '28000';
  end if;
end;
$function$
;

CREATE OR REPLACE FUNCTION private.ops_student_is_available(p_student_id text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select s.is_active
    and not exists (
      select 1
      from public.student_support_statuses x
      where x.student_id = s.id
        and x.is_active = true
        and x.status_type in ('bed_rest','maternity')
    )
    and coalesce((
      select cm.direction <> 'OUT'
      from public.campus_movements cm
      where cm.student_id = s.id
      order by cm.scanned_at desc, cm.id desc
      limit 1
    ), true)
  from public.students s
  where s.id = p_student_id;
$function$
;

CREATE OR REPLACE FUNCTION private.ops_touch_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog'
AS $function$
begin
  new.updated_at := now();
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION private.pass_email_dispatch()
 RETURNS bigint
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'vault', 'net', 'pg_catalog'
AS $function$
declare
  v_enabled boolean;
  v_has_work boolean;
  v_url text;
  v_key text;
  v_request_id bigint;
begin
  select enabled into v_enabled
  from private.pass_email_settings
  where singleton=true;

  if not coalesce(v_enabled,false) then return null; end if;

  select (
    exists(
      select 1 from private.pass_email_outbox
      where status in ('queued','failed') and available_at<=now() and attempts<5
    )
    or exists(
      select 1 from private.fee_notice_outbox
      where status in ('queued','failed') and available_at<=now() and attempts<5
    )
  ) into v_has_work;

  if not v_has_work then return null; end if;

  select decrypted_secret into v_url
  from vault.decrypted_secrets where name='amfcc_project_url' limit 1;
  select decrypted_secret into v_key
  from vault.decrypted_secrets where name='amfcc_publishable_key' limit 1;

  if nullif(v_url,'') is null or nullif(v_key,'') is null then return null; end if;

  select net.http_post(
    url=>v_url||'/functions/v1/pass-email-worker',
    headers=>jsonb_build_object(
      'Content-Type','application/json',
      'apikey',v_key,
      'Authorization','Bearer '||v_key
    ),
    body=>jsonb_build_object('action','drain'),
    timeout_milliseconds=>10000
  ) into v_request_id;

  return v_request_id;
end
$function$
;

CREATE OR REPLACE FUNCTION private.pass_normalize_email_list(p_emails text[])
 RETURNS text[]
 LANGUAGE sql
 IMMUTABLE
 SET search_path TO 'pg_catalog'
AS $function$
  select coalesce(array_agg(q.email order by q.email),'{}'::text[])
  from (
    select distinct lower(trim(value)) as email
    from unnest(coalesce(p_emails,'{}'::text[])) as e(value)
    where nullif(trim(value),'') is not null
  ) q
$function$
;

CREATE OR REPLACE FUNCTION private.pass_queue_email(p_pass_id uuid, p_event_type text)
 RETURNS integer
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_settings private.pass_email_settings%rowtype;
  v_pass public.gate_passes%rowtype;
  v_student public.students%rowtype;
  v_contact private.pass_requester_contacts%rowtype;
  v_recipient record;
  v_people jsonb;
  v_payload jsonb;
  v_event_label text;
  v_subject text;
  v_event_key uuid:=gen_random_uuid();
  v_count integer:=0;
begin
  if p_event_type not in ('submitted','pending','approved','rejected','cancelled','expired') then
    return 0;
  end if;

  select * into v_settings from private.pass_email_settings where singleton=true;
  if not found or not v_settings.enabled then return 0; end if;

  select * into v_pass from public.gate_passes where id=p_pass_id;
  if not found then return 0; end if;

  select * into v_student from public.students where id=v_pass.student_id;
  select * into v_contact from private.pass_requester_contacts where pass_id=p_pass_id;

  select coalesce(jsonb_agg(jsonb_build_object(
    'name',s.full_name,'registration_number',s.registration_number,'is_primary',gm.is_primary
  ) order by gm.is_primary desc,s.full_name),'[]'::jsonb)
  into v_people
  from public.gate_pass_members gm
  join public.students s on s.id=gm.student_id
  where gm.pass_id=p_pass_id;

  v_event_label:=case p_event_type
    when 'submitted' then 'Request received'
    when 'pending' then 'Pending review'
    when 'approved' then 'Approved'
    when 'rejected' then 'Rejected'
    when 'cancelled' then 'Cancelled'
    when 'expired' then 'Overdue or expired'
  end;
  v_subject:='AMFCC Gate Pass: '||v_event_label||' - '||coalesce(v_student.full_name,'Student');
  v_payload:=jsonb_build_object(
    'pass_id',v_pass.id,'event_type',p_event_type,'event_label',v_event_label,'status',v_pass.status,
    'student_name',v_student.full_name,'registration_number',v_student.registration_number,
    'destination',v_pass.destination,'reason',v_pass.reason,'contact_details',v_pass.contact_details,
    'departure_at',v_pass.departure_at,'expected_return_at',v_pass.expected_return_at,
    'actual_departure_at',v_pass.actual_departure_at,'actual_return_at',v_pass.actual_return_at,
    'cancellation_reason',v_pass.cancellation_reason,'people',v_people
  );

  for v_recipient in
    select lower(trim(r.email)) as email,min(r.recipient_group) as recipient_group
    from (
      select unnest(v_settings.admin_emails) as email,'administrator'::text as recipient_group
      union all select unnest(v_settings.management_emails),'management'::text
      union all select unnest(v_settings.student_leadership_emails),'student_leadership'::text
      union all select v_contact.requester_email,'student'::text
    ) r
    where nullif(trim(r.email),'') is not null
      and r.email ~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'
      and (
        (p_event_type in ('submitted','pending') and r.recipient_group in ('administrator','management'))
        or (p_event_type='submitted' and r.recipient_group='student')
        or (p_event_type in ('approved','rejected','cancelled','expired')
            and r.recipient_group in ('student_leadership','student'))
      )
    group by lower(trim(r.email))
  loop
    insert into private.pass_email_outbox(event_key,pass_id,event_type,recipient_group,recipient_email,subject,payload)
    values(v_event_key,p_pass_id,p_event_type,v_recipient.recipient_group,v_recipient.email,v_subject,v_payload)
    on conflict(event_key,recipient_email) do nothing;
    if found then v_count:=v_count+1; end if;
  end loop;

  return v_count;
end
$function$
;

CREATE OR REPLACE FUNCTION private.pass_queue_status_email()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
begin
  if old.status is distinct from new.status then
    perform private.pass_queue_email(new.id,new.status);
  end if;
  return new;
end
$function$
;

CREATE OR REPLACE FUNCTION private.queue_fee_notices(p_registration_ids uuid[], p_actor_role text, p_actor_name text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_row record;
  v_queued integer := 0;
  v_requested integer := coalesce(cardinality(p_registration_ids),0);
  v_skipped jsonb := '[]'::jsonb;
  v_email text;
  v_outbox_id uuid;
begin
  if v_requested = 0 then
    return jsonb_build_object('status','invalid','message','Select at least one student.','queued',0,'requested',0,'skipped','[]'::jsonb);
  end if;

  for v_row in
    with ids as (
      select distinct unnest(p_registration_ids) as id
    )
    select tr.id as registration_id,tr.student_id,tr.term_id,tr.student_name_snapshot,
           tr.registration_number_snapshot,tr.student_answers,
           fs.fees_paid,fs.outstanding_balance,fs.notice_text
    from ids
    join public.term_registrations tr on tr.id=ids.id
    left join public.student_term_fee_status fs on fs.student_id=tr.student_id and fs.term_id=tr.term_id
  loop
    v_email := lower(btrim(coalesce(v_row.student_answers->>'student_email','')));

    if coalesce(v_row.fees_paid,false) or coalesce(v_row.outstanding_balance,0) <= 0 then
      v_skipped := v_skipped || jsonb_build_array(jsonb_build_object(
        'registration_id',v_row.registration_id,'registration_number',v_row.registration_number_snapshot,
        'student_name',v_row.student_name_snapshot,'reason','fully_paid'
      ));
      continue;
    end if;

    if nullif(btrim(coalesce(v_row.notice_text,'')),'') is null then
      v_skipped := v_skipped || jsonb_build_array(jsonb_build_object(
        'registration_id',v_row.registration_id,'registration_number',v_row.registration_number_snapshot,
        'student_name',v_row.student_name_snapshot,'reason','no_notice'
      ));
      continue;
    end if;

    if v_email = '' or v_email !~ '^[^[:space:]@]+@[^[:space:]@]+[.][^[:space:]@]+$' then
      v_skipped := v_skipped || jsonb_build_array(jsonb_build_object(
        'registration_id',v_row.registration_id,'registration_number',v_row.registration_number_snapshot,
        'student_name',v_row.student_name_snapshot,'reason','no_registration_email'
      ));
      continue;
    end if;

    insert into private.fee_notice_outbox(
      registration_id,student_id,term_id,recipient_email,subject,notice_text,
      student_name,registration_number,outstanding_balance,is_test,requested_by_role,requested_by_name
    ) values (
      v_row.registration_id,v_row.student_id,v_row.term_id,v_email,
      'AMFCC fee notice - ' || v_row.student_name_snapshot,
      v_row.notice_text,v_row.student_name_snapshot,v_row.registration_number_snapshot,
      v_row.outstanding_balance,false,left(coalesce(p_actor_role,'admin'),80),nullif(left(btrim(coalesce(p_actor_name,'')),160),'')
    )
    returning id into v_outbox_id;

    update public.student_term_fee_status
    set notice_last_queued_at=now(),
        notice_last_recipient=v_email,
        notice_last_delivery_status='queued',
        notice_last_error=null,
        updated_at=now()
    where student_id=v_row.student_id and term_id=v_row.term_id;

    insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
    values(
      'fees','student',v_row.student_id,left(coalesce(p_actor_role,'admin'),80),'fee_notice_queued',
      jsonb_build_object('registration_id',v_row.registration_id,'registration_number',v_row.registration_number_snapshot,
                         'term_id',v_row.term_id,'recipient',v_email,'outbox_id',v_outbox_id)
    );

    v_queued := v_queued + 1;
  end loop;

  return jsonb_build_object(
    'status','success','requested',v_requested,'queued',v_queued,
    'skipped',v_skipped,
    'message',format('%s fee notice%s queued.',v_queued,case when v_queued=1 then '' else 's' end)
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION private.registration_session_context(p_token text, p_write boolean DEFAULT false)
 RETURNS text
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_role text;
begin
  select c.role_key into v_role
  from private.system_session_context(p_token,array['administrator','it_admin','admin_staff','management']) c
  limit 1;
  if v_role is null then raise exception 'Your Administration session has expired.' using errcode='28000'; end if;
  if p_write and v_role='management' then raise exception 'Management access is read-only.' using errcode='42501'; end if;
  return v_role;
end
$function$
;

CREATE OR REPLACE FUNCTION private.school_operating_mode()
 RETURNS text
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select case
    when lower(coalesce((select setting_value #>> '{}'
                         from public.system_settings
                         where setting_key='school_operating_mode'),'normal'))='holiday'
    then 'holiday'
    when coalesce((select (setting_value #>> '{}')::boolean
                   from public.system_settings
                   where setting_key='school_holiday_mode'),false)
    then 'holiday'
    else 'normal'
  end
$function$
;

CREATE OR REPLACE FUNCTION private.set_meal_features(p_check_in_enabled boolean, p_collection_enabled boolean, p_actor_role text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
begin
  insert into public.system_settings(setting_key,setting_value,updated_at)
  values ('meal_check_in_enabled',to_jsonb(coalesce(p_check_in_enabled,false)),now()),
         ('meal_collection_enabled',to_jsonb(coalesce(p_collection_enabled,false)),now())
  on conflict(setting_key) do update set setting_value=excluded.setting_value,updated_at=excluded.updated_at;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('settings','meal_service','meal_features',p_actor_role,'updated',jsonb_build_object(
    'meal_check_in_enabled',coalesce(p_check_in_enabled,false),'meal_collection_enabled',coalesce(p_collection_enabled,false),'actor_name',nullif(btrim(coalesce(p_actor_name,'')),'')));
  return jsonb_build_object('status','success','meal_check_in_enabled',coalesce(p_check_in_enabled,false),'meal_collection_enabled',coalesce(p_collection_enabled,false));
end
$function$
;

CREATE OR REPLACE FUNCTION private.system_access_matches(p_allowed_roles text[], p_pin text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
  select private.system_access_role(p_pin,p_allowed_roles) is not null
$function$
;

CREATE OR REPLACE FUNCTION private.system_access_role(p_pin text, p_allowed_roles text[] DEFAULT NULL::text[])
 RETURNS text
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'private', 'extensions', 'pg_catalog'
AS $function$
declare
  v_role text;
  v_ops_token text;
begin
  -- The browser sends an already-authenticated Operations token with an
  -- explicit prefix. Four-digit PINs continue through the bcrypt path below.
  if left(coalesce(p_pin,''),4)='ops:' then
    v_ops_token:=substr(p_pin,5);
    if length(v_ops_token)<32 then return null; end if;

    select s.actor_role into v_role
    from public.ops_access_sessions s
    where s.token_hash=private.ops_hash_token(v_ops_token)
      and s.revoked_at is null
      and s.expires_at>now()
      and s.actor_role in ('student_leadership','management','administrator')
      and (p_allowed_roles is null or s.actor_role=any(p_allowed_roles))
    limit 1;
    return v_role;
  end if;

  select c.role_key into v_role
  from public.system_access_credentials c
  where c.active
    and c.access_hash is not null
    and (c.locked_until is null or c.locked_until<=now())
    and (p_allowed_roles is null or c.role_key=any(p_allowed_roles))
    and c.access_hash=extensions.crypt(coalesce(p_pin,''),c.access_hash)
  order by case c.role_key
    when 'it_admin' then 1
    when 'administrator' then 2
    when 'management' then 3
    when 'student_leadership' then 4
    when 'library_staff' then 5
    else 100 end
  limit 1;
  return v_role;
end
$function$
;

CREATE OR REPLACE FUNCTION private.system_session_context(p_token text, p_allowed_roles text[] DEFAULT NULL::text[])
 RETURNS TABLE(role_key text, must_change_pin boolean)
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'extensions', 'pg_catalog'
AS $function$
declare
  v_hash text:=encode(extensions.digest(coalesce(p_token,''),'sha256'),'hex');
begin
  return query
  select s.role_key,c.must_change_pin
  from public.system_access_sessions s
  join public.system_access_credentials c on c.role_key=s.role_key and c.active
  where s.token_hash=v_hash
    and s.revoked_at is null
    and s.expires_at>now()
    and (p_allowed_roles is null or s.role_key=any(p_allowed_roles))
  limit 1;

  if found then
    update public.system_access_sessions set last_seen_at=now()
    where token_hash=v_hash;
    return;
  end if;

  -- School Administration may use its Operations login for administrator
  -- settings. The role filter prevents it from reaching IT-only PIN controls.
  return query
  update public.ops_access_sessions s
  set last_seen_at=now()
  where s.token_hash=private.ops_hash_token(coalesce(p_token,''))
    and s.revoked_at is null
    and s.expires_at>now()
    and s.actor_role in ('student_leadership','management','administrator')
    and (p_allowed_roles is null or s.actor_role=any(p_allowed_roles))
  returning s.actor_role,false;
end
$function$
;

CREATE OR REPLACE FUNCTION private.system_store_recoverable_pin(p_target_type text, p_target_key text, p_pin text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'private', 'vault', 'extensions', 'pg_catalog'
AS $function$
declare v_key text;
begin
  select decrypted_secret into v_key from vault.decrypted_secrets
  where name='amfcc_pin_recovery_key' limit 1;
  if nullif(v_key,'') is null then raise exception 'PIN recovery key is unavailable.'; end if;
  insert into private.system_pin_recovery(target_type,target_key,encrypted_pin,updated_at)
  values(p_target_type,p_target_key,extensions.pgp_sym_encrypt(p_pin,v_key,'cipher-algo=aes256'),now())
  on conflict(target_type,target_key) do update set encrypted_pin=excluded.encrypted_pin,updated_at=now();
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_accommodation_list(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_actor text:=private.tr_actor_from_pin(p_pin); v_term public.academic_terms%rowtype; v_rows jsonb;
begin
  if v_actor is null then return jsonb_build_object('status','unauthorized','message','Existing staff access required.'); end if;
  if p_term_id is null then select * into v_term from public.academic_terms order by registration_is_open desc,is_current desc,academic_year desc,term_number desc limit 1;
  else select * into v_term from public.academic_terms where id=p_term_id; end if;
  if not found then return jsonb_build_object('status','not_found','message','Academic term not found.'); end if;
  select coalesce(jsonb_agg(jsonb_build_object(
    'id',tr.id,'student_name',tr.student_name_snapshot,'registration_number',tr.registration_number_snapshot,
    'class_year',tr.class_year_snapshot,'campus_status',private.tr_current_campus_status(tr.student_id),
    'accommodation_mode',tr.accommodation_mode,'residence',tr.accommodation_residence,'room',tr.accommodation_room,
    'bed',tr.accommodation_bed,'accommodation_answers',tr.accommodation_answers,
    'accommodation_complete',tr.accommodation_complete,'registration_status',tr.status,
    'status_label',private.tr_status_label(tr.status)) order by tr.student_name_snapshot),'[]'::jsonb)
  into v_rows from public.term_registrations tr where tr.term_id=v_term.id;
  return jsonb_build_object('status','success','access_level',v_actor,
    'term',jsonb_build_object('id',v_term.id,'term_name',v_term.term_name,'academic_year',v_term.academic_year,'registration_is_open',v_term.registration_is_open),
    'registrations',v_rows);
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_actor_from_pin(p_pin text)
 RETURNS text
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_role text;
begin
  v_role:=private.system_access_role(p_pin,array['it_admin','administrator','management','student_leadership']);
  if v_role='it_admin' then return 'administrator'; end if;
  return v_role;
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_dashboard(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_actor text:=private.tr_actor_from_pin(p_pin);
  v_term public.academic_terms%rowtype;
  v_terms jsonb;
  v_rows jsonb;
  v_summary jsonb;
begin
  if v_actor<>'administrator' then
    return jsonb_build_object('status','unauthorized','message','School Administration access required.');
  end if;

  if p_term_id is null then
    select * into v_term
    from public.academic_terms
    order by registration_is_open desc,is_current desc,academic_year desc,term_number desc
    limit 1;
  else
    select * into v_term
    from public.academic_terms
    where id=p_term_id;
  end if;

  if not found then
    return jsonb_build_object('status','not_found','message','No academic term is configured.');
  end if;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id',t.id,
    'academic_year',t.academic_year,
    'term_number',t.term_number,
    'term_name',t.term_name,
    'fees_due_date',t.fees_due_date,
    'is_current',t.is_current,
    'registration_is_open',t.registration_is_open,
    'form_configured',coalesce((t.registration_form_schema->>'configured')::boolean,false),
    'expected',(select count(*) from public.term_registrations r where r.term_id=t.id),
    'started',(select count(*) from public.term_registrations r where r.term_id=t.id and r.student_started_at is not null),
    'submitted',(select count(*) from public.term_registrations r where r.term_id=t.id and r.student_submitted_at is not null),
    'completed',(select count(*) from public.term_registrations r where r.term_id=t.id and r.completed_at is not null)
  ) order by t.academic_year desc,t.term_number desc),'[]'::jsonb)
  into v_terms
  from public.academic_terms t;

  select jsonb_build_object(
    'expected',count(*),
    'not_started',count(*) filter(where status='not_started'),
    'started',count(*) filter(where status='started'),
    'returned',count(*) filter(where status='returned'),
    'submitted',count(*) filter(where student_submitted_at is not null),
    'waiting_admin',count(*) filter(where status='student_submitted' and not admin_office_complete),
    'waiting_fees',count(*) filter(where student_submitted_at is not null and admin_office_complete and not fees_complete),
    'waiting_accommodation',count(*) filter(where status='waiting_accommodation' or (student_submitted_at is not null and admin_office_complete and fees_complete and not accommodation_complete)),
    'ready_final',count(*) filter(where status='ready_final'),
    'completed',count(*) filter(where status='completed' or completed_at is not null)
  )
  into v_summary
  from public.term_registrations
  where term_id=v_term.id;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id',tr.id,
    'student_name',tr.student_name_snapshot,
    'registration_number',tr.registration_number_snapshot,
    'class_year',tr.class_year_snapshot,
    'campus_status',private.tr_current_campus_status(tr.student_id),
    'status',tr.status,
    'status_label',private.tr_status_label(tr.status),
    'stage',
      case
        when tr.completed_at is not null or tr.status='completed' then 'completed'
        when tr.status='not_started' then 'student_not_started'
        when tr.status='started' then 'student_form'
        when tr.status='returned' then 'returned_to_student'
        when not tr.admin_office_complete then 'administrators_office'
        when not tr.fees_complete then 'fees'
        when tr.status='waiting_accommodation' or not tr.accommodation_complete then 'accommodation'
        when tr.status='ready_final' then 'final_administration'
        else 'final_administration'
      end,
    'stage_label',
      case
        when tr.completed_at is not null or tr.status='completed' then 'Completed'
        when tr.status='not_started' then 'Student has not started'
        when tr.status='started' then 'Student completing form'
        when tr.status='returned' then 'Returned to student'
        when not tr.admin_office_complete then 'Administrator''s Office review'
        when not tr.fees_complete then 'Fees review'
        when tr.status='waiting_accommodation' or not tr.accommodation_complete then 'Accommodation'
        when tr.status='ready_final' then 'Final administration'
        else 'Final administration'
      end,
    'student_started_at',tr.student_started_at,
    'student_submitted_at',tr.student_submitted_at,
    'admin_office_complete',tr.admin_office_complete,
    'fees_complete',tr.fees_complete,
    'accommodation_mode',tr.accommodation_mode,
    'accommodation_residence',tr.accommodation_residence,
    'accommodation_room',tr.accommodation_room,
    'accommodation_complete',tr.accommodation_complete,
    'completed_at',tr.completed_at,
    'updated_at',tr.updated_at
  ) order by tr.student_name_snapshot),'[]'::jsonb)
  into v_rows
  from public.term_registrations tr
  where tr.term_id=v_term.id;

  return jsonb_build_object(
    'status','success',
    'selected_term',jsonb_build_object(
      'id',v_term.id,
      'academic_year',v_term.academic_year,
      'term_number',v_term.term_number,
      'term_name',v_term.term_name,
      'fees_due_date',v_term.fees_due_date,
      'registration_is_open',v_term.registration_is_open,
      'form_configured',coalesce((v_term.registration_form_schema->>'configured')::boolean,false),
      'form_schema',v_term.registration_form_schema
    ),
    'terms',v_terms,
    'summary',v_summary,
    'registrations',v_rows
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_export(p_pin text, p_term_id bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_term public.academic_terms%rowtype; v_rows jsonb; begin if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if; select * into v_term from public.academic_terms where id=p_term_id; if not found then return jsonb_build_object('status','not_found','message','Academic term not found.'); end if; select coalesce(jsonb_agg(jsonb_build_object('Registration Number',tr.registration_number_snapshot,'Student Name',tr.student_name_snapshot,'Class Year',tr.class_year_snapshot,'Status',private.tr_status_label(tr.status),'Student Submitted',tr.student_submitted_at,'Admin Office Complete',tr.admin_office_complete,'Fees Complete',tr.fees_complete,'Accommodation',case when tr.accommodation_mode='off_campus' then 'Off campus' else coalesce(tr.accommodation_residence,'') end,'Room',coalesce(tr.accommodation_room,''),'Accommodation Complete',tr.accommodation_complete,'Registration Completed',tr.completed_at,'Completed By Role',coalesce(tr.completed_by_role,'')) order by tr.student_name_snapshot),'[]'::jsonb) into v_rows from public.term_registrations tr where tr.term_id=p_term_id; return jsonb_build_object('status','success','term_name',v_term.term_name,'rows',v_rows); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_finalize(p_pin text, p_registration_id uuid, p_final_answers jsonb, p_staff_note text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_reg public.term_registrations%rowtype; v_term public.academic_terms%rowtype; v_final jsonb; v_missing jsonb; v_before jsonb; begin if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if; select * into v_reg from public.term_registrations where id=p_registration_id for update; if not found then return jsonb_build_object('status','not_found','message','Registration not found.'); end if; if v_reg.completed_at is not null then return jsonb_build_object('status','locked','message','This registration is already complete.'); end if; if v_reg.student_submitted_at is null or not v_reg.admin_office_complete or not v_reg.fees_complete or not v_reg.accommodation_complete then return jsonb_build_object('status','not_ready','message','Complete the Student, Admin Office, Fees and Accommodation sections first.'); end if; select * into v_term from public.academic_terms where id=v_reg.term_id; v_final:=private.tr_filter_answers(v_term.registration_form_schema->'final',coalesce(p_final_answers,'{}'::jsonb)); v_missing:=private.tr_missing_required(v_term.registration_form_schema->'final',v_final); if jsonb_array_length(v_missing)>0 then return jsonb_build_object('status','missing','message','Complete all required final check fields.','missing',v_missing); end if; v_before:=jsonb_build_object('final_answers',v_reg.final_answers,'status',v_reg.status,'staff_note',v_reg.staff_note); update public.term_registrations set final_answers=v_final,staff_note=coalesce(nullif(trim(coalesce(p_staff_note,'')),''),staff_note),completed_at=now(),completed_by_role='administrator',student_locked=true,status='completed',updated_at=now() where id=v_reg.id; perform private.tr_write_history(v_reg.id,'administrator','registration_completed','final',v_before,jsonb_build_object('final_answers',v_final,'status','completed','completed_at',now()),p_staff_note); insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details) values('term_registration','term_registration',v_reg.id::text,'administrator','registration_completed',jsonb_build_object('student_id',v_reg.student_id,'term_id',v_reg.term_id,'registration_number',v_reg.registration_number_snapshot)); return jsonb_build_object('status','success','message','Registration complete.','status_label','Registration complete','completed_at',now()); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_get(p_pin text, p_registration_id uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_reg public.term_registrations%rowtype; v_term public.academic_terms%rowtype; v_fee public.student_term_fee_status%rowtype; v_history jsonb; begin if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if; select * into v_reg from public.term_registrations where id=p_registration_id; if not found then return jsonb_build_object('status','not_found','message','Registration not found.'); end if; select * into v_term from public.academic_terms where id=v_reg.term_id; select * into v_fee from public.student_term_fee_status where student_id=v_reg.student_id and term_id=v_reg.term_id; select coalesce(jsonb_agg(jsonb_build_object('changed_at',h.changed_at,'actor_role',h.actor_role,'action',h.action,'section',h.section,'note',h.note) order by h.changed_at desc),'[]'::jsonb) into v_history from public.term_registration_history h where h.registration_id=v_reg.id; return jsonb_build_object('status','success','term',jsonb_build_object('id',v_term.id,'term_name',v_term.term_name,'academic_year',v_term.academic_year,'form_schema',v_term.registration_form_schema),'registration',to_jsonb(v_reg)||jsonb_build_object('status_label',private.tr_status_label(v_reg.status),'campus_status',private.tr_current_campus_status(v_reg.student_id)),'fees_paid',coalesce(v_fee.fees_paid,false),'fee_notes',v_fee.notes,'history',v_history); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_manage_term(p_pin text, p_academic_year integer, p_term_number integer, p_action text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_actor text:=private.tr_actor_from_pin(p_pin);
  v_term public.academic_terms%rowtype;
  v_due date;
  v_count int;
  v_student public.students%rowtype;
begin
  if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if;
  if p_academic_year not between 2020 and 2100 or p_term_number not between 1 and 3 then return jsonb_build_object('status','invalid','message','Choose a valid year and Term 1, 2 or 3.'); end if;
  v_due:=make_date(p_academic_year,case p_term_number when 1 then 1 when 2 then 5 else 9 end,case p_term_number when 1 then 15 when 2 then 5 else 5 end);
  insert into public.academic_terms(academic_year,term_number,term_name,fees_due_date,is_current,registration_form_schema)
  values(p_academic_year,p_term_number,format('Term %s %s',p_term_number,p_academic_year),v_due,false,private.tr_default_form_schema())
  on conflict(academic_year,term_number) do update set term_name=excluded.term_name,updated_at=now()
  returning * into v_term;
  if not coalesce((v_term.registration_form_schema->>'configured')::boolean,false) then
    update public.academic_terms set registration_form_schema=private.tr_default_form_schema(),updated_at=now() where id=v_term.id returning * into v_term;
  end if;
  if lower(p_action)='open' then
    update public.academic_terms set registration_is_open=false,registration_closed_at=case when registration_is_open then now() else registration_closed_at end,registration_updated_by_role=case when registration_is_open then 'administrator' else registration_updated_by_role end,updated_at=now() where id<>v_term.id and registration_is_open=true;
    update public.academic_terms set is_current=false,updated_at=now() where id<>v_term.id and is_current=true;
    update public.academic_terms set registration_is_open=true,registration_opened_at=coalesce(registration_opened_at,now()),registration_closed_at=null,registration_updated_by_role='administrator',is_current=true,updated_at=now() where id=v_term.id returning * into v_term;
  elsif lower(p_action)='close' then
    update public.academic_terms set registration_is_open=false,registration_closed_at=now(),registration_updated_by_role='administrator',updated_at=now() where id=v_term.id returning * into v_term;
  elsif lower(p_action) not in('create','refresh_expected') then
    return jsonb_build_object('status','invalid','message','Choose Create, Open, Close or Refresh expected students.');
  end if;
  if lower(p_action) in('open','refresh_expected') then
    for v_student in select * from public.students where is_active=true order by full_name loop
      perform private.tr_seed_registration(v_student,v_term);
    end loop;
  end if;
  select count(*) into v_count from public.term_registrations where term_id=v_term.id;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('term_registration','academic_term',v_term.id::text,'administrator','registration_term_'||lower(p_action),jsonb_build_object('term_name',v_term.term_name,'expected_students',v_count));
  return jsonb_build_object('status','success','term_id',v_term.id,'term_name',v_term.term_name,'registration_is_open',v_term.registration_is_open,'expected_students',v_count);
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_reopen(p_pin text, p_registration_id uuid, p_reason text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_reg public.term_registrations%rowtype; v_status text; begin if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if; if length(trim(coalesce(p_reason,'')))<3 then return jsonb_build_object('status','invalid','message','Add a short reason for reopening the registration.'); end if; select * into v_reg from public.term_registrations where id=p_registration_id for update; if not found then return jsonb_build_object('status','not_found','message','Registration not found.'); end if; if v_reg.completed_at is null then return jsonb_build_object('status','invalid','message','This registration is not complete.'); end if; update public.term_registrations set completed_at=null,completed_by_role=null,reopened_at=now(),reopened_by_role='administrator',reopen_reason=trim(p_reason),student_locked=true,updated_at=now() where id=v_reg.id; v_status:=private.tr_recalculate(v_reg.id); perform private.tr_write_history(v_reg.id,'administrator','registration_reopened','final',jsonb_build_object('status','completed'),jsonb_build_object('status',v_status),p_reason); insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details) values('term_registration','term_registration',v_reg.id::text,'administrator','registration_reopened',jsonb_build_object('reason',p_reason,'term_id',v_reg.term_id)); return jsonb_build_object('status','success','message','Registration reopened for Admin correction.','registration_status',v_status,'status_label',private.tr_status_label(v_status)); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_reset_student_access(p_pin text, p_registration_id uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_reg public.term_registrations%rowtype; begin if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if; select * into v_reg from public.term_registrations where id=p_registration_id for update; if not found then return jsonb_build_object('status','not_found','message','Registration not found.'); end if; if v_reg.student_submitted_at is not null then return jsonb_build_object('status','locked','message','Student access cannot be reset after submission.'); end if; update public.term_registrations set resume_token_hash=null,updated_at=now() where id=v_reg.id; perform private.tr_write_history(v_reg.id,'administrator','student_resume_access_reset','student',null,null,'Student may continue from a new browser.'); return jsonb_build_object('status','success','message','Student can now continue from a new browser.'); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_save_office_fees(p_pin text, p_registration_id uuid, p_admin_answers jsonb, p_admin_complete boolean, p_fees_answers jsonb, p_fees_complete boolean, p_fees_paid boolean, p_staff_note text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_reg public.term_registrations%rowtype; v_term public.academic_terms%rowtype; v_admin jsonb; v_fees jsonb; v_before jsonb; v_missing jsonb; v_status text; begin if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if; select * into v_reg from public.term_registrations where id=p_registration_id for update; if not found then return jsonb_build_object('status','not_found','message','Registration not found.'); end if; if v_reg.student_submitted_at is null then return jsonb_build_object('status','invalid','message','The student must submit their section first.'); end if; select * into v_term from public.academic_terms where id=v_reg.term_id; v_admin:=private.tr_filter_answers(v_term.registration_form_schema->'admin',coalesce(p_admin_answers,'{}'::jsonb)); v_fees:=private.tr_filter_answers(v_term.registration_form_schema->'fees',coalesce(p_fees_answers,'{}'::jsonb)); if coalesce(p_admin_complete,false) then v_missing:=private.tr_missing_required(v_term.registration_form_schema->'admin',v_admin); if jsonb_array_length(v_missing)>0 then return jsonb_build_object('status','missing','message','Complete all required Admin Office fields.','missing',v_missing); end if; end if; if coalesce(p_fees_complete,false) then v_missing:=private.tr_missing_required(v_term.registration_form_schema->'fees',v_fees); if jsonb_array_length(v_missing)>0 then return jsonb_build_object('status','missing','message','Complete all required Fees fields.','missing',v_missing); end if; end if; v_before:=jsonb_build_object('admin_answers',v_reg.admin_answers,'fees_answers',v_reg.fees_answers,'admin_complete',v_reg.admin_office_complete,'fees_complete',v_reg.fees_complete,'staff_note',v_reg.staff_note); update public.term_registrations set admin_answers=v_admin,fees_answers=v_fees,admin_office_complete=coalesce(p_admin_complete,false),admin_office_completed_at=case when p_admin_complete then coalesce(admin_office_completed_at,now()) else null end,admin_office_completed_by_role=case when p_admin_complete then 'administrator' else null end,fees_complete=coalesce(p_fees_complete,false),fees_completed_at=case when p_fees_complete then coalesce(fees_completed_at,now()) else null end,fees_completed_by_role=case when p_fees_complete then 'administrator' else null end,staff_note=nullif(trim(coalesce(p_staff_note,'')),''),updated_at=now() where id=v_reg.id; insert into public.student_term_fee_status(student_id,term_id,fees_paid,notes,updated_by_role,updated_at) values(v_reg.student_id,v_reg.term_id,coalesce(p_fees_paid,false),nullif(trim(coalesce(p_staff_note,'')),''),'administrator',now()) on conflict(student_id,term_id) do update set fees_paid=excluded.fees_paid,notes=excluded.notes,updated_by_role='administrator',updated_at=now(); v_status:=private.tr_recalculate(v_reg.id); perform private.tr_write_history(v_reg.id,'administrator','admin_and_fees_saved','admin_fees',v_before,jsonb_build_object('admin_answers',v_admin,'fees_answers',v_fees,'admin_complete',p_admin_complete,'fees_complete',p_fees_complete,'fees_paid',p_fees_paid,'staff_note',p_staff_note),p_staff_note); return jsonb_build_object('status','success','message','Admin Office and Fees saved.','registration_status',v_status,'status_label',private.tr_status_label(v_status)); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_admin_set_form_schema(p_pin text, p_term_id bigint, p_form_schema jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_term public.academic_terms%rowtype; v_started int; begin if v_actor<>'administrator' then return jsonb_build_object('status','unauthorized','message','School Administration access required.'); end if; if jsonb_typeof(coalesce(p_form_schema,'{}'::jsonb))<>'object' or jsonb_typeof(coalesce(p_form_schema->'student','[]'::jsonb))<>'array' or jsonb_typeof(coalesce(p_form_schema->'admin','[]'::jsonb))<>'array' or jsonb_typeof(coalesce(p_form_schema->'fees','[]'::jsonb))<>'array' or jsonb_typeof(coalesce(p_form_schema->'final','[]'::jsonb))<>'array' then return jsonb_build_object('status','invalid','message','The registration form definition is not valid.'); end if; select * into v_term from public.academic_terms where id=p_term_id for update; if not found then return jsonb_build_object('status','not_found','message','Academic term not found.'); end if; select count(*) into v_started from public.term_registrations where term_id=p_term_id and student_started_at is not null; if v_started>0 then return jsonb_build_object('status','locked','message','Form fields cannot be changed after students have started this term.'); end if; update public.academic_terms set registration_form_schema=(p_form_schema||jsonb_build_object('configured',true)),updated_at=now(),registration_updated_by_role='administrator' where id=p_term_id; insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details) values('term_registration','academic_term',p_term_id::text,'administrator','registration_form_configured',jsonb_build_object('student_fields',jsonb_array_length(p_form_schema->'student'),'admin_fields',jsonb_array_length(p_form_schema->'admin'),'fees_fields',jsonb_array_length(p_form_schema->'fees'),'final_fields',jsonb_array_length(p_form_schema->'final'))); return jsonb_build_object('status','success','message','Registration form fields saved.','term_id',p_term_id); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_class_year(p_registration bigint, p_academic_year integer)
 RETURNS integer
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $function$
  select public._student_year_number(p_registration,p_academic_year)
$function$
;

CREATE OR REPLACE FUNCTION private.tr_current_campus_status(p_student_id text)
 RETURNS text
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$ select coalesce((select cm.direction from public.campus_movements cm where cm.student_id=p_student_id order by cm.scanned_at desc,cm.id desc limit 1),'UNKNOWN') $function$
;

CREATE OR REPLACE FUNCTION private.tr_default_form_schema()
 RETURNS jsonb
 LANGUAGE sql
 IMMUTABLE
 SET search_path TO 'pg_catalog'
AS $function$
select jsonb_build_object(
  'configured',true,
  'student',jsonb_build_array(
    jsonb_build_object('id','gender','label','Gender','type','select','required',true,'options',jsonb_build_array('Male','Female')),
    jsonb_build_object('id','marital_status','label','Marital status','type','select','required',true,'options',jsonb_build_array('Single','Married','Widowed','Divorced')),
    jsonb_build_object('id','spouse_location','label','If married, where is your spouse?','type','text','required',false,'show_when',jsonb_build_object('field','marital_status','equals','Married')),
    jsonb_build_object('id','identity_number','label','ID number / passport number','type','text','required',true),
    jsonb_build_object('id','student_email','label','Student email','type','email','required',true),
    jsonb_build_object('id','student_phone','label','Student phone number','type','tel','required',true),
    jsonb_build_object('id','sponsor_name','label','Sponsor name','type','text','required',false),
    jsonb_build_object('id','sponsor_contact','label','Sponsor contact number','type','tel','required',false),
    jsonb_build_object('id','accommodation_type','label','Type of accommodation','type','select','required',false,'options',jsonb_build_array('Shared','Married')),
    jsonb_build_object('id','accommodation_hostel','label','Hostel allocated','type','text','required',false,'show_when',jsonb_build_object('field','accommodation_type','equals','Shared')),
    jsonb_build_object('id','accommodation_room','label','Room number','type','text','required',false,'show_when',jsonb_build_object('field','accommodation_type','equals','Shared')),
    jsonb_build_object('id','shared_occupants','label','Number of occupants in room','type','number','required',false,'show_when',jsonb_build_object('field','accommodation_type','equals','Shared'))
  ),
  'admin',jsonb_build_array(
    jsonb_build_object('id','official_date_of_arrival','label','Official date of arrival','type','date','required',true)
  ),
  'fees',jsonb_build_array(
    jsonb_build_object('id','arrears_previous_terms','label','Arrears from previous term(s)','type','number','required',true),
    jsonb_build_object('id','amount_paid_current_term','label','Amount paid for the current term','type','number','required',true),
    jsonb_build_object('id','outstanding_balance','label','Outstanding balance','type','number','required',true),
    jsonb_build_object('id','payment_plan','label','Payment plan','type','textarea','required',false),
    jsonb_build_object('id','fees_certified_by','label','Fees certified by','type','text','required',true)
  ),
  'accommodation',jsonb_build_array(
    jsonb_build_object('id','accommodation_type','label','Type of accommodation','type','select','required',true,'options',jsonb_build_array('Shared','Married')),
    jsonb_build_object('id','accommodation_hostel','label','Hostel allocated','type','text','required',false),
    jsonb_build_object('id','accommodation_room','label','Room number','type','text','required',false),
    jsonb_build_object('id','shared_occupants','label','Number of occupants in room','type','number','required',false),
    jsonb_build_object('id','accommodation_certified_by','label','Accommodation certified by','type','text','required',true)
  ),
  'final',jsonb_build_array(
    jsonb_build_object('id','principal_signature','label','Principal / authorised signatory','type','text','required',false)
  )
)
$function$
;

CREATE OR REPLACE FUNCTION private.tr_filter_answers(p_fields jsonb, p_answers jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 IMMUTABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $function$ declare v_result jsonb:='{}'::jsonb; v_field jsonb; v_id text; begin if jsonb_typeof(coalesce(p_answers,'{}'::jsonb))<>'object' or jsonb_typeof(coalesce(p_fields,'[]'::jsonb))<>'array' then return '{}'::jsonb; end if; for v_field in select value from jsonb_array_elements(p_fields) loop v_id:=nullif(trim(v_field->>'id'),''); if v_id is not null and p_answers?v_id then v_result:=v_result||jsonb_build_object(v_id,p_answers->v_id); end if; end loop; return v_result; end $function$
;

CREATE OR REPLACE FUNCTION private.tr_missing_required(p_fields jsonb, p_answers jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 IMMUTABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $function$ declare v_missing jsonb:='[]'::jsonb; v_field jsonb; v_id text; v_value jsonb; begin if jsonb_typeof(coalesce(p_fields,'[]'::jsonb))<>'array' then return v_missing; end if; for v_field in select value from jsonb_array_elements(p_fields) loop if coalesce((v_field->>'required')::boolean,false) then v_id:=nullif(trim(v_field->>'id'),''); if v_id is not null then v_value:=p_answers->v_id; if v_value is null or v_value='null'::jsonb or(jsonb_typeof(v_value)='string' and btrim(v_value#>>'{}')='')or(jsonb_typeof(v_value)='array' and jsonb_array_length(v_value)=0) then v_missing:=v_missing||jsonb_build_array(jsonb_build_object('id',v_id,'label',coalesce(v_field->>'label',v_id))); end if; end if; end if; end loop; return v_missing; end $function$
;

CREATE OR REPLACE FUNCTION private.tr_new_token()
 RETURNS text
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'extensions'
AS $function$ select encode(extensions.gen_random_bytes(24),'hex') $function$
;

CREATE OR REPLACE FUNCTION private.tr_recalculate(p_registration_id uuid)
 RETURNS text
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$ declare v_status text; begin select case when completed_at is not null then 'completed' when student_submitted_at is null and student_started_at is null then 'not_started' when student_submitted_at is null then 'started' when not admin_office_complete or not fees_complete then 'student_submitted' when not accommodation_complete then 'waiting_accommodation' else 'ready_final' end into v_status from public.term_registrations where id=p_registration_id; update public.term_registrations set status=v_status,updated_at=now() where id=p_registration_id; return v_status; end $function$
;

CREATE OR REPLACE FUNCTION private.tr_seed_registration(p_student students, p_term academic_terms)
 RETURNS term_registrations
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_row public.term_registrations%rowtype; v_res text; v_room text; v_bed text; begin select a.residence,a.room,a.bed into v_res,v_room,v_bed from public.accommodation_allocations a where a.student_id=p_student.id and a.is_active=true order by a.allocated_at desc limit 1; insert into public.term_registrations(student_id,term_id,student_name_snapshot,registration_number_snapshot,class_year_snapshot,accommodation_mode,accommodation_residence,accommodation_room,accommodation_bed) values(p_student.id,p_term.id,p_student.full_name,p_student.registration_number,private.tr_class_year(p_student.registration_number,p_term.academic_year),case when v_res is not null then 'on_campus' else 'unconfirmed' end,v_res,v_room,v_bed) on conflict(student_id,term_id) do update set student_name_snapshot=excluded.student_name_snapshot,registration_number_snapshot=excluded.registration_number_snapshot,class_year_snapshot=excluded.class_year_snapshot,updated_at=now() returning * into v_row; return v_row; end $function$
;

CREATE OR REPLACE FUNCTION private.tr_status_label(p_status text)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $function$
select case p_status
  when 'not_started' then 'Not started'
  when 'started' then 'Started'
  when 'returned' then 'Additional information requested'
  when 'student_submitted' then 'Waiting for Admin Office'
  when 'waiting_accommodation' then 'Waiting for Accommodation'
  when 'ready_final' then 'Ready for final check'
  when 'completed' then 'Registration complete'
  else 'Not started'
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_student_lookup(p_registration_number text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_digits text:=regexp_replace(coalesce(p_registration_number,''),'\D','','g'); v_student public.students%rowtype; v_term public.academic_terms%rowtype; v_reg public.term_registrations%rowtype; begin if v_digits!~'^\d{5}$' then return jsonb_build_object('status','invalid','message','Enter your five-digit registration number.'); end if; select * into v_student from public.students where registration_number::text=v_digits and is_active=true limit 1; if not found then return jsonb_build_object('status','not_found','message','This active student registration number was not found.'); end if; select * into v_term from public.academic_terms where registration_is_open=true order by registration_opened_at desc nulls last,id desc limit 1; if not found then return jsonb_build_object('status','closed','message','Term registration is not open right now.'); end if; select * into v_reg from public.term_registrations where student_id=v_student.id and term_id=v_term.id; if not found then v_reg:=private.tr_seed_registration(v_student,v_term); end if; return jsonb_build_object('status','success','student_name',v_student.full_name,'registration_number',v_student.registration_number,'term_id',v_term.id,'term_name',v_term.term_name,'academic_year',v_term.academic_year,'registration_status',v_reg.status,'status_label',private.tr_status_label(v_reg.status),'has_started',(v_reg.student_started_at is not null),'is_locked',v_reg.student_locked); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_student_save(p_registration_number text, p_resume_token text, p_answers jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_digits text:=regexp_replace(coalesce(p_registration_number,''),'\D','','g');
  v_reg public.term_registrations%rowtype;
  v_term public.academic_terms%rowtype;
  v_filtered jsonb;
  v_before jsonb;
begin
  select tr.* into v_reg
  from public.term_registrations tr
  join public.students s on s.id=tr.student_id
  join public.academic_terms t on t.id=tr.term_id
  where s.registration_number::text=v_digits and s.is_active and t.registration_is_open
  for update of tr;
  if not found then return jsonb_build_object('status','not_found','message','No open enrolment was found.'); end if;
  if v_reg.resume_token_hash is null or private.tr_token_hash(p_resume_token)<>v_reg.resume_token_hash then
    return jsonb_build_object('status','unauthorized','message','Open this enrolment from the browser where you started it.');
  end if;
  if v_reg.student_locked or v_reg.student_submitted_at is not null then
    return jsonb_build_object('status','locked','message','Your form has already been submitted.');
  end if;
  select * into v_term from public.academic_terms where id=v_reg.term_id;
  v_filtered:=private.tr_filter_answers(v_term.registration_form_schema->'student',coalesce(p_answers,'{}'::jsonb));
  if coalesce(v_filtered->>'marital_status','')<>'Married' then v_filtered:=v_filtered-'spouse_location'; end if;
  if coalesce(v_filtered->>'accommodation_type','')<>'Shared' then
    v_filtered:=v_filtered-'accommodation_hostel'-'accommodation_room'-'shared_occupants';
  end if;
  v_before:=v_reg.student_answers;
  update public.term_registrations set student_answers=v_filtered,updated_at=now()
  where id=v_reg.id;
  perform private.tr_write_history(v_reg.id,'student','answers_saved','student',v_before,v_filtered,null);
  return jsonb_build_object('status','success','message','Saved.','student_answers',v_filtered,'status_label',private.tr_status_label(v_reg.status));
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_student_start(p_registration_number text, p_resume_token text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog', 'extensions'
AS $function$
declare
  v_digits text:=regexp_replace(coalesce(p_registration_number,''),'\D','','g');
  v_student public.students%rowtype;
  v_term public.academic_terms%rowtype;
  v_reg public.term_registrations%rowtype;
  v_token text;
begin
  if v_digits!~'^\d{5}$' then return jsonb_build_object('status','invalid','message','Enter your five-digit registration number.'); end if;
  select * into v_student from public.students where registration_number::text=v_digits and is_active=true limit 1;
  if not found then return jsonb_build_object('status','not_found','message','This active student registration number was not found.'); end if;
  select * into v_term from public.academic_terms where registration_is_open=true order by registration_opened_at desc nulls last,id desc limit 1;
  if not found then return jsonb_build_object('status','closed','message','Term registration is not open right now.'); end if;
  select * into v_reg from public.term_registrations where student_id=v_student.id and term_id=v_term.id for update;
  if not found then v_reg:=private.tr_seed_registration(v_student,v_term); end if;
  if v_reg.resume_token_hash is not null then
    if nullif(p_resume_token,'') is null or private.tr_token_hash(p_resume_token)<>v_reg.resume_token_hash then
      return jsonb_build_object('status','resume_token_required','message','This registration was already started on another browser. Please continue on that browser or ask the Admin Office to reset access.','student_name',v_student.full_name,'registration_number',v_student.registration_number,'term_name',v_term.term_name,'status_label',private.tr_status_label(v_reg.status));
    end if;
    return jsonb_build_object('status','success','student_name',v_student.full_name,'registration_number',v_student.registration_number,'term_id',v_term.id,'term_name',v_term.term_name,'form_schema',v_term.registration_form_schema,'student_answers',v_reg.student_answers,'resume_token',p_resume_token,'registration_status',v_reg.status,'status_label',private.tr_status_label(v_reg.status),'is_locked',v_reg.student_locked,'return_reason',v_reg.reopen_reason);
  end if;
  if v_reg.student_locked then
    return jsonb_build_object('status','locked','message','This registration has already been submitted and cannot be changed by the student.','student_name',v_student.full_name,'registration_number',v_student.registration_number,'term_name',v_term.term_name,'status_label',private.tr_status_label(v_reg.status));
  end if;
  v_token:=private.tr_new_token();
  update public.term_registrations set resume_token_hash=private.tr_token_hash(v_token),student_started_at=coalesce(student_started_at,now()),status=case when status='returned' then 'returned' else 'started' end,updated_at=now() where id=v_reg.id returning * into v_reg;
  perform private.tr_write_history(v_reg.id,'student','registration_started','student',null,null,null);
  return jsonb_build_object('status','success','student_name',v_student.full_name,'registration_number',v_student.registration_number,'term_id',v_term.id,'term_name',v_term.term_name,'form_schema',v_term.registration_form_schema,'student_answers',v_reg.student_answers,'resume_token',v_token,'registration_status',v_reg.status,'status_label',private.tr_status_label(v_reg.status),'is_locked',false,'return_reason',v_reg.reopen_reason);
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_student_submit(p_registration_number text, p_resume_token text, p_answers jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_digits text:=regexp_replace(coalesce(p_registration_number,''),'\D','','g');
  v_reg public.term_registrations%rowtype;
  v_term public.academic_terms%rowtype;
  v_filtered jsonb;
  v_missing jsonb;
  v_before jsonb;
  v_status text;
  v_accommodation text;
begin
  select tr.* into v_reg
  from public.term_registrations tr
  join public.students s on s.id=tr.student_id
  join public.academic_terms t on t.id=tr.term_id
  where s.registration_number::text=v_digits and s.is_active and t.registration_is_open
  for update of tr;
  if not found then return jsonb_build_object('status','not_found','message','No open enrolment was found.'); end if;
  if v_reg.resume_token_hash is null or private.tr_token_hash(p_resume_token)<>v_reg.resume_token_hash then
    return jsonb_build_object('status','unauthorized','message','Open this enrolment from the browser where you started it.');
  end if;
  if v_reg.student_locked or v_reg.student_submitted_at is not null then
    return jsonb_build_object('status','locked','message','This enrolment has already been submitted.','status_label',private.tr_status_label(v_reg.status));
  end if;
  select * into v_term from public.academic_terms where id=v_reg.term_id;
  v_filtered:=private.tr_filter_answers(v_term.registration_form_schema->'student',coalesce(p_answers,'{}'::jsonb));
  if coalesce(v_filtered->>'marital_status','')<>'Married' then v_filtered:=v_filtered-'spouse_location'; end if;
  v_accommodation:=coalesce(v_filtered->>'accommodation_type','');
  if v_accommodation<>'Shared' then v_filtered:=v_filtered-'accommodation_hostel'-'accommodation_room'-'shared_occupants'; end if;
  v_missing:=private.tr_missing_required(v_term.registration_form_schema->'student',v_filtered);
  if coalesce(v_filtered->>'marital_status','')='Married' and nullif(btrim(coalesce(v_filtered->>'spouse_location','')),'') is null then
    v_missing:=v_missing||jsonb_build_array(jsonb_build_object('id','spouse_location','label','Where your spouse is'));
  end if;
  if nullif(btrim(coalesce(v_filtered->>'student_email','')),'') is not null
     and v_filtered->>'student_email' !~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$' then
    return jsonb_build_object('status','invalid','message','Enter a valid student email address.');
  end if;
  if jsonb_array_length(v_missing)>0 then
    return jsonb_build_object('status','missing','message','Please complete the required student information.','missing',v_missing);
  end if;
  v_before:=v_reg.student_answers;
  perform private.tr_sync_sponsor(v_reg.student_id,v_reg.term_id,v_filtered->>'sponsor_name',v_filtered->>'sponsor_contact','student');
  update public.term_registrations set
    student_answers=v_filtered,student_submitted_at=now(),student_locked=true,
    accommodation_mode=case when v_accommodation='Shared' then 'on_campus' when v_accommodation='Married' then 'off_campus' else 'unconfirmed' end,
    accommodation_residence=case when v_accommodation='Shared' then nullif(btrim(v_filtered->>'accommodation_hostel'),'') else null end,
    accommodation_room=case when v_accommodation='Shared' then nullif(btrim(v_filtered->>'accommodation_room'),'') else null end,
    accommodation_bed=null,
    accommodation_answers=case when v_accommodation='' then '{}'::jsonb else jsonb_strip_nulls(jsonb_build_object(
      'accommodation_type',v_accommodation,
      'accommodation_hostel',case when v_accommodation='Shared' then nullif(v_filtered->>'accommodation_hostel','') end,
      'accommodation_room',case when v_accommodation='Shared' then nullif(v_filtered->>'accommodation_room','') end,
      'shared_occupants',case when v_accommodation='Shared' then v_filtered->'shared_occupants' end
    )) end,
    reopened_at=null,reopened_by_role=null,reopen_reason=null,updated_at=now()
  where id=v_reg.id;
  v_status:=private.tr_recalculate(v_reg.id);
  perform private.tr_write_history(v_reg.id,'student','student_section_submitted','student',v_before,v_filtered,null);
  return jsonb_build_object('status','success','message','Your term enrolment has been submitted.','registration_status',v_status,'status_label',private.tr_status_label(v_status));
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_sync_sponsor(p_student_id text, p_term_id bigint, p_name text, p_phone text, p_actor_role text DEFAULT 'student'::text)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_sponsor_id uuid;
begin
  if nullif(btrim(coalesce(p_name,'')),'') is null or nullif(btrim(coalesce(p_phone,'')),'') is null then
    return null;
  end if;
  select id into v_sponsor_id from public.sponsors
  where lower(btrim(name))=lower(btrim(p_name))
    and regexp_replace(phone,'\s+','','g')=regexp_replace(p_phone,'\s+','','g')
  limit 1;
  if v_sponsor_id is null then
    insert into public.sponsors(name,phone,created_by_role)
    values(btrim(p_name),btrim(p_phone),p_actor_role)
    returning id into v_sponsor_id;
  else
    update public.sponsors set name=btrim(p_name),phone=btrim(p_phone),updated_at=now()
    where id=v_sponsor_id;
  end if;
  insert into public.student_term_sponsors(
    student_id,term_id,sponsor_id,sponsor_name_snapshot,sponsor_phone_snapshot,confirmed_by_role
  ) values(
    p_student_id,p_term_id,v_sponsor_id,btrim(p_name),btrim(p_phone),coalesce(nullif(p_actor_role,''),'student')
  ) on conflict(student_id,term_id) do update set
    sponsor_id=excluded.sponsor_id,
    sponsor_name_snapshot=excluded.sponsor_name_snapshot,
    sponsor_phone_snapshot=excluded.sponsor_phone_snapshot,
    confirmed_at=now(),confirmed_by_role=excluded.confirmed_by_role;
  return v_sponsor_id;
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_token_hash(p_token text)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'extensions'
AS $function$ select encode(extensions.digest(coalesce(p_token,''),'sha256'),'hex') $function$
;

CREATE OR REPLACE FUNCTION private.tr_update_accommodation(p_pin text, p_registration_id uuid, p_off_campus boolean, p_residence text DEFAULT NULL::text, p_room text DEFAULT NULL::text, p_bed text DEFAULT NULL::text, p_mark_complete boolean DEFAULT false)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$ declare v_actor text:=private.tr_actor_from_pin(p_pin); v_reg public.term_registrations%rowtype; v_before jsonb; v_result jsonb; v_status text; begin if v_actor is null then return jsonb_build_object('status','unauthorized','message','Existing staff access required.'); end if; select * into v_reg from public.term_registrations where id=p_registration_id for update; if not found then return jsonb_build_object('status','not_found','message','Registration not found.'); end if; if v_reg.completed_at is not null then return jsonb_build_object('status','locked','message','This registration is complete. Admin must reopen it before changes can be made.'); end if; if not coalesce(p_off_campus,false) and nullif(trim(coalesce(p_residence,'')),'') is null then return jsonb_build_object('status','invalid','message','Enter the hostel or accommodation location.'); end if; if coalesce(p_mark_complete,false) and not coalesce(p_off_campus,false) and nullif(trim(coalesce(p_room,'')),'') is null then return jsonb_build_object('status','invalid','message','Enter the room before marking accommodation complete.'); end if; v_before:=jsonb_build_object('mode',v_reg.accommodation_mode,'residence',v_reg.accommodation_residence,'room',v_reg.accommodation_room,'bed',v_reg.accommodation_bed,'complete',v_reg.accommodation_complete); if coalesce(p_off_campus,false) then v_result:=public.dashboard_update_student_accommodation(p_pin,v_reg.registration_number_snapshot::text,'',null,null,'cancelled',true); if coalesce(v_result->>'status','')<>'success' then return v_result; end if; update public.term_registrations set accommodation_mode='off_campus',accommodation_residence=null,accommodation_room=null,accommodation_bed=null,accommodation_complete=true,accommodation_completed_at=now(),accommodation_completed_by_role=v_actor,updated_at=now() where id=v_reg.id; else v_result:=public.dashboard_update_student_accommodation(p_pin,v_reg.registration_number_snapshot::text,trim(p_residence),nullif(trim(coalesce(p_room,'')),''),nullif(trim(coalesce(p_bed,'')),''),'allocated',false); if coalesce(v_result->>'status','')<>'success' then return v_result; end if; update public.term_registrations set accommodation_mode='on_campus',accommodation_residence=trim(p_residence),accommodation_room=nullif(trim(coalesce(p_room,'')),''),accommodation_bed=nullif(trim(coalesce(p_bed,'')),''),accommodation_complete=coalesce(p_mark_complete,false),accommodation_completed_at=case when p_mark_complete then now() else null end,accommodation_completed_by_role=case when p_mark_complete then v_actor else null end,updated_at=now() where id=v_reg.id; end if; v_status:=private.tr_recalculate(v_reg.id); perform private.tr_write_history(v_reg.id,v_actor,'accommodation_updated','accommodation',v_before,jsonb_build_object('off_campus',p_off_campus,'residence',p_residence,'room',p_room,'bed',p_bed,'complete',case when p_off_campus then true else p_mark_complete end),null); return jsonb_build_object('status','success','message','Accommodation saved.','registration_status',v_status,'status_label',private.tr_status_label(v_status)); end $function$
;

CREATE OR REPLACE FUNCTION private.tr_update_accommodation_v2(p_pin text, p_registration_id uuid, p_off_campus boolean, p_residence text DEFAULT NULL::text, p_room text DEFAULT NULL::text, p_bed text DEFAULT NULL::text, p_mark_complete boolean DEFAULT false, p_accommodation_answers jsonb DEFAULT '{}'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_actor text:=private.tr_actor_from_pin(p_pin); v_reg public.term_registrations%rowtype; v_term public.academic_terms%rowtype;
  v_before jsonb; v_result jsonb; v_status text; v_answers jsonb; v_missing jsonb;
begin
  if v_actor is null then return jsonb_build_object('status','unauthorized','message','Existing staff access required.'); end if;
  select * into v_reg from public.term_registrations where id=p_registration_id for update;
  if not found then return jsonb_build_object('status','not_found','message','Registration not found.'); end if;
  if v_reg.completed_at is not null then return jsonb_build_object('status','locked','message','This registration is complete. Admin must reopen it before changes can be made.'); end if;
  select * into v_term from public.academic_terms where id=v_reg.term_id;
  v_answers:=private.tr_filter_answers(v_term.registration_form_schema->'accommodation',coalesce(p_accommodation_answers,'{}'::jsonb));
  if not coalesce(p_off_campus,false) and nullif(trim(coalesce(p_residence,'')),'') is null then return jsonb_build_object('status','invalid','message','Enter the hostel or accommodation location.'); end if;
  if coalesce(p_mark_complete,false) and not coalesce(p_off_campus,false) and nullif(trim(coalesce(p_room,'')),'') is null then return jsonb_build_object('status','invalid','message','Enter the room before marking accommodation complete.'); end if;
  if coalesce(p_mark_complete,false) and not coalesce(p_off_campus,false) then
    v_missing:=private.tr_missing_required(v_term.registration_form_schema->'accommodation',v_answers);
    if jsonb_array_length(v_missing)>0 then return jsonb_build_object('status','missing','message','Complete the accommodation details before marking this part complete.','missing',v_missing); end if;
  end if;
  v_before:=jsonb_build_object('mode',v_reg.accommodation_mode,'residence',v_reg.accommodation_residence,'room',v_reg.accommodation_room,'bed',v_reg.accommodation_bed,'answers',v_reg.accommodation_answers,'complete',v_reg.accommodation_complete);
  if coalesce(p_off_campus,false) then
    v_result:=public.dashboard_update_student_accommodation(p_pin,v_reg.registration_number_snapshot::text,'',null,null,'cancelled',true);
    if coalesce(v_result->>'status','')<>'success' then return v_result; end if;
    update public.term_registrations set accommodation_mode='off_campus',accommodation_residence=null,accommodation_room=null,accommodation_bed=null,
      accommodation_answers='{}'::jsonb,accommodation_complete=true,accommodation_completed_at=now(),accommodation_completed_by_role=v_actor,updated_at=now() where id=v_reg.id;
  else
    v_result:=public.dashboard_update_student_accommodation(p_pin,v_reg.registration_number_snapshot::text,trim(p_residence),nullif(trim(coalesce(p_room,'')),''),nullif(trim(coalesce(p_bed,'')),''),'allocated',false);
    if coalesce(v_result->>'status','')<>'success' then return v_result; end if;
    update public.term_registrations set accommodation_mode='on_campus',accommodation_residence=trim(p_residence),accommodation_room=nullif(trim(coalesce(p_room,'')),''),
      accommodation_bed=nullif(trim(coalesce(p_bed,'')),''),accommodation_answers=v_answers,accommodation_complete=coalesce(p_mark_complete,false),
      accommodation_completed_at=case when p_mark_complete then now() else null end,accommodation_completed_by_role=case when p_mark_complete then v_actor else null end,updated_at=now() where id=v_reg.id;
  end if;
  v_status:=private.tr_recalculate(v_reg.id);
  perform private.tr_write_history(v_reg.id,v_actor,'accommodation_updated','accommodation',v_before,
    jsonb_build_object('off_campus',p_off_campus,'residence',p_residence,'room',p_room,'bed',p_bed,'answers',v_answers,'complete',case when p_off_campus then true else p_mark_complete end),null);
  return jsonb_build_object('status','success','message','Accommodation saved.','registration_status',v_status,'status_label',private.tr_status_label(v_status));
end
$function$
;

CREATE OR REPLACE FUNCTION private.tr_write_history(p_registration_id uuid, p_actor_role text, p_action text, p_section text, p_before jsonb, p_after jsonb, p_note text DEFAULT NULL::text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$ begin insert into public.term_registration_history(registration_id,actor_role,action,section,before_data,after_data,note) values(p_registration_id,p_actor_role,p_action,p_section,p_before,p_after,nullif(trim(coalesce(p_note,'')),'')); end $function$
;

CREATE OR REPLACE FUNCTION public._current_academic_year()
 RETURNS integer
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  SELECT coalesce(
    (SELECT academic_year FROM public.academic_terms WHERE is_current=true ORDER BY academic_year DESC,term_number DESC LIMIT 1),
    extract(year from (now() at time zone 'Africa/Harare'))::integer
  );
$function$
;

CREATE OR REPLACE FUNCTION public._gate_pass_add_primary_member()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  INSERT INTO public.gate_pass_members(pass_id, student_id, is_primary, added_by_student_id)
  VALUES(NEW.id, NEW.student_id, true, NEW.student_id)
  ON CONFLICT(pass_id, student_id) DO UPDATE
  SET is_primary = true,
      updated_at = now();
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public._gate_pass_deadline(p_departure_at timestamp with time zone)
 RETURNS timestamp with time zone
 LANGUAGE plpgsql
 STABLE
 SET search_path TO 'public'
AS $function$
declare
  v_local timestamp;
  v_monday timestamp;
  v_deadline_local timestamp;
begin
  if p_departure_at is null then
    return null;
  end if;

  v_local := p_departure_at at time zone 'Africa/Harare';
  v_monday := date_trunc('week', v_local);

  -- Gate-pass submissions close at 4:00 pm Harare time on the
  -- Wednesday of the departure's calendar week.
  v_deadline_local := v_monday + interval '2 days 16 hours';

  return v_deadline_local at time zone 'Africa/Harare';
end;
$function$
;

CREATE OR REPLACE FUNCTION public._gate_pass_people_json(p_pass_id uuid)
 RETURNS jsonb
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select coalesce(jsonb_agg(jsonb_build_object(
    'student_id',s.id,
    'student_name',s.full_name,
    'registration_number',s.registration_number,
    'is_primary',gm.is_primary,
    'actual_departure_at',gm.actual_departure_at,
    'actual_return_at',gm.actual_return_at
  ) order by gm.is_primary desc,s.full_name),'[]'::jsonb)
  from public.gate_pass_members gm
  join public.students s on s.id=gm.student_id
  where gm.pass_id=p_pass_id;
$function$
;

CREATE OR REPLACE FUNCTION public._perform_meal_check_in(p_registration_number text, p_meal_session text, p_service_date date, p_source text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_student public.students%rowtype;
  v_existing public.check_ins%rowtype;
  v_inserted public.check_ins%rowtype;
  v_reg bigint;
begin
  if private.conference_mode() then
    return jsonb_build_object(
      'status','conference_disabled',
      'message','Meal collection is unavailable while Conference Mode is on.'
    );
  end if;
  if p_registration_number !~ '^[0-9]{5}$' then
    return jsonb_build_object('status','invalid','message','Enter a five-digit registration number.');
  end if;
  if p_meal_session not in ('Breakfast','Lunch','Break-fast 4pm','Supper') then
    return jsonb_build_object('status','invalid','message','Choose a valid meal.');
  end if;
  if p_service_date <> timezone('Africa/Harare',now())::date then
    return jsonb_build_object('status','wrong_day','message','Meal collection can only be recorded for today.');
  end if;
  v_reg := p_registration_number::bigint;
  select * into v_student
  from public.students
  where registration_number = v_reg and is_active = true
  limit 1;
  if not found then
    return jsonb_build_object(
      'status','not_found',
      'registration_number',p_registration_number,
      'message','This registration number is not on the active student list.'
    );
  end if;
  select * into v_existing
  from public.check_ins
  where student_id = v_student.id
    and meal_session = p_meal_session
    and service_date = p_service_date
  limit 1;
  if found then
    return jsonb_build_object(
      'status','duplicate',
      'registration_number',v_student.registration_number::text,
      'full_name',v_student.full_name,
      'meal_session',p_meal_session,
      'first_checked_in_at',v_existing.checked_in_at,
      'message',v_student.full_name || ' has already collected this meal today.'
    );
  end if;
  begin
    insert into public.check_ins(
      student_id,meal_session,service_date,checked_in_at,checked_in_by,
      check_in_source,collection_event_id,recipient_role,child_portions
    ) values (
      v_student.id,p_meal_session,p_service_date,now(),null,p_source,
      gen_random_uuid(),'collector',0
    ) returning * into v_inserted;
  exception when unique_violation then
    select * into v_existing
    from public.check_ins
    where student_id = v_student.id
      and meal_session = p_meal_session
      and service_date = p_service_date
    limit 1;
    return jsonb_build_object(
      'status','duplicate',
      'registration_number',v_student.registration_number::text,
      'full_name',v_student.full_name,
      'meal_session',p_meal_session,
      'first_checked_in_at',v_existing.checked_in_at,
      'message',v_student.full_name || ' has already collected this meal today.'
    );
  end;
  return jsonb_build_object(
    'status','checked_in',
    'registration_number',v_student.registration_number::text,
    'full_name',v_student.full_name,
    'meal_session',p_meal_session,
    'checked_in_at',v_inserted.checked_in_at,
    'check_in_source',p_source
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public._student_year_number(p_registration_number bigint, p_academic_year integer)
 RETURNS integer
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $function$
  select case
    when p_registration_number is null or p_academic_year is null then null
    else coalesce(
      (select o.class_year from public.student_class_year_overrides o
       where o.registration_number=p_registration_number and o.academic_year=p_academic_year),
      case when p_academic_year-(2000+substring(p_registration_number::text from 1 for 2)::integer)+1 between 1 and 3
        then p_academic_year-(2000+substring(p_registration_number::text from 1 for 2)::integer)+1
        else null end
    )
  end
$function$
;

CREATE OR REPLACE FUNCTION public.admin_clear_day(p_pin text, p_service_date date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_deleted integer;
BEGIN
  IF NOT private.system_access_matches(ARRAY['administrator','it_admin'],p_pin) THEN RAISE EXCEPTION 'Incorrect PIN'; END IF;
  DELETE FROM public.check_ins WHERE service_date=p_service_date;
  GET DIAGNOSTICS v_deleted = ROW_COUNT;
  RETURN jsonb_build_object(
    'status','cleared',
    'deleted',v_deleted,
    'service_date',p_service_date
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_fee_dashboard(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_actor text := private.tr_actor_from_pin(p_pin);
  v_term_id bigint;
begin
  if v_actor <> 'administrator' then
    return jsonb_build_object('status','unauthorized','message','School Administration access required.');
  end if;
  if p_term_id is null then
    select id into v_term_id from public.academic_terms
    order by registration_is_open desc,is_current desc,academic_year desc,term_number desc limit 1;
  else
    v_term_id:=p_term_id;
  end if;
  return private.fee_dashboard_for_term(v_term_id);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_gate_pass_decision(p_pin text, p_pass_id uuid, p_decision text, p_comments text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_pass public.gate_passes%rowtype;
  v_old text;
  v_new text;
  v_admin boolean;
  v_senior boolean;
  v_holiday boolean := false;
BEGIN
  IF NOT private.system_access_matches(ARRAY['administrator','it_admin'],p_pin) THEN RETURN jsonb_build_object('status','unauthorized','message','School Administration password required.'); END IF;
  IF p_decision NOT IN ('approved','rejected','cancelled') THEN
    RETURN jsonb_build_object('status','invalid','message','Choose Approve, Reject or Cancel.');
  END IF;

  SELECT * INTO v_pass FROM public.gate_passes WHERE id=p_pass_id FOR UPDATE;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Gate pass not found.'); END IF;
  v_old:=v_pass.status;

  INSERT INTO public.gate_pass_approvals(pass_id,approver_role,decision,comments,decided_at)
  VALUES(p_pass_id,'administrator',p_decision,nullif(trim(coalesce(p_comments,'')),''),now())
  ON CONFLICT(pass_id,approver_role) DO UPDATE
  SET decision=excluded.decision,comments=excluded.comments,decided_at=excluded.decided_at;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_holiday
  FROM public.system_settings WHERE setting_key='school_holiday_mode';

  IF p_decision='cancelled' THEN
    v_new:='cancelled';
    UPDATE public.gate_passes
    SET status=v_new,cancelled_at=now(),cancelled_by_role='administrator',
        cancellation_reason=nullif(trim(coalesce(p_comments,'')),''),updated_at=now()
    WHERE id=p_pass_id;
  ELSIF p_decision='rejected' THEN
    v_new:='rejected';
    UPDATE public.gate_passes SET status=v_new,updated_at=now() WHERE id=p_pass_id;
  ELSE
    SELECT exists(SELECT 1 FROM public.gate_pass_approvals
      WHERE pass_id=p_pass_id AND approver_role='administrator' AND decision='approved') INTO v_admin;
    SELECT exists(SELECT 1 FROM public.gate_pass_approvals
      WHERE pass_id=p_pass_id AND approver_role IN ('principal','dean','director') AND decision='approved') INTO v_senior;

    IF v_admin AND (v_holiday OR v_senior) THEN
      v_new:='approved';
      UPDATE public.gate_passes
      SET status='approved',final_approved_at=coalesce(final_approved_at,now()),updated_at=now()
      WHERE id=p_pass_id;
    ELSE
      v_new:='pending';
      UPDATE public.gate_passes SET status='pending',updated_at=now() WHERE id=p_pass_id;
    END IF;
  END IF;

  INSERT INTO public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
  VALUES(p_pass_id,v_old,v_new,'administrator',nullif(trim(coalesce(p_comments,'')),''));
  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('gate_pass','gate_pass',p_pass_id::text,'administrator',p_decision,
    jsonb_build_object('previous_status',v_old,'new_status',v_new,'comments',p_comments,'school_holiday_mode',v_holiday));

  RETURN jsonb_build_object('status','success','pass_id',p_pass_id,'pass_status',v_new,
    'actor_role','administrator','decision',p_decision,'school_holiday_mode',v_holiday);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_gate_pass_editor_data(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  v_dashboard jsonb;
begin
  v_dashboard:=public.admin_services_dashboard(p_pin,null);

  if coalesce(v_dashboard->>'status','') <> 'success' then
    return jsonb_build_object('status','unauthorized','message','School Administration password required.');
  end if;

  return jsonb_build_object(
    'status','success',
    'passes',coalesce(v_dashboard->'gate_passes','[]'::jsonb),
    'loaded_at',now()
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_gate_pass_review_details(p_pin text, p_pass_id uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_auth jsonb;
  v_pass public.gate_passes%rowtype;
  v_student public.students%rowtype;
  v_people jsonb;
  v_approvals jsonb;
BEGIN
  v_auth:=public.admin_services_dashboard(p_pin,NULL);
  IF coalesce(v_auth->>'status','')<>'success' THEN
    RETURN jsonb_build_object('status','unauthorized','message','School Administration password required.');
  END IF;

  SELECT * INTO v_pass FROM public.gate_passes WHERE id=p_pass_id;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Gate pass not found.'); END IF;

  SELECT * INTO v_student FROM public.students WHERE id=v_pass.student_id;

  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'student_name',s.full_name,'registration_number',s.registration_number,
    'is_primary',gm.is_primary,'actual_departure_at',gm.actual_departure_at,
    'actual_return_at',gm.actual_return_at
  ) ORDER BY gm.is_primary DESC,s.full_name),'[]'::jsonb)
  INTO v_people
  FROM public.gate_pass_members gm
  JOIN public.students s ON s.id=gm.student_id
  WHERE gm.pass_id=p_pass_id;

  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'role',a.approver_role,'decision',a.decision,
    'comments',a.comments,'decided_at',a.decided_at
  ) ORDER BY a.decided_at),'[]'::jsonb)
  INTO v_approvals
  FROM public.gate_pass_approvals a
  WHERE a.pass_id=p_pass_id;

  RETURN jsonb_build_object('status','success','pass',jsonb_build_object(
    'id',v_pass.id,'student_name',v_student.full_name,
    'registration_number',v_student.registration_number,
    'destination',v_pass.destination,'reason',v_pass.reason,
    'contact_details',v_pass.contact_details,'departure_at',v_pass.departure_at,
    'expected_return_at',v_pass.expected_return_at,'status',v_pass.status,
    'waiting_on',CASE
      WHEN v_pass.status<>'pending' THEN NULL
      WHEN NOT EXISTS(SELECT 1 FROM public.gate_pass_approvals a WHERE a.pass_id=v_pass.id AND a.approver_role='administrator' AND a.decision='approved') THEN 'School Administrator'
      WHEN NOT coalesce((SELECT (setting_value #>> '{}')::boolean FROM public.system_settings WHERE setting_key='school_holiday_mode'),false)
        AND NOT EXISTS(SELECT 1 FROM public.gate_pass_approvals a WHERE a.pass_id=v_pass.id AND a.approver_role IN ('principal','dean','director') AND a.decision='approved') THEN 'Principal, Dean or Director'
      ELSE NULL END,
    'people',v_people,'approvals',v_approvals
  ));
END;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_review_gate_pass(p_pin text, p_pass_id uuid, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_decision text DEFAULT NULL::text, p_comments text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_auth jsonb;
  v_pass public.gate_passes%rowtype;
  v_old_status text;
  v_new_status text;
  v_admin boolean;
  v_senior boolean;
  v_holiday boolean := false;
  v_schedule_changed boolean;
BEGIN
  v_auth:=public.admin_services_dashboard(p_pin,NULL);
  IF coalesce(v_auth->>'status','')<>'success' THEN
    RETURN jsonb_build_object('status','unauthorized','message','School Administration password required.');
  END IF;

  IF p_decision IS NOT NULL AND p_decision NOT IN ('approved','rejected','cancelled') THEN
    RETURN jsonb_build_object('status','invalid','message','Choose Approve, Reject or Cancel.');
  END IF;


  IF p_departure_at IS NULL OR p_expected_return_at IS NULL OR p_expected_return_at<=p_departure_at THEN
    RETURN jsonb_build_object('status','invalid','message','Expected return must be later than departure.');
  END IF;

  IF p_expected_return_at<=now() THEN
    RETURN jsonb_build_object('status','invalid','message','Expected return must be in the future.');
  END IF;

  SELECT * INTO v_pass FROM public.gate_passes WHERE id=p_pass_id FOR UPDATE;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Gate pass not found.'); END IF;

  IF v_pass.status IN ('departed','returned','expired') THEN
    RETURN jsonb_build_object('status','invalid','message','Dates cannot be changed after travel has started or finished.');
  END IF;

  IF EXISTS(
    WITH current_people AS (
      SELECT student_id FROM public.gate_pass_members WHERE pass_id=p_pass_id
    )
    SELECT 1
    FROM current_people cp
    JOIN public.gate_pass_members other_member ON other_member.student_id=cp.student_id
    JOIN public.gate_passes other_pass ON other_pass.id=other_member.pass_id
    WHERE other_pass.id<>p_pass_id
      AND other_pass.status IN ('pending','approved','departed')
      AND tstzrange(other_pass.departure_at,other_pass.expected_return_at,'[]')
          && tstzrange(p_departure_at,p_expected_return_at,'[]')
  ) THEN
    RETURN jsonb_build_object('status','schedule_conflict','message','One of the people on this pass has another active pass that overlaps these dates.');
  END IF;

  v_old_status:=v_pass.status;
  v_schedule_changed:=v_pass.departure_at IS DISTINCT FROM p_departure_at OR v_pass.expected_return_at IS DISTINCT FROM p_expected_return_at;

  UPDATE public.gate_passes
  SET departure_at=p_departure_at,expected_return_at=p_expected_return_at,updated_at=now()
  WHERE id=p_pass_id;

  IF p_decision IS NULL THEN
    INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
    VALUES('gate_pass','gate_pass',p_pass_id::text,'administrator','schedule_updated',jsonb_build_object(
      'old_departure_at',v_pass.departure_at,'new_departure_at',p_departure_at,
      'old_expected_return_at',v_pass.expected_return_at,'new_expected_return_at',p_expected_return_at,
      'comments',p_comments
    ));
    RETURN jsonb_build_object('status','success','pass_id',p_pass_id,'pass_status',v_old_status,'schedule_updated',v_schedule_changed,'decision',NULL);
  END IF;

  INSERT INTO public.gate_pass_approvals(pass_id,approver_role,decision,comments,decided_at)
  VALUES(p_pass_id,'administrator',p_decision,nullif(trim(coalesce(p_comments,'')),''),now())
  ON CONFLICT(pass_id,approver_role) DO UPDATE
  SET decision=excluded.decision,comments=excluded.comments,decided_at=excluded.decided_at;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_holiday
  FROM public.system_settings WHERE setting_key='school_holiday_mode';

  IF p_decision='cancelled' THEN
    v_new_status:='cancelled';
    UPDATE public.gate_passes SET status=v_new_status,cancelled_at=now(),cancelled_by_role='administrator',cancellation_reason=nullif(trim(coalesce(p_comments,'')),''),updated_at=now() WHERE id=p_pass_id;
  ELSIF p_decision='rejected' THEN
    v_new_status:='rejected';
    UPDATE public.gate_passes SET status=v_new_status,updated_at=now() WHERE id=p_pass_id;
  ELSE
    SELECT EXISTS(SELECT 1 FROM public.gate_pass_approvals WHERE pass_id=p_pass_id AND approver_role='administrator' AND decision='approved') INTO v_admin;
    SELECT EXISTS(SELECT 1 FROM public.gate_pass_approvals WHERE pass_id=p_pass_id AND approver_role IN ('principal','dean','director') AND decision='approved') INTO v_senior;
    IF v_admin AND (v_holiday OR v_senior) THEN
      v_new_status:='approved';
      UPDATE public.gate_passes SET status='approved',final_approved_at=coalesce(final_approved_at,now()),updated_at=now() WHERE id=p_pass_id;
    ELSE
      v_new_status:='pending';
      UPDATE public.gate_passes SET status='pending',updated_at=now() WHERE id=p_pass_id;
    END IF;
  END IF;

  INSERT INTO public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
  VALUES(p_pass_id,v_old_status,v_new_status,'administrator',concat_ws(' ',nullif(trim(coalesce(p_comments,'')),''),CASE WHEN v_schedule_changed THEN 'Departure or return time was updated during review.' END));

  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('gate_pass','gate_pass',p_pass_id::text,'administrator',p_decision,jsonb_build_object(
    'previous_status',v_old_status,'new_status',v_new_status,'comments',p_comments,
    'school_holiday_mode',v_holiday,'schedule_updated',v_schedule_changed,
    'old_departure_at',v_pass.departure_at,'new_departure_at',p_departure_at,
    'old_expected_return_at',v_pass.expected_return_at,'new_expected_return_at',p_expected_return_at
  ));

  RETURN jsonb_build_object('status','success','pass_id',p_pass_id,'pass_status',v_new_status,'actor_role','administrator','decision',p_decision,'schedule_updated',v_schedule_changed,'school_holiday_mode',v_holiday);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_send_fee_notices(p_pin text, p_registration_ids uuid[])
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_actor text := private.tr_actor_from_pin(p_pin);
begin
  if v_actor <> 'administrator' then
    return jsonb_build_object('status','unauthorized','message','School Administration access required.');
  end if;
  return private.queue_fee_notices(p_registration_ids,'administrator',null);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_services_dashboard(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_base jsonb;
  v_students jsonb;
  v_terms jsonb;
  v_settings jsonb;
  v_selected public.academic_terms%rowtype;
  v_paid integer;
  v_unpaid integer;
begin
  if not private.system_access_matches(array['administrator','it_admin'],p_pin) then
    return jsonb_build_object('status','unauthorized','message','School Administration password required.');
  end if;

  if p_term_id is not null then
    select * into v_selected from public.academic_terms where id=p_term_id;
  else
    select * into v_selected from public.academic_terms
    order by is_current desc,academic_year desc,term_number desc limit 1;
  end if;
  if not found then
    return jsonb_build_object('status','configuration_error','message','No academic term is configured.');
  end if;

  v_base:=public.student_services_dashboard(p_pin);
  if coalesce(v_base->>'status','')<>'success' then return v_base; end if;

  select coalesce(jsonb_agg(
    x.student_json || jsonb_build_object(
      'fees_paid',coalesce(f.fees_paid,true),
      'fee_notes',f.notes,
      'fee_updated_at',f.updated_at
    ) order by x.student_json->>'student_name'
  ),'[]'::jsonb)
  into v_students
  from (
    select value as student_json
    from jsonb_array_elements(v_base->'students')
  ) x
  join public.students s
    on s.registration_number=(x.student_json->>'registration_number')::bigint
  left join public.student_term_fee_status f
    on f.student_id=s.id and f.term_id=v_selected.id;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id',id,'academic_year',academic_year,'term_number',term_number,
    'term_name',term_name,'fees_due_date',fees_due_date,'is_current',is_current
  ) order by academic_year desc,term_number),'[]'::jsonb)
  into v_terms
  from public.academic_terms;

  select count(*) filter(where coalesce(f.fees_paid,true)),
         count(*) filter(where not coalesce(f.fees_paid,true))
  into v_paid,v_unpaid
  from public.students s
  left join public.student_term_fee_status f
    on f.student_id=s.id and f.term_id=v_selected.id
  where s.is_active=true;

  select coalesce(jsonb_object_agg(setting_key,setting_value),'{}'::jsonb)
  into v_settings from public.system_settings;

  return v_base || jsonb_build_object(
    'status','success','access_level','administrator','can_review_passes',true,
    'can_manage_settings',true,'can_manage_fees',true,
    'students',v_students,'terms',v_terms,
    'selected_term',jsonb_build_object(
      'id',v_selected.id,'academic_year',v_selected.academic_year,
      'term_number',v_selected.term_number,'term_name',v_selected.term_name,
      'fees_due_date',v_selected.fees_due_date,'is_current',v_selected.is_current
    ),
    'fee_summary',jsonb_build_object('paid',v_paid,'unpaid',v_unpaid,'total',v_paid+v_unpaid),
    'settings',v_settings
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.admin_services_dashboard_v2(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  v_result jsonb;
  v_passes jsonb;
begin
  v_result:=public.admin_services_dashboard(p_pin,p_term_id);
  if coalesce(v_result->>'status','')<>'success' then return v_result; end if;

  select coalesce(jsonb_agg(
    pass_item || jsonb_build_object(
      'people',public._gate_pass_people_json((pass_item->>'id')::uuid)
    ) order by (pass_item->>'submitted_at')::timestamptz desc
  ),'[]'::jsonb)
  into v_passes
  from jsonb_array_elements(coalesce(v_result->'gate_passes','[]'::jsonb)) pass_item;

  v_result:=jsonb_set(v_result,'{gate_passes}',v_passes,true);
  return v_result || jsonb_build_object(
    'current_academic_year',public._current_academic_year(),
    'medical_visibility','admin_full'
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_services_dashboard_v3(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare
  v_result jsonb;
  v_students jsonb;
begin
  v_result := public.admin_services_dashboard_v2(p_pin, p_term_id);

  if v_result is null or v_result->>'status' is distinct from 'success' then
    return v_result;
  end if;

  select coalesce(
    jsonb_agg(
      student_entry.item || jsonb_build_object('gender', student.gender)
      order by student_entry.position
    ),
    '[]'::jsonb
  )
  into v_students
  from jsonb_array_elements(coalesce(v_result->'students', '[]'::jsonb))
       with ordinality as student_entry(item, position)
  left join public.students as student
    on student.registration_number::text = student_entry.item->>'registration_number';

  return jsonb_set(v_result, '{students}', v_students, true);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_dashboard(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_dashboard(p_pin,p_term_id) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_export(p_pin text, p_term_id bigint)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_export(p_pin,p_term_id) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_finalize(p_pin text, p_registration_id uuid, p_final_answers jsonb, p_staff_note text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_finalize(p_pin,p_registration_id,p_final_answers,p_staff_note) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_get(p_pin text, p_registration_id uuid)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_get(p_pin,p_registration_id) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_manage_term(p_pin text, p_academic_year integer, p_term_number integer, p_action text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_manage_term(p_pin,p_academic_year,p_term_number,p_action) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_reopen(p_pin text, p_registration_id uuid, p_reason text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_reopen(p_pin,p_registration_id,p_reason) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_reset_student_access(p_pin text, p_registration_id uuid)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_reset_student_access(p_pin,p_registration_id) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_save_office_fees(p_pin text, p_registration_id uuid, p_admin_answers jsonb, p_admin_complete boolean, p_fees_answers jsonb, p_fees_complete boolean, p_fees_paid boolean, p_staff_note text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_save_office_fees(p_pin,p_registration_id,p_admin_answers,p_admin_complete,p_fees_answers,p_fees_complete,p_fees_paid,p_staff_note) $function$
;

CREATE OR REPLACE FUNCTION public.admin_term_registration_set_form_schema(p_pin text, p_term_id bigint, p_form_schema jsonb)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_admin_set_form_schema(p_pin,p_term_id,p_form_schema) $function$
;

CREATE OR REPLACE FUNCTION public.admin_update_fee_status(p_pin text, p_registration_number text, p_term_id bigint, p_fees_paid boolean, p_notes text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_student public.students%rowtype;
  v_term public.academic_terms%rowtype;
BEGIN
  IF NOT private.system_access_matches(ARRAY['administrator','it_admin'],p_pin) THEN RETURN jsonb_build_object('status','unauthorized','message','School Administration password required.'); END IF;

  SELECT * INTO v_student FROM public.students
  WHERE registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    AND is_active=true LIMIT 1;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Student not found.'); END IF;

  SELECT * INTO v_term FROM public.academic_terms WHERE id=p_term_id;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Academic term not found.'); END IF;

  INSERT INTO public.student_term_fee_status(student_id,term_id,fees_paid,notes,updated_by_role,updated_at)
  VALUES(v_student.id,v_term.id,coalesce(p_fees_paid,false),nullif(trim(coalesce(p_notes,'')),''),'administrator',now())
  ON CONFLICT(student_id,term_id) DO UPDATE
  SET fees_paid=excluded.fees_paid,notes=excluded.notes,updated_by_role='administrator',updated_at=now();

  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('fees','student',v_student.id,'administrator','fee_status_updated',
    jsonb_build_object('registration_number',v_student.registration_number,'term_id',v_term.id,
      'term_name',v_term.term_name,'fees_paid',coalesce(p_fees_paid,false),'notes',p_notes));

  RETURN jsonb_build_object('status','success','student_name',v_student.full_name,
    'registration_number',v_student.registration_number,'term_id',v_term.id,
    'term_name',v_term.term_name,'fees_paid',coalesce(p_fees_paid,false));
END;
$function$
;

CREATE OR REPLACE FUNCTION public.admin_update_setting(p_pin text, p_setting_key text, p_setting_value jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_actor text:=private.system_access_role(p_pin,array['administrator','it_admin']);
begin
  if v_actor is null then return jsonb_build_object('status','unauthorized','message','School Administration password required.'); end if;
  if p_setting_key not in (
    'school_holiday_mode','gate_pass_pilot_mode','gate_pass_pilot_started_at',
    'gate_pass_pilot_ends_at','gate_terminal_result_seconds'
  ) then return jsonb_build_object('status','invalid','message','This setting cannot be changed from the application.'); end if;

  if p_setting_key='school_holiday_mode' then
    insert into public.system_settings(setting_key,setting_value,updated_at)
    values('school_operating_mode',to_jsonb(case when coalesce((p_setting_value #>> '{}')::boolean,false) then 'holiday' else 'normal' end),now())
    on conflict(setting_key) do update set setting_value=excluded.setting_value,updated_at=excluded.updated_at;
  end if;
  insert into public.system_settings(setting_key,setting_value,updated_at)
  values(p_setting_key,p_setting_value,now())
  on conflict(setting_key) do update set setting_value=excluded.setting_value,updated_at=excluded.updated_at;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('settings','system_setting',p_setting_key,v_actor,'updated',jsonb_build_object('value',p_setting_value));
  return jsonb_build_object('status','success','setting_key',p_setting_key,'setting_value',p_setting_value);
exception when others then
  return jsonb_build_object('status','invalid','message','The setting value is not valid.');
end
$function$
;

CREATE OR REPLACE FUNCTION public.campus_dashboard(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$ DECLARE v jsonb; BEGIN
  v:=public.student_services_dashboard(p_pin);
  IF coalesce(v->>'status','')<>'success' THEN RETURN v; END IF;
  RETURN jsonb_build_object('status','success','access_level',v->'access_level','counts',v->'counts','students',v->'students','recent_movements',v->'recent_movements');
END; $function$
;

CREATE OR REPLACE FUNCTION public.check_in_student(p_registration_number text, p_meal_session text, p_service_date date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  s public.students%rowtype;
  e public.check_ins%rowtype;
  n public.check_ins%rowtype;
  hb boolean;
  h4 boolean;
begin
  if auth.uid() is null then raise exception 'You must be signed in.'; end if;
  if not public.is_active_staff() then raise exception 'This staff account is inactive.'; end if;
  if private.conference_mode() then
    return jsonb_build_object(
      'status','conference_disabled',
      'message','Meal collection is unavailable while Conference Mode is on.'
    );
  end if;
  if p_service_date is null then
    return jsonb_build_object('status','invalid_date','message','A service date is required.');
  end if;
  if p_meal_session not in ('Breakfast','Lunch','Break-fast 4pm','Supper') then
    return jsonb_build_object('status','invalid_session','message','Choose a valid meal session.');
  end if;
  select * into s
  from public.students
  where registration_number::text = trim(p_registration_number)
    and is_active = true;
  if not found then
    return jsonb_build_object(
      'status','not_found',
      'registration_number',trim(p_registration_number),
      'message','This registration number is not on the active student list.'
    );
  end if;
  select * into e
  from public.check_ins
  where student_id=s.id and meal_session=p_meal_session and service_date=p_service_date;
  if found then
    return jsonb_build_object(
      'status','duplicate','student_id',s.id,
      'registration_number',s.registration_number,
      'full_name',s.full_name,'meal_session',p_meal_session,
      'first_checked_in_at',e.checked_in_at,
      'message','The student has already collected this meal.'
    );
  end if;
  select exists(
    select 1 from public.check_ins
    where student_id=s.id and meal_session='Breakfast' and service_date=p_service_date
  ) into hb;
  select exists(
    select 1 from public.check_ins
    where student_id=s.id and meal_session='Break-fast 4pm' and service_date=p_service_date
  ) into h4;
  if p_meal_session='Lunch' and not hb then
    return jsonb_build_object(
      'status','not_eligible','student_id',s.id,
      'registration_number',s.registration_number,
      'full_name',s.full_name,'meal_session',p_meal_session,
      'message','No breakfast collection was found today.'
    );
  end if;
  if p_meal_session='Supper' and not hb and not h4 then
    return jsonb_build_object(
      'status','not_eligible','student_id',s.id,
      'registration_number',s.registration_number,
      'full_name',s.full_name,'meal_session',p_meal_session,
      'message','No breakfast or 4pm break collection was found today.'
    );
  end if;
  begin
    insert into public.check_ins(
      student_id,meal_session,service_date,checked_in_by,check_in_source,
      collection_event_id,recipient_role,child_portions
    ) values (
      s.id,p_meal_session,p_service_date,auth.uid(),'staff',
      gen_random_uuid(),'collector',0
    ) returning * into n;
  exception when unique_violation then
    select * into e
    from public.check_ins
    where student_id=s.id and meal_session=p_meal_session and service_date=p_service_date;
    return jsonb_build_object(
      'status','duplicate','student_id',s.id,
      'registration_number',s.registration_number,
      'full_name',s.full_name,'meal_session',p_meal_session,
      'first_checked_in_at',e.checked_in_at,
      'message','The student was collected by another device.'
    );
  end;
  return jsonb_build_object(
    'status','checked_in','check_in_id',n.id,'student_id',s.id,
    'registration_number',s.registration_number,'full_name',s.full_name,
    'meal_session',p_meal_session,'checked_in_at',n.checked_in_at,
    'message','Meal collection saved.'
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.check_in_student_public(p_registration_number text, p_meal_session text, p_service_date date)
 RETURNS jsonb
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select public._perform_meal_check_in(p_registration_number,p_meal_session,p_service_date,'student_self');
$function$
;

CREATE OR REPLACE FUNCTION public.clinic_active_bed_rest(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_rows jsonb;
BEGIN
  IF p_pin<>'1957' THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect clinic password.'); END IF;
  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'student_id',s.id,'registration_number',s.registration_number,'student_name',s.full_name,
    'started_at',x.started_at,'notes',x.notes,'residence',aa.residence,'room',aa.room
  ) ORDER BY x.started_at DESC),'[]'::jsonb)
  INTO v_rows
  FROM public.student_support_statuses x
  JOIN public.students s ON s.id=x.student_id AND s.is_active=true
  LEFT JOIN LATERAL (
    SELECT a.residence,a.room FROM public.accommodation_allocations a
    WHERE a.student_id=s.id AND a.is_active=true ORDER BY a.allocated_at DESC LIMIT 1
  ) aa ON true
  WHERE x.status_type='bed_rest' AND x.is_active=true;
  RETURN jsonb_build_object('status','success','students',v_rows);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.clinic_active_bed_rest_v2(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_rows jsonb; v_academic_year integer:=public._current_academic_year();
BEGIN
  IF p_pin<>'1957' THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect clinic password.'); END IF;
  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'student_id',s.id,'registration_number',s.registration_number,'student_name',s.full_name,
    'year_number',public._student_year_number(s.registration_number,v_academic_year),
    'year_label',CASE public._student_year_number(s.registration_number,v_academic_year) WHEN 1 THEN '1st Year' WHEN 2 THEN '2nd Year' WHEN 3 THEN '3rd Year' ELSE 'Other Year' END,
    'started_at',x.started_at,'notes',x.notes,'residence',aa.residence,'room',aa.room
  ) ORDER BY x.started_at DESC),'[]'::jsonb)
  INTO v_rows
  FROM public.student_support_statuses x
  JOIN public.students s ON s.id=x.student_id AND s.is_active=true
  LEFT JOIN LATERAL (
    SELECT a.residence,a.room FROM public.accommodation_allocations a
    WHERE a.student_id=s.id AND a.is_active=true ORDER BY a.allocated_at DESC LIMIT 1
  ) aa ON true
  WHERE x.status_type='bed_rest' AND x.is_active=true;
  RETURN jsonb_build_object('status','success','current_academic_year',v_academic_year,'students',v_rows);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.clinic_search_students(p_pin text, p_query text DEFAULT ''::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_students jsonb; v_query text:=trim(coalesce(p_query,''));
BEGIN
  IF p_pin<>'1957' THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect clinic password.'); END IF;
  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'student_id',q.id,'registration_number',q.registration_number,'student_name',q.full_name,
    'on_bed_rest',q.on_bed_rest,'bed_rest_started_at',q.started_at,'bed_rest_notes',q.notes,
    'campus_status',q.campus_status,'residence',q.residence,'room',q.room
  ) ORDER BY q.full_name),'[]'::jsonb)
  INTO v_students
  FROM (
    SELECT s.id,s.registration_number,s.full_name,(br.id IS NOT NULL) on_bed_rest,br.started_at,br.notes,
           coalesce(cm.direction,'UNKNOWN') campus_status,aa.residence,aa.room
    FROM public.students s
    LEFT JOIN LATERAL (
      SELECT x.id,x.started_at,x.notes FROM public.student_support_statuses x
      WHERE x.student_id=s.id AND x.status_type='bed_rest' AND x.is_active=true
      ORDER BY x.started_at DESC LIMIT 1
    ) br ON true
    LEFT JOIN LATERAL (
      SELECT m.direction FROM public.campus_movements m WHERE m.student_id=s.id
      ORDER BY m.scanned_at DESC,m.id DESC LIMIT 1
    ) cm ON true
    LEFT JOIN LATERAL (
      SELECT a.residence,a.room FROM public.accommodation_allocations a
      WHERE a.student_id=s.id AND a.is_active=true ORDER BY a.allocated_at DESC LIMIT 1
    ) aa ON true
    WHERE s.is_active=true AND (
      v_query='' OR s.full_name ILIKE '%'||v_query||'%' OR
      (regexp_replace(v_query,'\D','','g')<>'' AND s.registration_number::text LIKE '%'||regexp_replace(v_query,'\D','','g')||'%')
    )
    ORDER BY s.full_name LIMIT 80
  ) q;
  RETURN jsonb_build_object('status','success','students',v_students);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.clinic_search_students_v2(p_pin text, p_query text DEFAULT ''::text, p_year_number integer DEFAULT NULL::integer)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_students jsonb;
  v_query text:=trim(coalesce(p_query,''));
  v_academic_year integer:=public._current_academic_year();
BEGIN
  IF p_pin<>'1957' THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect clinic password.'); END IF;
  IF p_year_number IS NOT NULL AND p_year_number NOT BETWEEN 1 AND 3 THEN RETURN jsonb_build_object('status','invalid','message','Choose 1st, 2nd or 3rd Year.'); END IF;

  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'student_id',q.id,'registration_number',q.registration_number,'student_name',q.full_name,
    'year_number',q.year_number,'year_label',CASE q.year_number WHEN 1 THEN '1st Year' WHEN 2 THEN '2nd Year' WHEN 3 THEN '3rd Year' ELSE 'Other Year' END,
    'on_bed_rest',q.on_bed_rest,'bed_rest_started_at',q.started_at,'bed_rest_notes',q.notes,
    'campus_status',q.campus_status,'residence',q.residence,'room',q.room
  ) ORDER BY q.full_name),'[]'::jsonb)
  INTO v_students
  FROM (
    SELECT s.id,s.registration_number,s.full_name,
           public._student_year_number(s.registration_number,v_academic_year) AS year_number,
           (br.id IS NOT NULL) AS on_bed_rest,br.started_at,br.notes,
           coalesce(cm.direction,'UNKNOWN') AS campus_status,aa.residence,aa.room
    FROM public.students s
    LEFT JOIN LATERAL (
      SELECT x.id,x.started_at,x.notes FROM public.student_support_statuses x
      WHERE x.student_id=s.id AND x.status_type='bed_rest' AND x.is_active=true
      ORDER BY x.started_at DESC LIMIT 1
    ) br ON true
    LEFT JOIN LATERAL (
      SELECT m.direction FROM public.campus_movements m WHERE m.student_id=s.id
      ORDER BY m.scanned_at DESC,m.id DESC LIMIT 1
    ) cm ON true
    LEFT JOIN LATERAL (
      SELECT a.residence,a.room FROM public.accommodation_allocations a
      WHERE a.student_id=s.id AND a.is_active=true ORDER BY a.allocated_at DESC LIMIT 1
    ) aa ON true
    WHERE s.is_active=true
      AND (p_year_number IS NULL OR public._student_year_number(s.registration_number,v_academic_year)=p_year_number)
      AND (v_query='' OR s.full_name ILIKE '%'||v_query||'%' OR (regexp_replace(v_query,'\D','','g')<>'' AND s.registration_number::text LIKE '%'||regexp_replace(v_query,'\D','','g')||'%'))
    ORDER BY s.full_name LIMIT 250
  ) q;

  RETURN jsonb_build_object('status','success','current_academic_year',v_academic_year,'year_filter',p_year_number,'students',v_students);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.clinic_set_bed_rest(p_pin text, p_registration_number text, p_action text, p_notes text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_student public.students%rowtype; v_action text:=lower(trim(coalesce(p_action,'')));
BEGIN
  IF p_pin<>'1957' THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect clinic password.'); END IF;
  SELECT * INTO v_student FROM public.students
  WHERE registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g') AND is_active=true LIMIT 1;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Student not found.'); END IF;

  IF v_action='start' THEN
    UPDATE public.student_support_statuses
    SET status_label='Bed Rest',started_at=now(),expected_end_at=NULL,ended_at=NULL,is_active=true,
        notes=nullif(trim(coalesce(p_notes,'')),''),set_by_role='clinic',updated_at=now()
    WHERE student_id=v_student.id AND status_type='bed_rest' AND is_active=true;
    IF NOT FOUND THEN
      INSERT INTO public.student_support_statuses(student_id,status_type,status_label,started_at,is_active,notes,set_by_role)
      VALUES(v_student.id,'bed_rest','Bed Rest',now(),true,nullif(trim(coalesce(p_notes,'')),''),'clinic');
    END IF;
    INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
    VALUES('clinic','student',v_student.id,'clinic','bed_rest_started',jsonb_build_object('notes',p_notes));
    RETURN jsonb_build_object('status','success','message','Student placed on bed rest.','student_name',v_student.full_name,'registration_number',v_student.registration_number,'on_bed_rest',true);
  ELSIF v_action='clear' THEN
    UPDATE public.student_support_statuses SET is_active=false,ended_at=now(),updated_at=now()
    WHERE student_id=v_student.id AND status_type='bed_rest' AND is_active=true;
    INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
    VALUES('clinic','student',v_student.id,'clinic','bed_rest_cleared',jsonb_build_object('notes',p_notes));
    RETURN jsonb_build_object('status','success','message','Student removed from bed rest.','student_name',v_student.full_name,'registration_number',v_student.registration_number,'on_bed_rest',false);
  ELSE
    RETURN jsonb_build_object('status','invalid','message','Choose start or clear.');
  END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.dashboard_gate_pass_decision(p_pin text, p_pass_id uuid, p_actor_role text, p_decision text, p_comments text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_pass public.gate_passes%rowtype;
  v_old text;
  v_new text;
  v_admin boolean;
  v_senior boolean;
  v_holiday boolean := false;
BEGIN
  IF NOT private.system_access_matches(ARRAY['management','administrator','it_admin'],p_pin) THEN RETURN jsonb_build_object('status','unauthorized','message','Management password required.'); END IF;
  IF p_actor_role NOT IN ('principal','dean','director') THEN
    RETURN jsonb_build_object('status','invalid','message','Choose Principal, Dean or Director. School Administrator approval is completed on the separate Admin site.');
  END IF;
  IF p_decision NOT IN ('approved','rejected','cancelled') THEN
    RETURN jsonb_build_object('status','invalid','message','Choose Approve, Reject or Cancel.');
  END IF;

  SELECT * INTO v_pass FROM public.gate_passes WHERE id=p_pass_id FOR UPDATE;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Gate pass not found.'); END IF;
  v_old:=v_pass.status;

  INSERT INTO public.gate_pass_approvals(pass_id,approver_role,decision,comments,decided_at)
  VALUES(p_pass_id,p_actor_role,p_decision,nullif(trim(coalesce(p_comments,'')),''),now())
  ON CONFLICT(pass_id,approver_role) DO UPDATE
  SET decision=excluded.decision,comments=excluded.comments,decided_at=excluded.decided_at;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_holiday
  FROM public.system_settings WHERE setting_key='school_holiday_mode';

  IF p_decision='cancelled' THEN
    v_new:='cancelled';
    UPDATE public.gate_passes
    SET status=v_new,cancelled_at=now(),cancelled_by_role=p_actor_role,
        cancellation_reason=nullif(trim(coalesce(p_comments,'')),''),updated_at=now()
    WHERE id=p_pass_id;
  ELSIF p_decision='rejected' THEN
    v_new:='rejected';
    UPDATE public.gate_passes SET status=v_new,updated_at=now() WHERE id=p_pass_id;
  ELSE
    SELECT exists(SELECT 1 FROM public.gate_pass_approvals
      WHERE pass_id=p_pass_id AND approver_role='administrator' AND decision='approved') INTO v_admin;
    SELECT exists(SELECT 1 FROM public.gate_pass_approvals
      WHERE pass_id=p_pass_id AND approver_role IN ('principal','dean','director') AND decision='approved') INTO v_senior;

    IF v_admin AND (v_holiday OR v_senior) THEN
      v_new:='approved';
      UPDATE public.gate_passes
      SET status='approved',final_approved_at=coalesce(final_approved_at,now()),updated_at=now()
      WHERE id=p_pass_id;
    ELSE
      v_new:='pending';
      UPDATE public.gate_passes SET status='pending',updated_at=now() WHERE id=p_pass_id;
    END IF;
  END IF;

  INSERT INTO public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
  VALUES(p_pass_id,v_old,v_new,p_actor_role,nullif(trim(coalesce(p_comments,'')),''));
  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('gate_pass','gate_pass',p_pass_id::text,p_actor_role,p_decision,
    jsonb_build_object('previous_status',v_old,'new_status',v_new,'comments',p_comments,'school_holiday_mode',v_holiday));

  RETURN jsonb_build_object('status','success','pass_id',p_pass_id,'pass_status',v_new,
    'actor_role',p_actor_role,'decision',p_decision,'school_holiday_mode',v_holiday);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.dashboard_gate_pass_review_details(p_pin text, p_pass_id uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  v_auth jsonb;
  v_access text;
  v_pass public.gate_passes%rowtype;
  v_student public.students%rowtype;
  v_approvals jsonb;
begin
  v_auth:=public.student_services_dashboard_v3(p_pin);
  if coalesce(v_auth->>'status','')<>'success' then
    return jsonb_build_object('status','unauthorized','message','Management or Student Leadership password required.');
  end if;
  v_access:=v_auth->>'access_level';

  select * into v_pass from public.gate_passes where id=p_pass_id;
  if not found then return jsonb_build_object('status','not_found','message','Gate pass not found.'); end if;
  select * into v_student from public.students where id=v_pass.student_id;

  select coalesce(jsonb_agg(jsonb_build_object(
    'role',a.approver_role,'decision',a.decision,'comments',a.comments,'decided_at',a.decided_at
  ) order by a.decided_at),'[]'::jsonb)
  into v_approvals
  from public.gate_pass_approvals a where a.pass_id=p_pass_id;

  return jsonb_build_object(
    'status','success','access_level',v_access,'can_decide',(v_access='management'),
    'pass',jsonb_build_object(
      'id',v_pass.id,'student_name',v_student.full_name,
      'registration_number',v_student.registration_number,
      'destination',v_pass.destination,'reason',v_pass.reason,
      'contact_details',case when v_access='management' then v_pass.contact_details else null end,
      'departure_at',v_pass.departure_at,'expected_return_at',v_pass.expected_return_at,
      'status',v_pass.status,'people',public._gate_pass_people_json(v_pass.id),
      'approvals',v_approvals
    )
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.dashboard_update_student_accommodation(p_pin text, p_registration_number text, p_residence text, p_room text DEFAULT NULL::text, p_bed text DEFAULT NULL::text, p_allocation_status text DEFAULT 'allocated'::text, p_remove boolean DEFAULT false)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_access_level text;
  v_student public.students%rowtype;
  v_status text:=lower(trim(coalesce(p_allocation_status,'allocated')));
  v_updated integer;
BEGIN
  v_access_level:=CASE WHEN private.system_access_matches(ARRAY['it_admin'],p_pin) THEN 'administrator' WHEN private.system_access_matches(ARRAY['administrator'],p_pin) THEN 'administrator' WHEN private.system_access_matches(ARRAY['management'],p_pin) THEN 'management' WHEN private.system_access_matches(ARRAY['student_leadership'],p_pin) THEN 'student_leadership' ELSE NULL END;
  IF v_access_level IS NULL THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect password.'); END IF;

  SELECT * INTO v_student FROM public.students
  WHERE registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    AND is_active=true LIMIT 1;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Student not found.'); END IF;

  IF coalesce(p_remove,false) THEN
    UPDATE public.accommodation_allocations
    SET is_active=false,allocation_status='cancelled',ended_at=now(),updated_at=now(),
        notes=concat_ws(' ',nullif(notes,''),'Removed from a dashboard.')
    WHERE student_id=v_student.id AND is_active=true;
    GET DIAGNOSTICS v_updated=ROW_COUNT;
    INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
    VALUES('accommodation','student',v_student.id,v_access_level,'accommodation_removed',
      jsonb_build_object('registration_number',v_student.registration_number,'rows_updated',v_updated));
    RETURN jsonb_build_object('status','success','message','Accommodation removed.',
      'student_name',v_student.full_name,'registration_number',v_student.registration_number,'removed',true);
  END IF;

  IF nullif(trim(coalesce(p_residence,'')),'') IS NULL THEN
    RETURN jsonb_build_object('status','invalid','message','Enter a residence or choose Remove accommodation.');
  END IF;
  IF v_status NOT IN ('waiting','allocated','checked_in','checked_out','cancelled') THEN
    RETURN jsonb_build_object('status','invalid','message','Choose a valid accommodation status.');
  END IF;

  UPDATE public.accommodation_allocations
  SET residence=trim(p_residence),room=nullif(trim(coalesce(p_room,'')),''),
      bed=nullif(trim(coalesce(p_bed,'')),''),allocation_status=v_status,
      allocated_by_role=v_access_level,updated_at=now(),
      ended_at=CASE WHEN v_status='cancelled' THEN now() ELSE NULL END,
      is_active=(v_status<>'cancelled')
  WHERE student_id=v_student.id AND is_active=true;
  GET DIAGNOSTICS v_updated=ROW_COUNT;

  IF v_updated=0 AND v_status<>'cancelled' THEN
    INSERT INTO public.accommodation_allocations(student_id,residence,room,bed,allocation_status,is_active,allocated_by_role,allocated_at,updated_at)
    VALUES(v_student.id,trim(p_residence),nullif(trim(coalesce(p_room,'')),''),
      nullif(trim(coalesce(p_bed,'')),''),v_status,true,v_access_level,now(),now());
  END IF;

  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('accommodation','student',v_student.id,v_access_level,'accommodation_updated',
    jsonb_build_object('registration_number',v_student.registration_number,'residence',trim(p_residence),
      'room',nullif(trim(coalesce(p_room,'')),''),'bed',nullif(trim(coalesce(p_bed,'')),''),'allocation_status',v_status));

  RETURN jsonb_build_object('status','success','message','Accommodation updated.',
    'student_name',v_student.full_name,'registration_number',v_student.registration_number,
    'residence',trim(p_residence),'room',nullif(trim(coalesce(p_room,'')),''),
    'bed',nullif(trim(coalesce(p_bed,'')),''),'allocation_status',v_status,'access_level',v_access_level);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.dashboard_update_student_campus_status(p_pin text, p_registration_number text, p_direction text, p_note text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_access_level text;
  v_student public.students%rowtype;
  v_device_id uuid;
  v_last_direction text;
  v_direction text:=upper(trim(coalesce(p_direction,'')));
BEGIN
  v_access_level:=CASE WHEN private.system_access_matches(ARRAY['it_admin'],p_pin) THEN 'administrator' WHEN private.system_access_matches(ARRAY['administrator'],p_pin) THEN 'administrator' WHEN private.system_access_matches(ARRAY['management'],p_pin) THEN 'management' WHEN private.system_access_matches(ARRAY['student_leadership'],p_pin) THEN 'student_leadership' ELSE NULL END;
  IF v_access_level IS NULL THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect password.'); END IF;
  IF v_direction NOT IN ('IN','OUT') THEN RETURN jsonb_build_object('status','invalid','message','Choose On Campus or Off Campus.'); END IF;

  SELECT * INTO v_student FROM public.students
  WHERE registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    AND is_active=true LIMIT 1;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Student not found.'); END IF;

  SELECT id INTO v_device_id FROM public.gate_devices WHERE is_active=true ORDER BY created_at NULLS LAST LIMIT 1;
  IF v_device_id IS NULL THEN RETURN jsonb_build_object('status','configuration_error','message','No active gate device is configured.'); END IF;

  SELECT direction INTO v_last_direction FROM public.campus_movements
  WHERE student_id=v_student.id ORDER BY scanned_at DESC,id DESC LIMIT 1;
  IF v_last_direction IS NOT DISTINCT FROM v_direction THEN
    RETURN jsonb_build_object('status','same_status','message',CASE WHEN v_direction='IN'
      THEN 'Student is already marked on campus.' ELSE 'Student is already marked off campus.' END,
      'student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',v_direction);
  END IF;

  INSERT INTO public.campus_movements(student_id,direction,gate_device_id,movement_source,corrected_by,correction_note)
  VALUES(v_student.id,v_direction,v_device_id,'administrative_update',v_access_level,
    coalesce(nullif(trim(coalesce(p_note,'')),''),'Campus status updated from a dashboard.'));
  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('campus_status','student',v_student.id,v_access_level,
    CASE WHEN v_direction='IN' THEN 'marked_on_campus' ELSE 'marked_off_campus' END,
    jsonb_build_object('registration_number',v_student.registration_number,'note',p_note));

  RETURN jsonb_build_object('status','success','message',CASE WHEN v_direction='IN'
    THEN 'Student marked on campus.' ELSE 'Student marked off campus.' END,
    'student_name',v_student.full_name,'registration_number',v_student.registration_number,
    'direction',v_direction,'access_level',v_access_level);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.dashboard_update_student_campus_status_v2(p_pin text, p_registration_number text, p_direction text, p_outing_type text DEFAULT NULL::text, p_note text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  v_auth jsonb;
  v_access text;
  v_student public.students%rowtype;
  v_device_id uuid;
  v_direction text:=upper(trim(coalesce(p_direction,'')));
  v_outing text:=lower(trim(coalesce(p_outing_type,'')));
  v_last public.campus_movements%rowtype;
  v_code text;
  v_label text;
  v_pass_id uuid;
  v_pass_status text;
  v_pass_destination text;
  v_member_id bigint;
  v_all_returned boolean;
begin
  v_auth:=public.student_services_dashboard_v3(p_pin);
  if coalesce(v_auth->>'status','')<>'success' then
    return jsonb_build_object('status','unauthorized','message','Incorrect password.');
  end if;
  v_access:=v_auth->>'access_level';

  if v_direction not in ('IN','OUT') then
    return jsonb_build_object('status','invalid','message','Choose On Campus or Off Campus.');
  end if;
  if v_outing not in ('','gate_pass','tanaka','mdh','town_other','holiday') then
    return jsonb_build_object('status','invalid','message','Choose a valid outing type.');
  end if;

  select * into v_student from public.students
  where registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    and is_active=true limit 1;
  if not found then return jsonb_build_object('status','not_found','message','Student not found.'); end if;

  select id into v_device_id from public.gate_devices where is_active=true order by created_at nulls last limit 1;
  if v_device_id is null then return jsonb_build_object('status','configuration_error','message','No active gate device is configured.'); end if;

  select * into v_last from public.campus_movements
  where student_id=v_student.id order by scanned_at desc,id desc limit 1;

  if v_direction='IN' then
    if found and v_last.direction='IN' then
      return jsonb_build_object('status','same_status','message','Student is already marked on campus.',
        'student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction','IN');
    end if;

    select p.id,p.status,gm.id into v_pass_id,v_pass_status,v_member_id
    from public.gate_passes p
    join public.gate_pass_members gm on gm.pass_id=p.id
    where gm.student_id=v_student.id
      and gm.actual_departure_at is not null and gm.actual_return_at is null
    order by gm.actual_departure_at desc limit 1
    for update of p,gm;

    if found then
      update public.gate_pass_members set actual_return_at=now(),updated_at=now() where id=v_member_id;
      select not exists(
        select 1 from public.gate_pass_members
        where pass_id=v_pass_id and actual_departure_at is not null and actual_return_at is null
      ) into v_all_returned;
      if v_all_returned then
        update public.gate_passes set status='returned',actual_return_at=now(),updated_at=now() where id=v_pass_id;
        if v_pass_status<>'returned' then
          insert into public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
          values(v_pass_id,v_pass_status,'returned',v_access,'Campus return corrected from dashboard.');
        end if;
      end if;
    end if;
  else
    v_code:=case v_outing when 'gate_pass' then 'PASS' when 'tanaka' then '1' when 'mdh' then '2' when 'town_other' then '3' when 'holiday' then '4' else null end;
    v_label:=case v_outing when 'tanaka' then 'Tanaka/Amalinda Shops' when 'mdh' then 'MDH' when 'town_other' then 'Town/Other' when 'holiday' then 'Holiday' else null end;

    if v_outing='gate_pass' then
      select p.id,p.status,p.destination,gm.id
      into v_pass_id,v_pass_status,v_pass_destination,v_member_id
      from public.gate_passes p
      join public.gate_pass_members gm on gm.pass_id=p.id
      where gm.student_id=v_student.id
        and p.status in ('approved','departed')
        and p.expected_return_at>now()
        and p.departure_at<=now()+interval '24 hours'
      order by case when p.status='departed' then 0 else 1 end,
        abs(extract(epoch from (p.departure_at-now())))
      limit 1 for update of p,gm;

      if not found then
        return jsonb_build_object('status','no_gate_pass','message','No active approved gate pass was found for this student.');
      end if;

      v_label:='Gate pass — '||v_pass_destination;
      update public.gate_pass_members
      set actual_departure_at=coalesce(actual_departure_at,now()),actual_return_at=null,updated_at=now()
      where id=v_member_id;
      update public.gate_passes
      set status='departed',actual_departure_at=coalesce(actual_departure_at,now()),actual_return_at=null,updated_at=now()
      where id=v_pass_id;
      if v_pass_status<>'departed' then
        insert into public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
        values(v_pass_id,v_pass_status,'departed',v_access,'Outing type changed to Gate pass from dashboard.');
      end if;
    end if;

    if v_last.id is not null and v_last.direction='OUT'
       and coalesce(v_last.checkout_destination_code,'')=coalesce(v_code,'')
       and coalesce(v_last.gate_pass_id::text,'')=coalesce(v_pass_id::text,'') then
      return jsonb_build_object('status','same_status','message','Student is already marked off campus with this outing type.',
        'student_name',v_student.full_name,'registration_number',v_student.registration_number,
        'direction','OUT','outing_type',nullif(v_outing,''),'outing_label',v_label,'gate_pass_id',v_pass_id);
    end if;
  end if;

  insert into public.campus_movements(
    student_id,direction,gate_device_id,movement_source,corrected_by,correction_note,
    gate_pass_id,checkout_destination_code,checkout_destination_label
  ) values(
    v_student.id,v_direction,v_device_id,'administrative_update',v_access,
    coalesce(nullif(trim(coalesce(p_note,'')),''),'Campus status updated from a dashboard.'),
    v_pass_id,case when v_direction='OUT' then v_code else null end,
    case when v_direction='OUT' then v_label else null end
  );

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('campus_status','student',v_student.id,v_access,
    case when v_direction='IN' then 'marked_on_campus' else 'marked_off_campus' end,
    jsonb_build_object('registration_number',v_student.registration_number,'note',p_note,
      'outing_type',nullif(v_outing,''),'outing_label',v_label,'gate_pass_id',v_pass_id));

  return jsonb_build_object('status','success',
    'message',case when v_direction='IN' then 'Student marked on campus.' else 'Student marked off campus.' end,
    'student_name',v_student.full_name,'registration_number',v_student.registration_number,
    'direction',v_direction,'access_level',v_access,'outing_type',nullif(v_outing,''),
    'outing_label',v_label,'gate_pass_id',v_pass_id);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.delete_check_ins_for_date(p_service_date date)
 RETURNS integer
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare n integer;
begin
  if not public.is_admin() then raise exception 'Only an administrator can clear records.'; end if;
  delete from public.check_ins where service_date=p_service_date;
  get diagnostics n=row_count;
  return n;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.fee_notice_claim(p_limit integer DEFAULT 10)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_items jsonb;
begin
  update private.fee_notice_outbox
  set status='failed',claimed_at=null,available_at=now(),updated_at=now(),
      last_error='Previous delivery attempt timed out.'
  where status='sending' and claimed_at<now()-interval '15 minutes';

  with picked as (
    select id
    from private.fee_notice_outbox
    where status in ('queued','failed')
      and available_at<=now()
      and attempts<5
    order by created_at
    for update skip locked
    limit least(greatest(coalesce(p_limit,10),1),25)
  ), claimed as (
    update private.fee_notice_outbox o
    set status='sending',attempts=o.attempts+1,claimed_at=now(),updated_at=now()
    from picked
    where o.id=picked.id
    returning o.id,o.registration_id,o.student_id,o.term_id,o.recipient_email,o.subject,o.notice_text,
              o.student_name,o.registration_number,o.outstanding_balance,o.is_test,o.attempts
  )
  select coalesce(jsonb_agg(to_jsonb(claimed)),'[]'::jsonb) into v_items from claimed;

  return jsonb_build_object('status','success','items',v_items);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.fee_notice_complete(p_outbox_id uuid, p_success boolean, p_provider_message_id text DEFAULT NULL::text, p_error text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_row private.fee_notice_outbox%rowtype;
begin
  update private.fee_notice_outbox
  set status=case when coalesce(p_success,false) then 'sent' else 'failed' end,
      sent_at=case when coalesce(p_success,false) then now() else null end,
      provider_message_id=case when coalesce(p_success,false) then left(coalesce(p_provider_message_id,''),300) else null end,
      last_error=case when coalesce(p_success,false) then null else left(coalesce(p_error,'Unknown email delivery error.'),1000) end,
      available_at=case when coalesce(p_success,false) then available_at else now()+make_interval(mins=>least(60,greatest(5,attempts*5))) end,
      claimed_at=null,
      updated_at=now()
  where id=p_outbox_id and status='sending'
  returning * into v_row;

  if not found then return jsonb_build_object('status','not_found'); end if;

  if not v_row.is_test and v_row.student_id is not null and v_row.term_id is not null then
    update public.student_term_fee_status
    set notice_last_delivery_status=v_row.status,
        notice_last_sent_at=case when v_row.status='sent' then v_row.sent_at else notice_last_sent_at end,
        notice_last_recipient=v_row.recipient_email,
        notice_last_error=v_row.last_error,
        updated_at=now()
    where student_id=v_row.student_id and term_id=v_row.term_id;
  end if;

  return jsonb_build_object('status','success','delivery_status',v_row.status,'attempts',v_row.attempts);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.gate_duty_record(p_device_token text, p_registration_number text, p_direction text, p_source text DEFAULT 'scanner'::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'extensions'
AS $function$
declare
  v_device public.gate_devices%rowtype;
  v_student public.students%rowtype;
  v_last public.gate_duty_records%rowtype;
begin
  select * into v_device from public.gate_devices
  where token_hash=encode(digest(p_device_token,'sha256'),'hex') and is_active=true;
  if not found then return jsonb_build_object('status','unauthorized','message','This device is not authorised for gate scanning.'); end if;
  if upper(p_direction) not in ('IN','OUT') then return jsonb_build_object('status','invalid_direction','message','Choose IN or OUT.'); end if;
  if p_source not in ('scanner','manual') then p_source:='scanner'; end if;

  select * into v_student from public.students
  where registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g') and is_active=true limit 1;
  if not found then return jsonb_build_object('status','not_found','message','Student not found.'); end if;

  select * into v_last from public.gate_duty_records where student_id=v_student.id order by scanned_at desc,id desc limit 1;
  if found and v_last.direction=upper(p_direction) then
    if v_last.scanned_at>now()-interval '30 seconds' then
      return jsonb_build_object('status','duplicate','message','Duplicate gate-duty scan ignored.','student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',v_last.direction,'last_scanned_at',v_last.scanned_at);
    end if;
    return jsonb_build_object('status','same_status','message',case when upper(p_direction)='IN' then 'Student is already checked in for gate duty.' else 'Student is already checked out from gate duty.' end,'student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',v_last.direction,'last_scanned_at',v_last.scanned_at);
  end if;

  insert into public.gate_duty_records(student_id,direction,gate_device_id,record_source)
  values(v_student.id,upper(p_direction),v_device.id,p_source);
  update public.gate_devices set last_seen_at=now() where id=v_device.id;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('gate_duty','student',v_student.id,'gate_terminal',lower(p_direction),jsonb_build_object('device_id',v_device.id,'source',p_source));

  return jsonb_build_object('status','success','message',case when upper(p_direction)='IN' then 'Gate duty started.' else 'Gate duty ended.' end,'student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',upper(p_direction),'scanned_at',now());
end;
$function$
;

CREATE OR REPLACE FUNCTION public.gate_pass_student_lookup(p_registration_number text)
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_student public.students%rowtype;
  v_reg text;
BEGIN
  v_reg:=regexp_replace(coalesce(p_registration_number,''),'\D','','g');

  IF length(v_reg)<>5 THEN
    RETURN jsonb_build_object(
      'status','invalid',
      'message','Enter a five-digit registration number.'
    );
  END IF;

  SELECT * INTO v_student
  FROM public.students
  WHERE registration_number::text=v_reg
    AND is_active=true
  LIMIT 1;

  IF NOT FOUND THEN
    RETURN jsonb_build_object(
      'status','not_found',
      'message','No active student was found with registration number '||v_reg||'.'
    );
  END IF;

  RETURN jsonb_build_object(
    'status','success',
    'registration_number',v_student.registration_number,
    'student_name',v_student.full_name
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.gate_pass_student_search(p_query text)
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_query text := trim(regexp_replace(coalesce(p_query,''),'\s+',' ','g'));
  v_digits text := regexp_replace(coalesce(p_query,''),'\D','','g');
  v_matches jsonb;
BEGIN
  IF length(v_query) < 2 AND length(v_digits) < 2 THEN
    RETURN jsonb_build_object(
      'status','invalid',
      'message','Enter at least two letters of the name or two digits of the registration number.',
      'matches','[]'::jsonb
    );
  END IF;

  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'registration_number',x.registration_number,
    'student_name',x.full_name
  ) ORDER BY x.sort_order,x.full_name),'[]'::jsonb)
  INTO v_matches
  FROM (
    SELECT
      s.registration_number,
      s.full_name,
      CASE
        WHEN v_digits <> '' AND s.registration_number::text = v_digits THEN 0
        WHEN lower(s.full_name) = lower(v_query) THEN 1
        WHEN lower(s.full_name) LIKE lower(v_query)||'%' THEN 2
        ELSE 3
      END AS sort_order
    FROM public.students s
    WHERE s.is_active = true
      AND (
        (length(v_digits) >= 2 AND s.registration_number::text LIKE '%'||v_digits||'%')
        OR
        (
          length(v_query) >= 2
          AND NOT EXISTS (
            SELECT 1
            FROM unnest(regexp_split_to_array(lower(v_query),'\s+')) AS term(value)
            WHERE term.value <> ''
              AND lower(s.full_name) NOT LIKE '%'||term.value||'%'
          )
        )
      )
    ORDER BY sort_order,s.full_name
    LIMIT 12
  ) x;

  RETURN jsonb_build_object(
    'status','success',
    'query',v_query,
    'matches',v_matches
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.gate_record_movement(p_device_token text, p_registration_number text, p_direction text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'extensions'
AS $function$
declare
 v_device public.gate_devices%rowtype;
 v_student public.students%rowtype;
 v_last public.campus_movements%rowtype;
begin
 select * into v_device from public.gate_devices
 where token_hash=encode(digest(p_device_token,'sha256'),'hex') and is_active=true;
 if not found then return jsonb_build_object('status','unauthorized','message','This device is not authorised for gate scanning.'); end if;
 if upper(p_direction) not in ('IN','OUT') then return jsonb_build_object('status','invalid_direction','message','Choose IN or OUT.'); end if;
 select * into v_student from public.students
 where registration_number::text=regexp_replace(p_registration_number,'\D','','g') and is_active=true limit 1;
 if not found then return jsonb_build_object('status','not_found','message','Student not found.'); end if;
 select * into v_last from public.campus_movements where student_id=v_student.id order by scanned_at desc,id desc limit 1;
 if found and v_last.direction=upper(p_direction) then
   if v_last.scanned_at>now()-interval '30 seconds' then
     return jsonb_build_object('status','duplicate','message','Duplicate scan ignored.','student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',v_last.direction,'last_scanned_at',v_last.scanned_at);
   end if;
   return jsonb_build_object('status','same_status','message',case when upper(p_direction)='IN' then 'Student is already marked on campus.' else 'Student is already marked off campus.' end,'student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',v_last.direction,'last_scanned_at',v_last.scanned_at);
 end if;
 insert into public.campus_movements(student_id,direction,gate_device_id) values(v_student.id,upper(p_direction),v_device.id);
 update public.gate_devices set last_seen_at=now() where id=v_device.id;
 return jsonb_build_object('status','success','message',case when upper(p_direction)='IN' then 'Checked in to campus.' else 'Checked out of campus.' end,'student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',upper(p_direction),'scanned_at',now());
end;
$function$
;

CREATE OR REPLACE FUNCTION public.gate_record_movement_v2(p_device_token text, p_registration_number text, p_direction text, p_source text DEFAULT 'scanner'::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'extensions'
AS $function$
declare
  v_device public.gate_devices%rowtype;
  v_student public.students%rowtype;
  v_last public.campus_movements%rowtype;
  v_source text := lower(coalesce(p_source,'scanner'));
begin
  select * into v_device
  from public.gate_devices
  where token_hash=encode(digest(p_device_token,'sha256'),'hex')
    and is_active=true;

  if not found then
    return jsonb_build_object('status','unauthorized','message','This device is not authorised for gate scanning.');
  end if;

  if upper(p_direction) not in ('IN','OUT') then
    return jsonb_build_object('status','invalid_direction','message','Choose IN or OUT.');
  end if;

  if v_source not in ('scanner','camera','manual') then
    v_source := 'scanner';
  end if;

  select * into v_student
  from public.students
  where registration_number::text=regexp_replace(p_registration_number,'\D','','g')
    and is_active=true
  limit 1;

  if not found then
    return jsonb_build_object('status','not_found','message','Student not found.');
  end if;

  select * into v_last
  from public.campus_movements
  where student_id=v_student.id
  order by scanned_at desc,id desc
  limit 1;

  if found and v_last.direction=upper(p_direction) then
    if v_last.scanned_at>now()-interval '30 seconds' then
      return jsonb_build_object(
        'status','duplicate','message','Duplicate scan ignored.',
        'student_name',v_student.full_name,
        'registration_number',v_student.registration_number,
        'direction',v_last.direction,
        'last_scanned_at',v_last.scanned_at
      );
    end if;

    return jsonb_build_object(
      'status','same_status',
      'message',case when upper(p_direction)='IN' then 'Student is already marked on campus.' else 'Student is already marked off campus.' end,
      'student_name',v_student.full_name,
      'registration_number',v_student.registration_number,
      'direction',v_last.direction,
      'last_scanned_at',v_last.scanned_at
    );
  end if;

  insert into public.campus_movements(student_id,direction,gate_device_id,movement_source)
  values(v_student.id,upper(p_direction),v_device.id,v_source);

  update public.gate_devices set last_seen_at=now() where id=v_device.id;

  return jsonb_build_object(
    'status','success',
    'message',case when upper(p_direction)='IN' then 'Checked in to campus.' else 'Checked out of campus.' end,
    'student_name',v_student.full_name,
    'registration_number',v_student.registration_number,
    'direction',upper(p_direction),
    'source',v_source,
    'scanned_at',now()
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.gate_record_movement_v3(p_device_token text, p_registration_number text, p_direction text, p_source text DEFAULT 'scanner'::text, p_checkout_option text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'extensions'
AS $function$
DECLARE
  v_device public.gate_devices%rowtype;
  v_student public.students%rowtype;
  v_last public.campus_movements%rowtype;
  v_pass_id uuid;
  v_pass_status text;
  v_pass_destination text;
  v_member_id bigint;
  v_pilot boolean;
  v_holiday boolean := false;
  v_message text;
  v_has_pass boolean := false;
  v_code text;
  v_label text;
  v_source text := lower(coalesce(p_source,'scanner'));
  v_all_returned boolean := false;
BEGIN
  SELECT * INTO v_device FROM public.gate_devices
  WHERE token_hash=encode(digest(p_device_token,'sha256'),'hex') AND is_active=true;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','unauthorized','message','This device is not authorised for gate scanning.'); END IF;

  IF upper(p_direction) NOT IN ('IN','OUT') THEN RETURN jsonb_build_object('status','invalid_direction','message','Choose IN or OUT.'); END IF;
  IF v_source NOT IN ('scanner','manual') THEN v_source:='scanner'; END IF;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_holiday
  FROM public.system_settings WHERE setting_key='school_holiday_mode';

  SELECT * INTO v_student FROM public.students
  WHERE registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g') AND is_active=true LIMIT 1;
  IF NOT FOUND THEN RETURN jsonb_build_object('status','not_found','message','Student not found.'); END IF;

  SELECT * INTO v_last FROM public.campus_movements WHERE student_id=v_student.id ORDER BY scanned_at DESC,id DESC LIMIT 1;
  IF FOUND AND v_last.direction=upper(p_direction) THEN
    IF v_last.scanned_at>now()-interval '30 seconds' THEN
      RETURN jsonb_build_object('status','duplicate','message','Duplicate scan ignored.','student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',v_last.direction,'last_scanned_at',v_last.scanned_at);
    END IF;
    RETURN jsonb_build_object('status','same_status','message',CASE WHEN upper(p_direction)='IN' THEN 'Student is already marked on campus.' ELSE 'Student is already marked off campus.' END,'student_name',v_student.full_name,'registration_number',v_student.registration_number,'direction',v_last.direction,'last_scanned_at',v_last.scanned_at);
  END IF;

  IF upper(p_direction)='OUT' THEN
    SELECT p.id,p.status,p.destination,gm.id
    INTO v_pass_id,v_pass_status,v_pass_destination,v_member_id
    FROM public.gate_passes p
    JOIN public.gate_pass_members gm ON gm.pass_id=p.id
    WHERE gm.student_id=v_student.id
      AND p.status IN ('approved','departed','returned')
      AND p.departure_at BETWEEN now()-interval '12 hours' AND now()+interval '12 hours'
      AND p.expected_return_at>now()
    ORDER BY p.departure_at
    LIMIT 1
    FOR UPDATE OF p,gm;

    IF FOUND THEN
      UPDATE public.gate_pass_members SET actual_departure_at=now(),actual_return_at=NULL,updated_at=now() WHERE id=v_member_id;
      UPDATE public.gate_passes SET status='departed',actual_departure_at=coalesce(actual_departure_at,now()),actual_return_at=NULL,updated_at=now() WHERE id=v_pass_id;
      IF v_pass_status<>'departed' THEN
        INSERT INTO public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
        VALUES(v_pass_id,v_pass_status,'departed','gate_terminal','A person on the shared gate pass scanned out at the gate.');
      END IF;
      v_has_pass:=true;
      v_label:=v_pass_destination;
      v_message:='Personal gate pass verified.';
    ELSE
      v_code:=trim(coalesce(p_checkout_option,''));
      v_label:=CASE v_code WHEN '1' THEN 'Tanaka/Amalinda Shops' WHEN '2' THEN 'MDH' WHEN '3' THEN 'Town/Other' WHEN '4' THEN CASE WHEN v_holiday THEN 'Holiday' ELSE NULL END ELSE NULL END;
      IF v_label IS NULL THEN
        RETURN jsonb_build_object(
          'status','destination_required',
          'message',CASE WHEN v_holiday THEN 'No approved gate pass. Select 1, 2, 3 or 4 before scanning again.' ELSE 'No approved gate pass. Select 1, 2 or 3 before scanning again.' END,
          'student_name',v_student.full_name,'registration_number',v_student.registration_number,
          'direction','OUT','school_holiday_mode',v_holiday,
          'options',CASE WHEN v_holiday THEN jsonb_build_array(
            jsonb_build_object('code','1','label','Tanaka/Amalinda Shops'),jsonb_build_object('code','2','label','MDH'),jsonb_build_object('code','3','label','Town/Other'),jsonb_build_object('code','4','label','Holiday')
          ) ELSE jsonb_build_array(
            jsonb_build_object('code','1','label','Tanaka/Amalinda Shops'),jsonb_build_object('code','2','label','MDH'),jsonb_build_object('code','3','label','Town/Other')
          ) END
        );
      END IF;
      v_message:='Checked out to '||v_label||' without a personal gate pass.';
    END IF;
  ELSE
    SELECT p.id,p.status,gm.id
    INTO v_pass_id,v_pass_status,v_member_id
    FROM public.gate_passes p
    JOIN public.gate_pass_members gm ON gm.pass_id=p.id
    WHERE gm.student_id=v_student.id
      AND gm.actual_departure_at IS NOT NULL
      AND gm.actual_return_at IS NULL
    ORDER BY gm.actual_departure_at DESC
    LIMIT 1
    FOR UPDATE OF p,gm;

    IF FOUND THEN
      UPDATE public.gate_pass_members SET actual_return_at=now(),updated_at=now() WHERE id=v_member_id;
      SELECT NOT EXISTS(
        SELECT 1 FROM public.gate_pass_members
        WHERE pass_id=v_pass_id AND actual_departure_at IS NOT NULL AND actual_return_at IS NULL
      ) INTO v_all_returned;

      IF v_all_returned THEN
        UPDATE public.gate_passes SET status='returned',actual_return_at=now(),updated_at=now() WHERE id=v_pass_id;
        INSERT INTO public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
        VALUES(v_pass_id,v_pass_status,'returned','gate_terminal','Everyone who departed on the shared gate pass has returned.');
      ELSE
        UPDATE public.gate_passes SET status='departed',updated_at=now() WHERE id=v_pass_id;
      END IF;

      v_has_pass:=true;
      v_message:=CASE WHEN v_all_returned THEN 'Return linked to the personal gate pass. Everyone has returned.' ELSE 'Return linked to the shared gate pass. Other people are still out.' END;
    ELSE
      v_message:='Campus movement recorded.';
    END IF;
  END IF;

  INSERT INTO public.campus_movements(student_id,direction,gate_device_id,movement_source,gate_pass_id,checkout_destination_code,checkout_destination_label)
  VALUES(v_student.id,upper(p_direction),v_device.id,v_source,CASE WHEN v_has_pass THEN v_pass_id ELSE NULL END,v_code,v_label);

  UPDATE public.gate_devices SET last_seen_at=now() WHERE id=v_device.id;
  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_pilot FROM public.system_settings WHERE setting_key='gate_pass_pilot_mode';

  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('campus_movement','student',v_student.id,'gate_terminal',lower(p_direction),jsonb_build_object(
    'device_id',v_device.id,'source',v_source,'gate_pass_id',CASE WHEN v_has_pass THEN v_pass_id ELSE NULL END,
    'checkout_destination_code',v_code,'checkout_destination_label',v_label,'school_holiday_mode',v_holiday
  ));

  RETURN jsonb_build_object(
    'status','success','message',v_message,'student_name',v_student.full_name,
    'registration_number',v_student.registration_number,'direction',upper(p_direction),
    'scanned_at',now(),'gate_pass_id',CASE WHEN v_has_pass THEN v_pass_id ELSE NULL END,
    'gate_pass_status',CASE WHEN v_has_pass THEN 'verified' ELSE 'not_linked' END,
    'checkout_destination_code',v_code,'checkout_destination_label',v_label,
    'paper_pass_pilot_mode',v_pilot,'school_holiday_mode',v_holiday
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.gate_terminal_heartbeat(p_device_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'extensions'
AS $function$
declare
  v_device public.gate_devices%rowtype;
  v_holiday boolean := false;
begin
  select * into v_device
  from public.gate_devices
  where token_hash=encode(digest(p_device_token,'sha256'),'hex')
    and is_active=true;

  if not found then
    return jsonb_build_object('status','unauthorized');
  end if;

  select coalesce((setting_value #>> '{}')::boolean,false)
  into v_holiday
  from public.system_settings
  where setting_key='school_holiday_mode';

  update public.gate_devices set last_seen_at=now() where id=v_device.id;

  return jsonb_build_object(
    'status','success',
    'device_name',v_device.device_name,
    'location',v_device.location,
    'server_time',now(),
    'school_holiday_mode',coalesce(v_holiday,false)
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
begin
  insert into public.profiles(id,display_name,role,is_active)
  values(new.id,coalesce(nullif(new.raw_user_meta_data->>'display_name',''),new.email,'Kitchen staff'),'kitchen_head',true)
  on conflict(id) do nothing;
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.immigration_document_authorize(p_session_type text, p_session_token text, p_action text, p_student_id text DEFAULT NULL::text, p_document_id uuid DEFAULT NULL::uuid, p_file_name text DEFAULT NULL::text, p_document_type text DEFAULT NULL::text, p_mime_type text DEFAULT NULL::text, p_file_size bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text; v_can_edit boolean; v_context record; v_doc public.student_immigration_documents%rowtype;
  v_id uuid; v_safe_name text; v_path text;
begin
  if lower(coalesce(p_session_type,''))='ops' then
    select * into v_context from private.immigration_session_context(p_session_token,p_action in('prepare_upload','confirm_upload','delete'));
    v_role:=v_context.actor_role; v_can_edit:=v_context.can_edit;
  elsif lower(coalesce(p_session_type,''))='system' then
    select c.role_key into v_role from private.system_session_context(p_session_token,array['administrator','it_admin','admin_staff','management']) c limit 1;
    if v_role is null then raise exception 'Your Administration session has expired.' using errcode='28000'; end if;
    v_can_edit:=v_role<>'management';
    if p_action in('prepare_upload','confirm_upload','delete') and not v_can_edit then raise exception 'Management access is read-only.' using errcode='42501'; end if;
  else return jsonb_build_object('status','invalid','message','Unknown session type.'); end if;
  if p_action='prepare_upload' then
    if not exists(select 1 from public.students where id=p_student_id and is_active) then return jsonb_build_object('status','not_found','message','Student not found.'); end if;
    if p_mime_type not in('application/pdf','image/jpeg','image/png','image/webp') then return jsonb_build_object('status','invalid','message','Upload a PDF, JPEG, PNG or WebP file.'); end if;
    if coalesce(p_file_size,0)<1 or p_file_size>10485760 then return jsonb_build_object('status','invalid','message','The document must be no larger than 10 MB.'); end if;
    v_id:=gen_random_uuid();
    v_safe_name:=regexp_replace(lower(coalesce(p_file_name,'document')),'[^a-z0-9._-]+','-','g');
    v_path:=p_student_id||'/'||v_id::text||'-'||left(v_safe_name,100);
    insert into public.student_immigration_documents(id,student_id,document_type,file_name,storage_path,mime_type,file_size,uploaded_by)
    values(v_id,p_student_id,coalesce(nullif(btrim(p_document_type),''),'Other'),coalesce(nullif(btrim(p_file_name),''),'document'),v_path,p_mime_type,p_file_size,v_role);
    return jsonb_build_object('status','success','allowed',true,'bucket','immigration-documents','document_id',v_id,'storage_path',v_path);
  end if;
  select * into v_doc from public.student_immigration_documents where id=p_document_id;
  if not found then return jsonb_build_object('status','not_found','message','Document not found.'); end if;
  if p_student_id is not null and v_doc.student_id<>p_student_id then return jsonb_build_object('status','unauthorized','message','Document does not belong to this student.'); end if;
  return jsonb_build_object('status','success','allowed',true,'can_edit',v_can_edit,'bucket','immigration-documents',
    'document_id',v_doc.id,'student_id',v_doc.student_id,'storage_path',v_doc.storage_path,'file_name',v_doc.file_name,'mime_type',v_doc.mime_type);
end
$function$
;

CREATE OR REPLACE FUNCTION public.is_active_staff()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select exists(select 1 from public.profiles where id=auth.uid() and is_active=true)
$function$
;

CREATE OR REPLACE FUNCTION public.is_admin()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select exists(select 1 from public.profiles where id=auth.uid() and is_active=true and role='admin')
$function$
;

CREATE OR REPLACE FUNCTION public.it_admin_records_bootstrap(p_session_token text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'pg_catalog'
AS $function$select it_admin_private.bootstrap(p_session_token)$function$
;

CREATE OR REPLACE FUNCTION public.it_admin_records_command(p_session_token text, p_entity text, p_action text, p_key jsonb DEFAULT '{}'::jsonb, p_values jsonb DEFAULT '{}'::jsonb, p_revision text DEFAULT NULL::text, p_actor_name text DEFAULT NULL::text, p_reason text DEFAULT NULL::text, p_confirmation text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'pg_catalog'
AS $function$select it_admin_private.command(p_session_token,p_entity,p_action,p_key,p_values,p_revision,p_actor_name,p_reason,p_confirmation)$function$
;

CREATE OR REPLACE FUNCTION public.it_admin_records_list(p_session_token text, p_entity text, p_query text DEFAULT ''::text, p_page integer DEFAULT 0)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'pg_catalog'
AS $function$select it_admin_private.records(p_session_token,p_entity,p_query,p_page)$function$
;

CREATE OR REPLACE FUNCTION public.it_admin_records_lookups(p_session_token text, p_entity text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'pg_catalog'
AS $function$select it_admin_private.lookups(p_session_token,p_entity)$function$
;

CREATE OR REPLACE FUNCTION public.library_bootstrap(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_settings jsonb;
  v_titles jsonb;
  v_active_loans jsonb;
  v_recent_loans jsonb;
  v_audit jsonb;
  v_title_count integer;
  v_copy_count integer;
  v_available_count integer;
  v_active_count integer;
  v_overdue_count integer;
begin
  select * into v_context from private.library_context(p_session_token);
  if not found then return jsonb_build_object('status','unauthorized','message','Your library session has ended.'); end if;

  select coalesce(jsonb_object_agg(setting_key,setting_value),'{}'::jsonb)
  into v_settings from public.library_settings;

  select coalesce(jsonb_agg(to_jsonb(q) order by q.title,q.author),'[]'::jsonb)
  into v_titles
  from (
    select t.id,t.isbn,t.title,t.subtitle,t.author,t.publisher,t.publication_year,
           t.category,t.shelf_location,t.notes,t.active,t.created_at,t.updated_at,
           count(c.id) filter(where c.status<>'withdrawn')::integer as copy_count,
           count(c.id) filter(where c.status='available')::integer as available_count,
           count(c.id) filter(where c.status='on_loan')::integer as on_loan_count,
           coalesce(jsonb_agg(jsonb_build_object(
             'id',c.id,'barcode',c.barcode,'accession_number',c.accession_number,
             'status',c.status,'condition_notes',c.condition_notes,'acquired_on',c.acquired_on
           ) order by c.barcode) filter(where c.id is not null),'[]'::jsonb) as copies
    from public.library_titles t
    left join public.library_copies c on c.title_id=t.id
    group by t.id
  ) q;

  select coalesce(jsonb_agg(to_jsonb(q) order by q.due_date,q.borrower_name),'[]'::jsonb)
  into v_active_loans
  from (
    select l.id,l.borrower_type,l.student_id,l.borrower_name,
           l.borrower_registration_number,l.borrowed_at,l.due_date,l.renew_count,l.notes,
           l.issued_by_name,c.id copy_id,c.barcode,c.accession_number,t.id title_id,t.title,t.author,
           l.due_date<current_date as overdue,(current_date-l.due_date)::integer as days_overdue
    from public.library_loans l
    join public.library_copies c on c.id=l.copy_id
    join public.library_titles t on t.id=c.title_id
    where l.returned_at is null
  ) q;

  select coalesce(jsonb_agg(to_jsonb(q) order by q.activity_at desc),'[]'::jsonb)
  into v_recent_loans
  from (
    select l.id,l.borrower_type,l.borrower_name,l.borrower_registration_number,
           l.borrowed_at,l.due_date,l.returned_at,l.renew_count,l.issued_by_name,l.returned_by_name,
           c.barcode,t.title,t.author,coalesce(l.returned_at,l.borrowed_at) activity_at
    from public.library_loans l
    join public.library_copies c on c.id=l.copy_id
    join public.library_titles t on t.id=c.title_id
    order by coalesce(l.returned_at,l.borrowed_at) desc
    limit 500
  ) q;

  select count(*) into v_title_count from public.library_titles where active;
  select count(*) into v_copy_count from public.library_copies where status<>'withdrawn';
  select count(*) into v_available_count from public.library_copies where status='available';
  select count(*) into v_active_count from public.library_loans where returned_at is null;
  select count(*) into v_overdue_count from public.library_loans where returned_at is null and due_date<current_date;

  if v_context.can_manage_settings then
    select coalesce(jsonb_agg(to_jsonb(q) order by q.event_at desc),'[]'::jsonb)
    into v_audit
    from (
      select id,event_at,actor_role,actor_name,action,entity_type,entity_id,details
      from public.library_audit_log order by event_at desc limit 100
    ) q;
  else
    v_audit:='[]'::jsonb;
  end if;

  return jsonb_build_object(
    'status','success','role',v_context.role_key,'role_label',v_context.role_label,
    'can_manage_settings',v_context.can_manage_settings,'settings',v_settings,
    'summary',jsonb_build_object('titles',v_title_count,'copies',v_copy_count,
      'available',v_available_count,'active_loans',v_active_count,'overdue',v_overdue_count),
    'titles',v_titles,'active_loans',v_active_loans,'recent_loans',v_recent_loans,
    'audit',v_audit,'loaded_at',now()
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.library_command(p_session_token text, p_action text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_action text:=lower(trim(coalesce(p_action,'')));
  v_actor text:=nullif(trim(coalesce(p_payload->>'actor_name','')),'');
  v_title public.library_titles%rowtype;
  v_copy public.library_copies%rowtype;
  v_loan public.library_loans%rowtype;
  v_student public.students%rowtype;
  v_id uuid;
  v_title_id uuid;
  v_copy_id uuid;
  v_loan_days integer;
  v_max_loans integer;
  v_max_renewals integer;
  v_count integer;
  v_due date;
  v_value jsonb;
begin
  select * into v_context from private.library_context(p_session_token);
  if not found then return jsonb_build_object('status','unauthorized','message','Your library session has ended.'); end if;
  if v_actor is null then return jsonb_build_object('status','invalid','message','Enter your name for the audit record.'); end if;

  if v_action='save_title' then
    if length(trim(coalesce(p_payload->>'title','')))<2 then
      return jsonb_build_object('status','invalid','message','Enter the book title.');
    end if;
    begin v_id:=nullif(p_payload->>'id','')::uuid; exception when others then v_id:=null; end;
    if v_id is null then
      insert into public.library_titles(
        isbn,title,subtitle,author,publisher,publication_year,category,shelf_location,notes
      ) values(
        nullif(trim(p_payload->>'isbn'),''),trim(p_payload->>'title'),nullif(trim(p_payload->>'subtitle'),''),
        nullif(trim(p_payload->>'author'),''),nullif(trim(p_payload->>'publisher'),''),
        nullif(p_payload->>'publication_year','')::integer,nullif(trim(p_payload->>'category'),''),
        nullif(trim(p_payload->>'shelf_location'),''),nullif(trim(p_payload->>'notes'),'')
      ) returning * into v_title;
      perform private.library_audit(v_context.role_key,v_actor,'title_created','library_title',v_title.id::text,
        jsonb_build_object('title',v_title.title));
    else
      update public.library_titles set
        isbn=nullif(trim(p_payload->>'isbn'),''),title=trim(p_payload->>'title'),
        subtitle=nullif(trim(p_payload->>'subtitle'),''),author=nullif(trim(p_payload->>'author'),''),
        publisher=nullif(trim(p_payload->>'publisher'),''),publication_year=nullif(p_payload->>'publication_year','')::integer,
        category=nullif(trim(p_payload->>'category'),''),shelf_location=nullif(trim(p_payload->>'shelf_location'),''),
        notes=nullif(trim(p_payload->>'notes'),'')
      where id=v_id returning * into v_title;
      if not found then return jsonb_build_object('status','not_found','message','Catalogue title not found.'); end if;
      perform private.library_audit(v_context.role_key,v_actor,'title_updated','library_title',v_title.id::text,
        jsonb_build_object('title',v_title.title));
    end if;
    return jsonb_build_object('status','success','title_id',v_title.id,'title',v_title.title);

  elsif v_action='add_copy' then
    begin v_title_id:=(p_payload->>'title_id')::uuid; exception when others then return jsonb_build_object('status','invalid','message','Choose a catalogue title.'); end;
    if length(trim(coalesce(p_payload->>'barcode','')))<2 then return jsonb_build_object('status','invalid','message','Scan or enter a copy barcode.'); end if;
    select * into v_title from public.library_titles where id=v_title_id and active;
    if not found then return jsonb_build_object('status','not_found','message','Catalogue title not found.'); end if;
    insert into public.library_copies(title_id,barcode,accession_number,condition_notes,acquired_on)
    values(v_title_id,trim(p_payload->>'barcode'),nullif(trim(p_payload->>'accession_number'),''),
      nullif(trim(p_payload->>'condition_notes'),''),nullif(p_payload->>'acquired_on','')::date)
    returning * into v_copy;
    perform private.library_audit(v_context.role_key,v_actor,'copy_created','library_copy',v_copy.id::text,
      jsonb_build_object('title',v_title.title,'barcode',v_copy.barcode));
    return jsonb_build_object('status','success','copy_id',v_copy.id,'barcode',v_copy.barcode);

  elsif v_action='update_copy' then
    begin v_copy_id:=(p_payload->>'copy_id')::uuid; exception when others then return jsonb_build_object('status','invalid','message','Choose a copy.'); end;
    if coalesce(p_payload->>'status','') not in ('available','missing','damaged','withdrawn') then
      return jsonb_build_object('status','invalid','message','Choose Available, Missing, Damaged, or Withdrawn.');
    end if;
    if exists(select 1 from public.library_loans where copy_id=v_copy_id and returned_at is null) then
      return jsonb_build_object('status','invalid','message','Return the active loan before changing this copy status.');
    end if;
    update public.library_copies set status=p_payload->>'status',condition_notes=nullif(trim(p_payload->>'condition_notes'),'')
    where id=v_copy_id returning * into v_copy;
    if not found then return jsonb_build_object('status','not_found','message','Book copy not found.'); end if;
    perform private.library_audit(v_context.role_key,v_actor,'copy_status_changed','library_copy',v_copy.id::text,
      jsonb_build_object('barcode',v_copy.barcode,'status',v_copy.status));
    return jsonb_build_object('status','success','copy_id',v_copy.id,'status_value',v_copy.status);

  elsif v_action='checkout' then
    select * into v_copy from public.library_copies where barcode=trim(coalesce(p_payload->>'barcode','')) for update;
    if not found then return jsonb_build_object('status','not_found','message','No library copy matches that barcode.'); end if;
    if v_copy.status<>'available' then return jsonb_build_object('status','invalid','message','This copy is not available.'); end if;
    select * into v_student from public.students
    where registration_number::text=regexp_replace(coalesce(p_payload->>'registration_number',''),'\D','','g') and is_active limit 1;
    if not found then return jsonb_build_object('status','not_found','message','Active student not found.'); end if;
    select coalesce((setting_value #>> '{}')::integer,14) into v_loan_days from public.library_settings where setting_key='loan_days';
    select coalesce((setting_value #>> '{}')::integer,3) into v_max_loans from public.library_settings where setting_key='max_active_loans';
    select count(*) into v_count from public.library_loans where student_id=v_student.id and returned_at is null;
    if v_count>=v_max_loans then return jsonb_build_object('status','invalid','message','This student has reached the active-loan limit.'); end if;
    v_due:=coalesce(nullif(p_payload->>'due_date','')::date,current_date+v_loan_days);
    if v_due<current_date then return jsonb_build_object('status','invalid','message','Due date cannot be in the past.'); end if;
    insert into public.library_loans(
      copy_id,borrower_type,student_id,borrower_name,borrower_registration_number,due_date,issued_by_name,notes
    ) values(
      v_copy.id,'student',v_student.id,v_student.full_name,v_student.registration_number,v_due,v_actor,
      nullif(trim(p_payload->>'notes'),'')
    ) returning * into v_loan;
    update public.library_copies set status='on_loan' where id=v_copy.id;
    perform private.library_audit(v_context.role_key,v_actor,'checked_out','library_loan',v_loan.id::text,
      jsonb_build_object('barcode',v_copy.barcode,'borrower',v_student.full_name,
        'registration_number',v_student.registration_number,'due_date',v_due));
    return jsonb_build_object('status','success','loan_id',v_loan.id,'borrower_name',v_student.full_name,'due_date',v_due);

  elsif v_action='checkout_staff' then
    select * into v_copy from public.library_copies where barcode=trim(coalesce(p_payload->>'barcode','')) for update;
    if not found then return jsonb_build_object('status','not_found','message','No library copy matches that barcode.'); end if;
    if v_copy.status<>'available' then return jsonb_build_object('status','invalid','message','This copy is not available.'); end if;
    if length(trim(coalesce(p_payload->>'borrower_name','')))<2 then return jsonb_build_object('status','invalid','message','Enter the staff borrower name.'); end if;
    select coalesce((setting_value #>> '{}')::integer,14) into v_loan_days from public.library_settings where setting_key='loan_days';
    select coalesce((setting_value #>> '{}')::integer,3) into v_max_loans from public.library_settings where setting_key='max_active_loans';
    select count(*) into v_count from public.library_loans
    where borrower_type='staff' and lower(borrower_name)=lower(trim(p_payload->>'borrower_name')) and returned_at is null;
    if v_count>=v_max_loans then return jsonb_build_object('status','invalid','message','This staff borrower has reached the active-loan limit.'); end if;
    v_due:=coalesce(nullif(p_payload->>'due_date','')::date,current_date+v_loan_days);
    insert into public.library_loans(copy_id,borrower_type,borrower_name,due_date,issued_by_name,notes)
    values(v_copy.id,'staff',trim(p_payload->>'borrower_name'),v_due,v_actor,nullif(trim(p_payload->>'notes'),''))
    returning * into v_loan;
    update public.library_copies set status='on_loan' where id=v_copy.id;
    perform private.library_audit(v_context.role_key,v_actor,'checked_out','library_loan',v_loan.id::text,
      jsonb_build_object('barcode',v_copy.barcode,'borrower',v_loan.borrower_name,'due_date',v_due));
    return jsonb_build_object('status','success','loan_id',v_loan.id,'borrower_name',v_loan.borrower_name,'due_date',v_due);

  elsif v_action='return' then
    select l.* into v_loan
    from public.library_loans l join public.library_copies c on c.id=l.copy_id
    where c.barcode=trim(coalesce(p_payload->>'barcode','')) and l.returned_at is null
    for update of l;
    if not found then return jsonb_build_object('status','not_found','message','No active loan matches that barcode.'); end if;
    update public.library_loans set returned_at=now(),returned_by_name=v_actor,
      returned_condition=nullif(trim(p_payload->>'condition_notes'),'') where id=v_loan.id;
    update public.library_copies set
      status=case when p_payload->>'return_status'='damaged' then 'damaged' else 'available' end,
      condition_notes=coalesce(nullif(trim(p_payload->>'condition_notes'),''),condition_notes)
    where id=v_loan.copy_id returning * into v_copy;
    perform private.library_audit(v_context.role_key,v_actor,'returned','library_loan',v_loan.id::text,
      jsonb_build_object('barcode',v_copy.barcode,'borrower',v_loan.borrower_name,'copy_status',v_copy.status));
    return jsonb_build_object('status','success','loan_id',v_loan.id,'borrower_name',v_loan.borrower_name,'copy_status',v_copy.status);

  elsif v_action='renew' then
    begin v_id:=(p_payload->>'loan_id')::uuid; exception when others then return jsonb_build_object('status','invalid','message','Choose an active loan.'); end;
    select * into v_loan from public.library_loans where id=v_id and returned_at is null for update;
    if not found then return jsonb_build_object('status','not_found','message','Active loan not found.'); end if;
    select coalesce((setting_value #>> '{}')::integer,14) into v_loan_days from public.library_settings where setting_key='loan_days';
    select coalesce((setting_value #>> '{}')::integer,1) into v_max_renewals from public.library_settings where setting_key='max_renewals';
    if v_loan.renew_count>=v_max_renewals then return jsonb_build_object('status','invalid','message','This loan has reached the renewal limit.'); end if;
    v_due:=greatest(v_loan.due_date,current_date)+v_loan_days;
    update public.library_loans set due_date=v_due,renew_count=renew_count+1 where id=v_loan.id returning * into v_loan;
    perform private.library_audit(v_context.role_key,v_actor,'renewed','library_loan',v_loan.id::text,
      jsonb_build_object('borrower',v_loan.borrower_name,'due_date',v_due,'renew_count',v_loan.renew_count));
    return jsonb_build_object('status','success','loan_id',v_loan.id,'due_date',v_due,'renew_count',v_loan.renew_count);

  elsif v_action='save_setting' then
    if not v_context.can_manage_settings then return jsonb_build_object('status','unauthorized','message','Administrator access is required for library rules.'); end if;
    if p_payload->>'setting_key' not in ('loan_days','max_active_loans','max_renewals','public_catalog_enabled') then
      return jsonb_build_object('status','invalid','message','This library setting cannot be changed here.');
    end if;
    v_value:=p_payload->'setting_value';
    if p_payload->>'setting_key' in ('loan_days','max_active_loans','max_renewals')
       and ((v_value #>> '{}')::integer<0 or (v_value #>> '{}')::integer>365) then
      return jsonb_build_object('status','invalid','message','Enter a sensible whole-number setting.');
    end if;
    insert into public.library_settings(setting_key,setting_value,updated_at,updated_by_role)
    values(p_payload->>'setting_key',v_value,now(),v_context.role_key)
    on conflict(setting_key) do update set setting_value=excluded.setting_value,updated_at=now(),updated_by_role=excluded.updated_by_role;
    perform private.library_audit(v_context.role_key,v_actor,'setting_updated','library_setting',p_payload->>'setting_key',jsonb_build_object('value',v_value));
    return jsonb_build_object('status','success','setting_key',p_payload->>'setting_key','setting_value',v_value);
  else
    return jsonb_build_object('status','invalid','message','Unknown library action.');
  end if;
exception
  when unique_violation then return jsonb_build_object('status','invalid','message','That barcode, accession number, or active loan already exists.');
  when invalid_text_representation then return jsonb_build_object('status','invalid','message','One of the entered values is not valid.');
  when check_violation then return jsonb_build_object('status','invalid','message','One of the entered values is outside the allowed range.');
end
$function$
;

CREATE OR REPLACE FUNCTION public.library_login(p_role text, p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'extensions', 'pg_catalog'
AS $function$
declare
  v_role text:=lower(trim(coalesce(p_role,'')));
  v_credential public.system_access_credentials%rowtype;
  v_token text;
begin
  if v_role not in ('library_staff','administrator','it_admin') then
    return jsonb_build_object('status','unauthorized','message','Choose a valid library access role.');
  end if;
  select * into v_credential from public.system_access_credentials where role_key=v_role for update;
  if not found or not v_credential.active or v_credential.access_hash is null then
    return jsonb_build_object('status','unavailable','message','This library access role has not been enabled. IT Administration can set its PIN.');
  end if;
  if v_credential.locked_until is not null and v_credential.locked_until>now() then
    return jsonb_build_object('status','locked','message','Too many incorrect attempts. Try again later.');
  end if;
  if v_credential.access_hash<>extensions.crypt(coalesce(p_pin,''),v_credential.access_hash) then
    update public.system_access_credentials
    set failed_attempts=failed_attempts+1,
        locked_until=case when failed_attempts+1>=5 then now()+interval '15 minutes' else null end,
        updated_at=now()
    where role_key=v_role;
    return jsonb_build_object('status','unauthorized','message','Incorrect PIN.');
  end if;

  update public.system_access_credentials
  set failed_attempts=0,locked_until=null,updated_at=now()
  where role_key=v_role;
  v_token:=encode(extensions.gen_random_bytes(32),'hex');
  insert into public.system_access_sessions(token_hash,role_key,expires_at)
  values(encode(extensions.digest(v_token,'sha256'),'hex'),v_role,now()+interval '8 hours');
  return jsonb_build_object(
    'status','success','session_token',v_token,'role',v_role,
    'display_name',v_credential.role_label,'expires_at',now()+interval '8 hours'
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.library_logout(p_session_token text)
 RETURNS jsonb
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select public.system_control_logout(p_session_token)
$function$
;

CREATE OR REPLACE FUNCTION public.library_public_catalog(p_query text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
declare v_enabled boolean; v_query text:=trim(coalesce(p_query,'')); v_rows jsonb;
begin
  select coalesce((setting_value #>> '{}')::boolean,false) into v_enabled
  from public.library_settings where setting_key='public_catalog_enabled';
  if not v_enabled then return jsonb_build_object('status','unavailable','message','The public catalogue is not enabled.'); end if;
  select coalesce(jsonb_agg(to_jsonb(q) order by q.title,q.author),'[]'::jsonb)
  into v_rows
  from (
    select t.id,t.title,t.subtitle,t.author,t.category,t.shelf_location,
           count(c.id) filter(where c.status<>'withdrawn')::integer copy_count,
           count(c.id) filter(where c.status='available')::integer available_count
    from public.library_titles t
    left join public.library_copies c on c.title_id=t.id
    where t.active and (
      v_query='' or t.title ilike '%'||v_query||'%' or coalesce(t.author,'') ilike '%'||v_query||'%'
      or coalesce(t.isbn,'') ilike '%'||v_query||'%'
    )
    group by t.id
    order by t.title,t.author
    limit 100
  ) q;
  return jsonb_build_object('status','success','titles',v_rows);
end
$function$
;

CREATE OR REPLACE FUNCTION public.library_search_students(p_session_token text, p_query text)
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_query text:=trim(coalesce(p_query,'')); v_rows jsonb;
begin
  select * into v_context from private.library_context(p_session_token);
  if not found then return jsonb_build_object('status','unauthorized','message','Your library session has ended.'); end if;
  if length(v_query)<2 then return jsonb_build_object('status','success','students','[]'::jsonb); end if;
  select coalesce(jsonb_agg(to_jsonb(q) order by q.full_name),'[]'::jsonb)
  into v_rows
  from (
    select id,registration_number,full_name,gender
    from public.students
    where is_active
      and (full_name ilike '%'||v_query||'%' or registration_number::text ilike '%'||regexp_replace(v_query,'\D','','g')||'%')
    order by case when registration_number::text=v_query then 0 else 1 end,full_name
    limit 20
  ) q;
  return jsonb_build_object('status','success','students',v_rows);
end
$function$
;

CREATE OR REPLACE FUNCTION public.library_student_loans(p_registration_number text)
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare
  v_registration text:=pg_catalog.regexp_replace(coalesce(p_registration_number,''),'[^0-9]','','g');
  v_loans jsonb;
begin
  if v_registration !~ '^[0-9]{5}$' then
    return pg_catalog.jsonb_build_object(
      'status','invalid',
      'message','Enter your five-digit registration number.'
    );
  end if;

  select coalesce(
    pg_catalog.jsonb_agg(pg_catalog.to_jsonb(q) order by q.due_date,q.title),
    '[]'::jsonb
  )
  into v_loans
  from (
    select
      t.title,
      t.author,
      l.borrowed_at::date as borrowed_on,
      l.due_date,
      l.renew_count,
      l.due_date<current_date as overdue,
      (l.due_date-current_date)::integer as due_in_days
    from public.library_loans l
    join public.library_copies c on c.id=l.copy_id
    join public.library_titles t on t.id=c.title_id
    where l.borrower_type='student'
      and l.borrower_registration_number::text=v_registration
      and l.returned_at is null
      and t.active
    order by l.due_date,t.title
    limit 10
  ) q;

  return pg_catalog.jsonb_build_object(
    'status','success',
    'loans',v_loans
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.meal_planning_status(p_service_date date DEFAULT NULL::date)
 RETURNS jsonb
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'private', 'pg_catalog'
AS $function$
  select jsonb_build_object(
    'status','success','service_date',coalesce(p_service_date,timezone('Africa/Harare',now())::date),
    'holiday_mode',private.meal_holiday_mode(),'conference_mode',private.conference_mode(),
    'switch_enabled',private.meal_feature_enabled('meal_check_in_enabled'),
    'check_in_enabled',private.meal_feature_enabled('meal_check_in_enabled') and not private.meal_holiday_mode() and not private.conference_mode(),
    'breakfast',private.meal_plan_window(coalesce(p_service_date,timezone('Africa/Harare',now())::date),'Breakfast'),
    'lunch',private.meal_plan_window(coalesce(p_service_date,timezone('Africa/Harare',now())::date),'Lunch'),
    'break_4pm',private.meal_plan_window(coalesce(p_service_date,timezone('Africa/Harare',now())::date),'Break-fast 4pm'),
    'lunch_rule','Lunch has its own check-in and is open for the current school day.','supper_rule','No meal number needed for Supper.'
  )
$function$
;

CREATE OR REPLACE FUNCTION public.ops_administrators_office_gate_passes(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_holiday boolean := false;
  v_passes jsonb;
begin
  select * into v_context from private.ops_session_context(p_session_token);

  select slug into v_department_slug
  from public.ops_departments
  where id=v_context.actor_department_id;

  if v_context.actor_role<>'department' or v_department_slug<>'administrators-office' then
    raise exception 'Administrator''s Office access is required.' using errcode='42501';
  end if;

  select coalesce((setting_value #>> '{}')::boolean,false)
  into v_holiday
  from public.system_settings
  where setting_key='school_holiday_mode';

  select coalesce(jsonb_agg(jsonb_build_object(
    'id',gp.id,
    'student_id',gp.student_id,
    'student_name',s.full_name,
    'registration_number',s.registration_number,
    'destination',gp.destination,
    'reason',gp.reason,
    'contact_details',gp.contact_details,
    'requester_email',(
      select c.requester_email
      from private.pass_requester_contacts c
      where c.pass_id=gp.id
    ),
    'departure_at',gp.departure_at,
    'expected_return_at',gp.expected_return_at,
    'status',gp.status,
    'submitted_at',gp.submitted_at,
    'updated_at',gp.updated_at,
    'created_source',gp.created_source,
    'people',public._gate_pass_people_json(gp.id),
    'approvals',coalesce((
      select jsonb_agg(jsonb_build_object(
        'role',a.approver_role,
        'decision',a.decision,
        'comments',a.comments,
        'decided_at',a.decided_at
      ) order by a.decided_at)
      from public.gate_pass_approvals a
      where a.pass_id=gp.id
    ),'[]'::jsonb),
    'waiting_on',case
      when gp.status<>'pending' then null
      when not exists(
        select 1 from public.gate_pass_approvals a
        where a.pass_id=gp.id and a.approver_role='administrator' and a.decision='approved'
      ) then 'School Administration'
      when not v_holiday and not exists(
        select 1 from public.gate_pass_approvals a
        where a.pass_id=gp.id and a.approver_role in ('principal','dean','director') and a.decision='approved'
      ) then 'Principal, Dean or Director'
      else null
    end,
    'can_edit',gp.status not in ('departed','returned','expired')
  ) order by gp.submitted_at desc),'[]'::jsonb)
  into v_passes
  from public.gate_passes gp
  join public.students s on s.id=gp.student_id;

  return jsonb_build_object(
    'status','success',
    'passes',v_passes,
    'deadline_applies',false,
    'approval_rule',case
      when v_holiday then 'School Administration approval only'
      else 'School Administration plus Principal, Dean or Director'
    end,
    'loaded_at',now()
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_administrators_office_save_gate_pass(p_session_token text, p_pass_id uuid, p_primary_registration text, p_destination text, p_reason text, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_contact_details text, p_companions jsonb DEFAULT '[]'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_primary public.students%rowtype;
  v_companion public.students%rowtype;
  v_existing public.gate_passes%rowtype;
  v_pass public.gate_passes%rowtype;
  v_old_status text;
  v_raw text;
  v_reg text;
  v_companion_ids text[] := '{}'::text[];
  v_companion_count integer := 0;
  v_people jsonb;
  v_queued integer := 0;
  v_previous_approvals jsonb := '[]'::jsonb;
begin
  select * into v_context from private.ops_session_context(p_session_token);

  select slug into v_department_slug
  from public.ops_departments
  where id=v_context.actor_department_id;

  if v_context.actor_role<>'department' or v_department_slug<>'administrators-office' then
    raise exception 'Administrator''s Office access is required.' using errcode='42501';
  end if;

  if p_companions is null then p_companions:='[]'::jsonb; end if;
  if jsonb_typeof(p_companions)<>'array' then
    return jsonb_build_object('status','invalid','message','The additional people could not be read. Remove them and add them again.');
  end if;

  select * into v_primary
  from public.students
  where registration_number::text=regexp_replace(coalesce(p_primary_registration,''),'\D','','g')
    and is_active=true
  limit 1;

  if not found then
    return jsonb_build_object('status','not_found','message','Choose an active student from the student register.');
  end if;

  if length(trim(coalesce(p_destination,'')))<2
     or length(trim(coalesce(p_reason,'')))<3
     or length(trim(coalesce(p_contact_details,'')))<3 then
    return jsonb_build_object('status','invalid','message','Complete the destination, reason and contact details.');
  end if;

  if p_departure_at is null or p_expected_return_at is null or p_expected_return_at<=p_departure_at then
    return jsonb_build_object('status','invalid','message','Expected return must be later than departure.');
  end if;

  if p_departure_at<=now() then
    return jsonb_build_object('status','invalid','message','Departure must be in the future.');
  end if;

  if p_pass_id is not null then
    select * into v_existing from public.gate_passes where id=p_pass_id for update;
    if not found then
      return jsonb_build_object('status','not_found','message','Gate pass not found.');
    end if;
    if v_existing.status in ('departed','returned','expired') then
      return jsonb_build_object('status','invalid','message','A pass cannot be edited after travel has started or finished.');
    end if;
  end if;

  if exists(
    select 1
    from public.gate_passes gp
    join public.gate_pass_members gm on gm.pass_id=gp.id
    where gm.student_id=v_primary.id
      and gp.id is distinct from p_pass_id
      and gp.status in ('pending','approved','departed')
      and tstzrange(gp.departure_at,gp.expected_return_at,'[]')
          && tstzrange(p_departure_at,p_expected_return_at,'[]')
  ) then
    return jsonb_build_object('status','schedule_conflict','message',v_primary.full_name||' already has an active pass that overlaps this period.');
  end if;

  for v_raw in
    select distinct value from jsonb_array_elements_text(p_companions)
  loop
    v_reg:=regexp_replace(coalesce(v_raw,''),'\D','','g');
    if v_reg='' then continue; end if;
    if v_reg=v_primary.registration_number::text then
      return jsonb_build_object('status','invalid','message','Do not add the primary student as an additional person.');
    end if;

    select * into v_companion
    from public.students
    where registration_number::text=v_reg and is_active=true
    limit 1;

    if not found then
      return jsonb_build_object('status','invalid','message','Additional student '||v_reg||' was not found.');
    end if;
    if v_companion.id=any(v_companion_ids) then continue; end if;

    v_companion_count:=v_companion_count+1;
    if v_companion_count>5 then
      return jsonb_build_object('status','invalid','message','A gate pass can include up to five additional people.');
    end if;

    if exists(
      select 1
      from public.gate_passes gp
      join public.gate_pass_members gm on gm.pass_id=gp.id
      where gm.student_id=v_companion.id
        and gp.id is distinct from p_pass_id
        and gp.status in ('pending','approved','departed')
        and tstzrange(gp.departure_at,gp.expected_return_at,'[]')
            && tstzrange(p_departure_at,p_expected_return_at,'[]')
    ) then
      return jsonb_build_object('status','schedule_conflict','message',v_companion.full_name||' already has an active pass that overlaps this period.');
    end if;

    v_companion_ids:=array_append(v_companion_ids,v_companion.id);
  end loop;

  if p_pass_id is null then
    insert into public.gate_passes(
      student_id,destination,reason,departure_at,expected_return_at,contact_details,created_source
    ) values (
      v_primary.id,trim(p_destination),trim(p_reason),p_departure_at,p_expected_return_at,trim(p_contact_details),'staff'
    ) returning * into v_pass;

    v_old_status:=null;
  else
    v_old_status:=v_existing.status;

    select coalesce(jsonb_agg(jsonb_build_object(
      'role',approver_role,'decision',decision,'comments',comments,'decided_at',decided_at
    ) order by decided_at),'[]'::jsonb)
    into v_previous_approvals
    from public.gate_pass_approvals
    where pass_id=p_pass_id;

    delete from public.gate_pass_approvals where pass_id=p_pass_id;
    delete from public.gate_pass_members where pass_id=p_pass_id;

    update public.gate_passes
    set student_id=v_primary.id,
        destination=trim(p_destination),
        reason=trim(p_reason),
        departure_at=p_departure_at,
        expected_return_at=p_expected_return_at,
        contact_details=trim(p_contact_details),
        status='pending',
        submitted_at=now(),
        final_approved_at=null,
        actual_departure_at=null,
        actual_return_at=null,
        paper_pass_checked=false,
        cancelled_at=null,
        cancelled_by_role=null,
        cancellation_reason=null,
        created_source='staff',
        updated_at=now()
    where id=p_pass_id
    returning * into v_pass;
  end if;

  if p_pass_id is not null then
    insert into public.gate_pass_members(pass_id,student_id,is_primary,added_by_student_id)
    values(v_pass.id,v_primary.id,true,null);
  end if;

  if array_length(v_companion_ids,1) is not null then
    insert into public.gate_pass_members(pass_id,student_id,is_primary,added_by_student_id)
    select v_pass.id,u.student_id,false,v_primary.id
    from unnest(v_companion_ids) as u(student_id)
    on conflict(pass_id,student_id) do nothing;
  end if;

  insert into public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
  values(
    v_pass.id,v_old_status,'pending','administrator',
    case when p_pass_id is null
      then 'Submitted by Administrator''s Office. Student submission deadline bypassed.'
      else 'Edited and resubmitted by Administrator''s Office. Previous approvals were reset.'
    end
  );

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values(
    'gate_pass','gate_pass',v_pass.id::text,'department',
    case when p_pass_id is null then 'administrators_office_submitted' else 'administrators_office_edited' end,
    jsonb_build_object(
      'department_id',v_context.actor_department_id,
      'student_id',v_primary.id,
      'registration_number',v_primary.registration_number,
      'companion_count',v_companion_count,
      'deadline_bypassed',true,
      'previous_status',v_old_status,
      'previous_approvals',v_previous_approvals
    )
  );

  v_queued:=private.pass_queue_email(v_pass.id,'submitted');
  v_people:=public._gate_pass_people_json(v_pass.id);

  return jsonb_build_object(
    'status','success',
    'pass_id',v_pass.id,
    'pass_status','pending',
    'people',v_people,
    'deadline_applies',false,
    'approvals_reset',p_pass_id is not null,
    'email_notification_queued',v_queued>0
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_assign_groups(p_session_token text, p_session_id uuid, p_allocations jsonb, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_session public.ops_work_sessions%rowtype;
  v_item jsonb;
  v_code text;
  v_count integer;
  v_total integer := 0;
  v_available integer;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('student_leadership','management','administrator') then
    raise exception 'Student Leadership access is required.' using errcode='42501';
  end if;
  if nullif(btrim(p_actor_name),'') is null then return jsonb_build_object('status','invalid','message','Select or enter the person assigning groups.'); end if;
  select * into v_session from public.ops_work_sessions where id=p_session_id for update;
  if not found or v_session.status='cancelled' then return jsonb_build_object('status','invalid','message','Work session not found.'); end if;
  if jsonb_typeof(coalesce(p_allocations,'[]'::jsonb))<>'array' then return jsonb_build_object('status','invalid','message','Enter group allocations.'); end if;

  for v_item in select value from jsonb_array_elements(coalesce(p_allocations,'[]'::jsonb)) loop
    v_code := v_item->>'group_code';
    v_count := coalesce(nullif(v_item->>'headcount','')::integer,0);
    if v_code not in ('year1_men','year1_ladies','year2_men','year2_ladies') or v_count<0 then
      return jsonb_build_object('status','invalid','message','A group allocation is invalid.');
    end if;
    v_total := v_total + v_count;
    select count(*)::integer - coalesce((
      select sum(a.headcount)::integer
      from public.ops_session_group_allocations a
      join public.ops_work_sessions ws on ws.id=a.session_id
      where a.group_code=v_code and a.session_id<>p_session_id
        and ws.work_date=v_session.work_date and ws.slot_id=v_session.slot_id and ws.status<>'cancelled'
    ),0) into v_available
    from public.students s
    where s.is_active and private.ops_group_code(s.registration_number,s.gender)=v_code
      and private.ops_student_is_available(s.id);
    if v_count > greatest(v_available,0) then
      return jsonb_build_object('status','invalid','message',format('Only %s people are available in %s for this slot.',greatest(v_available,0),replace(v_code,'_',' ')));
    end if;
  end loop;
  if v_total > v_session.allocated_headcount then
    return jsonb_build_object('status','invalid','message',format('This session has %s approved places.',v_session.allocated_headcount));
  end if;

  delete from public.ops_session_group_allocations where session_id=p_session_id;
  insert into public.ops_session_group_allocations(session_id,group_code,headcount,assigned_by_name,assigned_by_role)
  select p_session_id,x.group_code,x.headcount,btrim(p_actor_name),v_context.actor_role
  from (
    select value->>'group_code' group_code,(value->>'headcount')::integer headcount
    from jsonb_array_elements(coalesce(p_allocations,'[]'::jsonb))
  ) x where x.headcount>0;
  insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
  values(v_session.department_id,'groups_assigned','Student groups assigned',format('%s people have been assigned by group.',v_total),'work_session',v_session.id);
  perform private.ops_audit(v_context.actor_role,null,btrim(p_actor_name),'assign_groups','work_session',v_session.id::text,jsonb_build_object('headcount',v_total));
  return jsonb_build_object('status','success','assigned_count',v_total);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_bootstrap(p_session_token text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT (CURRENT_DATE + 7))
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_from date := coalesce(p_from_date, current_date);
  v_to date := coalesce(p_to_date, current_date + 7);
  v_result jsonb;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_to < v_from or v_to > v_from + 62 then
    return jsonb_build_object('status','invalid','message','Choose a date range of 63 days or fewer.');
  end if;

  select jsonb_build_object(
    'status','success',
    'viewer',jsonb_build_object(
      'role',v_context.actor_role,
      'department_id',v_context.actor_department_id,
      'can_plan',v_context.actor_role in ('student_leadership','management','administrator'),
      'can_verify',v_context.actor_role in ('student_leadership','management','administrator'),
      'can_approve',v_context.actor_role in ('management','administrator'),
      'can_manage_access',v_context.actor_role = 'administrator'
    ),
    'date_range',jsonb_build_object('from',v_from,'to',v_to),
    'departments',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',d.id,'slug',d.slug,'name',d.name,'short_name',d.short_name,
        'parent_department_id',d.parent_department_id,'department_kind',d.department_kind,
        'restricted_data',d.restricted_data,'workspace_enabled',d.workspace_enabled,
        'login_enabled',c.department_id is not null,
        'jira_operations_value',d.jira_operations_value,
        'jira_project_value',d.jira_project_value
      ) order by d.sort_order,d.name)
      from public.ops_departments d
      left join public.ops_department_credentials c on c.department_id=d.id
      where d.active
    ),'[]'::jsonb),
    'time_slots',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',s.id,'code',s.code,'name',s.name,'start_time',s.start_time,'end_time',s.end_time
      ) order by s.sort_order,s.name)
      from public.ops_time_slots s where s.active
    ),'[]'::jsonb),
    'staff_directory',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',x.id,'department_id',x.department_id,'full_name',x.full_name,'title',x.title
      ) order by x.full_name)
      from public.ops_staff_directory x
      where x.active and (
        v_context.actor_role <> 'department'
        or x.department_id is null
        or x.department_id = v_context.actor_department_id
      )
    ),'[]'::jsonb),
    'student_roster',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',s.id,
        'registration_number',s.registration_number::text,
        'full_name',s.full_name,
        'available',private.ops_student_is_available(s.id),
        'availability',case when private.ops_student_is_available(s.id) then 'Available' else 'Unavailable' end,
        'department_ids',coalesce((
          select jsonb_agg(m.department_id order by d2.sort_order)
          from public.ops_department_memberships m
          join public.ops_departments d2 on d2.id=m.department_id
          where m.student_id=s.id and m.active and (m.ends_on is null or m.ends_on >= current_date)
        ),'[]'::jsonb)
      ) order by s.full_name)
      from public.students s
      where s.is_active and (
        v_context.actor_role <> 'department'
        or exists (
          select 1 from public.ops_department_memberships m
          where m.student_id=s.id and m.department_id=v_context.actor_department_id
            and m.active and (m.ends_on is null or m.ends_on >= current_date)
        )
        or exists (
          select 1
          from public.ops_session_assignments a
          join public.ops_work_sessions ws on ws.id=a.session_id
          where a.student_id=s.id and ws.department_id=v_context.actor_department_id
            and ws.work_date between v_from and v_to
        )
      )
    ),'[]'::jsonb),
    'memberships',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',m.id,'department_id',m.department_id,'student_id',m.student_id,
        'member_role',m.member_role,'starts_on',m.starts_on,'ends_on',m.ends_on,'active',m.active
      ) order by d.sort_order,s.full_name)
      from public.ops_department_memberships m
      join public.ops_departments d on d.id=m.department_id
      join public.students s on s.id=m.student_id
      where (v_context.actor_role <> 'department' or m.department_id=v_context.actor_department_id)
        and m.active and (m.ends_on is null or m.ends_on >= current_date)
    ),'[]'::jsonb),
    'tasks',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',t.id,'department_id',t.department_id,'parent_task_id',t.parent_task_id,
        'title',t.title,'description',t.description,'task_type',t.task_type,'cadence',t.cadence,
        'priority',t.priority,'status',t.status,'due_date',t.due_date,
        'requested_people',t.requested_people,'external_people_allowed',t.external_people_allowed,
        'owner_name',t.owner_name,'created_by_name',t.created_by_name,
        'jira_issue_key',t.jira_issue_key,'jira_issue_url',t.jira_issue_url,
        'created_at',t.created_at,'updated_at',t.updated_at
      ) order by t.due_date nulls last,t.priority desc,t.created_at desc)
      from public.ops_tasks t
      where t.archived_at is null
        and private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,t.department_id)
    ),'[]'::jsonb),
    'session_requests',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',r.id,'department_id',r.department_id,'work_date',r.work_date,'slot_id',r.slot_id,
        'requested_headcount',r.requested_headcount,'allocated_headcount',r.allocated_headcount,
        'request_notes',r.request_notes,'decision_notes',r.decision_notes,
        'requested_by_name',r.requested_by_name,'status',r.status,
        'submitted_at',r.submitted_at,'decided_at',r.decided_at,
        'task_ids',coalesce((select jsonb_agg(rt.task_id) from public.ops_session_request_tasks rt where rt.request_id=r.id),'[]'::jsonb)
      ) order by r.work_date,r.submitted_at)
      from public.ops_session_requests r
      where r.work_date between v_from and v_to
        and private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,r.department_id)
    ),'[]'::jsonb),
    'work_sessions',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',ws.id,'request_id',ws.request_id,'department_id',ws.department_id,
        'work_date',ws.work_date,'slot_id',ws.slot_id,'allocated_headcount',ws.allocated_headcount,
        'status',ws.status,'leadership_notes',ws.leadership_notes,'department_notes',ws.department_notes,
        'published_at',ws.published_at,'completed_at',ws.completed_at,
        'task_ids',coalesce((select jsonb_agg(st.task_id order by st.sequence) from public.ops_session_tasks st where st.session_id=ws.id),'[]'::jsonb),
        'assigned_count',(select count(*) from public.ops_session_assignments a where a.session_id=ws.id)
      ) order by ws.work_date,slot.sort_order,d.sort_order)
      from public.ops_work_sessions ws
      join public.ops_time_slots slot on slot.id=ws.slot_id
      join public.ops_departments d on d.id=ws.department_id
      where ws.work_date between v_from and v_to
        and private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,ws.department_id)
    ),'[]'::jsonb),
    'assignments',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',a.id,'session_id',a.session_id,'student_id',a.student_id,
        'student_name',s.full_name,'registration_number',s.registration_number::text,
        'home_department_id',a.home_department_id,'assignment_source',a.assignment_source,
        'attendance',a.attendance,'notes',a.notes
      ) order by ws.work_date,slot.sort_order,s.full_name)
      from public.ops_session_assignments a
      join public.ops_work_sessions ws on ws.id=a.session_id
      join public.ops_time_slots slot on slot.id=ws.slot_id
      join public.students s on s.id=a.student_id
      where ws.work_date between v_from and v_to
        and private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,ws.department_id)
    ),'[]'::jsonb),
    'reports',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',r.id,'department_id',r.department_id,'report_type',r.report_type,
        'period_start',r.period_start,'period_end',r.period_end,'report_date',r.report_date,
        'status',r.status,'version',r.version,'prepared_by_name',r.prepared_by_name,
        'staff_on_duty',r.staff_on_duty,'summary',r.summary,'work_completed',r.work_completed,
        'work_open',r.work_open,'challenges',r.challenges,'action_required',r.action_required,
        'stock_equipment',r.stock_equipment,'risks',r.risks,'support_required',r.support_required,
        'next_period_plan',r.next_period_plan,'return_reason',r.return_reason,
        'jira_issue_key',r.jira_issue_key,'jira_issue_url',r.jira_issue_url,
        'metrics',coalesce((select jsonb_agg(jsonb_build_object(
          'id',m.id,'metric_name',m.metric_name,'unit',m.unit,'target_value',m.target_value,
          'actual_value',m.actual_value,'variance',m.variance,'status',m.status,'commentary',m.commentary
        ) order by m.sort_order,m.metric_name) from public.ops_report_metrics m where m.report_id=r.id),'[]'::jsonb)
      ) order by r.period_end desc,r.updated_at desc)
      from public.ops_reports r
      where r.period_end >= v_from - 31 and r.period_start <= v_to
        and private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,r.department_id)
    ),'[]'::jsonb),
    'transfers',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',t.id,'transfer_date',t.transfer_date,'from_department_id',t.from_department_id,
        'to_department_id',t.to_department_id,'reference',t.reference,'status',t.status,
        'sent_by_name',t.sent_by_name,'sent_at',t.sent_at,'received_by_name',t.received_by_name,
        'received_at',t.received_at,'notes',t.notes,
        'items',coalesce((select jsonb_agg(jsonb_build_object(
          'id',i.id,'item_name',i.item_name,'quantity',i.quantity,'unit',i.unit,'notes',i.notes
        ) order by i.item_name) from public.ops_transfer_items i where i.transfer_id=t.id),'[]'::jsonb)
      ) order by t.transfer_date desc,t.created_at desc)
      from public.ops_transfers t
      where t.transfer_date between v_from - 31 and v_to
        and (
          v_context.actor_role <> 'department'
          or t.from_department_id=v_context.actor_department_id
          or t.to_department_id=v_context.actor_department_id
        )
    ),'[]'::jsonb),
    'notifications',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',n.id,'notification_type',n.notification_type,'title',n.title,'message',n.message,
        'link_type',n.link_type,'link_id',n.link_id,'created_at',n.created_at,
        'read',exists(select 1 from public.ops_notification_reads nr where nr.notification_id=n.id and nr.access_session_id=v_context.access_session_id)
      ) order by n.created_at desc)
      from public.ops_notifications n
      where (n.expires_at is null or n.expires_at > now())
        and (
          (v_context.actor_role='department' and n.department_id=v_context.actor_department_id)
          or n.target_role=v_context.actor_role
          or (v_context.actor_role in ('management','administrator') and n.target_role in ('management','administrator'))
        )
    ),'[]'::jsonb),
    'management_actions',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',a.id,'department_id',a.department_id,'report_id',a.report_id,'task_id',a.task_id,
        'summary',a.summary,'description',a.description,'priority',a.priority,'status',a.status,
        'owner_name',a.owner_name,'due_date',a.due_date,'jira_issue_key',a.jira_issue_key,'jira_issue_url',a.jira_issue_url
      ) order by a.due_date nulls last,a.priority desc,a.created_at desc)
      from public.ops_management_actions a
      where v_context.actor_role <> 'department'
         or a.department_id=v_context.actor_department_id
    ),'[]'::jsonb),
    'settings',jsonb_build_object(
      'finance_enabled',coalesce((select setting_value from public.ops_settings where setting_key='finance_enabled'),'false'::jsonb),
      'school_timezone',coalesce((select setting_value from public.ops_settings where setting_key='school_timezone'),'"Africa/Harare"'::jsonb)
    ),
    'jira_sync',case when v_context.actor_role in ('management','administrator') then jsonb_build_object(
      'pending',(select count(*) from public.ops_jira_outbox where status='pending'),
      'processing',(select count(*) from public.ops_jira_outbox where status='processing'),
      'failed',(select count(*) from public.ops_jira_outbox where status='failed'),
      'sent',(select count(*) from public.ops_jira_outbox where status='sent')
    ) else null end
  ) into v_result;

  return v_result;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_bootstrap_v2(p_session_token text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT (CURRENT_DATE + 7))
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_result jsonb;
begin
  v_result:=public.ops_bootstrap(p_session_token,p_from_date,p_to_date);
  if coalesce(v_result->>'status','')<>'success' then return v_result; end if;
  v_result:=jsonb_set(v_result,'{student_roster}',coalesce((
    select jsonb_agg(value-'registration_number') from jsonb_array_elements(v_result->'student_roster')
  ),'[]'::jsonb));
  v_result:=jsonb_set(v_result,'{assignments}',coalesce((
    select jsonb_agg(value-'registration_number') from jsonb_array_elements(v_result->'assignments')
  ),'[]'::jsonb));
  v_result:=jsonb_set(v_result,'{tasks}',coalesce((
    select jsonb_agg(item.value || jsonb_build_object('metadata',coalesce(t.metadata,'{}'::jsonb)))
    from jsonb_array_elements(v_result->'tasks') item
    join public.ops_tasks t on t.id=(item.value->>'id')::uuid
  ),'[]'::jsonb));
  return v_result || jsonb_build_object('people_directory',public.ops_people_directory(p_session_token));
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_catalog()
 RETURNS jsonb
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select jsonb_build_object(
    'status','success',
    'departments',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',d.id,
        'slug',d.slug,
        'name',case
          when c.department_id is null
            then d.name || ' — Set new 4-digit PIN'
          else d.name
        end,
        'short_name',d.short_name,
        'parent_department_id',d.parent_department_id,
        'login_enabled',true,
        'pin_exists',c.department_id is not null
      ) order by d.sort_order,d.name)
      from public.ops_departments d
      left join public.ops_department_credentials c on c.department_id=d.id
      where d.active and d.workspace_enabled
    ),'[]'::jsonb),
    'access_types',jsonb_build_array(
      jsonb_build_object('value','department','label','Department'),
      jsonb_build_object('value','student_leadership','label','Student Leadership'),
      jsonb_build_object('value','management','label','Management'),
      jsonb_build_object('value','administrator','label','School Administration')
    )
  )
$function$
;

CREATE OR REPLACE FUNCTION public.ops_claim_department_pin(p_department_slug text, p_setup_code text, p_new_pin text, p_confirm_pin text)
 RETURNS jsonb
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select public.ops_create_department_pin(
    p_department_slug,
    p_new_pin,
    p_confirm_pin
  )
$function$
;

CREATE OR REPLACE FUNCTION public.ops_clinic_service(p_session_token text, p_action text, p_payload jsonb DEFAULT '{}'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_slug text; v_rows jsonb; v_student public.students%rowtype; v_year integer:=public._current_academic_year(); v_query text:=btrim(coalesce(p_payload->>'query',''));
begin
  select * into v_context from private.ops_session_context(p_session_token);
  select slug into v_slug from public.ops_departments where id=v_context.actor_department_id;
  if not (v_context.actor_role='administrator' or (v_context.actor_role='department' and v_slug='clinic')) then raise exception 'Clinic access is required.' using errcode='42501'; end if;
  if p_action='active' then
    select coalesce(jsonb_agg(jsonb_build_object('registration_number',s.registration_number::text,'student_name',s.full_name,'started_at',x.started_at,'notes',x.notes) order by x.started_at desc),'[]'::jsonb) into v_rows from public.student_support_statuses x join public.students s on s.id=x.student_id and s.is_active where x.status_type='bed_rest' and x.is_active;
    return jsonb_build_object('status','success','students',v_rows);
  elsif p_action='search' then
    select coalesce(jsonb_agg(jsonb_build_object('registration_number',q.registration_number::text,'student_name',q.full_name,'year_number',q.year_number,'on_bed_rest',q.on_bed_rest,'campus_status',q.campus_status) order by q.full_name),'[]'::jsonb) into v_rows from (select s.id,s.registration_number,s.full_name,public._student_year_number(s.registration_number,v_year) year_number,exists(select 1 from public.student_support_statuses x where x.student_id=s.id and x.status_type='bed_rest' and x.is_active) on_bed_rest,coalesce((select m.direction from public.campus_movements m where m.student_id=s.id order by m.scanned_at desc,m.id desc limit 1),'UNKNOWN') campus_status from public.students s where s.is_active and (v_query='' or s.full_name ilike '%'||v_query||'%' or (regexp_replace(v_query,'\\D','','g')<>'' and s.registration_number::text like '%'||regexp_replace(v_query,'\\D','','g')||'%')) order by s.full_name limit 100) q;
    return jsonb_build_object('status','success','students',v_rows);
  elsif p_action='set_bed_rest' then
    select * into v_student from public.students where registration_number::text=regexp_replace(coalesce(p_payload->>'registration_number',''),'\D','','g') and is_active limit 1;
    if not found then return jsonb_build_object('status','invalid','message','Student not found.'); end if;
    if p_payload->>'bed_rest_action'='start' then
      update public.student_support_statuses set status_label='Bed Rest',started_at=now(),ended_at=null,is_active=true,notes=nullif(btrim(p_payload->>'notes'),''),set_by_role='clinic',updated_at=now() where student_id=v_student.id and status_type='bed_rest' and is_active;
      if not found then insert into public.student_support_statuses(student_id,status_type,status_label,is_active,notes,set_by_role) values(v_student.id,'bed_rest','Bed Rest',true,nullif(btrim(p_payload->>'notes'),''),'clinic'); end if;
    elsif p_payload->>'bed_rest_action'='clear' then
      update public.student_support_statuses set is_active=false,ended_at=now(),updated_at=now() where student_id=v_student.id and status_type='bed_rest' and is_active;
    else return jsonb_build_object('status','invalid','message','Choose Start or End bed rest.'); end if;
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,'Clinic','set_bed_rest','student',v_student.id,jsonb_build_object('action',p_payload->>'bed_rest_action'));
    return jsonb_build_object('status','success','student_name',v_student.full_name);
  end if;
  return jsonb_build_object('status','invalid','message','Unknown clinic action.');
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_command(p_session_token text, p_action text, p_payload jsonb DEFAULT '{}'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog', 'extensions'
AS $function$
declare
  v_context record;
  v_action text := lower(coalesce(btrim(p_action),''));
  v_actor_name text := nullif(btrim(coalesce(p_payload->>'actor_name','')), '');
  v_id uuid;
  v_department_id uuid;
  v_target_department_id uuid;
  v_task public.ops_tasks%rowtype;
  v_request public.ops_session_requests%rowtype;
  v_session public.ops_work_sessions%rowtype;
  v_report public.ops_reports%rowtype;
  v_transfer public.ops_transfers%rowtype;
  v_management_action public.ops_management_actions%rowtype;
  v_item jsonb;
  v_status text;
  v_type text;
  v_code text;
  v_count integer;
  v_allocated integer;
  v_conflicts jsonb;
  v_unavailable jsonb;
  v_submit boolean;
  v_publish boolean;
  v_override boolean;
  v_work_date date;
  v_period_start date;
  v_period_end date;
  v_slot_id uuid;
begin
  p_payload := coalesce(p_payload, '{}'::jsonb);
  select * into v_context from private.ops_session_context(p_session_token);

  if v_action = 'save_staff_name' then
    v_department_id := coalesce(nullif(p_payload->>'department_id','')::uuid,v_context.actor_department_id);
    if v_actor_name is null then
      return jsonb_build_object('status','invalid','message','Enter the person name.');
    end if;
    if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
      raise exception 'You cannot change that department.' using errcode='42501';
    end if;

    insert into public.ops_staff_directory(department_id,full_name,title)
    values(v_department_id,v_actor_name,nullif(btrim(p_payload->>'title'),''))
    on conflict ((coalesce(department_id, '00000000-0000-0000-0000-000000000000'::uuid)), (lower(full_name)))
    do update set active=true,title=coalesce(excluded.title,public.ops_staff_directory.title)
    returning id into v_id;

    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'save_staff_name','staff_directory',v_id::text,jsonb_build_object('department_id',v_department_id));
    return jsonb_build_object('status','success','id',v_id);
  end if;

  if v_action = 'save_task' then
    v_id := nullif(p_payload->>'id','')::uuid;
    v_department_id := coalesce(nullif(p_payload->>'department_id','')::uuid,v_context.actor_department_id);
    if v_department_id is null then
      return jsonb_build_object('status','invalid','message','Choose a department.');
    end if;
    if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
      raise exception 'You cannot change that department.' using errcode='42501';
    end if;
    if length(btrim(coalesce(p_payload->>'title',''))) < 3 then
      return jsonb_build_object('status','invalid','message','Enter a task name.');
    end if;
    if v_actor_name is null and v_id is null then
      return jsonb_build_object('status','invalid','message','Select or enter your name.');
    end if;

    v_type := lower(coalesce(nullif(p_payload->>'task_type',''),'ad_hoc'));
    if v_type not in ('regular','ad_hoc','project','maintenance','building','incident_follow_up') then v_type:='ad_hoc'; end if;
    v_status := lower(coalesce(nullif(p_payload->>'status',''),'backlog'));
    if v_status not in ('backlog','ready','requested','planned','in_progress','blocked','done','cancelled') then v_status:='backlog'; end if;

    if v_id is null then
      insert into public.ops_tasks(
        department_id,title,description,task_type,cadence,priority,status,due_date,
        requested_people,external_people_allowed,owner_name,created_by_name,created_by_role,metadata
      ) values (
        v_department_id,btrim(p_payload->>'title'),nullif(btrim(p_payload->>'description'),''),v_type,
        case when lower(coalesce(p_payload->>'cadence','once')) in ('once','daily','weekly','monthly','quarterly')
          then lower(coalesce(p_payload->>'cadence','once')) else 'once' end,
        case when lower(coalesce(p_payload->>'priority','medium')) in ('low','medium','high','critical')
          then lower(coalesce(p_payload->>'priority','medium')) else 'medium' end,
        v_status,nullif(p_payload->>'due_date','')::date,
        greatest(0,least(coalesce(nullif(p_payload->>'requested_people','')::integer,0),100)),
        coalesce(nullif(p_payload->>'external_people_allowed','')::boolean,true),
        nullif(btrim(p_payload->>'owner_name'),''),v_actor_name,v_context.actor_role,
        coalesce(p_payload->'metadata','{}'::jsonb)
      ) returning * into v_task;
    else
      select * into v_task from public.ops_tasks where id=v_id for update;
      if not found or v_task.department_id<>v_department_id then
        return jsonb_build_object('status','invalid','message','Task not found.');
      end if;
      update public.ops_tasks set
        title=btrim(p_payload->>'title'),
        description=nullif(btrim(p_payload->>'description'),''),
        task_type=v_type,
        cadence=case when lower(coalesce(p_payload->>'cadence',cadence)) in ('once','daily','weekly','monthly','quarterly')
          then lower(coalesce(p_payload->>'cadence',cadence)) else cadence end,
        priority=case when lower(coalesce(p_payload->>'priority',priority)) in ('low','medium','high','critical')
          then lower(coalesce(p_payload->>'priority',priority)) else priority end,
        status=v_status,
        due_date=nullif(p_payload->>'due_date','')::date,
        requested_people=greatest(0,least(coalesce(nullif(p_payload->>'requested_people','')::integer,requested_people),100)),
        external_people_allowed=coalesce(nullif(p_payload->>'external_people_allowed','')::boolean,external_people_allowed),
        owner_name=nullif(btrim(p_payload->>'owner_name'),''),
        metadata=coalesce(p_payload->'metadata',metadata)
      where id=v_id returning * into v_task;
    end if;

    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'save_task','task',v_task.id::text,jsonb_build_object('department_id',v_department_id,'status',v_task.status));
    return jsonb_build_object('status','success','task_id',v_task.id,'task_status',v_task.status);
  end if;

  if v_action = 'request_session' then
    v_department_id := coalesce(nullif(p_payload->>'department_id','')::uuid,v_context.actor_department_id);
    if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
      raise exception 'You cannot request for that department.' using errcode='42501';
    end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter your name.'); end if;
    v_work_date := nullif(p_payload->>'work_date','')::date;
    v_slot_id := nullif(p_payload->>'slot_id','')::uuid;
    v_count := coalesce(nullif(p_payload->>'requested_headcount','')::integer,0);
    if v_work_date is null or v_work_date < current_date - 1 or v_work_date > current_date + 120 then
      return jsonb_build_object('status','invalid','message','Choose a work date within the next 120 days.');
    end if;
    if v_slot_id is null or not exists(select 1 from public.ops_time_slots where id=v_slot_id and active) then
      return jsonb_build_object('status','invalid','message','Choose a work session.');
    end if;
    if v_count < 1 or v_count > 100 then
      return jsonb_build_object('status','invalid','message','Requested people must be between 1 and 100.');
    end if;
    if exists(select 1 from public.ops_session_requests where department_id=v_department_id and work_date=v_work_date and slot_id=v_slot_id and status='pending') then
      return jsonb_build_object('status','invalid','message','This department already has a pending request for that slot.');
    end if;

    insert into public.ops_session_requests(
      department_id,work_date,slot_id,requested_headcount,request_notes,requested_by_name
    ) values (
      v_department_id,v_work_date,v_slot_id,v_count,nullif(btrim(p_payload->>'request_notes'),''),v_actor_name
    ) returning * into v_request;

    if jsonb_typeof(coalesce(p_payload->'task_ids','[]'::jsonb))='array' then
      insert into public.ops_session_request_tasks(request_id,task_id)
      select v_request.id,t.id
      from jsonb_array_elements_text(coalesce(p_payload->'task_ids','[]'::jsonb)) x(value)
      join public.ops_tasks t on t.id=x.value::uuid and t.department_id=v_department_id and t.archived_at is null
      on conflict do nothing;

      update public.ops_tasks set status='requested'
      where id in (select task_id from public.ops_session_request_tasks where request_id=v_request.id)
        and status in ('backlog','ready');
    end if;

    insert into public.ops_notifications(target_role,notification_type,title,message,link_type,link_id)
    values('student_leadership','session_request','New session request',
      format('%s requested %s people for %s.',(select name from public.ops_departments where id=v_department_id),v_count,to_char(v_work_date,'DD Mon YYYY')),
      'session_request',v_request.id);
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'request_session','session_request',v_request.id::text,jsonb_build_object('work_date',v_work_date,'requested_headcount',v_count));
    return jsonb_build_object('status','success','request_id',v_request.id);
  end if;

  if v_action = 'plan_session' then
    if v_context.actor_role not in ('student_leadership','management','administrator') then
      raise exception 'Student Leadership access is required.' using errcode='42501';
    end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the person making this decision.'); end if;
    v_id := nullif(p_payload->>'request_id','')::uuid;
    select * into v_request from public.ops_session_requests where id=v_id for update;
    if not found or v_request.status not in ('pending','approved','partially_approved') then
      return jsonb_build_object('status','invalid','message','Session request not found or already closed.');
    end if;
    v_status := lower(coalesce(p_payload->>'decision','approved'));
    v_allocated := greatest(0,least(coalesce(nullif(p_payload->>'allocated_headcount','')::integer,0),100));
    v_publish := coalesce(nullif(p_payload->>'publish','')::boolean,true);
    if v_status='declined' then
      update public.ops_session_requests set status='declined',allocated_headcount=0,
        decision_notes=nullif(btrim(p_payload->>'decision_notes'),''),decided_at=now(),decided_by_role=v_context.actor_role
      where id=v_request.id returning * into v_request;
      insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
      values(v_request.department_id,'session_decision','Session request declined',
        coalesce(nullif(btrim(p_payload->>'decision_notes'),''),'Student Leadership could not allocate this session.'),
        'session_request',v_request.id);
      return jsonb_build_object('status','success','request_status','declined');
    end if;
    if v_allocated < 1 then return jsonb_build_object('status','invalid','message','Allocate at least one person or decline the request.'); end if;
    v_status := case when v_allocated < v_request.requested_headcount then 'partially_approved' else 'approved' end;
    update public.ops_session_requests set status=v_status,allocated_headcount=v_allocated,
      decision_notes=nullif(btrim(p_payload->>'decision_notes'),''),decided_at=now(),decided_by_role=v_context.actor_role
    where id=v_request.id returning * into v_request;

    insert into public.ops_work_sessions(
      request_id,department_id,work_date,slot_id,allocated_headcount,status,leadership_notes,published_at,published_by_role
    ) values (
      v_request.id,v_request.department_id,v_request.work_date,v_request.slot_id,v_allocated,
      case when v_publish then 'published' else 'draft' end,
      nullif(btrim(p_payload->>'decision_notes'),''),case when v_publish then now() else null end,
      case when v_publish then v_context.actor_role else null end
    )
    on conflict (department_id,work_date,slot_id) do update set
      request_id=excluded.request_id,allocated_headcount=excluded.allocated_headcount,
      status=excluded.status,leadership_notes=excluded.leadership_notes,
      published_at=excluded.published_at,published_by_role=excluded.published_by_role
    returning * into v_session;

    insert into public.ops_session_tasks(session_id,task_id,sequence)
    select v_session.id,rt.task_id,(row_number() over(order by t.priority desc,t.due_date nulls last))::integer
    from public.ops_session_request_tasks rt
    join public.ops_tasks t on t.id=rt.task_id
    where rt.request_id=v_request.id
    on conflict (session_id,task_id) do nothing;
    update public.ops_tasks set status='planned'
    where id in(select task_id from public.ops_session_tasks where session_id=v_session.id)
      and status in ('backlog','ready','requested');

    insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
    values(v_request.department_id,'session_published','Work session allocated',
      format('Student Leadership allocated %s people for %s. %s',v_allocated,to_char(v_request.work_date,'DD Mon YYYY'),coalesce(p_payload->>'decision_notes','')),
      'work_session',v_session.id);
    perform private.ops_audit(v_context.actor_role,null,v_actor_name,
      'plan_session','work_session',v_session.id::text,jsonb_build_object('allocated_headcount',v_allocated,'published',v_publish));
    return jsonb_build_object('status','success','session_id',v_session.id,'request_status',v_status);
  end if;

  if v_action = 'assign_students' then
    if v_context.actor_role not in ('student_leadership','management','administrator') then
      raise exception 'Student Leadership access is required.' using errcode='42501';
    end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the person publishing assignments.'); end if;
    v_id := nullif(p_payload->>'session_id','')::uuid;
    select * into v_session from public.ops_work_sessions where id=v_id for update;
    if not found or v_session.status='cancelled' then
      return jsonb_build_object('status','invalid','message','Work session not found.');
    end if;
    if jsonb_typeof(coalesce(p_payload->'student_ids','[]'::jsonb))<>'array' then
      return jsonb_build_object('status','invalid','message','Choose the students to assign.');
    end if;
    v_count := jsonb_array_length(coalesce(p_payload->'student_ids','[]'::jsonb));
    if v_count > v_session.allocated_headcount then
      return jsonb_build_object('status','invalid','message',format('This session has %s places.',v_session.allocated_headcount));
    end if;
    v_override := coalesce(nullif(p_payload->>'override_unavailable','')::boolean,false);

    select coalesce(jsonb_agg(jsonb_build_object('student_id',q.id,'student_name',q.full_name)),'[]'::jsonb)
    into v_conflicts
    from (
      select distinct s.id,s.full_name
      from jsonb_array_elements_text(coalesce(p_payload->'student_ids','[]'::jsonb)) x(value)
      join public.students s on s.id=x.value
      join public.ops_session_assignments a on a.student_id=s.id and a.session_id<>v_session.id
      join public.ops_work_sessions other_ws on other_ws.id=a.session_id
      where other_ws.work_date=v_session.work_date and other_ws.slot_id=v_session.slot_id
        and other_ws.status<>'cancelled'
    ) q;
    if jsonb_array_length(v_conflicts)>0 then
      return jsonb_build_object('status','conflict','message','One or more students already have an assignment in this slot.','students',v_conflicts);
    end if;

    select coalesce(jsonb_agg(jsonb_build_object('student_id',s.id,'student_name',s.full_name)),'[]'::jsonb)
    into v_unavailable
    from jsonb_array_elements_text(coalesce(p_payload->'student_ids','[]'::jsonb)) x(value)
    join public.students s on s.id=x.value
    where not private.ops_student_is_available(s.id);
    if jsonb_array_length(v_unavailable)>0 and not v_override then
      return jsonb_build_object('status','unavailable','message','Some selected students are unavailable. No confidential reason is shown.','students',v_unavailable);
    end if;

    delete from public.ops_session_assignments where session_id=v_session.id;
    insert into public.ops_session_assignments(
      session_id,student_id,home_department_id,assignment_source,assigned_by_role
    )
    select v_session.id,s.id,home.department_id,
      case when home.department_id=v_session.department_id then 'home_department' else 'external' end,
      v_context.actor_role
    from jsonb_array_elements_text(coalesce(p_payload->'student_ids','[]'::jsonb)) x(value)
    join public.students s on s.id=x.value and s.is_active
    left join lateral (
      select m.department_id from public.ops_department_memberships m
      where m.student_id=s.id and m.active and (m.ends_on is null or m.ends_on>=current_date)
      order by (m.department_id=v_session.department_id) desc,m.starts_on desc limit 1
    ) home on true;

    insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
    values(v_session.department_id,'assignments_published','People assigned to your session',
      format('%s students have been assigned for %s.',v_count,to_char(v_session.work_date,'DD Mon YYYY')),
      'work_session',v_session.id);
    perform private.ops_audit(v_context.actor_role,null,v_actor_name,
      'assign_students','work_session',v_session.id::text,jsonb_build_object('student_count',v_count,'availability_override',v_override));
    return jsonb_build_object('status','success','assigned_count',v_count);
  end if;

  if v_action = 'update_attendance' then
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the person recording attendance.'); end if;
    v_id := nullif(p_payload->>'session_id','')::uuid;
    select * into v_session from public.ops_work_sessions where id=v_id;
    if not found or not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_session.department_id) then
      raise exception 'You cannot update that session.' using errcode='42501';
    end if;
    for v_item in select value from jsonb_array_elements(coalesce(p_payload->'attendance','[]'::jsonb)) loop
      v_status:=lower(coalesce(v_item->>'attendance','planned'));
      if v_status in ('planned','present','absent','excused') then
        update public.ops_session_assignments set attendance=v_status,notes=nullif(btrim(v_item->>'notes'),'')
        where session_id=v_session.id and student_id=v_item->>'student_id';
      end if;
    end loop;
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'update_attendance','work_session',v_session.id::text,'{}'::jsonb);
    return jsonb_build_object('status','success');
  end if;

  if v_action = 'update_session_status' then
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the person updating this session.'); end if;
    v_id := nullif(p_payload->>'session_id','')::uuid;
    v_status := lower(coalesce(p_payload->>'status',''));
    select * into v_session from public.ops_work_sessions where id=v_id for update;
    if not found or not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_session.department_id) then
      raise exception 'You cannot update that session.' using errcode='42501';
    end if;
    if v_context.actor_role='department' and v_status not in ('in_progress','completed') then
      raise exception 'The department can only start or complete its session.' using errcode='42501';
    end if;
    if v_status not in ('draft','published','in_progress','completed','cancelled') then
      return jsonb_build_object('status','invalid','message','Choose a valid session status.');
    end if;
    update public.ops_work_sessions set status=v_status,
      department_notes=coalesce(nullif(btrim(p_payload->>'department_notes'),''),department_notes),
      completed_at=case when v_status='completed' then now() else completed_at end
    where id=v_session.id;
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'update_session_status','work_session',v_session.id::text,jsonb_build_object('status',v_status));
    return jsonb_build_object('status','success','session_status',v_status);
  end if;

  if v_action = 'save_report' then
    v_department_id := coalesce(nullif(p_payload->>'department_id','')::uuid,v_context.actor_department_id);
    if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
      raise exception 'You cannot save that department report.' using errcode='42501';
    end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the person preparing this report.'); end if;
    v_type:=lower(coalesce(p_payload->>'report_type','daily'));
    if v_type not in ('daily','weekly','monthly') then return jsonb_build_object('status','invalid','message','Choose a valid report type.'); end if;
    v_period_start:=coalesce(nullif(p_payload->>'period_start','')::date,nullif(p_payload->>'report_date','')::date);
    v_period_end:=coalesce(nullif(p_payload->>'period_end','')::date,v_period_start);
    if v_type='daily' then v_period_end:=v_period_start; end if;
    if v_period_start is null or v_period_end<v_period_start or v_period_end>v_period_start+40 then
      return jsonb_build_object('status','invalid','message','Choose a valid reporting period.');
    end if;
    v_submit:=coalesce(nullif(p_payload->>'submit','')::boolean,false);
    if v_submit and nullif(btrim(coalesce(p_payload->>'work_completed','')),'') is null
       and nullif(btrim(coalesce(p_payload->>'challenges','')),'') is null then
      return jsonb_build_object('status','invalid','message','Record completed work or a challenge before submitting.');
    end if;

    select * into v_report from public.ops_reports
    where department_id=v_department_id and report_type=v_type and period_start=v_period_start and period_end=v_period_end
    for update;
    if found and v_report.status in ('approved','locked') then
      return jsonb_build_object('status','locked','message','This report is approved and cannot be changed.');
    end if;

    insert into public.ops_reports(
      department_id,report_type,period_start,period_end,report_date,status,prepared_by_name,
      staff_on_duty,summary,work_completed,work_open,challenges,action_required,stock_equipment,
      risks,support_required,next_period_plan,payload,submitted_at,return_reason,returned_at
    ) values (
      v_department_id,v_type,v_period_start,v_period_end,
      coalesce(nullif(p_payload->>'report_date','')::date,v_period_end),
      case when v_submit then 'submitted' else 'draft' end,v_actor_name,
      nullif(btrim(p_payload->>'staff_on_duty'),''),nullif(btrim(p_payload->>'summary'),''),
      nullif(btrim(p_payload->>'work_completed'),''),nullif(btrim(p_payload->>'work_open'),''),
      nullif(btrim(p_payload->>'challenges'),''),nullif(btrim(p_payload->>'action_required'),''),
      nullif(btrim(p_payload->>'stock_equipment'),''),nullif(btrim(p_payload->>'risks'),''),
      nullif(btrim(p_payload->>'support_required'),''),nullif(btrim(p_payload->>'next_period_plan'),''),
      coalesce(p_payload->'payload','{}'::jsonb),case when v_submit then now() else null end,null,null
    )
    on conflict (department_id,report_type,period_start,period_end) do update set
      report_date=excluded.report_date,status=excluded.status,version=public.ops_reports.version+1,
      prepared_by_name=excluded.prepared_by_name,staff_on_duty=excluded.staff_on_duty,
      summary=excluded.summary,work_completed=excluded.work_completed,work_open=excluded.work_open,
      challenges=excluded.challenges,action_required=excluded.action_required,
      stock_equipment=excluded.stock_equipment,risks=excluded.risks,
      support_required=excluded.support_required,next_period_plan=excluded.next_period_plan,
      payload=excluded.payload,submitted_at=excluded.submitted_at,return_reason=null,returned_at=null
    returning * into v_report;

    delete from public.ops_report_metrics where report_id=v_report.id;
    if jsonb_typeof(coalesce(p_payload->'metrics','[]'::jsonb))='array' then
      for v_item in select value from jsonb_array_elements(coalesce(p_payload->'metrics','[]'::jsonb)) loop
        if nullif(btrim(v_item->>'metric_name'),'') is not null then
          insert into public.ops_report_metrics(
            report_id,metric_name,unit,target_value,actual_value,status,commentary,sort_order
          ) values (
            v_report.id,btrim(v_item->>'metric_name'),nullif(btrim(v_item->>'unit'),''),
            nullif(v_item->>'target_value','')::numeric,nullif(v_item->>'actual_value','')::numeric,
            case when lower(coalesce(v_item->>'status','not_set')) in ('green','amber','red','not_set')
              then lower(coalesce(v_item->>'status','not_set')) else 'not_set' end,
            nullif(btrim(v_item->>'commentary'),''),
            coalesce(nullif(v_item->>'sort_order','')::integer,100)
          );
        end if;
      end loop;
    end if;

    if v_submit then
      insert into public.ops_notifications(target_role,notification_type,title,message,link_type,link_id)
      values('student_leadership','report_submitted','Department report submitted',
        format('%s submitted a %s report for %s.',(select name from public.ops_departments where id=v_department_id),v_type,to_char(v_period_end,'DD Mon YYYY')),
        'report',v_report.id);
    end if;
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      case when v_submit then 'submit_report' else 'save_report' end,'report',v_report.id::text,
      jsonb_build_object('report_type',v_type,'period_start',v_period_start,'period_end',v_period_end,'version',v_report.version));
    return jsonb_build_object('status','success','report_id',v_report.id,'report_status',v_report.status,'version',v_report.version);
  end if;

  if v_action = 'transition_report' then
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the reviewer name.'); end if;
    v_id:=nullif(p_payload->>'report_id','')::uuid;
    v_status:=lower(coalesce(p_payload->>'target_status',''));
    select * into v_report from public.ops_reports where id=v_id for update;
    if not found then return jsonb_build_object('status','invalid','message','Report not found.'); end if;

    if v_status='verified' then
      if v_context.actor_role not in ('student_leadership','management','administrator') or v_report.status<>'submitted' then
        raise exception 'This report cannot be verified.' using errcode='42501';
      end if;
      update public.ops_reports set status='verified',verified_at=now(),verified_by_role=v_context.actor_role where id=v_report.id returning * into v_report;
    elsif v_status='approved' then
      if v_context.actor_role not in ('management','administrator') or v_report.status<>'verified' then
        raise exception 'Management approval requires a verified report.' using errcode='42501';
      end if;
      update public.ops_reports set status='approved',approved_at=now(),approved_by_role=v_context.actor_role where id=v_report.id returning * into v_report;

      insert into public.ops_jira_outbox(event_type,aggregate_type,aggregate_id,idempotency_key,payload)
      select 'approved_report','report',v_report.id,
        format('report:%s:v%s',v_report.id,v_report.version),
        jsonb_build_object(
          'report_id',v_report.id,'report_type',v_report.report_type,'period_start',v_report.period_start,
          'period_end',v_report.period_end,'report_date',v_report.report_date,'version',v_report.version,
          'department_id',d.id,'department_slug',d.slug,'department_name',d.name,
          'jira_operations_value',d.jira_operations_value,'jira_operations_option_id',d.jira_operations_option_id,
          'prepared_by_name',v_report.prepared_by_name,'summary',v_report.summary,
          'work_completed',v_report.work_completed,'work_open',v_report.work_open,
          'challenges',v_report.challenges,'action_required',v_report.action_required,
          'stock_equipment',v_report.stock_equipment,'risks',v_report.risks,
          'support_required',v_report.support_required,'next_period_plan',v_report.next_period_plan,
          'metrics',coalesce((select jsonb_agg(jsonb_build_object(
            'name',m.metric_name,'unit',m.unit,'target',m.target_value,'actual',m.actual_value,
            'variance',m.variance,'status',m.status,'commentary',m.commentary
          ) order by m.sort_order,m.metric_name) from public.ops_report_metrics m where m.report_id=v_report.id),'[]'::jsonb)
        )
      from public.ops_departments d where d.id=v_report.department_id
      on conflict (idempotency_key) do nothing;
    elsif v_status='returned' then
      if v_context.actor_role not in ('student_leadership','management','administrator') or v_report.status not in ('submitted','verified') then
        raise exception 'This report cannot be returned.' using errcode='42501';
      end if;
      if nullif(btrim(p_payload->>'reason'),'') is null then return jsonb_build_object('status','invalid','message','Enter the reason for returning the report.'); end if;
      update public.ops_reports set status='returned',returned_at=now(),return_reason=btrim(p_payload->>'reason') where id=v_report.id returning * into v_report;
      insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
      values(v_report.department_id,'report_returned','Report returned for changes',v_report.return_reason,'report',v_report.id);
    elsif v_status='locked' then
      if v_context.actor_role not in ('management','administrator') or v_report.status<>'approved' then
        raise exception 'Only an approved report can be locked.' using errcode='42501';
      end if;
      update public.ops_reports set status='locked',locked_at=now() where id=v_report.id returning * into v_report;
    else
      return jsonb_build_object('status','invalid','message','Choose Verify, Approve, Return or Lock.');
    end if;

    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'transition_report','report',v_report.id::text,jsonb_build_object('status',v_report.status,'reason',p_payload->>'reason'));
    return jsonb_build_object('status','success','report_id',v_report.id,'report_status',v_report.status);
  end if;

  if v_action = 'set_department_code' then
    if v_context.actor_role<>'administrator' then raise exception 'School Administration access is required.' using errcode='42501'; end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the administrator name.'); end if;
    v_department_id:=nullif(p_payload->>'department_id','')::uuid;
    v_code:=coalesce(p_payload->>'access_code','');
    if length(v_code)<6 or length(v_code)>64 then return jsonb_build_object('status','invalid','message','Use a department code between 6 and 64 characters.'); end if;
    if not exists(select 1 from public.ops_departments where id=v_department_id and active and workspace_enabled) then
      return jsonb_build_object('status','invalid','message','Department not found.');
    end if;
    insert into public.ops_department_credentials(department_id,access_hash,updated_by_role)
    values(v_department_id,extensions.crypt(v_code,extensions.gen_salt('bf',10)),v_context.actor_role)
    on conflict (department_id) do update set
      access_hash=excluded.access_hash,failed_attempts=0,locked_until=null,
      updated_by_role=excluded.updated_by_role,updated_at=now();
    perform private.ops_audit(v_context.actor_role,null,v_actor_name,
      'set_department_code','department',v_department_id::text,'{}'::jsonb);
    return jsonb_build_object('status','success','department_id',v_department_id);
  end if;

  if v_action = 'save_membership' then
    if v_context.actor_role not in ('student_leadership','management','administrator') then
      raise exception 'Student Leadership access is required.' using errcode='42501';
    end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the person changing membership.'); end if;
    v_department_id:=nullif(p_payload->>'department_id','')::uuid;
    v_status:=lower(coalesce(p_payload->>'membership_action','add'));
    if not exists(select 1 from public.students where id=p_payload->>'student_id' and is_active) then
      return jsonb_build_object('status','invalid','message','Student not found.');
    end if;
    if v_status='remove' then
      update public.ops_department_memberships set active=false,ends_on=coalesce(ends_on,current_date)
      where department_id=v_department_id and student_id=p_payload->>'student_id' and active;
    else
      update public.ops_department_memberships set active=true,ends_on=null,
        member_role=case when lower(coalesce(p_payload->>'member_role','member')) in ('member','student_leader','assistant','hod_delegate')
          then lower(coalesce(p_payload->>'member_role','member')) else 'member' end
      where department_id=v_department_id and student_id=p_payload->>'student_id' and active;
      if not found then
        insert into public.ops_department_memberships(department_id,student_id,member_role)
        values(v_department_id,p_payload->>'student_id',
          case when lower(coalesce(p_payload->>'member_role','member')) in ('member','student_leader','assistant','hod_delegate')
            then lower(coalesce(p_payload->>'member_role','member')) else 'member' end);
      end if;
    end if;
    perform private.ops_audit(v_context.actor_role,null,v_actor_name,
      'save_membership','department',v_department_id::text,jsonb_build_object('student_id',p_payload->>'student_id','action',v_status));
    return jsonb_build_object('status','success');
  end if;

  if v_action = 'record_activity' then
    v_department_id:=coalesce(nullif(p_payload->>'department_id','')::uuid,v_context.actor_department_id);
    if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
      raise exception 'You cannot record for that department.' using errcode='42501';
    end if;
    if v_actor_name is null or nullif(btrim(p_payload->>'entry_type'),'') is null then
      return jsonb_build_object('status','invalid','message','Enter the person and record type.');
    end if;
    insert into public.ops_activity_records(
      department_id,record_date,entry_type,unit_id,task_id,session_id,report_id,staff_name,payload
    ) values (
      v_department_id,coalesce(nullif(p_payload->>'record_date','')::date,current_date),btrim(p_payload->>'entry_type'),
      nullif(p_payload->>'unit_id','')::uuid,nullif(p_payload->>'task_id','')::uuid,
      nullif(p_payload->>'session_id','')::uuid,nullif(p_payload->>'report_id','')::uuid,
      v_actor_name,coalesce(p_payload->'data','{}'::jsonb)
    ) returning id into v_id;
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'record_activity','activity_record',v_id::text,jsonb_build_object('entry_type',p_payload->>'entry_type'));
    return jsonb_build_object('status','success','activity_id',v_id);
  end if;

  if v_action = 'create_transfer' then
    v_department_id:=coalesce(nullif(p_payload->>'from_department_id','')::uuid,v_context.actor_department_id);
    v_target_department_id:=nullif(p_payload->>'to_department_id','')::uuid;
    if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
      raise exception 'You cannot send for that department.' using errcode='42501';
    end if;
    if v_target_department_id is null or v_target_department_id=v_department_id then
      return jsonb_build_object('status','invalid','message','Choose a different receiving department.');
    end if;
    if v_actor_name is null or jsonb_typeof(coalesce(p_payload->'items','[]'::jsonb))<>'array'
       or jsonb_array_length(coalesce(p_payload->'items','[]'::jsonb))=0 then
      return jsonb_build_object('status','invalid','message','Enter the sender and at least one transfer item.');
    end if;
    insert into public.ops_transfers(
      transfer_date,from_department_id,to_department_id,reference,status,sent_by_name,sent_at,notes
    ) values (
      coalesce(nullif(p_payload->>'transfer_date','')::date,current_date),v_department_id,v_target_department_id,
      nullif(btrim(p_payload->>'reference'),''),'sent',v_actor_name,now(),nullif(btrim(p_payload->>'notes'),'')
    ) returning * into v_transfer;
    for v_item in select value from jsonb_array_elements(p_payload->'items') loop
      if nullif(btrim(v_item->>'item_name'),'') is not null and coalesce(nullif(v_item->>'quantity','')::numeric,0)>0 then
        insert into public.ops_transfer_items(transfer_id,item_name,quantity,unit,notes)
        values(v_transfer.id,btrim(v_item->>'item_name'),(v_item->>'quantity')::numeric,
          coalesce(nullif(btrim(v_item->>'unit'),''),'unit'),nullif(btrim(v_item->>'notes'),''));
      end if;
    end loop;
    select count(*) into v_count from public.ops_transfer_items where transfer_id=v_transfer.id;
    if v_count=0 then raise exception 'At least one transfer item must have a quantity greater than zero.'; end if;
    insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
    values(v_target_department_id,'transfer_received','Internal transfer awaiting receipt',
      format('%s sent %s item line(s).',(select name from public.ops_departments where id=v_department_id),v_count),'transfer',v_transfer.id);
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'create_transfer','transfer',v_transfer.id::text,jsonb_build_object('to_department_id',v_target_department_id,'item_count',v_count));
    return jsonb_build_object('status','success','transfer_id',v_transfer.id);
  end if;

  if v_action = 'receive_transfer' then
    v_id:=nullif(p_payload->>'transfer_id','')::uuid;
    select * into v_transfer from public.ops_transfers where id=v_id for update;
    if not found or v_transfer.status<>'sent' then return jsonb_build_object('status','invalid','message','Transfer is not awaiting receipt.'); end if;
    if v_context.actor_role='department' and v_context.actor_department_id<>v_transfer.to_department_id then
      raise exception 'Only the receiving department can complete this transfer.' using errcode='42501';
    end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the receiving person.'); end if;
    v_status:=case when lower(coalesce(p_payload->>'decision','received'))='disputed' then 'disputed' else 'received' end;
    update public.ops_transfers set status=v_status,received_by_name=v_actor_name,received_at=now(),
      notes=coalesce(nullif(btrim(p_payload->>'notes'),''),notes)
    where id=v_transfer.id;
    insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
    values(v_transfer.from_department_id,'transfer_update','Internal transfer updated',
      format('%s marked the transfer %s.',(select name from public.ops_departments where id=v_transfer.to_department_id),v_status),'transfer',v_transfer.id);
    perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
      'receive_transfer','transfer',v_transfer.id::text,jsonb_build_object('status',v_status));
    return jsonb_build_object('status','success','transfer_status',v_status);
  end if;

  if v_action = 'save_management_action' then
    if v_context.actor_role not in ('student_leadership','management','administrator') then
      raise exception 'Leadership or management access is required.' using errcode='42501';
    end if;
    if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter the person creating this action.'); end if;
    if length(btrim(coalesce(p_payload->>'summary','')))<3 then return jsonb_build_object('status','invalid','message','Enter the management action.'); end if;
    v_status:=case when lower(coalesce(p_payload->>'priority','medium')) in ('low','medium','high','critical')
      then lower(coalesce(p_payload->>'priority','medium')) else 'medium' end;
    insert into public.ops_management_actions(
      department_id,report_id,task_id,summary,description,priority,status,owner_name,due_date,created_by_name,created_by_role
    ) values (
      nullif(p_payload->>'department_id','')::uuid,nullif(p_payload->>'report_id','')::uuid,
      nullif(p_payload->>'task_id','')::uuid,btrim(p_payload->>'summary'),nullif(btrim(p_payload->>'description'),''),
      v_status,'open',nullif(btrim(p_payload->>'owner_name'),''),nullif(p_payload->>'due_date','')::date,
      v_actor_name,v_context.actor_role
    ) returning * into v_management_action;
    if coalesce(nullif(p_payload->>'sync_to_jira','')::boolean,false) or v_management_action.priority in ('high','critical') then
      insert into public.ops_jira_outbox(event_type,aggregate_type,aggregate_id,idempotency_key,payload)
      select 'management_action','management_action',v_management_action.id,'action:'||v_management_action.id::text,
        jsonb_build_object(
          'action_id',v_management_action.id,'summary',v_management_action.summary,
          'description',v_management_action.description,'priority',v_management_action.priority,
          'owner_name',v_management_action.owner_name,'due_date',v_management_action.due_date,
          'department_id',d.id,'department_slug',d.slug,'department_name',d.name,
          'jira_operations_value',d.jira_operations_value,'jira_operations_option_id',d.jira_operations_option_id
        )
      from public.ops_departments d where d.id=v_management_action.department_id
      on conflict (idempotency_key) do nothing;
    end if;
    perform private.ops_audit(v_context.actor_role,null,v_actor_name,
      'save_management_action','management_action',v_management_action.id::text,jsonb_build_object('priority',v_management_action.priority));
    return jsonb_build_object('status','success','action_id',v_management_action.id);
  end if;

  if v_action = 'mark_notification_read' then
    v_id:=nullif(p_payload->>'notification_id','')::uuid;
    if not exists(select 1 from public.ops_notifications n where n.id=v_id and (
      (v_context.actor_role='department' and n.department_id=v_context.actor_department_id)
      or n.target_role=v_context.actor_role
      or (v_context.actor_role in ('management','administrator') and n.target_role in ('management','administrator'))
    )) then raise exception 'Notification not found.' using errcode='42501'; end if;
    insert into public.ops_notification_reads(notification_id,access_session_id)
    values(v_id,v_context.access_session_id) on conflict do nothing;
    return jsonb_build_object('status','success');
  end if;

  return jsonb_build_object('status','invalid','message','Unknown operation.');
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_create_department_pin(p_department_slug text, p_new_pin text, p_confirm_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'extensions', 'pg_catalog'
AS $function$
declare
  v_department public.ops_departments%rowtype;
  v_rows integer := 0;
begin
  if p_new_pin !~ '^[0-9]{4}$' or p_new_pin <> p_confirm_pin then
    return jsonb_build_object(
      'status','invalid',
      'message','Enter and confirm the same four-digit PIN.'
    );
  end if;

  select *
  into v_department
  from public.ops_departments
  where slug=lower(trim(coalesce(p_department_slug,'')))
    and active
    and workspace_enabled;

  if not found then
    return jsonb_build_object('status','not_found','message','Department not found.');
  end if;

  if exists(
    select 1
    from public.ops_department_credentials
    where department_id=v_department.id
  ) then
    return jsonb_build_object(
      'status','already_configured',
      'message','This department already has a PIN. Use the current PIN or ask School Administration to change it.'
    );
  end if;

  insert into public.ops_department_credentials(
    department_id,access_hash,failed_attempts,locked_until,updated_by_role,updated_at
  )
  values(
    v_department.id,
    extensions.crypt(p_new_pin,extensions.gen_salt('bf',10)),
    0,null,'department',now()
  )
  on conflict(department_id) do nothing;

  get diagnostics v_rows = row_count;
  if v_rows=0 then
    return jsonb_build_object(
      'status','already_configured',
      'message','This department already has a PIN. Use the current PIN or ask School Administration to change it.'
    );
  end if;

  perform private.system_store_recoverable_pin(
    'department',v_department.id::text,p_new_pin
  );

  perform private.ops_audit(
    'department',v_department.id,v_department.name,
    'create_department_pin','department',v_department.id::text,
    jsonb_build_object('method','direct_first_login')
  );

  return jsonb_build_object(
    'status','success',
    'department_id',v_department.id,
    'department_name',v_department.name
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_department_pin_setup_overview(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_setups jsonb;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role<>'administrator' then
    return jsonb_build_object('status','unauthorized','message','School Administration access is required.');
  end if;
  select coalesce(jsonb_agg(jsonb_build_object(
    'department_id',d.id,
    'setup_status',case
      when s.department_id is null then 'not_issued'
      when s.status='used' then 'used'
      when s.status='revoked' then 'revoked'
      when s.locked_until is not null and s.locked_until>now() then 'locked'
      when s.expires_at<=now() then 'expired'
      else 'active'
    end,
    'expires_at',s.expires_at,'locked_until',s.locked_until,'issued_at',s.issued_at,'issued_by_name',s.issued_by_name
  ) order by d.sort_order,d.name),'[]'::jsonb)
  into v_setups
  from public.ops_departments d
  left join public.ops_department_pin_setups s on s.department_id=d.id
  where d.active and d.workspace_enabled;
  return jsonb_build_object('status','success','setups',v_setups);
exception when sqlstate '28000' then
  return jsonb_build_object('status','unauthorized','message',sqlerrm);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_department_tool_command(p_session_token text, p_action text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_department_id uuid; v_actor text; v_id uuid; v_item public.ops_stock_items%rowtype; v_delta numeric;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role='student_leadership' then raise exception 'Department tool access is required.' using errcode='42501'; end if;
  v_department_id := coalesce(nullif(p_payload->>'department_id','')::uuid,v_context.actor_department_id);
  if v_department_id is null or not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then raise exception 'You cannot record for that department.' using errcode='42501'; end if;
  v_actor := nullif(btrim(p_payload->>'actor_name'),'');
  if v_actor is null then return jsonb_build_object('status','invalid','message','Select or enter the person recording this.'); end if;
  if p_action='save_plan' then
    if nullif(btrim(p_payload->>'plan_type'),'') is null or nullif(btrim(p_payload->>'title'),'') is null then return jsonb_build_object('status','invalid','message','Enter the plan type and title.'); end if;
    insert into public.ops_department_plans(department_id,starts_on,ends_on,plan_type,title,details,recorded_by_name)
    values(v_department_id,(p_payload->>'starts_on')::date,coalesce(nullif(p_payload->>'ends_on','')::date,(p_payload->>'starts_on')::date),btrim(p_payload->>'plan_type'),btrim(p_payload->>'title'),nullif(btrim(p_payload->>'details'),''),v_actor)
    returning id into v_id;
  elsif p_action='add_stock_item' then
    if nullif(btrim(p_payload->>'item_name'),'') is null or nullif(btrim(p_payload->>'unit'),'') is null then return jsonb_build_object('status','invalid','message','Enter the item name and unit.'); end if;
    insert into public.ops_stock_items(department_id,item_name,category,unit,reorder_level,recorded_by_name)
    values(v_department_id,btrim(p_payload->>'item_name'),nullif(btrim(p_payload->>'category'),''),btrim(p_payload->>'unit'),nullif(p_payload->>'reorder_level','')::numeric,v_actor)
    returning * into v_item;
    v_id:=v_item.id;
    v_delta:=coalesce(nullif(p_payload->>'opening_quantity','')::numeric,0);
    if v_delta<>0 then insert into public.ops_stock_movements(stock_item_id,department_id,movement_type,quantity_delta,notes,recorded_by_name) values(v_item.id,v_department_id,'adjustment',v_delta,'Opening quantity',v_actor); end if;
  elsif p_action='record_stock_movement' then
    select * into v_item from public.ops_stock_items where id=(p_payload->>'stock_item_id')::uuid and department_id=v_department_id and active;
    if not found then return jsonb_build_object('status','invalid','message','Choose a stock item.'); end if;
    v_delta:=coalesce(nullif(p_payload->>'quantity','')::numeric,0);
    if v_delta<=0 then return jsonb_build_object('status','invalid','message','Enter a quantity greater than zero.'); end if;
    if p_payload->>'movement_type' in ('used','wasted') then v_delta:=-v_delta; elsif p_payload->>'movement_type' not in ('received','adjustment') then return jsonb_build_object('status','invalid','message','Choose Received, Used, Wasted or Adjustment.'); end if;
    insert into public.ops_stock_movements(stock_item_id,department_id,movement_date,movement_type,quantity_delta,notes,recorded_by_name)
    values(v_item.id,v_department_id,coalesce(nullif(p_payload->>'movement_date','')::date,current_date),p_payload->>'movement_type',v_delta,nullif(btrim(p_payload->>'notes'),''),v_actor) returning id into v_id;
  elsif p_action='record_log' then
    if nullif(btrim(p_payload->>'log_type'),'') is null or nullif(btrim(p_payload->>'title'),'') is null then return jsonb_build_object('status','invalid','message','Enter the record type and title.'); end if;
    insert into public.ops_operational_logs(department_id,record_date,log_type,title,quantity,unit,notes,recorded_by_name)
    values(v_department_id,coalesce(nullif(p_payload->>'record_date','')::date,current_date),btrim(p_payload->>'log_type'),btrim(p_payload->>'title'),nullif(p_payload->>'quantity','')::numeric,nullif(btrim(p_payload->>'unit'),''),nullif(btrim(p_payload->>'notes'),''),v_actor) returning id into v_id;
  else return jsonb_build_object('status','invalid','message','Unknown department tool action.');
  end if;
  perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor,p_action,'department_tool',v_id::text,jsonb_build_object('department_id',v_department_id));
  return jsonb_build_object('status','success','id',v_id);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_department_tools_bootstrap(p_session_token text, p_department_id uuid DEFAULT NULL::uuid, p_from_date date DEFAULT (CURRENT_DATE - 14), p_to_date date DEFAULT (CURRENT_DATE + 14))
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_department_id uuid; v_slug text;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role='student_leadership' then raise exception 'Department tool access is required.' using errcode='42501'; end if;
  v_department_id := coalesce(p_department_id,v_context.actor_department_id);
  if v_department_id is null or not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
    raise exception 'You cannot open tools for that department.' using errcode='42501';
  end if;
  select slug into v_slug from public.ops_departments where id=v_department_id and active;
  return jsonb_build_object(
    'status','success','department_id',v_department_id,'department_slug',v_slug,
    'plans',(select coalesce(jsonb_agg(to_jsonb(p) order by p.starts_on desc,p.created_at desc),'[]'::jsonb) from public.ops_department_plans p where p.department_id=v_department_id and p.ends_on>=p_from_date and p.starts_on<=p_to_date),
    'stock_items',(select coalesce(jsonb_agg(jsonb_build_object(
      'id',i.id,'item_name',i.item_name,'category',i.category,'unit',i.unit,'reorder_level',i.reorder_level,
      'current_quantity',coalesce((select sum(m.quantity_delta) from public.ops_stock_movements m where m.stock_item_id=i.id),0)
    ) order by i.item_name),'[]'::jsonb) from public.ops_stock_items i where i.department_id=v_department_id and i.active),
    'stock_movements',(select coalesce(jsonb_agg(jsonb_build_object(
      'id',m.id,'stock_item_id',m.stock_item_id,'movement_date',m.movement_date,'movement_type',m.movement_type,
      'quantity_delta',m.quantity_delta,'notes',m.notes,'recorded_by_name',m.recorded_by_name
    ) order by m.movement_date desc,m.created_at desc),'[]'::jsonb) from public.ops_stock_movements m where m.department_id=v_department_id and m.movement_date between p_from_date and p_to_date),
    'logs',(select coalesce(jsonb_agg(to_jsonb(l) order by l.record_date desc,l.created_at desc),'[]'::jsonb) from public.ops_operational_logs l where l.department_id=v_department_id and l.record_date between p_from_date and p_to_date)
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_duties_dashboard(p_session_token text, p_from_week date DEFAULT CURRENT_DATE, p_to_week date DEFAULT (CURRENT_DATE + 120))
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_from date;
  v_to date;
begin
  select * into v_context from private.ops_session_context(p_session_token);

  if v_context.actor_role = 'department' then
    select d.slug into v_department_slug
    from public.ops_departments d
    where d.id = v_context.actor_department_id;
  end if;

  if v_context.actor_role not in ('student_leadership','management','administrator')
     and not (v_context.actor_role = 'department' and v_department_slug = 'security') then
    raise exception 'Duties access requires Student Leadership, Management, School Administration, or Security.'
      using errcode = '42501';
  end if;

  v_from := coalesce(p_from_week,current_date)
    - (extract(isodow from coalesce(p_from_week,current_date))::integer - 1);
  v_to := least(
    coalesce(p_to_week,v_from + 120)
      - (extract(isodow from coalesce(p_to_week,v_from + 120))::integer - 1),
    v_from + 364
  );

  return jsonb_build_object(
    'status','success',
    'current_week',current_date - (extract(isodow from current_date)::integer - 1),
    'permissions',jsonb_build_object(
      'can_manage_weekly',v_context.actor_role = 'student_leadership',
      'can_manage_gate',v_context.actor_role = 'student_leadership'
        or (v_context.actor_role = 'department' and v_department_slug = 'security')
    ),
    'weeks',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'week_start',w.week_start,
        'week_end',w.week_start + 6,
        'prefect_on_duty',r.prefect_on_duty,
        'prefect_student_id',r.prefect_student_id,
        'prefect_registration_number',pod_student.registration_number,
        'senior_prefect_on_duty',r.senior_prefect_on_duty,
        'senior_prefect_student_id',r.senior_prefect_student_id,
        'senior_prefect_registration_number',senior_student.registration_number,
        'bell_ringer_student_id',sdw.bell_ringer_student_id,
        'bell_ringer_2_student_id',sdw.bell_ringer_2_student_id,
        'bell_ringer',nullif(concat_ws(' and ',bell.full_name,bell_2.full_name),''),
        'bell_ringer_2',bell_2.full_name,
        'bell_ringer_registration_number',bell.registration_number,
        'bell_ringer_2_registration_number',bell_2.registration_number,
        'bell_ringers',coalesce((
          select jsonb_agg(jsonb_build_object(
            'student_id',s.id,
            'registration_number',s.registration_number,
            'full_name',s.full_name
          ) order by selected.sort_order)
          from (values
            (sdw.bell_ringer_student_id,1),
            (sdw.bell_ringer_2_student_id,2)
          ) selected(student_id,sort_order)
          join public.students s on s.id=selected.student_id
        ),'[]'::jsonb),
        'kitchen_department_id',sdw.kitchen_department_id,
        'kitchen_department',kd.name,
        'toilet_department_id',sdw.toilet_department_id,
        'toilet_department',td.name,
        'kitchen_people',coalesce((
          select jsonb_agg(jsonb_build_object(
            'student_id',m.student_id,
            'registration_number',s.registration_number,
            'full_name',s.full_name,
            'assignment_source',m.assignment_source
          ) order by m.sort_order,s.full_name)
          from public.ops_service_duty_members m
          join public.students s on s.id=m.student_id
          where m.week_start=w.week_start and m.duty_type='kitchen'
        ),'[]'::jsonb),
        'toilet_people',coalesce((
          select jsonb_agg(jsonb_build_object(
            'student_id',m.student_id,
            'registration_number',s.registration_number,
            'full_name',s.full_name,
            'assignment_source',m.assignment_source
          ) order by m.sort_order,s.full_name)
          from public.ops_service_duty_members m
          join public.students s on s.id=m.student_id
          where m.week_start=w.week_start and m.duty_type='toilet'
        ),'[]'::jsonb)
      ) order by w.week_start),'[]'::jsonb)
      from (
        select week_start from public.ops_weekly_duty_roster
        where week_start between v_from and v_to
        union
        select week_start from public.ops_service_duty_weeks
        where week_start between v_from and v_to
      ) w
      left join public.ops_weekly_duty_roster r on r.week_start=w.week_start
      left join public.students pod_student on pod_student.id=r.prefect_student_id
      left join public.students senior_student on senior_student.id=r.senior_prefect_student_id
      left join public.ops_service_duty_weeks sdw on sdw.week_start=w.week_start
      left join public.students bell on bell.id=sdw.bell_ringer_student_id
      left join public.students bell_2 on bell_2.id=sdw.bell_ringer_2_student_id
      left join public.ops_departments kd on kd.id=sdw.kitchen_department_id
      left join public.ops_departments td on td.id=sdw.toilet_department_id
    ),
    'gate_assignments',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'duty_date',g.duty_date,
        'slot_code',g.slot_code,
        'student_id',g.student_id,
        'registration_number',s.registration_number,
        'student_name',s.full_name,
        'updated_at',g.updated_at
      ) order by g.duty_date,
        case g.slot_code when '22_00' then 1 when '00_02' then 2 else 3 end
      ),'[]'::jsonb)
      from public.ops_gate_duty_assignments g
      join public.students s on s.id=g.student_id
      where g.duty_date between v_from and v_to + 6
    )
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_fee_dashboard(p_session_token text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_term_id bigint;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role='department' then
    select slug into v_department_slug from public.ops_departments where id=v_context.actor_department_id;
  end if;
  if not (
    v_context.actor_role='administrator'
    or (v_context.actor_role='department' and v_department_slug='administrators-office')
  ) then
    raise exception 'School Administration or Administrator''s Office access is required.' using errcode='42501';
  end if;
  if p_term_id is null then
    select id into v_term_id from public.academic_terms
    order by registration_is_open desc,is_current desc,academic_year desc,term_number desc limit 1;
  else
    v_term_id:=p_term_id;
  end if;
  return private.fee_dashboard_for_term(v_term_id);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_generate_department_pin_setup(p_session_token text, p_department_id uuid, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role <> 'administrator' then
    return jsonb_build_object('status','unauthorized','message','School Administration access is required.');
  end if;

  return jsonb_build_object(
    'status','disabled',
    'message','One-time department setup codes are no longer used. Departments now choose a 4-digit PIN directly at login.'
  );
exception when sqlstate '28000' then
  return jsonb_build_object('status','unauthorized','message',sqlerrm);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_generate_report(p_session_token text, p_report_type text, p_department_id uuid, p_period_start date, p_period_end date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department public.ops_departments%rowtype;
  v_type text := lower(coalesce(p_report_type,''));
  v_daily_count integer;
  v_overdue integer;
  v_blocked integer;
  v_completed integer;
  v_sessions integer;
  v_result jsonb;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,p_department_id) then
    raise exception 'You cannot view that department.' using errcode='42501';
  end if;
  if v_type not in ('weekly','monthly') or p_period_start is null or p_period_end is null
     or p_period_end < p_period_start or p_period_end > p_period_start + 40 then
    return jsonb_build_object('status','invalid','message','Choose a valid weekly or monthly period.');
  end if;

  select * into v_department from public.ops_departments where id=p_department_id and active;
  if not found then return jsonb_build_object('status','invalid','message','Department not found.'); end if;

  select count(*)
  into v_daily_count
  from public.ops_reports
  where department_id=p_department_id and report_type='daily'
    and report_date between p_period_start and p_period_end
    and status in ('submitted','verified','approved','locked');
  select count(*) filter(where status='done'),
         count(*) filter(where status='blocked'),
         count(*) filter(where due_date < p_period_end and status not in ('done','cancelled'))
  into v_completed,v_blocked,v_overdue
  from public.ops_tasks
  where department_id=p_department_id and archived_at is null
    and (due_date is null or due_date <= p_period_end);

  select count(*) into v_sessions
  from public.ops_work_sessions
  where department_id=p_department_id and work_date between p_period_start and p_period_end
    and status <> 'cancelled';

  select jsonb_build_object(
    'status','success',
    'report_type',v_type,
    'department',jsonb_build_object('id',v_department.id,'slug',v_department.slug,'name',v_department.name),
    'period_start',p_period_start,
    'period_end',p_period_end,
    'source_counts',jsonb_build_object(
      'daily_reports',v_daily_count,'completed_tasks',v_completed,'blocked_tasks',v_blocked,
      'overdue_tasks',v_overdue,'work_sessions',v_sessions
    ),
    'suggested_status',case when v_blocked>0 or v_overdue>2 then 'red' when v_overdue>0 or v_daily_count=0 then 'amber' else 'green' end,
    'summary',format('%s completed tasks, %s work sessions, %s blocked tasks and %s overdue tasks.',v_completed,v_sessions,v_blocked,v_overdue),
    'work_completed',coalesce((select string_agg(format('%s: %s',to_char(report_date,'DD Mon'),work_completed),E'\n\n' order by report_date)
      from public.ops_reports where department_id=p_department_id and report_type='daily'
      and report_date between p_period_start and p_period_end and nullif(btrim(work_completed),'') is not null
      and status in ('submitted','verified','approved','locked')),''),
    'work_open',coalesce((select string_agg(format('%s: %s',to_char(report_date,'DD Mon'),work_open),E'\n\n' order by report_date)
      from public.ops_reports where department_id=p_department_id and report_type='daily'
      and report_date between p_period_start and p_period_end and nullif(btrim(work_open),'') is not null
      and status in ('submitted','verified','approved','locked')),''),
    'challenges',coalesce((select string_agg(format('%s: %s',to_char(report_date,'DD Mon'),challenges),E'\n\n' order by report_date)
      from public.ops_reports where department_id=p_department_id and report_type='daily'
      and report_date between p_period_start and p_period_end and nullif(btrim(challenges),'') is not null
      and status in ('submitted','verified','approved','locked')),''),
    'action_required',coalesce((select string_agg(format('%s: %s',to_char(report_date,'DD Mon'),action_required),E'\n\n' order by report_date)
      from public.ops_reports where department_id=p_department_id and report_type='daily'
      and report_date between p_period_start and p_period_end and nullif(btrim(action_required),'') is not null
      and status in ('submitted','verified','approved','locked')),''),
    'stock_equipment',coalesce((select string_agg(format('%s: %s',to_char(report_date,'DD Mon'),stock_equipment),E'\n\n' order by report_date)
      from public.ops_reports where department_id=p_department_id and report_type='daily'
      and report_date between p_period_start and p_period_end and nullif(btrim(stock_equipment),'') is not null
      and status in ('submitted','verified','approved','locked')),''),
    'risks',coalesce((select string_agg(format('%s: %s',to_char(report_date,'DD Mon'),risks),E'\n\n' order by report_date)
      from public.ops_reports where department_id=p_department_id and report_type='daily'
      and report_date between p_period_start and p_period_end and nullif(btrim(risks),'') is not null
      and status in ('submitted','verified','approved','locked')),''),
    'open_tasks',coalesce((select jsonb_agg(jsonb_build_object(
      'id',t.id,'title',t.title,'status',t.status,'priority',t.priority,'due_date',t.due_date,'owner_name',t.owner_name
    ) order by t.due_date nulls last,t.priority desc) from public.ops_tasks t
      where t.department_id=p_department_id and t.archived_at is null and t.status not in ('done','cancelled')),'[]'::jsonb),
    'sessions',coalesce((select jsonb_agg(jsonb_build_object(
      'id',ws.id,'work_date',ws.work_date,'slot',slot.name,'status',ws.status,
      'allocated_headcount',ws.allocated_headcount,'assigned_count',(select count(*) from public.ops_session_assignments a where a.session_id=ws.id)
    ) order by ws.work_date,slot.sort_order) from public.ops_work_sessions ws
      join public.ops_time_slots slot on slot.id=ws.slot_id
      where ws.department_id=p_department_id and ws.work_date between p_period_start and p_period_end
      and ws.status<>'cancelled'),'[]'::jsonb)
  ) into v_result;

  return v_result;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_group_planner(p_session_token text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT (CURRENT_DATE + 21))
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_holiday boolean;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('student_leadership','management','administrator','department') then
    raise exception 'Operations access is required.' using errcode='42501';
  end if;
  v_holiday := coalesce((select (setting_value #>> '{}')::boolean from public.system_settings where setting_key='school_holiday_mode'),false);
  return jsonb_build_object(
    'status','success','holiday_mode',v_holiday,'next_day_cutoff','18:00',
    'request_kinds',(select coalesce(jsonb_object_agg(r.id::text,r.request_kind),'{}'::jsonb) from public.ops_session_requests r where r.work_date between coalesce(p_from_date,current_date) and coalesce(p_to_date,current_date+21) and (v_context.actor_role<>'department' or r.department_id=v_context.actor_department_id)),
    'groups',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'code',g.code,'label',g.label,'total',coalesce(c.total,0)
      ) order by g.sort_order),'[]'::jsonb)
      from (values
        ('year1_men','1st year men',10),('year1_ladies','1st year ladies',20),
        ('year2_men','2nd year men',30),('year2_ladies','2nd year ladies',40)
      ) g(code,label,sort_order)
      left join (
        select private.ops_group_code(s.registration_number,s.gender) code,count(*)::integer total
        from public.students s
        where s.is_active and s.gender is not null and private.ops_student_is_available(s.id)
        group by private.ops_group_code(s.registration_number,s.gender)
      ) c on c.code=g.code
    ),
    'allocations',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'id',a.id,'session_id',a.session_id,'group_code',a.group_code,'headcount',a.headcount,
        'work_date',ws.work_date,'slot_id',ws.slot_id,'department_id',ws.department_id,
        'assigned_by_name',a.assigned_by_name,'assigned_at',a.assigned_at
      ) order by ws.work_date,a.group_code),'[]'::jsonb)
      from public.ops_session_group_allocations a
      join public.ops_work_sessions ws on ws.id=a.session_id
      where ws.work_date between coalesce(p_from_date,current_date) and coalesce(p_to_date,current_date+21)
        and (v_context.actor_role<>'department' or ws.department_id=v_context.actor_department_id)
    )
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_immigration_bootstrap(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_rows jsonb; v_summary jsonb;
begin
  select * into v_context from private.immigration_session_context(p_session_token,false);
  select coalesce(jsonb_agg(jsonb_build_object(
    'student_id',s.id,'student_name',s.full_name,'registration_number',s.registration_number,'gender',s.gender,
    'residency_status',coalesce(ip.residency_status,'not_recorded'),'country',ip.country,'nationality',ip.nationality,
    'sponsor_id',ip.sponsor_id,'sponsor_name',sp.name,'sponsor_phone',sp.phone,
    'passport_number',ip.passport_number,'passport_issue_date',ip.passport_issue_date,'passport_expiry_date',ip.passport_expiry_date,
    'permit_type',ip.permit_type,'permit_number',ip.permit_number,'permit_issue_date',ip.permit_issue_date,'permit_expiry_date',ip.permit_expiry_date,
    'next_action',ip.next_action,'next_action_date',ip.next_action_date,'notes',ip.notes,'updated_by',ip.updated_by,'updated_at',ip.updated_at,
    'residence',aa.residence,'room',aa.room,
    'documents',coalesce((select jsonb_agg(to_jsonb(d)-'storage_path' order by d.uploaded_at desc) from public.student_immigration_documents d where d.student_id=s.id and d.confirmed_at is not null),'[]'::jsonb)
  ) order by s.full_name),'[]'::jsonb) into v_rows
  from public.students s
  left join public.student_immigration_profiles ip on ip.student_id=s.id
  left join public.sponsors sp on sp.id=ip.sponsor_id
  left join lateral (select a.residence,a.room from public.accommodation_allocations a where a.student_id=s.id and a.is_active order by a.allocated_at desc limit 1) aa on true
  where s.is_active;
  select jsonb_build_object(
    'total',count(*),'local',count(*) filter(where ip.residency_status='local'),
    'international',count(*) filter(where ip.residency_status='international'),
    'not_recorded',count(*) filter(where ip.student_id is null),
    'passports_expiring_90_days',count(*) filter(where ip.passport_expiry_date between current_date and current_date+90),
    'permits_expiring_90_days',count(*) filter(where ip.permit_expiry_date between current_date and current_date+90)
  ) into v_summary from public.students s left join public.student_immigration_profiles ip on ip.student_id=s.id where s.is_active;
  return jsonb_build_object('status','success','role',v_context.actor_role,'can_edit',v_context.can_edit,'summary',v_summary,'students',v_rows);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_immigration_save_profile(p_session_token text, p_student_id text, p_profile jsonb, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_status text:=lower(coalesce(p_profile->>'residency_status',''));
begin
  select * into v_context from private.immigration_session_context(p_session_token,true);
  if not exists(select 1 from public.students where id=p_student_id and is_active) then return jsonb_build_object('status','not_found','message','Active student not found.'); end if;
  if v_status not in('local','international') then return jsonb_build_object('status','invalid','message','Choose Local / Zimbabwe-based or International.'); end if;
  if v_status='international' and nullif(btrim(coalesce(p_profile->>'country','')),'') is null then return jsonb_build_object('status','invalid','message','Country is required for an international student.'); end if;
  insert into public.student_immigration_profiles(
    student_id,residency_status,country,nationality,sponsor_id,passport_number,passport_issue_date,passport_expiry_date,
    permit_type,permit_number,permit_issue_date,permit_expiry_date,next_action,next_action_date,notes,updated_by,updated_at
  ) values(
    p_student_id,v_status,
    case when v_status='international' then nullif(btrim(p_profile->>'country'),'') else null end,
    case when v_status='international' then nullif(btrim(p_profile->>'nationality'),'') else null end,
    nullif(p_profile->>'sponsor_id','')::uuid,nullif(btrim(p_profile->>'passport_number'),''),nullif(p_profile->>'passport_issue_date','')::date,nullif(p_profile->>'passport_expiry_date','')::date,
    nullif(btrim(p_profile->>'permit_type'),''),nullif(btrim(p_profile->>'permit_number'),''),nullif(p_profile->>'permit_issue_date','')::date,nullif(p_profile->>'permit_expiry_date','')::date,
    nullif(btrim(p_profile->>'next_action'),''),nullif(p_profile->>'next_action_date','')::date,nullif(btrim(p_profile->>'notes'),''),nullif(btrim(p_actor_name),''),now()
  ) on conflict(student_id) do update set
    residency_status=excluded.residency_status,country=excluded.country,nationality=excluded.nationality,sponsor_id=excluded.sponsor_id,
    passport_number=excluded.passport_number,passport_issue_date=excluded.passport_issue_date,passport_expiry_date=excluded.passport_expiry_date,
    permit_type=excluded.permit_type,permit_number=excluded.permit_number,permit_issue_date=excluded.permit_issue_date,permit_expiry_date=excluded.permit_expiry_date,
    next_action=excluded.next_action,next_action_date=excluded.next_action_date,notes=excluded.notes,updated_by=excluded.updated_by,updated_at=now();
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('immigration','student',p_student_id,v_context.actor_role,'profile_saved',jsonb_build_object('actor_name',nullif(btrim(p_actor_name),''),'residency_status',v_status));
  return jsonb_build_object('status','success','message','Immigration record saved.');
exception when invalid_text_representation then return jsonb_build_object('status','invalid','message','Check the sponsor and date fields.');
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_immigration_save_sponsor(p_session_token text, p_student_id text, p_sponsor jsonb, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_id uuid; v_term_id bigint;
begin
  select * into v_context from private.immigration_session_context(p_session_token,true);
  if nullif(btrim(coalesce(p_sponsor->>'name','')),'') is null or nullif(btrim(coalesce(p_sponsor->>'phone','')),'') is null then
    return jsonb_build_object('status','invalid','message','Sponsor name and contact number are required.');
  end if;
  select id into v_term_id from public.academic_terms order by is_current desc,academic_year desc,term_number desc limit 1;
  if v_term_id is null then return jsonb_build_object('status','not_found','message','No academic term is configured.'); end if;
  v_id:=private.tr_sync_sponsor(p_student_id,v_term_id,p_sponsor->>'name',p_sponsor->>'phone',v_context.actor_role);
  update public.sponsors set email=nullif(btrim(p_sponsor->>'email'),''),relationship_to_student=nullif(btrim(p_sponsor->>'relationship'),''),
    address=nullif(btrim(p_sponsor->>'address'),''),notes=nullif(btrim(p_sponsor->>'notes'),''),updated_at=now() where id=v_id;
  insert into public.student_immigration_profiles(student_id,sponsor_id,updated_by)
  values(p_student_id,v_id,nullif(btrim(p_actor_name),''))
  on conflict(student_id) do update set sponsor_id=excluded.sponsor_id,updated_by=excluded.updated_by,updated_at=now();
  return jsonb_build_object('status','success','message','Sponsor saved.','sponsor_id',v_id);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_it_assets_bootstrap(p_session_token text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO ''
AS $function$
  select it_assets_private.bootstrap(p_session_token);
$function$
;

CREATE OR REPLACE FUNCTION public.ops_it_assets_command(p_session_token text, p_action text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO ''
AS $function$
  select it_assets_private.command(p_session_token,p_action,p_payload);
$function$
;

CREATE OR REPLACE FUNCTION public.ops_it_document_authorize(p_session_token text, p_write boolean, p_version_id uuid DEFAULT NULL::uuid)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO ''
AS $function$ select it_documents_private.authorize(p_session_token,p_write,p_version_id); $function$
;

CREATE OR REPLACE FUNCTION public.ops_it_document_commit_version(p_session_token text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO ''
AS $function$ select it_documents_private.commit_version(p_session_token,p_payload); $function$
;

CREATE OR REPLACE FUNCTION public.ops_it_documents_bootstrap(p_session_token text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO ''
AS $function$ select it_documents_private.bootstrap(p_session_token); $function$
;

CREATE OR REPLACE FUNCTION public.ops_kitchen_service(p_session_token text, p_action text, p_payload jsonb DEFAULT '{}'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_slug text;
  v_date date := coalesce(
    nullif(p_payload->>'service_date','')::date,
    timezone('Africa/Harare',now())::date
  );
  v_counts jsonb;
  v_result jsonb;
  v_recent jsonb;
  v_source text;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  select slug into v_slug
  from public.ops_departments
  where id = v_context.actor_department_id;

  if not (
    v_context.actor_role='administrator'
    or (v_context.actor_role='department' and v_slug='kitchen')
  ) then
    raise exception 'Kitchen access is required.' using errcode='42501';
  end if;

  if p_action='dashboard' then
    select jsonb_build_object(
      'Breakfast',
        count(*) filter(where meal_session='Breakfast')
        + coalesce(sum(child_portions) filter(where meal_session='Breakfast'),0),
      'Lunch',
        count(*) filter(where meal_session='Lunch')
        + coalesce(sum(child_portions) filter(where meal_session='Lunch'),0),
      'Break-fast 4pm',
        count(*) filter(where meal_session='Break-fast 4pm')
        + coalesce(sum(child_portions) filter(where meal_session='Break-fast 4pm'),0),
      'Supper',
        count(*) filter(where meal_session='Supper')
        + coalesce(sum(child_portions) filter(where meal_session='Supper'),0)
    ) into v_counts
    from public.check_ins
    where service_date=v_date;

    select coalesce(
      jsonb_agg(to_jsonb(recent_row) order by recent_row.checked_in_at desc),
      '[]'::jsonb
    ) into v_recent
    from (
      select
        c.checked_in_at,
        c.meal_session,
        c.check_in_source,
        c.collection_event_id,
        c.recipient_role,
        c.child_portions,
        s.registration_number::text as registration_number,
        s.full_name
      from public.check_ins c
      join public.students s on s.id=c.student_id
      where c.service_date=v_date
      order by c.checked_in_at desc, c.id desc
      limit 20
    ) recent_row;

    return jsonb_build_object(
      'status','success',
      'service_date',v_date,
      'conference_mode',private.conference_mode(),
      'collection_enabled',not private.conference_mode(),
      'counts',v_counts,
      'recent',v_recent,
      'lunch_to_cook',(
        select count(*) from public.meal_plans
        where service_date=v_date and meal_session='Breakfast'
      )
    );
  elsif p_action='check_in' then
    if private.conference_mode() then
      return jsonb_build_object(
        'status','conference_disabled',
        'message','Meal collection is unavailable while Conference Mode is on.'
      );
    end if;
    v_source := case lower(coalesce(p_payload->>'source','manual'))
      when 'scanner' then 'operations_scanner'
      when 'camera' then 'operations_camera'
      else 'operations_manual'
    end;
    return public._perform_meal_check_in(
      p_payload->>'registration_number',
      p_payload->>'meal_session',
      v_date,
      v_source
    );
  elsif p_action='export' then
    select coalesce(
      jsonb_agg(to_jsonb(export_row) order by export_row.service_date,export_row.checked_in_at),
      '[]'::jsonb
    ) into v_result
    from (
      select
        c.service_date,
        c.meal_session,
        s.registration_number::text as registration_number,
        s.full_name,
        c.checked_in_at,
        c.check_in_source,
        c.recipient_role,
        c.child_portions,
        1 + c.child_portions as portions_on_row,
        c.collection_event_id
      from public.check_ins c
      join public.students s on s.id=c.student_id
      where coalesce(p_payload->>'scope','today')='all' or c.service_date=v_date
    ) export_row;
    return jsonb_build_object('status','success','rows',v_result);
  end if;

  return jsonb_build_object('status','invalid','message','Unknown Kitchen action.');
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_kitchen_set_meal_features(p_session_token text, p_check_in_enabled boolean, p_collection_enabled boolean, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_slug text;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  select slug into v_slug from public.ops_departments where id=v_context.actor_department_id;
  if not (v_context.actor_role='administrator' or (v_context.actor_role='department' and v_slug='kitchen')) then
    return jsonb_build_object('status','unauthorized','message','Kitchen access is required.');
  end if;
  if nullif(btrim(coalesce(p_actor_name,'')),'') is null then return jsonb_build_object('status','invalid','message','Enter your name for the audit record.'); end if;
  return private.set_meal_features(p_check_in_enabled,p_collection_enabled,case when v_context.actor_role='department' then 'kitchen' else v_context.actor_role end,p_actor_name);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_login(p_access_type text, p_department_slug text, p_access_code text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog', 'extensions'
AS $function$
declare
  v_department public.ops_departments%rowtype;
  v_credential public.ops_department_credentials%rowtype;
  v_existing_role text;
  v_actor_role text;
  v_login_key text;
  v_attempts public.ops_login_attempts%rowtype;
  v_token text;
  v_hours integer := 12;
  v_expires_at timestamptz;
  v_display_name text;
  v_has_credential boolean := false;
  v_created_rows integer := 0;
begin
  p_access_type := lower(coalesce(btrim(p_access_type), ''));
  p_department_slug := lower(coalesce(btrim(p_department_slug), ''));
  p_access_code := coalesce(p_access_code, '');

  if p_access_type not in ('department','student_leadership','management','administrator') then
    return jsonb_build_object('status','invalid','message','Choose a valid workspace.');
  end if;

  v_login_key := case
    when p_access_type = 'department' then 'department:' || coalesce(nullif(p_department_slug,''),'unknown')
    else 'role:' || p_access_type
  end;

  select * into v_attempts
  from public.ops_login_attempts
  where login_key = v_login_key;

  if found and v_attempts.locked_until is not null and v_attempts.locked_until > now() then
    return jsonb_build_object(
      'status','locked',
      'message','Too many unsuccessful attempts. Try again later.',
      'retry_at',v_attempts.locked_until
    );
  end if;

  if p_access_type = 'department' then
    select * into v_department
    from public.ops_departments
    where slug = p_department_slug and active and workspace_enabled;

    if not found then
      v_actor_role := null;
    else
      select exists(
        select 1
        from public.ops_department_credentials
        where department_id = v_department.id
      ) into v_has_credential;

      if not v_has_credential then
        if p_access_code !~ '^[0-9]{4}$' then
          return jsonb_build_object(
            'status','invalid',
            'message','Choose a four-digit department PIN.'
          );
        end if;

        insert into public.ops_department_credentials(
          department_id,access_hash,failed_attempts,locked_until,updated_by_role,updated_at
        )
        values(
          v_department.id,
          extensions.crypt(p_access_code,extensions.gen_salt('bf',10)),
          0,null,'department',now()
        )
        on conflict(department_id) do nothing;

        get diagnostics v_created_rows = row_count;

        if v_created_rows > 0 then
          perform private.system_store_recoverable_pin(
            'department',v_department.id::text,p_access_code
          );
          perform private.ops_audit(
            'department',v_department.id,v_department.name,
            'create_department_pin','department',v_department.id::text,
            jsonb_build_object('method','direct_login')
          );
          v_actor_role := 'department';
          v_display_name := v_department.name;
        else
          select * into v_credential
          from public.ops_department_credentials
          where department_id = v_department.id;

          if found
             and extensions.crypt(p_access_code, v_credential.access_hash) = v_credential.access_hash then
            v_actor_role := 'department';
            v_display_name := v_department.name;
          else
            v_actor_role := null;
          end if;
        end if;
      else
        select * into v_credential
        from public.ops_department_credentials
        where department_id = v_department.id;

        if found
           and extensions.crypt(p_access_code, v_credential.access_hash) = v_credential.access_hash then
          v_actor_role := 'department';
          v_display_name := v_department.name;
        else
          v_actor_role := null;
        end if;
      end if;
    end if;
  else
    v_existing_role := private.tr_actor_from_pin(p_access_code);
    v_actor_role := case
      when p_access_type = 'student_leadership' and v_existing_role = 'student_leadership' then 'student_leadership'
      when p_access_type = 'management' and v_existing_role = 'management' then 'management'
      when p_access_type = 'administrator' and v_existing_role = 'administrator' then 'administrator'
      else null
    end;
    v_display_name := case v_actor_role
      when 'student_leadership' then 'Student Leadership'
      when 'management' then 'Management'
      when 'administrator' then 'School Administration'
      else null
    end;
  end if;

  if v_actor_role is null then
    insert into public.ops_login_attempts(login_key, attempts, locked_until, last_attempt_at)
    values (v_login_key, 1, null, now())
    on conflict (login_key) do update set
      attempts = case
        when public.ops_login_attempts.last_attempt_at < now() - interval '15 minutes' then 1
        else public.ops_login_attempts.attempts + 1
      end,
      last_attempt_at = now(),
      locked_until = null;

    update public.ops_login_attempts
    set locked_until = now() + interval '15 minutes'
    where login_key = v_login_key and attempts >= 5;

    return jsonb_build_object('status','unauthorized','message','The access code is incorrect.');
  end if;

  delete from public.ops_login_attempts where login_key = v_login_key;
  delete from public.ops_access_sessions where expires_at < now() - interval '7 days';

  select coalesce((setting_value #>> '{}')::integer, 12)
  into v_hours
  from public.ops_settings
  where setting_key = 'session_hours';
  v_hours := greatest(1, least(coalesce(v_hours, 12), 24));

  v_token := encode(extensions.gen_random_bytes(32), 'hex');
  v_expires_at := now() + make_interval(hours => v_hours);

  insert into public.ops_access_sessions(token_hash, actor_role, department_id, expires_at)
  values (
    private.ops_hash_token(v_token),
    v_actor_role,
    case when v_actor_role = 'department' then v_department.id else null end,
    v_expires_at
  );

  perform private.ops_audit(
    v_actor_role,
    case when v_actor_role = 'department' then v_department.id else null end,
    null,
    'login',
    'access_session',
    null,
    jsonb_build_object(
      'access_type', p_access_type,
      'created_department_pin', v_created_rows > 0
    )
  );

  return jsonb_build_object(
    'status','success',
    'session_token',v_token,
    'expires_at',v_expires_at,
    'role',v_actor_role,
    'display_name',v_display_name,
    'department_pin_created',v_created_rows > 0,
    'department',case when v_actor_role = 'department' then jsonb_build_object(
      'id',v_department.id,'slug',v_department.slug,'name',v_department.name
    ) else null end
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_logout(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  update public.ops_access_sessions
  set revoked_at = now()
  where id = v_context.access_session_id;
  return jsonb_build_object('status','success');
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_move_planned_session(p_session_token text, p_session_id uuid, p_work_date date, p_slot_id uuid, p_actor_student_id text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_session public.ops_work_sessions%rowtype;
  v_actor text;
  v_slot_code text;
  v_item record;
  v_group_total integer;
  v_other_allocated integer;
  v_other_members integer;
  v_current_members integer;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('student_leadership','management','administrator') then
    raise exception 'Student Leadership access is required.' using errcode='42501';
  end if;
  select s.full_name into v_actor
  from public.ops_student_leadership_roles l join public.students s on s.id=l.student_id
  where l.student_id=p_actor_student_id and l.active and s.is_active
  order by l.display_order limit 1;
  if v_actor is null then return jsonb_build_object('status','invalid','message','Choose a current Student Leadership member.'); end if;
  if private.conference_mode() then return jsonb_build_object('status','invalid','message','Conference Mode has no manual-work sessions.'); end if;
  select * into v_session from public.ops_work_sessions where id=p_session_id and status<>'cancelled' for update;
  if not found then return jsonb_build_object('status','not_found','message','The planned task no longer exists.'); end if;
  if p_work_date<current_date or p_work_date>current_date+120 then
    return jsonb_build_object('status','invalid','message','Choose a current or future day within 120 days.');
  end if;
  select code into v_slot_code from public.ops_time_slots where id=p_slot_id and active;
  if v_slot_code is null then return jsonb_build_object('status','invalid','message','Choose an active session.'); end if;
  if private.school_operating_mode()='holiday' and v_slot_code not in ('morning','afternoon') then
    return jsonb_build_object('status','invalid','message','Holiday Mode allows Morning and Afternoon only.');
  end if;
  if exists(select 1 from public.ops_work_sessions ws where ws.id<>v_session.id
    and ws.department_id=v_session.department_id and ws.work_date=p_work_date
    and ws.slot_id=p_slot_id and ws.status<>'cancelled') then
    return jsonb_build_object('status','invalid','message','That department already has a task in the target session.');
  end if;
  for v_item in
    select a.group_code,a.headcount from public.ops_session_group_allocations a where a.session_id=v_session.id
  loop
    select count(*)::integer into v_group_total from public.students s
    where s.is_active and private.ops_group_code(s.registration_number,s.gender)=v_item.group_code
      and private.ops_student_is_available(s.id);
    select coalesce(sum(a.headcount),0)::integer into v_other_allocated
    from public.ops_session_group_allocations a join public.ops_work_sessions ws on ws.id=a.session_id
    where a.group_code=v_item.group_code and ws.id<>v_session.id and ws.work_date=p_work_date
      and ws.slot_id=p_slot_id and ws.status<>'cancelled';
    select count(*)::integer into v_other_members
    from public.ops_session_department_members m join public.ops_work_sessions ws on ws.id=m.session_id
    where m.group_code=v_item.group_code and ws.id<>v_session.id and ws.work_date=p_work_date
      and ws.slot_id=p_slot_id and ws.status<>'cancelled';
    select count(*)::integer into v_current_members
    from public.ops_session_department_members m
    where m.session_id=v_session.id and m.group_code=v_item.group_code;
    if v_item.headcount>greatest(0,v_group_total-v_other_allocated-v_other_members-v_current_members) then
      return jsonb_build_object('status','invalid','message',format('Not enough %s remain in the target session.',replace(v_item.group_code,'_',' ')));
    end if;
  end loop;
  update public.ops_work_sessions set work_date=p_work_date,slot_id=p_slot_id,updated_at=now()
  where id=v_session.id;
  update public.ops_session_requests set work_date=p_work_date,slot_id=p_slot_id,updated_at=now()
  where id=v_session.request_id;
  update public.ops_tasks set due_date=p_work_date,updated_at=now()
  where id in(select task_id from public.ops_session_tasks where session_id=v_session.id);
  perform private.ops_audit(v_context.actor_role,null,v_actor,'move_planned_session',
    'work_session',v_session.id::text,jsonb_build_object('work_date',p_work_date,'slot_code',v_slot_code));
  return jsonb_build_object('status','success','session_id',v_session.id,'work_date',p_work_date,'slot_id',p_slot_id);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_people_directory(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
begin
  select * into v_context from private.ops_session_context(p_session_token);

  return jsonb_build_object(
    'status','success',
    'can_edit_members',v_context.actor_role in ('department','student_leadership','management','administrator'),
    'students',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'id',s.id,
        'registration_number',s.registration_number,
        'full_name',s.full_name,
        'gender',lower(nullif(btrim(s.gender),''))
      ) order by s.full_name),'[]'::jsonb)
      from public.students s
      where s.is_active
    ),
    'staff',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'id',x.id,
        'full_name',x.full_name,
        'title',x.title,
        'department_id',x.department_id
      ) order by x.full_name),'[]'::jsonb)
      from public.ops_staff_directory x
      where x.active and x.staff_number is not null
    ),
    'leadership',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'student_id',s.id,
        'registration_number',s.registration_number,
        'full_name',s.full_name,
        'gender',lower(nullif(btrim(s.gender),'')),
        'leadership_role',l.leadership_role,
        'is_senior_prefect',l.leadership_role='senior_prefect'
      ) order by l.display_order,s.full_name),'[]'::jsonb)
      from public.ops_student_leadership_roles l
      join public.students s on s.id=l.student_id
      where l.active and s.is_active
    ),
    'department_members',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'department_id',m.department_id,
        'student_id',s.id,
        'registration_number',s.registration_number,
        'full_name',s.full_name,
        'gender',lower(nullif(btrim(s.gender),'')),
        'member_role',m.member_role,
        'group_code',private.ops_group_code(s.registration_number,s.gender)
      ) order by d.sort_order,
        case when m.member_role='hod' then 0 else 1 end,s.full_name),'[]'::jsonb)
      from public.ops_department_memberships m
      join public.students s on s.id=m.student_id
      join public.ops_departments d on d.id=m.department_id
      where m.active
        and (m.ends_on is null or m.ends_on>=current_date)
        and s.is_active
        and (v_context.actor_role<>'department' or m.department_id=v_context.actor_department_id)
    )
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_plan_work_request_v2(p_session_token text, p_request_id uuid, p_decision text, p_slot_id uuid, p_work_date date, p_allocated_headcount integer, p_allocations jsonb, p_notes text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_request public.ops_session_requests%rowtype;
  v_session public.ops_work_sessions%rowtype;
  v_decision text:=lower(coalesce(nullif(p_decision,''),'approved'));
  v_actor text:=nullif(btrim(coalesce(p_actor_name,'')),'');
  v_work_date date;
  v_slot_code text;
  v_item jsonb;
  v_code text;
  v_count integer;
  v_total integer:=0;
  v_group_total integer;
  v_other_allocated integer;
  v_standing_reserved integer;
  v_available integer;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('student_leadership','management','administrator') then
    raise exception 'Student Leadership access is required.' using errcode='42501';
  end if;
  if v_actor is null then
    return jsonb_build_object('status','invalid','message','Enter the person making this decision.');
  end if;
  select * into v_request
  from public.ops_session_requests
  where id=p_request_id
  for update;
  if not found or v_request.status not in ('pending','approved','partially_approved') then
    return jsonb_build_object('status','invalid','message','This task is no longer waiting for allocation.');
  end if;

  if v_decision='declined' then
    update public.ops_session_requests set
      status='declined',allocated_headcount=0,
      decision_notes=nullif(btrim(coalesce(p_notes,'')),''),
      decided_at=now(),decided_by_role=v_context.actor_role
    where id=v_request.id;
    update public.ops_tasks set status='ready'
    where id in(select task_id from public.ops_session_request_tasks where request_id=v_request.id)
      and status='requested';
    insert into public.ops_notifications(
      department_id,notification_type,title,message,link_type,link_id
    ) values(
      v_request.department_id,'task_decision','Task allocation declined',
      coalesce(nullif(btrim(coalesce(p_notes,'')),''),'Student Leadership could not allocate people for this task.'),
      'session_request',v_request.id
    );
    perform private.ops_audit(v_context.actor_role,null,v_actor,'decline_task_request',
      'session_request',v_request.id::text,jsonb_build_object('notes',p_notes));
    return jsonb_build_object('status','success','request_status','declined');
  end if;

  if private.conference_mode() then
    return jsonb_build_object('status','invalid','message','Conference Mode has no manual-work sessions.');
  end if;
  v_work_date:=coalesce(p_work_date,v_request.work_date);
  if v_work_date<current_date or v_work_date>current_date+120 then
    return jsonb_build_object('status','invalid','message','Choose a work day within the next 120 days.');
  end if;
  select code into v_slot_code from public.ops_time_slots where id=p_slot_id and active;
  if v_slot_code is null then
    return jsonb_build_object('status','invalid','message','Choose a work session.');
  end if;
  if private.school_operating_mode()='holiday' and v_slot_code not in ('morning','afternoon') then
    return jsonb_build_object('status','invalid','message','Holiday Mode allows Morning and Afternoon only.');
  end if;
  if coalesce(p_allocated_headcount,0)<1 or p_allocated_headcount>100 then
    return jsonb_build_object('status','invalid','message','Approve between 1 and 100 people.');
  end if;
  if jsonb_typeof(coalesce(p_allocations,'[]'::jsonb))<>'array' then
    return jsonb_build_object('status','invalid','message','Enter the cohort allocation.');
  end if;

  for v_item in select value from jsonb_array_elements(coalesce(p_allocations,'[]'::jsonb)) loop
    v_code:=v_item->>'group_code';
    v_count:=coalesce(nullif(v_item->>'headcount','')::integer,0);
    if v_code not in ('year1_men','year1_ladies','year2_men','year2_ladies') or v_count<0 then
      return jsonb_build_object('status','invalid','message','A cohort allocation is invalid.');
    end if;
    v_total:=v_total+v_count;

    select count(*)::integer into v_group_total
    from public.students s
    where s.is_active
      and private.ops_group_code(s.registration_number,s.gender)=v_code
      and private.ops_student_is_available(s.id);

    select coalesce(sum(a.headcount),0)::integer into v_other_allocated
    from public.ops_session_group_allocations a
    join public.ops_work_sessions ws on ws.id=a.session_id
    where a.group_code=v_code
      and ws.work_date=v_work_date
      and ws.slot_id=p_slot_id
      and ws.status<>'cancelled'
      and ws.department_id<>v_request.department_id;

    select coalesce(sum(c.member_count),0)::integer into v_standing_reserved
    from public.ops_department_schedule_rules r
    join public.ops_department_group_counts c on c.department_id=r.department_id
    where r.active and c.group_code=v_code
      and r.department_id<>v_request.department_id
      and extract(isodow from v_work_date)::smallint=any(r.days_of_week)
      and (cardinality(r.slot_codes)=0 or v_slot_code=any(r.slot_codes))
      and not exists(
        select 1
        from public.ops_work_sessions ws
        join public.ops_session_group_allocations a on a.session_id=ws.id and a.group_code=v_code
        where ws.department_id=r.department_id
          and ws.work_date=v_work_date
          and ws.slot_id=p_slot_id
          and ws.status<>'cancelled'
      );

    v_available:=greatest(0,v_group_total-v_other_allocated-v_standing_reserved);
    if v_count>v_available then
      return jsonb_build_object(
        'status','invalid',
        'message',format('Only %s people remain in %s for that session.',v_available,replace(v_code,'_',' '))
      );
    end if;
  end loop;
  if v_total<>p_allocated_headcount then
    return jsonb_build_object(
      'status','invalid',
      'message',format('The four cohort numbers must add up to the approved total of %s.',p_allocated_headcount)
    );
  end if;

  update public.ops_session_requests set
    work_date=v_work_date,
    slot_id=p_slot_id,
    status=case when p_allocated_headcount<requested_headcount then 'partially_approved' else 'approved' end,
    allocated_headcount=p_allocated_headcount,
    decision_notes=nullif(btrim(coalesce(p_notes,'')),''),
    decided_at=now(),decided_by_role=v_context.actor_role
  where id=v_request.id
  returning * into v_request;

  insert into public.ops_work_sessions(
    request_id,department_id,work_date,slot_id,allocated_headcount,status,
    leadership_notes,published_at,published_by_role
  ) values(
    v_request.id,v_request.department_id,v_request.work_date,p_slot_id,
    p_allocated_headcount,'published',nullif(btrim(coalesce(p_notes,'')),''),
    now(),v_context.actor_role
  ) on conflict(department_id,work_date,slot_id) do update set
    request_id=excluded.request_id,allocated_headcount=excluded.allocated_headcount,
    status='published',leadership_notes=excluded.leadership_notes,
    published_at=now(),published_by_role=excluded.published_by_role
  returning * into v_session;

  insert into public.ops_session_tasks(session_id,task_id,sequence)
  select v_session.id,rt.task_id,(row_number() over(order by t.priority desc,t.due_date nulls last))::integer
  from public.ops_session_request_tasks rt
  join public.ops_tasks t on t.id=rt.task_id
  where rt.request_id=v_request.id
  on conflict(session_id,task_id) do nothing;
  update public.ops_tasks set status='planned',due_date=v_request.work_date
  where id in(select task_id from public.ops_session_tasks where session_id=v_session.id)
    and status in ('backlog','ready','requested');

  delete from public.ops_session_group_allocations where session_id=v_session.id;
  insert into public.ops_session_group_allocations(
    session_id,group_code,headcount,assigned_by_name,assigned_by_role
  )
  select v_session.id,x.group_code,x.headcount,v_actor,v_context.actor_role
  from (
    select value->>'group_code' as group_code,(value->>'headcount')::integer as headcount
    from jsonb_array_elements(p_allocations)
  ) x
  where x.headcount>0;

  insert into public.ops_notifications(
    department_id,notification_type,title,message,link_type,link_id
  ) values(
    v_request.department_id,'task_allocated','Task approved and allocated',
    format('%s people were allocated for %s. %s',p_allocated_headcount,
      to_char(v_request.work_date,'DD Mon YYYY'),coalesce(nullif(btrim(coalesce(p_notes,'')),''),'')),
    'work_session',v_session.id
  );
  perform private.ops_audit(v_context.actor_role,null,v_actor,'plan_work_request',
    'work_session',v_session.id::text,jsonb_build_object(
      'request_id',v_request.id,'slot_code',v_slot_code,
      'allocated_headcount',p_allocated_headcount,'allocations',p_allocations
    ));
  return jsonb_build_object(
    'status','success','request_status',v_request.status,
    'session_id',v_session.id,'allocated_headcount',p_allocated_headcount
  );
exception when others then
  if sqlstate='P0001' then return jsonb_build_object('status','invalid','message',sqlerrm); end if;
  raise;
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_plan_work_request_v3(p_session_token text, p_request_id uuid, p_decision text, p_slot_id uuid, p_work_date date, p_allocated_headcount integer, p_allocations jsonb, p_notes text, p_actor_student_id text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_request public.ops_session_requests%rowtype;
  v_session public.ops_work_sessions%rowtype;
  v_decision text:=lower(coalesce(nullif(p_decision,''),'approved'));
  v_actor text;
  v_work_date date;
  v_slot_code text;
  v_item jsonb;
  v_code text;
  v_count integer;
  v_total integer:=0;
  v_group_total integer;
  v_other_allocated integer;
  v_other_members integer;
  v_current_members integer;
  v_current_group_members integer;
  v_expected_extra integer;
  v_standing_reserved integer;
  v_available integer;
  v_task_metadata jsonb:='{}'::jsonb;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('student_leadership','management','administrator') then
    raise exception 'Student Leadership access is required.' using errcode='42501';
  end if;
  select s.full_name into v_actor
  from public.ops_student_leadership_roles l join public.students s on s.id=l.student_id
  where l.student_id=p_actor_student_id and l.active and s.is_active
  order by l.display_order limit 1;
  if v_actor is null then
    return jsonb_build_object('status','invalid','message','Choose a current Student Leadership member for this decision.');
  end if;
  select * into v_request from public.ops_session_requests where id=p_request_id for update;
  if not found or v_request.status not in ('pending','approved','partially_approved') then
    return jsonb_build_object('status','invalid','message','This task is no longer waiting for allocation.');
  end if;
  select coalesce(t.metadata,'{}'::jsonb) into v_task_metadata
  from public.ops_session_request_tasks rt join public.ops_tasks t on t.id=rt.task_id
  where rt.request_id=v_request.id order by t.created_at limit 1;
  v_current_members:=coalesce(nullif(v_task_metadata->>'department_member_count','')::integer,0);

  if v_decision='declined' then
    update public.ops_session_requests set
      status='declined',allocated_headcount=0,
      decision_notes=nullif(btrim(coalesce(p_notes,'')),''),
      decided_at=now(),decided_by_role=v_context.actor_role,updated_at=now()
    where id=v_request.id;
    update public.ops_tasks set status='ready'
    where id in(select task_id from public.ops_session_request_tasks where request_id=v_request.id)
      and status='requested';
    insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
    values(v_request.department_id,'task_decision','Task request rejected',
      coalesce(nullif(btrim(coalesce(p_notes,'')),''),'Student Leadership rejected this task request.'),
      'session_request',v_request.id);
    perform private.ops_audit(v_context.actor_role,null,v_actor,'reject_task_request',
      'session_request',v_request.id::text,jsonb_build_object('notes',p_notes));
    return jsonb_build_object('status','success','request_status','declined');
  end if;

  if private.conference_mode() then
    return jsonb_build_object('status','invalid','message','Conference Mode has no manual-work sessions.');
  end if;
  v_work_date:=coalesce(p_work_date,v_request.work_date);
  if v_work_date<current_date or v_work_date>current_date+120 then
    return jsonb_build_object('status','invalid','message','Choose a work day within the next 120 days.');
  end if;
  select code into v_slot_code from public.ops_time_slots where id=p_slot_id and active;
  if v_slot_code is null then return jsonb_build_object('status','invalid','message','Choose a work session.'); end if;
  if private.school_operating_mode()='holiday' and v_slot_code not in ('morning','afternoon') then
    return jsonb_build_object('status','invalid','message','Holiday Mode allows Morning and Afternoon only.');
  end if;
  if exists(
    select 1 from public.ops_work_sessions ws
    where ws.department_id=v_request.department_id and ws.work_date=v_work_date
      and ws.slot_id=p_slot_id and ws.request_id<>v_request.id and ws.status<>'cancelled'
  ) then
    return jsonb_build_object('status','invalid','message','This department already has a published task in that session. Choose another session or move the existing card first.');
  end if;
  if coalesce(p_allocated_headcount,0)<v_current_members or p_allocated_headcount>100 then
    return jsonb_build_object('status','invalid','message',format('Approve at least the %s named department members, up to 100 people.',v_current_members));
  end if;
  if jsonb_typeof(coalesce(p_allocations,'[]'::jsonb))<>'array' then
    return jsonb_build_object('status','invalid','message','Enter the cohort allocation.');
  end if;
  v_expected_extra:=p_allocated_headcount-v_current_members;

  for v_item in select value from jsonb_array_elements(coalesce(p_allocations,'[]'::jsonb)) loop
    v_code:=v_item->>'group_code';
    v_count:=coalesce(nullif(v_item->>'headcount','')::integer,0);
    if v_code not in ('year1_men','year1_ladies','year2_men','year2_ladies') or v_count<0 then
      return jsonb_build_object('status','invalid','message','A cohort allocation is invalid.');
    end if;
    v_total:=v_total+v_count;
    select count(*)::integer into v_group_total
    from public.students s
    where s.is_active and private.ops_group_code(s.registration_number,s.gender)=v_code
      and private.ops_student_is_available(s.id);
    select coalesce(sum(a.headcount),0)::integer into v_other_allocated
    from public.ops_session_group_allocations a
    join public.ops_work_sessions ws on ws.id=a.session_id
    where a.group_code=v_code and ws.work_date=v_work_date and ws.slot_id=p_slot_id
      and ws.status<>'cancelled' and ws.request_id<>v_request.id;
    select count(*)::integer into v_other_members
    from public.ops_session_department_members m
    join public.ops_work_sessions ws on ws.id=m.session_id
    where m.group_code=v_code and ws.work_date=v_work_date and ws.slot_id=p_slot_id
      and ws.status<>'cancelled' and ws.request_id<>v_request.id;
    v_current_group_members:=coalesce(nullif(v_task_metadata->'department_member_groups'->>v_code,'')::integer,0);
    select coalesce(sum(c.member_count),0)::integer into v_standing_reserved
    from public.ops_department_schedule_rules r
    join public.ops_department_group_counts c on c.department_id=r.department_id
    where r.active and c.group_code=v_code and r.department_id<>v_request.department_id
      and extract(isodow from v_work_date)::smallint=any(r.days_of_week)
      and (cardinality(r.slot_codes)=0 or v_slot_code=any(r.slot_codes))
      and not exists(
        select 1 from public.ops_work_sessions ws
        where ws.department_id=r.department_id and ws.work_date=v_work_date
          and ws.slot_id=p_slot_id and ws.status<>'cancelled'
      );
    v_available:=greatest(0,v_group_total-v_other_allocated-v_other_members-v_current_group_members-v_standing_reserved);
    if v_count>v_available then
      return jsonb_build_object('status','invalid','message',format(
        'Only %s additional people remain in %s for that session.',v_available,replace(v_code,'_',' ')
      ));
    end if;
  end loop;
  if v_total<>v_expected_extra then
    return jsonb_build_object('status','invalid','message',format(
      'Allocate %s additional people across the four groups. The %s named department members are already included.',
      v_expected_extra,v_current_members
    ));
  end if;

  update public.ops_session_requests set
    work_date=v_work_date,slot_id=p_slot_id,
    status=case when p_allocated_headcount<requested_headcount then 'partially_approved' else 'approved' end,
    allocated_headcount=p_allocated_headcount,decision_notes=nullif(btrim(coalesce(p_notes,'')),''),
    decided_at=now(),decided_by_role=v_context.actor_role,updated_at=now()
  where id=v_request.id returning * into v_request;

  insert into public.ops_work_sessions(
    request_id,department_id,work_date,slot_id,allocated_headcount,status,
    leadership_notes,published_at,published_by_role,allocation_model
  ) values(
    v_request.id,v_request.department_id,v_request.work_date,p_slot_id,p_allocated_headcount,
    'published',nullif(btrim(coalesce(p_notes,'')),''),now(),v_context.actor_role,'members_plus_groups'
  ) on conflict(request_id) do update set
    work_date=excluded.work_date,slot_id=excluded.slot_id,allocated_headcount=excluded.allocated_headcount,
    status='published',leadership_notes=excluded.leadership_notes,published_at=now(),
    published_by_role=excluded.published_by_role,allocation_model='members_plus_groups',updated_at=now()
  returning * into v_session;

  insert into public.ops_session_tasks(session_id,task_id,sequence)
  select v_session.id,rt.task_id,(row_number() over(order by t.priority desc,t.due_date nulls last))::integer
  from public.ops_session_request_tasks rt join public.ops_tasks t on t.id=rt.task_id
  where rt.request_id=v_request.id
  on conflict(session_id,task_id) do nothing;
  update public.ops_tasks set status='planned',due_date=v_request.work_date,updated_at=now()
  where id in(select task_id from public.ops_session_tasks where session_id=v_session.id)
    and status in ('backlog','ready','requested','planned');

  delete from public.ops_session_group_allocations where session_id=v_session.id;
  insert into public.ops_session_group_allocations(session_id,group_code,headcount,assigned_by_name,assigned_by_role)
  select v_session.id,value->>'group_code',(value->>'headcount')::integer,v_actor,v_context.actor_role
  from jsonb_array_elements(p_allocations)
  where (value->>'headcount')::integer>0;

  delete from public.ops_session_department_members where session_id=v_session.id;
  insert into public.ops_session_department_members(session_id,student_id,member_name,member_role,group_code)
  select v_session.id,value->>'student_id',value->>'full_name',
    coalesce(value->>'member_role','member'),value->>'group_code'
  from jsonb_array_elements(coalesce(v_task_metadata->'department_members','[]'::jsonb))
  where exists(select 1 from public.students s where s.id=value->>'student_id');

  insert into public.ops_notifications(department_id,notification_type,title,message,link_type,link_id)
  values(v_request.department_id,'task_allocated','Task approved and allocated',
    format('%s people were allocated for %s. %s',p_allocated_headcount,to_char(v_request.work_date,'DD Mon YYYY'),coalesce(nullif(btrim(coalesce(p_notes,'')),''),'')),
    'work_session',v_session.id);
  perform private.ops_audit(v_context.actor_role,null,v_actor,'plan_work_request',
    'work_session',v_session.id::text,jsonb_build_object(
      'request_id',v_request.id,'slot_code',v_slot_code,'allocated_headcount',p_allocated_headcount,
      'named_department_members',v_current_members,'group_allocations',p_allocations
    ));
  return jsonb_build_object('status','success','request_status',v_request.status,
    'session_id',v_session.id,'allocated_headcount',p_allocated_headcount);
exception when others then
  if sqlstate='P0001' then return jsonb_build_object('status','invalid','message',sqlerrm); end if;
  raise;
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_planning_dashboard(p_session_token text, p_from_week date DEFAULT CURRENT_DATE, p_to_week date DEFAULT (CURRENT_DATE + 365))
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_current_week date;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  v_current_week:=current_date-(extract(isodow from current_date)::integer-1);

  return jsonb_build_object(
    'status','success',
    'current_week',v_current_week,
    'current_duty',coalesce((
      select jsonb_build_object(
        'id',r.id,'week_start',r.week_start,
        'prefect_on_duty',r.prefect_on_duty,
        'senior_prefect_on_duty',r.senior_prefect_on_duty,
        'notes',r.notes
      )
      from public.ops_weekly_duty_roster r
      where r.week_start=v_current_week
    ),'{}'::jsonb),
    'duties',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'id',r.id,'week_start',r.week_start,
        'prefect_on_duty',r.prefect_on_duty,
        'senior_prefect_on_duty',r.senior_prefect_on_duty,
        'notes',r.notes,'updated_at',r.updated_at
      ) order by r.week_start),'[]'::jsonb)
      from public.ops_weekly_duty_roster r
      where r.week_start between coalesce(p_from_week,v_current_week)-7
        and least(coalesce(p_to_week,v_current_week+365),v_current_week+1825)
    ),
    'department_group_counts',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'department_id',c.department_id,'group_code',c.group_code,
        'member_count',c.member_count,'updated_at',c.updated_at
      ) order by d.sort_order,d.name,c.group_code),'[]'::jsonb)
      from public.ops_department_group_counts c
      join public.ops_departments d on d.id=c.department_id
      where d.active and d.workspace_enabled
        and (v_context.actor_role<>'department' or c.department_id=v_context.actor_department_id)
    ),
    'standing_rules',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'department_id',r.department_id,'active',r.active,
        'days_of_week',to_jsonb(r.days_of_week),
        'slot_codes',to_jsonb(r.slot_codes),'updated_at',r.updated_at
      ) order by d.sort_order,d.name),'[]'::jsonb)
      from public.ops_department_schedule_rules r
      join public.ops_departments d on d.id=r.department_id
      where d.active and d.workspace_enabled
        and (v_context.actor_role<>'department' or r.department_id=v_context.actor_department_id)
    )
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_planning_dashboard_v2(p_session_token text, p_from_week date DEFAULT CURRENT_DATE, p_to_week date DEFAULT (CURRENT_DATE + 56))
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_base jsonb;
  v_from date:=coalesce(p_from_week,current_date);
  v_to date:=least(coalesce(p_to_week,current_date+56),coalesce(p_from_week,current_date)+120);
begin
  select * into v_context from private.ops_session_context(p_session_token);
  v_base:=public.ops_planning_dashboard(p_session_token,p_from_week,p_to_week);
  return v_base || jsonb_build_object(
    'plan_sessions',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'id',ws.id,'request_id',ws.request_id,'department_id',ws.department_id,
        'department_name',d.name,'work_date',ws.work_date,'slot_id',ws.slot_id,
        'slot_code',slot.code,'slot_name',slot.name,'allocated_headcount',ws.allocated_headcount,
        'status',ws.status,'allocation_model',ws.allocation_model,
        'tasks',coalesce((
          select jsonb_agg(jsonb_build_object(
            'id',t.id,'title',t.title,'description',t.description,
            'location',t.metadata->>'work_location','metadata',t.metadata
          ) order by st.sequence,t.title)
          from public.ops_session_tasks st join public.ops_tasks t on t.id=st.task_id
          where st.session_id=ws.id
        ),'[]'::jsonb),
        'groups',coalesce((
          select jsonb_agg(jsonb_build_object('group_code',a.group_code,'headcount',a.headcount)
            order by a.group_code)
          from public.ops_session_group_allocations a where a.session_id=ws.id
        ),'[]'::jsonb),
        'department_members',coalesce((
          select jsonb_agg(jsonb_build_object(
            'student_id',m.student_id,'full_name',m.member_name,'member_role',m.member_role,
            'group_code',m.group_code
          ) order by case when m.member_role='hod' then 0 else 1 end,m.member_name)
          from public.ops_session_department_members m where m.session_id=ws.id
        ),'[]'::jsonb)
      ) order by ws.work_date,slot.sort_order,d.sort_order,d.name),'[]'::jsonb)
      from public.ops_work_sessions ws
      join public.ops_departments d on d.id=ws.department_id
      join public.ops_time_slots slot on slot.id=ws.slot_id
      where ws.work_date between v_from and v_to and ws.status<>'cancelled'
        and v_context.actor_role in ('student_leadership','management','administrator')
    ),
    'student_lookup',(
      select coalesce(jsonb_agg(jsonb_build_object('id',s.id,'full_name',s.full_name) order by s.full_name),'[]'::jsonb)
      from public.students s where s.is_active
    ),
    'leadership_people',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'student_id',s.id,'full_name',s.full_name,'leadership_role',l.leadership_role,
        'is_senior_prefect',l.leadership_role='senior_prefect'
      ) order by l.display_order,s.full_name),'[]'::jsonb)
      from public.ops_student_leadership_roles l join public.students s on s.id=l.student_id
      where l.active and s.is_active
    ),
    'department_members',(
      select coalesce(jsonb_agg(jsonb_build_object(
        'department_id',m.department_id,'student_id',s.id,'full_name',s.full_name,
        'member_role',m.member_role,'group_code',private.ops_group_code(s.registration_number,s.gender)
      ) order by d.sort_order,case when m.member_role='hod' then 0 else 1 end,s.full_name),'[]'::jsonb)
      from public.ops_department_memberships m
      join public.students s on s.id=m.student_id join public.ops_departments d on d.id=m.department_id
      where m.active and (m.ends_on is null or m.ends_on>=current_date) and s.is_active
        and (v_context.actor_role<>'department' or m.department_id=v_context.actor_department_id)
    )
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_department_members(p_session_token text, p_department_id uuid, p_members jsonb, p_actor_student_id text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_item jsonb;
  v_student_id text;
  v_role text;
  v_actor_name text;
  v_count integer:=0;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('department','student_leadership','management','administrator') then
    raise exception 'Department roster access is required.' using errcode='42501';
  end if;
  if not exists(select 1 from public.ops_departments where id=p_department_id and active and workspace_enabled) then
    return jsonb_build_object('status','invalid','message','Choose an active department.');
  end if;
  if v_context.actor_role='department' then
    if v_context.actor_department_id<>p_department_id then
      raise exception 'A department can edit only its own members.' using errcode='42501';
    end if;
    select s.full_name into v_actor_name
    from public.ops_department_memberships m
    join public.students s on s.id=m.student_id
    where m.department_id=p_department_id and m.student_id=p_actor_student_id
      and m.member_role='hod' and m.active
      and (m.ends_on is null or m.ends_on>=current_date) and s.is_active;
    if v_actor_name is null then
      return jsonb_build_object('status','invalid','message','Choose a current HOD to confirm this roster change.');
    end if;
  else
    v_actor_name:=replace(initcap(replace(v_context.actor_role,'_',' ')),'It ','IT ');
  end if;
  if jsonb_typeof(coalesce(p_members,'[]'::jsonb))<>'array' then
    return jsonb_build_object('status','invalid','message','The member list is not valid.');
  end if;
  if jsonb_array_length(coalesce(p_members,'[]'::jsonb))>100 then
    return jsonb_build_object('status','invalid','message','A department cannot have more than 100 listed members.');
  end if;
  if exists(
    select 1 from (
      select value->>'student_id' student_id,count(*)
      from jsonb_array_elements(coalesce(p_members,'[]'::jsonb))
      group by value->>'student_id' having count(*)>1
    ) duplicate
  ) then
    return jsonb_build_object('status','invalid','message','The same student appears more than once.');
  end if;
  for v_item in select value from jsonb_array_elements(coalesce(p_members,'[]'::jsonb)) loop
    v_student_id:=nullif(v_item->>'student_id','');
    v_role:=lower(coalesce(nullif(v_item->>'member_role',''),'member'));
    if v_role not in ('hod','member') then
      return jsonb_build_object('status','invalid','message','Choose HOD or Member for every person.');
    end if;
    if not exists(select 1 from public.students where id=v_student_id and is_active) then
      return jsonb_build_object('status','invalid','message','One selected person is not an active student.');
    end if;
    v_count:=v_count+1;
  end loop;

  update public.ops_department_memberships
  set active=false,ends_on=coalesce(ends_on,greatest(starts_on,current_date-1))
  where department_id=p_department_id and active and ends_on is null;

  insert into public.ops_department_memberships(
    department_id,student_id,member_role,starts_on,ends_on,active
  )
  select p_department_id,value->>'student_id',lower(coalesce(nullif(value->>'member_role',''),'member')),
    current_date,null,true
  from jsonb_array_elements(coalesce(p_members,'[]'::jsonb));

  perform private.ops_refresh_department_group_counts(p_department_id,v_actor_name);
  perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
    'save_department_members','department',p_department_id::text,
    jsonb_build_object('member_count',v_count));
  return jsonb_build_object('status','success','department_id',p_department_id,'member_count',v_count);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_department_planning(p_session_token text, p_department_id uuid, p_group_counts jsonb, p_active boolean, p_days_of_week jsonb, p_slot_codes jsonb, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_item jsonb;
  v_code text;
  v_count integer;
  v_days smallint[]:='{}'::smallint[];
  v_slots text[]:='{}'::text[];
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('student_leadership','management','administrator') then
    raise exception 'Student Leadership or School Administration access is required.' using errcode='42501';
  end if;
  if nullif(btrim(coalesce(p_actor_name,'')),'') is null then
    return jsonb_build_object('status','invalid','message','Enter the person updating the department setup.');
  end if;
  if not exists(select 1 from public.ops_departments where id=p_department_id and active and workspace_enabled) then
    return jsonb_build_object('status','invalid','message','Choose an active department.');
  end if;
  if jsonb_typeof(coalesce(p_group_counts,'[]'::jsonb))<>'array' then
    return jsonb_build_object('status','invalid','message','Enter the four department member counts.');
  end if;

  -- Validate every value before changing existing department setup.
  for v_item in select value from jsonb_array_elements(coalesce(p_group_counts,'[]'::jsonb)) loop
    v_code:=v_item->>'group_code';
    v_count:=coalesce(nullif(v_item->>'member_count','')::integer,0);
    if v_code not in ('year1_men','year1_ladies','year2_men','year2_ladies')
       or v_count<0 or v_count>100 then
      return jsonb_build_object('status','invalid','message','A department member count is invalid.');
    end if;
  end loop;

  if jsonb_typeof(coalesce(p_days_of_week,'[]'::jsonb))='array' then
    select coalesce(array_agg(distinct value::smallint order by value::smallint),'{}'::smallint[])
    into v_days from jsonb_array_elements_text(coalesce(p_days_of_week,'[]'::jsonb));
  end if;
  if coalesce(array_length(v_days,1),0)=0 then
    v_days:=array[1,2,3,4,5,6,7]::smallint[];
  end if;
  if exists(select 1 from unnest(v_days) d where d not between 1 and 7) then
    return jsonb_build_object('status','invalid','message','Choose valid weekdays.');
  end if;

  if jsonb_typeof(coalesce(p_slot_codes,'[]'::jsonb))='array' then
    select coalesce(array_agg(distinct value order by value),'{}'::text[])
    into v_slots from jsonb_array_elements_text(coalesce(p_slot_codes,'[]'::jsonb));
  end if;
  if exists(
    select 1 from unnest(v_slots) s
    where not exists(select 1 from public.ops_time_slots t where t.code=s and t.active)
  ) then
    return jsonb_build_object('status','invalid','message','Choose valid work sessions.');
  end if;

  delete from public.ops_department_group_counts where department_id=p_department_id;
  for v_item in select value from jsonb_array_elements(coalesce(p_group_counts,'[]'::jsonb)) loop
    insert into public.ops_department_group_counts(
      department_id,group_code,member_count,updated_by_name
    ) values(
      p_department_id,
      v_item->>'group_code',
      coalesce(nullif(v_item->>'member_count','')::integer,0),
      btrim(p_actor_name)
    );
  end loop;

  insert into public.ops_department_schedule_rules(
    department_id,active,days_of_week,slot_codes,updated_by_name
  ) values(
    p_department_id,coalesce(p_active,false),v_days,v_slots,btrim(p_actor_name)
  ) on conflict(department_id) do update set
    active=excluded.active,days_of_week=excluded.days_of_week,
    slot_codes=excluded.slot_codes,updated_by_name=excluded.updated_by_name,
    updated_at=now();

  perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,btrim(p_actor_name),
    'save_department_planning','department',p_department_id::text,jsonb_build_object(
      'always_on',coalesce(p_active,false),'days_of_week',v_days,'slot_codes',v_slots
    ));
  return jsonb_build_object('status','success','department_id',p_department_id);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_emergency_gate_pass(p_session_token text, p_pass_id uuid, p_primary_registration text, p_destination text, p_reason text, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_contact_details text, p_companions jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'private'
AS $function$
declare
  v_email text;
  v_student_id text;
  v_registration text:=regexp_replace(coalesce(p_primary_registration,''),'\D','','g');
begin
  select s.id into v_student_id
  from public.students s
  where s.registration_number::text=v_registration and s.is_active=true
  limit 1;

  if p_pass_id is not null then
    select c.requester_email into v_email
    from private.pass_requester_contacts c
    join public.gate_passes gp on gp.id=c.pass_id
    where c.pass_id=p_pass_id and gp.student_id=v_student_id;
  end if;

  if nullif(trim(coalesce(v_email,'')),'') is null then
    select nullif(trim(r.student_answers->>'student_email'),'') into v_email
    from public.term_registrations r
    join public.academic_terms t on t.id=r.term_id
    where r.student_id=v_student_id
      and nullif(trim(r.student_answers->>'student_email'),'') is not null
    order by t.academic_year desc,t.term_number desc,r.updated_at desc
    limit 1;
  end if;

  if v_email is null then
    return jsonb_build_object('status','invalid','message',
      'Student email is missing from registration. Add it in the enrolment record before submitting this pass.');
  end if;

  return public.ops_save_emergency_gate_pass(
    p_session_token,p_pass_id,p_primary_registration,v_email,p_destination,p_reason,
    p_departure_at,p_expected_return_at,p_contact_details,p_companions
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_emergency_gate_pass(p_session_token text, p_pass_id uuid, p_primary_registration text, p_requester_email text, p_destination text, p_reason text, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_contact_details text, p_companions jsonb DEFAULT '[]'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_primary public.students%rowtype;
  v_companion public.students%rowtype;
  v_existing public.gate_passes%rowtype;
  v_pass public.gate_passes%rowtype;
  v_old_status text;
  v_raw text;
  v_reg text;
  v_companion_ids text[] := '{}'::text[];
  v_companion_count integer := 0;
  v_people jsonb;
  v_queued integer := 0;
  v_previous_approvals jsonb := '[]'::jsonb;
  v_actor_label text;
  v_history_role text;
begin
  select * into v_context from private.ops_session_context(p_session_token);

  select slug into v_department_slug
  from public.ops_departments
  where id=v_context.actor_department_id;

  if v_context.actor_role='student_leadership' then
    v_actor_label:='Senior Student Leadership';
    v_history_role:='student_leadership';
  elsif v_context.actor_role='department' and v_department_slug='administrators-office' then
    v_actor_label:='Administrator''s Office';
    v_history_role:='administrator';
  else
    raise exception 'Senior Student Leadership or Administrator''s Office access is required.' using errcode='42501';
  end if;

  p_requester_email:=lower(trim(coalesce(p_requester_email,'')));
  if length(p_requester_email)>254
     or p_requester_email!~*'^[A-Z0-9._%+\-]+@[A-Z0-9.\-]+\.[A-Z]{2,}$' then
    return jsonb_build_object('status','invalid','message','Enter a valid student email address.');
  end if;

  if p_companions is null then p_companions:='[]'::jsonb; end if;
  if jsonb_typeof(p_companions)<>'array' then
    return jsonb_build_object('status','invalid','message','The additional people could not be read. Remove them and add them again.');
  end if;

  select * into v_primary
  from public.students
  where registration_number::text=regexp_replace(coalesce(p_primary_registration,''),'\D','','g')
    and is_active=true
  limit 1;

  if not found then
    return jsonb_build_object('status','not_found','message','Choose an active student from the student register.');
  end if;

  if length(trim(coalesce(p_destination,'')))<2
     or length(trim(coalesce(p_reason,'')))<3
     or length(trim(coalesce(p_contact_details,'')))<3 then
    return jsonb_build_object('status','invalid','message','Complete the destination, reason and contact details.');
  end if;

  if p_departure_at is null or p_expected_return_at is null or p_expected_return_at<=p_departure_at then
    return jsonb_build_object('status','invalid','message','Expected return must be later than departure.');
  end if;

  if p_departure_at<=now() then
    return jsonb_build_object('status','invalid','message','Departure must be in the future.');
  end if;

  if p_pass_id is not null then
    select * into v_existing from public.gate_passes where id=p_pass_id for update;
    if not found then
      return jsonb_build_object('status','not_found','message','Gate pass not found.');
    end if;
    if v_existing.status in ('departed','returned','expired') then
      return jsonb_build_object('status','invalid','message','A pass cannot be edited after travel has started or finished.');
    end if;
  end if;

  if exists(
    select 1
    from public.gate_passes gp
    join public.gate_pass_members gm on gm.pass_id=gp.id
    where gm.student_id=v_primary.id
      and gp.id is distinct from p_pass_id
      and gp.status in ('pending','approved','departed')
      and tstzrange(gp.departure_at,gp.expected_return_at,'[]')
          && tstzrange(p_departure_at,p_expected_return_at,'[]')
  ) then
    return jsonb_build_object('status','schedule_conflict','message',v_primary.full_name||' already has an active pass that overlaps this period.');
  end if;

  for v_raw in
    select distinct value from jsonb_array_elements_text(p_companions)
  loop
    v_reg:=regexp_replace(coalesce(v_raw,''),'\D','','g');
    if v_reg='' then continue; end if;
    if v_reg=v_primary.registration_number::text then
      return jsonb_build_object('status','invalid','message','Do not add the primary student as an additional person.');
    end if;

    select * into v_companion
    from public.students
    where registration_number::text=v_reg and is_active=true
    limit 1;

    if not found then
      return jsonb_build_object('status','invalid','message','Additional student '||v_reg||' was not found.');
    end if;
    if v_companion.id=any(v_companion_ids) then continue; end if;

    v_companion_count:=v_companion_count+1;
    if v_companion_count>5 then
      return jsonb_build_object('status','invalid','message','A gate pass can include up to five additional people.');
    end if;

    if exists(
      select 1
      from public.gate_passes gp
      join public.gate_pass_members gm on gm.pass_id=gp.id
      where gm.student_id=v_companion.id
        and gp.id is distinct from p_pass_id
        and gp.status in ('pending','approved','departed')
        and tstzrange(gp.departure_at,gp.expected_return_at,'[]')
            && tstzrange(p_departure_at,p_expected_return_at,'[]')
    ) then
      return jsonb_build_object('status','schedule_conflict','message',v_companion.full_name||' already has an active pass that overlaps this period.');
    end if;

    v_companion_ids:=array_append(v_companion_ids,v_companion.id);
  end loop;

  if p_pass_id is null then
    insert into public.gate_passes(
      student_id,destination,reason,departure_at,expected_return_at,contact_details,created_source
    ) values (
      v_primary.id,trim(p_destination),trim(p_reason),p_departure_at,p_expected_return_at,trim(p_contact_details),'staff'
    ) returning * into v_pass;

    v_old_status:=null;
  else
    v_old_status:=v_existing.status;

    select coalesce(jsonb_agg(jsonb_build_object(
      'role',approver_role,'decision',decision,'comments',comments,'decided_at',decided_at
    ) order by decided_at),'[]'::jsonb)
    into v_previous_approvals
    from public.gate_pass_approvals
    where pass_id=p_pass_id;

    delete from public.gate_pass_approvals where pass_id=p_pass_id;
    delete from public.gate_pass_members where pass_id=p_pass_id;

    update public.gate_passes
    set student_id=v_primary.id,
        destination=trim(p_destination),
        reason=trim(p_reason),
        departure_at=p_departure_at,
        expected_return_at=p_expected_return_at,
        contact_details=trim(p_contact_details),
        status='pending',
        submitted_at=now(),
        final_approved_at=null,
        actual_departure_at=null,
        actual_return_at=null,
        paper_pass_checked=false,
        cancelled_at=null,
        cancelled_by_role=null,
        cancellation_reason=null,
        created_source='staff',
        updated_at=now()
    where id=p_pass_id
    returning * into v_pass;
  end if;

  if p_pass_id is not null then
    insert into public.gate_pass_members(pass_id,student_id,is_primary,added_by_student_id)
    values(v_pass.id,v_primary.id,true,null);
  end if;

  if array_length(v_companion_ids,1) is not null then
    insert into public.gate_pass_members(pass_id,student_id,is_primary,added_by_student_id)
    select v_pass.id,u.student_id,false,v_primary.id
    from unnest(v_companion_ids) as u(student_id)
    on conflict(pass_id,student_id) do nothing;
  end if;

  insert into private.pass_requester_contacts(pass_id,requester_email)
  values(v_pass.id,p_requester_email)
  on conflict(pass_id) do update
  set requester_email=excluded.requester_email;

  insert into public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
  values(
    v_pass.id,v_old_status,'pending',v_history_role,
    case when p_pass_id is null
      then 'Submitted by '||v_actor_label||'. Student submission deadline bypassed.'
      else 'Edited and resubmitted by '||v_actor_label||'. Previous approvals were reset.'
    end
  );

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values(
    'gate_pass','gate_pass',v_pass.id::text,'department',
    case
      when v_context.actor_role='student_leadership' then 'student_leadership_emergency_submitted'
      when p_pass_id is null then 'administrators_office_submitted'
      else 'administrators_office_edited'
    end,
    jsonb_build_object(
      'department_id',v_context.actor_department_id,
      'student_id',v_primary.id,
      'registration_number',v_primary.registration_number,
      'requester_email',p_requester_email,
      'companion_count',v_companion_count,
      'deadline_bypassed',true,
      'previous_status',v_old_status,
      'previous_approvals',v_previous_approvals
    )
  );

  v_queued:=private.pass_queue_email(v_pass.id,'submitted');
  v_people:=public._gate_pass_people_json(v_pass.id);

  return jsonb_build_object(
    'status','success',
    'pass_id',v_pass.id,
    'pass_status','pending',
    'people',v_people,
    'deadline_applies',false,
    'approvals_reset',p_pass_id is not null,
    'email_notification_queued',v_queued>0
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_gate_duty(p_session_token text, p_duty_date date, p_assignments jsonb, p_actor_student_id text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_actor_name text;
  v_role_label text;
  v_count integer;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role='department' then
    select d.slug into v_department_slug
    from public.ops_departments d
    where d.id=v_context.actor_department_id;
  end if;

  if v_context.actor_role='student_leadership' then
    select s.full_name into v_actor_name
    from public.ops_student_leadership_roles l
    join public.students s on s.id=l.student_id
    where l.student_id=p_actor_student_id and l.active and s.is_active
    order by l.display_order
    limit 1;
    v_role_label := 'student_leadership';
  elsif v_context.actor_role='department' and v_department_slug='security' then
    select s.full_name into v_actor_name
    from public.ops_department_memberships m
    join public.students s on s.id=m.student_id
    where m.department_id=v_context.actor_department_id
      and m.student_id=p_actor_student_id
      and m.active
      and (m.ends_on is null or m.ends_on>=current_date)
      and s.is_active
    limit 1;
    v_role_label := 'security';
  else
    raise exception 'Only Student Leadership or the Security department can set gate duty.'
      using errcode='42501';
  end if;

  if v_actor_name is null then
    return jsonb_build_object('status','invalid','message','Choose your exact Student Leadership or Security department record.');
  end if;
  if p_duty_date is null or p_duty_date < current_date - 14 or p_duty_date > current_date + 365 then
    return jsonb_build_object('status','invalid','message','Choose a current or future gate-duty date.');
  end if;
  if jsonb_typeof(coalesce(p_assignments,'null'::jsonb)) <> 'array'
     or jsonb_array_length(p_assignments) <> 3 then
    return jsonb_build_object('status','invalid','message','Choose one student for each of the three gate-duty slots.');
  end if;

  select count(distinct item.value->>'slot_code') into v_count
  from jsonb_array_elements(p_assignments) item(value)
  where item.value->>'slot_code' in ('22_00','00_02','02_04');
  if v_count <> 3 then
    return jsonb_build_object('status','invalid','message','Use the 10 pm, 12 am, and 2 am gate-duty slots once each.');
  end if;

  select count(*) into v_count
  from jsonb_array_elements(p_assignments) item(value)
  join public.students s on s.id=item.value->>'student_id' and s.is_active;
  if v_count <> 3 then
    return jsonb_build_object('status','invalid','message','Every gate-duty name must be one exact active student record.');
  end if;

  delete from public.ops_gate_duty_assignments where duty_date=p_duty_date;
  insert into public.ops_gate_duty_assignments(
    duty_date,slot_code,student_id,updated_by_student_id,updated_by_role
  )
  select p_duty_date,item.value->>'slot_code',item.value->>'student_id',
    p_actor_student_id,v_role_label
  from jsonb_array_elements(p_assignments) item(value);

  perform private.ops_audit(
    v_context.actor_role,v_context.actor_department_id,v_actor_name,
    'save_gate_duty','gate_duty_day',p_duty_date::text,
    jsonb_build_object('duty_date',p_duty_date,'slots',p_assignments)
  );

  return jsonb_build_object('status','success','duty_date',p_duty_date);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_service_duties(p_session_token text, p_week_start date, p_bell_student_id text, p_kitchen_department_id uuid, p_toilet_department_id uuid, p_kitchen_students jsonb, p_toilet_students jsonb, p_actor_student_id text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_week_start date;
  v_next_week date;
  v_actor_name text;
  v_input_count integer;
  v_valid_count integer;
  v_male_count integer;
  v_female_count integer;
  v_kitchen_department_id uuid;
  v_toilet_department_id uuid;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role <> 'student_leadership' then
    raise exception 'Only Student Leadership can set bell, kitchen, and toilet duty.'
      using errcode = '42501';
  end if;

  if p_actor_student_id is null then
    v_actor_name := 'Student Leadership';
  else
    select s.full_name into v_actor_name
    from public.ops_student_leadership_roles l
    join public.students s on s.id=l.student_id
    where l.student_id=p_actor_student_id and l.active and s.is_active
    order by l.display_order
    limit 1;
  end if;
  if v_actor_name is null then
    return jsonb_build_object('status','invalid','message','Choose the Student Leadership member entering this roster.');
  end if;

  if p_week_start is null then
    return jsonb_build_object('status','invalid','message','Choose the week beginning Monday.');
  end if;
  v_week_start := p_week_start - (extract(isodow from p_week_start)::integer - 1);
  if v_week_start < current_date - 14 or v_week_start > current_date + 730 then
    return jsonb_build_object('status','invalid','message','Choose a current or future duty week.');
  end if;
  v_next_week := v_week_start + 7;

  if p_bell_student_id is not null
     and not exists(select 1 from public.students where id=p_bell_student_id and is_active) then
    return jsonb_build_object('status','invalid','message','Choose an active student as bell ringer.');
  end if;

  select id into v_kitchen_department_id
  from public.ops_departments
  where slug='kitchen' and active and workspace_enabled
  limit 1;
  select id into v_toilet_department_id
  from public.ops_departments
  where slug='toilets' and active and workspace_enabled
  limit 1;
  if v_kitchen_department_id is null or v_toilet_department_id is null then
    return jsonb_build_object('status','invalid','message','Kitchen or Toilets is missing from the department setup.');
  end if;

  if jsonb_typeof(coalesce(p_kitchen_students,'null'::jsonb)) <> 'array'
     or jsonb_typeof(coalesce(p_toilet_students,'null'::jsonb)) <> 'array' then
    return jsonb_build_object('status','invalid','message','Duty students must be selected from the exact-name lists.');
  end if;
  if jsonb_array_length(p_kitchen_students) > 4 or jsonb_array_length(p_toilet_students) > 4 then
    return jsonb_build_object('status','invalid','message','Kitchen and toilet duty can each contain up to four students.');
  end if;

  select count(distinct nullif(btrim(item.value #>> '{}'),''))
    into v_input_count
  from jsonb_array_elements(p_kitchen_students) item(value);
  select count(*),
         count(*) filter (where lower(btrim(s.gender))='male'),
         count(*) filter (where lower(btrim(s.gender))='female')
    into v_valid_count,v_male_count,v_female_count
  from public.students s
  where s.is_active and s.id in (
    select nullif(btrim(item.value #>> '{}'),'')
    from jsonb_array_elements(p_kitchen_students) item(value)
  );
  if v_input_count <> jsonb_array_length(p_kitchen_students) or v_valid_count <> v_input_count then
    return jsonb_build_object('status','invalid','message','Every kitchen-duty name must be one exact active student record.');
  end if;
  if v_male_count + v_female_count <> v_valid_count then
    return jsonb_build_object('status','invalid','message','Every kitchen-duty student must have Male or Female recorded.');
  end if;
  if v_male_count > 2 or v_female_count > 2 then
    return jsonb_build_object('status','invalid','message','Kitchen duty can contain up to 2 men and 2 women.');
  end if;

  select count(distinct nullif(btrim(item.value #>> '{}'),''))
    into v_input_count
  from jsonb_array_elements(p_toilet_students) item(value);
  select count(*),
         count(*) filter (where lower(btrim(s.gender))='male'),
         count(*) filter (where lower(btrim(s.gender))='female')
    into v_valid_count,v_male_count,v_female_count
  from public.students s
  where s.is_active and s.id in (
    select nullif(btrim(item.value #>> '{}'),'')
    from jsonb_array_elements(p_toilet_students) item(value)
  );
  if v_input_count <> jsonb_array_length(p_toilet_students) or v_valid_count <> v_input_count then
    return jsonb_build_object('status','invalid','message','Every toilet-duty name must be one exact active student record.');
  end if;
  if v_male_count + v_female_count <> v_valid_count then
    return jsonb_build_object('status','invalid','message','Every toilet-duty student must have Male or Female recorded.');
  end if;
  if v_male_count > 2 or v_female_count > 2 then
    return jsonb_build_object('status','invalid','message','Toilet duty can contain up to 2 men and 2 women.');
  end if;

  insert into public.ops_service_duty_weeks(
    week_start,bell_ringer_student_id,kitchen_department_id,toilet_department_id,
    updated_by_student_id,updated_by_role
  ) values(
    v_week_start,p_bell_student_id,v_kitchen_department_id,v_toilet_department_id,
    p_actor_student_id,'student_leadership'
  )
  on conflict(week_start) do update set
    bell_ringer_student_id=excluded.bell_ringer_student_id,
    kitchen_department_id=excluded.kitchen_department_id,
    toilet_department_id=excluded.toilet_department_id,
    updated_by_student_id=excluded.updated_by_student_id,
    updated_by_role='student_leadership',
    updated_at=now();

  delete from public.ops_service_duty_members
  where week_start=v_week_start and duty_type in ('kitchen','toilet');

  insert into public.ops_service_duty_members(
    week_start,duty_type,student_id,assignment_source,sort_order
  )
  select v_week_start,'kitchen',item.value #>> '{}','manual',item.ordinality::integer
  from jsonb_array_elements(p_kitchen_students) with ordinality item(value,ordinality);

  insert into public.ops_service_duty_members(
    week_start,duty_type,student_id,assignment_source,sort_order
  )
  select v_week_start,'toilet',item.value #>> '{}','manual',item.ordinality::integer
  from jsonb_array_elements(p_toilet_students) with ordinality item(value,ordinality);

  insert into public.ops_service_duty_weeks(
    week_start,updated_by_student_id,updated_by_role
  ) values(v_next_week,p_actor_student_id,'student_leadership')
  on conflict(week_start) do update set updated_at=now();

  delete from public.ops_service_duty_members
  where week_start=v_next_week and duty_type='toilet'
    and assignment_source='kitchen_rotation';

  insert into public.ops_service_duty_members(
    week_start,duty_type,student_id,assignment_source,sort_order
  )
  select v_next_week,'toilet',m.student_id,'kitchen_rotation',m.sort_order
  from public.ops_service_duty_members m
  where m.week_start=v_week_start and m.duty_type='kitchen'
  on conflict(week_start,duty_type,student_id) do nothing;

  perform private.ops_audit(
    v_context.actor_role,v_context.actor_department_id,v_actor_name,
    'save_service_duties','service_duty_week',v_week_start::text,
    jsonb_build_object(
      'week_start',v_week_start,
      'next_toilet_week',v_next_week,
      'bell_entered',p_bell_student_id is not null,
      'kitchen_count',jsonb_array_length(p_kitchen_students),
      'toilet_count',jsonb_array_length(p_toilet_students),
      'partial_save',jsonb_array_length(p_kitchen_students) < 4
        or jsonb_array_length(p_toilet_students) < 4
        or p_bell_student_id is null
    )
  );

  return jsonb_build_object(
    'status','success',
    'week_start',v_week_start,
    'next_toilet_week',v_next_week
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_service_duties_pair(p_session_token text, p_week_start date, p_bell_student_id text, p_bell_student_2_id text, p_kitchen_department_id uuid, p_toilet_department_id uuid, p_kitchen_students jsonb, p_toilet_students jsonb, p_actor_student_id text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_result jsonb;
  v_week_start date;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role <> 'student_leadership' then
    raise exception 'Only Student Leadership can set bell, kitchen, and toilet duty.'
      using errcode = '42501';
  end if;

  if p_bell_student_2_id is not null
     and not exists (
       select 1 from public.students
       where id=p_bell_student_2_id and is_active
     ) then
    return jsonb_build_object('status','invalid','message','Choose an active student as the second bell ringer.');
  end if;
  if p_bell_student_id is not null
     and p_bell_student_id = p_bell_student_2_id then
    return jsonb_build_object('status','invalid','message','Choose two different bell ringers.');
  end if;

  v_result := public.ops_save_service_duties(
    p_session_token,
    p_week_start,
    p_bell_student_id,
    p_kitchen_department_id,
    p_toilet_department_id,
    p_kitchen_students,
    p_toilet_students,
    p_actor_student_id
  );

  if coalesce(v_result->>'status','') = 'success' then
    v_week_start := p_week_start - (extract(isodow from p_week_start)::integer - 1);
    update public.ops_service_duty_weeks
    set bell_ringer_2_student_id=p_bell_student_2_id,
        updated_at=now()
    where week_start=v_week_start;
  end if;

  return v_result || jsonb_build_object('bell_ringer_2_student_id',p_bell_student_2_id);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_weekly_duty(p_session_token text, p_week_start date, p_prefect_on_duty text, p_senior_prefect_on_duty text, p_notes text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_week_start date;
  v_id uuid;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role not in ('student_leadership','management','administrator') then
    raise exception 'Student Leadership or School Administration access is required.' using errcode='42501';
  end if;
  if nullif(btrim(coalesce(p_actor_name,'')),'') is null then
    return jsonb_build_object('status','invalid','message','Enter the person updating the duty roster.');
  end if;
  if length(btrim(coalesce(p_prefect_on_duty,'')))<2
     or length(btrim(coalesce(p_senior_prefect_on_duty,'')))<2 then
    return jsonb_build_object('status','invalid','message','Enter both the Prefect on Duty and Senior Prefect on Duty.');
  end if;
  if p_week_start is null then
    return jsonb_build_object('status','invalid','message','Choose the week.');
  end if;
  v_week_start:=p_week_start-(extract(isodow from p_week_start)::integer-1);
  if v_week_start<current_date-interval '14 days' or v_week_start>current_date+interval '5 years' then
    return jsonb_build_object('status','invalid','message','Choose a current or future week.');
  end if;

  insert into public.ops_weekly_duty_roster(
    week_start,prefect_on_duty,senior_prefect_on_duty,notes,
    updated_by_name,updated_by_role
  ) values(
    v_week_start,btrim(p_prefect_on_duty),btrim(p_senior_prefect_on_duty),
    nullif(btrim(coalesce(p_notes,'')),''),btrim(p_actor_name),v_context.actor_role
  )
  on conflict(week_start) do update set
    prefect_on_duty=excluded.prefect_on_duty,
    senior_prefect_on_duty=excluded.senior_prefect_on_duty,
    notes=excluded.notes,updated_by_name=excluded.updated_by_name,
    updated_by_role=excluded.updated_by_role,updated_at=now()
  returning id into v_id;

  perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,btrim(p_actor_name),
    'save_weekly_duty','weekly_duty',v_id::text,jsonb_build_object('week_start',v_week_start));
  return jsonb_build_object('status','success','id',v_id,'week_start',v_week_start);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_save_weekly_duty_v2(p_session_token text, p_week_start date, p_prefect_student_id text, p_senior_prefect_student_id text, p_notes text, p_actor_student_id text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_week_start date;
  v_id uuid;
  v_prefect text;
  v_senior text;
  v_actor text;
begin
  select * into v_context from private.ops_session_context(p_session_token);

  if v_context.actor_role not in ('student_leadership','management','administrator') then
    raise exception 'Student Leadership or School Administration access is required.'
      using errcode='42501';
  end if;

  select s.full_name into v_prefect
  from public.students s
  where s.id=p_prefect_student_id
    and s.is_active
    and public._student_year_number(
      s.registration_number,
      public._current_academic_year()
    )=2
  limit 1;

  select s.full_name into v_senior
  from public.ops_student_leadership_roles l
  join public.students s on s.id=l.student_id
  where l.student_id=p_senior_prefect_student_id
    and l.leadership_role='senior_prefect'
    and l.active
    and s.is_active
  limit 1;

  select s.full_name into v_actor
  from public.ops_student_leadership_roles l
  join public.students s on s.id=l.student_id
  where l.student_id=p_actor_student_id
    and l.active
    and s.is_active
  order by l.display_order
  limit 1;

  if v_prefect is null then
    return jsonb_build_object('status','invalid','message','Choose any active second-year student as Prefect on Duty.');
  end if;
  if v_senior is null then
    return jsonb_build_object('status','invalid','message','Choose one of the four Senior Prefects.');
  end if;
  if v_actor is null then
    return jsonb_build_object('status','invalid','message','Choose the Student Leadership member entering this week.');
  end if;
  if p_week_start is null then
    return jsonb_build_object('status','invalid','message','Choose the week.');
  end if;

  v_week_start:=p_week_start-(extract(isodow from p_week_start)::integer-1);
  if v_week_start<current_date-14 or v_week_start>current_date+1825 then
    return jsonb_build_object('status','invalid','message','Choose a current or future week.');
  end if;

  insert into public.ops_weekly_duty_roster(
    week_start,prefect_on_duty,senior_prefect_on_duty,notes,
    updated_by_name,updated_by_role,prefect_student_id,
    senior_prefect_student_id,updated_by_student_id
  ) values(
    v_week_start,v_prefect,v_senior,nullif(btrim(coalesce(p_notes,'')),''),
    v_actor,v_context.actor_role,p_prefect_student_id,
    p_senior_prefect_student_id,p_actor_student_id
  )
  on conflict(week_start) do update set
    prefect_on_duty=excluded.prefect_on_duty,
    senior_prefect_on_duty=excluded.senior_prefect_on_duty,
    notes=excluded.notes,
    updated_by_name=excluded.updated_by_name,
    updated_by_role=excluded.updated_by_role,
    prefect_student_id=excluded.prefect_student_id,
    senior_prefect_student_id=excluded.senior_prefect_student_id,
    updated_by_student_id=excluded.updated_by_student_id,
    updated_at=now()
  returning id into v_id;

  perform private.ops_audit(
    v_context.actor_role,v_context.actor_department_id,v_actor,
    'save_weekly_duty','weekly_duty',v_id::text,
    jsonb_build_object('week_start',v_week_start)
  );

  return jsonb_build_object('status','success','id',v_id,'week_start',v_week_start);
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_send_fee_notices(p_session_token text, p_registration_ids uuid[])
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_actor_role text;
begin
  select * into v_context from private.ops_session_context(p_session_token);

  if v_context.actor_role='department' then
    select slug into v_department_slug from public.ops_departments where id=v_context.actor_department_id;
  end if;

  if not (
    v_context.actor_role='administrator'
    or (v_context.actor_role='department' and v_department_slug='administrators-office')
  ) then
    raise exception 'School Administration or Administrator''s Office access is required.' using errcode='42501';
  end if;

  v_actor_role := case when v_department_slug='administrators-office' then 'administrators_office' else 'administrator' end;
  return private.queue_fee_notices(p_registration_ids,v_actor_role,null);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_set_department_pin(p_session_token text, p_department_id uuid, p_pin text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'extensions', 'pg_catalog'
AS $function$
declare v_context record;
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role<>'administrator' then raise exception 'School Administration access is required.' using errcode='42501'; end if;
  if p_pin !~ '^[0-9]{4}$' then return jsonb_build_object('status','invalid','message','Enter exactly four digits.'); end if;
  if nullif(btrim(p_actor_name),'') is null then return jsonb_build_object('status','invalid','message','Enter the administrator name.'); end if;
  if not exists(select 1 from public.ops_departments where id=p_department_id and active and workspace_enabled) then
    return jsonb_build_object('status','invalid','message','Department not found.');
  end if;
  insert into public.ops_department_credentials(department_id,access_hash,updated_by_role)
  values(p_department_id,extensions.crypt(p_pin,extensions.gen_salt('bf',10)),v_context.actor_role)
  on conflict (department_id) do update set access_hash=excluded.access_hash,failed_attempts=0,locked_until=null,updated_by_role=excluded.updated_by_role,updated_at=now();
  perform private.ops_audit(v_context.actor_role,null,btrim(p_actor_name),'set_department_pin','department',p_department_id::text,'{}'::jsonb);
  return jsonb_build_object('status','success','department_id',p_department_id);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_set_department_pin_v2(p_session_token text, p_department_id uuid, p_pin text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_result jsonb;
begin
  v_result:=public.ops_set_department_pin(p_session_token,p_department_id,p_pin,p_actor_name);
  if v_result->>'status'='success' then
    perform private.system_store_recoverable_pin('department',p_department_id::text,p_pin);
  end if;
  return v_result;
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_submit_session_request(p_session_token text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_id uuid;
  v_request public.ops_session_requests%rowtype;
  v_work_date date;
  v_slot_id uuid;
  v_count integer;
  v_actor_name text := nullif(btrim(p_payload->>'actor_name'),'');
  v_kind text := lower(coalesce(nullif(p_payload->>'request_kind',''),'planned'));
begin
  select * into v_context from private.ops_session_context(p_session_token);
  v_department_id := coalesce(nullif(p_payload->>'department_id','')::uuid,v_context.actor_department_id);
  if not private.ops_can_access_department(v_context.actor_role,v_context.actor_department_id,v_department_id) then
    raise exception 'You cannot request for that department.' using errcode='42501';
  end if;
  if v_actor_name is null then return jsonb_build_object('status','invalid','message','Select or enter your name.'); end if;
  if v_kind not in ('planned','unexpected') then return jsonb_build_object('status','invalid','message','Choose Planned or Unexpected.'); end if;
  v_work_date := nullif(p_payload->>'work_date','')::date;
  v_slot_id := nullif(p_payload->>'slot_id','')::uuid;
  v_count := coalesce(nullif(p_payload->>'requested_headcount','')::integer,0);
  if v_work_date is null or v_work_date > current_date + 120 then
    return jsonb_build_object('status','invalid','message','Choose a work date within the next 120 days.');
  end if;
  if v_slot_id is null or not exists(select 1 from public.ops_time_slots where id=v_slot_id and active) then
    return jsonb_build_object('status','invalid','message','Choose a work session.');
  end if;
  if v_count < 1 or v_count > 100 then
    return jsonb_build_object('status','invalid','message','Requested people must be between 1 and 100, including department members.');
  end if;
  if exists(select 1 from public.ops_session_requests where department_id=v_department_id and work_date=v_work_date and slot_id=v_slot_id and status='pending') then
    return jsonb_build_object('status','invalid','message','This department already has a pending request for that slot.');
  end if;

  insert into public.ops_session_requests(
    department_id,work_date,slot_id,requested_headcount,request_notes,requested_by_name,request_kind
  ) values (
    v_department_id,v_work_date,v_slot_id,v_count,nullif(btrim(p_payload->>'request_notes'),''),v_actor_name,v_kind
  ) returning * into v_request;

  if jsonb_typeof(coalesce(p_payload->'task_ids','[]'::jsonb))='array' then
    insert into public.ops_session_request_tasks(request_id,task_id)
    select v_request.id,t.id
    from jsonb_array_elements_text(coalesce(p_payload->'task_ids','[]'::jsonb)) x(value)
    join public.ops_tasks t on t.id=x.value::uuid and t.department_id=v_department_id and t.archived_at is null
    on conflict do nothing;
    update public.ops_tasks set status='requested'
    where id in (select task_id from public.ops_session_request_tasks where request_id=v_request.id)
      and status in ('backlog','ready');
  end if;

  insert into public.ops_notifications(target_role,notification_type,title,message,link_type,link_id)
  values('student_leadership',case when v_kind='unexpected' then 'unexpected_task' else 'session_request' end,
    case when v_kind='unexpected' then 'Unexpected task request' else 'New session request' end,
    format('%s requested %s people for %s.',(select name from public.ops_departments where id=v_department_id),v_count,to_char(v_work_date,'DD Mon YYYY')),
    'session_request',v_request.id);
  perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor_name,
    'request_session','session_request',v_request.id::text,jsonb_build_object('work_date',v_work_date,'requested_headcount',v_count,'request_kind',v_kind));
  return jsonb_build_object('status','success','request_id',v_request.id);
exception when others then
  if sqlstate='P0001' then return jsonb_build_object('status','invalid','message',sqlerrm); end if;
  raise;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.ops_submit_work_request_v2(p_session_token text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_id uuid;
  v_task_id uuid;
  v_request_id uuid;
  v_actor text:=nullif(btrim(coalesce(p_payload->>'actor_name','')),'');
  v_title text:=btrim(coalesce(p_payload->>'title',''));
  v_description text:=nullif(btrim(coalesce(p_payload->>'description','')),'');
  v_work_date date:=nullif(p_payload->>'work_date','')::date;
  v_cadence text:=lower(coalesce(nullif(p_payload->>'cadence',''),'once'));
  v_priority_choice text:=lower(coalesce(nullif(p_payload->>'priority',''),'normal'));
  v_priority text;
  v_crucial_reason text:=nullif(btrim(coalesce(p_payload->>'crucial_reason','')),'');
  v_unexpected boolean:=coalesce(nullif(p_payload->>'unexpected','')::boolean,false);
  v_extra integer:=greatest(0,least(coalesce(nullif(p_payload->>'extra_people','')::integer,0),100));
  v_members integer;
  v_total integer;
  v_member_groups jsonb;
  v_conference boolean:=private.conference_mode();
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role<>'department' then
    raise exception 'Use a department workspace to submit work.' using errcode='42501';
  end if;
  v_department_id:=v_context.actor_department_id;
  if v_department_id is null then
    return jsonb_build_object('status','invalid','message','The department workspace is not connected.');
  end if;
  if v_actor is null then
    return jsonb_build_object('status','invalid','message','Enter the person submitting the task.');
  end if;
  if length(v_title)<3 or length(v_title)>180 then
    return jsonb_build_object('status','invalid','message','Briefly describe the work needed.');
  end if;
  if v_work_date is null or v_work_date<current_date or v_work_date>current_date+120 then
    return jsonb_build_object('status','invalid','message','Choose a working day within the next 120 days.');
  end if;
  if v_unexpected and v_work_date<>current_date then
    return jsonb_build_object('status','invalid','message','Unexpected work must use today as the work day.');
  end if;
  if not v_unexpected and v_work_date=current_date then
    return jsonb_build_object('status','invalid','message','Same-day work must be marked Unexpected.');
  end if;
  if v_cadence not in ('once','daily','weekly','monthly','quarterly') then v_cadence:='once'; end if;
  v_priority:=case v_priority_choice
    when 'important' then 'high'
    when 'crucial' then 'critical'
    else 'medium'
  end;
  if v_priority_choice='crucial' and v_crucial_reason is null then
    return jsonb_build_object('status','invalid','message','Explain why this task is crucial.');
  end if;

  select coalesce(sum(member_count),0)::integer,
         coalesce(jsonb_object_agg(group_code,member_count),'{}'::jsonb)
  into v_members,v_member_groups
  from public.ops_department_group_counts
  where department_id=v_department_id;
  v_total:=v_members+v_extra;
  if v_total>100 then
    return jsonb_build_object('status','invalid','message','Department members and extra help cannot exceed 100 people.');
  end if;

  insert into public.ops_tasks(
    department_id,title,description,task_type,cadence,priority,status,due_date,
    requested_people,external_people_allowed,owner_name,created_by_name,created_by_role,metadata
  ) values(
    v_department_id,v_title,v_description,
    case when v_conference or v_unexpected then 'emergency'
      when v_cadence<>'once' then 'regular' else 'ad_hoc' end,
    v_cadence,case when v_conference then 'critical' else v_priority end,
    case when v_conference or v_total=0 then 'ready' else 'requested' end,
    v_work_date,v_total,v_extra>0,null,v_actor,v_context.actor_role,
    jsonb_build_object(
      'simple_request',true,'unexpected',v_unexpected,
      'priority_choice',v_priority_choice,'crucial_reason',v_crucial_reason,
      'department_member_count',v_members,'department_member_groups',v_member_groups,
      'extra_people_requested',v_extra,'work_date',v_work_date
    )
  ) returning id into v_task_id;

  if not v_conference and v_total>0 then
    insert into public.ops_session_requests(
      department_id,work_date,slot_id,requested_headcount,
      request_notes,requested_by_name,request_kind
    ) values(
      v_department_id,v_work_date,null,v_total,
      concat_ws(E'\n',v_description,
        case when v_crucial_reason is not null then 'Crucial: '||v_crucial_reason end),
      v_actor,case when v_unexpected then 'unexpected' else 'planned' end
    ) returning id into v_request_id;

    insert into public.ops_session_request_tasks(request_id,task_id)
    values(v_request_id,v_task_id);
  end if;

  insert into public.ops_notifications(
    target_role,notification_type,title,message,link_type,link_id
  ) values(
    'student_leadership',case when v_unexpected then 'unexpected_task' else 'task_request' end,
    case when v_unexpected then 'Unexpected task submitted' else 'Task ready for planning' end,
    format('%s submitted %s for %s.',
      (select name from public.ops_departments where id=v_department_id),
      v_title,to_char(v_work_date,'DD Mon YYYY')),
    case when v_request_id is null then 'task' else 'session_request' end,
    coalesce(v_request_id,v_task_id)
  );
  perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor,
    'submit_work_request','task',v_task_id::text,jsonb_build_object(
      'request_id',v_request_id,'work_date',v_work_date,
      'department_members',v_members,'extra_people',v_extra,'total_people',v_total,
      'cadence',v_cadence,'priority',case when v_conference then 'critical' else v_priority end
    ));

  return jsonb_build_object(
    'status','success','task_id',v_task_id,'request_id',v_request_id,
    'department_member_count',v_members,'extra_people',v_extra,
    'total_people',v_total,'conference_task_only',v_conference
  );
exception when others then
  if sqlstate='P0001' then return jsonb_build_object('status','invalid','message',sqlerrm); end if;
  raise;
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_submit_work_request_v3(p_session_token text, p_payload jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_id uuid;
  v_task_id uuid;
  v_request_id uuid;
  v_actor_id text:=nullif(p_payload->>'actor_student_id','');
  v_actor text;
  v_title text:=btrim(coalesce(p_payload->>'title',''));
  v_description text:=nullif(btrim(coalesce(p_payload->>'description','')),'');
  v_location text:=nullif(btrim(coalesce(p_payload->>'location','')),'');
  v_work_date date:=nullif(p_payload->>'work_date','')::date;
  v_cadence text:=lower(coalesce(nullif(p_payload->>'cadence',''),'once'));
  v_priority_choice text:=lower(coalesce(nullif(p_payload->>'priority',''),'normal'));
  v_priority text;
  v_crucial_reason text:=nullif(btrim(coalesce(p_payload->>'crucial_reason','')),'');
  v_unexpected boolean:=coalesce(nullif(p_payload->>'unexpected','')::boolean,false);
  v_extra integer:=greatest(0,least(coalesce(nullif(p_payload->>'extra_people','')::integer,0),100));
  v_members integer;
  v_total integer;
  v_member_groups jsonb;
  v_member_snapshot jsonb;
  v_conference boolean:=private.conference_mode();
begin
  select * into v_context from private.ops_session_context(p_session_token);
  if v_context.actor_role<>'department' then
    raise exception 'Use a department workspace to submit work.' using errcode='42501';
  end if;
  v_department_id:=v_context.actor_department_id;
  select s.full_name into v_actor
  from public.ops_department_memberships m join public.students s on s.id=m.student_id
  where m.department_id=v_department_id and m.student_id=v_actor_id and m.active
    and (m.ends_on is null or m.ends_on>=current_date) and s.is_active;
  if v_actor is null then
    return jsonb_build_object('status','invalid','message','Choose a current department member as the submitter.');
  end if;
  if length(v_title)<3 or length(v_title)>180 then
    return jsonb_build_object('status','invalid','message','Briefly describe the work needed.');
  end if;
  if v_location is null then
    return jsonb_build_object('status','invalid','message','Enter where the work should happen.');
  end if;
  if v_work_date is null or v_work_date<current_date or v_work_date>current_date+120 then
    return jsonb_build_object('status','invalid','message','Choose a working day within the next 120 days.');
  end if;
  if v_unexpected and v_work_date<>current_date then
    return jsonb_build_object('status','invalid','message','Unexpected work must use today as the work day.');
  end if;
  if not v_unexpected and v_work_date=current_date then
    return jsonb_build_object('status','invalid','message','Same-day work must be marked Unexpected.');
  end if;
  if v_cadence not in ('once','daily','weekly','monthly','quarterly') then v_cadence:='once'; end if;
  v_priority:=case v_priority_choice when 'important' then 'high' when 'crucial' then 'critical' else 'medium' end;
  if v_priority_choice='crucial' and v_crucial_reason is null then
    return jsonb_build_object('status','invalid','message','Explain why this task is crucial.');
  end if;

  select coalesce(sum(member_count),0)::integer,
    coalesce(jsonb_object_agg(group_code,member_count),'{}'::jsonb)
  into v_members,v_member_groups
  from (
    select private.ops_group_code(s.registration_number,s.gender) group_code,count(*)::integer member_count
    from public.ops_department_memberships m join public.students s on s.id=m.student_id
    where m.department_id=v_department_id and m.active
      and (m.ends_on is null or m.ends_on>=current_date) and s.is_active
    group by private.ops_group_code(s.registration_number,s.gender)
  ) counts;

  select coalesce(jsonb_agg(jsonb_build_object(
    'student_id',s.id,'full_name',s.full_name,'member_role',m.member_role,
    'group_code',private.ops_group_code(s.registration_number,s.gender)
  ) order by case when m.member_role='hod' then 0 else 1 end,s.full_name),'[]'::jsonb)
  into v_member_snapshot
  from public.ops_department_memberships m join public.students s on s.id=m.student_id
  where m.department_id=v_department_id and m.active
    and (m.ends_on is null or m.ends_on>=current_date) and s.is_active;

  v_total:=coalesce(v_members,0)+v_extra;
  if v_total>100 then
    return jsonb_build_object('status','invalid','message','Department members and extra help cannot exceed 100 people.');
  end if;

  insert into public.ops_tasks(
    department_id,title,description,task_type,cadence,priority,status,due_date,
    requested_people,external_people_allowed,owner_name,created_by_name,created_by_role,metadata
  ) values(
    v_department_id,v_title,v_description,
    case when v_conference or v_unexpected then 'emergency' when v_cadence<>'once' then 'regular' else 'ad_hoc' end,
    v_cadence,case when v_conference then 'critical' else v_priority end,
    case when v_conference or v_total=0 then 'ready' else 'requested' end,
    v_work_date,v_total,v_extra>0,null,v_actor,v_context.actor_role,
    jsonb_build_object(
      'simple_request',true,'unexpected',v_unexpected,'work_location',v_location,
      'priority_choice',v_priority_choice,'crucial_reason',v_crucial_reason,
      'department_member_count',coalesce(v_members,0),'department_member_groups',v_member_groups,
      'department_members',v_member_snapshot,'extra_people_requested',v_extra,'work_date',v_work_date
    )
  ) returning id into v_task_id;

  if not v_conference and v_total>0 then
    insert into public.ops_session_requests(
      department_id,work_date,slot_id,requested_headcount,request_notes,requested_by_name,request_kind
    ) values(
      v_department_id,v_work_date,null,v_total,
      concat_ws(E'\n',v_description,'Location: '||v_location,
        case when v_crucial_reason is not null then 'Crucial: '||v_crucial_reason end),
      v_actor,case when v_unexpected then 'unexpected' else 'planned' end
    ) returning id into v_request_id;
    insert into public.ops_session_request_tasks(request_id,task_id) values(v_request_id,v_task_id);
  end if;

  insert into public.ops_notifications(target_role,notification_type,title,message,link_type,link_id)
  values(
    'student_leadership',case when v_unexpected then 'unexpected_task' else 'task_request' end,
    case when v_unexpected then 'Unexpected task submitted' else 'Task ready for planning' end,
    format('%s submitted %s for %s.',(select name from public.ops_departments where id=v_department_id),v_title,to_char(v_work_date,'DD Mon YYYY')),
    case when v_request_id is null then 'task' else 'session_request' end,coalesce(v_request_id,v_task_id)
  );
  perform private.ops_audit(v_context.actor_role,v_context.actor_department_id,v_actor,
    'submit_work_request','task',v_task_id::text,jsonb_build_object(
      'request_id',v_request_id,'work_date',v_work_date,'location',v_location,
      'department_members',coalesce(v_members,0),'extra_people',v_extra,'total_people',v_total
    ));
  return jsonb_build_object(
    'status','success','task_id',v_task_id,'request_id',v_request_id,
    'department_member_count',coalesce(v_members,0),'extra_people',v_extra,
    'total_people',v_total,'conference_task_only',v_conference
  );
exception when others then
  if sqlstate='P0001' then return jsonb_build_object('status','invalid','message',sqlerrm); end if;
  raise;
end
$function$
;

CREATE OR REPLACE FUNCTION public.ops_term_enrolment_dashboard(p_session_token text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_slug text;
  v_term public.academic_terms%rowtype;
  v_terms jsonb;
  v_summary jsonb;
  v_rows jsonb;
begin
  select * into v_context
  from private.ops_session_context(p_session_token);

  if v_context.actor_role='department' then
    select slug into v_department_slug
    from public.ops_departments
    where id=v_context.actor_department_id;
  end if;

  if not (
    v_context.actor_role='administrator'
    or (v_context.actor_role='department' and v_department_slug='administrators-office')
  ) then
    raise exception 'School Administration or Administrator''s Office access is required.'
      using errcode='42501';
  end if;

  if p_term_id is null then
    select * into v_term
    from public.academic_terms
    order by registration_is_open desc,is_current desc,academic_year desc,term_number desc
    limit 1;
  else
    select * into v_term
    from public.academic_terms
    where id=p_term_id;
  end if;

  if not found then
    return jsonb_build_object('status','not_found','message','No academic term is configured.');
  end if;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id',t.id,
    'academic_year',t.academic_year,
    'term_number',t.term_number,
    'term_name',t.term_name,
    'registration_is_open',t.registration_is_open,
    'is_current',t.is_current,
    'expected',(select count(*) from public.term_registrations r where r.term_id=t.id),
    'completed',(select count(*) from public.term_registrations r where r.term_id=t.id and r.completed_at is not null)
  ) order by t.academic_year desc,t.term_number desc),'[]'::jsonb)
  into v_terms
  from public.academic_terms t;

  select jsonb_build_object(
    'expected',count(*),
    'not_started',count(*) filter(where status='not_started'),
    'started',count(*) filter(where status='started'),
    'returned',count(*) filter(where status='returned'),
    'student_submitted',count(*) filter(where status='student_submitted'),
    'waiting_accommodation',count(*) filter(where status='waiting_accommodation'),
    'ready_final',count(*) filter(where status='ready_final'),
    'completed',count(*) filter(where status='completed' or completed_at is not null)
  )
  into v_summary
  from public.term_registrations
  where term_id=v_term.id;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id',tr.id,
    'student_id',tr.student_id,
    'student_name',tr.student_name_snapshot,
    'registration_number',tr.registration_number_snapshot,
    'class_year',tr.class_year_snapshot,
    'status',tr.status,
    'status_label',private.tr_status_label(tr.status),
    'stage',
      case
        when tr.completed_at is not null or tr.status='completed' then 'completed'
        when tr.status='not_started' then 'student_not_started'
        when tr.status='started' then 'student_form'
        when tr.status='returned' then 'returned_to_student'
        when not tr.admin_office_complete then 'administrators_office'
        when not tr.fees_complete then 'fees'
        when tr.status='waiting_accommodation' or not tr.accommodation_complete then 'accommodation'
        when tr.status='ready_final' then 'final_administration'
        else 'final_administration'
      end,
    'stage_label',
      case
        when tr.completed_at is not null or tr.status='completed' then 'Completed'
        when tr.status='not_started' then 'Student has not started'
        when tr.status='started' then 'Student completing form'
        when tr.status='returned' then 'Returned to student'
        when not tr.admin_office_complete then 'Administrator''s Office review'
        when not tr.fees_complete then 'Fees review'
        when tr.status='waiting_accommodation' or not tr.accommodation_complete then 'Accommodation'
        when tr.status='ready_final' then 'Final administration'
        else 'Final administration'
      end,
    'student_started_at',tr.student_started_at,
    'student_submitted_at',tr.student_submitted_at,
    'admin_office_complete',tr.admin_office_complete,
    'admin_office_completed_at',tr.admin_office_completed_at,
    'fees_complete',tr.fees_complete,
    'fees_completed_at',tr.fees_completed_at,
    'accommodation_complete',tr.accommodation_complete,
    'accommodation_completed_at',tr.accommodation_completed_at,
    'completed_at',tr.completed_at,
    'updated_at',tr.updated_at
  ) order by tr.student_name_snapshot),'[]'::jsonb)
  into v_rows
  from public.term_registrations tr
  where tr.term_id=v_term.id;

  return jsonb_build_object(
    'status','success',
    'selected_term',jsonb_build_object(
      'id',v_term.id,
      'academic_year',v_term.academic_year,
      'term_number',v_term.term_number,
      'term_name',v_term.term_name,
      'registration_is_open',v_term.registration_is_open,
      'is_current',v_term.is_current
    ),
    'terms',v_terms,
    'summary',v_summary,
    'registrations',v_rows
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.pass_email_claim(p_limit integer DEFAULT 10)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_enabled boolean;
  v_items jsonb;
begin
  select enabled into v_enabled from private.pass_email_settings where singleton=true;
  if not coalesce(v_enabled,false) then
    return jsonb_build_object('status','disabled','items','[]'::jsonb);
  end if;

  update private.pass_email_outbox
  set status='failed',claimed_at=null,available_at=now(),updated_at=now(),
      last_error='Previous delivery attempt timed out.'
  where status='sending' and claimed_at<now()-interval '15 minutes';

  with picked as (
    select id
    from private.pass_email_outbox
    where status in ('queued','failed')
      and available_at<=now()
      and attempts<5
    order by created_at
    for update skip locked
    limit least(greatest(coalesce(p_limit,10),1),25)
  ), claimed as (
    update private.pass_email_outbox o
    set status='sending',attempts=o.attempts+1,claimed_at=now(),updated_at=now()
    from picked
    where o.id=picked.id
    returning o.id,o.recipient_email,o.recipient_group,o.subject,o.payload,o.attempts
  )
  select coalesce(jsonb_agg(to_jsonb(claimed)),'[]'::jsonb)
  into v_items
  from claimed;

  return jsonb_build_object('status','success','items',v_items);
end
$function$
;

CREATE OR REPLACE FUNCTION public.pass_email_complete(p_outbox_id uuid, p_success boolean, p_provider_message_id text DEFAULT NULL::text, p_error text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_row private.pass_email_outbox%rowtype;
begin
  update private.pass_email_outbox
  set status=case when coalesce(p_success,false) then 'sent' else 'failed' end,
      sent_at=case when coalesce(p_success,false) then now() else null end,
      provider_message_id=case when coalesce(p_success,false) then left(coalesce(p_provider_message_id,''),300) else null end,
      last_error=case when coalesce(p_success,false) then null else left(coalesce(p_error,'Unknown email delivery error.'),1000) end,
      available_at=case when coalesce(p_success,false) then available_at else now()+make_interval(mins=>least(60,greatest(5,attempts*5))) end,
      claimed_at=null,
      updated_at=now()
  where id=p_outbox_id and status='sending'
  returning * into v_row;

  if not found then
    return jsonb_build_object('status','not_found');
  end if;
  return jsonb_build_object('status','success','delivery_status',v_row.status,'attempts',v_row.attempts);
end
$function$
;

CREATE OR REPLACE FUNCTION public.pod_live_board()
 RETURNS jsonb
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
  with day_values as (
    select current_date work_date
  ),
  duty_values as (
    select public.student_duties_board(current_date) duty
  )
  select jsonb_build_object(
    'status','success','work_date',dv.work_date,
    'base_mode',private.school_operating_mode(),'conference_mode',private.conference_mode(),
    'duty',duty_values.duty - 'status' - 'week_start' - 'week_end',
    'sessions',coalesce((
      select jsonb_agg(jsonb_build_object(
        'id',ws.id,'department',d.name,'session',slot.name,'slot_code',slot.code,
        'status',ws.status,'allocated_headcount',ws.allocated_headcount,
        'tasks',coalesce((
          select jsonb_agg(jsonb_build_object(
            'title',t.title,'location',coalesce(nullif(t.metadata->>'work_location',''),'Location not entered')
          ) order by st.sequence,t.title)
          from public.ops_session_tasks st join public.ops_tasks t on t.id=st.task_id
          where st.session_id=ws.id
        ),'[]'::jsonb),
        'groups',coalesce((
          select jsonb_agg(jsonb_build_object(
            'group_code',a.group_code,
            'label',case a.group_code
              when 'year1_men' then 'first year men' when 'year1_ladies' then 'first year ladies'
              when 'year2_men' then 'second year men' when 'year2_ladies' then 'second year ladies' end,
            'headcount',a.headcount
          ) order by a.group_code)
          from public.ops_session_group_allocations a where a.session_id=ws.id
        ),'[]'::jsonb),
        'department_members',coalesce((
          select jsonb_agg(m.member_name order by case when m.member_role='hod' then 0 else 1 end,m.member_name)
          from public.ops_session_department_members m where m.session_id=ws.id
        ),'[]'::jsonb)
      ) order by slot.sort_order,d.sort_order,d.name)
      from public.ops_work_sessions ws
      join public.ops_departments d on d.id=ws.department_id
      join public.ops_time_slots slot on slot.id=ws.slot_id
      where ws.work_date=dv.work_date and ws.status in ('published','in_progress')
    ),'[]'::jsonb),
    'refreshed_at',now()
  )
  from day_values dv cross join duty_values;
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_bootstrap(p_session_token text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text:=private.registration_session_context(p_session_token,false);
  v_term public.academic_terms%rowtype;
  v_terms jsonb;
  v_rows jsonb;
  v_summary jsonb;
begin
  if p_term_id is null then
    select * into v_term from public.academic_terms
    order by registration_is_open desc,is_current desc,academic_year desc,term_number desc limit 1;
  else select * into v_term from public.academic_terms where id=p_term_id; end if;
  if not found then return jsonb_build_object('status','not_found','message','No academic term is configured.'); end if;
  select coalesce(jsonb_agg(jsonb_build_object(
    'id',t.id,'academic_year',t.academic_year,'term_number',t.term_number,'term_name',t.term_name,
    'registration_is_open',t.registration_is_open,'is_current',t.is_current,
    'expected',(select count(*) from public.term_registrations r where r.term_id=t.id),
    'submitted',(select count(*) from public.term_registrations r where r.term_id=t.id and r.student_submitted_at is not null),
    'completed',(select count(*) from public.term_registrations r where r.term_id=t.id and r.completed_at is not null)
  ) order by t.academic_year desc,t.term_number desc),'[]'::jsonb) into v_terms
  from public.academic_terms t;
  select jsonb_build_object(
    'expected',count(*),'not_started',count(*) filter(where status='not_started'),
    'draft',count(*) filter(where status='started'),'submitted',count(*) filter(where student_submitted_at is not null),
    'waiting_admin',count(*) filter(where student_submitted_at is not null and completed_at is null),
    'completed',count(*) filter(where completed_at is not null)
  ) into v_summary from public.term_registrations where term_id=v_term.id;
  select coalesce(jsonb_agg(jsonb_build_object(
    'id',tr.id,'student_id',tr.student_id,'student_name',tr.student_name_snapshot,
    'registration_number',tr.registration_number_snapshot,'class_year',tr.class_year_snapshot,
    'status',tr.status,'status_label',private.tr_status_label(tr.status),
    'student_started_at',tr.student_started_at,'student_submitted_at',tr.student_submitted_at,
    'admin_office_complete',tr.admin_office_complete,'fees_complete',tr.fees_complete,
    'accommodation_complete',tr.accommodation_complete,'completed_at',tr.completed_at,
    'accommodation_type',coalesce(tr.accommodation_answers->>'accommodation_type',tr.student_answers->>'accommodation_type'),
    'accommodation_residence',tr.accommodation_residence,'accommodation_room',tr.accommodation_room,
    'sponsor_name',sts.sponsor_name_snapshot,'sponsor_phone',sts.sponsor_phone_snapshot,
    'arrears',coalesce(fs.arrears_previous_terms,0),'amount_paid',coalesce(fs.amount_paid_current_term,0),
    'outstanding_balance',coalesce(fs.outstanding_balance,0),
    'residency_status',coalesce(ip.residency_status,'not_recorded'),'country',ip.country,
    'passport_expiry_date',ip.passport_expiry_date,
    'document_count',(select count(*) from public.student_immigration_documents d where d.student_id=tr.student_id and d.confirmed_at is not null)
  ) order by tr.student_name_snapshot),'[]'::jsonb) into v_rows
  from public.term_registrations tr
  left join public.student_term_sponsors sts on sts.student_id=tr.student_id and sts.term_id=tr.term_id
  left join public.student_term_fee_status fs on fs.student_id=tr.student_id and fs.term_id=tr.term_id
  left join public.student_immigration_profiles ip on ip.student_id=tr.student_id
  where tr.term_id=v_term.id;
  return jsonb_build_object(
    'status','success','role',v_role,'can_edit',v_role<>'management',
    'can_manage_term',v_role in('administrator','it_admin'),
    'selected_term',jsonb_build_object('id',v_term.id,'academic_year',v_term.academic_year,'term_number',v_term.term_number,
      'term_name',v_term.term_name,'registration_is_open',v_term.registration_is_open,'form_schema',v_term.registration_form_schema),
    'terms',v_terms,'summary',v_summary,'registrations',v_rows
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_fee_dashboard(p_session_token text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text := private.registration_session_context(p_session_token,false);
  v_term_id bigint;
begin
  if p_term_id is null then
    select id into v_term_id from public.academic_terms
    order by registration_is_open desc,is_current desc,academic_year desc,term_number desc limit 1;
  else
    v_term_id:=p_term_id;
  end if;
  return private.fee_dashboard_for_term(v_term_id);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_get(p_session_token text, p_registration_id uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text:=private.registration_session_context(p_session_token,false);
  v_reg public.term_registrations%rowtype;
  v_term public.academic_terms%rowtype;
  v_fee jsonb;
  v_sponsor jsonb;
  v_immigration jsonb;
  v_documents jsonb;
  v_history jsonb;
begin
  select * into v_reg from public.term_registrations where id=p_registration_id;
  if not found then return jsonb_build_object('status','not_found','message','Enrolment record not found.'); end if;
  select * into v_term from public.academic_terms where id=v_reg.term_id;
  select to_jsonb(f) into v_fee from public.student_term_fee_status f where f.student_id=v_reg.student_id and f.term_id=v_reg.term_id;
  select to_jsonb(s)||jsonb_build_object('sponsor_name_snapshot',sts.sponsor_name_snapshot,'sponsor_phone_snapshot',sts.sponsor_phone_snapshot)
    into v_sponsor from public.student_term_sponsors sts join public.sponsors s on s.id=sts.sponsor_id
    where sts.student_id=v_reg.student_id and sts.term_id=v_reg.term_id;
  select to_jsonb(ip) into v_immigration from public.student_immigration_profiles ip where ip.student_id=v_reg.student_id;
  select coalesce(jsonb_agg(to_jsonb(d)-'storage_path' order by d.uploaded_at desc),'[]'::jsonb) into v_documents
    from public.student_immigration_documents d where d.student_id=v_reg.student_id and d.confirmed_at is not null;
  select coalesce(jsonb_agg(jsonb_build_object('changed_at',h.changed_at,'actor_role',h.actor_role,'action',h.action,'section',h.section,'note',h.note) order by h.changed_at desc),'[]'::jsonb)
    into v_history from public.term_registration_history h where h.registration_id=v_reg.id;
  return jsonb_build_object('status','success','role',v_role,'can_edit',v_role<>'management',
    'term',jsonb_build_object('id',v_term.id,'term_name',v_term.term_name,'academic_year',v_term.academic_year,'term_number',v_term.term_number,'form_schema',v_term.registration_form_schema),
    'registration',to_jsonb(v_reg)||jsonb_build_object('status_label',private.tr_status_label(v_reg.status)),
    'fee',coalesce(v_fee,'{}'::jsonb),'sponsor',coalesce(v_sponsor,'{}'::jsonb),
    'immigration',coalesce(v_immigration,'{}'::jsonb),'documents',v_documents,'history',v_history);
end
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_manage_term(p_session_token text, p_academic_year integer, p_term_number integer, p_action text, p_actor_name text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text:=private.registration_session_context(p_session_token,true);
  v_term public.academic_terms%rowtype;
  v_due date;
  v_count integer;
  v_student public.students%rowtype;
begin
  if v_role not in('administrator','it_admin') then return jsonb_build_object('status','unauthorized','message','School Administration or IT Administration access is required.'); end if;
  if p_academic_year not between 2020 and 2100 or p_term_number not between 1 and 3 then return jsonb_build_object('status','invalid','message','Choose a valid year and term.'); end if;
  v_due:=make_date(p_academic_year,case p_term_number when 1 then 1 when 2 then 5 else 9 end,case p_term_number when 1 then 15 else 5 end);
  insert into public.academic_terms(academic_year,term_number,term_name,fees_due_date,is_current,registration_form_schema)
  values(p_academic_year,p_term_number,format('Term %s %s',p_term_number,p_academic_year),v_due,false,private.tr_default_form_schema())
  on conflict(academic_year,term_number) do update set term_name=excluded.term_name,registration_form_schema=private.tr_default_form_schema(),updated_at=now()
  returning * into v_term;
  if lower(p_action)='open' then
    update public.academic_terms set registration_is_open=false,
      registration_closed_at=case when registration_is_open then now() else registration_closed_at end,
      registration_updated_by_role=case when registration_is_open then v_role else registration_updated_by_role end,updated_at=now()
    where id<>v_term.id and registration_is_open;
    update public.academic_terms set is_current=false,updated_at=now() where id<>v_term.id and is_current;
    update public.academic_terms set registration_is_open=true,registration_opened_at=now(),registration_closed_at=null,
      registration_updated_by_role=v_role,is_current=true,updated_at=now() where id=v_term.id returning * into v_term;
  elsif lower(p_action)='close' then
    update public.academic_terms set registration_is_open=false,registration_closed_at=now(),registration_updated_by_role=v_role,updated_at=now()
    where id=v_term.id returning * into v_term;
  elsif lower(p_action) not in('create','refresh_expected') then
    return jsonb_build_object('status','invalid','message','Choose Create, Open, Close or Refresh expected students.');
  end if;
  if lower(p_action) in('open','refresh_expected') then
    for v_student in select * from public.students where is_active order by full_name loop
      perform private.tr_seed_registration(v_student,v_term);
    end loop;
  end if;
  select count(*) into v_count from public.term_registrations where term_id=v_term.id;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('term_registration','academic_term',v_term.id::text,v_role,'registration_term_'||lower(p_action),
    jsonb_build_object('term_name',v_term.term_name,'expected_students',v_count,'actor_name',nullif(btrim(coalesce(p_actor_name,'')),'')));
  return jsonb_build_object('status','success','term_id',v_term.id,'term_name',v_term.term_name,'registration_is_open',v_term.registration_is_open,'expected_students',v_count);
end
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_return_for_information(p_session_token text, p_registration_id uuid, p_request text, p_actor_name text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text:=private.registration_session_context(p_session_token,true);
  v_reg public.term_registrations%rowtype;
  v_request text:=nullif(btrim(coalesce(p_request,'')),'');
begin
  if v_request is null then return jsonb_build_object('status','invalid','message','Describe the additional information needed.'); end if;
  select * into v_reg from public.term_registrations where id=p_registration_id for update;
  if not found then return jsonb_build_object('status','not_found','message','Enrolment record not found.'); end if;
  if v_reg.completed_at is not null then return jsonb_build_object('status','locked','message','A completed enrolment cannot be returned.'); end if;
  if v_reg.student_submitted_at is null then return jsonb_build_object('status','invalid','message','This student has not submitted the form.'); end if;
  update public.term_registrations set
    status='returned',student_locked=false,student_submitted_at=null,resume_token_hash=null,
    reopened_at=now(),reopened_by_role=v_role,reopen_reason=v_request,updated_at=now()
  where id=v_reg.id;
  perform private.tr_write_history(v_reg.id,v_role,'additional_information_requested','student',v_reg.student_answers,v_reg.student_answers,v_request);
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('term_registration','term_registration',v_reg.id::text,v_role,'returned_for_information',jsonb_build_object('request',v_request,'actor_name',nullif(btrim(coalesce(p_actor_name,'')),'')));
  return jsonb_build_object('status','success','message','The form was returned to the student.','registration_status','returned','status_label',private.tr_status_label('returned'));
end
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_save_record(p_session_token text, p_registration_id uuid, p_admin_answers jsonb, p_fees_answers jsonb, p_accommodation_answers jsonb, p_final_answers jsonb, p_staff_note text DEFAULT NULL::text, p_finalize boolean DEFAULT false, p_actor_name text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text:=private.registration_session_context(p_session_token,true);
  v_reg public.term_registrations%rowtype;
  v_term public.academic_terms%rowtype;
  v_admin jsonb; v_fees jsonb; v_accommodation jsonb; v_final jsonb;
  v_admin_missing jsonb; v_fees_missing jsonb; v_accommodation_missing jsonb;
  v_admin_complete boolean; v_fees_complete boolean; v_accommodation_complete boolean;
  v_type text; v_status text;
begin
  select * into v_reg from public.term_registrations where id=p_registration_id for update;
  if not found then return jsonb_build_object('status','not_found','message','Enrolment record not found.'); end if;
  if v_reg.completed_at is not null then return jsonb_build_object('status','locked','message','This enrolment is already complete.'); end if;
  select * into v_term from public.academic_terms where id=v_reg.term_id;
  v_admin:=private.tr_filter_answers(v_term.registration_form_schema->'admin',coalesce(p_admin_answers,'{}'::jsonb));
  v_fees:=private.tr_filter_answers(v_term.registration_form_schema->'fees',coalesce(p_fees_answers,'{}'::jsonb));
  v_accommodation:=private.tr_filter_answers(v_term.registration_form_schema->'accommodation',coalesce(p_accommodation_answers,'{}'::jsonb));
  v_final:=private.tr_filter_answers(v_term.registration_form_schema->'final',coalesce(p_final_answers,'{}'::jsonb));
  v_type:=coalesce(v_accommodation->>'accommodation_type',v_reg.student_answers->>'accommodation_type','');
  v_accommodation:=v_accommodation||jsonb_build_object('accommodation_type',v_type);
  if v_type<>'Shared' then v_accommodation:=v_accommodation-'accommodation_hostel'-'accommodation_room'-'shared_occupants'; end if;
  v_admin_missing:=private.tr_missing_required(v_term.registration_form_schema->'admin',v_admin);
  v_fees_missing:=private.tr_missing_required(v_term.registration_form_schema->'fees',v_fees);
  v_accommodation_missing:=private.tr_missing_required(v_term.registration_form_schema->'accommodation',v_accommodation);
  if v_type='Shared' then
    if nullif(btrim(coalesce(v_accommodation->>'accommodation_hostel','')),'') is null then v_accommodation_missing:=v_accommodation_missing||jsonb_build_array(jsonb_build_object('id','accommodation_hostel','label','Hostel allocated')); end if;
    if nullif(btrim(coalesce(v_accommodation->>'accommodation_room','')),'') is null then v_accommodation_missing:=v_accommodation_missing||jsonb_build_array(jsonb_build_object('id','accommodation_room','label','Room number')); end if;
    if coalesce((v_accommodation->>'shared_occupants')::numeric,0)<1 then v_accommodation_missing:=v_accommodation_missing||jsonb_build_array(jsonb_build_object('id','shared_occupants','label','Number of occupants')); end if;
  elsif v_type<>'Married' then
    v_accommodation_missing:=v_accommodation_missing||jsonb_build_array(jsonb_build_object('id','accommodation_type','label','Accommodation type'));
  end if;
  v_admin_complete:=jsonb_array_length(v_admin_missing)=0;
  v_fees_complete:=jsonb_array_length(v_fees_missing)=0;
  v_accommodation_complete:=jsonb_array_length(v_accommodation_missing)=0;
  if p_finalize and (v_reg.student_submitted_at is null or not v_admin_complete or not v_fees_complete or not v_accommodation_complete) then
    return jsonb_build_object('status','not_ready','message','Complete the student, Admin Office, Fees and Accommodation sections before finalising.',
      'admin_missing',v_admin_missing,'fees_missing',v_fees_missing,'accommodation_missing',v_accommodation_missing);
  end if;
  update public.term_registrations set
    admin_answers=v_admin,fees_answers=v_fees,accommodation_answers=v_accommodation,final_answers=v_final,
    admin_office_complete=v_admin_complete,
    admin_office_completed_at=case when v_admin_complete then coalesce(admin_office_completed_at,now()) else null end,
    admin_office_completed_by_role=case when v_admin_complete then v_role else null end,
    fees_complete=v_fees_complete,
    fees_completed_at=case when v_fees_complete then coalesce(fees_completed_at,now()) else null end,
    fees_completed_by_role=case when v_fees_complete then v_role else null end,
    accommodation_mode=case when v_type='Shared' then 'on_campus' when v_type='Married' then 'off_campus' else 'unconfirmed' end,
    accommodation_residence=case when v_type='Shared' then nullif(btrim(v_accommodation->>'accommodation_hostel'),'') else null end,
    accommodation_room=case when v_type='Shared' then nullif(btrim(v_accommodation->>'accommodation_room'),'') else null end,
    accommodation_complete=v_accommodation_complete,
    accommodation_completed_at=case when v_accommodation_complete then coalesce(accommodation_completed_at,now()) else null end,
    accommodation_completed_by_role=case when v_accommodation_complete then v_role else null end,
    staff_note=nullif(btrim(coalesce(p_staff_note,'')),''),updated_at=now()
  where id=v_reg.id;
  insert into public.student_term_fee_status(
    student_id,term_id,fees_paid,notes,updated_by_role,arrears_previous_terms,amount_paid_current_term,outstanding_balance,payment_plan
  ) values(
    v_reg.student_id,v_reg.term_id,coalesce((v_fees->>'outstanding_balance')::numeric,0)<=0,
    nullif(btrim(coalesce(p_staff_note,'')),''),v_role,
    coalesce((v_fees->>'arrears_previous_terms')::numeric,0),coalesce((v_fees->>'amount_paid_current_term')::numeric,0),
    coalesce((v_fees->>'outstanding_balance')::numeric,0),nullif(btrim(v_fees->>'payment_plan'),'')
  ) on conflict(student_id,term_id) do update set
    fees_paid=excluded.fees_paid,notes=excluded.notes,updated_by_role=excluded.updated_by_role,
    arrears_previous_terms=excluded.arrears_previous_terms,amount_paid_current_term=excluded.amount_paid_current_term,
    outstanding_balance=excluded.outstanding_balance,payment_plan=excluded.payment_plan,updated_at=now();
  update public.accommodation_allocations set is_active=false,allocation_status='checked_out',ended_at=now(),updated_at=now()
  where student_id=v_reg.student_id and is_active and v_type='Married';
  if v_type='Shared' and nullif(btrim(v_accommodation->>'accommodation_hostel'),'') is not null then
    update public.accommodation_allocations set is_active=false,ended_at=now(),updated_at=now()
    where student_id=v_reg.student_id and is_active;
    insert into public.accommodation_allocations(student_id,residence,room,term_label,allocation_status,is_active,allocated_by_role,notes)
    values(v_reg.student_id,btrim(v_accommodation->>'accommodation_hostel'),nullif(btrim(v_accommodation->>'accommodation_room'),''),v_term.term_name,'allocated',true,v_role,'Updated from term enrolment');
  end if;
  v_status:=private.tr_recalculate(v_reg.id);
  if p_finalize then
    update public.term_registrations set completed_at=now(),completed_by_role=v_role,status='completed',student_locked=true,updated_at=now() where id=v_reg.id;
    v_status:='completed';
  end if;
  perform private.tr_write_history(v_reg.id,v_role,case when p_finalize then 'registration_completed' else 'admin_sections_saved' end,'administration',
    null,jsonb_build_object('admin',v_admin,'fees',v_fees,'accommodation',v_accommodation,'final',v_final),p_actor_name);
  return jsonb_build_object('status','success','message',case when p_finalize then 'Enrolment completed.' else 'Administration sections saved.' end,
    'registration_status',v_status,'status_label',private.tr_status_label(v_status));
exception when invalid_text_representation or numeric_value_out_of_range then
  return jsonb_build_object('status','invalid','message','Check that every fee amount and occupant count is a valid number.');
end
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_save_sponsor(p_session_token text, p_registration_id uuid, p_sponsor jsonb, p_actor_name text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_role text:=private.registration_session_context(p_session_token,true); v_reg public.term_registrations%rowtype; v_id uuid;
begin
  select * into v_reg from public.term_registrations where id=p_registration_id;
  if not found then return jsonb_build_object('status','not_found','message','Enrolment record not found.'); end if;
  if nullif(btrim(coalesce(p_sponsor->>'name','')),'') is null or nullif(btrim(coalesce(p_sponsor->>'phone','')),'') is null then
    return jsonb_build_object('status','invalid','message','Sponsor name and contact number are required.');
  end if;
  v_id:=private.tr_sync_sponsor(v_reg.student_id,v_reg.term_id,p_sponsor->>'name',p_sponsor->>'phone',v_role);
  update public.sponsors set email=nullif(btrim(p_sponsor->>'email'),''),relationship_to_student=nullif(btrim(p_sponsor->>'relationship'),''),
    address=nullif(btrim(p_sponsor->>'address'),''),notes=nullif(btrim(p_sponsor->>'notes'),''),updated_at=now() where id=v_id;
  update public.term_registrations set student_answers=student_answers||jsonb_build_object('sponsor_name',p_sponsor->>'name','sponsor_contact',p_sponsor->>'phone'),updated_at=now() where id=v_reg.id;
  perform private.tr_write_history(v_reg.id,v_role,'sponsor_updated','sponsor',null,p_sponsor,p_actor_name);
  return jsonb_build_object('status','success','message','Sponsor saved.','sponsor_id',v_id);
end
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_send_fee_notices(p_session_token text, p_registration_ids uuid[], p_actor_name text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_role text := private.registration_session_context(p_session_token,true);
begin
  return private.queue_fee_notices(p_registration_ids,v_role,p_actor_name);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.registration_admin_sponsors(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_role text:=private.registration_session_context(p_session_token,false); v_rows jsonb;
begin
  select coalesce(jsonb_agg(jsonb_build_object(
    'id',s.id,'name',s.name,'phone',s.phone,'email',s.email,'relationship',s.relationship_to_student,
    'address',s.address,'notes',s.notes,'student_count',(select count(distinct sts.student_id) from public.student_term_sponsors sts where sts.sponsor_id=s.id)
  ) order by s.name),'[]'::jsonb) into v_rows from public.sponsors s;
  return jsonb_build_object('status','success','role',v_role,'can_edit',v_role<>'management','sponsors',v_rows);
end
$function$
;

CREATE OR REPLACE FUNCTION public.staff_check_in(p_pin text, p_registration_number text, p_meal_session text, p_service_date date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  IF p_pin <> '1958' THEN
    RAISE EXCEPTION 'Incorrect PIN';
  END IF;
  RETURN public._perform_meal_check_in(
    p_registration_number,
    p_meal_session,
    p_service_date,
    'staff'
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.staff_dashboard(p_pin text, p_service_date date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_counts jsonb;
  v_breakfast_plan integer;
  v_break4_plan integer;
  v_breakfast_collected integer;
  v_lunch_collected integer;
  v_break4_collected integer;
  v_supper_collected integer;
  v_recent jsonb;
  v_windows jsonb;
begin
  if p_pin<>'1958' then
    return jsonb_build_object('status','unauthorized','message','Incorrect PIN.');
  end if;
  select jsonb_build_object(
    'Breakfast',count(*) filter(where meal_session='Breakfast')
      + coalesce(sum(child_portions) filter(where meal_session='Breakfast'),0),
    'Lunch',count(*) filter(where meal_session='Lunch')
      + coalesce(sum(child_portions) filter(where meal_session='Lunch'),0),
    'Break-fast 4pm',count(*) filter(where meal_session='Break-fast 4pm')
      + coalesce(sum(child_portions) filter(where meal_session='Break-fast 4pm'),0),
    'Supper',count(*) filter(where meal_session='Supper')
      + coalesce(sum(child_portions) filter(where meal_session='Supper'),0)
  ) into v_counts
  from public.check_ins
  where service_date=p_service_date;
  select count(*) into v_breakfast_plan
  from public.meal_plans
  where service_date=p_service_date and meal_session='Breakfast';
  select count(*) into v_break4_plan
  from public.meal_plans
  where service_date=p_service_date and meal_session='Break-fast 4pm';
  v_breakfast_collected:=coalesce((v_counts->>'Breakfast')::integer,0);
  v_lunch_collected:=coalesce((v_counts->>'Lunch')::integer,0);
  v_break4_collected:=coalesce((v_counts->>'Break-fast 4pm')::integer,0);
  v_supper_collected:=coalesce((v_counts->>'Supper')::integer,0);
  select coalesce(jsonb_agg(to_jsonb(q) order by q.checked_in_at desc),'[]'::jsonb)
  into v_recent
  from (
    select
      s.full_name as student_name,
      s.registration_number::text as registration_number,
      c.meal_session,
      c.checked_in_at,
      c.check_in_source,
      c.collection_event_id,
      c.recipient_role,
      c.child_portions
    from public.check_ins c
    join public.students s on s.id=c.student_id
    where c.service_date=p_service_date
    order by c.checked_in_at desc, c.id desc
    limit 20
  ) q;
  v_windows:=jsonb_build_object(
    'Breakfast',private.meal_plan_window(p_service_date,'Breakfast'),
    'Break-fast 4pm',private.meal_plan_window(p_service_date,'Break-fast 4pm')
  );
  return jsonb_build_object(
    'status','success',
    'service_date',p_service_date,
    'holiday_mode',private.meal_holiday_mode(),
    'conference_mode',private.conference_mode(),
    'collection_enabled',not private.conference_mode(),
    'counts',v_counts,
    'planning',jsonb_build_object(
      'Breakfast',jsonb_build_object(
        'planned',v_breakfast_plan,'collected',v_breakfast_collected,
        'remaining',greatest(v_breakfast_plan-v_breakfast_collected,0),
        'extra',greatest(v_breakfast_collected-v_breakfast_plan,0)
      ),
      'Lunch',jsonb_build_object(
        'planned',v_breakfast_plan,'collected',v_lunch_collected,
        'remaining',greatest(v_breakfast_plan-v_lunch_collected,0),
        'extra',greatest(v_lunch_collected-v_breakfast_plan,0),'based_on','Breakfast'
      ),
      'Break-fast 4pm',jsonb_build_object(
        'planned',v_break4_plan,'collected',v_break4_collected,
        'remaining',greatest(v_break4_plan-v_break4_collected,0),
        'extra',greatest(v_break4_collected-v_break4_plan,0)
      ),
      'Supper',jsonb_build_object(
        'planned',null,'collected',v_supper_collected,
        'remaining',null,'fixed_amount',true
      )
    ),
    'windows',v_windows,
    'recent_collections',v_recent,
    'lunch_to_cook',v_breakfast_plan,
    'supper_to_cook',null
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.staff_export(p_pin text, p_scope text, p_service_date date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_result jsonb;
BEGIN
  IF p_pin <> '1958' THEN RAISE EXCEPTION 'Incorrect PIN'; END IF;
  IF p_scope NOT IN ('today','all') THEN RAISE EXCEPTION 'Invalid export scope'; END IF;

  SELECT coalesce(jsonb_agg(to_jsonb(q) ORDER BY q.service_date,q.checked_in_at),'[]'::jsonb)
  INTO v_result
  FROM (
    SELECT c.service_date,c.meal_session,
           s.registration_number::text AS registration_number,
           s.full_name,c.checked_in_at,c.check_in_source
    FROM public.check_ins c
    JOIN public.students s ON s.id=c.student_id
    WHERE p_scope='all' OR c.service_date=p_service_date
  ) q;

  RETURN v_result;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.staff_plan_meal(p_pin text, p_registration_number text, p_meal_session text, p_service_date date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_auth jsonb;
begin
  v_auth:=public.staff_dashboard(p_pin,p_service_date);
  if coalesce(v_auth->>'status','')<>'success' then return jsonb_build_object('status','unauthorized','message','Incorrect PIN.'); end if;
  return private.meal_plan_save(p_registration_number,p_meal_session,p_service_date,'staff');
end $function$
;

CREATE OR REPLACE FUNCTION public.student_collect_meal(p_collector_registration text, p_meal_session text, p_service_date date, p_additional_registration text DEFAULT NULL::text, p_child_portions integer DEFAULT 0)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_collector public.students%rowtype;
  v_additional public.students%rowtype;
  v_additional_registration text := nullif(trim(coalesce(p_additional_registration,'')),'');
  v_children integer := coalesce(p_child_portions,0);
  v_event_id uuid := gen_random_uuid();
  v_collected_at timestamptz := now();
  v_duplicate_name text;
  v_student_portions integer := 1;
begin
  if private.conference_mode() then
    return jsonb_build_object(
      'status','conference_disabled',
      'message','Meal collection is unavailable while Conference Mode is on.'
    );
  end if;

  if coalesce(trim(p_collector_registration),'') !~ '^[0-9]{5}$' then
    return jsonb_build_object(
      'status','invalid',
      'message','Select your exact student record before collecting.'
    );
  end if;

  if p_meal_session not in ('Breakfast','Lunch','Break-fast 4pm','Supper') then
    return jsonb_build_object('status','invalid','message','Choose a valid meal.');
  end if;

  if p_service_date is null
     or p_service_date <> timezone('Africa/Harare',now())::date then
    return jsonb_build_object(
      'status','wrong_day',
      'message','Meal collection can only be recorded for today.'
    );
  end if;

  if v_children < 0 or v_children > 10 then
    return jsonb_build_object(
      'status','invalid',
      'message','Enter a child portion count from 0 to 10.'
    );
  end if;

  select * into v_collector
  from public.students
  where registration_number = trim(p_collector_registration)::bigint
    and is_active = true
  limit 1;

  if not found then
    return jsonb_build_object(
      'status','not_found',
      'message','Your selected student record is not active.'
    );
  end if;

  if v_additional_registration is not null then
    if v_additional_registration !~ '^[0-9]{5}$' then
      return jsonb_build_object(
        'status','invalid',
        'message','Select the other person from the student search results.'
      );
    end if;

    if v_additional_registration = trim(p_collector_registration) then
      return jsonb_build_object(
        'status','invalid',
        'message','The additional person must be different from the collector.'
      );
    end if;

    select * into v_additional
    from public.students
    where registration_number = v_additional_registration::bigint
      and is_active = true
    limit 1;

    if not found then
      return jsonb_build_object(
        'status','not_found',
        'message','The additional student record is not active.'
      );
    end if;

    v_student_portions := 2;
  end if;

  select s.full_name into v_duplicate_name
  from public.check_ins c
  join public.students s on s.id = c.student_id
  where c.service_date = p_service_date
    and c.meal_session = p_meal_session
    and c.student_id in (v_collector.id, v_additional.id)
  order by case when c.student_id = v_collector.id then 0 else 1 end
  limit 1;

  if found then
    return jsonb_build_object(
      'status','duplicate',
      'duplicate_student_name',v_duplicate_name,
      'meal_session',p_meal_session,
      'message',v_duplicate_name || ' has already collected this meal today.'
    );
  end if;

  begin
    insert into public.check_ins(
      student_id,
      meal_session,
      service_date,
      checked_in_at,
      checked_in_by,
      check_in_source,
      collection_event_id,
      recipient_role,
      child_portions
    ) values (
      v_collector.id,
      p_meal_session,
      p_service_date,
      v_collected_at,
      null,
      'student_collection',
      v_event_id,
      'collector',
      v_children
    );

    if v_additional.id is not null then
      insert into public.check_ins(
        student_id,
        meal_session,
        service_date,
        checked_in_at,
        checked_in_by,
        check_in_source,
        collection_event_id,
        recipient_role,
        child_portions
      ) values (
        v_additional.id,
        p_meal_session,
        p_service_date,
        v_collected_at,
        null,
        'student_collection',
        v_event_id,
        'additional',
        0
      );
    end if;
  exception when unique_violation then
    select s.full_name into v_duplicate_name
    from public.check_ins c
    join public.students s on s.id = c.student_id
    where c.service_date = p_service_date
      and c.meal_session = p_meal_session
      and c.student_id in (v_collector.id, v_additional.id)
    order by case when c.student_id = v_collector.id then 0 else 1 end
    limit 1;

    return jsonb_build_object(
      'status','duplicate',
      'duplicate_student_name',v_duplicate_name,
      'meal_session',p_meal_session,
      'message',coalesce(v_duplicate_name,'One selected student') ||
        ' has already collected this meal today.'
    );
  end;

  return jsonb_build_object(
    'status','collected',
    'collection_event_id',v_event_id,
    'meal_session',p_meal_session,
    'service_date',p_service_date,
    'collected_at',v_collected_at,
    'collector',jsonb_build_object(
      'registration_number',v_collector.registration_number::text,
      'full_name',v_collector.full_name
    ),
    'additional_student',case when v_additional.id is null then null else
      jsonb_build_object(
        'registration_number',v_additional.registration_number::text,
        'full_name',v_additional.full_name
      )
    end,
    'student_portions',v_student_portions,
    'child_portions',v_children,
    'total_portions',v_student_portions + v_children,
    'message','Meal collection recorded.'
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.student_duties_board(p_week_start date DEFAULT CURRENT_DATE)
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
declare
  v_week_start date;
  v_result jsonb;
begin
  v_week_start := coalesce(p_week_start,current_date)
    - (extract(isodow from coalesce(p_week_start,current_date))::integer - 1);

  select jsonb_build_object(
    'status','success',
    'week_start',v_week_start,
    'week_end',v_week_start + 6,
    'prefect_on_duty',r.prefect_on_duty,
    'senior_prefect_on_duty',r.senior_prefect_on_duty,
    'bell_ringer',nullif(concat_ws(' and ',bell.full_name,bell_2.full_name),''),
    'bell_ringers',coalesce((
      select jsonb_agg(s.full_name order by selected.sort_order)
      from (values
        (sdw.bell_ringer_student_id,1),
        (sdw.bell_ringer_2_student_id,2)
      ) selected(student_id,sort_order)
      join public.students s on s.id=selected.student_id
    ),'[]'::jsonb),
    'kitchen_department',kd.name,
    'toilet_department',td.name,
    'kitchen_people',coalesce((
      select jsonb_agg(s.full_name order by m.sort_order,s.full_name)
      from public.ops_service_duty_members m
      join public.students s on s.id=m.student_id
      where m.week_start=v_week_start and m.duty_type='kitchen'
    ),'[]'::jsonb),
    'toilet_people',coalesce((
      select jsonb_agg(s.full_name order by m.sort_order,s.full_name)
      from public.ops_service_duty_members m
      join public.students s on s.id=m.student_id
      where m.week_start=v_week_start and m.duty_type='toilet'
    ),'[]'::jsonb),
    'gate_assignments',coalesce((
      select jsonb_agg(jsonb_build_object(
        'duty_date',g.duty_date,
        'slot_code',g.slot_code,
        'student_name',s.full_name
      ) order by g.duty_date,
        case g.slot_code when '22_00' then 1 when '00_02' then 2 else 3 end
      )
      from public.ops_gate_duty_assignments g
      join public.students s on s.id=g.student_id
      where g.duty_date between v_week_start and v_week_start + 6
    ),'[]'::jsonb)
  ) into v_result
  from (select v_week_start week_start) w
  left join public.ops_weekly_duty_roster r on r.week_start=w.week_start
  left join public.ops_service_duty_weeks sdw on sdw.week_start=w.week_start
  left join public.students bell on bell.id=sdw.bell_ringer_student_id
  left join public.students bell_2 on bell_2.id=sdw.bell_ringer_2_student_id
  left join public.ops_departments kd on kd.id=sdw.kitchen_department_id
  left join public.ops_departments td on td.id=sdw.toilet_department_id;

  return v_result;
end
$function$
;

CREATE OR REPLACE FUNCTION public.student_gate_pass_status(p_registration_number text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_student public.students%rowtype;
  v_passes jsonb;
  v_pilot boolean;
  v_pilot_end jsonb;
  v_holiday boolean := false;
BEGIN
  SELECT * INTO v_student
  FROM public.students
  WHERE registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    AND is_active=true
  LIMIT 1;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('status','not_found','message','Student registration number was not found.');
  END IF;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_holiday
  FROM public.system_settings WHERE setting_key='school_holiday_mode';

  SELECT coalesce(jsonb_agg(item ORDER BY submitted_at DESC),'[]'::jsonb)
  INTO v_passes
  FROM (
    SELECT p.submitted_at,jsonb_build_object(
      'id',p.id,'destination',p.destination,'reason',p.reason,
      'departure_at',p.departure_at,'expected_return_at',p.expected_return_at,
      'status',p.status,'submitted_at',p.submitted_at,'final_approved_at',p.final_approved_at,
      'actual_departure_at',p.actual_departure_at,'actual_return_at',p.actual_return_at,
      'paper_pass_checked',p.paper_pass_checked,'cancellation_reason',p.cancellation_reason,
      'approvals',coalesce((
        SELECT jsonb_agg(jsonb_build_object(
          'role',a.approver_role,'decision',a.decision,'comments',a.comments,'decided_at',a.decided_at
        ) ORDER BY a.decided_at)
        FROM public.gate_pass_approvals a WHERE a.pass_id=p.id
      ),'[]'::jsonb),
      'waiting_on',CASE
        WHEN p.status<>'pending' THEN NULL
        WHEN NOT EXISTS(
          SELECT 1 FROM public.gate_pass_approvals a
          WHERE a.pass_id=p.id AND a.approver_role='administrator' AND a.decision='approved'
        ) THEN 'School Administrator'
        WHEN NOT v_holiday AND NOT EXISTS(
          SELECT 1 FROM public.gate_pass_approvals a
          WHERE a.pass_id=p.id AND a.approver_role IN ('principal','dean','director') AND a.decision='approved'
        ) THEN 'Principal, Dean or Director'
        ELSE NULL
      END
    ) item
    FROM public.gate_passes p
    WHERE p.student_id=v_student.id
    ORDER BY p.submitted_at DESC
    LIMIT 20
  ) q;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_pilot
  FROM public.system_settings WHERE setting_key='gate_pass_pilot_mode';
  SELECT setting_value INTO v_pilot_end
  FROM public.system_settings WHERE setting_key='gate_pass_pilot_ends_at';

  RETURN jsonb_build_object(
    'status','success','student_name',v_student.full_name,
    'registration_number',v_student.registration_number,'passes',v_passes,
    'pilot_mode',v_pilot,'pilot_ends_at',v_pilot_end,
    'school_holiday_mode',v_holiday,
    'approval_rule',CASE WHEN v_holiday THEN 'School Administrator approval only' ELSE 'School Administrator plus Principal, Dean or Director' END,
    'submission_deadline_active',(NOT v_holiday)
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_gate_pass_status_v2(p_registration_number text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
declare
  v_student public.students%rowtype;
  v_passes jsonb;
  v_pilot boolean := false;
  v_pilot_end text;
  v_holiday boolean := false;
begin
  select * into v_student
  from public.students
  where registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    and is_active=true
  limit 1;

  if not found then
    return jsonb_build_object('status','not_found','message','Student registration number was not found.');
  end if;

  select coalesce((setting_value #>> '{}')::boolean,false) into v_holiday
  from public.system_settings where setting_key='school_holiday_mode';
  select coalesce((setting_value #>> '{}')::boolean,false) into v_pilot
  from public.system_settings where setting_key='gate_pass_pilot_mode';
  select setting_value #>> '{}' into v_pilot_end
  from public.system_settings where setting_key='gate_pass_pilot_ends_at';

  select coalesce(jsonb_agg(
    jsonb_build_object('status','pending')
    order by p.submitted_at desc
  ),'[]'::jsonb) into v_passes
  from public.gate_pass_members gm
  join public.gate_passes p on p.id=gm.pass_id
  where gm.student_id=v_student.id
    and p.status='pending';

  return jsonb_build_object(
    'status','success',
    'student_name',v_student.full_name,
    'registration_number',v_student.registration_number,
    'school_holiday_mode',coalesce(v_holiday,false),
    'pilot_mode',coalesce(v_pilot,false),
    'pilot_ends_at',v_pilot_end,
    'passes',v_passes
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.student_movements_export(p_pin text, p_period text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_period text:=lower(trim(coalesce(p_period,'current_status')));
  v_start timestamptz;
  v_label text;
  v_rows jsonb;
  v_total integer; v_on_campus integer; v_bed_rest integer; v_on_gate_pass integer;
BEGIN
  IF private.system_access_role(p_pin,ARRAY['administrator','it_admin','management','student_leadership']) IS NULL THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect password.'); END IF;
  CASE v_period
    WHEN 'current_status' THEN v_start:=NULL;v_label:='Current status';
    WHEN 'last_24_hours' THEN v_start:=now()-interval '24 hours';v_label:='Last 24 hours';
    WHEN 'last_3_days' THEN v_start:=now()-interval '3 days';v_label:='Last 3 days';
    WHEN 'past_week' THEN v_start:=now()-interval '7 days';v_label:='Past week';
    ELSE RETURN jsonb_build_object('status','invalid','message','Choose current_status, last_24_hours, last_3_days or past_week.');
  END CASE;

  WITH latest_all AS (
    SELECT DISTINCT ON (cm.student_id) cm.student_id,cm.direction,cm.scanned_at,cm.checkout_destination_label,cm.gate_pass_id
    FROM public.campus_movements cm ORDER BY cm.student_id,cm.scanned_at DESC,cm.id DESC
  ), period_stats AS (
    SELECT cm.student_id,count(*)::integer movement_count,max(cm.scanned_at) last_movement_at
    FROM public.campus_movements cm WHERE v_start IS NOT NULL AND cm.scanned_at>=v_start GROUP BY cm.student_id
  ), period_last AS (
    SELECT DISTINCT ON (cm.student_id) cm.student_id,cm.direction,cm.scanned_at,cm.checkout_destination_label
    FROM public.campus_movements cm WHERE v_start IS NULL OR cm.scanned_at>=v_start
    ORDER BY cm.student_id,cm.scanned_at DESC,cm.id DESC
  ), active_bed_rest AS (
    SELECT DISTINCT ON (x.student_id) x.student_id,x.started_at,x.notes
    FROM public.student_support_statuses x WHERE x.status_type='bed_rest' AND x.is_active=true
    ORDER BY x.student_id,x.started_at DESC,x.id DESC
  ), active_maternity AS (
    SELECT DISTINCT ON (x.student_id) x.student_id,x.started_at
    FROM public.student_support_statuses x WHERE x.status_type='maternity' AND x.is_active=true
    ORDER BY x.student_id,x.started_at DESC,x.id DESC
  ), current_pass AS (
    SELECT DISTINCT ON (p.student_id) p.student_id,p.id,p.status,p.destination,p.departure_at,
      p.expected_return_at,p.actual_departure_at,(p.status='departed' AND p.expected_return_at<now()) overdue
    FROM public.gate_passes p WHERE p.status IN ('departed','approved')
    ORDER BY p.student_id,CASE WHEN p.status='departed' THEN 0 ELSE 1 END,
      coalesce(p.actual_departure_at,p.departure_at) DESC,p.submitted_at DESC
  ), current_accommodation AS (
    SELECT DISTINCT ON (a.student_id) a.student_id,a.residence,a.room,a.bed
    FROM public.accommodation_allocations a WHERE a.is_active=true
    ORDER BY a.student_id,a.allocated_at DESC,a.id DESC
  ), report_rows AS (
    SELECT s.registration_number,s.full_name student_name,
      CASE coalesce(la.direction,'UNKNOWN') WHEN 'IN' THEN 'On Campus' WHEN 'OUT' THEN 'Off Campus' ELSE 'Unknown' END current_campus_status,
      CASE WHEN la.direction='IN' THEN 'Yes' ELSE 'No' END on_campus,
      la.scanned_at latest_movement_at,la.direction latest_movement_direction,
      coalesce(la.checkout_destination_label,'') latest_checkout_destination,
      CASE WHEN br.student_id IS NOT NULL THEN 'Yes' ELSE 'No' END on_bed_rest,
      br.started_at bed_rest_started_at,CASE WHEN mat.student_id IS NOT NULL THEN 'Yes' ELSE 'No' END maternity,
      CASE WHEN cp.status='departed' THEN 'Yes' ELSE 'No' END on_gate_pass,
      coalesce(initcap(cp.status),'None') gate_pass_status,coalesce(cp.destination,'') gate_pass_destination,
      cp.departure_at gate_pass_departure_at,cp.expected_return_at gate_pass_expected_return_at,
      CASE WHEN coalesce(cp.overdue,false) THEN 'Yes' ELSE 'No' END gate_pass_overdue,
      CASE WHEN v_period='current_status' THEN NULL ELSE coalesce(ps.movement_count,0) END movements_in_period,
      CASE WHEN v_period='current_status' THEN la.scanned_at ELSE pl.scanned_at END last_movement_in_period,
      CASE WHEN v_period='current_status' THEN la.direction ELSE pl.direction END last_direction_in_period,
      CASE WHEN v_period='current_status' THEN coalesce(la.checkout_destination_label,'') ELSE coalesce(pl.checkout_destination_label,'') END last_destination_in_period,
      coalesce(ca.residence,'') residence,coalesce(ca.room,'') room,coalesce(ca.bed,'') bed
    FROM public.students s
    LEFT JOIN latest_all la ON la.student_id=s.id
    LEFT JOIN period_stats ps ON ps.student_id=s.id
    LEFT JOIN period_last pl ON pl.student_id=s.id
    LEFT JOIN active_bed_rest br ON br.student_id=s.id
    LEFT JOIN active_maternity mat ON mat.student_id=s.id
    LEFT JOIN current_pass cp ON cp.student_id=s.id
    LEFT JOIN current_accommodation ca ON ca.student_id=s.id
    WHERE s.is_active=true
  )
  SELECT count(*)::integer,count(*) FILTER(WHERE on_campus='Yes')::integer,
    count(*) FILTER(WHERE on_bed_rest='Yes')::integer,count(*) FILTER(WHERE on_gate_pass='Yes')::integer,
    coalesce(jsonb_agg(to_jsonb(report_rows) ORDER BY
      CASE WHEN on_gate_pass='Yes' THEN 0 ELSE 1 END,
      CASE WHEN on_bed_rest='Yes' THEN 0 ELSE 1 END,
      CASE WHEN on_campus='Yes' THEN 0 ELSE 1 END,student_name),'[]'::jsonb)
  INTO v_total,v_on_campus,v_bed_rest,v_on_gate_pass,v_rows FROM report_rows;

  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('report_export','student_movements',v_period,
    coalesce(private.system_access_role(p_pin,ARRAY['administrator','it_admin','management','student_leadership']),'unknown'),
    'exported',jsonb_build_object('period',v_period,'period_start',v_start,'row_count',v_total));

  RETURN jsonb_build_object('status','success','report','student_movements','period',v_period,
    'period_label',v_label,'period_start',v_start,'generated_at',now(),
    'summary',jsonb_build_object('active_students',v_total,'on_campus',v_on_campus,
      'on_bed_rest',v_bed_rest,'on_gate_pass',v_on_gate_pass),'rows',v_rows);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_movements_export_v2(p_pin text, p_period text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  v_admin_auth jsonb;
  v_dashboard_auth jsonb;
  v_result jsonb;
  v_rows jsonb;
  v_is_admin boolean:=false;
begin
  v_admin_auth:=public.admin_services_dashboard(p_pin,null);
  if coalesce(v_admin_auth->>'status','')='success' then
    v_is_admin:=true;
  else
    v_dashboard_auth:=public.student_services_dashboard_v3(p_pin);
    if coalesce(v_dashboard_auth->>'status','')<>'success' then
      return jsonb_build_object('status','unauthorized','message','Incorrect password.');
    end if;
  end if;

  v_result:=public.student_movements_export(p_pin,p_period);
  if coalesce(v_result->>'status','')<>'success' then return v_result; end if;

  if not v_is_admin then
    select coalesce(jsonb_agg(row_item-'maternity'-'bed_rest_started_at'),'[]'::jsonb)
    into v_rows from jsonb_array_elements(coalesce(v_result->'rows','[]'::jsonb)) row_item;
    v_result:=jsonb_set(v_result,'{rows}',v_rows,true);
    v_result:=v_result || jsonb_build_object('medical_visibility','bed_rest_permission_only');
  else
    v_result:=v_result || jsonb_build_object('medical_visibility','admin_full');
  end if;

  return v_result;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.student_plan_meal(p_registration_number text, p_meal_session text, p_service_date date)
 RETURNS jsonb
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.meal_plan_save(p_registration_number,p_meal_session,p_service_date,'student_self') $function$
;

CREATE OR REPLACE FUNCTION public.student_services_dashboard(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_access text;
  v_students jsonb;
  v_recent jsonb;
  v_passes jsonb;
  v_duty jsonb;
  v_settings jsonb;
  v_on integer; v_off integer; v_unknown integer;
  v_pending integer; v_approved integer; v_overdue integer;
  v_bed_rest integer; v_maternity integer;
  v_holiday boolean := false;
BEGIN
  v_access:=CASE WHEN private.system_access_matches(ARRAY['management'],p_pin) THEN 'management' WHEN private.system_access_matches(ARRAY['student_leadership'],p_pin) THEN 'student_leadership' WHEN private.system_access_matches(ARRAY['administrator','it_admin'],p_pin) THEN 'management' ELSE NULL END;
  IF v_access IS NULL THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect password.'); END IF;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_holiday
  FROM public.system_settings WHERE setting_key='school_holiday_mode';

  WITH latest AS (
    SELECT DISTINCT ON (cm.student_id) cm.student_id,cm.direction,cm.scanned_at,gd.device_name,gd.location
    FROM public.campus_movements cm JOIN public.gate_devices gd ON gd.id=cm.gate_device_id
    ORDER BY cm.student_id,cm.scanned_at DESC,cm.id DESC
  ), roster AS (
    SELECT s.id,s.registration_number,s.full_name,coalesce(l.direction,'UNKNOWN') status,
           l.scanned_at,l.device_name,l.location,
           (br.id IS NOT NULL) bed_rest,br.started_at bed_rest_started_at,br.notes bed_rest_notes,
           (mat.id IS NOT NULL) maternity,
           aa.residence,aa.room,aa.bed,aa.allocation_status
    FROM public.students s
    LEFT JOIN latest l ON l.student_id=s.id
    LEFT JOIN LATERAL (
      SELECT x.id,x.started_at,x.notes FROM public.student_support_statuses x
      WHERE x.student_id=s.id AND x.status_type='bed_rest' AND x.is_active=true
      ORDER BY x.started_at DESC LIMIT 1
    ) br ON true
    LEFT JOIN LATERAL (
      SELECT x.id FROM public.student_support_statuses x
      WHERE x.student_id=s.id AND x.status_type='maternity' AND x.is_active=true
      ORDER BY x.started_at DESC LIMIT 1
    ) mat ON true
    LEFT JOIN LATERAL (
      SELECT a.residence,a.room,a.bed,a.allocation_status FROM public.accommodation_allocations a
      WHERE a.student_id=s.id AND a.is_active=true ORDER BY a.allocated_at DESC LIMIT 1
    ) aa ON true
    WHERE s.is_active=true
  )
  SELECT count(*) FILTER(WHERE status='IN'),count(*) FILTER(WHERE status='OUT'),count(*) FILTER(WHERE status='UNKNOWN'),
         count(*) FILTER(WHERE bed_rest),count(*) FILTER(WHERE maternity),
         coalesce(jsonb_agg(jsonb_build_object(
           'student_id',id,'registration_number',registration_number,'student_name',full_name,
           'status',status,'last_movement_at',scanned_at,'device_name',device_name,'location',location,
           'bed_rest',bed_rest,'bed_rest_started_at',bed_rest_started_at,'bed_rest_notes',bed_rest_notes,
           'maternity',maternity,'residence',residence,'room',room,'bed',bed,'accommodation_status',allocation_status
         ) ORDER BY full_name),'[]'::jsonb)
  INTO v_on,v_off,v_unknown,v_bed_rest,v_maternity,v_students FROM roster;

  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'id',x.id,'registration_number',x.registration_number,'student_name',x.full_name,
    'direction',x.direction,'scanned_at',x.scanned_at,'device_name',x.device_name,'location',x.location,
    'gate_pass_id',x.gate_pass_id,'checkout_destination_code',x.checkout_destination_code,
    'checkout_destination_label',x.checkout_destination_label
  ) ORDER BY x.scanned_at DESC),'[]'::jsonb)
  INTO v_recent
  FROM (
    SELECT cm.id,s.registration_number,s.full_name,cm.direction,cm.scanned_at,gd.device_name,gd.location,
           cm.gate_pass_id,cm.checkout_destination_code,cm.checkout_destination_label
    FROM public.campus_movements cm JOIN public.students s ON s.id=cm.student_id
    JOIN public.gate_devices gd ON gd.id=cm.gate_device_id
    ORDER BY cm.scanned_at DESC,cm.id DESC LIMIT 150
  ) x;

  SELECT count(*) FILTER(WHERE status='pending'),count(*) FILTER(WHERE status='approved'),
         count(*) FILTER(WHERE status='departed' AND expected_return_at<now())
  INTO v_pending,v_approved,v_overdue FROM public.gate_passes;

  SELECT coalesce(jsonb_agg(item ORDER BY submitted_at DESC),'[]'::jsonb) INTO v_passes
  FROM (
    SELECT p.submitted_at,jsonb_build_object(
      'id',p.id,'student_id',p.student_id,'student_name',s.full_name,'registration_number',s.registration_number,
      'destination',p.destination,'reason',p.reason,'contact_details',p.contact_details,
      'departure_at',p.departure_at,'expected_return_at',p.expected_return_at,'submitted_at',p.submitted_at,
      'status',p.status,'final_approved_at',p.final_approved_at,'actual_departure_at',p.actual_departure_at,
      'actual_return_at',p.actual_return_at,'paper_pass_checked',p.paper_pass_checked,
      'cancellation_reason',p.cancellation_reason,'overdue',(p.status='departed' AND p.expected_return_at<now()),
      'approvals',coalesce((SELECT jsonb_agg(jsonb_build_object(
        'role',a.approver_role,'decision',a.decision,'comments',a.comments,'decided_at',a.decided_at
      ) ORDER BY a.decided_at) FROM public.gate_pass_approvals a WHERE a.pass_id=p.id),'[]'::jsonb),
      'waiting_on',CASE
        WHEN p.status<>'pending' THEN NULL
        WHEN NOT EXISTS(SELECT 1 FROM public.gate_pass_approvals a WHERE a.pass_id=p.id AND a.approver_role='administrator' AND a.decision='approved') THEN 'School Administrator'
        WHEN NOT v_holiday AND NOT EXISTS(SELECT 1 FROM public.gate_pass_approvals a WHERE a.pass_id=p.id AND a.approver_role IN ('principal','dean','director') AND a.decision='approved') THEN 'Principal, Dean or Director'
        ELSE NULL END
    ) item
    FROM public.gate_passes p JOIN public.students s ON s.id=p.student_id
    ORDER BY p.submitted_at DESC LIMIT 300
  ) q;

  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'id',x.id,'student_name',x.full_name,'registration_number',x.registration_number,
    'direction',x.direction,'scanned_at',x.scanned_at,'source',x.record_source
  ) ORDER BY x.scanned_at DESC),'[]'::jsonb)
  INTO v_duty
  FROM (
    SELECT g.id,s.full_name,s.registration_number,g.direction,g.scanned_at,g.record_source
    FROM public.gate_duty_records g JOIN public.students s ON s.id=g.student_id
    WHERE (g.scanned_at AT TIME ZONE 'Africa/Harare')::date=(now() AT TIME ZONE 'Africa/Harare')::date
    ORDER BY g.scanned_at DESC LIMIT 200
  ) x;

  IF v_access='management' THEN
    SELECT coalesce(jsonb_object_agg(setting_key,setting_value),'{}'::jsonb) INTO v_settings FROM public.system_settings;
  ELSE v_settings:='{}'::jsonb; END IF;

  RETURN jsonb_build_object(
    'status','success','access_level',v_access,
    'can_review_passes',(v_access='management'),'can_manage_settings',(v_access='management'),
    'school_holiday_mode',v_holiday,
    'counts',jsonb_build_object('on_campus',v_on,'off_campus',v_off,'unknown',v_unknown,
      'pending_passes',v_pending,'approved_passes',v_approved,'overdue_passes',v_overdue,
      'bed_rest',v_bed_rest,'maternity',v_maternity),
    'students',v_students,'recent_movements',v_recent,'gate_passes',v_passes,
    'gate_duty_today',v_duty,'settings',v_settings
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_services_dashboard_v2(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_result jsonb;
BEGIN
  v_result:=public.student_services_dashboard(p_pin);
  IF coalesce(v_result->>'status','')<>'success' THEN RETURN v_result; END IF;
  RETURN v_result || jsonb_build_object('current_academic_year',public._current_academic_year());
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_services_dashboard_v3(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  v_result jsonb;
  v_students jsonb;
  v_passes jsonb;
  v_counts jsonb;
begin
  v_result:=public.student_services_dashboard_v2(p_pin);
  if coalesce(v_result->>'status','')<>'success' then return v_result; end if;

  select coalesce(jsonb_agg(
    (student_item - 'bed_rest_notes' - 'bed_rest_started_at' - 'maternity') ||
    coalesce((
      select jsonb_build_object(
        'outing_type',case
          when cm.gate_pass_id is not null then 'gate_pass'
          when cm.checkout_destination_code='1' then 'tanaka'
          when cm.checkout_destination_code='2' then 'mdh'
          when cm.checkout_destination_code='3' then 'town_other'
          when cm.checkout_destination_code='4' then 'holiday'
          else null
        end,
        'outing_label',cm.checkout_destination_label,
        'current_gate_pass_id',cm.gate_pass_id
      )
      from public.campus_movements cm
      where cm.student_id=student_item->>'student_id'
      order by cm.scanned_at desc,cm.id desc
      limit 1
    ),jsonb_build_object('outing_type',null,'outing_label',null,'current_gate_pass_id',null))
    order by student_item->>'student_name'
  ),'[]'::jsonb)
  into v_students
  from jsonb_array_elements(coalesce(v_result->'students','[]'::jsonb)) student_item;

  select coalesce(jsonb_agg(
    pass_item || jsonb_build_object(
      'people',public._gate_pass_people_json((pass_item->>'id')::uuid)
    ) order by (pass_item->>'submitted_at')::timestamptz desc
  ),'[]'::jsonb)
  into v_passes
  from jsonb_array_elements(coalesce(v_result->'gate_passes','[]'::jsonb)) pass_item;

  v_counts:=coalesce(v_result->'counts','{}'::jsonb)-'maternity';
  v_result:=jsonb_set(v_result,'{students}',v_students,true);
  v_result:=jsonb_set(v_result,'{gate_passes}',v_passes,true);
  v_result:=jsonb_set(v_result,'{counts}',v_counts,true);

  return v_result || jsonb_build_object(
    'medical_visibility','bed_rest_permission_only',
    'can_view_pass_details',true
  );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.student_services_dashboard_v4(p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare
  v_result jsonb;
  v_students jsonb;
begin
  v_result := public.student_services_dashboard_v3(p_pin);

  if v_result is null or v_result->>'status' is distinct from 'success' then
    return v_result;
  end if;

  select coalesce(
    jsonb_agg(
      student_entry.item || jsonb_build_object('gender', student.gender)
      order by student_entry.position
    ),
    '[]'::jsonb
  )
  into v_students
  from jsonb_array_elements(coalesce(v_result->'students', '[]'::jsonb))
       with ordinality as student_entry(item, position)
  left join public.students as student
    on student.registration_number::text = student_entry.item->>'registration_number';

  return jsonb_set(v_result, '{students}', v_students, true);
end;
$function$
;

CREATE OR REPLACE FUNCTION public.student_services_export(p_pin text, p_report text, p_start_date date, p_end_date date)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE v_result jsonb;
BEGIN
  IF private.system_access_role(p_pin,ARRAY['administrator','it_admin','management','student_leadership']) IS NULL THEN RETURN jsonb_build_object('status','unauthorized','message','Incorrect password.'); END IF;
  IF p_start_date IS NULL THEN p_start_date:=current_date-30; END IF;
  IF p_end_date IS NULL THEN p_end_date:=current_date; END IF;
  IF p_report='campus' THEN
    SELECT coalesce(jsonb_agg(to_jsonb(q) ORDER BY q.scanned_at DESC),'[]'::jsonb) INTO v_result FROM (
      SELECT cm.scanned_at,s.registration_number,s.full_name,cm.direction,cm.movement_source,gd.device_name,
             cm.gate_pass_id,cm.checkout_destination_code,cm.checkout_destination_label
      FROM public.campus_movements cm JOIN public.students s ON s.id=cm.student_id
      JOIN public.gate_devices gd ON gd.id=cm.gate_device_id
      WHERE (cm.scanned_at AT TIME ZONE 'Africa/Harare')::date BETWEEN p_start_date AND p_end_date
    ) q;
  ELSIF p_report='passes' THEN
    SELECT coalesce(jsonb_agg(to_jsonb(q) ORDER BY q.submitted_at DESC),'[]'::jsonb) INTO v_result FROM (
      SELECT p.submitted_at,s.registration_number,s.full_name,p.destination,p.reason,p.departure_at,
             p.expected_return_at,p.status,p.final_approved_at,p.actual_departure_at,p.actual_return_at,p.contact_details
      FROM public.gate_passes p JOIN public.students s ON s.id=p.student_id
      WHERE (p.submitted_at AT TIME ZONE 'Africa/Harare')::date BETWEEN p_start_date AND p_end_date
    ) q;
  ELSIF p_report='gate_duty' THEN
    SELECT coalesce(jsonb_agg(to_jsonb(q) ORDER BY q.scanned_at DESC),'[]'::jsonb) INTO v_result FROM (
      SELECT g.scanned_at,s.registration_number,s.full_name,g.direction,g.record_source,gd.device_name
      FROM public.gate_duty_records g JOIN public.students s ON s.id=g.student_id
      JOIN public.gate_devices gd ON gd.id=g.gate_device_id
      WHERE (g.scanned_at AT TIME ZONE 'Africa/Harare')::date BETWEEN p_start_date AND p_end_date
    ) q;
  ELSIF p_report='meals' THEN
    SELECT coalesce(jsonb_agg(to_jsonb(q) ORDER BY q.checked_in_at DESC),'[]'::jsonb) INTO v_result FROM (
      SELECT c.service_date,c.checked_in_at,s.registration_number,s.full_name,c.meal_session,c.check_in_source
      FROM public.check_ins c JOIN public.students s ON s.id=c.student_id
      WHERE c.service_date BETWEEN p_start_date AND p_end_date
    ) q;
  ELSE RETURN jsonb_build_object('status','invalid','message','Unknown report type.'); END IF;
  RETURN jsonb_build_object('status','success','report',p_report,'rows',v_result);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_services_update_setting(p_pin text, p_setting_key text, p_setting_value jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_actor text:=private.system_access_role(p_pin,array['management','administrator','it_admin']);
begin
  if v_actor is null then return jsonb_build_object('status','unauthorized','message','Management password required.'); end if;
  if p_setting_key not in ('gate_pass_pilot_mode','gate_pass_pilot_started_at','gate_pass_pilot_ends_at','gate_terminal_result_seconds') then
    return jsonb_build_object('status','invalid','message','This setting cannot be changed from the application.');
  end if;
  insert into public.system_settings(setting_key,setting_value,updated_at)
  values(p_setting_key,p_setting_value,now())
  on conflict(setting_key) do update set setting_value=excluded.setting_value,updated_at=excluded.updated_at;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('settings','system_setting',p_setting_key,v_actor,'updated',jsonb_build_object('value',p_setting_value));
  return jsonb_build_object('status','success','setting_key',p_setting_key,'setting_value',p_setting_value);
end
$function$
;

CREATE OR REPLACE FUNCTION public.student_submit_gate_pass(p_registration_number text, p_destination text, p_reason text, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_contact_details text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_student public.students%rowtype;
  v_pass public.gate_passes%rowtype;
  v_deadline timestamptz;
  v_pilot boolean;
  v_pilot_end jsonb;
  v_holiday boolean := false;
BEGIN
  SELECT * INTO v_student
  FROM public.students
  WHERE registration_number::text=regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    AND is_active=true
  LIMIT 1;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('status','not_found','message','Student registration number was not found.');
  END IF;

  IF length(trim(coalesce(p_destination,'')))<2
     OR length(trim(coalesce(p_reason,'')))<3
     OR length(trim(coalesce(p_contact_details,'')))<3 THEN
    RETURN jsonb_build_object('status','invalid','message','Complete the destination, reason and contact details.');
  END IF;

  IF p_departure_at IS NULL OR p_expected_return_at IS NULL OR p_expected_return_at<=p_departure_at THEN
    RETURN jsonb_build_object('status','invalid','message','Expected return must be later than departure.');
  END IF;

  IF p_departure_at<=now() THEN
    RETURN jsonb_build_object('status','invalid','message','Departure must be in the future.');
  END IF;

  SELECT coalesce((setting_value #>> '{}')::boolean,false)
  INTO v_holiday
  FROM public.system_settings
  WHERE setting_key='school_holiday_mode';

  IF NOT coalesce(v_holiday,false) THEN
    v_deadline:=public._gate_pass_deadline(p_departure_at);
    IF now()>v_deadline THEN
      RETURN jsonb_build_object(
        'status','deadline_closed',
        'message','The Wednesday 4:00 pm submission deadline has passed. Contact School Administration for an emergency request.',
        'deadline',v_deadline,
        'school_holiday_mode',false
      );
    END IF;
  ELSE
    v_deadline:=NULL;
  END IF;

  IF EXISTS(
    SELECT 1 FROM public.gate_passes
    WHERE student_id=v_student.id
      AND status IN ('pending','approved','departed')
      AND tstzrange(departure_at,expected_return_at,'[]') && tstzrange(p_departure_at,p_expected_return_at,'[]')
  ) THEN
    RETURN jsonb_build_object('status','duplicate_request','message','An active gate pass already overlaps this period.');
  END IF;

  INSERT INTO public.gate_passes(student_id,destination,reason,departure_at,expected_return_at,contact_details)
  VALUES(v_student.id,trim(p_destination),trim(p_reason),p_departure_at,p_expected_return_at,trim(p_contact_details))
  RETURNING * INTO v_pass;

  INSERT INTO public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
  VALUES(v_pass.id,NULL,'pending','student',
    CASE WHEN v_holiday THEN 'Gate pass submitted during School Holiday Mode.' ELSE 'Gate pass submitted.' END);

  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('gate_pass','gate_pass',v_pass.id::text,'student','submitted',
    jsonb_build_object('student_id',v_student.id,'registration_number',v_student.registration_number,'school_holiday_mode',v_holiday));

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_pilot
  FROM public.system_settings WHERE setting_key='gate_pass_pilot_mode';
  SELECT setting_value INTO v_pilot_end
  FROM public.system_settings WHERE setting_key='gate_pass_pilot_ends_at';

  RETURN jsonb_build_object(
    'status','success','pass_id',v_pass.id,'student_name',v_student.full_name,
    'registration_number',v_student.registration_number,'pass_status',v_pass.status,
    'deadline',v_deadline,'pilot_mode',v_pilot,'pilot_ends_at',v_pilot_end,
    'school_holiday_mode',v_holiday,
    'approval_rule',CASE WHEN v_holiday THEN 'School Administrator approval only' ELSE 'School Administrator plus Principal, Dean or Director' END
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_submit_gate_pass_v2(p_registration_number text, p_destination text, p_reason text, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_contact_details text, p_companion_registration_numbers text[] DEFAULT '{}'::text[])
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_student public.students%rowtype;
  v_companion public.students%rowtype;
  v_pass public.gate_passes%rowtype;
  v_deadline timestamptz;
  v_pilot boolean;
  v_pilot_end jsonb;
  v_holiday boolean := false;
  v_raw text;
  v_reg text;
  v_companion_ids text[] := '{}'::text[];
  v_companion_count integer := 0;
  v_people jsonb;
BEGIN
  SELECT * INTO v_student
  FROM public.students
  WHERE registration_number::text = regexp_replace(coalesce(p_registration_number,''),'\D','','g')
    AND is_active = true
  LIMIT 1;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('status','not_found','message','Student registration number was not found.');
  END IF;

  IF length(trim(coalesce(p_destination,''))) < 2
     OR length(trim(coalesce(p_reason,''))) < 3
     OR length(trim(coalesce(p_contact_details,''))) < 3 THEN
    RETURN jsonb_build_object('status','invalid','message','Complete the destination, reason and contact details.');
  END IF;

  IF p_departure_at IS NULL OR p_expected_return_at IS NULL OR p_expected_return_at <= p_departure_at THEN
    RETURN jsonb_build_object('status','invalid','message','Expected return must be later than departure.');
  END IF;

  IF p_departure_at <= now() THEN
    RETURN jsonb_build_object('status','invalid','message','Departure must be in the future.');
  END IF;

  SELECT coalesce((setting_value #>> '{}')::boolean,false)
  INTO v_holiday
  FROM public.system_settings
  WHERE setting_key='school_holiday_mode';

  IF NOT coalesce(v_holiday,false) THEN
    v_deadline := public._gate_pass_deadline(p_departure_at);
    IF now() > v_deadline THEN
      RETURN jsonb_build_object(
        'status','deadline_closed',
        'message','The Wednesday 4:00 pm submission deadline has passed. Contact School Administration for an emergency request.',
        'deadline',v_deadline,
        'school_holiday_mode',false
      );
    END IF;
  ELSE
    v_deadline := NULL;
  END IF;

  IF EXISTS(
    SELECT 1
    FROM public.gate_passes gp
    JOIN public.gate_pass_members gm ON gm.pass_id=gp.id
    WHERE gm.student_id=v_student.id
      AND gp.status IN ('pending','approved','departed')
      AND tstzrange(gp.departure_at,gp.expected_return_at,'[]')
          && tstzrange(p_departure_at,p_expected_return_at,'[]')
  ) THEN
    RETURN jsonb_build_object('status','duplicate_request','message','You already have an active gate pass that overlaps this period.');
  END IF;

  FOR v_raw IN
    SELECT DISTINCT u.value
    FROM unnest(coalesce(p_companion_registration_numbers,'{}'::text[])) AS u(value)
  LOOP
    v_reg := regexp_replace(coalesce(v_raw,''),'\D','','g');
    IF v_reg = '' THEN CONTINUE; END IF;

    IF v_reg = v_student.registration_number::text THEN
      RETURN jsonb_build_object('status','invalid_companion','message','Do not add your own registration number as a companion.');
    END IF;

    SELECT * INTO v_companion
    FROM public.students
    WHERE registration_number::text=v_reg
      AND is_active=true
    LIMIT 1;

    IF NOT FOUND THEN
      RETURN jsonb_build_object('status','invalid_companion','message','Companion registration number '||v_reg||' was not found.');
    END IF;

    IF v_companion.id = ANY(v_companion_ids) THEN CONTINUE; END IF;

    v_companion_count := v_companion_count + 1;
    IF v_companion_count > 5 THEN
      RETURN jsonb_build_object('status','too_many_companions','message','A gate pass can include up to five additional people.');
    END IF;

    IF EXISTS(
      SELECT 1
      FROM public.gate_passes gp
      JOIN public.gate_pass_members gm ON gm.pass_id=gp.id
      WHERE gm.student_id=v_companion.id
        AND gp.status IN ('pending','approved','departed')
        AND tstzrange(gp.departure_at,gp.expected_return_at,'[]')
            && tstzrange(p_departure_at,p_expected_return_at,'[]')
    ) THEN
      RETURN jsonb_build_object('status','companion_conflict','message',v_companion.full_name||' already has an active gate pass that overlaps this period.');
    END IF;

    v_companion_ids := array_append(v_companion_ids,v_companion.id);
  END LOOP;

  INSERT INTO public.gate_passes(student_id,destination,reason,departure_at,expected_return_at,contact_details)
  VALUES(v_student.id,trim(p_destination),trim(p_reason),p_departure_at,p_expected_return_at,trim(p_contact_details))
  RETURNING * INTO v_pass;

  IF array_length(v_companion_ids,1) IS NOT NULL THEN
    INSERT INTO public.gate_pass_members(pass_id,student_id,is_primary,added_by_student_id)
    SELECT v_pass.id,u.student_id,false,v_student.id
    FROM unnest(v_companion_ids) AS u(student_id)
    ON CONFLICT(pass_id,student_id) DO NOTHING;
  END IF;

  INSERT INTO public.gate_pass_status_history(pass_id,previous_status,new_status,actor_role,notes)
  VALUES(v_pass.id,NULL,'pending','student',CASE
    WHEN v_holiday THEN 'Shared gate pass submitted during School Holiday Mode.'
    WHEN v_companion_count > 0 THEN 'Shared gate pass submitted.'
    ELSE 'Gate pass submitted.' END);

  INSERT INTO public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  VALUES('gate_pass','gate_pass',v_pass.id::text,'student','submitted',jsonb_build_object(
    'student_id',v_student.id,
    'registration_number',v_student.registration_number,
    'companion_count',v_companion_count,
    'school_holiday_mode',v_holiday
  ));

  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'student_name',s.full_name,
    'registration_number',s.registration_number,
    'is_primary',gm.is_primary
  ) ORDER BY gm.is_primary DESC,s.full_name),'[]'::jsonb)
  INTO v_people
  FROM public.gate_pass_members gm
  JOIN public.students s ON s.id=gm.student_id
  WHERE gm.pass_id=v_pass.id;

  SELECT coalesce((setting_value #>> '{}')::boolean,false) INTO v_pilot
  FROM public.system_settings WHERE setting_key='gate_pass_pilot_mode';
  SELECT setting_value INTO v_pilot_end
  FROM public.system_settings WHERE setting_key='gate_pass_pilot_ends_at';

  RETURN jsonb_build_object(
    'status','success','pass_id',v_pass.id,'student_name',v_student.full_name,
    'registration_number',v_student.registration_number,'people',v_people,
    'pass_status',v_pass.status,'deadline',v_deadline,'pilot_mode',v_pilot,
    'pilot_ends_at',v_pilot_end,'school_holiday_mode',v_holiday,
    'approval_rule',CASE WHEN v_holiday THEN 'School Administrator approval only' ELSE 'School Administrator plus Principal, Dean or Director' END
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_submit_gate_pass_v3(p_registration_number text, p_destination text, p_reason text, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_contact_details text, p_companions jsonb DEFAULT '[]'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_companion_regs text[] := '{}'::text[];
BEGIN
  IF p_companions IS NULL THEN
    p_companions:='[]'::jsonb;
  END IF;

  IF jsonb_typeof(p_companions)<>'array' THEN
    RETURN jsonb_build_object(
      'status','invalid_companions',
      'message','The people added to the pass could not be read. Remove them and add them again.'
    );
  END IF;

  SELECT coalesce(array_agg(registration_number),'{}'::text[])
  INTO v_companion_regs
  FROM (
    SELECT DISTINCT regexp_replace(value,'\D','','g') AS registration_number
    FROM jsonb_array_elements_text(p_companions)
    WHERE regexp_replace(value,'\D','','g')<>''
  ) registrations;

  RETURN public.student_submit_gate_pass_v2(
    p_registration_number,
    p_destination,
    p_reason,
    p_departure_at,
    p_expected_return_at,
    p_contact_details,
    v_companion_regs
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.student_submit_gate_pass_v4(p_registration_number text, p_destination text, p_reason text, p_departure_at timestamp with time zone, p_expected_return_at timestamp with time zone, p_contact_details text, p_requester_email text, p_companions jsonb DEFAULT '[]'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_result jsonb;
  v_pass_id uuid;
  v_email text:=lower(trim(coalesce(p_requester_email,'')));
  v_queued integer:=0;
begin
  if length(v_email)>254 or v_email !~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$' then
    return jsonb_build_object('status','invalid','message','Enter a valid email address for pass updates.');
  end if;

  v_result:=public.student_submit_gate_pass_v3(
    p_registration_number,p_destination,p_reason,p_departure_at,p_expected_return_at,
    p_contact_details,p_companions
  );

  if coalesce(v_result->>'status','')<>'success' then
    return v_result;
  end if;

  v_pass_id:=(v_result->>'pass_id')::uuid;
  insert into private.pass_requester_contacts(pass_id,requester_email)
  values(v_pass_id,v_email)
  on conflict(pass_id) do update set requester_email=excluded.requester_email;

  v_queued:=private.pass_queue_email(v_pass_id,'submitted');

  return v_result||jsonb_build_object(
    'notification_email_saved',true,
    'email_notification_queued',v_queued>0
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.student_term_registration_lookup(p_registration_number text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_student_lookup(p_registration_number) $function$
;

CREATE OR REPLACE FUNCTION public.student_term_registration_save(p_registration_number text, p_resume_token text, p_answers jsonb)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_student_save(p_registration_number,p_resume_token,p_answers) $function$
;

CREATE OR REPLACE FUNCTION public.student_term_registration_start(p_registration_number text, p_resume_token text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_student_start(p_registration_number,p_resume_token) $function$
;

CREATE OR REPLACE FUNCTION public.student_term_registration_status()
 RETURNS jsonb
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_catalog'
AS $function$
  select case when t.id is null then jsonb_build_object('status','closed','registration_is_open',false)
  else jsonb_build_object(
    'status','success','registration_is_open',true,'term_id',t.id,'term_name',t.term_name,
    'academic_year',t.academic_year,'term_number',t.term_number,
    'opened_at',t.registration_opened_at
  ) end
  from (select 1) q
  left join lateral (
    select * from public.academic_terms where registration_is_open
    order by registration_opened_at desc nulls last,id desc limit 1
  ) t on true
$function$
;

CREATE OR REPLACE FUNCTION public.student_term_registration_submit(p_registration_number text, p_resume_token text, p_answers jsonb)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_student_submit(p_registration_number,p_resume_token,p_answers) $function$
;

CREATE OR REPLACE FUNCTION public.system_control_bootstrap(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_settings jsonb;
  v_roles jsonb;
  v_departments jsonb;
  v_audit jsonb;
begin
  select * into v_context
  from private.system_session_context(p_session_token,array['administrator','it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','Your control session has ended.'); end if;

  select coalesce(jsonb_object_agg(setting_key,setting_value),'{}'::jsonb)
  into v_settings from public.system_settings;

  select coalesce(jsonb_agg(jsonb_build_object(
    'role_key',c.role_key,'role_label',c.role_label,'active',c.active,
    'pin_configured',c.access_hash is not null,'must_change_pin',c.must_change_pin,
    'pin_changed_at',c.pin_changed_at,'locked_until',c.locked_until
  ) order by case c.role_key
    when 'it_admin' then 1 when 'administrator' then 2 when 'management' then 3
    when 'student_leadership' then 4 when 'library_staff' then 5 else 100 end),'[]'::jsonb)
  into v_roles from public.system_access_credentials c;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id',d.id,'slug',d.slug,'name',d.name,'active',d.active,
    'workspace_enabled',d.workspace_enabled,'pin_configured',dc.access_hash is not null,
    'pin_changed_at',dc.updated_at
  ) order by d.sort_order,d.name),'[]'::jsonb)
  into v_departments
  from public.ops_departments d
  left join public.ops_department_credentials dc on dc.department_id=d.id
  where d.active and d.workspace_enabled;

  select coalesce(jsonb_agg(to_jsonb(q) order by q.created_at desc),'[]'::jsonb)
  into v_audit
  from (
    select id,event_type,entity_type,entity_id,actor_role,action,details,created_at
    from public.audit_log
    where event_type in ('settings','access','library')
    order by created_at desc limit 100
  ) q;

  return jsonb_build_object(
    'status','success','role',v_context.role_key,'must_change_pin',v_context.must_change_pin,
    'can_manage_pins',v_context.role_key='it_admin','mode',private.school_operating_mode(),
    'settings',v_settings,
    'role_credentials',case when v_context.role_key='it_admin' then v_roles else '[]'::jsonb end,
    'departments',case when v_context.role_key='it_admin' then v_departments else '[]'::jsonb end,
    'audit',v_audit,'loaded_at',now()
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_bootstrap_v2(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record; v_result jsonb;
begin
  select * into v_context from private.system_session_context(p_session_token,array['administrator','it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','Your control session has ended.'); end if;
  v_result:=public.system_control_bootstrap(p_session_token);
  if v_result->>'status'<>'success' then return v_result; end if;
  v_result:=jsonb_set(v_result,'{role_credentials}',coalesce((
    select jsonb_agg(value || jsonb_build_object('pin_viewable',exists(
      select 1 from private.system_pin_recovery r
      where r.target_type='role' and r.target_key=value->>'role_key'
    ))) from jsonb_array_elements(v_result->'role_credentials')
  ),'[]'::jsonb));
  v_result:=jsonb_set(v_result,'{departments}',coalesce((
    select jsonb_agg(value || jsonb_build_object('pin_viewable',exists(
      select 1 from private.system_pin_recovery r
      where r.target_type='department' and r.target_key=value->>'id'
    ))) from jsonb_array_elements(v_result->'departments')
  ),'[]'::jsonb));
  return v_result || jsonb_build_object('actor_people',(
    select coalesce(jsonb_agg(jsonb_build_object('id',s.id,'full_name',s.full_name) order by s.full_name),'[]'::jsonb)
    from public.students s where s.is_active
  ));
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_delete_gate_pass(p_session_token text, p_pass_id uuid, p_confirmation text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare
  v_context record;
  v_pass public.gate_passes%rowtype;
  v_student_names jsonb;
  v_member_count integer:=0;
  v_approval_count integer:=0;
  v_history_count integer:=0;
  v_email_count integer:=0;
  v_movement_count integer:=0;
begin
  select * into v_context
  from private.system_session_context(p_session_token,array['it_admin']);
  if not found then
    return jsonb_build_object('status','unauthorized','message','IT Administrator access is required.');
  end if;
  if p_pass_id is null then
    return jsonb_build_object('status','invalid','message','Choose a pass to delete.');
  end if;
  if trim(coalesce(p_confirmation,''))<>'DELETE' then
    return jsonb_build_object('status','confirmation_required','message','Type DELETE exactly to confirm permanent removal.');
  end if;
  if not exists(
    select 1 from public.students s
    where s.is_active and s.full_name=trim(coalesce(p_actor_name,''))
  ) then
    return jsonb_build_object('status','invalid','message','Choose your exact name from the database lookup.');
  end if;

  select * into v_pass
  from public.gate_passes gp
  where gp.id=p_pass_id
  for update;
  if not found then
    return jsonb_build_object('status','not_found','message','This pass no longer exists. Refresh the list.');
  end if;

  select coalesce(jsonb_agg(s.full_name order by gm.is_primary desc,s.full_name),'[]'::jsonb),count(*)::integer
  into v_student_names,v_member_count
  from public.gate_pass_members gm
  join public.students s on s.id=gm.student_id
  where gm.pass_id=p_pass_id;
  if v_member_count=0 then
    select jsonb_build_array(s.full_name) into v_student_names
    from public.students s where s.id=v_pass.student_id;
  end if;

  select count(*)::integer into v_approval_count from public.gate_pass_approvals ga where ga.pass_id=p_pass_id;
  select count(*)::integer into v_history_count from public.gate_pass_status_history gh where gh.pass_id=p_pass_id;
  select count(*)::integer into v_email_count from private.pass_email_outbox po where po.pass_id=p_pass_id;
  select count(*)::integer into v_movement_count from public.campus_movements cm where cm.gate_pass_id=p_pass_id;

  delete from public.campus_movements cm where cm.gate_pass_id=p_pass_id;
  delete from public.gate_passes gp where gp.id=p_pass_id;

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values(
    'access','gate_pass',p_pass_id::text,'it_admin','test_pass_deleted',
    jsonb_build_object(
      'actor_name',trim(p_actor_name),
      'student_names',coalesce(v_student_names,'[]'::jsonb),
      'status',v_pass.status,
      'destination',v_pass.destination,
      'submitted_at',v_pass.submitted_at,
      'deleted_counts',jsonb_build_object(
        'members',v_member_count,
        'approvals',v_approval_count,
        'status_history',v_history_count,
        'email_messages',v_email_count,
        'campus_movements',v_movement_count
      )
    )
  );

  return jsonb_build_object(
    'status','success',
    'message','The test pass and its linked records were permanently deleted.',
    'pass_id',p_pass_id,
    'student_names',coalesce(v_student_names,'[]'::jsonb),
    'deleted_counts',jsonb_build_object(
      'members',v_member_count,
      'approvals',v_approval_count,
      'status_history',v_history_count,
      'email_messages',v_email_count,
      'campus_movements',v_movement_count
    )
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_gate_passes(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
declare
  v_context record;
  v_passes jsonb;
begin
  select * into v_context
  from private.system_session_context(p_session_token,array['it_admin']);
  if not found then
    return jsonb_build_object('status','unauthorized','message','IT Administrator access is required.');
  end if;

  select coalesce(jsonb_agg(to_jsonb(pass_row) order by pass_row.submitted_at desc),'[]'::jsonb)
  into v_passes
  from (
    select
      gp.id,
      gp.status,
      gp.destination,
      gp.reason,
      gp.departure_at,
      gp.expected_return_at,
      gp.submitted_at,
      gp.created_source,
      coalesce((
        select jsonb_agg(s.full_name order by gm.is_primary desc,s.full_name)
        from public.gate_pass_members gm
        join public.students s on s.id=gm.student_id
        where gm.pass_id=gp.id
      ),jsonb_build_array(primary_student.full_name)) as student_names,
      (select count(*)::integer from public.gate_pass_members gm where gm.pass_id=gp.id) as member_count,
      (select count(*)::integer from public.gate_pass_approvals ga where ga.pass_id=gp.id) as approval_count,
      (select count(*)::integer from public.gate_pass_status_history gh where gh.pass_id=gp.id) as history_count,
      (select count(*)::integer from private.pass_email_outbox po where po.pass_id=gp.id) as email_count,
      (select count(*)::integer from public.campus_movements cm where cm.gate_pass_id=gp.id) as movement_count
    from public.gate_passes gp
    join public.students primary_student on primary_student.id=gp.student_id
    order by gp.submitted_at desc
    limit 500
  ) pass_row;

  return jsonb_build_object('status','success','passes',v_passes,'limit',500);
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_login(p_role text, p_pin text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'extensions', 'pg_catalog'
AS $function$
declare
  v_role text:=lower(trim(coalesce(p_role,'')));
  v_credential public.system_access_credentials%rowtype;
  v_token text;
begin
  if v_role not in ('administrator','it_admin','admin_staff','management') then
    return jsonb_build_object('status','unauthorized','message','Choose an authorised Administration role.');
  end if;
  select * into v_credential from public.system_access_credentials where role_key=v_role for update;
  if not found or not v_credential.active or v_credential.access_hash is null then
    return jsonb_build_object('status','unavailable','message','This access role has not been enabled yet.');
  end if;
  if v_credential.locked_until is not null and v_credential.locked_until>now() then
    return jsonb_build_object('status','locked','message','Too many incorrect attempts. Try again later.');
  end if;
  if v_credential.access_hash<>extensions.crypt(coalesce(p_pin,''),v_credential.access_hash) then
    update public.system_access_credentials set
      failed_attempts=failed_attempts+1,
      locked_until=case when failed_attempts+1>=5 then now()+interval '15 minutes' else null end,
      updated_at=now()
    where role_key=v_role;
    return jsonb_build_object('status','unauthorized','message','Incorrect PIN.');
  end if;
  update public.system_access_credentials set failed_attempts=0,locked_until=null,updated_at=now() where role_key=v_role;
  v_token:=encode(extensions.gen_random_bytes(32),'hex');
  insert into public.system_access_sessions(token_hash,role_key,expires_at)
  values(encode(extensions.digest(v_token,'sha256'),'hex'),v_role,now()+interval '8 hours');
  delete from public.system_access_sessions where expires_at<now()-interval '1 day' or revoked_at<now()-interval '1 day';
  return jsonb_build_object('status','success','session_token',v_token,'role',v_role,
    'display_name',v_credential.role_label,'must_change_pin',v_credential.must_change_pin,'expires_at',now()+interval '8 hours');
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_logout(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
begin
  update public.system_access_sessions
  set revoked_at=now()
  where token_hash=encode(extensions.digest(coalesce(p_session_token,''),'sha256'),'hex');
  return jsonb_build_object('status','success');
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_pass_email_settings(p_session_token text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'cron', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_settings private.pass_email_settings%rowtype;
  v_queued integer;
  v_failed integer;
  v_schedule_ready boolean;
begin
  select * into v_context from private.system_session_context(p_session_token,array['it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','IT Administrator access is required.'); end if;
  select * into v_settings from private.pass_email_settings where singleton=true;
  select count(*) filter(where status in ('queued','sending')),count(*) filter(where status='failed' and attempts>=5)
  into v_queued,v_failed from private.pass_email_outbox;
  select exists(select 1 from cron.job where jobname='amfcc-pass-email-worker' and active) into v_schedule_ready;
  return jsonb_build_object(
    'status','success','enabled',v_settings.enabled,'from_email',v_settings.from_email,
    'admin_emails',to_jsonb(v_settings.admin_emails),'management_emails',to_jsonb(v_settings.management_emails),
    'student_leadership_emails',to_jsonb(v_settings.student_leadership_emails),
    'queued_count',v_queued,'failed_count',v_failed,'automatic_dispatch_ready',v_schedule_ready,
    'updated_at',v_settings.updated_at
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_set_conference(p_session_token text, p_enabled boolean, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_previous boolean:=private.conference_mode();
  v_enabled boolean:=coalesce(p_enabled,false);
begin
  select * into v_context
  from private.system_session_context(p_session_token,array['administrator','it_admin']);
  if not found then
    return jsonb_build_object('status','unauthorized','message','Your control session has ended.');
  end if;
  if nullif(trim(coalesce(p_actor_name,'')),'') is null then
    return jsonb_build_object('status','invalid','message','Enter your name for the audit record.');
  end if;

  if not v_previous and v_enabled then
    update public.ops_tasks
    set metadata=coalesce(metadata,'{}'::jsonb) || jsonb_build_object(
          'pre_conference_task_type',task_type,
          'pre_conference_priority',priority,
          'conference_mode',true
        ),
        task_type='emergency',
        priority='critical',
        updated_at=now()
    where status not in ('done','cancelled');
  elsif v_previous and not v_enabled then
    update public.ops_tasks
    set task_type=coalesce(nullif(metadata->>'pre_conference_task_type',''),task_type),
        priority=coalesce(nullif(metadata->>'pre_conference_priority',''),priority),
        metadata=coalesce(metadata,'{}'::jsonb)
          -'pre_conference_task_type'-'pre_conference_priority'-'conference_mode',
        updated_at=now()
    where status not in ('done','cancelled')
      and metadata ? 'pre_conference_task_type';
  end if;

  insert into public.system_settings(setting_key,setting_value,description,updated_at)
  values(
    'conference_mode',to_jsonb(v_enabled),
    'Conference overlay. Works alongside School Term or Holiday Mode.',now()
  )
  on conflict(setting_key) do update
    set setting_value=excluded.setting_value,
        description=excluded.description,
        updated_at=excluded.updated_at;

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values(
    'settings','system_setting','conference_mode',v_context.role_key,'conference_mode_changed',
    jsonb_build_object('from',v_previous,'to',v_enabled,'actor_name',trim(p_actor_name),
      'base_mode',private.school_operating_mode())
  );

  return jsonb_build_object(
    'status','success','conference_mode',v_enabled,
    'previous_conference_mode',v_previous,'base_mode',private.school_operating_mode()
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_set_meal_features(p_session_token text, p_check_in_enabled boolean, p_collection_enabled boolean, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record;
begin
  select * into v_context from private.system_session_context(p_session_token,array['it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','IT Administration access is required.'); end if;
  if nullif(btrim(coalesce(p_actor_name,'')),'') is null then return jsonb_build_object('status','invalid','message','Enter your name for the audit record.'); end if;
  return private.set_meal_features(p_check_in_enabled,p_collection_enabled,v_context.role_key,p_actor_name);
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_set_mode(p_session_token text, p_mode text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_mode text:=lower(trim(coalesce(p_mode,'')));
  v_previous text:=private.school_operating_mode();
begin
  select * into v_context
  from private.system_session_context(p_session_token,array['administrator','it_admin']);
  if not found then
    return jsonb_build_object('status','unauthorized','message','Your control session has ended.');
  end if;
  if v_mode not in ('normal','holiday') then
    return jsonb_build_object('status','invalid','message','Choose School Term or Holiday Mode.');
  end if;
  if nullif(trim(coalesce(p_actor_name,'')),'') is null then
    return jsonb_build_object('status','invalid','message','Enter your name for the audit record.');
  end if;

  insert into public.system_settings(setting_key,setting_value,description,updated_at)
  values(
    'school_operating_mode',to_jsonb(v_mode),
    'Base school calendar mode: normal (School Term) or holiday.',now()
  )
  on conflict(setting_key) do update
    set setting_value=excluded.setting_value,
        description=excluded.description,
        updated_at=excluded.updated_at;

  insert into public.system_settings(setting_key,setting_value,description,updated_at)
  values('school_holiday_mode',to_jsonb(v_mode='holiday'),'Backward-compatible Holiday Mode flag.',now())
  on conflict(setting_key) do update
    set setting_value=excluded.setting_value,
        description=excluded.description,
        updated_at=excluded.updated_at;

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values(
    'settings','system_setting','school_operating_mode',v_context.role_key,'base_mode_changed',
    jsonb_build_object('from',v_previous,'to',v_mode,'actor_name',trim(p_actor_name))
  );

  return jsonb_build_object(
    'status','success','mode',v_mode,'base_mode',v_mode,
    'previous_mode',v_previous,'conference_mode',private.conference_mode()
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_set_pin(p_session_token text, p_target_type text, p_target_key text, p_new_pin text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'extensions', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_department_id uuid;
  v_label text;
begin
  select * into v_context
  from private.system_session_context(p_session_token,array['it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','IT Administrator access is required.'); end if;
  if coalesce(p_new_pin,'') !~ '^[0-9]{4}$' then
    return jsonb_build_object('status','invalid','message','Enter exactly four digits.');
  end if;
  if nullif(trim(coalesce(p_actor_name,'')),'') is null then
    return jsonb_build_object('status','invalid','message','Enter your name for the audit record.');
  end if;

  if p_target_type='role' then
    update public.system_access_credentials
    set access_hash=extensions.crypt(p_new_pin,extensions.gen_salt('bf',10)),
        active=true,must_change_pin=false,failed_attempts=0,locked_until=null,
        pin_changed_at=now(),updated_at=now(),updated_by_role='it_admin'
    where role_key=p_target_key
    returning role_label into v_label;
    if not found then return jsonb_build_object('status','not_found','message','Access role not found.'); end if;
  elsif p_target_type='department' then
    begin v_department_id:=p_target_key::uuid;
    exception when others then return jsonb_build_object('status','invalid','message','Department identifier is not valid.'); end;
    select name into v_label
    from public.ops_departments
    where id=v_department_id and active and workspace_enabled;
    if not found then return jsonb_build_object('status','not_found','message','Department workspace not found.'); end if;
    insert into public.ops_department_credentials(
      department_id,access_hash,failed_attempts,locked_until,updated_by_role,updated_at
    ) values(
      v_department_id,extensions.crypt(p_new_pin,extensions.gen_salt('bf',10)),0,null,'it_admin',now()
    ) on conflict(department_id) do update
      set access_hash=excluded.access_hash,failed_attempts=0,locked_until=null,
          updated_by_role='it_admin',updated_at=now();
  else
    return jsonb_build_object('status','invalid','message','Choose a role or department PIN.');
  end if;

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('access',p_target_type,p_target_key,'it_admin','pin_changed',
    jsonb_build_object('target_label',v_label,'actor_name',trim(p_actor_name)));

  return jsonb_build_object('status','success','target_type',p_target_type,
    'target_key',p_target_key,'target_label',v_label);
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_set_pin_v2(p_session_token text, p_target_type text, p_target_key text, p_new_pin text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_result jsonb;
begin
  v_result:=public.system_control_set_pin(p_session_token,p_target_type,p_target_key,p_new_pin,p_actor_name);
  if v_result->>'status'='success' then
    perform private.system_store_recoverable_pin(p_target_type,p_target_key,p_new_pin);
  end if;
  return v_result;
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_update_pass_email_settings(p_session_token text, p_enabled boolean, p_admin_emails text[], p_management_emails text[], p_student_leadership_emails text[], p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_admin text[]:=private.pass_normalize_email_list(p_admin_emails);
  v_management text[]:=private.pass_normalize_email_list(p_management_emails);
  v_leadership text[]:=private.pass_normalize_email_list(p_student_leadership_emails);
  v_bad_email text;
begin
  select * into v_context from private.system_session_context(p_session_token,array['it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','IT Administrator access is required.'); end if;
  if nullif(trim(coalesce(p_actor_name,'')),'') is null then return jsonb_build_object('status','invalid','message','Enter your name for the audit record.'); end if;
  if cardinality(v_admin)>20 or cardinality(v_management)>20 or cardinality(v_leadership)>20 then
    return jsonb_build_object('status','invalid','message','Use no more than 20 recipients in each group.');
  end if;
  select email into v_bad_email from unnest(v_admin||v_management||v_leadership) as e(email)
  where length(email)>254 or email !~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$' limit 1;
  if found then return jsonb_build_object('status','invalid','message','Check this email address: '||v_bad_email); end if;
  if coalesce(p_enabled,false) and (cardinality(v_admin)=0 or cardinality(v_management)=0 or cardinality(v_leadership)=0) then
    return jsonb_build_object('status','invalid','message','Add at least one School Administration, Management, and Student Leadership recipient before enabling email.');
  end if;
  update private.pass_email_settings set enabled=coalesce(p_enabled,false),from_email='it@amfcc.ac.zw',
    admin_emails=v_admin,management_emails=v_management,student_leadership_emails=v_leadership,
    updated_at=now(),updated_by=trim(p_actor_name) where singleton=true;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('settings','pass_email','global','it_admin','pass_email_settings_updated',jsonb_build_object(
    'actor_name',trim(p_actor_name),'enabled',coalesce(p_enabled,false),'from_email','it@amfcc.ac.zw',
    'admin_recipient_count',cardinality(v_admin),'management_recipient_count',cardinality(v_management),
    'student_leadership_recipient_count',cardinality(v_leadership)
  ));
  return jsonb_build_object('status','success','enabled',coalesce(p_enabled,false),'from_email','it@amfcc.ac.zw',
    'admin_recipient_count',cardinality(v_admin),'management_recipient_count',cardinality(v_management),
    'student_leadership_recipient_count',cardinality(v_leadership));
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_update_pass_email_settings(p_session_token text, p_enabled boolean, p_admin_emails text[], p_student_leadership_emails text[], p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_management text[];
begin
  select management_emails into v_management from private.pass_email_settings where singleton=true;
  return public.system_control_update_pass_email_settings(
    p_session_token,p_enabled,p_admin_emails,coalesce(v_management,'{}'::text[]),p_student_leadership_emails,p_actor_name
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_update_setting(p_session_token text, p_setting_key text, p_setting_value jsonb, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare v_context record;
begin
  select * into v_context
  from private.system_session_context(p_session_token,array['administrator','it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','Your control session has ended.'); end if;
  if nullif(trim(coalesce(p_actor_name,'')),'') is null then
    return jsonb_build_object('status','invalid','message','Enter your name for the audit record.');
  end if;
  if p_setting_key not in (
    'gate_pass_pilot_mode','gate_pass_pilot_started_at','gate_pass_pilot_ends_at',
    'gate_terminal_result_seconds','school_timezone'
  ) then
    return jsonb_build_object('status','invalid','message','This setting is managed somewhere else.');
  end if;
  if p_setting_key='gate_terminal_result_seconds'
     and ((p_setting_value #>> '{}')::numeric<1 or (p_setting_value #>> '{}')::numeric>10) then
    return jsonb_build_object('status','invalid','message','Kiosk result duration must be between 1 and 10 seconds.');
  end if;
  if p_setting_key='school_timezone'
     and not exists(select 1 from pg_timezone_names where name=p_setting_value #>> '{}') then
    return jsonb_build_object('status','invalid','message','Choose a valid database time zone.');
  end if;

  insert into public.system_settings(setting_key,setting_value,updated_at)
  values(p_setting_key,p_setting_value,now())
  on conflict(setting_key) do update set setting_value=excluded.setting_value,updated_at=excluded.updated_at;

  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('settings','system_setting',p_setting_key,v_context.role_key,'updated',
    jsonb_build_object('value',p_setting_value,'actor_name',trim(p_actor_name)));

  return jsonb_build_object('status','success','setting_key',p_setting_key,'setting_value',p_setting_value);
exception when others then
  return jsonb_build_object('status','invalid','message','The setting value is not valid.');
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_control_view_pin(p_session_token text, p_target_type text, p_target_key text, p_actor_name text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'private', 'vault', 'extensions', 'pg_catalog'
AS $function$
declare
  v_context record;
  v_key text;
  v_pin text;
  v_label text;
begin
  select * into v_context from private.system_session_context(p_session_token,array['it_admin']);
  if not found then return jsonb_build_object('status','unauthorized','message','IT Administrator access is required.'); end if;
  if not exists(select 1 from public.students where is_active and full_name=p_actor_name) then
    return jsonb_build_object('status','invalid','message','Choose your exact name from the database lookup.');
  end if;
  select decrypted_secret into v_key from vault.decrypted_secrets where name='amfcc_pin_recovery_key' limit 1;
  select extensions.pgp_sym_decrypt(r.encrypted_pin,v_key) into v_pin
  from private.system_pin_recovery r where r.target_type=p_target_type and r.target_key=p_target_key;
  if v_pin is null then
    return jsonb_build_object('status','not_available','message','This PIN was created before secure viewing was enabled. Reset it once to make it viewable.');
  end if;
  if p_target_type='role' then
    select role_label into v_label from public.system_access_credentials where role_key=p_target_key;
  elsif p_target_type='department' then
    select name into v_label from public.ops_departments where id=p_target_key::uuid;
  end if;
  insert into public.audit_log(event_type,entity_type,entity_id,actor_role,action,details)
  values('access',p_target_type,p_target_key,'it_admin','pin_viewed',jsonb_build_object(
    'target_label',coalesce(v_label,p_target_key),'actor_name',p_actor_name
  ));
  return jsonb_build_object('status','success','target_label',coalesce(v_label,p_target_key),'pin',v_pin);
end
$function$
;

CREATE OR REPLACE FUNCTION public.system_mode_status()
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'private', 'pg_catalog'
AS $function$
declare
  v_base text:=private.school_operating_mode();
  v_conference boolean:=private.conference_mode();
  v_base_label text;
  v_check_in boolean:=private.meal_feature_enabled('meal_check_in_enabled');
  v_collection boolean:=private.meal_feature_enabled('meal_collection_enabled');
begin
  v_base_label:=case v_base when 'holiday' then 'Holiday Mode' else 'School Term Mode' end;
  return jsonb_build_object(
    'status','success','mode',v_base,'base_mode',v_base,'label',v_base_label,'base_label',v_base_label,
    'combined_label',v_base_label||case when v_conference then ' + Conference Mode' else '' end,
    'holiday_mode',v_base='holiday','conference_mode',v_conference,
    'meal_deadlines_enabled',not v_conference,
    'meal_check_in_switch',v_check_in,'meal_collection_switch',v_collection,
    'meal_check_in_enabled',v_check_in and not v_conference and v_base<>'holiday',
    'meal_collection_enabled',v_collection and not v_conference,
    'manual_work_sessions_enabled',not v_conference,'tasks_are_emergencies',v_conference
  );
end
$function$
;

CREATE OR REPLACE FUNCTION public.term_registration_accommodation_list(p_pin text, p_term_id bigint DEFAULT NULL::bigint)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_accommodation_list(p_pin,p_term_id) $function$
;

CREATE OR REPLACE FUNCTION public.term_registration_update_accommodation(p_pin text, p_registration_id uuid, p_off_campus boolean, p_residence text DEFAULT NULL::text, p_room text DEFAULT NULL::text, p_bed text DEFAULT NULL::text, p_mark_complete boolean DEFAULT false)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_update_accommodation(p_pin,p_registration_id,p_off_campus,p_residence,p_room,p_bed,p_mark_complete) $function$
;

CREATE OR REPLACE FUNCTION public.term_registration_update_accommodation_v2(p_pin text, p_registration_id uuid, p_off_campus boolean, p_residence text DEFAULT NULL::text, p_room text DEFAULT NULL::text, p_bed text DEFAULT NULL::text, p_mark_complete boolean DEFAULT false, p_accommodation_answers jsonb DEFAULT '{}'::jsonb)
 RETURNS jsonb
 LANGUAGE sql
 SET search_path TO 'private', 'pg_catalog'
AS $function$ select private.tr_update_accommodation_v2(p_pin,p_registration_id,p_off_campus,p_residence,p_room,p_bed,p_mark_complete,p_accommodation_answers) $function$
;