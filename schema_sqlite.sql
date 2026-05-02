-- SQLite Schema (auto-generated from DbGate HTML)

PRAGMA foreign_keys = ON;


CREATE TABLE IF NOT EXISTS "addresses" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "customer_profile_id" INTEGER NOT NULL,
  "address_name" TEXT NOT NULL,
  "country" INTEGER NOT NULL,
  "city" TEXT NOT NULL,
  "post_code" TEXT NOT NULL,
  "detail" TEXT,
  "lat" REAL,
  "lon" REAL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "active" INTEGER DEFAULT 0
);


CREATE TABLE IF NOT EXISTS "users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "email" TEXT NOT NULL,
  "name" TEXT,
  "avatar_url" TEXT,
  "post_code" TEXT,
  "phone" TEXT,
  "password_hash" TEXT NOT NULL,
  "role" TEXT NOT NULL,
  "email_verified" INTEGER DEFAULT 0,
  "email_verification_token" TEXT,
  "password_reset_token" TEXT,
  "password_reset_expires_at" TEXT,
  "password_reset_code" TEXT,
  "password_reset_code_expires_at" TEXT,
  "password_reset_code_attempts" TEXT,
  "two_factor_secret" TEXT,
  "two_factor_enabled" INTEGER DEFAULT 0,
  "preferred_language" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "refresh_tokens" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL,
  "token" TEXT NOT NULL,
  "expires_at" TEXT NOT NULL,
  "user_agent" TEXT,
  "ip" TEXT,
  "revoked" INTEGER DEFAULT 0,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "restaurant_types" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "description" TEXT,
  "active" INTEGER DEFAULT 0 NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "driver_locations" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "driver_user_id" INTEGER NOT NULL,
  "lat" REAL NOT NULL,
  "lon" REAL NOT NULL,
  "accuracy" REAL,
  "heading" REAL,
  "speed" REAL,
  "timestamp" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "notifications" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "role" TEXT,
  "title" TEXT NOT NULL,
  "message" TEXT NOT NULL,
  "type" TEXT NOT NULL,
  "data" TEXT,
  "read_at" TEXT,
  "created_by" INTEGER,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "customer_profiles" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL,
  "legal_name" TEXT,
  "tax_no" REAL,
  "business_type" TEXT NOT NULL,
  "active" INTEGER DEFAULT 0 NOT NULL,
  "waste_oil_solid_price" REAL NOT NULL,
  "waste_oil_liquid_price" REAL NOT NULL,
  "restaurant_type_id" INTEGER,
  "total_postponements" REAL NOT NULL,
  "consecutive_postponements" TEXT NOT NULL,
  "last_postponement_date" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "external_id" INTEGER,
  "is_wholesale" INTEGER DEFAULT 0 NOT NULL,
  "referred_by_user_id" INTEGER,
  "referred_at" TEXT,
  "avg_waste_percent" REAL NOT NULL,
  "total_waste_records" REAL NOT NULL,
  "last_waste_percent" REAL,
  "customer_no" TEXT,
  "last_order_at" TEXT
);


CREATE TABLE IF NOT EXISTS "recurring_orders" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "customer_profile_id" INTEGER NOT NULL,
  "address_id" INTEGER NOT NULL,
  "service_address_id" INTEGER,
  "billing_address_id" INTEGER,
  "freq" TEXT NOT NULL,
  "interval" TEXT NOT NULL,
  "by_day" TEXT,
  "start_date" TEXT NOT NULL,
  "next_run_at" TEXT,
  "active" INTEGER DEFAULT 0 NOT NULL,
  "default_driver_user_id" INTEGER,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "type" TEXT
);


CREATE TABLE IF NOT EXISTS "customer_barrels" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "customer_profile_id" INTEGER NOT NULL,
  "barrel_id" INTEGER NOT NULL,
  "quantity" INTEGER NOT NULL,
  "notes" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "barrels" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "type" TEXT NOT NULL,
  "capacity" TEXT NOT NULL,
  "description" TEXT,
  "active" INTEGER DEFAULT 0 NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "company_settings" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "company_name" TEXT NOT NULL,
  "address" TEXT NOT NULL,
  "city" TEXT NOT NULL,
  "postal_code" TEXT NOT NULL,
  "tax_number" REAL NOT NULL,
  "phone" TEXT,
  "email" TEXT,
  "logo_url" TEXT,
  "custom_fields" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "system_config" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "key" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  "description" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "audit_logs" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "actor_id" INTEGER,
  "actor_name" TEXT,
  "actor_avatar_url" TEXT,
  "action_type" TEXT,
  "action_description" TEXT,
  "method" TEXT NOT NULL,
  "path" TEXT NOT NULL,
  "status_code" TEXT NOT NULL,
  "request_body" TEXT,
  "response_body" TEXT,
  "ip" TEXT,
  "user_agent" TEXT,
  "entity_type" TEXT,
  "entity_id" INTEGER,
  "diff" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "client_logs" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "message" TEXT NOT NULL,
  "stack" TEXT,
  "browser_info" TEXT,
  "user_id" INTEGER,
  "url" TEXT,
  "metadata" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "invoices" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" INTEGER NOT NULL,
  "customer_profile_id" INTEGER NOT NULL,
  "number" INTEGER NOT NULL,
  "currency" TEXT NOT NULL,
  "subtotal" REAL NOT NULL,
  "tax_rate" REAL NOT NULL,
  "tax_total" REAL NOT NULL,
  "grand_total" REAL NOT NULL,
  "status" TEXT NOT NULL,
  "issued_at" TEXT,
  "due_date" TEXT,
  "sent_at" TEXT,
  "paid_at" TEXT,
  "template_id" INTEGER,
  "template_version" REAL,
  "pdf_path" TEXT,
  "pdf_hash" TEXT,
  "signature_data" TEXT,
  "meta" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "driver_push_tokens" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "driver_user_id" INTEGER NOT NULL,
  "expo_push_token" TEXT NOT NULL,
  "platform" REAL NOT NULL,
  "device_name" TEXT,
  "os_version" INTEGER,
  "is_active" INTEGER DEFAULT 0,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "driver_routes" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "driver_user_id" INTEGER NOT NULL,
  "date" TEXT NOT NULL,
  "start_point_lat" REAL,
  "start_point_lon" REAL,
  "end_point_lat" REAL,
  "end_point_lon" REAL,
  "route_data" TEXT,
  "status" TEXT NOT NULL,
  "statistics" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "barrel_exchanges" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "order_id" INTEGER NOT NULL,
  "driver_user_id" INTEGER NOT NULL,
  "barrel_id" INTEGER NOT NULL,
  "action" TEXT NOT NULL,
  "quantity" INTEGER NOT NULL,
  "volume_liters" REAL,
  "notes" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "dashboard_metrics" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "date" TEXT NOT NULL,
  "metric_type" TEXT NOT NULL,
  "total_customers" REAL,
  "active_orders" INTEGER DEFAULT 0,
  "today_deliveries" TEXT,
  "active_drivers" INTEGER DEFAULT 0,
  "order_status_distribution" TEXT,
  "monthly_revenue" REAL,
  "month" TEXT,
  "year" TEXT,
  "system_alerts" TEXT,
  "total_revenue" REAL,
  "average_revenue" REAL,
  "revenue_growth" REAL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "invoice_templates" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "html_content" TEXT NOT NULL,
  "version" INTEGER NOT NULL,
  "is_active" INTEGER DEFAULT 0,
  "variables" TEXT,
  "metadata" TEXT,
  "created_by" INTEGER NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "type" TEXT
);


CREATE TABLE IF NOT EXISTS "email_templates" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "subject" TEXT NOT NULL,
  "html_content" TEXT NOT NULL,
  "version" INTEGER NOT NULL,
  "is_active" INTEGER DEFAULT 0,
  "type" TEXT,
  "variables" TEXT,
  "metadata" TEXT,
  "created_by" INTEGER NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "admin_export_configs" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "report_type" TEXT NOT NULL,
  "fields" TEXT NOT NULL,
  "active" INTEGER DEFAULT 0 NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "field_order" TEXT
);


CREATE TABLE IF NOT EXISTS "usage_quotas" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "channel" TEXT NOT NULL,
  "provider" TEXT,
  "kind" TEXT,
  "period" TEXT NOT NULL,
  "limit_count" INTEGER NOT NULL,
  "warn_at_percent" TEXT NOT NULL,
  "enabled" INTEGER DEFAULT 0 NOT NULL,
  "notify_roles" TEXT NOT NULL,
  "label" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "prospects" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "legal_name" TEXT,
  "business_type" TEXT NOT NULL,
  "restaurant_type_id" INTEGER,
  "phone" TEXT,
  "email" TEXT,
  "website" TEXT,
  "address_text" TEXT,
  "post_code" TEXT,
  "lat" REAL NOT NULL,
  "lon" REAL NOT NULL,
  "external_source" TEXT NOT NULL,
  "pinned" INTEGER DEFAULT 0 NOT NULL,
  "pinned_at" TEXT,
  "pinned_by_user_id" INTEGER,
  "external_id" INTEGER,
  "import_batch_id" INTEGER,
  "notes" TEXT,
  "status" TEXT NOT NULL,
  "next_eligible_at" TEXT,
  "last_visit_at" TEXT,
  "visit_count" INTEGER NOT NULL,
  "score" REAL NOT NULL,
  "created_by_user_id" INTEGER,
  "merged_into_customer_profile_id" INTEGER,
  "source_customer_profile_id" INTEGER,
  "previous_status" TEXT,
  "dedupe_key" TEXT,
  "deleted_at" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "route_prospect_stops" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "route_id" INTEGER NOT NULL,
  "prospect_id" INTEGER NOT NULL,
  "sequence_number" INTEGER NOT NULL,
  "stop_status" TEXT NOT NULL,
  "arrived_at" TEXT,
  "departed_at" TEXT,
  "injection_mode" TEXT NOT NULL,
  "injection_score" REAL,
  "injection_score_breakdown" REAL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "prospect_import_batches" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "file_name" TEXT NOT NULL,
  "uploaded_by_user_id" INTEGER NOT NULL,
  "total_rows" REAL NOT NULL,
  "imported_count" INTEGER NOT NULL,
  "duplicate_pending_count" INTEGER NOT NULL,
  "skipped_count" INTEGER NOT NULL,
  "error_count" INTEGER NOT NULL,
  "column_mapping" TEXT,
  "errors" TEXT,
  "status" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "prospect_duplicate_reviews" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "import_batch_id" INTEGER,
  "incoming_data" INTEGER NOT NULL,
  "match_type" TEXT NOT NULL,
  "matched_customer_profile_id" INTEGER,
  "matched_prospect_id" INTEGER,
  "pending_prospect_id" INTEGER,
  "match_reasons" TEXT,
  "confidence" TEXT NOT NULL,
  "decision" TEXT NOT NULL,
  "merged_fields" TEXT,
  "decided_by_user_id" INTEGER,
  "decided_at" TEXT,
  "created_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "driver_profiles" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER NOT NULL,
  "license_no" TEXT,
  "vehicle_plate" REAL,
  "active" INTEGER DEFAULT 0 NOT NULL,
  "home_lat" REAL,
  "home_lon" REAL,
  "home_address" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "prospects_auto_inject_enabled" INTEGER DEFAULT 0,
  "max_prospects_per_route" INTEGER,
  "prospect_stats_cache" TEXT
);


CREATE TABLE IF NOT EXISTS "driver_incentives" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "driver_user_id" INTEGER NOT NULL,
  "type" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "target_value" TEXT NOT NULL,
  "current_value" TEXT NOT NULL,
  "reward_amount" REAL,
  "status" TEXT NOT NULL,
  "period" TEXT,
  "period_start" TEXT,
  "period_end" TEXT,
  "metadata" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "source_prospect_id" INTEGER
);


CREATE TABLE IF NOT EXISTS "driver_reports" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "customer_profile_id" INTEGER NOT NULL,
  "driver_user_id" INTEGER NOT NULL,
  "order_id" INTEGER,
  "recurring_order_id" INTEGER,
  "reason" TEXT NOT NULL,
  "notes" TEXT,
  "status" TEXT NOT NULL,
  "resolved_by" INTEGER,
  "resolved_at" TEXT,
  "resolution_notes" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "prospect_visits" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "prospect_id" INTEGER NOT NULL,
  "driver_user_id" INTEGER NOT NULL,
  "route_id" INTEGER,
  "route_stop_id" INTEGER,
  "visited_at" TEXT NOT NULL,
  "outcome" TEXT NOT NULL,
  "rejection_reason" TEXT,
  "notes" TEXT,
  "contact_phone" TEXT,
  "contact_name" TEXT,
  "estimated_volume" REAL,
  "frequency" TEXT,
  "lat" REAL,
  "lon" REAL,
  "gps_available" INTEGER DEFAULT 0 NOT NULL,
  "location_verified" INTEGER DEFAULT 0 NOT NULL,
  "location_distance_meters" TEXT,
  "photo_url" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "quoted_price_solid" REAL,
  "quoted_price_liquid" REAL,
  "quoted_currency" TEXT NOT NULL,
  "quote_notes" TEXT
);


CREATE TABLE IF NOT EXISTS "system_jobs" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "job_type" TEXT NOT NULL,
  "status" TEXT NOT NULL,
  "source" TEXT,
  "started_at" TEXT,
  "finished_at" TEXT,
  "duration_ms" INTEGER,
  "attempt_count" INTEGER NOT NULL,
  "max_attempts" TEXT NOT NULL,
  "error_message" TEXT,
  "metadata" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "system_action_logs" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "job_id" INTEGER,
  "entity_type" TEXT,
  "entity_id" INTEGER,
  "action_type" TEXT NOT NULL,
  "channel" TEXT,
  "status" TEXT NOT NULL,
  "triggered_by" TEXT NOT NULL,
  "triggered_by_user_id" INTEGER,
  "target_email" TEXT,
  "target_phone" TEXT,
  "message" TEXT,
  "metadata" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "system_health_events" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "severity" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "status" TEXT NOT NULL,
  "title" TEXT NOT NULL,
  "message" TEXT,
  "entity_type" TEXT,
  "entity_id" INTEGER,
  "job_id" INTEGER,
  "fingerprint" TEXT NOT NULL,
  "occurrence_count" INTEGER NOT NULL,
  "first_seen_at" TEXT NOT NULL,
  "last_seen_at" TEXT NOT NULL,
  "resolved_at" TEXT,
  "resolved_by_user_id" INTEGER,
  "metadata" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "orders" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "customer_profile_id" INTEGER NOT NULL,
  "address_id" INTEGER NOT NULL,
  "service_address_id" INTEGER,
  "billing_address_id" INTEGER,
  "assigned_driver_user_id" INTEGER,
  "source_recurring_id" INTEGER,
  "route_id" INTEGER,
  "status" TEXT NOT NULL,
  "scheduled_at" TEXT,
  "completed_at" TEXT,
  "volume_liters_solid" REAL,
  "volume_liters_liquid" REAL,
  "notes" TEXT,
  "postponed_to" TEXT,
  "postpone_history" TEXT,
  "payment_method" TEXT,
  "payment_amount" REAL,
  "payment_reference" TEXT,
  "payment_notes" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "started_at" TEXT,
  "type" TEXT,
  "wholesale_kg" REAL,
  "wholesale_lt" REAL,
  "ffa" TEXT,
  "m_i" TEXT,
  "scale_document_url" TEXT,
  "lab_document_url" TEXT,
  "supplier_signature_url" TEXT,
  "transfer_note_number" INTEGER,
  "transfer_note_issued_at" TEXT,
  "transfer_note_pdf_path" TEXT,
  "waste_percent" REAL,
  "net_volume_solid" REAL,
  "net_volume_liquid" REAL,
  "waste_notes" TEXT,
  "waste_recorded_at" TEXT,
  "waste_recorded_by" TEXT,
  "received_volume_solid" REAL,
  "received_volume_liquid" REAL,
  "waste_amount_solid" REAL,
  "waste_amount_liquid" REAL,
  "driver_instructions" TEXT,
  "driver_alert_type" TEXT
);


CREATE TABLE IF NOT EXISTS "usage_logs" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "channel" TEXT NOT NULL,
  "provider" TEXT NOT NULL,
  "status" TEXT NOT NULL,
  "recipient" TEXT NOT NULL,
  "subject" TEXT,
  "kind" TEXT,
  "user_id" INTEGER,
  "user_role" TEXT,
  "cost_units" TEXT NOT NULL,
  "error_message" TEXT,
  "meta" TEXT,
  "sent_at" TEXT NOT NULL,
  "created_at" TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS "route_order_sequences" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "route_id" INTEGER NOT NULL,
  "order_id" INTEGER NOT NULL,
  "sequence_number" INTEGER NOT NULL,
  "estimated_arrival_time" TEXT,
  "actual_arrival_time" TEXT,
  "stop_status" TEXT NOT NULL,
  "arrived_at" TEXT,
  "departed_at" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL
);
