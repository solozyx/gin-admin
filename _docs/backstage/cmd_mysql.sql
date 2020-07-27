
ssh -L 3309:localhost:3306 zyx@39.107.248.183 -p50010
zhaoyingxin@123

show create table mz_user;
show columns from bs_department;

update bs_user set creator_id=0 where id=1;

ALTER TABLE `bs_permission` ADD `method` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'http method' AFTER `permission_status`;
ALTER TABLE `bs_permission` ADD `path` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'http path' AFTER `method`;

ALTER TABLE `bs_user_role` ADD `status`int(11) NOT NULL DEFAULT 1 COMMENT '状态 0不可用 1可用' AFTER `role_id`;
ALTER TABLE `bs_user_role` ADD `creator_id` int(11) NOT NULL DEFAULT 0 COMMENT '操作者用户id' AFTER `status`;

ALTER TABLE `bs_role_permission` ADD `status`int(11) NOT NULL DEFAULT 1 COMMENT '状态 0不可用 1可用' AFTER `permission_id`;
ALTER TABLE `bs_role_permission` ADD `creator_id` int(11) NOT NULL DEFAULT 0 COMMENT '操作者用户id' AFTER `status`;

select * from bs_role_permission;

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
update bs_permission set name='创建部门',path='/api/v1/department/create' where id=10;
update bs_permission set name='创建用户',path='/api/v1/user/create' where id=11;
update bs_permission set name='删除用户',path='/api/v1/user/delete' where id=12;

update bs_permission set name='用户角色列表',path='/api/v1/user/rolelist' where id=7;
update bs_permission set name='用户权限列表',path='/api/v1/user/permlist' where id=8;

update bs_permission set name='用户角色添加',path='/api/v1/user/roleadd' where id=4;

update bs_permission set name='角色权限添加',path='/api/v1/role/permadd' where id=3;
update bs_permission set name='角色权限减少',path='/api/v1/role/permreduce' where id=4;
update bs_permission set name='用户角色添加',path='/api/v1/user/roleadd' where id=5;
update bs_permission set name='用户角色减少',path='/api/v1/user/rolereduce' where id=6;

update bs_role set name='系统管理员', creator_id=0,remark='' where id=1;
update bs_role set name='子管理员1', creator_id=1,remark='' where id=2;
update bs_role set name='子管理员6' where id=7;

alter table bs_user drop column deleted_at;
alter table bs_user drop column `name`;
alter table bs_role drop column deleted_at;
alter table bs_permission drop column deleted_at;
alter table bs_user_role drop column deleted_at;
alter table bs_role_permission drop column deleted_at;

alter table bs_user change remark `desc` varchar(128) default '' not null comment '备注';
alter table bs_role change remark `desc` varchar(128) default '' not null comment '备注';
alter table bs_permission change remark `desc` varchar(128) default '' not null comment '备注';

alter table bs_role drop column sort;
alter table bs_permission drop column sort;

ALTER TABLE `bs_user` ADD UNIQUE KEY `index_name` (`name`) USING BTREE;

ALTER TABLE `bs_user` ADD UNIQUE KEY `index_email` (`email`) USING BTREE;
ALTER TABLE `bs_user` ADD UNIQUE KEY `index_phone` (`phone`) USING BTREE;

ALTER TABLE `bs_user` ADD `department_id` int(11) NOT NULL DEFAULT 0 COMMENT '部门id' AFTER `creator_id`;

delete from bs_role_permission where role_id=2 and permission_id=2;
update bs_user set department_id=1 where id>1;
update bs_user set password='d6cf393ff29f1b223052a63891ef52bca7697e85';

select * from bs_role_permission where permission_id=10;

delete from bs_role_permission where role_id=2 and permission_id=10;

show create table bs_user;

ALTER TABLE `bs_organization` ADD `level` int(11) NOT NULL DEFAULT '0' COMMENT '组织级别' AFTER `name`;


-- 更改字段名称
alter table bs_permission change permission_status perm_status int default 1 not null comment '状态 0不可用 1可用 2删除';

-- 添加字段
ALTER TABLE `bs_department` ADD `organization_id` int(11) NOT NULL DEFAULT '0' COMMENT '组织id' AFTER `name`;

-- 添加联合唯一索引
alter table `bs_department` add UNIQUE KEY unique_index_name_orgid(`name`,`organization_id`);
alter table `bs_permission` add UNIQUE KEY unique_index_method_path(`method`,`path`);
alter table `bs_department` drop KEY index_name;

ALTER TABLE `bs_department` ADD `level` int(11) NOT NULL DEFAULT '0' COMMENT '部门级别' AFTER `organization_id`;

alter table `bs_user` add KEY index_orgid(`organization_id`);
alter table `bs_user` add KEY index_depid(`department_id`);

alter table `bs_role_permission` drop KEY index_permissionid_roleid;
alter table `bs_role_permission` add UNIQUE KEY unique_index_roleid_permid(`role_id`,`permission_id`);

-- update `bs_role_permission` set `permission_id`=`id` where `id`>21;

alter table bs_role_permission change `creator_id` `creator_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建者用户id';

ALTER TABLE `bs_role` ADD `organization_id` int(11) NOT NULL DEFAULT '0' COMMENT '组织id' AFTER `name`;
alter table `bs_role` add KEY index_orgid(`organization_id`);

alter table `bs_role` drop KEY `index_orgid`;
alter table `bs_role` add UNIQUE KEY unique_index_name_orgid(`name`,`organization_id`);


alter table `bs_user_role` drop KEY `index_userid_roleid`;
alter table `bs_user_role` add UNIQUE KEY unique_index_userid_roleid(`user_id`,`role_id`);

alter table `bs_intention` add UNIQUE KEY unique_index_orgid_intention(`organization_id`,`intention`);
ALTER TABLE `bs_intention` ADD `creator_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建人id' AFTER `intention`;

alter table `bs_menu` add UNIQUE KEY unique_index_title(`title`);

ALTER TABLE `bs_permission` ADD `menu_id` int(11) NOT NULL DEFAULT '0' COMMENT '菜单id' AFTER `name`;
ALTER TABLE `bs_permission` ADD `button_id` int(11) NOT NULL DEFAULT '0' COMMENT '按钮id' AFTER `name`;

ALTER TABLE `bs_permission` ADD `ui_id` int(11) NOT NULL DEFAULT '0' COMMENT 'UI元素id' AFTER `name`;

RENAME TABLE `bs_button` TO `bs_element`;

alter table bs_permission change `button_id` `element_id` int(11) NOT NULL DEFAULT '0' COMMENT 'UI元素id';

ALTER TABLE `bs_element` ADD `ui_type` int(11) NOT NULL DEFAULT '0' COMMENT 'UI元素类型' AFTER `menu_id`;

ALTER TABLE `bs_menu` ADD `level` int(11) NOT NULL DEFAULT '0' COMMENT '菜单级别' AFTER `title`;
ALTER TABLE `bs_menu` ADD `public` int(11) NOT NULL DEFAULT '0' COMMENT '公共菜单 0非公共 1公共' AFTER `parent_id`;
