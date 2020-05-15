
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

update bs_permission set path='/api/v1/permission/list' where id=1;
update bs_permission set method='GET' where id=1;

update bs_permission set path='/api/v1/permission/create' where id=2;
update bs_permission set name='权限列表' where id=1;
update bs_permission set path='/api/v1/role/bindperm' where id=3;
update bs_permission set name='权限1',path='/api/v1/permission/demo1' where id=10;

update bs_role set name='系统管理员', creator_id=0,remark='' where id=1;
update bs_role set name='子管理员1', creator_id=1,remark='' where id=2;
update bs_role set name='子管理员6' where id=7;

alter table bs_user drop column deleted_at;
alter table bs_role drop column deleted_at;
alter table bs_permission drop column deleted_at;
alter table bs_user_role drop column deleted_at;
alter table bs_role_permission drop column deleted_at;

alter table bs_user change remark `desc` varchar(128) default '' not null comment '备注';
alter table bs_role change remark `desc` varchar(128) default '' not null comment '备注';
alter table bs_permission change remark `desc` varchar(128) default '' not null comment '备注';

alter table bs_role drop column sort;
alter table bs_permission drop column sort;

