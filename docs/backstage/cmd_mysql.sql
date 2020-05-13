
ssh -L 3309:localhost:3306 zyx@39.107.248.183 -p50010
zhaoyingxin@123


mysql -h127.0.0.1 -uroot -p
oben.com@123
use backstage


ALTER TABLE `bs_permission` ADD `method` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'http method' AFTER `permission_status`;
ALTER TABLE `bs_permission` ADD `path` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'http path' AFTER `method`;

UPDATE `bs_permission` SET `method`='GET',path='/permission/list' WHERE `id`=1;
UPDATE `bs_permission` SET `method`='POST',path='/permission/create' WHERE `id`=2;

SELECT * FROM `bs_role`  WHERE `bs_role`.`deleted_at` IS NULL AND ((role_status=1)) ORDER BY `sort`;
SELECT * FROM `bs_role`  WHERE  ((role_status=1)) ORDER BY `sort`;


ALTER TABLE `bs_permission` MODIFY COLUMN `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间';
ALTER TABLE `bs_role` MODIFY COLUMN `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间';
ALTER TABLE `bs_role_permission` MODIFY COLUMN `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间';
ALTER TABLE `bs_user` MODIFY COLUMN `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间';
ALTER TABLE `bs_user_permission` MODIFY COLUMN `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间';
ALTER TABLE `bs_user_role` MODIFY COLUMN `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间';

UPDATE `bs_permission` SET `deleted_at`=NULL;
UPDATE `bs_role` SET `deleted_at`=NULL;
UPDATE `bs_role_permission` SET `deleted_at`=NULL;
UPDATE `bs_user` SET `deleted_at`=NULL;
UPDATE `bs_user_permission` SET `deleted_at`=NULL;
UPDATE `bs_user_role` SET `deleted_at`=NULL;

show columns from `bs_permission`;

