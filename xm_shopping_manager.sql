/*
 Navicat Premium Data Transfer

 Source Server         : manager
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : xm_shopping_manager

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 31/12/2024 10:23:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人',
  `useraddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货地址',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '地址信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, 'liyi', '湖南省长沙市岳麓区', '19106001894');
INSERT INTO `address` VALUES (2, 1, 'zhangsan', '广东省广州市白云区', '17371457171');
INSERT INTO `address` VALUES (3, 1, 'lier', '南京市热河路', '19156563896');
INSERT INTO `address` VALUES (4, 1, 'lisi', '北京市海淀区', '15111193585');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1735611708542-1733909633270-456.png', 'ADMIN', '13677889922', 'admin@xm.com');

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '店铺名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商家介绍',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商家信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of business
-- ----------------------------
INSERT INTO `business` VALUES (1, 'kakaxi', '123456', '电脑家具店', 'http://localhost:9090/files/1733795817483-1697438073596-avatar.png', 'BUSINESS', '19191919199', 'liyi777kk@gmail.com', '', '审核通过');
INSERT INTO `business` VALUES (2, 'kafuka', '123456', '男装箱包店', 'http://localhost:9090/files/1733795947856-1699252742825-柴犬.jpeg', 'BUSINESS', '19106001894', 'opopKeep@163.com', '', '审核通过');
INSERT INTO `business` VALUES (3, 'kakaka', '123456', '女装饰品店', 'http://localhost:9090/files/1733795987102-1699015621841-汽车配件.png', 'BUSINESS', '1564132156', 'qiwu3302@gmail.com', '', '审核通过');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `business_id` int NULL DEFAULT NULL COMMENT '店铺ID',
  `num` int NULL DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '购物车表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (5, 3, 6, 1, 1);

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `business_id` int NULL DEFAULT NULL COMMENT '店铺ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (11, 2, 32, 2);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `business_id` int NULL DEFAULT NULL COMMENT '店铺ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品主图',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '商品介绍',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '计件单位',
  `count` int NULL DEFAULT 0 COMMENT '商品销量',
  `type_id` int NULL DEFAULT NULL COMMENT '分类ID',
  `business_id` int NULL DEFAULT NULL COMMENT '商家ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (6, 'Dell_戴尔灵越15.6英寸轻薄笔记本电脑英特尔学习游戏办公商务手提剪辑PS设计pr高性能本官方旗舰店', 'http://localhost:9090/files/1733898705842-2.jpg', '<p><img src=\"http://localhost:9090/files/1733899977949-2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899982335-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899985207-4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899988803-5.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 5999.00, '件', 7, 12, 1);
INSERT INTO `goods` VALUES (7, '荣耀笔记本电脑商务办公大学生i7吃鸡游戏本剪辑设计i5便携', 'http://localhost:9090/files/1733898736536-1.jpg', '<p><img src=\"http://localhost:9090/files/1733900017066-2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900021068-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900024699-4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900028881-5.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 1000.00, '件', 1, 12, 1);
INSERT INTO `goods` VALUES (8, '小米笔记本电脑办公商务大学生网课超轻薄i7游戏本手提i5', 'http://localhost:9090/files/1733900046549-1.jpg', '<p><img src=\"http://localhost:9090/files/1733900050950-2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900056013-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900059967-4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900062970-5.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 1000.00, '件', 5, 12, 1);
INSERT INTO `goods` VALUES (9, '联想台式电脑主机商务办公采购高配游戏设计学习全套六核电脑整机', 'http://localhost:9090/files/1733900136315-详情图片_02_20231120_090404.jpg', '<p><img src=\"http://localhost:9090/files/1733900123681-详情图片_01.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900128640-详情图片_02_20231120_090404.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900146399-详情图片_07.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900154567-详情图片_10.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 5999.00, '台', 5, 12, 1);
INSERT INTO `goods` VALUES (10, 'SK品牌2.1A快充 3C认证 充电器防爆适用苹果 安卓 华为 OPPO vivo', 'http://localhost:9090/files/1733898930092-1.jpg', '<p><img src=\"http://localhost:9090/files/1733900201655-2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900206864-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900210659-4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900214222-5.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 69.00, '件', 13, 11, 1);
INSERT INTO `goods` VALUES (11, '无线蓝牙游戏耳机真无线炫彩发光 TWS游戏电竞蓝牙耳机', 'http://localhost:9090/files/1733900243926-2.jpg', '<p><img src=\"http://localhost:9090/files/1733900250437-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900256597-4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733900259545-1.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 199.00, '个', 4, 11, 1);
INSERT INTO `goods` VALUES (12, '真维斯秋冬装卫衣男新款纯色圆领百搭休闲潮牌加绒长袖上衣服男士', 'http://localhost:9090/files/1733987143560-1.png', '<p><img src=\"http://localhost:9090/files/1733987154052-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899116470-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899123895-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899129237-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 169.00, '件', 3, 15, 2);
INSERT INTO `goods` VALUES (13, '啄木鸟灯芯绒外套男秋冬季加绒加厚中老年羊羔绒棉衣休闲夹克男装', 'http://localhost:9090/files/1733899142193-d3.png', '<p><img src=\"http://localhost:9090/files/1733899205077-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899211692-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899216006-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 299.00, '件', 4, 15, 2);
INSERT INTO `goods` VALUES (14, '森马集团GENIOLAMODE连帽外套男开衫熊猫春秋季大码灰色薄款卫衣', 'http://localhost:9090/files/1733899277311-1.png', '<p><img src=\"http://localhost:9090/files/1733899301544-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899306960-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899310604-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899314069-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 129.00, '件', 7, 15, 2);
INSERT INTO `goods` VALUES (15, '设计感修身短款t恤女夏季新款圆领薄款短袖白色高腰紧身露脐上衣', 'http://localhost:9090/files/1733899503344-1.png', '<p><img src=\"http://localhost:9090/files/1733899530658-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899536765-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899540409-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899544125-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 99.00, '件', 1, 16, 3);
INSERT INTO `goods` VALUES (16, '美式复古短袖T恤女纯棉夏ins潮半袖2023年新款设计感小众v领体桖', 'http://localhost:9090/files/1733899559160-1.png', '<p><img src=\"http://localhost:9090/files/1733899588617-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899594089-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899598704-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899603591-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 59.00, '件', 1, 16, 3);
INSERT INTO `goods` VALUES (17, 'MsShe大码女装新款胖mm夏装遮肚子200斤裹胸显瘦碎花连体泳衣', 'http://localhost:9090/files/1733899633533-1.png', '<p><img src=\"http://localhost:9090/files/1733899677658-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899680862-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899684773-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899687798-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899691206-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899694942-d6.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 119.00, '件', 2, 16, 3);
INSERT INTO `goods` VALUES (18, 'MsShe大码女装新款叠穿松紧腰配饰假两件系扣衬衫下摆屁帘', 'http://localhost:9090/files/1733899716377-1.png', '<p><img src=\"http://localhost:9090/files/1733899740196-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899743314-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899746157-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899749559-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 39.00, '件', 1, 16, 3);
INSERT INTO `goods` VALUES (19, 'JEEP吉普休闲夹克男士外套春秋季潮牌工装宽松青年潮流连帽上衣服', 'http://localhost:9090/files/1733899865161-1.png', '<p><img src=\"http://localhost:9090/files/1733899890732-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899894564-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899897979-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733899901773-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 159.00, '件', 1, 15, 2);
INSERT INTO `goods` VALUES (20, '新中式沙发组合客厅别墅大小户型现代简约轻奢高端全实木定制家具', 'http://localhost:9090/files/1733901090309-1.png', '<p><img src=\"http://localhost:9090/files/1733901124642-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901129654-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901134948-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901140716-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901145693-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 4999.00, '件', 1, 6, 1);
INSERT INTO `goods` VALUES (21, '新款主卧室灯led吸顶灯简约现代大气圆形阳台客厅房间灯具', 'http://localhost:9090/files/1733901178041-1.png', '<p><img src=\"http://localhost:9090/files/1733901203341-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901207067-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901210479-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901214275-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 88.00, '个', 10, 6, 1);
INSERT INTO `goods` VALUES (22, '铜洗脸盆水龙头冷热水家用卫生间洗手池洗漱台面盆浴室柜单龙头 1件装', 'http://localhost:9090/files/1733901227028-1.png', '<p><img src=\"http://localhost:9090/files/1733901252079-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901255656-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901260320-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901264268-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901267714-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 19.00, '个', 3, 6, 1);
INSERT INTO `goods` VALUES (23, '霖朗客厅主灯现代简约大气led吸顶灯新款中山灯具长方形超薄', 'http://localhost:9090/files/1733901280487-1.png', '<p><img src=\"http://localhost:9090/files/1733901308348-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901312351-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901315762-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901320353-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901324277-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901329640-d6.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901333694-d7.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 599.00, '个', 1, 6, 1);
INSERT INTO `goods` VALUES (24, '白色毛巾架免打孔浴室卫生间卫浴五金挂件套装浴巾架置物架五件套', 'http://localhost:9090/files/1733901349099-1.png', '<p><img src=\"http://localhost:9090/files/1733901374725-d1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901377992-d2.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901382219-d3.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901385525-d4.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901389541-d5.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901393438-d6.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 129.00, '个', 1, 6, 1);
INSERT INTO `goods` VALUES (25, '斜挎包大容量运动款男腰包简约百搭斜跨单肩包时尚学生背包', 'http://localhost:9090/files/1733901511711-2.jpg', '<p><img src=\"http://localhost:9090/files/1733901547734-4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901551942-5.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901555722-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901564204-详情图片_25.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733901570332-详情图片_20.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 32.00, '个', 1, 14, 2);
INSERT INTO `goods` VALUES (26, '复古大容量双肩包 韩版男包男士旅行背包时尚书包通勤电脑包', 'http://localhost:9090/files/1733901590847-详情图片_02.jpg', '<p><img src=\"http://localhost:9090/files/1733901630261-2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 129.00, '个', 3, 14, 2);
INSERT INTO `goods` VALUES (27, 'Estee Lauder雅诗兰黛鲜活亮采红石榴保湿洁面乳', 'http://localhost:9090/files/1733908877187-1.jpg', '<p><img src=\"http://localhost:9090/files/1733908919946-2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733908923682-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733908931752-d1.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733908935262-d2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733908938680-d3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733908944219-d6.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733908947129-d9.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 99.00, '支', 5, 13, 3);
INSERT INTO `goods` VALUES (28, '阿玛尼红黑管挚爱哑光雾面滋润唇膏口红', 'http://localhost:9090/files/1733909037727-1.jpg', '<p><img src=\"http://localhost:9090/files/1733909064146-2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909067814-3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909071365-4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909074986-d1.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909078398-d2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909081551-d3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 279.00, '支', 1, 13, 3);
INSERT INTO `goods` VALUES (29, 'Dior迪奥香水花漾甜心小样持久淡香真我女士伴手礼盒', 'http://localhost:9090/files/1733909115481-1.jpg', '<p><img src=\"http://localhost:9090/files/1733909145478-d1.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909149705-d2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909153251-d3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 199.00, '瓶', 1, 13, 3);
INSERT INTO `goods` VALUES (30, 'YSL圣罗兰香水小样礼盒装', 'http://localhost:9090/files/1733909174126-1.jpg', '<p><img src=\"http://localhost:9090/files/1733909226682-d1.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909230430-d2.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909234912-d3.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909242132-d4.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909245528-d5.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909249663-d6.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1733909252705-d7.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 399.00, '瓶', 1, 13, 3);
INSERT INTO `goods` VALUES (31, '男鞋新款冬季潮流百搭防滑防臭工作皮鞋男士休闲黑色板鞋', 'http://localhost:9090/files/1734526251869-主图_2.jpg', '<p><img src=\"http://localhost:9090/files/1734526308673-01.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1734526312513-02.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1734526318309-03.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 199.00, '双', 2, 14, 2);
INSERT INTO `goods` VALUES (32, '男鞋年秋季官网新款学生舒适百搭休闲鞋运动鞋', 'http://localhost:9090/files/1734526837343-主图_5.jpg', '<p><img src=\"http://localhost:9090/files/1734526880501-02.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/1734526885071-详情图片_07.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 599.00, '双', 5, 14, 2);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '“双12大促会”', '每满300减40，每晚8点-12.12热卖中', '2024-12-10', 'admin');
INSERT INTO `notice` VALUES (2, '狂撒亿元红包 天天买天天领', '搜索下单返红包,回来领红包，多买多得！', '2024-12-10', 'admin');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单ID',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `business_id` int NULL DEFAULT NULL COMMENT '商家ID',
  `num` int NULL DEFAULT NULL COMMENT '商品数量',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT '订单价格',
  `addressId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址ID',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类描述',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, '图书音像', '这是图书音像', 'http://localhost:9090/files/1733735205669-图书音像.png');
INSERT INTO `type` VALUES (2, '厨具 / 收纳 / 宠物', '这是厨具 / 收纳 / 宠物', 'http://localhost:9090/files/1733735493560-1699015709389-母婴玩具.png');
INSERT INTO `type` VALUES (3, '医药 / 保健品', '这是医药 / 保健品', 'http://localhost:9090/files/1733735471439-1699015585629-医药保健.png');
INSERT INTO `type` VALUES (4, '家纺 / 家饰 / 鲜花', '这是家纺 / 家饰 / 鲜花', 'http://localhost:9090/files/1733735456530-1699015602362-家纺家饰.png');
INSERT INTO `type` VALUES (5, '汽车 / 配件 / 用品', '这是汽车 / 配件 / 用品', 'http://localhost:9090/files/1733735444121-1699015621841-汽车配件.png');
INSERT INTO `type` VALUES (6, '家具 / 灯具 / 卫浴', '这是家具 / 灯具 / 卫浴', 'http://localhost:9090/files/1733735415309-1699015637219-家具建材.png');
INSERT INTO `type` VALUES (7, '生活电器 / 生活用品', '这是生活电器 / 生活用品', 'http://localhost:9090/files/1733735402829-1699015658084-家用电器.png');
INSERT INTO `type` VALUES (8, '水果 / 生鲜', '水果 / 生鲜', 'http://localhost:9090/files/1733735388979-1699015679164-喵鲜生.png');
INSERT INTO `type` VALUES (9, '零食 / 茶酒 / 进口食品', '这是零食 / 茶酒 / 进口食品', 'http://localhost:9090/files/1733735382177-1699015694567-食品.png');
INSERT INTO `type` VALUES (10, '母婴 / 玩具', '这是母婴 / 玩具', 'http://localhost:9090/files/1733735368089-1699015709389-母婴玩具.png');
INSERT INTO `type` VALUES (11, '手机 / 数码 / 配件', '这是手机 / 数码 / 配件', 'http://localhost:9090/files/1733735355866-1699015723293-数码手机.png');
INSERT INTO `type` VALUES (12, '电脑 / 电子办公 / 配件', '这是电脑 / 电子办公 / 配件', 'http://localhost:9090/files/1733735349201-1699015735715-电脑.png');
INSERT INTO `type` VALUES (13, '珠宝 / 护肤 / 饰品', '这是珠宝 / 护肤 / 饰品', 'http://localhost:9090/files/1733735342848-1699015765623-珠宝饰品.png');
INSERT INTO `type` VALUES (14, '女鞋 / 男鞋 / 箱包', '这是女鞋 / 男鞋 / 箱包', 'http://localhost:9090/files/1733735333007-1699015794478-鞋_箱包.png');
INSERT INTO `type` VALUES (15, '精品男装 / 运动户外', '这是精品男装 / 运动户外', 'http://localhost:9090/files/1733735426559-1699015810103-男装.png');
INSERT INTO `type` VALUES (16, '靓丽女装 / 内衣', '这是靓丽女装 / 内衣', 'http://localhost:9090/files/1733735294914-1699015824719-女装内衣.png');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'zhangsan', '123456', 'liyi', 'http://localhost:9090/files/1733909633270-456.png', 'USER', '19106001894', 'coolkafuka@163.com', '湖南省长沙市岳麓区');
INSERT INTO `user` VALUES (2, 'lisi', '123456', '李四', 'http://localhost:9090/files/1733884717718-1699252742825-柴犬.jpeg', 'USER', '1959595956', '115@163.com', '湖南省岳阳市岳阳楼区');
INSERT INTO `user` VALUES (3, 'wangwu', '123456', '王五', 'http://localhost:9090/files/1733886231611-1699015810103-男装.png', 'USER', '1910601894', 'coolkafuka@163.com', '北京市海淀区长安街1号');
INSERT INTO `user` VALUES (4, '哈哈', '123456', 'haha', 'http://localhost:9090/files/1734054670903-1699254328253-柯基.jpeg', 'USER', '19106000184', 'opppo@gmail.com', '广东省广州市白云区');

SET FOREIGN_KEY_CHECKS = 1;
