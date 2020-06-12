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
  `original_price` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品原价,单位分',
  `present_price` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品现价,单位分',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `thumb_image_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品缩略图地址',
  `image_urls` text COLLATE utf8mb4_unicode_ci COMMENT '详情图',
  `banner_urls` text COLLATE utf8mb4_unicode_ci COMMENT 'banner图',
  `sku` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sku描述',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '商品状态 0虚拟商品 1真实商品',
  `product_status` int(11) NOT NULL DEFAULT '1' COMMENT '商品状态 0下架 1上架',
  `ship_address` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '发货地址',
  `sale_support` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '售后保障',
  `description` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述备注',
  `reward` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买单个商品增加的抽奖次数',
  `sold_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '单个商品初始售出数量',
  `mz_pid` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '秒追商品id',
  `category` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '品牌分类',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品表';



update mz_product set
 `name`='小米小爱音箱 Pro',
 `original_price`=29900,`present_price`=100,
 `sort`=1,
 `thumb_image_url`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/main/1.jpg',
 `banner_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/main/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/main/2.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/main/3.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/main/4.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/main/5.jpg',
 `image_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/2.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/3.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/4.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/5.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/6.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/7.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/8.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/9.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/10.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/11.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/12.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/13.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/14.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/15.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/16.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/17.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/18.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/19.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/20.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0101/detail/21.jpg',
 `sku`='750mL超大音腔容积 / AUX IN 支持有线连接 / 组合立体声 / 专业级DTS音效 / Hi-Fi级音频芯片 / 支持红外遥控传统家电 / 蓝牙Mesh网关',
 `type`=1,`product_status`=1,
 `ship_address`='北京',`sale_support`='官方授权 秒追直发 假一赔四 正品保证',
 `reward`=2,
 `sold_count`=1029,
 `mz_pid`='MZ0101',
 `category`='小米/音响'
 where id=1;



update mz_product set
 `name`='小米手环4 NFC版',
 `original_price`=22900,`present_price`=100,
 `sort`=2,
 `thumb_image_url`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/main/1.png',
 `banner_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/main/1.png,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/main/2.png,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/main/3.png,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/main/4.png,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/main/5.png',
 `image_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/2.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/3.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/4.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/5.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/6.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/7.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/8.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/9.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/10.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/11.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/12.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/13.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/14.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/15.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/16.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/17.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/18.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/19.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/20.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/21.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/22.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/23.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/24.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0102/detail/25.jpg',
 `sku`='全新 AMOLED 大屏彩显，支持77种个性主题。拥有20天的超长续航，能用支付宝抬手支付。50米防水，支持游泳模式。还能看微信、看来电、测心率、测睡眠。戴上它，你的改变从今天开始。',
 `type`=1,`product_status`=1,
 `ship_address`='北京',`sale_support`='官方授权 秒追直发 假一赔四 正品保证',
 `reward`=2,
 `sold_count`=2683,
 `mz_pid`='MZ0102',
 `category`='小米/手环'
 where id=2;




update mz_product set
 `name`='小米移动电源3 10000mAh 银色',
 `original_price`=12900,`present_price`=100,
 `sort`=3,
 `thumb_image_url`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/main/1.jpg',
 `banner_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/main/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/main/2.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/main/3.jpg',
 `image_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/2.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/3.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/4.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/5.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/6.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/7.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/8.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/9.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/10.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/11.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0103/detail/12.jpg',
 `sku`='USB-C双向快充版/双向18W快充/输入输出双接口/高密度锂聚合物电芯，更安全/可上飞机，更贴心',
 `type`=1,`product_status`=1,
 `ship_address`='北京',`sale_support`='官方授权 秒追直发 假一赔四 正品保证',
 `reward`=1,
 `sold_count`=3756,
 `mz_pid`='MZ0103',
 `category`='小米/移动电源'
 where id=3;




update mz_product set
 `name`='I Do BOOM瓷系列 18K金真钻石锁骨项链 黑陶色',
 `original_price`=199900,`present_price`=100,
 `sort`=4,
 `thumb_image_url`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0104/main/1.jpg',
 `banner_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0104/main/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0104/main/2.jpg',
 `image_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0104/detail/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0104/detail/2.jpg',
 `sku`='I DO官方正品/黑陶(皮绳)/42cm短款项链/赠手绳',
 `type`=1,`product_status`=1,
 `ship_address`='北京',`sale_support`='官方授权 秒追直发 假一赔四 正品保证',
 `reward`=5,
 `sold_count`=652,
 `mz_pid`='MZ0104',
 `category`='I DO/项链'
 where id=4;




update mz_product set
 `name`='I Do 心扉系列 18K金钻石锁骨项链',
 `original_price`=279900,`present_price`=100,
 `sort`=5,
 `thumb_image_url`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/main/1.jpg',
 `banner_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/main/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/main/2.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/main/3.jpg',
 `image_urls`='https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/1.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/2.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/3.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/4.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/5.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/6.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/7.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/8.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/9.jpg,https://secondschased.oss-cn-beijing.aliyuncs.com/goods/mz0105/detail/10.jpg',
 `sku`='I DO官方正品/群镶钻石共约5分/18K金',
 `type`=1,`product_status`=1,
 `ship_address`='北京',`sale_support`='官方授权 秒追直发 假一赔四 正品保证',
 `reward`=5,
 `sold_count`=356,
 `mz_pid`='MZ0105',
 `category`='I DO/项链'
 where id=5;



-- 运费要根据地址算

show create table mz_product;
alter table mz_product drop column `sku_desc`;
ALTER TABLE `mz_product` ADD `sku` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sku描述' AFTER `banner_urls`;
ALTER TABLE `mz_product` DROP `lottery_times`;
ALTER TABLE `mz_product` ADD `reward` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买单个商品增加的抽奖次数' AFTER `description`;
-- `freight` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '运费,单位分',
ALTER TABLE `mz_product` DROP `freight`;
-- `image_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品主图地址',
ALTER TABLE `mz_product` DROP `image_url`;
-- `quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品初始数量',
ALTER TABLE `mz_product` DROP `quantity`;
-- 商品按[无库存]做
ALTER TABLE `mz_product` ADD `sold_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '单个商品初始售出数量' AFTER `reward`;
ALTER TABLE `mz_product` ADD `mz_pid` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '秒追商品id' AFTER `sold_count`;
ALTER TABLE `mz_product` ADD `category` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '品牌分类' AFTER `mz_pid`;

ALTER TABLE `mz_product` ADD `image_urls` text COLLATE utf8mb4_unicode_ci COMMENT '详情图' AFTER `thumb_image_url`;

INSERT INTO `mz_product`(`updated_at`) VALUES('2020-06-12 11:22:03');

insert into `mz_task` (`task_name`,`reward`,`type`,`status`,`flags`,`details`,`update_time`,`pid`) values ('小米手环4 NFC版',2,2,1,0,'成功购买获赠2次','2020-06-12 15:00:02',2);
insert into `mz_task` (`task_name`,`reward`,`type`,`status`,`flags`,`details`,`update_time`,`pid`) values ('小米移动电源3 10000mAh 银色',2,2,1,0,'成功购买获赠1次','2020-06-12 15:00:03',3);
insert into `mz_task` (`task_name`,`reward`,`type`,`status`,`flags`,`details`,`update_time`,`pid`) values ('I Do BOOM瓷系列 18K金真钻石锁骨项链 黑陶色',2,2,1,0,'成功购买获赠5次','2020-06-12 15:00:04',4);
insert into `mz_task` (`task_name`,`reward`,`type`,`status`,`flags`,`details`,`update_time`,`pid`) values ('I Do 心扉系列 18K金钻石锁骨项链',2,2,1,0,'成功购买获赠5次','2020-06-12 15:00:05',5);

update mz_task set
 `task_name`='小米小爱音箱 Pro',
 `reward`=2,
 `type`=2,
 `status`=1,
 `flags`=0,
 `details`='成功购买获赠2次',
 `update_time`='2020-06-12 15:00:01',
 `pid`=1
 where id=5;

select * from mz_task;

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

show columns from `mz_task`;