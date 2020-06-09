-- database secondchase
CREATE DATABASE `secondchase` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- table mz_user
CREATE TABLE `mz_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `phonenum` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `wechat` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '微信',
  `qq` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'QQ号',
  `apple_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `gender` int(11) NOT NULL COMMENT '性别 "1"是男，"2"是女',
  `deviceCode` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设备码',
  `useraddress` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `Image` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '形象照',
  `updatetime` datetime NOT NULL COMMENT '更新时间',
  `mzid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '秒追ID',
  `versionum` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '版本号',
  `devicetype` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机型号 android / ios',
  `invitcode` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邀请码',
  `pid` int(11) NOT NULL COMMENT '父ID',
  `vip` int(11) NOT NULL DEFAULT '0' COMMENT '会员标识 二进制 0x0001:月会员 0x0010:季会员 0x0100:年会员 0x1000:试用会员 0x0000:非会员',
  `vipExpire` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('normal','disable') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `balance` int(10) unsigned NOT NULL DEFAULT '0',
  `version` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mz_user_phonenum_index` (`phonenum`),
  KEY `mz_user_wechat_index` (`wechat`),
  KEY `mz_user_qq_index` (`qq`),
  KEY `mz_user_mzid_index` (`mzid`),
  KEY `sindex` (`balance`,`version`)
) ENGINE=InnoDB AUTO_INCREMENT=486 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- table mz_idols
CREATE TABLE `mz_idols` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '偶像名称',
  `resources` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '偶像资源',
  `image` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '偶像图片',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL COMMENT '状态',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `head_image` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '偶像头像',
  `jobs` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mindes` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '明星描述',
  `description` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '明星介绍',
  `rowsort` int(11) NOT NULL,
  `tags` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签',
  `IOS3DUrl` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Android3DIUrl` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `type` enum('idol','public') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'idol' COMMENT '类型',
  `publish_time` datetime DEFAULT NULL,
  `idol_sn` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '明星编号',
  `idol_sn_android` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '明星编号(安卓)',
  `gender` enum('male','female') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'male',
  `model_image` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'idol列表的image',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sindex` (`id`,`publish_time`),
  KEY `mz_idols_type_index` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='偶像列表';

-- table mz_gift
CREATE TABLE `mz_gift` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '礼物名称',
  `image_url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标url',
  `sort` int(11) NOT NULL COMMENT '排序字段',
  `gift_status` int(11) NOT NULL DEFAULT '1' COMMENT '礼物状态',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `motion` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mz_gift_gift_status_index` (`gift_status`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='礼物表';

-- table mz_userinfo
CREATE TABLE `mz_userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `aivalue` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'AI值',
  `Introduction` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
  `interest` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '喜欢',
  `nickname` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
  `gender` int(11) NOT NULL COMMENT '性别',
  `avatar` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户头像',
  PRIMARY KEY (`id`),
  KEY `mz_userinfo_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户属性表';

-- table mz_ar_picture
CREATE TABLE `mz_ar_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `picture_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片ID',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片名称',
  `picture_url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片URL',
  `ar_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AR拍照';

-- table mz_user_idol
CREATE TABLE `mz_user_idol` (
  `user_id` int(11) NOT NULL,
  `idol_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`idol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- table mz_ai_list
CREATE TABLE `mz_ai_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `original_price` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '花费金额',
  `ai_value` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'ai值',
  `present_price` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '现价',
  `discount` float unsigned NOT NULL DEFAULT '0',
  `ai_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT '0',
  `ios_product_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Applestore 商品ID',
  `top_up_bonus` int(11) NOT NULL DEFAULT '0' COMMENT '充值赠送ai值',
  PRIMARY KEY (`id`),
  KEY `mz_ai_list_ai_status_index` (`ai_status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- table mz_product
-- ALTER TABLE `mz_product` ADD `banner_urls` text COMMENT 'banner图' AFTER `image_url`;
-- ALTER TABLE `mz_product` ADD `freight` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '运费,单位分' AFTER `present_price`;

CREATE TABLE `mz_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品初始数量',
  `original_price` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品原价,单位分',
  `present_price` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品现价,单位分',
  `freight` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '运费,单位分',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `thumb_image_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品缩略图地址',
  `image_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品主图地址',
  `banner_urls` text COLLATE utf8mb4_unicode_ci COMMENT 'banner图',
  `sku` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sku描述',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '商品状态 0虚拟商品 1真实商品',
  `product_status` int(11) NOT NULL DEFAULT '1' COMMENT '商品状态 0下架 1上架',
  `ship_address` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '发货地址',
  `sale_support` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '售后保障',
  `description` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述备注',
  `reward` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买单个商品增加的抽奖次数',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品表';



update mz_product set `name`='小米 Redmi Note8 小金刚品质保证 高通骁龙665 4800万全场景四摄',
 `quantity`=100,
 `original_price`=129900,`present_price`=99900,`freight`=1000,
 `sort`=1,
 `thumb_image_url`='https://secondschased.oss-cn-beijing.aliyuncs.com/lottery/model3.png',
 `image_url`='https://secondschased.oss-cn-beijing.aliyuncs.com/lottery/iphone.png',
 `banner_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/lottery/xiaomi.png,https://secondschased.oss-cn-beijing.aliyuncs.com/lottery/lihe.png',
 `sku`='小金刚, 4GB+64GB',
 `type`=1,`product_status`=1,
 `ship_address`='北京',`sale_support`='官方授权 秒追直发 假一赔四 品质保证',
 `reward`=1
 where id=1;

update mz_product set `reward`=5 where id=1;

-- 运费要根据地址算

show create table mz_product;
alter table mz_product drop column `sku_desc`;
ALTER TABLE `mz_product` ADD `sku` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sku描述' AFTER `banner_urls`;
ALTER TABLE `mz_product` DROP `lottery_times`;
ALTER TABLE `mz_product` ADD `reward` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买单个商品增加的抽奖次数' AFTER `description`;


CREATE TABLE `mz_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `reward` int(11) NOT NULL COMMENT '任务奖励',
  `type` int(11) NOT NULL COMMENT '类型',
  `status` int(11) NOT NULL COMMENT '任务状态',
  `flags` int(11) NOT NULL DEFAULT '0' COMMENT '标识位 ',
  `details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '详情',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务列表';

create index index_pid on `mz_task`(`pid`) using btree;

CREATE TABLE `mz_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `reward` int(11) NOT NULL COMMENT '任务奖励',
  `type` int(11) NOT NULL COMMENT '类型',
  `status` int(11) NOT NULL COMMENT '任务状态',
  `flags` int(11) NOT NULL DEFAULT '0' COMMENT '标识位 ',
  `details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '详情',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  PRIMARY KEY (`id`),
  KEY `index_pid` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务列表';

