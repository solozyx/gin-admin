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

