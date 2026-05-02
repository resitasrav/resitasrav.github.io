-- MySQL Schema (auto-generated from DbGate HTML)

SET FOREIGN_KEY_CHECKS=0;


CREATE TABLE IF NOT EXISTS `addresses` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `customer_profile_id` BIGINT UNSIGNED NOT NULL,
  `address_name` VARCHAR(255) NOT NULL,
  `country` INT NOT NULL,
  `city` TEXT NOT NULL,
  `post_code` VARCHAR(255) NOT NULL,
  `detail` TEXT,
  `lat` DECIMAL(12,4),
  `lon` DECIMAL(12,4),
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `active` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `users` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255),
  `avatar_url` VARCHAR(255),
  `post_code` VARCHAR(255),
  `phone` VARCHAR(255),
  `password_hash` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `email_verified` TINYINT(1) DEFAULT 0,
  `email_verification_token` VARCHAR(255),
  `password_reset_token` VARCHAR(255),
  `password_reset_expires_at` DATETIME,
  `password_reset_code` VARCHAR(255),
  `password_reset_code_expires_at` DATETIME,
  `password_reset_code_attempts` DATETIME,
  `two_factor_secret` TEXT,
  `two_factor_enabled` TINYINT(1) DEFAULT 0,
  `preferred_language` TEXT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `refresh_tokens` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `expires_at` DATETIME NOT NULL,
  `user_agent` VARCHAR(255),
  `ip` TEXT,
  `revoked` TINYINT(1) DEFAULT 0,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `restaurant_types` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` JSON,
  `active` TINYINT(1) DEFAULT 0 NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `driver_locations` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `driver_user_id` BIGINT UNSIGNED NOT NULL,
  `lat` DECIMAL(12,4) NOT NULL,
  `lon` DECIMAL(12,4) NOT NULL,
  `accuracy` DECIMAL(12,4),
  `heading` DECIMAL(12,4),
  `speed` DECIMAL(12,4),
  `timestamp` DATETIME NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `notifications` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `user_id` BIGINT UNSIGNED,
  `role` VARCHAR(255),
  `title` VARCHAR(255) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `data` JSON,
  `read_at` DATETIME,
  `created_by` BIGINT UNSIGNED,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `customer_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `legal_name` VARCHAR(255),
  `tax_no` DECIMAL(12,4),
  `business_type` VARCHAR(255) NOT NULL,
  `active` TINYINT(1) DEFAULT 0 NOT NULL,
  `waste_oil_solid_price` DECIMAL(12,4) NOT NULL,
  `waste_oil_liquid_price` DECIMAL(12,4) NOT NULL,
  `restaurant_type_id` BIGINT UNSIGNED,
  `total_postponements` DECIMAL(12,4) NOT NULL,
  `consecutive_postponements` TEXT NOT NULL,
  `last_postponement_date` DATETIME,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `external_id` BIGINT UNSIGNED,
  `is_wholesale` TINYINT(1) DEFAULT 0 NOT NULL,
  `referred_by_user_id` BIGINT UNSIGNED,
  `referred_at` DATETIME,
  `avg_waste_percent` DECIMAL(12,4) NOT NULL,
  `total_waste_records` DECIMAL(12,4) NOT NULL,
  `last_waste_percent` DECIMAL(12,4),
  `customer_no` JSON,
  `last_order_at` DATETIME,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `recurring_orders` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `customer_profile_id` BIGINT UNSIGNED NOT NULL,
  `address_id` BIGINT UNSIGNED NOT NULL,
  `service_address_id` BIGINT UNSIGNED,
  `billing_address_id` BIGINT UNSIGNED,
  `freq` TEXT NOT NULL,
  `interval` TEXT NOT NULL,
  `by_day` TEXT,
  `start_date` DATETIME NOT NULL,
  `next_run_at` DATETIME,
  `active` TINYINT(1) DEFAULT 0 NOT NULL,
  `default_driver_user_id` BIGINT UNSIGNED,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `type` VARCHAR(255),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `customer_barrels` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `customer_profile_id` BIGINT UNSIGNED NOT NULL,
  `barrel_id` BIGINT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL,
  `notes` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `barrels` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `capacity` TEXT NOT NULL,
  `description` JSON,
  `active` TINYINT(1) DEFAULT 0 NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `company_settings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `company_name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `city` TEXT NOT NULL,
  `postal_code` VARCHAR(255) NOT NULL,
  `tax_number` DECIMAL(12,4) NOT NULL,
  `phone` VARCHAR(255),
  `email` VARCHAR(255),
  `logo_url` VARCHAR(255),
  `custom_fields` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `system_config` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `key` VARCHAR(255) NOT NULL,
  `value` VARCHAR(255) NOT NULL,
  `description` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `audit_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `actor_id` BIGINT UNSIGNED,
  `actor_name` VARCHAR(255),
  `actor_avatar_url` VARCHAR(255),
  `action_type` VARCHAR(255),
  `action_description` JSON,
  `method` VARCHAR(255) NOT NULL,
  `path` VARCHAR(255) NOT NULL,
  `status_code` VARCHAR(255) NOT NULL,
  `request_body` JSON,
  `response_body` JSON,
  `ip` TEXT,
  `user_agent` VARCHAR(255),
  `entity_type` VARCHAR(255),
  `entity_id` BIGINT UNSIGNED,
  `diff` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `client_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `stack` TEXT,
  `browser_info` TEXT,
  `user_id` BIGINT UNSIGNED,
  `url` VARCHAR(255),
  `metadata` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `invoices` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `customer_profile_id` BIGINT UNSIGNED NOT NULL,
  `number` INT NOT NULL,
  `currency` VARCHAR(255) NOT NULL,
  `subtotal` DECIMAL(12,4) NOT NULL,
  `tax_rate` DECIMAL(12,4) NOT NULL,
  `tax_total` DECIMAL(12,4) NOT NULL,
  `grand_total` DECIMAL(12,4) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `issued_at` DATETIME,
  `due_date` DATETIME,
  `sent_at` DATETIME,
  `paid_at` DATETIME,
  `template_id` BIGINT UNSIGNED,
  `template_version` DECIMAL(12,4),
  `pdf_path` VARCHAR(255),
  `pdf_hash` VARCHAR(255),
  `signature_data` JSON,
  `meta` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `driver_push_tokens` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `driver_user_id` BIGINT UNSIGNED NOT NULL,
  `expo_push_token` VARCHAR(255) NOT NULL,
  `platform` DECIMAL(12,4) NOT NULL,
  `device_name` VARCHAR(255),
  `os_version` INT,
  `is_active` TINYINT(1) DEFAULT 0,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `driver_routes` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `driver_user_id` BIGINT UNSIGNED NOT NULL,
  `date` TEXT NOT NULL,
  `start_point_lat` DECIMAL(12,4),
  `start_point_lon` DECIMAL(12,4),
  `end_point_lat` DECIMAL(12,4),
  `end_point_lon` DECIMAL(12,4),
  `route_data` JSON,
  `status` VARCHAR(255) NOT NULL,
  `statistics` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `barrel_exchanges` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `driver_user_id` BIGINT UNSIGNED NOT NULL,
  `barrel_id` BIGINT UNSIGNED NOT NULL,
  `action` VARCHAR(255) NOT NULL,
  `quantity` INT NOT NULL,
  `volume_liters` DECIMAL(12,4),
  `notes` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `dashboard_metrics` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `date` TEXT NOT NULL,
  `metric_type` VARCHAR(255) NOT NULL,
  `total_customers` DECIMAL(12,4),
  `active_orders` TINYINT(1) DEFAULT 0,
  `today_deliveries` TEXT,
  `active_drivers` TINYINT(1) DEFAULT 0,
  `order_status_distribution` VARCHAR(255),
  `monthly_revenue` DECIMAL(12,4),
  `month` TEXT,
  `year` TEXT,
  `system_alerts` TEXT,
  `total_revenue` DECIMAL(12,4),
  `average_revenue` DECIMAL(12,4),
  `revenue_growth` DECIMAL(12,4),
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `invoice_templates` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `html_content` JSON NOT NULL,
  `version` INT NOT NULL,
  `is_active` TINYINT(1) DEFAULT 0,
  `variables` JSON,
  `metadata` JSON,
  `created_by` BIGINT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `type` VARCHAR(255),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `email_templates` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `html_content` JSON NOT NULL,
  `version` INT NOT NULL,
  `is_active` TINYINT(1) DEFAULT 0,
  `type` VARCHAR(255),
  `variables` JSON,
  `metadata` JSON,
  `created_by` BIGINT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `admin_export_configs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `report_type` VARCHAR(255) NOT NULL,
  `fields` JSON NOT NULL,
  `active` TINYINT(1) DEFAULT 0 NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `field_order` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `usage_quotas` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `channel` VARCHAR(255) NOT NULL,
  `provider` VARCHAR(255),
  `kind` TEXT,
  `period` VARCHAR(255) NOT NULL,
  `limit_count` INT NOT NULL,
  `warn_at_percent` DATETIME NOT NULL,
  `enabled` TINYINT(1) DEFAULT 0 NOT NULL,
  `notify_roles` VARCHAR(255) NOT NULL,
  `label` TEXT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `prospects` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `legal_name` VARCHAR(255),
  `business_type` VARCHAR(255) NOT NULL,
  `restaurant_type_id` BIGINT UNSIGNED,
  `phone` VARCHAR(255),
  `email` VARCHAR(255),
  `website` TEXT,
  `address_text` VARCHAR(255),
  `post_code` VARCHAR(255),
  `lat` DECIMAL(12,4) NOT NULL,
  `lon` DECIMAL(12,4) NOT NULL,
  `external_source` VARCHAR(255) NOT NULL,
  `pinned` TINYINT(1) DEFAULT 0 NOT NULL,
  `pinned_at` DATETIME,
  `pinned_by_user_id` BIGINT UNSIGNED,
  `external_id` BIGINT UNSIGNED,
  `import_batch_id` BIGINT UNSIGNED,
  `notes` JSON,
  `status` VARCHAR(255) NOT NULL,
  `next_eligible_at` DATETIME,
  `last_visit_at` DATETIME,
  `visit_count` INT NOT NULL,
  `score` DECIMAL(12,4) NOT NULL,
  `created_by_user_id` BIGINT UNSIGNED,
  `merged_into_customer_profile_id` BIGINT UNSIGNED,
  `source_customer_profile_id` BIGINT UNSIGNED,
  `previous_status` VARCHAR(255),
  `dedupe_key` VARCHAR(255),
  `deleted_at` DATETIME,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `route_prospect_stops` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `route_id` BIGINT UNSIGNED NOT NULL,
  `prospect_id` BIGINT UNSIGNED NOT NULL,
  `sequence_number` INT NOT NULL,
  `stop_status` VARCHAR(255) NOT NULL,
  `arrived_at` DATETIME,
  `departed_at` DATETIME,
  `injection_mode` TEXT NOT NULL,
  `injection_score` DECIMAL(12,4),
  `injection_score_breakdown` DECIMAL(12,4),
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `prospect_import_batches` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `file_name` VARCHAR(255) NOT NULL,
  `uploaded_by_user_id` BIGINT UNSIGNED NOT NULL,
  `total_rows` DECIMAL(12,4) NOT NULL,
  `imported_count` INT NOT NULL,
  `duplicate_pending_count` INT NOT NULL,
  `skipped_count` INT NOT NULL,
  `error_count` INT NOT NULL,
  `column_mapping` JSON,
  `errors` JSON,
  `status` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `prospect_duplicate_reviews` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `import_batch_id` BIGINT UNSIGNED,
  `incoming_data` INT NOT NULL,
  `match_type` VARCHAR(255) NOT NULL,
  `matched_customer_profile_id` BIGINT UNSIGNED,
  `matched_prospect_id` BIGINT UNSIGNED,
  `pending_prospect_id` BIGINT UNSIGNED,
  `match_reasons` VARCHAR(255),
  `confidence` TEXT NOT NULL,
  `decision` VARCHAR(255) NOT NULL,
  `merged_fields` JSON,
  `decided_by_user_id` BIGINT UNSIGNED,
  `decided_at` DATETIME,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `driver_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `license_no` TEXT,
  `vehicle_plate` DECIMAL(12,4),
  `active` TINYINT(1) DEFAULT 0 NOT NULL,
  `home_lat` DECIMAL(12,4),
  `home_lon` DECIMAL(12,4),
  `home_address` VARCHAR(255),
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `prospects_auto_inject_enabled` TINYINT(1) DEFAULT 0,
  `max_prospects_per_route` INT,
  `prospect_stats_cache` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `driver_incentives` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `driver_user_id` BIGINT UNSIGNED NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `description` JSON NOT NULL,
  `target_value` VARCHAR(255) NOT NULL,
  `current_value` VARCHAR(255) NOT NULL,
  `reward_amount` DECIMAL(12,4),
  `status` VARCHAR(255) NOT NULL,
  `period` VARCHAR(255),
  `period_start` VARCHAR(255),
  `period_end` VARCHAR(255),
  `metadata` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `source_prospect_id` BIGINT UNSIGNED,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `driver_reports` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `customer_profile_id` BIGINT UNSIGNED NOT NULL,
  `driver_user_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED,
  `recurring_order_id` BIGINT UNSIGNED,
  `reason` VARCHAR(255) NOT NULL,
  `notes` JSON,
  `status` VARCHAR(255) NOT NULL,
  `resolved_by` BIGINT UNSIGNED,
  `resolved_at` DATETIME,
  `resolution_notes` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `prospect_visits` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `prospect_id` BIGINT UNSIGNED NOT NULL,
  `driver_user_id` BIGINT UNSIGNED NOT NULL,
  `route_id` BIGINT UNSIGNED,
  `route_stop_id` BIGINT UNSIGNED,
  `visited_at` DATETIME NOT NULL,
  `outcome` VARCHAR(255) NOT NULL,
  `rejection_reason` VARCHAR(255),
  `notes` JSON,
  `contact_phone` VARCHAR(255),
  `contact_name` VARCHAR(255),
  `estimated_volume` DECIMAL(12,4),
  `frequency` TEXT,
  `lat` DECIMAL(12,4),
  `lon` DECIMAL(12,4),
  `gps_available` TINYINT(1) DEFAULT 0 NOT NULL,
  `location_verified` TINYINT(1) DEFAULT 0 NOT NULL,
  `location_distance_meters` TEXT,
  `photo_url` VARCHAR(255),
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `quoted_price_solid` DECIMAL(12,4),
  `quoted_price_liquid` DECIMAL(12,4),
  `quoted_currency` VARCHAR(255) NOT NULL,
  `quote_notes` JSON,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `system_jobs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `job_type` VARCHAR(255) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `source` VARCHAR(255),
  `started_at` DATETIME,
  `finished_at` DATETIME,
  `duration_ms` INT,
  `attempt_count` INT NOT NULL,
  `max_attempts` DATETIME NOT NULL,
  `error_message` VARCHAR(255),
  `metadata` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `system_action_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `job_id` BIGINT UNSIGNED,
  `entity_type` VARCHAR(255),
  `entity_id` BIGINT UNSIGNED,
  `action_type` VARCHAR(255) NOT NULL,
  `channel` VARCHAR(255),
  `status` VARCHAR(255) NOT NULL,
  `triggered_by` TEXT NOT NULL,
  `triggered_by_user_id` BIGINT UNSIGNED,
  `target_email` VARCHAR(255),
  `target_phone` VARCHAR(255),
  `message` VARCHAR(255),
  `metadata` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `system_health_events` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `severity` TEXT NOT NULL,
  `category` TEXT NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `message` VARCHAR(255),
  `entity_type` VARCHAR(255),
  `entity_id` BIGINT UNSIGNED,
  `job_id` BIGINT UNSIGNED,
  `fingerprint` VARCHAR(255) NOT NULL,
  `occurrence_count` INT NOT NULL,
  `first_seen_at` DATETIME NOT NULL,
  `last_seen_at` DATETIME NOT NULL,
  `resolved_at` DATETIME,
  `resolved_by_user_id` BIGINT UNSIGNED,
  `metadata` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `orders` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `customer_profile_id` BIGINT UNSIGNED NOT NULL,
  `address_id` BIGINT UNSIGNED NOT NULL,
  `service_address_id` BIGINT UNSIGNED,
  `billing_address_id` BIGINT UNSIGNED,
  `assigned_driver_user_id` BIGINT UNSIGNED,
  `source_recurring_id` BIGINT UNSIGNED,
  `route_id` BIGINT UNSIGNED,
  `status` VARCHAR(255) NOT NULL,
  `scheduled_at` DATETIME,
  `completed_at` DATETIME,
  `volume_liters_solid` DECIMAL(12,4),
  `volume_liters_liquid` DECIMAL(12,4),
  `notes` JSON,
  `postponed_to` TEXT,
  `postpone_history` JSON,
  `payment_method` VARCHAR(255),
  `payment_amount` DECIMAL(12,4),
  `payment_reference` TEXT,
  `payment_notes` JSON,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `started_at` DATETIME,
  `type` VARCHAR(255),
  `wholesale_kg` DECIMAL(12,4),
  `wholesale_lt` DECIMAL(12,4),
  `ffa` TEXT,
  `m_i` TEXT,
  `scale_document_url` VARCHAR(255),
  `lab_document_url` VARCHAR(255),
  `supplier_signature_url` VARCHAR(255),
  `transfer_note_number` INT,
  `transfer_note_issued_at` DATETIME,
  `transfer_note_pdf_path` VARCHAR(255),
  `waste_percent` DECIMAL(12,4),
  `net_volume_solid` DECIMAL(12,4),
  `net_volume_liquid` DECIMAL(12,4),
  `waste_notes` JSON,
  `waste_recorded_at` DATETIME,
  `waste_recorded_by` TEXT,
  `received_volume_solid` DECIMAL(12,4),
  `received_volume_liquid` DECIMAL(12,4),
  `waste_amount_solid` DECIMAL(12,4),
  `waste_amount_liquid` DECIMAL(12,4),
  `driver_instructions` TEXT,
  `driver_alert_type` VARCHAR(255),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `usage_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `channel` VARCHAR(255) NOT NULL,
  `provider` VARCHAR(255) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `recipient` TEXT NOT NULL,
  `subject` VARCHAR(255),
  `kind` TEXT,
  `user_id` BIGINT UNSIGNED,
  `user_role` VARCHAR(255),
  `cost_units` TEXT NOT NULL,
  `error_message` VARCHAR(255),
  `meta` JSON,
  `sent_at` DATETIME NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `route_order_sequences` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `route_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `sequence_number` INT NOT NULL,
  `estimated_arrival_time` DATETIME,
  `actual_arrival_time` DATETIME,
  `stop_status` VARCHAR(255) NOT NULL,
  `arrived_at` DATETIME,
  `departed_at` DATETIME,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


SET FOREIGN_KEY_CHECKS=1;
