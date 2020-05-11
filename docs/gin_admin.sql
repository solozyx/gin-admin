
CREATE DATABASE `gin-admin` DEFAULT CHARACTER SET utf8;

CREATE TABLE `g_demo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `record_id` varchar(36) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `code` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `memo` varchar(200) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `creator` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_g_demo_updated_at` (`updated_at`),
  KEY `idx_g_demo_deleted_at` (`deleted_at`),
  KEY `idx_g_demo_code` (`code`),
  KEY `idx_g_demo_name` (`name`),
  KEY `idx_g_demo_status` (`status`),
  KEY `idx_g_demo_record_id` (`record_id`),
  KEY `idx_g_demo_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `g_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `record_id` varchar(36) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `sequence` int(11) NOT NULL DEFAULT '0',
  `icon` varchar(255) DEFAULT NULL,
  `router` varchar(255) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `parent_path` varchar(518) DEFAULT NULL,
  `show_status` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `memo` varchar(1024) DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_g_menu_created_at` (`created_at`),
  KEY `idx_g_menu_updated_at` (`updated_at`),
  KEY `idx_g_menu_deleted_at` (`deleted_at`),
  KEY `idx_g_menu_sequence` (`sequence`),
  KEY `idx_g_menu_parent_id` (`parent_id`),
  KEY `idx_g_menu_show_status` (`show_status`),
  KEY `idx_g_menu_record_id` (`record_id`),
  KEY `idx_g_menu_name` (`name`),
  KEY `idx_g_menu_parent_path` (`parent_path`),
  KEY `idx_g_menu_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `g_menu_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `record_id` varchar(36) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `menu_id` varchar(36) NOT NULL DEFAULT '',
  `code` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_g_menu_action_deleted_at` (`deleted_at`),
  KEY `idx_g_menu_action_menu_id` (`menu_id`),
  KEY `idx_g_menu_action_record_id` (`record_id`),
  KEY `idx_g_menu_action_created_at` (`created_at`),
  KEY `idx_g_menu_action_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `g_menu_action_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `record_id` varchar(36) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `action_id` varchar(36) NOT NULL DEFAULT '',
  `method` varchar(100) NOT NULL DEFAULT '',
  `path` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_g_menu_action_resource_record_id` (`record_id`),
  KEY `idx_g_menu_action_resource_created_at` (`created_at`),
  KEY `idx_g_menu_action_resource_updated_at` (`updated_at`),
  KEY `idx_g_menu_action_resource_deleted_at` (`deleted_at`),
  KEY `idx_g_menu_action_resource_action_id` (`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `g_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `sequence` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,

  `record_id` varchar(36) NOT NULL DEFAULT '',
  `memo` varchar(1024) DEFAULT NULL,

  PRIMARY KEY (`id`),

  KEY `idx_g_role_deleted_at` (`deleted_at`),
  KEY `idx_g_role_name` (`name`),
  KEY `idx_g_role_sequence` (`sequence`),
  KEY `idx_g_role_status` (`status`),
  KEY `idx_g_role_record_id` (`record_id`),
  KEY `idx_g_role_created_at` (`created_at`),
  KEY `idx_g_role_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `g_role_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `record_id` varchar(36) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `role_id` varchar(36) NOT NULL DEFAULT '',
  `menu_id` varchar(36) NOT NULL DEFAULT '',
  `action_id` varchar(36) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_g_role_menu_action_id` (`action_id`),
  KEY `idx_g_role_menu_record_id` (`record_id`),
  KEY `idx_g_role_menu_created_at` (`created_at`),
  KEY `idx_g_role_menu_updated_at` (`updated_at`),
  KEY `idx_g_role_menu_deleted_at` (`deleted_at`),
  KEY `idx_g_role_menu_role_id` (`role_id`),
  KEY `idx_g_role_menu_menu_id` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `g_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `user_name` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(40) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `creator` varchar(36) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `real_name` varchar(64) NOT NULL DEFAULT '',

  `record_id` varchar(36) NOT NULL DEFAULT '',

  PRIMARY KEY (`id`),

  KEY `idx_g_user_record_id` (`record_id`),
  KEY `idx_g_user_created_at` (`created_at`),
  KEY `idx_g_user_user_name` (`user_name`),
  KEY `idx_g_user_real_name` (`real_name`),
  KEY `idx_g_user_email` (`email`),
  KEY `idx_g_user_phone` (`phone`),
  KEY `idx_g_user_updated_at` (`updated_at`),
  KEY `idx_g_user_deleted_at` (`deleted_at`),
  KEY `idx_g_user_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `g_user_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) NOT NULL DEFAULT '',
  `role_id` varchar(36) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,

  `record_id` varchar(36) NOT NULL DEFAULT '',

  PRIMARY KEY (`id`),

  KEY `idx_g_user_role_user_id` (`user_id`),
  KEY `idx_g_user_role_role_id` (`role_id`),
  KEY `idx_g_user_role_record_id` (`record_id`),
  KEY `idx_g_user_role_created_at` (`created_at`),
  KEY `idx_g_user_role_updated_at` (`updated_at`),
  KEY `idx_g_user_role_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
