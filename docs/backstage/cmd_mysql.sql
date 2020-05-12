

ALTER TABLE `bs_permission` ADD `method` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'http method' AFTER `permission_status`;
ALTER TABLE `bs_permission` ADD `path` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'http path' AFTER `method`;

UPDATE `bs_permission` SET `method`='GET',path='/permission/list' WHERE `id`=1;
UPDATE `bs_permission` SET `method`='POST',path='/permission/create' WHERE `id`=2;

