/*
Navicat MySQL Data Transfer

Source Server         : localhost_logo
Source Server Version : 50726
Source Host           : logo.com:3306
Source Database       : logo_com

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-09-21 19:39:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for color_system
-- ----------------------------
DROP TABLE IF EXISTS `color_system`;
CREATE TABLE `color_system` (
  `color_system_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '色系的名字',
  `path` varchar(255) DEFAULT NULL COMMENT '色系的图片路径',
  `info` varchar(255) DEFAULT NULL COMMENT '色系的描述',
  PRIMARY KEY (`color_system_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of color_system
-- ----------------------------
INSERT INTO `color_system` VALUES ('1', '绿色系', null, '绿色象征着生命和活力，代表着希望和安全，在各行业使用较为普通。');
INSERT INTO `color_system` VALUES ('2', '黄色系', null, '黄色是一种醒目活力的颜色，黄给人一种快乐，童真的感觉，吸引人的注意。');
INSERT INTO `color_system` VALUES ('3', '蓝色系', null, '蓝色传递着信心和成功，具有理智，准确的意象，强调科技，效率的企业形象.');
INSERT INTO `color_system` VALUES ('4', '橙色系', null, '橙色代表着富足，快乐，浅橙色用于吸引高档市场，亮橙色则吸引年轻客户。');
INSERT INTO `color_system` VALUES ('5', '黑白系', null, '黑色代表着力量，彰显企业实力，塑造。黑色代表着力量，彰显企业实力，塑造。');
INSERT INTO `color_system` VALUES ('6', '咖色系', null, '咖啡色属于含蓄的颜色，它优雅，朴素，庄重而不失雅致，给人稳重的感觉。');
INSERT INTO `color_system` VALUES ('7', '金色系', null, '金色代表着温暖与幸福，象征着高贵，光荣，华贵和辉煌，拥有光芒四射的魅力。');
INSERT INTO `color_system` VALUES ('8', '紫色系', null, '紫色属于尊贵的颜色，可以给人尊贵，奢华，醒目和时尚的感觉。');
INSERT INTO `color_system` VALUES ('9', '红色系', null, '红色有着广泛的情感，代表着积极乐观，真诚主动，能一眼抓住客户的眼球。');

-- ----------------------------
-- Table structure for fa_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin`;
CREATE TABLE `fa_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表';

-- ----------------------------
-- Records of fa_admin
-- ----------------------------
INSERT INTO `fa_admin` VALUES ('1', 'admin', 'Admin', '7094a541beb34b4c99e4652f1d946e12', 'ebc2f5', '/assets/img/avatar.png', '910435951@qq.com', '0', '1632143846', '127.0.0.1', '1491635035', '1632143846', 'd125bf45-a80b-4b97-a38f-73bd24644867', 'normal');

-- ----------------------------
-- Table structure for fa_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin_log`;
CREATE TABLE `fa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '日志标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `name` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员日志表';

-- ----------------------------
-- Records of fa_admin_log
-- ----------------------------
INSERT INTO `fa_admin_log` VALUES ('1', '1', 'admin', '/YBTproUIGF.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"DxAs\",\"keeplogin\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1631971601');
INSERT INTO `fa_admin_log` VALUES ('2', '1', 'admin', '/YBTproUIGF.php/addon/install', '插件管理', '{\"name\":\"epay\",\"force\":\"0\",\"uid\":\"32530\",\"token\":\"***\",\"version\":\"1.2.5\",\"faversion\":\"1.2.1.20210730_beta\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1631971707');
INSERT INTO `fa_admin_log` VALUES ('3', '1', 'admin', '/YBTproUIGF.php/general.config/edit', '常规管理 / 系统配置 / 编辑', '{\"__token__\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632057016');
INSERT INTO `fa_admin_log` VALUES ('4', '1', 'admin', '/YBTproUIGF.php/general/config/check', '常规管理 / 系统配置', '{\"row\":{\"name\":\"优惠价格\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632057056');
INSERT INTO `fa_admin_log` VALUES ('5', '1', 'admin', '/YBTproUIGF.php/general/config/check', '常规管理 / 系统配置', '{\"row\":{\"name\":\"logo_price\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632057072');
INSERT INTO `fa_admin_log` VALUES ('6', '1', 'admin', '/YBTproUIGF.php/general.config/add', '常规管理 / 系统配置 / 添加', '{\"__token__\":\"***\",\"row\":{\"group\":\"basic\",\"type\":\"text\",\"name\":\"logo_price\",\"title\":\"优惠价格\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"value\":\"68\",\"content\":\"value1|title1\\r\\nvalue2|title2\",\"tip\":\"优惠价格\",\"rule\":\"\",\"extend\":\"\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632057080');
INSERT INTO `fa_admin_log` VALUES ('7', '1', 'admin', '/YBTproUIGF.php/general/config/del', '常规管理 / 系统配置 / 删除', '{\"name\":\"logo_price\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632057096');
INSERT INTO `fa_admin_log` VALUES ('8', '1', 'admin', '/YBTproUIGF.php/general.config/edit', '常规管理 / 系统配置 / 编辑', '{\"__token__\":\"***\",\"row\":{\"name\":\"logo设计\",\"beian\":\"\",\"cdnurl\":\"\",\"version\":\"1.0.1\",\"timezone\":\"Asia\\/Shanghai\",\"forbiddenip\":\"\",\"languages\":\"{&quot;backend&quot;:&quot;zh-cn&quot;,&quot;frontend&quot;:&quot;zh-cn&quot;}\",\"fixedpage\":\"dashboard\",\"logo_price\":\"68.00\",\"logo_original_price\":\"188.00\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632057330');
INSERT INTO `fa_admin_log` VALUES ('9', '1', 'admin', '/YBTproUIGF.php/general.config/edit', '常规管理 / 系统配置 / 编辑', '{\"__token__\":\"***\",\"row\":{\"name\":\"logo设计\",\"beian\":\"\",\"cdnurl\":\"\",\"version\":\"1.0.1\",\"timezone\":\"Asia\\/Shanghai\",\"forbiddenip\":\"\",\"languages\":\"{&quot;backend&quot;:&quot;zh-cn&quot;,&quot;frontend&quot;:&quot;zh-cn&quot;}\",\"fixedpage\":\"dashboard\",\"logo_price\":\"68.00\",\"logo_original_price\":\"188.00\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632059233');
INSERT INTO `fa_admin_log` VALUES ('10', '1', 'admin', '/YBTproUIGF.php/auth/rule/edit/ids/118?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"industry\",\"title\":\"行业管理\",\"url\":\"\",\"icon\":\"fa fa-trophy\",\"weigh\":\"0\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"status\":\"normal\"},\"ids\":\"118\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632061278');
INSERT INTO `fa_admin_log` VALUES ('11', '1', 'admin', '/YBTproUIGF.php/index/login?url=%2FYBTproUIGF.php%2Fdashboard%3Fref%3Daddtabs', '登录', '{\"url\":\"\\/YBTproUIGF.php\\/dashboard?ref=addtabs\",\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', '1632143846');

-- ----------------------------
-- Table structure for fa_area
-- ----------------------------
DROP TABLE IF EXISTS `fa_area`;
CREATE TABLE `fa_area` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简称',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) DEFAULT NULL COMMENT '层级 0 1 2 省市区县',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地区表';

-- ----------------------------
-- Records of fa_area
-- ----------------------------

-- ----------------------------
-- Table structure for fa_attachment
-- ----------------------------
DROP TABLE IF EXISTS `fa_attachment`;
CREATE TABLE `fa_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '类别',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filename` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) DEFAULT NULL COMMENT '创建日期',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `uploadtime` int(10) DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='附件表';

-- ----------------------------
-- Records of fa_attachment
-- ----------------------------
INSERT INTO `fa_attachment` VALUES ('1', '', '1', '0', '/assets/img/qrcode.png', '150', '150', 'png', '0', 'qrcode.png', '21859', 'image/png', '', '1491635035', '1491635035', '1491635035', 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');

-- ----------------------------
-- Table structure for fa_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group`;
CREATE TABLE `fa_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规则ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分组表';

-- ----------------------------
-- Records of fa_auth_group
-- ----------------------------
INSERT INTO `fa_auth_group` VALUES ('1', '0', 'Admin group', '*', '1491635035', '1491635035', 'normal');
INSERT INTO `fa_auth_group` VALUES ('2', '1', 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', '1491635035', '1491635035', 'normal');
INSERT INTO `fa_auth_group` VALUES ('3', '2', 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', '1491635035', '1491635035', 'normal');
INSERT INTO `fa_auth_group` VALUES ('4', '1', 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', '1491635035', '1491635035', 'normal');
INSERT INTO `fa_auth_group` VALUES ('5', '2', 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', '1491635035', '1491635035', 'normal');

-- ----------------------------
-- Table structure for fa_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group_access`;
CREATE TABLE `fa_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限分组表';

-- ----------------------------
-- Records of fa_auth_group_access
-- ----------------------------
INSERT INTO `fa_auth_group_access` VALUES ('1', '1');

-- ----------------------------
-- Table structure for fa_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_rule`;
CREATE TABLE `fa_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图标',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '条件',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '拼音',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `weigh` (`weigh`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点表';

-- ----------------------------
-- Records of fa_auth_rule
-- ----------------------------
INSERT INTO `fa_auth_rule` VALUES ('1', 'file', '0', 'dashboard', 'Dashboard', 'fa fa-dashboard', '', '', 'Dashboard tips', '1', null, '', 'kzt', 'kongzhitai', '1491635035', '1491635035', '143', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('2', 'file', '0', 'general', 'General', 'fa fa-cogs', '', '', '', '1', null, '', 'cggl', 'changguiguanli', '1491635035', '1491635035', '137', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('3', 'file', '0', 'category', 'Category', 'fa fa-leaf', '', '', 'Category tips', '1', null, '', 'flgl', 'fenleiguanli', '1491635035', '1491635035', '119', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('4', 'file', '0', 'addon', 'Addon', 'fa fa-rocket', '', '', 'Addon tips', '1', null, '', 'cjgl', 'chajianguanli', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('5', 'file', '0', 'auth', 'Auth', 'fa fa-group', '', '', '', '1', null, '', 'qxgl', 'quanxianguanli', '1491635035', '1491635035', '99', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('6', 'file', '2', 'general/config', 'Config', 'fa fa-cog', '', '', 'Config tips', '1', null, '', 'xtpz', 'xitongpeizhi', '1491635035', '1491635035', '60', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('7', 'file', '2', 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', '', 'Attachment tips', '1', null, '', 'fjgl', 'fujianguanli', '1491635035', '1491635035', '53', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('8', 'file', '2', 'general/profile', 'Profile', 'fa fa-user', '', '', '', '1', null, '', 'grzl', 'gerenziliao', '1491635035', '1491635035', '34', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('9', 'file', '5', 'auth/admin', 'Admin', 'fa fa-user', '', '', 'Admin tips', '1', null, '', 'glygl', 'guanliyuanguanli', '1491635035', '1491635035', '118', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('10', 'file', '5', 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', '', 'Admin log tips', '1', null, '', 'glyrz', 'guanliyuanrizhi', '1491635035', '1491635035', '113', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('11', 'file', '5', 'auth/group', 'Group', 'fa fa-group', '', '', 'Group tips', '1', null, '', 'jsz', 'juesezu', '1491635035', '1491635035', '109', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('12', 'file', '5', 'auth/rule', 'Rule', 'fa fa-bars', '', '', 'Rule tips', '1', null, '', 'cdgz', 'caidanguize', '1491635035', '1491635035', '104', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('13', 'file', '1', 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '136', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('14', 'file', '1', 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '135', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('15', 'file', '1', 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '133', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('16', 'file', '1', 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '134', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('17', 'file', '1', 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '132', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('18', 'file', '6', 'general/config/index', 'View', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '52', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('19', 'file', '6', 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '51', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('20', 'file', '6', 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '50', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('21', 'file', '6', 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '49', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('22', 'file', '6', 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '48', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('23', 'file', '7', 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 'Attachment tips', '0', null, '', '', '', '1491635035', '1491635035', '59', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('24', 'file', '7', 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '58', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('25', 'file', '7', 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '57', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('26', 'file', '7', 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '56', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('27', 'file', '7', 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '55', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('28', 'file', '7', 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '54', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('29', 'file', '8', 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '33', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('30', 'file', '8', 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '32', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('31', 'file', '8', 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '31', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('32', 'file', '8', 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '30', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('33', 'file', '8', 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '29', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('34', 'file', '8', 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '28', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('35', 'file', '3', 'category/index', 'View', 'fa fa-circle-o', '', '', 'Category tips', '0', null, '', '', '', '1491635035', '1491635035', '142', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('36', 'file', '3', 'category/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '141', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('37', 'file', '3', 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '140', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('38', 'file', '3', 'category/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '139', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('39', 'file', '3', 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '138', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('40', 'file', '9', 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 'Admin tips', '0', null, '', '', '', '1491635035', '1491635035', '117', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('41', 'file', '9', 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '116', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('42', 'file', '9', 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '115', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('43', 'file', '9', 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '114', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('44', 'file', '10', 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 'Admin log tips', '0', null, '', '', '', '1491635035', '1491635035', '112', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('45', 'file', '10', 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '111', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('46', 'file', '10', 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '110', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('47', 'file', '11', 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 'Group tips', '0', null, '', '', '', '1491635035', '1491635035', '108', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('48', 'file', '11', 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '107', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('49', 'file', '11', 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '106', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('50', 'file', '11', 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '105', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('51', 'file', '12', 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 'Rule tips', '0', null, '', '', '', '1491635035', '1491635035', '103', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('52', 'file', '12', 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '102', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('53', 'file', '12', 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '101', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('54', 'file', '12', 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '100', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('55', 'file', '4', 'addon/index', 'View', 'fa fa-circle-o', '', '', 'Addon tips', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('56', 'file', '4', 'addon/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('57', 'file', '4', 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('58', 'file', '4', 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('59', 'file', '4', 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('60', 'file', '4', 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('63', 'file', '4', 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('64', 'file', '4', 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('65', 'file', '4', 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('66', 'file', '0', 'user', 'User', 'fa fa-user-circle', '', '', '', '1', null, '', 'hygl', 'huiyuanguanli', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('67', 'file', '66', 'user/user', 'User', 'fa fa-user', '', '', '', '1', null, '', 'hygl', 'huiyuanguanli', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('68', 'file', '67', 'user/user/index', 'View', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('69', 'file', '67', 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('70', 'file', '67', 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('71', 'file', '67', 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('72', 'file', '67', 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('73', 'file', '66', 'user/group', 'User group', 'fa fa-users', '', '', '', '1', null, '', 'hyfz', 'huiyuanfenzu', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('74', 'file', '73', 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('75', 'file', '73', 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('76', 'file', '73', 'user/group/index', 'View', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('77', 'file', '73', 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('78', 'file', '73', 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('79', 'file', '66', 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '', '1', null, '', 'hygz', 'huiyuanguize', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('80', 'file', '79', 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('81', 'file', '79', 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('82', 'file', '79', 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('83', 'file', '79', 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('84', 'file', '79', 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '', '0', null, '', '', '', '1491635035', '1491635035', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('90', 'file', '0', 'order', '订单管理', 'fa fa-circle-o', '', '', '', '1', 'addtabs', '', '', '', '1625305049', '1625305049', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('91', 'file', '90', 'order/index', '订单列表', 'fa fa-list', '', '', '', '1', 'addtabs', '', '', '', '1625305072', '1628511958', '100', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('105', 'file', '0', 'material', '素材管理', 'fa fa-amazon', '', '', '', '1', 'addtabs', '', '', '', '1628597343', '1628597396', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('106', 'file', '105', 'material/index', '素材列表', 'fa fa-500px', '', '', '', '1', 'addtabs', '', '', '', '1628597390', '1628597400', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('107', 'file', '106', 'material/add', '添加素材', 'fa fa-circle-o', '', '', '', '0', 'addtabs', '', '', '', '1628597440', '1628597440', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('108', 'file', '106', 'material/edit', '编辑', 'fa fa-edit', '', '', '', '0', 'addtabs', '', '', '', '1628597466', '1628597466', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('109', 'file', '106', 'material/del', '删除', 'fa fa-delicious', '', '', '', '0', 'addtabs', '', '', '', '1628597530', '1628597530', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('118', 'file', '0', 'industry', '行业管理', 'fa fa-trophy', '', '', '', '1', 'addtabs', '', 'hygl', 'hangyeguanli', '1631023556', '1632061278', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('119', 'file', '118', 'industry/index', '行业列表', 'fa fa-circle-o', '', '', '', '1', 'addtabs', '', '', '', '1631023584', '1631023584', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('120', 'file', '119', 'industry/add', '添加', 'fa fa-circle-o', '', '', '', '0', 'addtabs', '', '', '', '1631023598', '1631023598', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('121', 'file', '119', 'industry/edit', '编辑', 'fa fa-circle-o', '', '', '', '0', 'addtabs', '', '', '', '1631023612', '1631023612', '0', 'normal');
INSERT INTO `fa_auth_rule` VALUES ('122', 'file', '119', 'industry/del', '删除', 'fa fa-circle-o', '', '', '', '0', 'addtabs', '', '', '', '1631023629', '1631023629', '0', 'normal');

-- ----------------------------
-- Table structure for fa_category
-- ----------------------------
DROP TABLE IF EXISTS `fa_category`;
CREATE TABLE `fa_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `weigh` (`weigh`,`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类表';

-- ----------------------------
-- Records of fa_category
-- ----------------------------
INSERT INTO `fa_category` VALUES ('1', '0', 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', '1491635035', '1491635035', '1', 'normal');
INSERT INTO `fa_category` VALUES ('2', '0', 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', '1491635035', '1491635035', '2', 'normal');
INSERT INTO `fa_category` VALUES ('3', '2', 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', '1491635035', '1491635035', '3', 'normal');
INSERT INTO `fa_category` VALUES ('4', '2', 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', '1491635035', '1491635035', '4', 'normal');
INSERT INTO `fa_category` VALUES ('5', '0', 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', '1491635035', '1491635035', '5', 'normal');
INSERT INTO `fa_category` VALUES ('6', '5', 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', '1491635035', '1491635035', '6', 'normal');
INSERT INTO `fa_category` VALUES ('7', '5', 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', '1491635035', '1491635035', '7', 'normal');
INSERT INTO `fa_category` VALUES ('8', '6', 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', '1491635035', '1491635035', '8', 'normal');
INSERT INTO `fa_category` VALUES ('9', '6', 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', '1491635035', '1491635035', '9', 'normal');
INSERT INTO `fa_category` VALUES ('10', '7', 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', '1491635035', '1491635035', '10', 'normal');
INSERT INTO `fa_category` VALUES ('11', '7', 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', '1491635035', '1491635035', '11', 'normal');
INSERT INTO `fa_category` VALUES ('12', '0', 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', '1491635035', '1491635035', '12', 'normal');
INSERT INTO `fa_category` VALUES ('13', '0', 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', '1491635035', '1491635035', '13', 'normal');

-- ----------------------------
-- Table structure for fa_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_config`;
CREATE TABLE `fa_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量名',
  `group` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '分组',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text COLLATE utf8mb4_unicode_ci COMMENT '变量值',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '变量字典数据',
  `rule` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置';

-- ----------------------------
-- Records of fa_config
-- ----------------------------
INSERT INTO `fa_config` VALUES ('1', 'name', 'basic', 'Site name', '请填写站点名称', 'string', 'logo设计', '', 'required', '', null);
INSERT INTO `fa_config` VALUES ('2', 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', null);
INSERT INTO `fa_config` VALUES ('3', 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', null);
INSERT INTO `fa_config` VALUES ('4', 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '1.0.1', '', 'required', '', null);
INSERT INTO `fa_config` VALUES ('5', 'timezone', 'basic', 'Timezone', '', 'string', 'Asia/Shanghai', '', 'required', '', null);
INSERT INTO `fa_config` VALUES ('6', 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', null);
INSERT INTO `fa_config` VALUES ('7', 'languages', 'basic', 'Languages', '', 'array', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', null);
INSERT INTO `fa_config` VALUES ('8', 'fixedpage', 'basic', 'Fixed page', '请尽量输入左侧菜单栏存在的链接', 'string', 'dashboard', '', 'required', '', null);
INSERT INTO `fa_config` VALUES ('9', 'categorytype', 'dictionary', 'Category type', '', 'array', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES ('10', 'configgroup', 'dictionary', 'Config group', '', 'array', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES ('11', 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '1', '[\"请选择\",\"SMTP\"]', '', '', '');
INSERT INTO `fa_config` VALUES ('12', 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', 'smtp.qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES ('13', 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '465', '', '', '', '');
INSERT INTO `fa_config` VALUES ('14', 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '10000', '', '', '', '');
INSERT INTO `fa_config` VALUES ('15', 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'string', 'password', '', '', '', '');
INSERT INTO `fa_config` VALUES ('16', 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `fa_config` VALUES ('17', 'mail_from', 'email', 'Mail from', '', 'string', '10000@qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES ('18', 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '{\"category1\":\"Category1\",\"category2\":\"Category2\",\"custom\":\"Custom\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES ('19', 'logo_price', 'basic', '优惠价格', '', 'string', '68.00', null, 'required', '', null);
INSERT INTO `fa_config` VALUES ('20', 'logo_original_price', 'basic', '原价', '', 'string', '188.00', null, 'required', '', null);

-- ----------------------------
-- Table structure for fa_ems
-- ----------------------------
DROP TABLE IF EXISTS `fa_ems`;
CREATE TABLE `fa_ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '事件',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮箱验证码表';

-- ----------------------------
-- Records of fa_ems
-- ----------------------------

-- ----------------------------
-- Table structure for fa_sms
-- ----------------------------
DROP TABLE IF EXISTS `fa_sms`;
CREATE TABLE `fa_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信验证码表';

-- ----------------------------
-- Records of fa_sms
-- ----------------------------

-- ----------------------------
-- Table structure for fa_test
-- ----------------------------
DROP TABLE IF EXISTS `fa_test`;
CREATE TABLE `fa_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `category_id` int(10) unsigned DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') COLLATE utf8mb4_unicode_ci DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `images` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '省市',
  `json` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置:key=名称,value=值',
  `price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '价格',
  `views` int(10) unsigned DEFAULT '0' COMMENT '点击',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year(4) DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) DEFAULT NULL COMMENT '刷新时间(int)',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试表';

-- ----------------------------
-- Records of fa_test
-- ----------------------------
INSERT INTO `fa_test` VALUES ('1', '0', '12', '12,13', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '描述', '广西壮族自治区/百色市/平果县', '{\"a\":\"1\",\"b\":\"2\"}', '0.00', '0', '2017-07-10', '2017-07-10 18:24:45', '2017', '18:24:45', '1491635035', '1491635035', '1491635035', null, '0', '1', 'normal', '1');

-- ----------------------------
-- Table structure for fa_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_user`;
CREATE TABLE `fa_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` int(10) DEFAULT NULL COMMENT '上次登录时间',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) DEFAULT NULL COMMENT '加入时间',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Token',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  `verification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员表';

-- ----------------------------
-- Records of fa_user
-- ----------------------------
INSERT INTO `fa_user` VALUES ('1', '1', 'admin', 'admin', 'd8ec88b6faa76353df0be6c82fafbf94', 'c042f3', 'admin@163.com', '13888888888', '', '0', '0', '2017-04-08', '', '0.00', '0', '1', '1', '1491635035', '1491635035', '127.0.0.1', '0', '127.0.0.1', '1491635035', '0', '1491635035', '', 'normal', '');

-- ----------------------------
-- Table structure for fa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_group`;
CREATE TABLE `fa_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限节点',
  `createtime` int(10) DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员组表';

-- ----------------------------
-- Records of fa_user_group
-- ----------------------------
INSERT INTO `fa_user_group` VALUES ('1', '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', '1491635035', '1491635035', 'normal');

-- ----------------------------
-- Table structure for fa_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_money_log`;
CREATE TABLE `fa_user_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员余额变动表';

-- ----------------------------
-- Records of fa_user_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_rule`;
CREATE TABLE `fa_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题',
  `remark` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员规则表';

-- ----------------------------
-- Records of fa_user_rule
-- ----------------------------
INSERT INTO `fa_user_rule` VALUES ('1', '0', 'index', 'Frontend', '', '1', '1491635035', '1491635035', '1', 'normal');
INSERT INTO `fa_user_rule` VALUES ('2', '0', 'api', 'API Interface', '', '1', '1491635035', '1491635035', '2', 'normal');
INSERT INTO `fa_user_rule` VALUES ('3', '1', 'user', 'User Module', '', '1', '1491635035', '1491635035', '12', 'normal');
INSERT INTO `fa_user_rule` VALUES ('4', '2', 'user', 'User Module', '', '1', '1491635035', '1491635035', '11', 'normal');
INSERT INTO `fa_user_rule` VALUES ('5', '3', 'index/user/login', 'Login', '', '0', '1491635035', '1491635035', '5', 'normal');
INSERT INTO `fa_user_rule` VALUES ('6', '3', 'index/user/register', 'Register', '', '0', '1491635035', '1491635035', '7', 'normal');
INSERT INTO `fa_user_rule` VALUES ('7', '3', 'index/user/index', 'User Center', '', '0', '1491635035', '1491635035', '9', 'normal');
INSERT INTO `fa_user_rule` VALUES ('8', '3', 'index/user/profile', 'Profile', '', '0', '1491635035', '1491635035', '4', 'normal');
INSERT INTO `fa_user_rule` VALUES ('9', '4', 'api/user/login', 'Login', '', '0', '1491635035', '1491635035', '6', 'normal');
INSERT INTO `fa_user_rule` VALUES ('10', '4', 'api/user/register', 'Register', '', '0', '1491635035', '1491635035', '8', 'normal');
INSERT INTO `fa_user_rule` VALUES ('11', '4', 'api/user/index', 'User Center', '', '0', '1491635035', '1491635035', '10', 'normal');
INSERT INTO `fa_user_rule` VALUES ('12', '4', 'api/user/profile', 'Profile', '', '0', '1491635035', '1491635035', '3', 'normal');

-- ----------------------------
-- Table structure for fa_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_score_log`;
CREATE TABLE `fa_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员积分变动表';

-- ----------------------------
-- Records of fa_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_token
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_token`;
CREATE TABLE `fa_user_token` (
  `token` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `expiretime` int(10) DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员Token表';

-- ----------------------------
-- Records of fa_user_token
-- ----------------------------

-- ----------------------------
-- Table structure for fa_version
-- ----------------------------
DROP TABLE IF EXISTS `fa_version`;
CREATE TABLE `fa_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '包大小',
  `content` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='版本表';

-- ----------------------------
-- Records of fa_version
-- ----------------------------

-- ----------------------------
-- Table structure for industry
-- ----------------------------
DROP TABLE IF EXISTS `industry`;
CREATE TABLE `industry` (
  `industry_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '行业ID',
  `industry_name` varchar(255) DEFAULT NULL COMMENT '行业名字',
  `industry_info` varchar(255) DEFAULT NULL COMMENT '行业描述',
  `industry_path` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `file_name` varchar(255) DEFAULT NULL COMMENT '行业图片文件名',
  `industry_path1` varchar(255) DEFAULT NULL COMMENT '图片路径1',
  `file_name1` varchar(255) DEFAULT NULL COMMENT '行业图片文件名1',
  `stage` varchar(255) DEFAULT '0' COMMENT '该字段判断行业是否被删除，0默认为未删除，1默认为已删除',
  PRIMARY KEY (`industry_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='行业表';

-- ----------------------------
-- Records of industry
-- ----------------------------
INSERT INTO `industry` VALUES ('1', '网络科技', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_03.png', 'trade2_03.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_03.png', 'trade1_03.png', '0');
INSERT INTO `industry` VALUES ('2', '商务贸易', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_05.png', 'trade2_05.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_05.png', 'trade1_05.png', '0');
INSERT INTO `industry` VALUES ('3', '餐饮', 'ces', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_07.png', 'trade2_07.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_07.png', 'trade1_07.png', '0');
INSERT INTO `industry` VALUES ('4', '金融', '刚刚rt ', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_09.png', 'trade2_09.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_09.png', 'trade1_09.png', '0');
INSERT INTO `industry` VALUES ('5', '建材家居', 'sd ', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade-fzxm.png', 'trade-fzxm.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade-fzxm-active.png', 'trade-fzxm-active.png', '0');
INSERT INTO `industry` VALUES ('6', '运动健身', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_11.png', 'trade2_11.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_11.png', 'trade1_11.png', '0');
INSERT INTO `industry` VALUES ('7', '房地产', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_13.png', 'trade2_13.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_13.png', 'trade1_13.png', '0');
INSERT INTO `industry` VALUES ('8', '医疗美容', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_25.png', 'trade2_25.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_25.png', 'trade1_25.png', '0');
INSERT INTO `industry` VALUES ('9', '教育', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_27.png', 'trade2_27.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_27.png', 'trade1_27.png', '0');
INSERT INTO `industry` VALUES ('10', '购物休闲', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade-lyxx.png', 'trade-lyxx.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade-lyxx-active.png', 'trade-lyxx-active.png', '0');
INSERT INTO `industry` VALUES ('11', '艺术传媒', '', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_29.png', 'trade2_29.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_29.png', 'trade1_29.png', '0');
INSERT INTO `industry` VALUES ('12', '其他行业', null, 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade2_33.png', 'trade2_33.png', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/trade1_33.png', 'trade1_33.png', '0');

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `material_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '素材库的id',
  `material_name` varchar(255) DEFAULT NULL COMMENT '素材的名字',
  `industry_id` int(11) DEFAULT NULL COMMENT '行业表的ID',
  `material_path` varchar(255) DEFAULT NULL COMMENT '素材上传文件的路径',
  `color_system_id` int(11) DEFAULT NULL COMMENT '素材的归属色系ID',
  `file_name` varchar(255) DEFAULT NULL COMMENT '上传素材的文件名',
  `back_user_id` int(11) DEFAULT NULL COMMENT '后台用户表的的id',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'logo价格',
  `typename` varchar(255) DEFAULT NULL COMMENT '标签属性',
  `rgb` varchar(20) DEFAULT NULL COMMENT '颜色',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态 0：正常  1：锁定',
  PRIMARY KEY (`material_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1482 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='素材表';

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('16', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/0b8d11b1d3997f36dbc1f705f65c1168b935ed5c.svg', '9', '0b8d11b1d3997f36dbc1f705f65c1168b935ed5c.svg', '1', '59.00', '日', '006699', '1');
INSERT INTO `material` VALUES ('19', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/0bc3bac9c1a727805edfda17b3614601c0044bb3.svg', '2', '0bc3bac9c1a727805edfda17b3614601c0044bb3.svg', '1', '59.00', 'm,音', 'ff9900', '0');
INSERT INTO `material` VALUES ('23', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/0d1b4de23a5bca82158059c7e1cc9a9db4eab73c.svg', '1', '0d1b4de23a5bca82158059c7e1cc9a9db4eab73c.svg', '1', '59.00', '山,水', '009966', '0');
INSERT INTO `material` VALUES ('29', '2020.9.12', '10', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/0fb79cc31bdd200ab83a0f06fec6ae0be838dc21.svg', '3', '0fb79cc31bdd200ab83a0f06fec6ae0be838dc21.svg', '1', '59.00', 'q,c,n,树,木', '3399cc', '0');
INSERT INTO `material` VALUES ('30', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/0ff8c97ca8f8e621c153f37e80d39dff73c6f93c.svg', '1', '0ff8c97ca8f8e621c153f37e80d39dff73c6f93c.svg', '1', '59.00', 'z', '009999', '0');
INSERT INTO `material` VALUES ('32', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/01c72b03a28207571902b08a2be36c1108a7d3a5.svg', '7', '01c72b03a28207571902b08a2be36c1108a7d3a5.svg', '1', '59.00', '', 'cc0000', '0');
INSERT INTO `material` VALUES ('33', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/01d8193267b036965f28feb0cb0b0765cf7ae2f8.svg', '3', '01d8193267b036965f28feb0cb0b0765cf7ae2f8.svg', '1', '59.00', 'i,教,育', '0099cc', '0');
INSERT INTO `material` VALUES ('34', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/01db53e120fef355784007b862f7dce91fef8c56.svg', '9', '01db53e120fef355784007b862f7dce91fef8c56.svg', '1', '59.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('36', '2020.9.12', '12', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/1a24bc046f110ed4c6817ef11123fe529c1417b3.svg', '4', '1a24bc046f110ed4c6817ef11123fe529c1417b3.svg', '1', '59.00', '杯,酒', 'ff9933', '0');
INSERT INTO `material` VALUES ('47', '2020.9.12', '9', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/1bf7a26b68933911a68100e62247d513f74ba6d9.svg', '2', '1bf7a26b68933911a68100e62247d513f74ba6d9.svg', '1', '59.00', '书,考,教,育', '0099ff', '0');
INSERT INTO `material` VALUES ('142', '2020.9.12', '9', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/4fbac67868fdb33eea71a18d938a480ffefd3543.svg', '2', '4fbac67868fdb33eea71a18d938a480ffefd3543.svg', '1', '59.00', '', 'ffcc00', '0');
INSERT INTO `material` VALUES ('316', '2020.9.12', '11', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/37d6a9df69377b002f998fde8d5a5b7c5a634956.svg', '3', '37d6a9df69377b002f998fde8d5a5b7c5a634956.svg', '1', '59.00', 'f,鹅', '006699', '0');
INSERT INTO `material` VALUES ('432', '2020.9.12', '3', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/137bd991fc5c3a93494e24f54f84d7dbff162b44.svg', '9', '137bd991fc5c3a93494e24f54f84d7dbff162b44.svg', '1', '59.00', 'c,辣,椒', 'ff3333', '0');
INSERT INTO `material` VALUES ('449', '2020.9.12', '4', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/334c2fd7291b92148b20daaed9b6bd791496701e.svg', '7', '334c2fd7291b92148b20daaed9b6bd791496701e.svg', '1', '59.00', '星,球', 'cc0000', '0');
INSERT INTO `material` VALUES ('518', '2020.9.12', '6', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/951e7de00c44545071fc47f2da2e4cbb5fc9bc73.svg', '3', '951e7de00c44545071fc47f2da2e4cbb5fc9bc73.svg', '1', '59.00', 't,电', '0099cc', '0');
INSERT INTO `material` VALUES ('535', '2020.9.12', '7', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/3618c207db6ede5281a3d984a10c1730bfb2fbc3.svg', '3', '3618c207db6ede5281a3d984a10c1730bfb2fbc3.svg', '1', '59.00', '物业,家,房,建,筑', '3399cc', '1');
INSERT INTO `material` VALUES ('587', '2020.9.12', '8', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/46837be5e48efe64e880bbc4ed22b0d4f05f684e.svg', '9', '46837be5e48efe64e880bbc4ed22b0d4f05f684e.svg', '1', '59.00', 'i,十', 'ff6600', '0');
INSERT INTO `material` VALUES ('591', '2020.9.12', '6', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/54571d60f6fb2cac5d7ef62b2dbf330d69293220.svg', '3', '54571d60f6fb2cac5d7ef62b2dbf330d69293220.svg', '1', '59.00', 's,水', '3399cc', '0');
INSERT INTO `material` VALUES ('594', '2020.9.12', '8', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/57255f91be717f5505dab9f1ebb0fc85469a1ec5.svg', '1', '57255f91be717f5505dab9f1ebb0fc85469a1ec5.svg', '1', '59.00', '十,医', '336699', '0');
INSERT INTO `material` VALUES ('877', '2020.9.12', '1', 'http://mylogo3.oss-cn-beijing.aliyuncs.com/logo3/db7312ebc11a342b97765a33c0a8cd9a5f001653.svg', '3', 'db7312ebc11a342b97765a33c0a8cd9a5f001653.svg', '1', '59.00', 'c', '3399cc', '0');
INSERT INTO `material` VALUES ('1037', '111', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/导出格式.svg', '3', '导出格式.svg', '13', '33.00', '未来,眼睛', '0066cc', '0');
INSERT INTO `material` VALUES ('1038', '071001', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/11-7.svg', '1', '11-7.svg', '13', '59.00', '花瓣,s', '009933', '0');
INSERT INTO `material` VALUES ('1039', '071002', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/bgv-12.svg', '3', 'bgv-12.svg', '13', '59.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1040', '071003', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/bnbn-12.svg', '9', 'bnbn-12.svg', '13', '59.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1042', '071005', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/bvc-12.svg', '1', 'bvc-12.svg', '13', '59.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1043', '071006', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/cvbngf-13.svg', '1', 'cvbngf-13.svg', '13', '59.00', '', '0099cc', '1');
INSERT INTO `material` VALUES ('1045', '071009', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/dfg3.svg', '4', 'dfg3.svg', '13', '59.00', '', 'cccc99', '0');
INSERT INTO `material` VALUES ('1047', '071011', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/dfghj-13.svg', '3', 'dfghj-13.svg', '13', '59.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1048', '071013', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/fghj-12.svg', '3', 'fghj-12.svg', '13', '59.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1049', '071015', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/fhjnn-1.svg', '8', 'fhjnn-1.svg', '13', '59.00', '', '663366', '0');
INSERT INTO `material` VALUES ('1051', '071016', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/hjnj-11.svg', '4', 'hjnj-11.svg', '13', '59.00', '', 'cccc00', '0');
INSERT INTO `material` VALUES ('1052', '071017', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/jcvbnjm-1.svg', '9', 'jcvbnjm-1.svg', '13', '59.00', '', '003333', '0');
INSERT INTO `material` VALUES ('1054', '071019', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Kids Care.svg', '8', 'Kids Care.svg', '13', '59.00', '', '9966cc', '0');
INSERT INTO `material` VALUES ('1056', '071021', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/kxfghk-1.svg', '9', 'kxfghk-1.svg', '13', '59.00', '', '003333', '0');
INSERT INTO `material` VALUES ('1057', '071022', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/lcgj-1.svg', '9', 'lcgj-1.svg', '13', '59.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1058', '071023', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Link People.svg', '3', 'Link People.svg', '13', '59.00', '', '999999', '0');
INSERT INTO `material` VALUES ('1059', '071023', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Lumber Mill.svg', '6', 'Lumber Mill.svg', '13', '59.00', '', '333300', '0');
INSERT INTO `material` VALUES ('1060', '071024', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Medcare.svg', '3', 'Medcare.svg', '13', '59.00', '', '33cccc', '0');
INSERT INTO `material` VALUES ('1062', '071026', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/mjj-12.svg', '4', 'mjj-12.svg', '13', '59.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1063', '071026', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/mknb题-12.svg', '1', 'mknb题-12.svg', '13', '59.00', '', '99cc33', '0');
INSERT INTO `material` VALUES ('1064', '071029', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Octopus.svg', '1', 'Octopus.svg', '13', '59.00', '', '00cc99', '0');
INSERT INTO `material` VALUES ('1065', '071030', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Peacock.svg', '4', 'Peacock.svg', '13', '59.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1066', '071031', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Pixel Run.svg', '4', 'Pixel Run.svg', '13', '59.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1068', '071033', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Rocket Lab.svg', '3', 'Rocket Lab.svg', '13', '59.00', '', '3399ff', '0');
INSERT INTO `material` VALUES ('1072', '071037', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Univers Letter U.svg', '9', 'Univers Letter U.svg', '13', '59.00', '', 'ff6633', '0');
INSERT INTO `material` VALUES ('1073', '071038', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Woman Beauty.svg', '9', 'Woman Beauty.svg', '13', '59.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1077', '071043', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/未duyfl-3.svg', '8', '未duyfl-3.svg', '13', '59.00', '', '66cccc', '0');
INSERT INTO `material` VALUES ('1078', '071046', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/未标题-3.svg', '4', '未标题-3.svg', '13', '59.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1079', '071047', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/未标题-6.svg', '1', '未标题-6.svg', '13', '59.00', '', 'cc3366', '0');
INSERT INTO `material` VALUES ('1080', '071049', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/未标题-7.svg', '3', '未标题-7.svg', '13', '59.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1081', '071050', '12', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/未标题-13.svg', '3', '未标题-13.svg', '13', '59.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1082', '701', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1.svg', '2', '1.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1083', '703', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/3.svg', '9', '3.svg', '13', '33.00', '', 'cc0000', '0');
INSERT INTO `material` VALUES ('1085', '705', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/5.svg', '3', '5.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1086', '706', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/6.svg', '3', '6.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1087', '707', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/7.svg', '9', '7.svg', '13', '33.00', '', '003333', '0');
INSERT INTO `material` VALUES ('1089', '709', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/9.svg', '1', '9.svg', '13', '33.00', '', '006600', '0');
INSERT INTO `material` VALUES ('1091', '710', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/10.svg', '3', '10.svg', '13', '33.00', '', '3399ff', '0');
INSERT INTO `material` VALUES ('1092', '711', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/11.svg', '9', '11.svg', '13', '33.00', '', 'cc0000', '0');
INSERT INTO `material` VALUES ('1093', '712', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/12.svg', '2', '12.svg', '13', '33.00', '', '006633', '0');
INSERT INTO `material` VALUES ('1095', '714', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/14.svg', '9', '14.svg', '13', '33.00', '', 'ff0000', '0');
INSERT INTO `material` VALUES ('1096', '715', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/15.svg', '3', '15.svg', '13', '33.00', '', 'cc0099', '0');
INSERT INTO `material` VALUES ('1097', '716', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/16.svg', '4', '16.svg', '13', '33.00', '', 'ff6600', '0');
INSERT INTO `material` VALUES ('1099', '718', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/18.svg', '3', '18.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1100', '179', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/19.svg', '1', '19.svg', '13', '33.00', '', '333366', '0');
INSERT INTO `material` VALUES ('1101', '720', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/20.svg', '1', '20.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1102', '721', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/21.svg', '5', '21.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1103', '722', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/22.svg', '2', '22.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1104', '723', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/23.svg', '3', '23.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1105', '724', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/24.svg', '3', '24.svg', '13', '33.00', '', '003366', '0');
INSERT INTO `material` VALUES ('1106', '725', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/25.svg', '1', '25.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1107', '726', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/26.svg', '5', '26.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1108', '727', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/27.svg', '5', '27.svg', '13', '33.00', '', '333366', '0');
INSERT INTO `material` VALUES ('1110', '729', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/29.svg', '2', '29.svg', '13', '33.00', '', '333366', '0');
INSERT INTO `material` VALUES ('1111', '730', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/30.svg', '5', '30.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1112', '731', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/31.svg', '4', '31.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1114', '733', '9', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/33.svg', '2', '33.svg', '13', '33.00', '', 'ffcc00', '0');
INSERT INTO `material` VALUES ('1120', '82', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/82.svg', '1', '82.svg', '13', '33.00', '', 'ccccff', '0');
INSERT INTO `material` VALUES ('1125', '87', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/87.svg', '3', '87.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1126', '88', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/88.svg', '5', '88.svg', '13', '33.00', '', '006666', '0');
INSERT INTO `material` VALUES ('1127', '89', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/89.svg', '9', '89.svg', '13', '33.00', '', '990000', '0');
INSERT INTO `material` VALUES ('1128', '810', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/810.svg', '5', '810.svg', '13', '33.00', '', '336666', '0');
INSERT INTO `material` VALUES ('1129', '811', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/811.svg', '1', '811.svg', '13', '33.00', '', 'ff6699', '0');
INSERT INTO `material` VALUES ('1131', '813', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/813.svg', '2', '813.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1132', '814', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/814.svg', '1', '814.svg', '13', '33.00', '', '6699cc', '0');
INSERT INTO `material` VALUES ('1133', '815', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/815.svg', '3', '815.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1134', '816', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/816.svg', '3', '816.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1135', '817', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/817.svg', '3', '817.svg', '13', '33.00', '', 'cccccc', '0');
INSERT INTO `material` VALUES ('1137', '820', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/820.svg', '3', '820.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1138', '821', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/821.svg', '1', '821.svg', '13', '33.00', '', '339933', '0');
INSERT INTO `material` VALUES ('1139', '822', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/822.svg', '9', '822.svg', '13', '33.00', '', 'cccccc', '0');
INSERT INTO `material` VALUES ('1140', '823', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/823.svg', '5', '823.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1141', '824', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/824.svg', '1', '824.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1142', '825', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/825.svg', '2', '825.svg', '13', '33.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1143', '826', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/826.svg', '3', '826.svg', '13', '33.00', '', '999999', '0');
INSERT INTO `material` VALUES ('1144', '827', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/827.svg', '3', '827.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1145', '828', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/828.svg', '2', '828.svg', '13', '33.00', '', 'cccc33', '0');
INSERT INTO `material` VALUES ('1147', '830', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/830.svg', '3', '830.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1148', '831', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/831.svg', '3', '831.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1149', '832', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/832.svg', '3', '832.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1151', '834', '4', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/834.svg', '1', '834.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1153', '102', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/102.svg', '6', '102.svg', '13', '33.00', '', '663300', '1');
INSERT INTO `material` VALUES ('1155', '105', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/105.svg', '5', '105.svg', '13', '33.00', '', '993333', '0');
INSERT INTO `material` VALUES ('1156', '106', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/106.svg', '2', '106.svg', '13', '33.00', '', 'cc9900', '0');
INSERT INTO `material` VALUES ('1157', '107', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/107.svg', '5', '107.svg', '13', '33.00', '', 'ff0000', '0');
INSERT INTO `material` VALUES ('1158', '108', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/108.svg', '9', '108.svg', '13', '33.00', '', 'ff0000', '0');
INSERT INTO `material` VALUES ('1159', '109', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/109.svg', '4', '109.svg', '13', '33.00', '', '993333', '0');
INSERT INTO `material` VALUES ('1160', '110', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/110.svg', '5', '110.svg', '13', '33.00', '', '333366', '0');
INSERT INTO `material` VALUES ('1161', '91', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/91.svg', '3', '91.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1162', '111', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/111.svg', '9', '111.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1163', '112', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/112.svg', '9', '112.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1164', '92', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/92.svg', '3', '92.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1165', '113', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/113.svg', '9', '113.svg', '13', '33.00', '', '990000', '0');
INSERT INTO `material` VALUES ('1166', '93', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/93.svg', '7', '93.svg', '13', '33.00', '', 'cc9933', '0');
INSERT INTO `material` VALUES ('1167', '114', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/114.svg', '6', '114.svg', '13', '33.00', '', '663333', '0');
INSERT INTO `material` VALUES ('1168', '115', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/115.svg', '7', '115.svg', '13', '33.00', '', 'ff9966', '0');
INSERT INTO `material` VALUES ('1169', '94', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/94.svg', '1', '94.svg', '13', '33.00', '', 'ff0033', '0');
INSERT INTO `material` VALUES ('1170', '95', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/95.svg', '8', '95.svg', '13', '33.00', '', '996699', '0');
INSERT INTO `material` VALUES ('1171', '116', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/116.svg', '5', '116.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1172', '96', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/96.svg', '3', '96.svg', '13', '33.00', '', '009933', '0');
INSERT INTO `material` VALUES ('1173', '97', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/97.svg', '8', '97.svg', '13', '33.00', '', '0099ff', '0');
INSERT INTO `material` VALUES ('1174', '117', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/117.svg', '3', '117.svg', '13', '33.00', '', '333366', '0');
INSERT INTO `material` VALUES ('1175', '98', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/98.svg', '3', '98.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1177', '118', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/118.svg', '1', '118.svg', '13', '33.00', '', '669900', '1');
INSERT INTO `material` VALUES ('1178', '910', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/910.svg', '4', '910.svg', '13', '33.00', '', '333399', '0');
INSERT INTO `material` VALUES ('1179', '912', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/912.svg', '9', '912.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1180', '119', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/119.svg', '9', '119.svg', '13', '33.00', '', '993300', '0');
INSERT INTO `material` VALUES ('1181', '913', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/913.svg', '7', '913.svg', '13', '33.00', '', 'cccc66', '0');
INSERT INTO `material` VALUES ('1182', '914', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/914.svg', '9', '914.svg', '13', '33.00', '', '333399', '0');
INSERT INTO `material` VALUES ('1183', '120', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/120.svg', '2', '120.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1185', '122', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/122.svg', '6', '122.svg', '13', '33.00', '', 'cc6633', '0');
INSERT INTO `material` VALUES ('1186', '915', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/915.svg', '3', '915.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1187', '916', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/916.svg', '3', '916.svg', '13', '33.00', '', '006666', '0');
INSERT INTO `material` VALUES ('1188', '917', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/917.svg', '3', '917.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1190', '123', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/123.svg', '1', '123.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1192', '124', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/124.svg', '3', '124.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1193', '920', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/920.svg', '7', '920.svg', '13', '33.00', '', 'cccc33', '0');
INSERT INTO `material` VALUES ('1194', '125', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/125.svg', '3', '125.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1195', '921', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/921.svg', '4', '921.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1196', '126', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/126.svg', '1', '126.svg', '13', '33.00', '', '99cc33', '0');
INSERT INTO `material` VALUES ('1198', '127', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/127.svg', '6', '127.svg', '13', '33.00', '', 'cc6633', '0');
INSERT INTO `material` VALUES ('1200', '128', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/128.svg', '4', '128.svg', '13', '33.00', '', 'ff0000', '0');
INSERT INTO `material` VALUES ('1201', '924', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/924.svg', '9', '924.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1202', '129', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/129.svg', '2', '129.svg', '13', '33.00', '', 'ffcc00', '0');
INSERT INTO `material` VALUES ('1203', '925', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/925.svg', '3', '925.svg', '13', '33.00', '', '33cccc', '0');
INSERT INTO `material` VALUES ('1206', '926', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/926.svg', '1', '926.svg', '13', '33.00', '', '669933', '0');
INSERT INTO `material` VALUES ('1209', '133', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/133.svg', '3', '133.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1210', '928', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/928.svg', '5', '928.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1211', '134', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/134.svg', '6', '134.svg', '13', '33.00', '', 'cc6600', '0');
INSERT INTO `material` VALUES ('1212', '929', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/929.svg', '5', '929.svg', '13', '33.00', '', '339966', '0');
INSERT INTO `material` VALUES ('1213', '135', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/135.svg', '9', '135.svg', '13', '33.00', '', '339933', '0');
INSERT INTO `material` VALUES ('1214', '930', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/930.svg', '1', '930.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1215', '136', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/136.svg', '2', '136.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1216', '931', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/931.svg', '1', '931.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1218', '933', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/933.svg', '8', '933.svg', '13', '33.00', '', '990066', '0');
INSERT INTO `material` VALUES ('1219', '934', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/934.svg', '2', '934.svg', '13', '33.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1221', '138', '3', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/138.svg', '1', '138.svg', '13', '33.00', '', '66cc33', '0');
INSERT INTO `material` VALUES ('1222', '936', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/936.svg', '3', '936.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1224', '201', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/201.svg', '6', '201.svg', '13', '33.00', '', '339999', '0');
INSERT INTO `material` VALUES ('1225', '202', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/202.svg', '6', '202.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1226', '203', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/203.svg', '1', '203.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1227', '204', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/204.svg', '3', '204.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1228', '205', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/205.svg', '6', '205.svg', '13', '33.00', '', 'ff6600', '0');
INSERT INTO `material` VALUES ('1229', '1101', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1101.svg', '7', '1101.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1230', '206', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/206.svg', '6', '206.svg', '13', '33.00', '', '333333', '1');
INSERT INTO `material` VALUES ('1231', '1102', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1102.svg', '5', '1102.svg', '13', '33.00', '', '666666', '1');
INSERT INTO `material` VALUES ('1233', '207', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/207.svg', '7', '207.svg', '13', '33.00', '', '99cc33', '0');
INSERT INTO `material` VALUES ('1235', '1104', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1104.svg', '8', '1104.svg', '13', '33.00', '', '663366', '0');
INSERT INTO `material` VALUES ('1238', '1105', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1105.svg', '3', '1105.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1239', '211', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/211.svg', '2', '211.svg', '13', '33.00', '', 'cc6699', '0');
INSERT INTO `material` VALUES ('1240', '212', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/212.svg', '6', '212.svg', '13', '33.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1241', '1106', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1106.svg', '2', '1106.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1242', '213', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/213.svg', '1', '213.svg', '13', '33.00', '', '669933', '0');
INSERT INTO `material` VALUES ('1243', '1107', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1107.svg', '1', '1107.svg', '13', '33.00', '', '999933', '0');
INSERT INTO `material` VALUES ('1244', '214', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/214.svg', '5', '214.svg', '13', '33.00', '', '000000', '0');
INSERT INTO `material` VALUES ('1247', '1109', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1109.svg', '3', '1109.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1248', '216', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/216.svg', '3', '216.svg', '13', '33.00', '', '66ccff', '0');
INSERT INTO `material` VALUES ('1249', '1110', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1110.svg', '1', '1110.svg', '13', '33.00', '', '66cc00', '0');
INSERT INTO `material` VALUES ('1250', '1111', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1111.svg', '1', '1111.svg', '13', '33.00', '', '333399', '0');
INSERT INTO `material` VALUES ('1252', '1112', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1113.svg', '3', '1113.svg', '13', '33.00', '', '99ccff', '0');
INSERT INTO `material` VALUES ('1253', '218', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/218.svg', '5', '218.svg', '13', '33.00', '', '000000', '1');
INSERT INTO `material` VALUES ('1254', '1114', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1114.svg', '7', '1114.svg', '13', '33.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1255', '219', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/219.svg', '3', '219.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1256', '1115', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1115.svg', '7', '1115.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1257', '220', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/220.svg', '2', '220.svg', '13', '33.00', '', 'cccc66', '0');
INSERT INTO `material` VALUES ('1259', '221', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/221.svg', '9', '221.svg', '13', '33.00', '', 'cc3366', '0');
INSERT INTO `material` VALUES ('1260', '1117', '11', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1117.svg', '1', '1117.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1261', '222', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/222.svg', '9', '222.svg', '13', '33.00', '', 'ff0033', '0');
INSERT INTO `material` VALUES ('1262', '1118', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1118.svg', '1', '1118.svg', '13', '33.00', '', '99cc33', '0');
INSERT INTO `material` VALUES ('1263', '223', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/223.svg', '5', '223.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1264', '1119', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1119.svg', '3', '1119.svg', '13', '33.00', '', '99ccff', '0');
INSERT INTO `material` VALUES ('1265', '224', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/224.svg', '3', '224.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1266', '1120', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1120.svg', '7', '1120.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1268', '1121', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1121.svg', '3', '1121.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1269', '226', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/226.svg', '6', '226.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1270', '227', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/227.svg', '3', '227.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1271', '1122', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1122.svg', '1', '1122.svg', '13', '33.00', '', '999999', '0');
INSERT INTO `material` VALUES ('1273', '229', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/229.svg', '1', '229.svg', '13', '33.00', '', '99cc33', '0');
INSERT INTO `material` VALUES ('1274', '1123', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1123.svg', '8', '1123.svg', '13', '33.00', '', 'cc6666', '0');
INSERT INTO `material` VALUES ('1275', '230', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/230.svg', '1', '230.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1276', '1124', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1124.svg', '7', '1124.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1277', '1125', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1125.svg', '5', '1125.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1278', '231', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/231.svg', '3', '231.svg', '13', '33.00', '', 'cccc00', '0');
INSERT INTO `material` VALUES ('1279', '232', '2', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/232.svg', '2', '232.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1280', '1126', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1126.svg', '1', '1126.svg', '13', '33.00', '', 'ccffff', '0');
INSERT INTO `material` VALUES ('1282', '1127', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1127.svg', '3', '1127.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1283', '1128', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1128.svg', '1', '1128.svg', '13', '33.00', '', '99cc00', '0');
INSERT INTO `material` VALUES ('1285', '1130', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1130.svg', '3', '1130.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1287', '1132', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1132.svg', '5', '1132.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1288', '1133', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1133.svg', '1', '1133.svg', '13', '33.00', '', '66cccc', '0');
INSERT INTO `material` VALUES ('1290', '1202', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1202.svg', '1', '1202.svg', '13', '33.00', '', '009933', '0');
INSERT INTO `material` VALUES ('1291', '1203', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1204.svg', '1', '1204.svg', '13', '33.00', '', '009933', '0');
INSERT INTO `material` VALUES ('1292', '1205', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1205.svg', '1', '1205.svg', '13', '33.00', '', '009933', '0');
INSERT INTO `material` VALUES ('1294', '1206', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1206.svg', '3', '1206.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1295', '1207', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1207.svg', '1', '1207.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1296', '1208', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1208.svg', '1', '1208.svg', '13', '33.00', '', '009933', '0');
INSERT INTO `material` VALUES ('1297', '1209', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1209.svg', '5', '1209.svg', '13', '33.00', '', '66cccc', '0');
INSERT INTO `material` VALUES ('1298', '1210', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1210.svg', '9', '1210.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1299', '1211', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1211.svg', '1', '1211.svg', '13', '33.00', '', '66cc00', '0');
INSERT INTO `material` VALUES ('1301', '1213.', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1213.svg', '9', '1213.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1303', '1215', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1215.svg', '3', '1215.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1304', '1216', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1216.svg', '3', '1216.svg', '13', '33.00', '', '33ccff', '1');
INSERT INTO `material` VALUES ('1305', '1217', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1217.svg', '1', '1217.svg', '13', '33.00', '', '66cc00', '0');
INSERT INTO `material` VALUES ('1306', '1218', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1218.svg', '5', '1218.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1307', '1219', '10', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1219.svg', '1', '1219.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1308', '1220', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1220.svg', '7', '1220.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1309', '1220', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1221.svg', '1', '1221.svg', '13', '33.00', '', '339900', '0');
INSERT INTO `material` VALUES ('1310', '1222', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1222.svg', '9', '1222.svg', '13', '33.00', '', '999999', '0');
INSERT INTO `material` VALUES ('1311', '1223', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1223.svg', '8', '1223.svg', '13', '33.00', '', 'ff0099', '0');
INSERT INTO `material` VALUES ('1312', '1224', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1224.svg', '1', '1224.svg', '13', '33.00', '', '669933', '0');
INSERT INTO `material` VALUES ('1313', '1225', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1225.svg', '3', '1225.svg', '13', '33.00', '', '66cc33', '0');
INSERT INTO `material` VALUES ('1314', '1226', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1226.svg', '5', '1226.svg', '13', '33.00', '', '66cccc', '0');
INSERT INTO `material` VALUES ('1315', '1227', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1227.svg', '9', '1227.svg', '13', '33.00', '', 'cc0033', '0');
INSERT INTO `material` VALUES ('1316', '1228', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1228.svg', '3', '1228.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1317', '1229', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1229.svg', '3', '1229.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1319', '1231', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1231.svg', '7', '1231.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1320', '1232', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1232.svg', '3', '1232.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1321', '1234', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1234.svg', '8', '1234.svg', '13', '33.00', '', 'cc3399', '0');
INSERT INTO `material` VALUES ('1322', '1235', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1235.svg', '7', '1235.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1323', '1236', '8', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/1236.svg', '3', '1236.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1324', '41', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/41.svg', '1', '41.svg', '13', '33.00', '', '669933', '0');
INSERT INTO `material` VALUES ('1325', '42', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/42.svg', '9', '42.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1326', '43', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/43.svg', '5', '43.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1327', '44', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/44.svg', '3', '44.svg', '13', '33.00', '', '006699', '1');
INSERT INTO `material` VALUES ('1328', '45', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/45.svg', '9', '45.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1329', '46', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/46.svg', '3', '46.svg', '13', '33.00', '', '333366', '0');
INSERT INTO `material` VALUES ('1331', '48', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/48.svg', '5', '48.svg', '13', '33.00', '', 'ff6633', '1');
INSERT INTO `material` VALUES ('1332', '49', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/49.svg', '8', '49.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1334', '411', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/411.svg', '3', '411.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1335', '412', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/412.svg', '9', '412.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1336', '413', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/413.svg', '3', '413.svg', '13', '33.00', '', '336699', '1');
INSERT INTO `material` VALUES ('1338', '415', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/415.svg', '3', '415.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1339', '416', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/416.svg', '3', '416.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1340', '417', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/417.svg', '9', '417.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1341', '418', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/418.svg', '9', '418.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1342', '419', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/419.svg', '9', '419.svg', '13', '33.00', '', 'cc3333', '1');
INSERT INTO `material` VALUES ('1343', '430', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/430.svg', '1', '430.svg', '13', '33.00', '', '339933', '0');
INSERT INTO `material` VALUES ('1345', '432', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/432.svg', '3', '432.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1346', '433', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/433.svg', '3', '433.svg', '13', '33.00', '', '003399', '0');
INSERT INTO `material` VALUES ('1347', '434', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/434.svg', '8', '434.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1348', '420', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/420.svg', '9', '420.svg', '13', '33.00', '', 'cc3333', '1');
INSERT INTO `material` VALUES ('1349', '421', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/421.svg', '1', '421.svg', '13', '33.00', '', '006633', '0');
INSERT INTO `material` VALUES ('1350', '422', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/422.svg', '9', '422.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1351', '423', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/423.svg', '5', '423.svg', '13', '33.00', '', '003333', '0');
INSERT INTO `material` VALUES ('1353', '425', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/425.svg', '9', '425.svg', '13', '33.00', '', '003333', '0');
INSERT INTO `material` VALUES ('1354', '426', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/426.svg', '6', '426.svg', '13', '33.00', '', '009999', '0');
INSERT INTO `material` VALUES ('1356', '428', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/428.svg', '5', '428.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1357', '429', '7', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/429.svg', '7', '429.svg', '13', '33.00', '', 'cccc66', '0');
INSERT INTO `material` VALUES ('1359', '51', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/51.svg', '1', '51.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1360', '52', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/52.svg', '7', '52.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1361', '53', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/53.svg', '7', '53.svg', '13', '33.00', '', 'cc6699', '0');
INSERT INTO `material` VALUES ('1362', '54', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/54.svg', '2', '54.svg', '13', '33.00', '', '996699', '0');
INSERT INTO `material` VALUES ('1365', '58', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/58.svg', '7', '58.svg', '13', '33.00', '', 'ff3366', '0');
INSERT INTO `material` VALUES ('1366', '59', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/59.svg', '8', '59.svg', '13', '33.00', '', '663399', '0');
INSERT INTO `material` VALUES ('1367', '510', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/510.svg', '3', '510.svg', '13', '33.00', '', '339999', '0');
INSERT INTO `material` VALUES ('1368', '511', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/512.svg', '9', '512.svg', '13', '33.00', '', 'ff0000', '0');
INSERT INTO `material` VALUES ('1369', '513', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/513.svg', '1', '513.svg', '13', '33.00', '', '66cc33', '0');
INSERT INTO `material` VALUES ('1372', '516', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/516.svg', '7', '516.svg', '13', '33.00', '', '990033', '0');
INSERT INTO `material` VALUES ('1373', '517', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/517.svg', '3', '517.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1374', '518', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/518.svg', '1', '518.svg', '13', '33.00', '', '669933', '0');
INSERT INTO `material` VALUES ('1375', '519', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/519.svg', '7', '519.svg', '13', '33.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1376', '520', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/520.svg', '5', '520.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1377', '521', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/521.svg', '3', '521.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1378', '522', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/522.svg', '5', '522.svg', '13', '33.00', '', 'cc6666', '1');
INSERT INTO `material` VALUES ('1379', '523', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/523.svg', '1', '523.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1380', '524', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/524.svg', '3', '524.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1381', '525', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/525.svg', '3', '525.svg', '13', '33.00', '', '669933', '0');
INSERT INTO `material` VALUES ('1382', '526', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/526.svg', '1', '526.svg', '13', '33.00', '', '99ccff', '0');
INSERT INTO `material` VALUES ('1383', '527', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/527.svg', '3', '527.svg', '13', '33.00', '', '99cccc', '0');
INSERT INTO `material` VALUES ('1384', '528', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/528.svg', '8', '528.svg', '13', '33.00', '', 'cc3366', '0');
INSERT INTO `material` VALUES ('1385', '529', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/529.svg', '1', '529.svg', '13', '33.00', '', '669933', '0');
INSERT INTO `material` VALUES ('1387', '531', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/531.svg', '7', '531.svg', '13', '33.00', '', 'ff9933', '1');
INSERT INTO `material` VALUES ('1388', '532', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/532.svg', '1', '532.svg', '13', '33.00', '', '99cc33', '0');
INSERT INTO `material` VALUES ('1389', '533', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/533.svg', '8', '533.svg', '13', '33.00', '', '993366', '0');
INSERT INTO `material` VALUES ('1390', '534', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/534.svg', '7', '534.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1391', '535', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/535.svg', '3', '535.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1392', '536', '5', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/536.svg', '4', '536.svg', '13', '33.00', '', 'ff6633', '0');
INSERT INTO `material` VALUES ('1393', '61', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/61.svg', '4', '61.svg', '13', '33.00', '', 'ffcc33', '0');
INSERT INTO `material` VALUES ('1394', '62', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/62.svg', '3', '62.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1395', '63', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/63.svg', '3', '63.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1397', '65', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/65.svg', '3', '65.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1398', '66', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/66.svg', '5', '66.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1400', '69', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/69.svg', '3', '69.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1401', '610', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/610.svg', '3', '610.svg', '13', '33.00', '', '0099ff', '0');
INSERT INTO `material` VALUES ('1402', '611', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/611.svg', '2', '611.svg', '13', '33.00', '', 'ff9900', '0');
INSERT INTO `material` VALUES ('1404', '613', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/613.svg', '3', '613.svg', '13', '33.00', '', '666666', '0');
INSERT INTO `material` VALUES ('1405', '614', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/614.svg', '1', '614.svg', '13', '33.00', '', '669966', '0');
INSERT INTO `material` VALUES ('1406', '615', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/615.svg', '7', '615.svg', '13', '33.00', '', 'ff3366', '0');
INSERT INTO `material` VALUES ('1407', '617', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/617.svg', '3', '617.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1408', '618', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/618.svg', '3', '618.svg', '13', '33.00', '', '669999', '0');
INSERT INTO `material` VALUES ('1409', '619', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/619.svg', '3', '619.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1410', '620', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/620.svg', '3', '620.svg', '13', '33.00', '', '003366', '0');
INSERT INTO `material` VALUES ('1411', '621', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/621.svg', '8', '621.svg', '13', '33.00', '', '6633cc', '0');
INSERT INTO `material` VALUES ('1412', '622', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/622.svg', '3', '622.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1413', '623', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/623.svg', '3', '623.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1414', '624', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/624.svg', '4', '624.svg', '13', '33.00', '', 'ff3300', '0');
INSERT INTO `material` VALUES ('1415', '625', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/625.svg', '5', '625.svg', '13', '33.00', '', 'ffcc00', '1');
INSERT INTO `material` VALUES ('1416', '626', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/626.svg', '3', '626.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1417', '627', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/627.svg', '3', '627.svg', '13', '33.00', '', '0099ff', '0');
INSERT INTO `material` VALUES ('1418', '628', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/628.svg', '5', '628.svg', '13', '33.00', '', '6699cc', '0');
INSERT INTO `material` VALUES ('1419', '629', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/629.svg', '5', '629.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1420', '630', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/630.svg', '3', '630.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1421', '631', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/631.svg', '7', '631.svg', '13', '33.00', '', '666600', '0');
INSERT INTO `material` VALUES ('1422', '632', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/632.svg', '2', '632.svg', '13', '33.00', '', '009933', '0');
INSERT INTO `material` VALUES ('1423', '633', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/633.svg', '3', '633.svg', '13', '33.00', '', '0066cc', '0');
INSERT INTO `material` VALUES ('1424', '634', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/634.svg', '3', '634.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1425', '635', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/635.svg', '4', '635.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1426', '308', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/308.svg', '6', '308.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1427', '309', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/309.svg', '3', '309.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1428', '310', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/310.svg', '5', '310.svg', '13', '33.00', '', '999999', '0');
INSERT INTO `material` VALUES ('1429', '311', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/311.svg', '4', '311.svg', '13', '33.00', '', 'cc6666', '0');
INSERT INTO `material` VALUES ('1430', '312', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/312.svg', '3', '312.svg', '13', '33.00', '', '0099ff', '0');
INSERT INTO `material` VALUES ('1431', '313', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/313.svg', '3', '313.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1432', '314', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/314.svg', '1', '314.svg', '13', '33.00', '', '66cccc', '0');
INSERT INTO `material` VALUES ('1433', '315', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/315.svg', '3', '315.svg', '13', '33.00', '', '003333', '0');
INSERT INTO `material` VALUES ('1435', '317', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/317.svg', '5', '317.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1436', '318', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/318.svg', '3', '318.svg', '13', '33.00', '', '33ccff', '0');
INSERT INTO `material` VALUES ('1437', '319', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/319.svg', '5', '319.svg', '13', '33.00', '', '003333', '0');
INSERT INTO `material` VALUES ('1438', '320', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/320.svg', '3', '320.svg', '13', '33.00', '', '006699', '0');
INSERT INTO `material` VALUES ('1439', '312', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/321.svg', '5', '321.svg', '13', '33.00', '', '333333', '0');
INSERT INTO `material` VALUES ('1440', '322', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/322.svg', '9', '322.svg', '13', '33.00', '', 'ff3366', '0');
INSERT INTO `material` VALUES ('1441', '323', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/323.svg', '9', '323.svg', '13', '33.00', '', '990000', '0');
INSERT INTO `material` VALUES ('1443', '325', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/325.svg', '3', '325.svg', '13', '33.00', '', '3399cc', '0');
INSERT INTO `material` VALUES ('1444', '326', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/326.svg', '3', '326.svg', '13', '33.00', '', '0099cc', '0');
INSERT INTO `material` VALUES ('1446', '328', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/328.svg', '8', '328.svg', '13', '33.00', '', '996699', '0');
INSERT INTO `material` VALUES ('1448', '330', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/330.svg', '1', '330.svg', '13', '33.00', '', '33cccc', '0');
INSERT INTO `material` VALUES ('1449', '331', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/331.svg', '9', '331.svg', '13', '33.00', '', 'cc3333', '0');
INSERT INTO `material` VALUES ('1450', '332', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/332.svg', '1', '332.svg', '13', '33.00', '', '006666', '0');
INSERT INTO `material` VALUES ('1451', '333', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/333.svg', '9', '333.svg', '13', '33.00', '', 'cc0033', '0');
INSERT INTO `material` VALUES ('1452', '334', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/334.svg', '3', '334.svg', '13', '33.00', '', 'ffffff', '0');
INSERT INTO `material` VALUES ('1453', '335', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/335.svg', '2', '335.svg', '13', '33.00', '', '003366', '0');
INSERT INTO `material` VALUES ('1454', '336', '6', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/336.svg', '4', '336.svg', '13', '33.00', '', 'ff9933', '0');
INSERT INTO `material` VALUES ('1455', 'A1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/A1.svg', '2', 'A1.svg', '13', '33.00', 'a', 'cc3399', '1');
INSERT INTO `material` VALUES ('1456', 'b1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/B1.svg', '7', 'B1.svg', '13', '33.00', 'b', 'ffffff', '1');
INSERT INTO `material` VALUES ('1457', 'c1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/C1.svg', '7', 'C1.svg', '13', '33.00', 'c', '99cc33', '1');
INSERT INTO `material` VALUES ('1458', 'd1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/D1.svg', '3', 'D1.svg', '13', '33.00', 'd', '99cc33', '1');
INSERT INTO `material` VALUES ('1459', 'e1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/E 1.svg', '2', 'E 1.svg', '13', '33.00', 'e', 'ffffff', '1');
INSERT INTO `material` VALUES ('1460', 'F1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/F1.svg', '8', 'F1.svg', '13', '33.00', 'f', 'cc3399', '1');
INSERT INTO `material` VALUES ('1461', 'G1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/G1.svg', '1', 'G1.svg', '13', '33.00', 'g', '99cc33', '1');
INSERT INTO `material` VALUES ('1462', 'h1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/H1.svg', '3', 'H1.svg', '13', '33.00', 'h', '3399cc', '1');
INSERT INTO `material` VALUES ('1463', 'i1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/I1.svg', '1', 'I1.svg', '13', '33.00', 'i', '99cc33', '1');
INSERT INTO `material` VALUES ('1464', 'J1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/J1.svg', '3', 'J1.svg', '13', '33.00', 'j', '3399cc', '1');
INSERT INTO `material` VALUES ('1465', 'K1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/K1.svg', '7', 'K1.svg', '13', '33.00', 'k', '336699', '1');
INSERT INTO `material` VALUES ('1466', 'l1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/L1svg.svg', '2', 'L1svg.svg', '13', '33.00', 'l', 'ff6633', '1');
INSERT INTO `material` VALUES ('1467', 'm1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/M1.svg', '2', 'M1.svg', '13', '33.00', 'm', 'ffcc00', '1');
INSERT INTO `material` VALUES ('1468', 'n1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/N1.svg', '3', 'N1.svg', '13', '33.00', 'n', '99cc33', '1');
INSERT INTO `material` VALUES ('1469', 'o1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/O1.svg', '3', 'O1.svg', '13', '33.00', 'o', '99cc33', '1');
INSERT INTO `material` VALUES ('1470', 'p1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/P1.svg', '8', 'P1.svg', '13', '33.00', 'p', '336699', '1');
INSERT INTO `material` VALUES ('1471', 'q1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Q0001.svg', '1', 'Q0001.svg', '13', '33.00', 'q', '99cc33', '1');
INSERT INTO `material` VALUES ('1473', 'r1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/R1.svg', '8', 'R1.svg', '13', '33.00', 'r', 'ff3366', '1');
INSERT INTO `material` VALUES ('1475', 't', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/T0001.svg', '2', 'T0001.svg', '13', '33.00', 't', 'ffcc00', '1');
INSERT INTO `material` VALUES ('1476', 'u1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/U001.svg', '7', 'U001.svg', '13', '33.00', 'u', 'ffcc00', '1');
INSERT INTO `material` VALUES ('1477', 'v', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/V0001.svg', '3', 'V0001.svg', '13', '33.00', 'v', 'cccc33', '1');
INSERT INTO `material` VALUES ('1479', 'x', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/X001.svg', '4', 'X001.svg', '13', '33.00', 'x', '3399cc', '1');
INSERT INTO `material` VALUES ('1480', 'y1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Y001.svg', '1', 'Y001.svg', '13', '33.00', 'y', 'cccc33', '1');
INSERT INTO `material` VALUES ('1481', 'z1', '1', 'http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/Z0004.svg', '3', 'Z0004.svg', '13', '33.00', 'z', '3399cc', '1');

-- ----------------------------
-- Table structure for material_type
-- ----------------------------
DROP TABLE IF EXISTS `material_type`;
CREATE TABLE `material_type` (
  `material_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '素材分类id',
  `name` varchar(255) DEFAULT NULL COMMENT '素材的名字',
  PRIMARY KEY (`material_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='素材分类表';

-- ----------------------------
-- Records of material_type
-- ----------------------------
INSERT INTO `material_type` VALUES ('1', '1');
INSERT INTO `material_type` VALUES ('2', '鸟');
INSERT INTO `material_type` VALUES ('3', '圆形');
INSERT INTO `material_type` VALUES ('4', '方形');
INSERT INTO `material_type` VALUES ('5', '椭圆');
INSERT INTO `material_type` VALUES ('6', '字母A');
INSERT INTO `material_type` VALUES ('7', '猫');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单号',
  `user_id` int(11) DEFAULT NULL COMMENT ' 用户iD',
  `order_stage` varchar(255) DEFAULT '0' COMMENT '0为未付款，1为已付款',
  `logonameurl` varchar(255) DEFAULT NULL COMMENT 'logo名字',
  `paytype` varchar(255) DEFAULT NULL COMMENT '订单支付类型',
  `paymoney` varchar(255) DEFAULT NULL COMMENT '订单支付金额',
  `creat_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `material_id` int(11) DEFAULT NULL COMMENT '素材表ID',
  `pngurl` varchar(255) DEFAULT NULL COMMENT 'png',
  `jpgurl` varchar(255) DEFAULT NULL COMMENT 'jpg',
  `logoname_en` varchar(500) DEFAULT '' COMMENT '英文',
  `industry_id` int(11) NOT NULL DEFAULT '0' COMMENT '行业id',
  `mobile` varchar(20) DEFAULT '' COMMENT '电话号码',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3916 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('1', '3234', '35757', '1', '24234234', 'wechat', '3', '2021-07-01 22:01:56', '234', '23423', '23442', '', '0', '', null);
INSERT INTO `order` VALUES ('2', '3234333', '35757', '0', '24234234', 'alipay', '33', '2021-07-01 22:01:56', '234', '23423', '23442', '', '0', '', null);
INSERT INTO `order` VALUES ('3915', 'L919569861686408', '71136', '0', '非法', null, null, '2021-09-19 21:09:46', null, null, null, null, '0', '15888888888', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户表的ID',
  `phone` bigint(20) DEFAULT NULL COMMENT '用户手机号，即账号',
  `pwd` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `reg_time` datetime DEFAULT NULL COMMENT '用户注册时间',
  `reg_ip` varchar(255) DEFAULT NULL COMMENT '用户注册IP',
  `reg_address` varchar(255) DEFAULT NULL COMMENT '用户注册地址',
  `reg_client` varchar(255) DEFAULT NULL COMMENT '注册的客户端，0为移动端1为PC端',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `unique_user_phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71137 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('71136', '15888888888', '3622f779e640626043da7f22514aa41a', '2021-09-19 21:08:59', '127.0.0.1', 'http://logo.com/wap/index/order.html', '0');
