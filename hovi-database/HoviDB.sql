/*
 Navicat Premium Data Transfer

 Source Server         : HoviDB
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3307
 Source Schema         : HoviDB

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 14/11/2019 16:06:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for amenities
-- ----------------------------
DROP TABLE IF EXISTS `amenities`;
CREATE TABLE `amenities` (
  `amenities_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of amenities',
  `icon_id` varchar(50) DEFAULT NULL COMMENT 'id of icon show UI',
  `usable_name` varchar(255) DEFAULT NULL COMMENT 'Name of amenities when usable',
  `unusable_name` varchar(255) DEFAULT NULL COMMENT 'Name of amenities when unusable',
  `description` text COMMENT 'Description for amenities',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`amenities_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of amenities
-- ----------------------------
BEGIN;
INSERT INTO `amenities` VALUES (1, '1', 'Không chung chủ', 'Chung chủ', 'tự do khu nhà ở', '2019-10-23 12:18:55.952131', '2019-10-23 12:18:55.952131');
INSERT INTO `amenities` VALUES (2, '2', 'Khép kín', 'Chung phòng tắm', 'Khu vực ở có khép kín hay k?', '2019-10-23 12:18:56.705670', '2019-10-23 12:18:56.705670');
INSERT INTO `amenities` VALUES (3, '3', 'Ban công', '', 'Ban công phòng', '2019-10-23 12:18:57.511849', '2019-10-23 12:18:57.511849');
INSERT INTO `amenities` VALUES (4, '4', 'Thang máy', '', '', '2019-10-23 12:18:58.256340', '2019-10-23 12:18:58.256340');
INSERT INTO `amenities` VALUES (5, '5', 'Nuôi thú cưng', '', '', '2019-10-23 12:18:58.982570', '2019-10-23 12:18:58.982570');
INSERT INTO `amenities` VALUES (6, '6', 'Nấu ăn', '', NULL, '2019-10-23 12:18:59.684756', '2019-10-23 12:18:59.684756');
INSERT INTO `amenities` VALUES (7, '7', 'Điều hòa', '', NULL, '2019-10-23 12:19:00.887824', '2019-10-23 12:19:00.887824');
INSERT INTO `amenities` VALUES (8, '8', 'Bình nóng lạnh', '', NULL, '2019-10-23 12:19:01.625316', '2019-10-23 12:19:01.625316');
INSERT INTO `amenities` VALUES (9, '9', 'Giường', '', NULL, '2019-10-23 12:19:02.765866', '2019-10-23 12:19:02.765866');
INSERT INTO `amenities` VALUES (10, '10', 'Tủ', '', NULL, '2019-10-23 12:19:04.547522', '2019-10-23 12:19:04.547522');
INSERT INTO `amenities` VALUES (11, '11', 'Bàn ghế', '', NULL, '2019-10-23 12:19:05.396939', '2019-10-23 12:19:05.396939');
COMMIT;

-- ----------------------------
-- Table structure for bank_transfer_history
-- ----------------------------
DROP TABLE IF EXISTS `bank_transfer_history`;
CREATE TABLE `bank_transfer_history` (
  `transfer_id` int(4) NOT NULL AUTO_INCREMENT COMMENT 'ID of the bank transferation',
  `sender_user_id` int(5) DEFAULT NULL COMMENT 'Sender user id',
  `sender_bank` varchar(255) DEFAULT NULL COMMENT 'Bank of sender',
  `sender_account_number` varchar(255) DEFAULT NULL COMMENT 'Sender account number',
  `sender_user_type` tinyint(1) DEFAULT NULL COMMENT 'Sender user type',
  `receiver_user_id` int(5) DEFAULT NULL COMMENT 'Receiver user id',
  `receiver_bank` varchar(255) DEFAULT NULL COMMENT 'Bank of receiver',
  `receiver_account_number` varchar(255) DEFAULT NULL COMMENT 'Receiver account number',
  `receiver_user_type` tinyint(1) DEFAULT NULL COMMENT 'Receiver user type',
  `transfer_time` timestamp(6) NULL DEFAULT NULL COMMENT 'Time of transferation',
  `money_amount` double(10,0) DEFAULT NULL COMMENT 'Money amount of the transfer',
  `transfer_note` varchar(255) DEFAULT NULL COMMENT 'Note of transfer',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`transfer_id`) USING BTREE,
  KEY `FK_user_bank_transfer_history-sender_id` (`sender_user_id`) USING BTREE,
  KEY `FK_user_bank_transfer_history-receiver_id` (`receiver_user_id`) USING BTREE,
  CONSTRAINT `FK_user_bank_transfer_history-receiver_id` FOREIGN KEY (`receiver_user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK_user_bank_transfer_history-sender_id` FOREIGN KEY (`sender_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building` (
  `building_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of building',
  `building_name` varchar(255) DEFAULT NULL COMMENT 'name of the building',
  `building_type_id` int(2) DEFAULT NULL COMMENT 'ID of building type',
  `host_id` int(11) DEFAULT NULL COMMENT 'ID of host of building',
  `province` varchar(255) DEFAULT 'default value' COMMENT 'Province of the building',
  `district` varchar(255) DEFAULT NULL COMMENT 'District of the building',
  `ward` varchar(255) DEFAULT NULL COMMENT 'Ward of the building',
  `detailed_address` varchar(255) DEFAULT NULL COMMENT 'Detailed address of the building',
  `address_description` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL COMMENT 'Location of the building',
  `floor_quantity` int(2) DEFAULT '1' COMMENT 'Number of floors in the building',
  `is_verified` bit(1) DEFAULT NULL COMMENT 'Building is verified or not',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`building_id`) USING BTREE,
  KEY `FK_room_type_building` (`building_type_id`) USING BTREE,
  KEY `FK_user_building` (`host_id`) USING BTREE,
  CONSTRAINT `FK_type_building` FOREIGN KEY (`building_type_id`) REFERENCES `building_type` (`type_id`),
  CONSTRAINT `FK_user_building` FOREIGN KEY (`host_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of building
-- ----------------------------
BEGIN;
INSERT INTO `building` VALUES (7, 'Chung cư An Nam', 1, 1, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', '12 giai phong', '', '20.9714041,105.8409441', 23, NULL, NULL, '2019-11-13 08:34:40.081491');
INSERT INTO `building` VALUES (8, 'Chung cư Vincom City', 1, 1, '[\"Hà Nội\",1]', '[\"Nam Từ Liêm\",18]', '[\"Mỹ Đình 2\",2021]', '12 mỹ đình', '', '21.0295126,105.7790821', 16, NULL, NULL, '2019-11-13 08:34:40.081491');
INSERT INTO `building` VALUES (9, 'Nhà trọ Thái Luyện', 3, 1, '[\"Hà Nội\",1]', '[\"Cầu Giấy\",4]', '[\"Mai Dịch\",264]', '12 nguyen phong sac', '', '21.044239,105.790373', 2, NULL, NULL, '2019-11-13 08:34:40.081491');
INSERT INTO `building` VALUES (10, 'Nhà trọ Định Mệnh', 3, 1, '[\"Hà Nội\",1]', '[\"Nam Từ Liêm\",18]', '[\"Phú Đô\",2022]', '12 phu do', '', '21.0079443,105.7667015', 1, NULL, NULL, '2019-11-13 08:34:40.081491');
INSERT INTO `building` VALUES (12, 'Happy House', 1, 22, '[\"Hà Nội\",1]', '[\"Cầu Giấy\",4]', '[\"Nghĩa Đô\",265]', 'Quận 9, Hồ Chí Minh, Campuchia', 'Vừng ơi mở ra', '10.8428402,106.8286851', 1, NULL, NULL, '2019-11-13 15:33:10.578757');
INSERT INTO `building` VALUES (13, 'Chung cư Văn Minh', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Trương Định\",1090]', '78 Trương Định, Hai Bà Trưng, Hà Nội, Việt Nam', 'Nhà mặt đường', '20.993988,105.849651', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (14, 'Happy House', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', '163 Đại La, Đồng Tâm, Hai Bà Trưng, Hà Nội, Việt Nam', 'Rẽ trái cạnh siêu thi Vinmart', '20.9966682,105.8446902', 5, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (15, 'Full House', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Minh Khai\",1081]', '505 Phố Minh Khai, Vĩnh Phú, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi phố Minh Khai xong rẽ trái vào ngõ', '20.9998197,105.8703171', 6, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (16, 'Chung cư tầng 6 Vincom Bà Triệu', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Việt Nam', 'Tòa nhà VinCom Bà Triệu', '21.0114461,105.8500128', 6, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (17, 'Chung cư tầng 7 Vincom Bà Triệu', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Việt Nam', 'Tòa nhà Vincom Bà Triệu', '21.0114461,105.8500128', 7, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (18, 'Chung cư Mới', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Trương Định\",1090]', '1 Phố Minh Khai, Trương Định, Hai Bà Trưng, Hà Nội, Việt Nam', 'Chung cư mới xây mặt đường Trương Định', '20.9959189,105.8503406', 2, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (19, 'Vintage Building', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Trương Định\",1090]', '440 Bạch Mai, Trương Định, Hai Bà Trưng, Hà Nội, Việt Nam', 'Tòa nhà kiểu Pháp trên mặt đường Bạch Mai', '20.9985581,105.8501943', 5, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (20, 'Nhà Mới', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bách Khoa\",1073]', '99 Trần Đại Nghĩa, Bách Khoa, Hai Bà Trưng, Hà Nội, Việt Nam', 'Gần đối diện cổng parabol trường Bách Khoa', '21.0040558,105.8454565', 2, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (21, 'Nhà nguyên căn Trần Đại Nghĩa', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', '2A Trần Đại Nghĩa, Đồng Tâm, Hai Bà Trưng, Hà Nội, Việt Nam', 'Cạnh quán bánh gato trên đường Trần Đại Nghĩa', '21.0035271,105.8446348', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (22, 'Nhà cấp bốn Tạ Quang Bửu', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bách Khoa\",1073]', 'A15 Tạ Quang Bửu, Bách Khoa, Hai Bà Trưng, Hà Nội, Việt Nam', 'Nhà mặt đường màu xanh', '21.0043602,105.847327', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (23, 'Căn hộ Kim Ngưu', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Vĩnh Tuy\",1091]', '461 Kim Ngưu, Vĩnh Tuy, Hai Bà Trưng, Hà Nội, Việt Nam', 'Cạnh quán vịt quay Lạng Sơn Kim Ngưu', '21.0007085,105.8620677', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (24, 'Lucky Apts', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', '221 Thanh Nhàn, Quỳnh Lôi, Hai Bà Trưng, Hà Nội, Việt Nam', 'Như địa chỉ chi tiết', '21.002988,105.8547817', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (25, 'Căn hộ trong ngõ', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', 'Số 112 Phố Lạc Nghiệp, Thanh Nhàn, Hai Bà Trưng, Hà Nội 100000, Việt Nam', 'Trong ngõ Lạc Nghiệp', '21.0080036,105.8570593', 2, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (26, 'Rental Apartment', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Minh Khai\",1081]', '545 Phố Minh Khai, Vĩnh Phú, Hai Bà Trưng, Hà Nội, Việt Nam', 'Căn hộ mặt đường', '21.001197,105.8703589', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (27, 'Cozy house', 2, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Vĩnh Tuy\",1091]', '55 Lạc Trung, Vĩnh Tuy, Hai Bà Trưng, Hà Nội, Việt Nam', '', '21.0028675,105.8664958', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (28, 'Homestay vui vẻ', 3, 16, '[\"Hà Nội\",1]', '[\"Thanh Xuân\",28]', '[\"Nhân Chính\",2631]', '301d Quan Nhân', 'Cạnh tiệm cắt tóc 301 Quan Nhân', '21.007151,105.811867', 1, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (29, 'Nhà trọ Tây Thiên 1', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', 'Số 10 ngõ 252 Tây Sơn', 'Gần đại học Thủy Lợi', '21.0080465,105.8225565', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (30, 'Nhà Trọ Tây Thiên 2', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', 'Số 1/43 ngõ Thanh Miến, Phố Văn Miếu, Phường Văn Miếu, Đống Đa, Hà Nội', '', '21.0294096,105.8375543', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (31, 'Nhà cho hotboy', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Cát Linh\",596]', 'Ngõ 35 ', 'Đối diện đường ray Cát Linh', '21.0290796,105.8285339', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (32, 'Nhà trọ Tây Thiên 3', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', 'Số 12  ngõ 7 ngách 25 Thái Hà', '', '21.010993,105.821965', 4, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (33, 'Nhà trọ Tây Thiên 4', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', 'Số 5 ngõ 3 Thái hà', 'Ngay đầu ngõ', '21.009462,105.8228194', 5, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (34, 'Nhà Trọ Tây Thiên 5', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', 'Sô 5 ngõ 7 Thái Hà', 'Nhà cao nhất ngõ', '21.0102583,105.8222383', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (35, 'Khu trọ FA', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Cát Linh\",596]', 'ngõ số 6 Hàng Cháo', '', '21.030906,105.834197', 3, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (36, 'Nhà trọ Bắc Môn 1', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', 'Số 3 ngõ thổ quan  Tôn Đức Thắng ', 'Nhà đẹp nhất ', '21.0207622,105.8301109', 4, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (37, 'Nhà trọ Bắc Môn 2', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'Số 14 ngõ 252 Tây Sơn', '', '21.0080465,105.8225565', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (38, 'Khu trọ zdui vẻ', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Cát Linh\",596]', 'ngõ số 16 Cát Linh', 'Đến đầu ngõ đi thẳng, rẽ phải đối diện quán bán cháo', '21.0276156,105.8339147', 3, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (39, 'Nhà Trọ Bắc Môn 3', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'Sô 4 ngõ 12/12 Nguyễn Phúc Lai, Đống Đa', '', '21.022445,105.822028', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (40, 'Nhà đẹp sweet home', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Hàng Bột\",597]', 'Số 36B ngõ Văn Chương', '', '21.0234345,105.8325658', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (41, 'Nhà Trọ Bắc Môn 4', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'số 10, ngách 66, ngõ giếng, phố Đông Các', '', '21.0189275,105.8266735', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (42, 'Khu trọ 4.0', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', 'Ngõ 1 ', '125', '21.0216972,105.8299504', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (43, 'Nhà trọ bác Kim', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', 'Phố Khâm Thiên', 'Đối diện Welax', '21.0193276,105.8355011', 4, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (44, 'Nhà trọ chú Sơn', 3, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Lương\",1088]', '16 Lạc Trung, Thanh Lương, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi vào ngõ hỏi nhà trọ chú Sơn', '21.0031073,105.8619436', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (45, 'Nhà trọ bác Anh', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', 'Ngõ 42 Vũ Ngọc Phan ', '', '21.0148813,105.8103552', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (46, 'Nhà trọ khu Bách Khoa', 3, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bách Khoa\",1073]', '14/40 Tạ Quang Bửu, Bách Khoa, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi vào trong ngõ của siêu thị', '21.0040972,105.8471699', 1, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (47, 'Nhà trọ anh Tùng', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', 'Ngõ 100 phố Vương Thừa Vũ', '', '21.0003741,105.8233757', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (48, 'Nhà trọ Bạch Đằng', 3, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bạch Đằng\",1072]', '18 Vân Đồn, Bạch Đằng, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi vào ngõ 18 50m', '21.014458,105.865252', 2, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (49, 'Nhà trọ Tùng Anh', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', 'ngõ 99 Nguyễn Chí Thanh', '', '21.0173028,105.80798', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (50, 'Nhà trọ Quỳnh Mai', 3, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Mai\",1087]', '284 Kim Ngưu, Quỳnh Mai, Hai Bà Trưng, Hà Nội, Việt Nam', 'Cạnh chợ Quỳnh Mai', '20.999146,105.86152', 3, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (51, 'Nhà trọ Tùng Sơn', 3, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', '68 phố Chùa Láng', '', '21.0227154,105.8094064', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (52, 'Chung cư Emperial', 1, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', 'Sky City Tower 88', '', '21.0124824,105.8112754', 16, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (53, 'Chung cư vip', 1, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', ' Sky City', '', '21.0124824,105.8112754', 23, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (54, 'Nhà 4 tầng ', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ngã Tư Sở\",604]', 'Ngã tư sở', 'Gần đoạn trường chinh\n', '21.004722,105.8220581', 4, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (55, 'Nhà Trọ Bắc Môn 5', 3, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'Số 5 ngõ 43 Xã Đàn', '', '21.0175738,105.8300282', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (56, 'Chung cơ Lardmark', 1, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', '275 xã đàn', '', '21.0174298,105.8303724', 22, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (57, 'Chung cư Hào Nam 1', 1, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'số 6 ngõ 137, Hào Nam', '', '21.025495,105.8269197', 14, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (58, 'Chung cơ Nam Tiến 1', 1, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'số 224 Mai Anh Tuấn', '', '21.0181412,105.8238215', 1, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (59, 'Chung cư Hào Nam 2', 1, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', '73 nguyễn lương bằng', '', '21.0170574,105.8291695', 8, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (60, 'Chung cư D\'. Le Pont D\'or 1', 1, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', '36 Hoàng Cầu', '', '21.0201135,105.8238057', 1, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (61, 'Chung cư Nam Tiến 2', 1, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', '360 xã đàn', '', '21.0147164,105.8345383', 1, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (62, 'Chung cư Đông Mạc', 1, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', '36 Hoàng Cầu', '', '21.0201135,105.8238057', 18, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (63, 'Nhà Nguyên Căn Chùa Bộc', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'Số 3 ngõ 43 Chùa Bộc', '', '21.006847,105.8297259', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (64, 'Nhà Tôn Thất Tùng', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'CCMN 2A/37 ngõ 72 Tôn Thất Tùng', '', '21.0017883,105.8284159', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (65, 'Nhà Thái Hà', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'Số 35A ngõ 7 Thái Hà', '', '21.0095107,105.8216074', 1, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (66, 'Nhà Nguyên căn Thái Hà', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'số 20 ngõ 252 Tây Sơn', '', '21.0080465,105.8225565', 4, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (67, 'Nhà Nguyên Căn', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'Số 12 ngõ 580 Trường Chinh.', '', '21.0027279,105.822348', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (68, 'Nguyên Căn TTT', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'số 2c/7 ngõ 22 Tôn Thất Tùng', '', '21.0025867,105.8289767', 3, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (69, 'Nguyên Căn', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', 'Ngõ 131B Tôn Đức Thắng', '', '21.026802,105.833911', 4, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (70, 'Nguyên Căn TQ', 2, 16, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Thổ Quan\",611]', 'Số 75E ngõ Thổ Quan', '', '21.019053,105.833834', 5, NULL, NULL, '2019-11-13 15:16:43.237907');
INSERT INTO `building` VALUES (71, 'Nhà nguyên căn mặt phố', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', ' Ngõ Thịnh Hào 1', '', '21.023636,105.831766', 3, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (72, 'Chung cư NEU', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', '107-H50, ngách 27 Ngõ 41 Phố Vọng, Đồng Tâm, Hai Bà Trưng, Hà Nội 100000, Việt Nam', 'sau ĐHKTQD', '20.9992372,105.8425979', 3, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (73, 'Chung cư Trường Chinh', 1, 15, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', 'Ngõ 128C - Đại La, Đồng Tâm, Hai Bà Trưng, Hà Nội, Việt Nam', '', '20.9975923,105.8433884', 3, NULL, NULL, '2019-11-13 15:15:29.124867');
INSERT INTO `building` VALUES (74, 'Chung cư vip Tower City', 1, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', 'Phố Tôn Thất Tùng', '', '21.0032249,105.8306606', 1, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (75, 'Khu chung cư bác Tùng', 1, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', '252 tây sơn', '', '21.0080465,105.8225565', 4, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (76, 'Chung cư mini tiện lợi', 1, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', '23 PHỐ ĐÔNG CÁC', '', '21.0184963,105.8288692', 7, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (77, 'Chung cư siêu siêu cấp', 1, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'Hoàng Cầu SkyLine', '', '21.0185264,105.8241049', 8, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (78, 'Chung cư cho người yêu anime', 1, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'HOÀNG CẦU VÕ VĂN DŨNG', '', '21.016252,105.823067', 5, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (79, 'Nhà tình thương ', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'Mai Anh Tuấn', '', '21.0182026,105.8237164', 3, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (80, 'Nhà nguyên căn chất lượng ', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'Trần Quang Diệu , ngõ 19 ', '', '21.0157618,105.8250225', 3, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (81, 'Nhà nguyên căn Ô chợ dừa', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', 'ngõ 9 Hoàng Cầu', '', '21.0192007,105.8265637', 3, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (82, 'Nhà nguyên căn 9 tầng Hà Nội', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Thượng\",602]', 'NGÕ 898 đường láng', '', '21.0211631,105.80173', 9, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (83, 'Nhà đẹp 3 tầng', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Thượng\",602]', ' 157 Pháo Đài Láng', '', '21.0182122,105.804095', 3, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (84, 'Nhà cho thuê - ĐIểm đến cho cặp vợ chồng mới cưới', 2, 18, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Thượng\",602]', 'ngõ 121 Chùa Láng', '', '21.0232387,105.8045483', 2, NULL, NULL, '2019-11-13 15:22:26.007772');
INSERT INTO `building` VALUES (85, 'CHUYÊN CHO THUÊ CĂN HỘ 2,3 ,4 NGỦ TẠI SUNANCORA ', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đống Mác\",1077]', 'Bạch Đằng, Hai Bà Trưng District, Hanoi, Vietnam', 'Bạch Đằng, Hai Bà Trưng District, Hanoi, Vietnam', '21.0094412,105.8603338', 4, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (86, ' CĂN HỘ 2, 3 PHÒNG NGỦ TẠI IMPERIA SKY GARDEN', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', 'Tầng 6, Số 101, Mai Hắc Đế, Phường Bùi Thị Xuân, Quận Hai Bà Trưng, Bùi Thị Xuân, Hai Bà Trưng, Hà Nội, Vietnam', 'Tầng 6, Số 101, Mai Hắc Đế, Phường Bùi Thị Xuân, Quận Hai Bà Trưng, Bùi Thị Xuân, Hai Bà Trưng, Hà Nội, Vietnam', '21.014602,105.851067', 6, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (87, 'Chính chủ cho thuê sàn tầng 1 số nhà 249, ngõ Quỳnh, Thanh Nhàn', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bùi Thị Xuân\",1075]', 'Ngõ Quỳnh, Đường Thanh Nhàn, Phường Quỳnh Lôi, Hai Bà Trưng, Hà Nội', 'Không có nhu cầu sử dụng chính chủ cần cho thuê sàn tầng 1, DT 64m2, chi tiết:\n- Diện tích sử dụng 64 m2, gồm 3 phòng: 1 phòng ngủ, 1 phòng bếp, 1 phòng khách rộng có thể kết hợp thành phòng ngủ, 1 vệ sinh.\n- Nội thất cơ bản: Bếp, nóng lạnh, điều hòa.\n- Đ', '21.0028517,105.8543947', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (88, 'Có phòng cho thuê khép kín giá 3tr - 3,5tr - 4 tr', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Ngô Thì Nhậm\",1082]', '188 Bà Triệu, Nguyễn Du, Hai Bà Trưng, Hà Nội, Vietnam', '188 Bà Triệu, Nguyễn Du, Hai Bà Trưng, Hà Nội, Vietnam', '21.016055,105.849207', 2, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (89, 'Duplex Lò Đúc 170m² 3 PN', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', '5 Trần Thánh Tông, Bạch Đằng, Hai Bà Trưng, Hà Nội, Vietnam', '5 Trần Thánh Tông, Bạch Đằng, Hai Bà Trưng, Hà Nội, Vietnam', '21.0148919,105.8596521', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (90, 'Căn hộ Quận Hai Bà Trưng 80m² 2PN', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Ngô Thì Nhậm\",1082]', '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Vietnam', '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Vietnam', '21.0114461,105.8500128', 4, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (91, 'Cho sinh viên thuê', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bùi Thị Xuân\",1075]', '120 Bùi Thị Xuân', '10C ngõ 109, Đường Đê Trần Khát Chân, Phường Thanh Lương, Quận Hai Bà Trưng, Hà Nội', '21.0137487,105.8500528', 3, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (92, 'Tin Môi giới đăng 3 ngày trước CCMN 76B/5 ngõ 209 Bạch Mai 4-5tr Full đồ', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bùi Thị Xuân\",1075]', '	 76B/5 ngõ 209, Đường Bạch Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '	\n76B/5 ngõ 209, Đường Bạch Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '20.9989516,105.8503348', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (93, 'Căn chung cư Hai Bà Trưng', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Mai\",1087]', 'phố 8/3, Phường Quỳnh Mai, Quận Hai Bà Trưng, Hà Nội', 'phố 8/3, Phường Quỳnh Mai, Quận Hai Bà Trưng, Hà Nội', '20.9994048,105.8593784', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (94, 'Cho thuê căn hộ tầng 5 tập thể A7', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bạch Mai\",1074]', '390 Bùi Ngọc Dương', 'Phòng 508 - Tập thể A7, Đường Bùi Ngọc Dương, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '21.002816,105.85383', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (95, 'Bán nhà phố Thanh Nhàn, diện tích 46m2 x 5 tầng', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Nguyễn Du\",1083]', '370 Trần Khát Chân, Street, Hai Bà Trưng, Hà Nội, Vietnam', '370 Trần Khát Chân, Street, Hai Bà Trưng, Hà Nội, Vietnam', '21.0087535,105.8615518', 2, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (96, 'Cho Thuê Căn Hộ Khu Trần Khát Trân ', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', '119 Kim Ngưu', '119, Đường Kim Ngưu, Phường Thanh Nhàn, Quận Hai Bà Trưng, Hà Nội', '21.0068746,105.8614659', 3, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (97, ' (ID:8483504) Phường Thống Nhất, Thành phố Biên Hòa 60 m2 2 2 ₫ 10 triệu Chia sẻ  https://www.muabannhadat.vn/tin-dang/cho-thue-can-ho-2-phong-ngu-thanh-pho-bien-hoa-8483504?utm_source=copy-paste&utm_medium=crm&utm_campaign=share-button THÔNG TIN CƠ BẢN N', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', 'số 55 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội, Vietnam', 'số 55 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội, Vietnam', '21.0033135,105.8433207', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (98, 'BÁN NHÀ HAI BÀ TRƯNG, 65M, NGÕ THÔNG KHẮP NGẢ.', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Lương\",1088]', ' Đường Lê Thanh Nghị, Phường Đồng Tâm, Quận Hai Bà Trưng, Hà Nội', '	\nĐường Lê Thanh Nghị, Phường Đồng Tâm, Quận Hai Bà Trưng, Hà Nội', '21.0011348,105.8423124', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (99, 'Đường Thanh Nhàn, Phường Quỳnh Lôi, Quận Hai Bà Trưng, Hà Nội', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', 'Bach Khoa, Hai Bà Trưng District, Hanoi, Vietnam', 'Bach Khoa, Hai Bà Trưng District, Hanoi, Vietnam', '21.0048067,105.8453406', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (100, 'Đẹp ở luôn Minh Khai Hai BàTrưng', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Mai\",1087]', 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '20.9975552,105.8652828', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (101, 'Phòng ở ghép Trần đại nghĩa, Quận Hai Bà Trưng', 3, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', '34 Trần đại nghĩa, Phường Đồng Tâm', '34 Trần đại nghĩa, Phường Đồng Tâm', '21.0023697,105.8446542', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (102, 'Phòng cho thuê giá rẻ', 3, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', '	 Đường Lê Thanh Nghị, Phường Bách Khoa, Quận Hai Bà Trưng, Hà Nộ', '	\nĐường Lê Thanh Nghị, Phường Bách Khoa, Quận Hai Bà Trưng, Hà Nộ', '21.0094412,105.8603338', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (103, 'Nhà trọ giá rẻ cho sinh viên Bách khoa', 3, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Nguyễn Du\",1083]', 'ường Lê Ngọc Hân, Phường Phạm Đình Hổ, Quận Hai Bà Trưng, Hà Nội', 'ường Lê Ngọc Hân, Phường Phạm Đình Hổ, Quận Hai Bà Trưng, Hà Nội', '21.015609,105.855239', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (104, 'Cho thuê căn hộ sang trọng', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', 'Đường Đê Trần Khát Chân, Phường Phố Huế, Quận Hai Bà Trưng, Hà Nội', 'Đường Đê Trần Khát Chân, Phường Phố Huế, Quận Hai Bà Trưng, Hà Nội', '21.0094412,105.8603338', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (105, 'Cho thuê căn hộ siêu sang -Hai Ba Trưng', 2, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bạch Đằng\",1072]', '197, Đường Minh Khai, Phường Thanh Nhàn, Quận Hai Bà Trưng, Hà Nội', '197, Đường Minh Khai, Phường Thanh Nhàn, Quận Hai Bà Trưng, Hà Nội', '20.9955533,105.8596066', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (106, 'Nhà trọ cho sinh viên gần bách khoa', 3, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Nguyễn Du\",1083]', 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '20.9975552,105.8652828', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (107, 'cho thuê chung cư quận Hai bà trưng', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Lôi\",1086]', '	 Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '	\nĐường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '20.9975552,105.8652828', 1, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (108, 'Cho thuê chung cư gia đình', 1, 21, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đống Mác\",1077]', 'Đường Hồng Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', 'Đường Hồng Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '20.9988954,105.8532977', 16, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (109, 'cho thuê căn hộ gần đại học bách khóa', 1, 21, '[\"Hà Nội\",1]', '[\"Sóc Sơn\",22]', '[\"Phù Linh\",2288]', '	 Đường Nguyễn An Ninh, Phường Trương Định, Quận Hai Bà Trưng, Hà Nội', '	\nĐường Nguyễn An Ninh, Phường Trương Định, Quận Hai Bà Trưng, Hà Nội', '20.9911093,105.8446343', 34, NULL, NULL, '2019-11-13 15:31:50.820121');
INSERT INTO `building` VALUES (110, 'Nhà trọ Hoàng Yến', 3, 1, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Vĩnh Tuy\",1091]', '23', '', '21.017794127836883,105.84999645767209', 2, NULL, '2019-11-13 14:50:10.201256', NULL);
INSERT INTO `building` VALUES (111, 'Căn hộ tòa 12A Mỹ Đình', 1, 1, '[\"Hà Nội\",1]', '[\"Nam Từ Liêm\",18]', '[\"Mỹ Đình 1\",2020]', '1', '', '21.0226555,105.7704955', 34, NULL, '2019-11-13 14:57:21.529479', NULL);
INSERT INTO `building` VALUES (112, 'Nguyên căn mặt phố', 2, 1, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Phố Huế\",1085]', '12', '', '21.0090571,105.8607507', 3, NULL, '2019-11-13 18:27:27.256472', NULL);
INSERT INTO `building` VALUES (113, 'Chung cư Jjajang ramen', 1, 1, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', '12', '', '21.0180725,105.8299495', 34, NULL, '2019-11-14 04:54:44.599414', NULL);
COMMIT;

-- ----------------------------
-- Table structure for building_service
-- ----------------------------
DROP TABLE IF EXISTS `building_service`;
CREATE TABLE `building_service` (
  `building_id` int(5) NOT NULL COMMENT 'ID of the building',
  `service_id` int(5) NOT NULL COMMENT 'ID of the service in the building',
  `service_price` double(10,0) DEFAULT NULL COMMENT 'Price of service',
  `note` text COMMENT 'Note for building service',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`building_id`,`service_id`) USING BTREE,
  KEY `FK_service` (`service_id`) USING BTREE,
  CONSTRAINT `FK_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`),
  CONSTRAINT `FK_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of building_service
-- ----------------------------
BEGIN;
INSERT INTO `building_service` VALUES (8, 1, 200000, 'Giá 1 tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (8, 2, 90000, 'Sẵn có 50 số điện + phụ trội thêm 90k', NULL, NULL);
INSERT INTO `building_service` VALUES (8, 3, NULL, 'Theo giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (9, 1, 190000, 'giá hàng tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (10, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (12, 1, 10000000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (13, 1, 150000, 'WiFi Viettel', NULL, NULL);
INSERT INTO `building_service` VALUES (13, 2, 500000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (13, 3, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (14, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (14, 2, 400000, 'Điện nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (14, 3, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (14, 5, 100000, 'Máy giặt tự động', NULL, NULL);
INSERT INTO `building_service` VALUES (14, 6, 150000, 'nhà để xe riêng', NULL, NULL);
INSERT INTO `building_service` VALUES (15, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (15, 2, 400000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (15, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (16, 1, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (16, 2, 500000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (16, 3, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (16, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (16, 5, 500000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (16, 6, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (16, 7, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (17, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (17, 2, 500000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (17, 3, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (18, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (18, 2, 600000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (18, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (18, 7, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (19, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (19, 2, 300000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (19, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (19, 5, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (20, 2, 400000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (20, 3, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (20, 6, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (21, 2, 400000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (21, 3, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (22, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (22, 2, 400000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (22, 3, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (23, 2, 300000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (23, 3, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (23, 6, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (24, 2, 400000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (24, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (25, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (25, 2, 400000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (25, 3, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (26, 2, 400000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (26, 3, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (27, 2, 300000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (27, 3, 70000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (27, 7, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (28, 1, 80000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (28, 2, 3500, '3500vnđ/1 số điện', NULL, NULL);
INSERT INTO `building_service` VALUES (28, 3, 80000, '80000vnđ/1ng/1 tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (28, 6, 0, 'free', NULL, NULL);
INSERT INTO `building_service` VALUES (29, 1, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (29, 2, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (29, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (30, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (30, 2, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (30, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (30, 7, 100000, 'Thứ 7 Hàng tuần sẽ có người đến dọn nhà và phòng vệ sinh', NULL, NULL);
INSERT INTO `building_service` VALUES (31, 1, 200000, 'Wifi siêu mạnh', NULL, NULL);
INSERT INTO `building_service` VALUES (31, 2, 3500, 'Theo giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (31, 3, NULL, 'Theo giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (31, 6, 50000, 'Trông ngày đêm', NULL, NULL);
INSERT INTO `building_service` VALUES (32, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (32, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (32, 3, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (32, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (33, 1, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (33, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (33, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (34, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (34, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (34, 3, 80000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (34, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (35, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (35, 3, 3500, 'Nước không nhiễm dầu', NULL, NULL);
INSERT INTO `building_service` VALUES (35, 4, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (35, 6, 40000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (36, 1, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (36, 2, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (36, 3, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (37, 1, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (37, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (37, 3, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (37, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (38, 1, NULL, 'Giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (38, 2, NULL, 'Giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (38, 4, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (39, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (39, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (39, 3, 130000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (39, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (40, 1, NULL, 'Tự lắp mạng', NULL, NULL);
INSERT INTO `building_service` VALUES (40, 2, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (40, 3, 4000, 'Tính theo giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (40, 6, 100000, 'Tiền nước chè', NULL, NULL);
INSERT INTO `building_service` VALUES (41, 1, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (41, 2, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (41, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (42, 2, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (42, 3, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (42, 7, 50000, 'ĐỊnh kì hàng tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (44, 1, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (44, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (44, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (45, 2, NULL, 'Theo giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (45, 3, NULL, 'GIá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (46, 1, 70000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (46, 2, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (46, 3, 60000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (46, 5, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (46, 6, 40000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (47, 1, NULL, 'Miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (47, 2, NULL, 'Giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (47, 3, NULL, 'Giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (48, 1, 60000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (48, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (48, 3, 70000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (49, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (49, 2, 4500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (49, 3, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (50, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (50, 2, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (50, 3, 70000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (52, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (52, 3, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (55, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (55, 2, 3500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (55, 3, 20000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (56, 1, 250000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (56, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (56, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (57, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (57, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (57, 3, 25000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (57, 7, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (58, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (58, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (58, 3, 20000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (58, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (58, 5, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (58, 6, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (58, 7, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (61, 7, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (62, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (62, 3, 25000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (63, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (63, 3, 25000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (64, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (64, 3, 20000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (65, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (65, 3, 22000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (66, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (66, 3, 20000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (67, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (67, 3, 23000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (68, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (68, 3, 23000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (69, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (69, 3, 22000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (70, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (70, 3, 20000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (71, 1, 100000, 'Wifi siêu nhanh', NULL, NULL);
INSERT INTO `building_service` VALUES (72, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (72, 3, 2500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (73, 1, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (73, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (73, 3, 2500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (74, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (74, 2, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (74, 3, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (79, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (79, 2, NULL, 'Giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (79, 3, NULL, 'Giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (80, 2, NULL, 'Gia nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (80, 3, NULL, 'Giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (81, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (81, 3, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (82, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (82, 3, 4000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (85, 1, 100000, 'đóng cuối tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (85, 2, 200000, 'đóng cuối tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (85, 3, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (85, 4, NULL, 'Miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (85, 5, NULL, 'Miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (85, 6, NULL, 'Miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (85, 7, 30000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (86, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (86, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (86, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (86, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (86, 5, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (86, 6, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (86, 7, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (87, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (87, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (87, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (87, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (87, 5, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (87, 6, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (87, 7, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (88, 1, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (88, 2, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (88, 3, 30000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (88, 4, 0, 'free', NULL, NULL);
INSERT INTO `building_service` VALUES (88, 5, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (88, 6, 0, 'free', NULL, NULL);
INSERT INTO `building_service` VALUES (88, 7, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (89, 1, NULL, 'miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (89, 2, NULL, 'miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (89, 3, NULL, 'miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (89, 4, NULL, 'miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (89, 5, NULL, 'miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (89, 6, NULL, 'miễn phí', NULL, NULL);
INSERT INTO `building_service` VALUES (89, 7, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (90, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (90, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (90, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (90, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (90, 5, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (90, 6, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (90, 7, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (91, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (91, 2, 3000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (91, 3, 1500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (91, 7, 150000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (93, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (93, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (93, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (93, 6, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (93, 7, 40000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (94, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (94, 2, 3000, 'tùy theo lượng sử dụng', NULL, NULL);
INSERT INTO `building_service` VALUES (94, 3, 1500, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (94, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (94, 7, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (95, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (95, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (95, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (95, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (95, 5, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (95, 6, 70000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (96, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (96, 2, 650000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (96, 3, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (96, 5, 250000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (96, 7, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (97, 1, 100000, '', NULL, NULL);
INSERT INTO `building_service` VALUES (97, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (97, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (97, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (97, 5, 0, 'free', NULL, NULL);
INSERT INTO `building_service` VALUES (97, 6, 0, 'free', NULL, NULL);
INSERT INTO `building_service` VALUES (97, 7, 40000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (100, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (100, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (100, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (100, 4, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (100, 5, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (100, 6, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (100, 7, 40000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (101, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (101, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (101, 3, 40000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (102, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (102, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (102, 3, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (102, 7, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (103, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (103, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (103, 3, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (104, 1, 120000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (104, 2, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (104, 3, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (106, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (106, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (106, 3, 40000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (106, 4, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (110, 1, 200000, 'Giá theo tháng', '2019-11-13 14:50:10.400771', NULL);
INSERT INTO `building_service` VALUES (110, 2, 70000, 'Giá 1 số điện', '2019-11-13 14:50:10.463113', NULL);
INSERT INTO `building_service` VALUES (110, 3, NULL, 'Theo giá nhà nước', '2019-11-13 14:50:10.375854', NULL);
INSERT INTO `building_service` VALUES (111, 1, 200000, NULL, '2019-11-13 14:57:21.584416', NULL);
INSERT INTO `building_service` VALUES (111, 2, 70000, NULL, '2019-11-13 14:57:21.588295', NULL);
INSERT INTO `building_service` VALUES (111, 3, NULL, 'Theo giá nhà nước', '2019-11-13 14:57:21.593394', NULL);
INSERT INTO `building_service` VALUES (111, 4, NULL, 'Gửi xe tầng hầm, có vé tháng', '2019-11-13 14:57:21.604568', NULL);
INSERT INTO `building_service` VALUES (112, 1, NULL, 'Tự lắp đặt', '2019-11-13 18:27:27.386048', NULL);
INSERT INTO `building_service` VALUES (112, 2, NULL, 'Giá theo khu vực', '2019-11-13 18:27:27.385703', NULL);
INSERT INTO `building_service` VALUES (112, 3, NULL, 'Giá theo khu vực', '2019-11-13 18:27:27.369118', NULL);
INSERT INTO `building_service` VALUES (113, 1, 200000, NULL, '2019-11-14 04:54:44.767204', NULL);
COMMIT;

-- ----------------------------
-- Table structure for building_type
-- ----------------------------
DROP TABLE IF EXISTS `building_type`;
CREATE TABLE `building_type` (
  `type_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room type',
  `building_type` varchar(255) DEFAULT NULL COMMENT 'Name of the type',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time ',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of building_type
-- ----------------------------
BEGIN;
INSERT INTO `building_type` VALUES (1, 'Căn hộ chung cư', '2019-10-17 04:26:20.980356', '2019-10-17 04:26:20.980356');
INSERT INTO `building_type` VALUES (2, 'Nhà nguyên căn', '2019-10-17 04:26:19.703176', '2019-10-17 04:26:19.703176');
INSERT INTO `building_type` VALUES (3, 'Khu nhà trọ', '2019-10-17 04:26:14.933942', '2019-10-17 04:26:14.933942');
COMMIT;

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `feedback_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the feedback',
  `user_id` int(5) DEFAULT NULL COMMENT 'ID of user who sends the feedback',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email of the user who sends feedback',
  `content` text NOT NULL COMMENT 'Content of the feedback',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`feedback_id`) USING BTREE,
  KEY `FK_user_feedback` (`user_id`) USING BTREE,
  CONSTRAINT `FK_user_feedback` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for host_review
-- ----------------------------
DROP TABLE IF EXISTS `host_review`;
CREATE TABLE `host_review` (
  `review_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the review',
  `host_id` int(5) DEFAULT NULL COMMENT 'ID of the host who sends the review',
  `tenant_id` int(5) DEFAULT NULL COMMENT 'ID of targeted tenant of the review',
  `comment` text COMMENT 'Content of the comment',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`review_id`) USING BTREE,
  KEY `FK_user_host` (`host_id`) USING BTREE,
  KEY `FK_user_tenant` (`tenant_id`) USING BTREE,
  CONSTRAINT `FK_user_host` FOREIGN KEY (`host_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK_user_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for reported_room
-- ----------------------------
DROP TABLE IF EXISTS `reported_room`;
CREATE TABLE `reported_room` (
  `user_id` int(5) NOT NULL COMMENT 'ID of user who sends the report',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of reported room group',
  `report_content` text COMMENT 'Content of the report',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`,`room_group_id`) USING BTREE,
  KEY `FK_room_report` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_report` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`),
  CONSTRAINT `FK_user_report` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `room_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of group that room belongs to',
  `room_name` text COMMENT 'name of the room',
  `room_status` tinyint(2) DEFAULT NULL COMMENT 'Room status code',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_id`) USING BTREE,
  KEY `FK_room_group` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room
-- ----------------------------
BEGIN;
INSERT INTO `room` VALUES (9, 10, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (10, 1, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (11, 1, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (12, 1, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (13, 11, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (14, 11, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (15, 11, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (16, 12, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (17, 12, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (18, 12, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (19, 13, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (20, 14, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (21, 15, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (22, 16, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (23, 17, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (24, 18, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (25, 19, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (26, 20, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (27, 21, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (28, 22, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (29, 23, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (30, 24, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (31, 25, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (32, 26, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (33, 27, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (34, 28, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (35, 29, '101,301,401', 1, NULL, NULL);
INSERT INTO `room` VALUES (36, 30, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (37, 30, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (38, 30, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (39, 31, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (40, 31, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (41, 31, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (42, 31, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (43, 32, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (44, 32, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (45, 32, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (46, 32, '104', 1, NULL, NULL);
INSERT INTO `room` VALUES (47, 32, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (48, 32, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (49, 32, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (50, 32, '204', 1, NULL, NULL);
INSERT INTO `room` VALUES (51, 33, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (52, 33, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (53, 33, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (54, 33, '304', 1, NULL, NULL);
INSERT INTO `room` VALUES (55, 35, '140', 1, NULL, NULL);
INSERT INTO `room` VALUES (56, 35, '160', 1, NULL, NULL);
INSERT INTO `room` VALUES (57, 35, '120', 1, NULL, NULL);
INSERT INTO `room` VALUES (58, 34, '112', 1, NULL, NULL);
INSERT INTO `room` VALUES (59, 34, '220', 1, NULL, NULL);
INSERT INTO `room` VALUES (60, 34, '111', 1, NULL, NULL);
INSERT INTO `room` VALUES (61, 36, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (62, 36, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (63, 36, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (64, 36, '204', 1, NULL, NULL);
INSERT INTO `room` VALUES (65, 36, '205', 1, NULL, NULL);
INSERT INTO `room` VALUES (66, 36, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (67, 36, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (68, 36, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (69, 36, '304', 1, NULL, NULL);
INSERT INTO `room` VALUES (70, 36, '305', 1, NULL, NULL);
INSERT INTO `room` VALUES (71, 37, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (72, 37, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (73, 37, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (74, 37, '104', 1, NULL, NULL);
INSERT INTO `room` VALUES (75, 37, '105', 1, NULL, NULL);
INSERT INTO `room` VALUES (76, 38, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (77, 38, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (78, 38, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (79, 38, '204', 1, NULL, NULL);
INSERT INTO `room` VALUES (80, 38, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (81, 38, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (82, 38, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (83, 38, '304', 1, NULL, NULL);
INSERT INTO `room` VALUES (84, 39, '401', 1, NULL, NULL);
INSERT INTO `room` VALUES (85, 39, '402', 1, NULL, NULL);
INSERT INTO `room` VALUES (86, 39, '403', 1, NULL, NULL);
INSERT INTO `room` VALUES (87, 39, '404', 1, NULL, NULL);
INSERT INTO `room` VALUES (88, 39, '501', 1, NULL, NULL);
INSERT INTO `room` VALUES (89, 39, '502', 1, NULL, NULL);
INSERT INTO `room` VALUES (90, 40, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (91, 40, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (92, 41, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (93, 41, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (94, 41, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (95, 41, '304', 1, NULL, NULL);
INSERT INTO `room` VALUES (96, 42, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (97, 42, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (98, 42, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (99, 42, '204', 1, NULL, NULL);
INSERT INTO `room` VALUES (100, 43, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (101, 43, '145', 1, NULL, NULL);
INSERT INTO `room` VALUES (102, 43, '157', 1, NULL, NULL);
INSERT INTO `room` VALUES (103, 43, '122', 1, NULL, NULL);
INSERT INTO `room` VALUES (104, 43, '132', 1, NULL, NULL);
INSERT INTO `room` VALUES (105, 43, '131', 1, NULL, NULL);
INSERT INTO `room` VALUES (106, 43, '1324', 1, NULL, NULL);
INSERT INTO `room` VALUES (107, 43, '31', 1, NULL, NULL);
INSERT INTO `room` VALUES (108, 43, '312', 1, NULL, NULL);
INSERT INTO `room` VALUES (109, 43, '13', 1, NULL, NULL);
INSERT INTO `room` VALUES (110, 43, '213', 1, NULL, NULL);
INSERT INTO `room` VALUES (111, 44, '100', 1, NULL, NULL);
INSERT INTO `room` VALUES (112, 44, '200', 1, NULL, NULL);
INSERT INTO `room` VALUES (113, 44, '300', 1, NULL, NULL);
INSERT INTO `room` VALUES (114, 44, '400', 1, NULL, NULL);
INSERT INTO `room` VALUES (115, 45, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (116, 45, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (117, 45, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (118, 45, '204', 1, NULL, NULL);
INSERT INTO `room` VALUES (119, 45, '205', 1, NULL, NULL);
INSERT INTO `room` VALUES (120, 45, '206', 1, NULL, NULL);
INSERT INTO `room` VALUES (121, 46, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (122, 46, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (123, 46, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (124, 46, '304', 1, NULL, NULL);
INSERT INTO `room` VALUES (125, 46, '305', 1, NULL, NULL);
INSERT INTO `room` VALUES (126, 46, '306', 1, NULL, NULL);
INSERT INTO `room` VALUES (127, 48, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (128, 48, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (129, 48, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (130, 48, '304', 1, NULL, NULL);
INSERT INTO `room` VALUES (131, 47, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (132, 47, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (133, 47, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (134, 49, '100', 1, NULL, NULL);
INSERT INTO `room` VALUES (135, 49, '200', 1, NULL, NULL);
INSERT INTO `room` VALUES (136, 49, '300', 1, NULL, NULL);
INSERT INTO `room` VALUES (137, 50, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (138, 50, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (139, 50, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (140, 50, '401', 1, NULL, NULL);
INSERT INTO `room` VALUES (141, 50, '402', 1, NULL, NULL);
INSERT INTO `room` VALUES (142, 50, '403', 1, NULL, NULL);
INSERT INTO `room` VALUES (143, 51, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (144, 51, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (145, 51, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (146, 52, '211', 1, NULL, NULL);
INSERT INTO `room` VALUES (147, 52, '222', 1, NULL, NULL);
INSERT INTO `room` VALUES (148, 52, '234', 1, NULL, NULL);
INSERT INTO `room` VALUES (149, 52, '256', 1, NULL, NULL);
INSERT INTO `room` VALUES (150, 52, '2312', 1, NULL, NULL);
INSERT INTO `room` VALUES (151, 52, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (152, 52, '31', 1, NULL, NULL);
INSERT INTO `room` VALUES (153, 52, '113', 1, NULL, NULL);
INSERT INTO `room` VALUES (154, 52, '1321', 1, NULL, NULL);
INSERT INTO `room` VALUES (155, 52, '351', 1, NULL, NULL);
INSERT INTO `room` VALUES (156, 53, '1516', 1, NULL, NULL);
INSERT INTO `room` VALUES (157, 53, '413', 1, NULL, NULL);
INSERT INTO `room` VALUES (158, 53, '12321', 1, NULL, NULL);
INSERT INTO `room` VALUES (159, 53, '124', 1, NULL, NULL);
INSERT INTO `room` VALUES (160, 53, '311', 1, NULL, NULL);
INSERT INTO `room` VALUES (161, 54, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (162, 54, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (163, 54, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (164, 55, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (165, 55, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (166, 55, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (167, 56, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (168, 56, '153', 1, NULL, NULL);
INSERT INTO `room` VALUES (169, 57, '12', 1, NULL, NULL);
INSERT INTO `room` VALUES (170, 57, '421', 1, NULL, NULL);
INSERT INTO `room` VALUES (171, 57, '213', 1, NULL, NULL);
INSERT INTO `room` VALUES (172, 57, '312', 1, NULL, NULL);
INSERT INTO `room` VALUES (173, 58, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (174, 58, '131', 1, NULL, NULL);
INSERT INTO `room` VALUES (175, 58, '1212', 1, NULL, NULL);
INSERT INTO `room` VALUES (176, 59, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (177, 59, '404', 1, NULL, NULL);
INSERT INTO `room` VALUES (178, 60, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (179, 60, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (180, 60, '107', 1, NULL, NULL);
INSERT INTO `room` VALUES (181, 61, 'A11', 1, NULL, NULL);
INSERT INTO `room` VALUES (182, 61, 'A21', 1, NULL, NULL);
INSERT INTO `room` VALUES (183, 61, 'A13', 1, NULL, NULL);
INSERT INTO `room` VALUES (184, 62, '213', 1, NULL, NULL);
INSERT INTO `room` VALUES (185, 62, '151', 1, NULL, NULL);
INSERT INTO `room` VALUES (186, 62, '313', 1, NULL, NULL);
INSERT INTO `room` VALUES (187, 65, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (188, 65, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (189, 65, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (190, 65, '204', 1, NULL, NULL);
INSERT INTO `room` VALUES (191, 64, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (192, 64, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (193, 64, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (194, 64, '304', 1, NULL, NULL);
INSERT INTO `room` VALUES (195, 63, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (196, 63, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (197, 63, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (198, 63, '104', 1, NULL, NULL);
INSERT INTO `room` VALUES (199, 66, '112', 1, NULL, NULL);
INSERT INTO `room` VALUES (200, 66, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (201, 68, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (202, 68, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (203, 68, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (204, 67, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (205, 67, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (206, 67, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (207, 69, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (208, 69, '234', 1, NULL, NULL);
INSERT INTO `room` VALUES (209, 69, '245', 1, NULL, NULL);
INSERT INTO `room` VALUES (210, 71, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (211, 71, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (212, 71, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (213, 71, '104', 1, NULL, NULL);
INSERT INTO `room` VALUES (214, 70, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (215, 70, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (216, 70, '204', 1, NULL, NULL);
INSERT INTO `room` VALUES (217, 70, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (218, 72, '301', 1, NULL, NULL);
INSERT INTO `room` VALUES (219, 72, '302', 1, NULL, NULL);
INSERT INTO `room` VALUES (220, 72, '303', 1, NULL, NULL);
INSERT INTO `room` VALUES (221, 74, '23', 1, NULL, NULL);
INSERT INTO `room` VALUES (222, 74, '24', 1, NULL, NULL);
INSERT INTO `room` VALUES (223, 74, '25', 1, NULL, NULL);
INSERT INTO `room` VALUES (224, 73, '12', 1, NULL, NULL);
INSERT INTO `room` VALUES (225, 73, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (226, 73, '145', 1, NULL, NULL);
INSERT INTO `room` VALUES (227, 75, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (228, 76, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (229, 77, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (230, 78, '101', 1, NULL, NULL);
INSERT INTO `room` VALUES (231, 78, '102', 1, NULL, NULL);
INSERT INTO `room` VALUES (232, 78, '103', 1, NULL, NULL);
INSERT INTO `room` VALUES (233, 79, '201', 1, NULL, NULL);
INSERT INTO `room` VALUES (234, 79, '202', 1, NULL, NULL);
INSERT INTO `room` VALUES (235, 79, '203', 1, NULL, NULL);
INSERT INTO `room` VALUES (236, 80, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (237, 81, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (238, 82, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (239, 83, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (240, 84, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (241, 85, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (242, 86, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (243, 87, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (244, 88, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (245, 89, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (246, 90, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (247, 91, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (248, 92, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (249, 93, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (250, 94, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (251, 95, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (252, 96, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (253, 97, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (254, 98, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (255, 99, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (256, 100, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (257, 101, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (258, 102, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (259, 103, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (260, 104, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (261, 105, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (262, 106, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (263, 107, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (264, 108, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (265, 109, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (266, 110, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (267, 111, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (268, 112, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (269, 113, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (270, 114, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (271, 115, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (272, 116, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (273, 117, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (274, 118, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (275, 119, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (276, 120, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (277, 121, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (278, 122, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (279, 123, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (280, 124, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (281, 125, '102 ', 1, NULL, NULL);
INSERT INTO `room` VALUES (282, 125, '111', 1, NULL, NULL);
INSERT INTO `room` VALUES (283, 125, '123', 1, NULL, NULL);
INSERT INTO `room` VALUES (284, 126, '232', 1, NULL, NULL);
INSERT INTO `room` VALUES (285, 126, '424', 1, NULL, NULL);
INSERT INTO `room` VALUES (286, 126, '223', 1, NULL, NULL);
INSERT INTO `room` VALUES (287, 127, 'phòng điều hòa', 1, NULL, NULL);
INSERT INTO `room` VALUES (288, 128, 'phòng đơn ', 1, NULL, NULL);
INSERT INTO `room` VALUES (289, 128, 'phòng ghép', 1, NULL, NULL);
INSERT INTO `room` VALUES (290, 129, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (291, 130, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (292, 131, 'điều hòa', 1, NULL, NULL);
INSERT INTO `room` VALUES (293, 132, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (294, 133, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (295, 134, 'Thuê cả nhà', 1, NULL, NULL);
INSERT INTO `room` VALUES (296, 135, '201', 1, '2019-11-13 14:50:10.564083', NULL);
INSERT INTO `room` VALUES (297, 135, '202', 1, '2019-11-13 14:50:10.564083', NULL);
INSERT INTO `room` VALUES (298, 135, '203', 1, '2019-11-13 14:50:10.564083', NULL);
INSERT INTO `room` VALUES (299, 136, '301', 1, '2019-11-13 14:50:10.565921', NULL);
INSERT INTO `room` VALUES (300, 136, '302', 1, '2019-11-13 14:50:10.565921', NULL);
INSERT INTO `room` VALUES (301, 136, '303', 1, '2019-11-13 14:50:10.565921', NULL);
INSERT INTO `room` VALUES (302, 137, 'Thuê cả nhà', 1, '2019-11-13 14:57:21.638310', NULL);
INSERT INTO `room` VALUES (303, 138, 'Thuê cả nhà', 1, '2019-11-13 18:27:27.433896', NULL);
INSERT INTO `room` VALUES (304, 139, 'Thuê cả nhà', 1, '2019-11-14 04:54:44.813682', NULL);
COMMIT;

-- ----------------------------
-- Table structure for room_amenities
-- ----------------------------
DROP TABLE IF EXISTS `room_amenities`;
CREATE TABLE `room_amenities` (
  `room_group_id` int(5) NOT NULL COMMENT 'ID of the room group',
  `amenities_id` int(5) NOT NULL COMMENT 'ID of amenities in the room group',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_group_id`,`amenities_id`) USING BTREE,
  KEY `FK_Amenities-Room_Amenities` (`amenities_id`) USING BTREE,
  CONSTRAINT `FK_Amenities-Room_Amenities` FOREIGN KEY (`amenities_id`) REFERENCES `amenities` (`amenities_id`),
  CONSTRAINT `FK_Room-Room_Amenities` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room_amenities
-- ----------------------------
BEGIN;
INSERT INTO `room_amenities` VALUES (1, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (10, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (10, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (10, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (10, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (10, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (10, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (10, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (11, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (11, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (11, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (11, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (12, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (12, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (12, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (12, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (13, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (14, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (15, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (16, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (17, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (18, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (19, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (20, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (20, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (20, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (20, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (20, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (20, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (20, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (21, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (22, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (22, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (22, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (22, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (22, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (22, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (22, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (23, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (23, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (23, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (23, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (23, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (23, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (24, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (25, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (25, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (25, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (25, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (25, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (25, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (26, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (26, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (26, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (26, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (26, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (26, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (27, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (27, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (27, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (27, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (28, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (28, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (28, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (28, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (28, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (29, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (29, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (29, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (29, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (30, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (31, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (31, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (31, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (31, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (31, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (31, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (31, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (32, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (32, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (32, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (32, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (32, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (32, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (32, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (33, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (34, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (35, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (36, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (37, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (37, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (37, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (37, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (37, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (37, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (38, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (38, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (38, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (38, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (38, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (38, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (38, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (39, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (40, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (40, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (40, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (40, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (40, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (40, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (41, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (42, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (42, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (42, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (42, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (42, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (42, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (43, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (43, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (43, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (43, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (43, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (43, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (44, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (45, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (45, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (45, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (45, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (45, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (45, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (46, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (46, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (46, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (46, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (46, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (46, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (46, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (47, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (47, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (47, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (47, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (47, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (47, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (47, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (48, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (49, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (49, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (49, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (49, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (49, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (49, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (49, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (50, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (51, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (51, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (51, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (51, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (51, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (51, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (52, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (53, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (54, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (54, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (54, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (54, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (54, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (54, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (54, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (55, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (55, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (55, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (55, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (55, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (56, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (59, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (59, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (59, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (59, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (60, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (60, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (60, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (60, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (60, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (60, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (61, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (62, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (63, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (63, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (63, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (63, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (63, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (63, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (64, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (65, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (66, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (67, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (67, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (67, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (67, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (67, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (68, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (68, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (68, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (68, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (68, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (68, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (68, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (69, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (69, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (69, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (70, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (70, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (70, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (70, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (70, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (71, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (71, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (71, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (72, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (72, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (72, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (72, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (72, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (72, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (73, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (74, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (74, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (74, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (74, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (74, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (74, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (74, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (75, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (76, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (77, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (78, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (78, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (78, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (78, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (78, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (78, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (79, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (79, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (79, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (79, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (79, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (79, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (79, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (80, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (81, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (82, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (83, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (84, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (85, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (86, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (87, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (88, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (89, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (90, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (91, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (92, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (93, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (94, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (94, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (94, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (94, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (94, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (94, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (95, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (96, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (97, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (98, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (99, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (99, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (99, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (99, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (99, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (99, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (100, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (100, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (100, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (100, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (100, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (100, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (101, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (102, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (103, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (104, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (105, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (105, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (105, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (105, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (105, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (105, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (106, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (107, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (107, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (107, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (107, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (107, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (107, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (107, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (108, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (109, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (110, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (111, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (112, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (113, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (114, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (115, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (116, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (117, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (118, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (119, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (120, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (121, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (122, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (123, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (124, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (125, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (126, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (127, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (128, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (129, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (130, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (131, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (132, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (133, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (133, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (133, 5, NULL, NULL);
INSERT INTO `room_amenities` VALUES (133, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (133, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (133, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (133, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (134, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (134, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (134, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (135, 1, '2019-11-13 14:50:10.686963', NULL);
INSERT INTO `room_amenities` VALUES (135, 2, '2019-11-13 14:50:10.712286', NULL);
INSERT INTO `room_amenities` VALUES (135, 3, '2019-11-13 14:50:10.737142', NULL);
INSERT INTO `room_amenities` VALUES (135, 7, '2019-11-13 14:50:10.801813', NULL);
INSERT INTO `room_amenities` VALUES (135, 8, '2019-11-13 14:50:10.790927', NULL);
INSERT INTO `room_amenities` VALUES (135, 9, '2019-11-13 14:50:10.800752', NULL);
INSERT INTO `room_amenities` VALUES (135, 10, '2019-11-13 14:50:10.807177', NULL);
INSERT INTO `room_amenities` VALUES (135, 11, '2019-11-13 14:50:10.809594', NULL);
INSERT INTO `room_amenities` VALUES (136, 1, '2019-11-13 14:50:10.707825', NULL);
INSERT INTO `room_amenities` VALUES (136, 2, '2019-11-13 14:50:10.708834', NULL);
INSERT INTO `room_amenities` VALUES (136, 3, '2019-11-13 14:50:10.744950', NULL);
INSERT INTO `room_amenities` VALUES (136, 6, '2019-11-13 14:50:10.727809', NULL);
INSERT INTO `room_amenities` VALUES (136, 7, '2019-11-13 14:50:10.739315', NULL);
INSERT INTO `room_amenities` VALUES (136, 8, '2019-11-13 14:50:10.741116', NULL);
INSERT INTO `room_amenities` VALUES (136, 9, '2019-11-13 14:50:10.752006', NULL);
INSERT INTO `room_amenities` VALUES (136, 10, '2019-11-13 14:50:10.802924', NULL);
INSERT INTO `room_amenities` VALUES (136, 11, '2019-11-13 14:50:10.812348', NULL);
INSERT INTO `room_amenities` VALUES (137, 1, '2019-11-13 14:57:21.679843', NULL);
INSERT INTO `room_amenities` VALUES (137, 2, '2019-11-13 14:57:21.682854', NULL);
INSERT INTO `room_amenities` VALUES (137, 3, '2019-11-13 14:57:21.687950', NULL);
INSERT INTO `room_amenities` VALUES (137, 4, '2019-11-13 14:57:21.689537', NULL);
INSERT INTO `room_amenities` VALUES (137, 5, '2019-11-13 14:57:21.693344', NULL);
INSERT INTO `room_amenities` VALUES (137, 6, '2019-11-13 14:57:21.697959', NULL);
INSERT INTO `room_amenities` VALUES (137, 7, '2019-11-13 14:57:21.703689', NULL);
INSERT INTO `room_amenities` VALUES (137, 8, '2019-11-13 14:57:21.705113', NULL);
INSERT INTO `room_amenities` VALUES (137, 9, '2019-11-13 14:57:21.708850', NULL);
INSERT INTO `room_amenities` VALUES (137, 10, '2019-11-13 14:57:21.719758', NULL);
INSERT INTO `room_amenities` VALUES (137, 11, '2019-11-13 14:57:21.721090', NULL);
INSERT INTO `room_amenities` VALUES (138, 1, '2019-11-13 18:27:27.494419', NULL);
INSERT INTO `room_amenities` VALUES (138, 2, '2019-11-13 18:27:27.500284', NULL);
INSERT INTO `room_amenities` VALUES (138, 3, '2019-11-13 18:27:27.519067', NULL);
INSERT INTO `room_amenities` VALUES (138, 4, '2019-11-13 18:27:27.524371', NULL);
INSERT INTO `room_amenities` VALUES (138, 5, '2019-11-13 18:27:27.525870', NULL);
INSERT INTO `room_amenities` VALUES (138, 6, '2019-11-13 18:27:27.520047', NULL);
INSERT INTO `room_amenities` VALUES (138, 7, '2019-11-13 18:27:27.528821', NULL);
INSERT INTO `room_amenities` VALUES (138, 8, '2019-11-13 18:27:27.544921', NULL);
INSERT INTO `room_amenities` VALUES (138, 9, '2019-11-13 18:27:27.536739', NULL);
INSERT INTO `room_amenities` VALUES (138, 10, '2019-11-13 18:27:27.547705', NULL);
INSERT INTO `room_amenities` VALUES (138, 11, '2019-11-13 18:27:27.547497', NULL);
INSERT INTO `room_amenities` VALUES (139, 1, '2019-11-14 04:54:44.930225', NULL);
INSERT INTO `room_amenities` VALUES (139, 2, '2019-11-14 04:54:44.932535', NULL);
INSERT INTO `room_amenities` VALUES (139, 3, '2019-11-14 04:54:44.917539', NULL);
INSERT INTO `room_amenities` VALUES (139, 4, '2019-11-14 04:54:44.920345', NULL);
INSERT INTO `room_amenities` VALUES (139, 5, '2019-11-14 04:54:44.919360', NULL);
INSERT INTO `room_amenities` VALUES (139, 6, '2019-11-14 04:54:44.922030', NULL);
INSERT INTO `room_amenities` VALUES (139, 7, '2019-11-14 04:54:44.923155', NULL);
INSERT INTO `room_amenities` VALUES (139, 8, '2019-11-14 04:54:44.931329', NULL);
INSERT INTO `room_amenities` VALUES (139, 9, '2019-11-14 04:54:44.958108', NULL);
INSERT INTO `room_amenities` VALUES (139, 10, '2019-11-14 04:54:44.941985', NULL);
INSERT INTO `room_amenities` VALUES (139, 11, '2019-11-14 04:54:44.948088', NULL);
COMMIT;

-- ----------------------------
-- Table structure for room_group
-- ----------------------------
DROP TABLE IF EXISTS `room_group`;
CREATE TABLE `room_group` (
  `room_group_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room group',
  `building_id` int(5) DEFAULT NULL COMMENT 'ID of the building that the group belongs to',
  `gender` bit(1) DEFAULT NULL COMMENT 'Gender in the group',
  `rent_price` double(10,0) DEFAULT NULL COMMENT 'Rent price of the room group',
  `min_deposit_period` int(5) DEFAULT NULL COMMENT 'minimun months of deposit',
  `area` double(10,0) DEFAULT NULL COMMENT 'Area of the room group',
  `bedroom_quantity` int(5) DEFAULT '1' COMMENT 'Number of  bedrooms in the building',
  `bathroom_quantity` int(5) DEFAULT '1' COMMENT 'Number of bathrooms in the building',
  `direction` varchar(255) DEFAULT NULL COMMENT 'direction of the room',
  `is_available` bit(1) DEFAULT b'1' COMMENT 'The group is available or not',
  `is_verified` bit(1) DEFAULT NULL COMMENT 'Room group is verified or not',
  `deposit_price` double(10,0) DEFAULT NULL COMMENT 'Deposit price of the room group',
  `description` text COMMENT 'Description of the room group',
  `capacity` int(10) DEFAULT NULL COMMENT 'Capacity of the room group',
  `view_amount` int(10) DEFAULT NULL COMMENT 'View amount of the room group',
  `phone_view_amount` int(10) DEFAULT NULL COMMENT 'View via phone amount of the room group',
  `is_sponsored` bit(1) DEFAULT b'0' COMMENT 'The room group is sponsored or not',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_group_id`) USING BTREE,
  KEY `FK_room_group_building` (`building_id`) USING BTREE,
  CONSTRAINT `FK_room_group_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room_group
-- ----------------------------
BEGIN;
INSERT INTO `room_group` VALUES (1, 9, NULL, 2500000, 1, 150, 1, 1, 'all', NULL, NULL, 1500000, 'Phòng đẹp, sạch sẽ có ban công. Hàng xóm thân thiện', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (10, 8, NULL, 7500000, 1, 200, 2, 2, 'Đông Bắc', NULL, NULL, 5000000, 'Căn hộ view đẹp, đầy đủ tiện nghi.\nGửi xe tầng hầm miễn phí.\nTest', 4, NULL, NULL, NULL, '2019-11-04 06:40:15.296960', '2019-11-04 06:40:15.296960');
INSERT INTO `room_group` VALUES (11, 9, NULL, 1500000, 1, 100, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng đẹp, sạch sẽ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (12, 10, NULL, 1500000, 1, 100, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng đẹp', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (13, 12, NULL, 9999999999, -1, -11, 1, 2, 'Đông Bắc', NULL, NULL, 1500000, 'Không biết', -11, NULL, NULL, NULL, NULL, '2019-11-13 18:09:41.745275');
INSERT INTO `room_group` VALUES (14, 13, NULL, 4500000, 1, 80, 1, 1, 'Đông', NULL, NULL, 5000000, 'Nhà rộng rãi, sạch sẽ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (15, 14, NULL, 5500000, 2, 100, 2, 2, 'Đông Nam', NULL, NULL, 4000000, 'Nhà sạch và rộng, mới xây', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (16, 15, NULL, 3500000, 1, 60, 1, 1, 'Tây Nam', NULL, NULL, 3000000, 'Thoáng mát, sạch sẽ, tiện nghi', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (17, 16, NULL, 6500000, 1, 100, 1, 1, 'Bắc', NULL, NULL, 67000000, 'Nhà mới chung cư Vincom, sôi động', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (18, 17, NULL, 5500000, 1, 70, 1, 2, 'Bắc', NULL, NULL, 5000000, 'Nhà Vincom sạch sẽ thoáng mát', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (19, 18, NULL, 3500000, 1, 100, 1, 1, 'Nam', NULL, NULL, 3000000, 'Chung cư mới sạch thoáng mát', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (20, 19, NULL, 3500000, 2, 30, 1, 1, 'Đông Bắc', NULL, NULL, 43000000, 'Nhà kiến trúc đẹp, phong cách cổ kính nhưng vẫn đầy đủ tiện nghi', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (21, 20, NULL, 10500000, 1, 150, 2, 2, 'Đông Nam', NULL, NULL, 10000000, 'Nhà mới xây nhưng không sử dụng nên có nhu cầu cho thuê lại, đồ đạc tiện nghi mới mẻ', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (22, 21, NULL, 5500000, 1, 50, 2, 1, 'Đông', NULL, NULL, 5000000, 'Nhà mới xây', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (23, 22, NULL, 4500000, 0, 60, 1, 1, 'Bắc', NULL, NULL, 4000000, 'Nhà cấp 4 rộng rãi, thoáng mát', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (24, 23, NULL, 7500000, 1, 100, 2, 1, 'Tây Nam', NULL, NULL, 6000000, 'Nhà cho gia đình 4 người ở thoải mái', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (25, 24, NULL, 3500000, 1, 120, 2, 1, 'Nam', NULL, NULL, 3000000, 'Mát mẻ vào mùa hè, ấm áp vào mùa đông\n', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (26, 25, NULL, 5500000, 1, 40, 1, 1, 'Đông Nam', NULL, NULL, 3000000, 'Căn hộ hợp lý cho sinh viên', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (27, 26, NULL, 5000000, 1, 45, 1, 1, 'Tây Bắc', NULL, NULL, 4000000, 'Căn hộ nguyên căn tiện nghi', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (28, 27, NULL, 3500000, 1, 50, 1, 1, 'Tây', NULL, NULL, 2000000, 'Nhà đẹp', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (29, 28, NULL, 1000000, 1, 30, 1, 1, 'all', NULL, NULL, 1000000, 'gọn gàng sạch sẽ phòng mới xây đầy đủ điều hòa nóng lạnh', 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (30, 29, NULL, 1800000, 2, 25, 1, 1, 'all', NULL, NULL, 1000000, 'Có phòng cho thuê diện tích 15m2 - 25m2.\nGiá 1,8tr/th.\nPhòng to sạch sẽ có nóng lạnh, điều hòa, có ban công cửa sổ thoáng mát, có chỗ để xe và phơi đồ riêng.\nTại địa chỉ ngõ 252 Tây Sơn gần đại học Thủy Lợi - Công Đoàn.\nLiên hệ: Chị Linh 0375147121 (MTG).', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (31, 29, NULL, 1500000, 2, 20, 1, 1, 'all', NULL, NULL, 1000000, 'Có phòng cho thuê diện tích 15m2 - 25m2.\nGiá 1,5tr/th và 1,8tr/th.\nPhòng to sạch sẽ có nóng lạnh, điều hòa, có ban công cửa sổ thoáng mát, có chỗ để xe và phơi đồ riêng.\nTại địa chỉ ngõ 252 Tây Sơn gần đại học Thủy Lợi - Công Đoàn.\nLiên hệ: Chị Linh 0375147121 (MTG).', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (32, 30, NULL, 2200000, 1, 20, 1, 1, 'all', NULL, NULL, 1000000, '- Phòng 35m2 khép kín có bếp, có nhà WC và một số đồ cơ bản.\n- Địa chỉ tại số 1/43 ngõ Thanh Miến, phố Văn Miếu, Đống Đa, HN.\n- Giá là 3.500.000 vnđ/ tháng ưu tiên gia đình và sinh viên nữ thuê.\n- LH: 0983.027.485.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (33, 30, NULL, 2500000, 2, 25, 1, 1, 'all', NULL, NULL, 1000000, '- Phòng 35m2 khép kín có bếp, có nhà WC và một số đồ cơ bản.\n- Địa chỉ tại số 1/43 ngõ Thanh Miến, phố Văn Miếu, Đống Đa, HN.\n- Giá là 3.500.000 vnđ/ tháng ưu tiên gia đình và sinh viên nữ thuê.\n- LH: 0983.027.485.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (34, 31, b'0', 1500000, 2, 15, 1, 1, 'all', NULL, NULL, 2000000, 'Xanh sạch đẹp.\nChủ nhà thân thiện.\nGiờ giấc thoải mái.\nĐặc biệt trọ chỉ tuyển người đẹp trai vào thuê !!!', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (35, 31, b'0', 1200000, 2, 13, 1, 1, 'all', NULL, NULL, 1500000, 'Trọ cho người đẹp trai vừa phải', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (36, 32, NULL, 3500000, 1, 25, 1, 1, 'all', NULL, NULL, 3000000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2- 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 ( MIỄN TIÊP MÔI GIỚI)', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (37, 32, NULL, 2500000, 1, 20, 1, 1, 'all', NULL, NULL, 2500000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2- 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 ( MIỄN TIÊP MÔI GIỚI)', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (38, 33, NULL, 2500000, 2, 20, 1, 1, 'all', NULL, NULL, 1000000, 'Chung cư mini 6 tầng còn 5 phòng cho thuê ở ngõ 3 Thái Hà - còn trống trên tầng 2, 3 muốn cho thuê - tầng 1 để xe, có bảo vệ 24/24h an ninh tốt, giờ giấc tự do - phòng khép kín hết, có kệ bếp nấu ăn, có giường, tivi, nóng lạnh, điều hòa, tủ quần áo - ở được 2, 3 bạn sinh viên, hoặc hộ gia đình nhỏ.\nĐiện nước: 3.000/số.\nNước 50.000/người/tháng.\nDiện tích: 25m2 - 30 m2.\nGiá: Từ 2,3tr/th - 2,6tr/th.\nLiên hệ: Anh Nam: 0345.064.289/ chị Linh: 0375.429.239 miễn môi giới làm phiền.\n', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (39, 33, NULL, 3500000, 2, 25, 1, 1, 'all', NULL, NULL, 2000000, 'Chung cư mini 6 tầng còn 5 phòng cho thuê ở ngõ 3 Thái Hà - còn trống trên tầng 2, 3 muốn cho thuê - tầng 1 để xe, có bảo vệ 24/24h an ninh tốt, giờ giấc tự do - phòng khép kín hết, có kệ bếp nấu ăn, có giường, tivi, nóng lạnh, điều hòa, tủ quần áo - ở được 2, 3 bạn sinh viên, hoặc hộ gia đình nhỏ.\nĐiện nước: 3.000/số.\nNước 50.000/người/tháng.\nDiện tích: 25m2 - 30 m2.\nGiá: Từ 2,3tr/th - 2,6tr/th.\nLiên hệ: Anh Nam: 0345.064.289/ chị Linh: 0375.429.239 miễn môi giới làm phiền.\n', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (40, 33, NULL, 1500000, 1, 20, 1, 1, 'all', NULL, NULL, 2000000, 'Chung cư mini 6 tầng còn 5 phòng cho thuê ở ngõ 3 Thái Hà - còn trống trên tầng 2, 3 muốn cho thuê - tầng 1 để xe, có bảo vệ 24/24h an ninh tốt, giờ giấc tự do - phòng khép kín hết, có kệ bếp nấu ăn, có giường, tivi, nóng lạnh, điều hòa, tủ quần áo - ở được 2, 3 bạn sinh viên, hoặc hộ gia đình nhỏ.\nĐiện nước: 3.000/số.\nNước 50.000/người/tháng.\nDiện tích: 25m2 - 30 m2.\nGiá: Từ 2,3tr/th - 2,6tr/th.\nLiên hệ: Anh Nam: 0345.064.289/ chị Linh: 0375.429.239 miễn môi giới làm phiền.\n', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (41, 34, NULL, 3200000, 1, 26, 1, 1, 'all', NULL, NULL, 3000000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2 - 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 Chú Dũng 0966.223.091 (MTG).', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (42, 34, NULL, 2700000, 2, 22, 1, 1, 'all', NULL, NULL, 3000000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2 - 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 Chú Dũng 0966.223.091 (MTG).', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (43, 35, NULL, 2000000, 2, 20, 1, 1, 'all', NULL, NULL, 2000000, 'Nhà đẹp rộng rãi\nĐI lại thoải mái\nTrông xe đảm bảo\nĐIện nước giá dân', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (44, 35, b'1', 3000000, 2, 25, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp rộng rãi\nĐI lại thoải mái\nTrông xe đảm bảo\nĐIện nước giá dân', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (45, 36, NULL, 2100000, 2, 18, 1, 1, 'all', NULL, NULL, 2000000, 'Cho thuê phòng giá rẻ tại Tôn Đức Thắng - Khâm Thiên. Gia: 800 nghìn/th - 1tr - 1,2tr/tháng. Diện tích 14m2 - 15m2 - 17m2. Phòng sạch sẽ thoáng phù hợp để sinh viên hoặc người đi làm. Tiện chợ gần đường lớn, gần các trường đại học. Đóng tiền tháng 1, bạn bè đến chơi thoải mái,', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (46, 36, NULL, 2500000, 1, 23, 1, 1, 'all', NULL, NULL, 3000000, 'Cho thuê phòng giá rẻ tại Tôn Đức Thắng - Khâm Thiên. Gia: 800 nghìn/th - 1tr - 1,2tr/tháng. Diện tích 14m2 - 15m2 - 17m2. Phòng sạch sẽ thoáng phù hợp để sinh viên hoặc người đi làm. Tiện chợ gần đường lớn, gần các trường đại học. Đóng tiền tháng 1, bạn bè đến chơi thoải mái,', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (47, 37, NULL, 2300000, 2, 23, 1, 1, 'all', NULL, NULL, 2000000, '- Nhà xây kiểu chung cư 6 tầng, phòng khép kín, có nóng lạnh. - Diện tích 18m2 - 20m2 - 25m2. - Giá 1.600.000/th - 1,800,000/th - 2.000.000đ/ tháng.- Phòng thoáng mát sạch sẽ, ban công, cửa sổ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (48, 37, NULL, 3000000, 2, 28, 1, 1, 'all', NULL, NULL, 3000000, '- Nhà xây kiểu chung cư 6 tầng, phòng khép kín, có nóng lạnh. - Diện tích 18m2 - 20m2 - 25m2. - Giá 1.600.000/th - 1,800,000/th - 2.000.000đ/ tháng.- Phòng thoáng mát sạch sẽ, ban công, cửa sổ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (49, 38, b'0', 3000000, 2, 25, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp \nThơm tho thoáng mát\nKhông tệ nạn', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (50, 39, NULL, 3500000, 2, 26, 1, 1, 'all', NULL, NULL, 3000000, 'Cho thuê phòng, nhà 5 tầng, ngõ 12/12 Nguyễn Phúc Lai, Đống Đa.\nGần hồ Hoàng Cầu, đại học Văn Hóa, học viện Âm Nhạc, Đê La Thành, Giảng Võ. Nhà ô tô vào được. Có máy giặt, điện 3.500 đ/số, nước 70.000 đ/người, nhà còn 01 phòng tầng 4 có Điều Hòa và Nóng Lạnh, phơi quần áo trên tầng 5, tầng 1 để xe, phòng rộng 27m2. Đi lại tự quản. Phòng có 02 cửa sổ nhìn ra ngõ thoáng mát.\nGọi ngay Mr Dũng 0978713456. Giá 2.400.000 đ/th.\nỞ ngay.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (51, 39, NULL, 2500000, 2, 22, 1, 1, 'all', NULL, NULL, 3000000, 'Cho thuê phòng, nhà 5 tầng, ngõ 12/12 Nguyễn Phúc Lai, Đống Đa.\nGần hồ Hoàng Cầu, đại học Văn Hóa, học viện Âm Nhạc, Đê La Thành, Giảng Võ. Nhà ô tô vào được. Có máy giặt, điện 3.500 đ/số, nước 70.000 đ/người, nhà còn 01 phòng tầng 4 có Điều Hòa và Nóng Lạnh, phơi quần áo trên tầng 5, tầng 1 để xe, phòng rộng 27m2. Đi lại tự quản. Phòng có 02 cửa sổ nhìn ra ngõ thoáng mát.\nGọi ngay Mr Dũng 0978713456. Giá 2.400.000 đ/th.\nỞ ngay.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (52, 40, NULL, 4000000, 3, 30, 1, 1, 'all', NULL, NULL, 4000000, 'Phòng Vip cho dân chơi', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (53, 40, NULL, 2500000, 3, 25, 1, 1, 'all', NULL, NULL, 3000000, 'Phòng thường cho dân thường', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (54, 41, NULL, 2800000, 2, 28, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp dùng để setup khách sạn, nay cho thuê phòng trọ, căn hộ mini cao cấp.\nVị trí gần Hoàng Cầu, Nhạc Viện Hà Nội, Đại Học Thủy Lợi, Đại Học Công Đoàn, Đại Học Ngân Hàng….\nNgõ rộng ô tô vào gần tận nhà, đầy đủ đồ điều hòa, nóng lạnh, máy giặt, giường đệm cao cấp, điện nước giá nhà nước, tự do đi lại không chung chủ.\nĐ/c: Số 10, ngách 66, ngõ giếng, phố Đông Các, Ô Chợ Dừa, Đống Đa, Hà Nội.\nGiá 3,8 tr/tháng, rộng 38m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nGiá 4,5 tr/tháng, rộng 45m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nChú ý: Có wifi, truyền hình cáp full HD, để xe miễn phí, giờ tự do không chung chủ, cho nấu ăn, Mr Đại 0904 5959 62', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (55, 41, NULL, 2500000, 2, 22, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp dùng để setup khách sạn, nay cho thuê phòng trọ, căn hộ mini cao cấp.\nVị trí gần Hoàng Cầu, Nhạc Viện Hà Nội, Đại Học Thủy Lợi, Đại Học Công Đoàn, Đại Học Ngân Hàng….\nNgõ rộng ô tô vào gần tận nhà, đầy đủ đồ điều hòa, nóng lạnh, máy giặt, giường đệm cao cấp, điện nước giá nhà nước, tự do đi lại không chung chủ.\nĐ/c: Số 10, ngách 66, ngõ giếng, phố Đông Các, Ô Chợ Dừa, Đống Đa, Hà Nội.\nGiá 3,8 tr/tháng, rộng 38m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nGiá 4,5 tr/tháng, rộng 45m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nChú ý: Có wifi, truyền hình cáp full HD, để xe miễn phí, giờ tự do không chung chủ, cho nấu ăn, Mr Đại 0904 5959 62', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (56, 42, NULL, 4000000, 2, 30, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp\nSạch sẽ\nChủ nhà vui tính', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (57, 42, NULL, 3500000, 2, 25, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp\nSạch sẽ\nChủ nhà vui tính', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (58, 43, NULL, 3500000, 2, 25, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp thoáng mát', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (59, 44, NULL, 1500000, 1, 25, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng trọ cho sinh viên', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (60, 44, NULL, 2500000, 1, 30, 1, 1, 'all', NULL, NULL, 2000000, 'Phòng trọ diện tích rộng cho sinh viên', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (61, 45, NULL, 3500000, 2, 30, 1, 1, 'all', NULL, NULL, 2000000, 'Nhà đẹp thoáng mát\n\n\nCực thuận tiện vì gần chợ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (62, 45, NULL, 2500000, 2, 25, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp thoáng mát\n\n\nCực thuận tiện vì gần chợ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (63, 46, NULL, 2000000, 1, 20, 1, 1, 'all', NULL, NULL, 1500000, 'Phòng loại rẻ nhất', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (64, 46, NULL, 4000000, 1, 40, 1, 1, 'all', NULL, NULL, 3500000, 'Phòng 40m2 rộng rãi với 2 người, phù hợp cho 3 người ở, tiện nghi hiện đại', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (65, 46, NULL, 3500000, 1, 30, 1, 1, 'all', NULL, NULL, 3000000, 'Phòng 30m2 rộng rãi thoải mái', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (66, 47, NULL, 2500000, 2, 20, 1, 1, 'all', NULL, NULL, 2000000, 'Nhà sạch đẹp', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (67, 48, NULL, 1500000, 1, 20, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng nhỏ loại 1 rẻ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (68, 48, NULL, 2500000, 1, 30, 1, 1, 'all', NULL, NULL, 2000000, 'Phòng lớn loại 2', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (69, 49, NULL, 2500000, 2, 100, 1, 1, 'all', NULL, NULL, 3000000, 'Thoáng mát', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (70, 50, NULL, 2500000, 1, 25, 1, 1, 'all', NULL, NULL, 2000000, 'Phòng loại 2 có điều hòa', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (71, 50, NULL, 1500000, 1, 20, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng loại 1 không điều hòa', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (72, 50, NULL, 3500000, 1, 30, 1, 1, 'all', NULL, NULL, 3000000, 'Phòng loại 3 rộng rãi có điều hòa và ban công', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (73, 51, b'0', 3500000, 1, 30, 1, 1, 'all', NULL, NULL, 1000000, 'Nhà Đẹp', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (74, 51, b'0', 2500000, 2, 20, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (75, 52, NULL, 10000000, 2, 75, 2, 4, 'Nam', NULL, NULL, 5000000, 'Cho người nhiều tiền', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (76, 53, NULL, 8500000, 4, 100, 2, 3, 'Tây', NULL, NULL, 2000000, 'Nhà đẹp ', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (77, 54, NULL, 7500000, 2, 50, 3, 2, 'Đông', NULL, NULL, 2000000, 'Nhà thích hợp cho trẻ em\n', 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (78, 55, b'0', 2300000, 1, 20, 1, 1, 'all', NULL, NULL, 3000000, 'òa chung cư mini 7 tầng, tại ngõ 43 Xã Đàn, quận Đống Đa, Hà Nội.\nPhòng nhỏ giá 3tr - 4tr/th.\nPhòng to giá 5tr/th.\n+ Phòng bếp được trang bị điều hòa, nóng lạnh, giường, tủ.\n+ Khu vực nhà vệ sinh được lắp đầy đủ thiết bị hiện đại như chậu rửa mặt, bệt Inax, vòi sen.\n- Tiện ích: Tòa nhà có bảo vệ 24/24, đảm bảo an ninh tuyệt đối, giờ giấc ra vào thoải mái.\nInternet cáp quang,\n- Tòa nhà nằm ở vị trí trung tâm, giao thông thuận tiện, gần đường Đê La Thành, Khâm Thiên, Phạm Ngọc Thạch.\n- Ưu tiên cho hộ gia đình, sinh viên người đi làm hiền lành thuê ở.\n- Chỉ ở từ 2 - 3 người/phòng.\n\nĐịa chỉ: Ngõ 43 Xã Đàn - Ô Chợ Dừa - Đống Đa - Hà Nội.\nLiên hệ: Anh Thành 0936412192 (Liên hệ xem phòng ban ngày từ 8h sáng đến 18h).', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (79, 55, b'0', 2800000, 1, 25, 1, 1, 'all', NULL, NULL, 3000000, 'òa chung cư mini 7 tầng, tại ngõ 43 Xã Đàn, quận Đống Đa, Hà Nội.\nPhòng nhỏ giá 3tr - 4tr/th.\nPhòng to giá 5tr/th.\n+ Phòng bếp được trang bị điều hòa, nóng lạnh, giường, tủ.\n+ Khu vực nhà vệ sinh được lắp đầy đủ thiết bị hiện đại như chậu rửa mặt, bệt Inax, vòi sen.\n- Tiện ích: Tòa nhà có bảo vệ 24/24, đảm bảo an ninh tuyệt đối, giờ giấc ra vào thoải mái.\nInternet cáp quang,\n- Tòa nhà nằm ở vị trí trung tâm, giao thông thuận tiện, gần đường Đê La Thành, Khâm Thiên, Phạm Ngọc Thạch.\n- Ưu tiên cho hộ gia đình, sinh viên người đi làm hiền lành thuê ở.\n- Chỉ ở từ 2 - 3 người/phòng.\n\nĐịa chỉ: Ngõ 43 Xã Đàn - Ô Chợ Dừa - Đống Đa - Hà Nội.\nLiên hệ: Anh Thành 0936412192 (Liên hệ xem phòng ban ngày từ 8h sáng đến 18h).', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (80, 56, NULL, 15000000, 1, 50, 2, 1, 'Đông Bắc', NULL, NULL, 10000000, 'Căn hộ cao cấp tại Xã Đàn, Ô Chợ Dừa. I, Thiết kế căn hộ. + Diện tích, giá: 25m2-35m2 giá từ 4.5 - 5 - 5.5 tr/th. + Vệ sinh khép kín. + Vị trí: 275 Xã Đàn. + Cách mặt đường lớn ngã 6 Ô Chợ Dừa tầm 50m. II, Tiện ích tòa nhà. - Full đồ.', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (81, 57, NULL, 2500000, 1, 80, 2, 2, 'Nam', NULL, NULL, 10000000, 'Hiện tôi còn duy nhất một phòng trọ tầng 3 diện tích 15m2, tại nhà số 6 ngõ 137, Hào Nam, Phường Ô Chợ Dừa, phố Hào Nam, Đống Đa, Hà Nội. Tiện ích: - Gần Nhạc Viện, Đại học Mỹ Thuật, ngõ rộng ô tô đỗ cửa tiện đi lại. - Vệ sinh có bình nóng lạnh, quạt trần, nhà sạch sẽ, an ninh', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (82, 58, NULL, 150000000, 1, 70, 2, 1, 'Đông Bắc', NULL, NULL, 12000000, 'LIGOT mái nhà chung của mọi người! Xách đồ ngay tới các địa chỉ của chúng tôi: 1. Căn hộ dịch vụ số 224 Mai Anh Tuấn (vệ hồ Hoàng Cầu). 2. Homestay 73 Nguyên Hồng. 3. Căn hộ 54A Thợ Nhuộm. Đơn vị phát triển: Phi Long DC. Thông tin sản phẩm. - Căn phòng được setup ', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (83, 59, NULL, 8500000, 1, 90, 3, 2, '', NULL, NULL, 8000000, 'Diện tích các căn hộ từ 25m2 - 30m2 - 35m2. Với các mức giá cho thuê từ 3.000.000đ/th - 3.500.000/th - đến 5.500.000đ/căn.Các căn hộ bao gồm:+ 1 phòng ngủ riêng biệt có cửa sổ thông thoáng được trang bị điều hòa 2 chiều, giường, tủ quần áo, bàn ăn, bàn trang điểm (tùy căn)', 6, NULL, NULL, NULL, '2019-11-05 06:10:38.054664', '2019-11-05 06:10:38.054664');
INSERT INTO `room_group` VALUES (84, 60, NULL, 24000000, 1, 68, 3, 2, 'Đông Nam', NULL, NULL, 20000000, 'Xem nhà 24/7:\nPhòng kinh doanh quản lý cho thuê các căn hộ tại chung cư cao cấp Tân Hoàng Minh D\'. Le Pont D\'or – 36 Hoàng Cầu giá tốt nhất thị trường, chỉ từ 14 triệu/tháng, diện tích từ 68m2 - 145m2.\nLiên hệ Mr Mạnh: 0936.386.595.\n- Giá cam kết rẻ nhất thị trường.\n- Tư vấn nhiệt tình chính xác nhất.\n- Xem nhà bất kể khi nào 24/7.\n- Ký hợp đồng trực tiếp với chủ nhà.\n- Có ưu đãi cho khách hàng đặt cọc trước.\n- Khách thuê được xem trực tiếp căn hộ, làm việc chính chủ.\n- Hỗ trợ tư vấn về pháp lý và thủ tục trong suốt thời gian thuê nhà.\n- Căn hộ 68m2, 1 phòng ngủ, đầy đủ nội thất thiết kế đẹp mắt ban công view hồ. Giá 14 triệu/tháng.\n- Căn hộ 75m2, 2 phòng ngủ, đầy đủ đồ cao cấp: Sofa, giường, tủ âm tường, tủ tivi, bàn ăn, kệ bếp tủ bếp,... Giá 16 triệu/tháng.\n- Căn hộ 100m2, thiết kết 2 phòng ngủ, đồ cơ bản có điều hòa âm trần, sàn gỗ, nóng lạnh, kệ tủ bếp, giá 16 triệu/tháng.\n- Căn hộ 100m2, thiết kế 2 phòng ngủ, tầng đẹp, đầy đủ nội thất sang trọng. Giá: 18 triệu/tháng.\n- Căn hộ 128m2, thiết kế 3 phòng ngủ, đồ cơ bản: Điều hòa âm trần, sàn gỗ, nóng lạnh, kệ tủ bếp. Giá 18 triệu/tháng.\n- Căn hộ 128m2, thiết kế 3 phòng ngủ, full đồ, nội thất đẹp chỉ việc mang quần áo đến ở. Giá 22 triệu/tháng.\n- Căn hộ 145m2, thiết kế 3 phòng ngủ, full đồ, nội thất sang trọng, chỉ việc mang quần áo đến ở. Giá 25 triệu/tháng.\n\n+ Vị trí: Tòa nhà D. \'Le Pont D\'or 36 Hoàng Cầu chủ đầu tư Tân Hoàng Minh, cạnh hồ Hoàng Cầu giao thông thuận lợi. Tọa lạc tại vị trí đắc địa bậc nhất thủ đô, nằm bên hồ Hoàng Cầu, tòa tháp căn hộ cao cấp D\'. Le Pont D\'or Hoàng Cầu được xây dựng và thiết kế theo phong cách Tân Cổ Điển đã thiết lập tiêu chuẩn mới cho cuộc sống đô thị hiện đại ở Việt Nam.\n+ Tiện ích: Tòa nhà có hệ thống an ninh tốt. Có bể bơi bốn mùa tại tầng 2. Có siêu thị nhà hàng, spa, gym.\nQuý khách hãy liên hệ sớm với chúng tôi để nhanh chóng tìm được căn hộ ưng ý nhất nhé.\nBan Quản Lý tòa nhà : Mr Mạnh.\nMobile: 0936.386.595 or 0974.548.024 ( MTG).\nChân thành cảm ơn quý khách hàng đã quan tâm!', 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (85, 61, NULL, 7500000, 1, 63, 2, 1, 'Tây Bắc', NULL, NULL, 7000000, 'Cho thuê căn hộ chung cư mini Xã Đàn mới xây Phường Ô chợ Dừa, khu vực dân trí cao, đi lại thuận tiện ô tô đỗ cửa...\nDiện tích từ 26m2 - 35m2,1 phòng ngủ, sàn gỗ, nóng lạnh,điều hòa, tivi, ttur lạnh, máy giặt, có tủ quần áo, giường, có bếp từ, bàn bếp, Tủ bếp hút mùi, truyền hình cáp,internet wifi, điện nước đầy đủ công tơ riêng, tầng hầm để xe, nhà mới sạch sẽ thoáng mát,an ninh tốt,có bảo vệ 24/24 \nphù hợp hộ gia đình trẻ, chìa khóa trao tay,\ngiá 3.5 triệu nội thất cơ bản, 4,5 triệu / tháng đủ đồ tivi, tủ lạnh, máy giặt  ....\n\nliên hệ ngay gặp MR. Hùng 0963 488 688.', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (86, 62, NULL, 12500000, 1, 56, 3, 2, 'Đông', NULL, NULL, 10000000, 'BQL cần cho thuê một số căn hộ chung cư tại Hoàng Cầu Skyline, 36 Hoàng Cầu - Dự án của Tân Hoàng Cầu, Đống Đa, Hà Nội giá từ 14 triệu/tháng với diện tích từ 67m2 - 130m2:\n* Căn hộ đồ cơ bản.\n- 130m2: 3 PN, 2 vệ sinh, giá 18 triệu/tháng.\n- 112m2: 3 PN, 2 vệ sinh, giá 17 triệu/tháng.\n- 67m2: 2 PN, 2 vệ sinh, giá 14 triệu/tháng.\n- 85m2: 2 PN, 2 vệ sinh, giá 15 triệu/tháng.\n- 92m2: 2 PN, 2 vệ sinh, giá 16 triệu/tháng.\n\n* Căn hộ đầy đủ đồ: 02 ti vi, đầy đủ giường ngủ, bàn ghế sofa, bàn ghế ăn, bếp từ - Hệ thống tủ bếp hiện đại, máy giặt Electrolux, thiết bị vệ sinh TOTO, bình nóng lạnh, tủ âm tường, tủ quần áo, kệ đầu giường, điều hòa Daikin 2 chiều. Khách chỉ cần mang quần áo đến ở.\n- 130m2: 3 PN, 2 vệ sinh, giá 20 triệu/tháng.\n- 112m2: 3 PN, 2 vệ sinh, giá 19 triệu/tháng.\n- 67m2: 2 PN, 2 vệ sinh, giá 16 triệu/tháng.\n- 85m2: 2 PN, 2 vệ sinh, giá 17 triệu/tháng.\n- 92m2: 2 PN, 2 vệ sinh, giá 18 triệu/tháng.\n\nTiện ích của tòa nhà: Gym, bể bơi, siêu thị Minh Hoa, nhà trẻ quốc tế, hầm để xe rộng rãi, an ninh tốt, bộ phận lễ tân chuyên nghiệp.\n\nXin liên hệ: 0971. 216. 995 gặp Ms Chinh để được tư vấn và xem nhà.\nMiễn phí hoàn toàn cho khách thuê.\nCảm ơn đã đọc tin và MTG.', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (87, 63, NULL, 15000000, 1, 100, 3, 3, 'Tây', NULL, NULL, 10000000, 'Có phòng cho thuê chung cư mini 7 tầng, ngõ 43 Chùa Bộc.\n- Diện tích 17m2 - 21m2 - 25m2 khép kín (có điều hòa, nóng lạnh).\n- Giá phòng 1,500,000/th - 1,800,000/th - 2tr/th - 2,500,000/ tháng. (nhà trọ cho thuê).\n- Có phòng to full đồ 3 tr/th và 3,5 triệu/th.\n- Phòng rất gần trường Ngân Hàng, Y, Công Đoàn, Thủy Lợi.\n- Phòng trọ thoáng mát sạch sẽ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặt... ) phục vụ cho các bạn cáp, nét (mạng cáp quang) đầy đủ. Điện nước đầy đủ và được tính theo đồng hồ để cho các bạn yên tâm về số lượng mình dùng. Đặc biệt bảo vệ 24.24 nên an ninh đảm bảo yên tâm 100% nhé.\n- Liên hệ: 0352.761.017 (cô Hoa).', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (88, 64, NULL, 15000000, 1, 90, 3, 3, '', NULL, NULL, 10000000, 'Chung cư mini số 22 Tôn Thất Tùng cần cho thuê phòng:\n- Giá cả 2,2 triệu/tháng - 2,3tr/th - 2,5tr/th - 3tr/th.\n- Diện tích 22m2 - 25m2 - 27m2 - 30m2.\n- Tiện nghi các phòng đều khép kín, tùy theo mức giá có nóng lạnh, điều hòa, vòi hoa sen chậu rửa, sàn ốp đá hoa cao cấp, ban công cửa sổ thoáng đãng, nấu ăn trong phòng. Khu dân trí cao an ninh tốt. Có bảo vệ 24/24 tiện chợ, gần đường lớn.\nỞ riêng chủ, bạn bè phụ huynh đến chơi thoải mái.\nƯu tiên sinh viên hoặc người đi làm.\nLiên hệ: Chú Tân (cô Mai) 0375147121 (miễn tiếp trung gian).', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (89, 65, NULL, 12500000, 1, 110, 3, 2, '', NULL, NULL, 12000000, 'Địa chỉ: Số 35A ngõ 7 Thái Hà, Hà Nội.\nLH Anh Chiến 0936412192 (xem phòng từ 7h45p - 18h10).\nMình còn 2 loại phòng cho thuê ở được luôn. Rất gần ĐH Công Đoàn, Thủy Lợi, Ngân Hàng, Y Hà Nội.\n- Phòng nhỏ giá: 2.5tr - 3tr/th.\n- Phòng to giá: 3,5tr - 4.5tr/th.\n- An ninh rất tốt, xe để tầng 1.\nƯu tiên sinh viên, người đi làm hiền lành ở.\nPhòng cho thuê gần phố Tây Sơn, Thái Thịnh, Chùa Bộc.', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (90, 66, NULL, 25000000, 1, 80, 4, 3, '', NULL, NULL, 20000000, '- Nhà xây kiểu chung cư 6 tầng, phòng khép kín, có nóng lạnh.\n- Diện tích 18m2 - 20m2 - 25m2.\n- Giá 1.600.000/th - 1,800,000/th - 2.000.000đ/ tháng.\n\n- Phòng thoáng mát sạch sẽ, ban công, cửa sổ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặt... ) miễn phí net. Điện 3.500/số, nước 20.000/khối.\n\nLiên hệ: Chị Trang: 0327.946.467. Bác Tuấn BV: 0961.085.122 (MTG).', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (91, 67, NULL, 15000000, 1, 67, 3, 3, '', NULL, NULL, 10000000, 'Cho thuê phòng trọ ở ngõ 580 Trường Chinh.\nNhà mình còn 3 phòng trọ khép kín muốn cho sinh viên hoặc người đi làm thuê.\nDT: 15m2 - 18m2 - 22m2.\nGiá 1,5tr/th - 1,8tr/th - 2,2tr/th.\nTrong phòng có nóng lạnh, kệ bếp, bồn rửa sạch sẽ, ban công thoáng mát.\nAi có nhu cầu thuê thì liên hệ: A. Hưng: 0345.064.289/ chị Nhài: 0966.066.281 (miễn trung gian).', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (92, 68, NULL, 23000000, 1, 78, 4, 2, '', NULL, NULL, 23000000, 'Chung cư mini thang máy 7 tầng.\nCòn phòng giá 3tr/th - 3,5tr/th - 4tr/th diện tích từ 25m2 đến 40 m2 có đủ điều hòa, nóng lạnh, phòng to có thêm giường, tủ tất cả phòng đều khép kín, kệ bếp, tủ bếp. Phòng thoáng mát, an ninh tốt có bảo vệ trông xe.\nLiên hệ: Chị Hồng: 0961.085.122 anh Minh: 0352.764.159 (MTG).', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (93, 69, NULL, 17000000, 1, 102, 3, 3, '', NULL, NULL, 10000000, '- Nhà mình có 4 phòng trọ muốn cho sinh viên và người đi làm thuê.\n- DT: 18m2 - 22m2 - 25m2 - 30m2 - 35m2.\n- Giá: 1,7 tr/th - 2tr/th - 2,2 tr/th - 2,5tr/th - 2,8tr/th - 3,2tr/th là có điều hòa).\n- Trong phòng đã trang bị đầy đủ tiện nghi điều hòa, nóng lạnh, giường, nhà vệ sinh sạch sẽ, có ban công thoáng mát.\n- Địa chỉ: Ngõ 131B Tôn Đức Thắng.\nLiên hệ: Cô Thức 0352761017 (MTG).', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (94, 70, NULL, 15000000, 1, 90, 3, 3, '', NULL, NULL, 15000000, 'Nhà 6 tầng, đang còn phòng ở tầng 2, tầng 4.\nNhà sạch sẽ, thoáng mát.\nĐiện nước: Có công tơ riêng.\nPhòng nhỏ giá: 2.5tr/th - 3tr/th.\nPhòng to giá: 4.2tr/th.\nVệ sinh khép kín, có cả nóng lạnh, điều hòa, giường.\nĐịa chỉ: Số 75E ngõ Thổ Quan, Khâm Thiên, Hà Nội (Nhà cho thuê gần phố Xã Đàn, Tôn Đức Thắng, Ô Chợ Dừa).\nChỉ ở 2 người/phòng.\nĐT Anh Tuấn 0936412192 (liên hệ xem phòng báo trước 30p).\nPhòng cho thuê gần trường Bách Khoa, Công Đoàn, Mỹ Thuật, Văn Hóa.', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (95, 71, NULL, 5500000, 3, 60, 3, 3, 'Đông Nam', NULL, NULL, 3000000, 'Nhà to mặt tiền\n', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (96, 72, NULL, 6500000, 1, 120, 2, 2, 'Nam', NULL, NULL, 6000000, 'Nhà đẹp', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (97, 73, NULL, 4500000, 1, 100, 2, 1, 'Đông', NULL, NULL, 4000000, 'Nhà mới đẹp tiện nghi', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (98, 74, NULL, 8500000, 2, 70, 3, 2, 'Nam', NULL, NULL, 3000000, 'Tầng cao chót vót', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (99, 75, NULL, 7500000, 3, 100, 3, 3, 'Tây Bắc', NULL, NULL, 2000000, 'Vip ', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (100, 76, NULL, 3500000, 3, 100, 3, 3, 'Đông', NULL, NULL, 2000000, 'Nhà đẹp', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (101, 77, NULL, 6500000, 3, 100, 2, 3, 'Nam', NULL, NULL, 7000000, 'Nhà vip', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (102, 78, NULL, 7000000, 3, 100, 3, 3, 'Đông', NULL, NULL, 3000000, 'Nhà đẹp', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (103, 79, NULL, 5500000, 1, 100, 3, 3, 'Nam', NULL, NULL, 3000000, 'Big house', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (104, 80, NULL, 7500000, 3, 60, 2, 2, 'Tây Nam', NULL, NULL, 3000000, 'Nhà nguyên căn giá rẻ', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (105, 81, NULL, 5500000, 1, 80, 3, 3, 'Tây', NULL, NULL, 5000000, 'Nhà phong thủy', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (106, 82, NULL, 5500000, 2, 50, 3, 2, 'Nam', NULL, NULL, 3000000, 'Nhà super đẹp', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (107, 83, NULL, 4500000, 2, 70, 3, 2, 'Đông', NULL, NULL, 4000000, 'Nhà 3 tầng to có bảo vệ', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (108, 84, NULL, 5500000, 1, 30, 2, 3, 'Đông', NULL, NULL, 2500000, 'Nhà phù hợp cho vợ chồng mới cưới', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (109, 85, NULL, 4500000, 1, 100, 1, 1, 'Đông', NULL, NULL, 2000000, 'chung cư Sunancora đã full đầy đủ các tiện ích của một chung cư 5 sao, ban quản lí căn hộ là đơn vị nước ngoài, là sự lựa chọn của những cư dân hiện đại.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (110, 86, NULL, 6000000, 1, 100, 2, 1, 'Đông Bắc', NULL, NULL, 2000000, '* Căn 90m2 - 115m2, 3PN, 2WC, PK và khu bếp:\nNguyên bản(đã có điều hòa). Giá 13tr/th - 14tr/th.\nLắp thêm đồ cơ bản, full tủ bếp, bình nước nóng. Giá 14tr/th - 15tr/th.\nLắp full đồ chỉ cần xách vali vào ở. Giá 18tr/th - 20tr/th.', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (111, 87, NULL, 3500000, 1, 200, 3, 2, 'Tây', NULL, NULL, 2000000, 'Nội thất cơ bản: Bếp, nóng lạnh, điều hòa.', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (112, 88, NULL, 7500000, 1, 70, 2, 1, 'Tây Bắc', NULL, NULL, 3000000, 'Nhà còn phòng cho thuê khép kín đủ điều hòa, nóng lạnh, giường, giá 3tr - 3,5tr - 4 tr/th.\nNgay cạnh Bách - Kinh - Xây đi bộ 5p. Nhà riêng chủ, tự do.', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (113, 89, NULL, 1500000, 1, 170, 3, 1, 'Tây Bắc', NULL, NULL, 1000000, 'Hiện tôi đang có 2 căn hộ Duplex 2 ngủ và 3 ngủ full đồ mặt phố Thọ Lão, Lò Đúc.\n- Diện tích: 170m2.\n- Nội thất đầy đủ, chỉ việc xách vali vào ở.\n- Có 3 nhà vệ sinh, bếp, phòng khách và ban công rộng.\n- Giá: 21 triệu/tháng.\n- Free: internet, TV, dọn phòng, an ninh, thang máy.', 7, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (114, 90, NULL, 5500000, 1, 100, 1, 1, 'Tây', NULL, NULL, 3000000, 'Cho thuê nhà TT ngõ 627 Giải Phóng( cách ĐH Kinh tế 500m),\nTầng 5( tầng trên cùng nhưng không nóng vì nhà 2 mái), DT 80m2, 2PN, 2 ban công, 1 PK, bếp, wc.\nCó chỗ để 2 xe máy riêng của nhà ở tầng 1( tiết kiệm được 500N/tháng)\nĐiện nước tính theo công tơ, ngay cạnh trường ĐH kinh tế quốc dân, ĐH bách khoa, ĐH Xây dựng\nPhù hợp với người đi làm, các bạn sinh viên, hộ GĐ ở\nGiá 5 triệu/tháng\nLH: A Nam Tel\nĐ/c: 627 Giải phóng, Đồng tâm, Hai bà trưng, Hà nội', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (115, 91, NULL, 6500000, 2, 100, 4, 3, 'Tây Nam', NULL, NULL, 3000000, 'Chính chủ cho thuê 1 phòng tầng 3 tại Tomhouse khu Đê Trần Khát Chân, Q Hai Bà Trưng\nđiện 2.3K/số, nước 70k/người, mạng 80k/phòng, vệ sinh 20k/phòng. Phòng khép kín gồm điều hoà, bếp, nhà vệ sinh riêng, nóng lạnh, quạt trần, rèm, không chung chủ, ra vào chủ động khoá vân tay, để xe tầng 1. Camera an ninh, khu dân cư gần chợ trường\nGiá 3.6 triệu/tháng, đóng 3T cọc 1 tháng', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (116, 92, NULL, 10500000, 1, 100, 1, 1, 'Đông Nam', NULL, NULL, 4000000, 'Cho sinh viên hoặc người đi làm thuê căn hộ mini\nDiện tích 23-30m2\nKhép kín; nội thất đầy đủ chỉ việc xách vali vào ở\ncho cả khách nước ngoài thuê\nđiện nước cáp mạng khỏe.\nGiá thuê từng căn hộ từ 4tr- 5tr/ 1 tháng\ngần ĐH Bách Khoa, Kinh Tế, Xây Dựng... Bệnh viện Bạch Mai, gần chợ Mơ.\nĐịa chỉ: phố Bạch Mai, quận Hai Bà Trưng, Hà Nội.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (117, 93, NULL, 4500000, 1, 60, 2, 1, 'Tây', NULL, NULL, 2000000, 'Tin Môi giới đăng 3 giờ trước\nNhà phố 8/3 dt 30m2 x 4 tầng ,mt 7m\n4.700.000.000 đ- 30 m2\nLưu tin like\nNHÀ ĐẸP –MẶT TIỀN RỘNG – 3 THOÁNG – Ô TÔ TẢI ĐỖ CỬA.\nPhố 8/3 Hai Bà Trưng dt 30m2, 4 tầng mặt tiền 7m giá 4.7 tỷ\n✅Mô tả\n+ Vị trí đẹp từ nhà ra mặt phố chưa đầy 20m, 3 mặt thoáng, ô tô tải đỗ cửa.\n+ Nhà xây 4 tầng sàn - cầu thang ốp gỗ Lim bóng loáng. Mỗi tầng một phòng một phụ khép kín.\n- Tầng 1: p. khách, bếp, ăn, có thêm một diện tích hơn chục m2 làm sàn nước, cơi nới thêm sàn để xe máy ngoài nhà\n- Tầng 2,3: một phòng ngủ rộng + wc.\n- Tầng 4: p.thờ, sân phơi.\n- Các phòng đều có ban công rộng.\n- Nhà phù hợp kinh doanh Vp, TT tiếng anh hoặc gì cũng tốt\n- Sổ chính chủ, pháp lý rõ ràng.\n- Hướng Đông Bắc', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (118, 94, NULL, 4000000, 2, 53, 2, 1, 'Tây', NULL, NULL, 1500000, 'Diện tích 53m2: Phòng khách, phòng ngủ, bếp, vệ sinh và ban công (điều hòa, bình nóng lạnh, máy bơm...). Điện nước - Anh ninh tốt. Giá điện nước theo đồng hồ. Nhà ở có lộc, phù hợp gia đình thuê.', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (119, 95, NULL, 5500000, 1, 100, 1, 1, 'Đông', NULL, NULL, 3000000, 'Tiêu đề:\n\nBán nhà phố Thanh Nhàn, diện tích 46m2 x 5 tầng x mt 3.4m x giá 4.45 tỷ.\n\n+ Nhà mới xây, chắc chắn, đẹp khung BTCT.\n\n+ Đường trước nhà 2 xe máy tránh, ngõ thông các ngả.\n\n+ Nội thất nhà thiết kế sang trọng, hiện đại toàn đồ ngoại nhập.\n\n+ Tầng 1: Phòng khách + bếp + wc.\n\n+ Tầng 2,3,4: mỗi tầng 2 phòng + wc + giếng trời + 1 ban công.\n\n+ Tầng 5: là 2 sân phơi đã lợp mái tôn chống nóng.\n\n+ Nhà gần trường, bệnh viện, công viên, chợ, tiện ích đầy đủ….. giao thông đi lại cực thuận tiện.\n\n+ Khu dân trí cao, an ninh tốt', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (120, 96, NULL, 5000000, 6, 60, 3, 3, 'Đông Nam', NULL, NULL, 2000000, 'Căn hộ ccmini trần khát Chân - lò đúc - Kim Ngư.\nKhu vực giao thông thuận tiện, vào phố rất gần, dân trí cao. nhà có ban công cửa sổ Thoáng mát...\nDiện tích từ 35 - 42m2 + gác sép 18m2.\nCăn hộ khép kín.sàn gỗ, Điều hòa, vệ sinh nóng lạnh giường đệm tủ bàn ghế bếp trạn hút mùi. Đủ đồ vào ở luôn.\n+ phòng ngủ có cửa sổ và ban công thông thoáng.\n+ Phòng bếp được trang bi, bàn bếp, tủ bếp, chậu rửa bát, ….\n+ Khu vực nhà vệ sinh được lắp đầy đủ thiết bị hiện đại như chậu rửa mặt, bệt Inax, vòi sen, bình nóng lạnh...\nNhà để xe thang máy bảo vệ 24/24 an ninh tốt ra vào thoải mái.\nRất phù hợp với hộ gia đình, KD online...\nGiá thuê từ 4 - 5,5tr/th. Liên hệ ngay Mr Hùng', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (121, 97, NULL, 12500000, 1, 100, 1, 1, 'Đông Bắc', NULL, NULL, 6000000, 'Cho thuê căn hộ Pegasus full nội thất, đầy đủ tiện nghi\nCho Thuê Căn Hộ Pegasus Cao Cấp Full Nội Thất Giá Rẻ\n- Tòa nhà Pegasus trực thuộc tại vị trí trung tâm đắc địa, kh...', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (122, 98, NULL, 6500000, 1, 100, 1, 1, 'Đông', NULL, NULL, 3000000, '+ Mặt tiền: 4m.\n+ Nhà thiết kế 4 tầng, tổng 4 phòng ngủ.\n+ Diện tích cực rộng 65m, chủ mua nguyên bản thiết kế riêng cho ngôi nhà.\n+ Nhà cực gần phố, ngõ thông đường nào ra phố cũng tính bằng giây.\n+ Sổ đỏ chính chủ.\n+ Giá 4.4 tỷ ( có thương lượng).\nLH Mr Đức O971886291 (Tư vấn nhà, đất với 10.000 căn nhà khắp các quận huyện Hà Nội cam kết tìm nhà đúng với nhu cầu và hoàn toàn miễn phí)', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (123, 99, NULL, 5500000, 1, 100, 1, 1, 'Tây', NULL, NULL, 3000000, 'Bán nhà phố Thanh Nhàn quận Hai Bà Trưng diện tích rộng chỉ có 2.85 tỷ Quận Hai Bà Trưng\n\n+ Ngõ rộng 3m ra ngõ quỳnh hay phố Thanh Nhàn đều rất gần.\n+ Thiết kế tầng 2 phòng,\n+ Sổ vuông đẹp\n+ An Ninh yên tĩnh, trước nhà thoáng đãng.\n', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (124, 100, NULL, 1500000, 1, 100, 1, 1, 'Đông Nam', NULL, NULL, 1000000, '- Nhà 4 Tầng Chủ tự xây kiên cố rất đẹp, nội thất đầy đủ, tất cả các phòng đều có cửa ra ban công hóng gió và cửa sổ đón gió trời.\n+ Vị trí đẹp, khu phố đông đúc, anh sinh rất là tuyệt vời, 20m ra mặt đường ô tô.\n+ Thuận lợi đủ thứ, hưởng trọn mọi tiện ích của khu trung tâm gần Trường, chợ, bệnh viện Bạch Mai, Thanh Nhàn, giao thông thuận tiện đi các hướng gốc đề, Trương Định, Minh Khai, Tam Trinh, Hồ Đền Lừ....\n+ Sổ đỏ chính chủ, pháp lý đầy đủ.\n+ Giá: 2.3 tỷ ( có thương lượng, hỗ trợ vay vốn ngân hàng với lãi suất thấp ).\n- Thông tin chi tiết liên hệ xem nhà Em Lâm:', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (125, 101, NULL, 2100000, 1, 15, 1, 1, 'all', NULL, NULL, 1000000, 'Dreamhouse 09 đang có 2 suất nam trống  tại 34 Trần Đại Nghĩa.\n\n????Bách Khoa -- Kinh tế - Xây Dựng????\n???? Nhà 7 tầng . Tầng 1 để xe, tầng 2 phòng bếp,. tầng 7 có ban công phơi đồ.\n\nĐầy đủ tiện nghi, điều hòa nóng lạnh,máy giặt,tủ lạnh,  (chỉ cần xách balo và ở).\n\n????Điện nước giá dân.\n????Giờ giấc thoải mái, không chung chủ.\n????Tham gia các khóa học, clb Tiếng Anh, teambuilding, …\n????Tạo môi trường ???? Rèn thói quen ???? Chắp cánh ước mơ????\n\n☎️Liên hệ  hoặc COMMENT số điện thoại để được tư vấn nhé các bạn.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (126, 101, NULL, 2500000, 1, 100, 1, 1, 'all', NULL, NULL, 1000000, 'Dreamhouse 09 đang có 2 suất nam trống  tại 34 Trần Đại Nghĩa.\n\n????Bách Khoa -- Kinh tế - Xây Dựng????\n???? Nhà 7 tầng . Tầng 1 để xe, tầng 2 phòng bếp,. tầng 7 có ban công phơi đồ.\n\nĐầy đủ tiện nghi, điều hòa nóng lạnh,máy giặt,tủ lạnh,  (chỉ cần xách balo và ở).\n\n????Điện nước giá dân.\n????Giờ giấc thoải mái, không chung chủ.\n????Tham gia các khóa học, clb Tiếng Anh, teambuilding, …\n????Tạo môi trường ???? Rèn thói quen ???? Chắp cánh ước mơ????\n\n☎️Liên hệ  hoặc COMMENT số điện thoại để được tư vấn nhé các bạn.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (127, 102, NULL, 2500000, 1, 100, 1, 1, 'all', NULL, NULL, 1000000, 'Môi trường an ninh, yên tĩnh, trung tâm thành phố. Không nấu ăn trong phòng.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (128, 103, NULL, 1800000, 1, 100, 1, 1, 'all', NULL, NULL, 1000000, 'Nhà trọ giá rẻ, chủ nhà dễ tính, rất mong được đón tiếp các bạn sinh viên', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (129, 104, NULL, 7500000, 1, 100, 1, 1, 'Tây', NULL, NULL, 3000000, 'Phòng mới xây, có ban công và cửa sổ nên rất thoáng mát, có bếp, toilet riêng. Nội thất: máy lạnh, máy nước nóng, giường, tủ, nệp, drap.\nHẻm 2 xe hơi tránh nhau', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (130, 105, NULL, 12500000, 1, 100, 1, 1, 'Đông Bắc', NULL, NULL, 4000000, 'Gia đình tôi cần bán gấp nhà số 56 ngõ 197 Phố Mai Động, Minh Khai đi vào. Đường vào nhà ôtô chạy thẳng tắp, trước nhà thông rộng, xe bán tải vào nhà.\nDiện tích sổ đỏ 58m2, xây 5 Tầng mới cứng, (tổng DTSD 290m2), nhà nở hậu mở cửa thoáng trước sau. Thiết kế mỗi tầng hai phòng rộng, tầng một Gara ôtô vào nhà và mặt bằng kinh doanh. Gồm 6 phòng ngủ rộng lất gỗ Đức cao cấp, phòng ăn, phòng thờ, sân phơi riêng, 4WC VIP.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (131, 106, NULL, 1500000, 1, 100, 1, 1, 'all', NULL, NULL, 1000000, '+Nhà nằm trong quận Hai Bà Trưng, gần khu đô thị Time CiTy là khu văn minh, giá 1 tỷ 800 triệu quá hiếm, khách cần mua nhà, nhanh tay bấm máy liên hệ đến xem nhà còn kịp mua. Chủ nhà thiện chí đón tiếp (giá thương lượng)', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (132, 107, NULL, 8500000, 1, 100, 1, 1, 'Đông Bắc', NULL, NULL, 5000000, 'Nhà gần trường học, gần chợ, gần Trung Tâm Time City, Bệnh viện VinMec Quốc tế, BV Thanh Nhàn, BV Bạch Mai..! 7 phút đi xe máy lên TT phố cổ, TT phố đi bộ Hồ Hoàn Kiếm, ra các ngả phố rất thuận tiện. Gần khu vui chơi giải trí, Vài phút ra các Trường Đại Học danh tiếng ĐH Bách Khoa; ĐH Kinh Tế; ĐH Xây Dựng...!', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (133, 108, NULL, 6500000, 1, 100, 1, 1, 'Đông', NULL, NULL, 2000000, ' Nhà gần chợ ô tô tránh nhau, khu vực kinh doanh sầm uất, ban công rộng\n+ Nhà xây chủ tự xây chắc chắn kiên cố, các phòng có anh sáng tự nhiên vào phòng\n+ Khách về chỉ sách va li về ở, nhà hiện đại đẹp lung linh.\n+ Nội thất sang chảnh, cao cấp, đầy đủ tiện nghi\n+ Pháp lý sạch, sổ đỏ đầy đủ, mát mẻ, thoáng, sang tên trong nốt nhạc\n+ Chủ thân thiện cán bộ về hưu, nhiệt tình bán về ở với con, vào việc ngay\n+ Tư vấn nhiệt tình miễn phí thủ tục sang tên, pháp lý và các thủ tục khác\n+ Các bạn môi giới và trung gian vui lòng không làm phiền', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (134, 109, NULL, 1500000, 1, 100, 1, 1, 'Đông', NULL, NULL, 1000000, '- Nhà gần chợ, sân bóng, nhà thi đấu Quận.\n- Thiết kế 4 tầng, bếp, khách, ngủ, thờ, sân phơi, xây khung bê tông cốt thép đầy đủ công năng.', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (135, 110, NULL, 1500000, 1, 100, 1, 1, 'all', b'1', NULL, 1000000, '<p>Phòng đẹp, tiện nghi đầy đủ</p>\n', 2, NULL, NULL, b'0', '2019-11-13 14:50:10.542830', NULL);
INSERT INTO `room_group` VALUES (136, 110, NULL, 2500000, 1, 100, 1, 1, 'all', b'1', NULL, 1000000, '<p>phòng được nấu ăn, view cao</p>\n', 3, NULL, NULL, b'0', '2019-11-13 14:50:10.545529', NULL);
INSERT INTO `room_group` VALUES (137, 111, NULL, 5500000, 2, 100, 2, 2, 'Đông Bắc', b'1', NULL, 3000000, '<p>Phòng đầy đủ tiện nghi</p>\n', 2, NULL, NULL, b'0', '2019-11-13 14:57:21.625368', NULL);
INSERT INTO `room_group` VALUES (138, 112, NULL, 9500000, 1, 200, 3, 3, 'Đông Bắc', b'1', NULL, 5000000, '<p>Nhà đẹp, dễ bán hàng</p>\n', 6, NULL, NULL, b'0', '2019-11-13 18:27:27.410557', NULL);
INSERT INTO `room_group` VALUES (139, 113, NULL, 5500000, 1, 100, 2, 2, 'Bắc', b'1', NULL, 2000000, '<p>Phòng view đẹp</p>\n', 4, NULL, NULL, b'0', '2019-11-14 04:54:44.791829', NULL);
COMMIT;

-- ----------------------------
-- Table structure for room_image
-- ----------------------------
DROP TABLE IF EXISTS `room_image`;
CREATE TABLE `room_image` (
  `image_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the image',
  `image_url` text COMMENT 'URL of the image',
  `room_group_id` int(2) DEFAULT NULL COMMENT 'ID of room group of image',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`image_id`) USING BTREE,
  KEY `FK_roomGroup_image` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_roomGroup_image` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room_image
-- ----------------------------
BEGIN;
INSERT INTO `room_image` VALUES (16, 'https://storage.googleapis.com/room_images_bucket/room-image-10-rc-upload-1572849419039-4', 10, NULL, NULL);
INSERT INTO `room_image` VALUES (17, 'https://storage.googleapis.com/room_images_bucket/room-image-10-rc-upload-1572849419039-3', 10, NULL, NULL);
INSERT INTO `room_image` VALUES (18, 'https://storage.googleapis.com/room_images_bucket/room-image-10-rc-upload-1572849419039-2', 10, NULL, NULL);
INSERT INTO `room_image` VALUES (19, 'https://storage.googleapis.com/room_images_bucket/room-image-10-rc-upload-1572849419039-7', 10, NULL, NULL);
INSERT INTO `room_image` VALUES (20, 'https://storage.googleapis.com/room_images_bucket/room-image-13-rc-upload-1572868130464-4', 13, NULL, NULL);
INSERT INTO `room_image` VALUES (21, 'https://storage.googleapis.com/room_images_bucket/room-image-13-rc-upload-1572868130464-6', 13, NULL, NULL);
INSERT INTO `room_image` VALUES (22, 'https://storage.googleapis.com/room_images_bucket/room-image-13-rc-upload-1572868130464-8', 13, NULL, NULL);
INSERT INTO `room_image` VALUES (23, 'https://storage.googleapis.com/room_images_bucket/room-image-13-rc-upload-1572868130464-2', 13, NULL, NULL);
INSERT INTO `room_image` VALUES (24, 'https://storage.googleapis.com/room_images_bucket/room-image-14-rc-upload-1572870560082-2', 14, NULL, NULL);
INSERT INTO `room_image` VALUES (25, 'https://storage.googleapis.com/room_images_bucket/room-image-14-rc-upload-1572870560082-4', 14, NULL, NULL);
INSERT INTO `room_image` VALUES (26, 'https://storage.googleapis.com/room_images_bucket/room-image-14-rc-upload-1572870560082-3', 14, NULL, NULL);
INSERT INTO `room_image` VALUES (27, 'https://storage.googleapis.com/room_images_bucket/room-image-14-rc-upload-1572870560082-5', 14, NULL, NULL);
INSERT INTO `room_image` VALUES (28, 'https://storage.googleapis.com/room_images_bucket/room-image-15-rc-upload-1572871388026-2', 15, NULL, NULL);
INSERT INTO `room_image` VALUES (29, 'https://storage.googleapis.com/room_images_bucket/room-image-15-rc-upload-1572871388026-4', 15, NULL, NULL);
INSERT INTO `room_image` VALUES (30, 'https://storage.googleapis.com/room_images_bucket/room-image-15-rc-upload-1572871388026-5', 15, NULL, NULL);
INSERT INTO `room_image` VALUES (31, 'https://storage.googleapis.com/room_images_bucket/room-image-15-rc-upload-1572871388026-3', 15, NULL, NULL);
INSERT INTO `room_image` VALUES (32, 'https://storage.googleapis.com/room_images_bucket/room-image-16-rc-upload-1572871388026-9', 16, NULL, NULL);
INSERT INTO `room_image` VALUES (33, 'https://storage.googleapis.com/room_images_bucket/room-image-16-rc-upload-1572871388026-8', 16, NULL, NULL);
INSERT INTO `room_image` VALUES (34, 'https://storage.googleapis.com/room_images_bucket/room-image-16-rc-upload-1572871388026-10', 16, NULL, NULL);
INSERT INTO `room_image` VALUES (35, 'https://storage.googleapis.com/room_images_bucket/room-image-16-rc-upload-1572871388026-11', 16, NULL, NULL);
INSERT INTO `room_image` VALUES (36, 'https://storage.googleapis.com/room_images_bucket/room-image-17-rc-upload-1572872163813-2', 17, NULL, NULL);
INSERT INTO `room_image` VALUES (37, 'https://storage.googleapis.com/room_images_bucket/room-image-17-rc-upload-1572872163813-4', 17, NULL, NULL);
INSERT INTO `room_image` VALUES (38, 'https://storage.googleapis.com/room_images_bucket/room-image-17-rc-upload-1572872163813-5', 17, NULL, NULL);
INSERT INTO `room_image` VALUES (39, 'https://storage.googleapis.com/room_images_bucket/room-image-17-rc-upload-1572872163813-3', 17, NULL, NULL);
INSERT INTO `room_image` VALUES (40, 'https://storage.googleapis.com/room_images_bucket/room-image-18-rc-upload-1572872163813-9', 18, NULL, NULL);
INSERT INTO `room_image` VALUES (41, 'https://storage.googleapis.com/room_images_bucket/room-image-18-rc-upload-1572872163813-8', 18, NULL, NULL);
INSERT INTO `room_image` VALUES (42, 'https://storage.googleapis.com/room_images_bucket/room-image-18-rc-upload-1572872163813-10', 18, NULL, NULL);
INSERT INTO `room_image` VALUES (43, 'https://storage.googleapis.com/room_images_bucket/room-image-18-rc-upload-1572872163813-11', 18, NULL, NULL);
INSERT INTO `room_image` VALUES (44, 'https://storage.googleapis.com/room_images_bucket/room-image-19-rc-upload-1572872163813-16', 19, NULL, NULL);
INSERT INTO `room_image` VALUES (45, 'https://storage.googleapis.com/room_images_bucket/room-image-19-rc-upload-1572872163813-14', 19, NULL, NULL);
INSERT INTO `room_image` VALUES (46, 'https://storage.googleapis.com/room_images_bucket/room-image-19-rc-upload-1572872163813-17', 19, NULL, NULL);
INSERT INTO `room_image` VALUES (47, 'https://storage.googleapis.com/room_images_bucket/room-image-19-rc-upload-1572872163813-15', 19, NULL, NULL);
INSERT INTO `room_image` VALUES (48, 'https://storage.googleapis.com/room_images_bucket/room-image-20-rc-upload-1572872163813-21', 20, NULL, NULL);
INSERT INTO `room_image` VALUES (49, 'https://storage.googleapis.com/room_images_bucket/room-image-20-rc-upload-1572872163813-23', 20, NULL, NULL);
INSERT INTO `room_image` VALUES (50, 'https://storage.googleapis.com/room_images_bucket/room-image-20-rc-upload-1572872163813-20', 20, NULL, NULL);
INSERT INTO `room_image` VALUES (51, 'https://storage.googleapis.com/room_images_bucket/room-image-20-rc-upload-1572872163813-22', 20, NULL, NULL);
INSERT INTO `room_image` VALUES (52, 'https://storage.googleapis.com/room_images_bucket/room-image-21-rc-upload-1572875352285-2', 21, NULL, NULL);
INSERT INTO `room_image` VALUES (53, 'https://storage.googleapis.com/room_images_bucket/room-image-21-rc-upload-1572875352285-4', 21, NULL, NULL);
INSERT INTO `room_image` VALUES (54, 'https://storage.googleapis.com/room_images_bucket/room-image-21-rc-upload-1572875352285-5', 21, NULL, NULL);
INSERT INTO `room_image` VALUES (55, 'https://storage.googleapis.com/room_images_bucket/room-image-21-rc-upload-1572875352285-3', 21, NULL, NULL);
INSERT INTO `room_image` VALUES (56, 'https://storage.googleapis.com/room_images_bucket/room-image-22-rc-upload-1572875352285-8', 22, NULL, NULL);
INSERT INTO `room_image` VALUES (57, 'https://storage.googleapis.com/room_images_bucket/room-image-22-rc-upload-1572875352285-9', 22, NULL, NULL);
INSERT INTO `room_image` VALUES (58, 'https://storage.googleapis.com/room_images_bucket/room-image-22-rc-upload-1572875352285-11', 22, NULL, NULL);
INSERT INTO `room_image` VALUES (59, 'https://storage.googleapis.com/room_images_bucket/room-image-22-rc-upload-1572875352285-10', 22, NULL, NULL);
INSERT INTO `room_image` VALUES (60, 'https://storage.googleapis.com/room_images_bucket/room-image-23-rc-upload-1572875352285-16', 23, NULL, NULL);
INSERT INTO `room_image` VALUES (61, 'https://storage.googleapis.com/room_images_bucket/room-image-23-rc-upload-1572875352285-14', 23, NULL, NULL);
INSERT INTO `room_image` VALUES (62, 'https://storage.googleapis.com/room_images_bucket/room-image-23-rc-upload-1572875352285-15', 23, NULL, NULL);
INSERT INTO `room_image` VALUES (63, 'https://storage.googleapis.com/room_images_bucket/room-image-23-rc-upload-1572875352285-17', 23, NULL, NULL);
INSERT INTO `room_image` VALUES (64, 'https://storage.googleapis.com/room_images_bucket/room-image-24-rc-upload-1572875352285-21', 24, NULL, NULL);
INSERT INTO `room_image` VALUES (65, 'https://storage.googleapis.com/room_images_bucket/room-image-24-rc-upload-1572875352285-22', 24, NULL, NULL);
INSERT INTO `room_image` VALUES (66, 'https://storage.googleapis.com/room_images_bucket/room-image-24-rc-upload-1572875352285-20', 24, NULL, NULL);
INSERT INTO `room_image` VALUES (67, 'https://storage.googleapis.com/room_images_bucket/room-image-24-rc-upload-1572875352285-23', 24, NULL, NULL);
INSERT INTO `room_image` VALUES (68, 'https://storage.googleapis.com/room_images_bucket/room-image-25-rc-upload-1572875352285-27', 25, NULL, NULL);
INSERT INTO `room_image` VALUES (69, 'https://storage.googleapis.com/room_images_bucket/room-image-25-rc-upload-1572875352285-29', 25, NULL, NULL);
INSERT INTO `room_image` VALUES (70, 'https://storage.googleapis.com/room_images_bucket/room-image-25-rc-upload-1572875352285-28', 25, NULL, NULL);
INSERT INTO `room_image` VALUES (71, 'https://storage.googleapis.com/room_images_bucket/room-image-25-rc-upload-1572875352285-26', 25, NULL, NULL);
INSERT INTO `room_image` VALUES (72, 'https://storage.googleapis.com/room_images_bucket/room-image-26-rc-upload-1572877345896-3', 26, NULL, NULL);
INSERT INTO `room_image` VALUES (73, 'https://storage.googleapis.com/room_images_bucket/room-image-26-rc-upload-1572877345896-2', 26, NULL, NULL);
INSERT INTO `room_image` VALUES (74, 'https://storage.googleapis.com/room_images_bucket/room-image-26-rc-upload-1572877345896-5', 26, NULL, NULL);
INSERT INTO `room_image` VALUES (75, 'https://storage.googleapis.com/room_images_bucket/room-image-26-rc-upload-1572877345896-4', 26, NULL, NULL);
INSERT INTO `room_image` VALUES (76, 'https://storage.googleapis.com/room_images_bucket/room-image-27-rc-upload-1572877345896-8', 27, NULL, NULL);
INSERT INTO `room_image` VALUES (77, 'https://storage.googleapis.com/room_images_bucket/room-image-27-rc-upload-1572877345896-11', 27, NULL, NULL);
INSERT INTO `room_image` VALUES (78, 'https://storage.googleapis.com/room_images_bucket/room-image-27-rc-upload-1572877345896-10', 27, NULL, NULL);
INSERT INTO `room_image` VALUES (79, 'https://storage.googleapis.com/room_images_bucket/room-image-27-rc-upload-1572877345896-9', 27, NULL, NULL);
INSERT INTO `room_image` VALUES (80, 'https://storage.googleapis.com/room_images_bucket/room-image-28-rc-upload-1572877345896-14', 28, NULL, NULL);
INSERT INTO `room_image` VALUES (81, 'https://storage.googleapis.com/room_images_bucket/room-image-28-rc-upload-1572877345896-15', 28, NULL, NULL);
INSERT INTO `room_image` VALUES (82, 'https://storage.googleapis.com/room_images_bucket/room-image-28-rc-upload-1572877345896-17', 28, NULL, NULL);
INSERT INTO `room_image` VALUES (83, 'https://storage.googleapis.com/room_images_bucket/room-image-28-rc-upload-1572877345896-16', 28, NULL, NULL);
INSERT INTO `room_image` VALUES (84, 'https://storage.googleapis.com/room_images_bucket/room-image-29-rc-upload-1572887031421-4', 29, NULL, NULL);
INSERT INTO `room_image` VALUES (85, 'https://storage.googleapis.com/room_images_bucket/room-image-29-rc-upload-1572887031421-6', 29, NULL, NULL);
INSERT INTO `room_image` VALUES (86, 'https://storage.googleapis.com/room_images_bucket/room-image-29-rc-upload-1572887031421-2', 29, NULL, NULL);
INSERT INTO `room_image` VALUES (87, 'https://storage.googleapis.com/room_images_bucket/room-image-29-rc-upload-1572887031421-8', 29, NULL, NULL);
INSERT INTO `room_image` VALUES (88, 'https://storage.googleapis.com/room_images_bucket/room-image-30-rc-upload-1572916879097-11', 30, NULL, NULL);
INSERT INTO `room_image` VALUES (89, 'https://storage.googleapis.com/room_images_bucket/room-image-30-rc-upload-1572916879097-13', 30, NULL, NULL);
INSERT INTO `room_image` VALUES (90, 'https://storage.googleapis.com/room_images_bucket/room-image-30-rc-upload-1572916879097-12', 30, NULL, NULL);
INSERT INTO `room_image` VALUES (91, 'https://storage.googleapis.com/room_images_bucket/room-image-30-rc-upload-1572916879097-9', 30, NULL, NULL);
INSERT INTO `room_image` VALUES (92, 'https://storage.googleapis.com/room_images_bucket/room-image-30-rc-upload-1572916879097-10', 30, NULL, NULL);
INSERT INTO `room_image` VALUES (93, 'https://storage.googleapis.com/room_images_bucket/room-image-32-rc-upload-1572917978603-3', 32, NULL, NULL);
INSERT INTO `room_image` VALUES (94, 'https://storage.googleapis.com/room_images_bucket/room-image-32-rc-upload-1572917978603-7', 32, NULL, NULL);
INSERT INTO `room_image` VALUES (95, 'https://storage.googleapis.com/room_images_bucket/room-image-32-rc-upload-1572917978603-5', 32, NULL, NULL);
INSERT INTO `room_image` VALUES (96, 'https://storage.googleapis.com/room_images_bucket/room-image-32-rc-upload-1572917978603-6', 32, NULL, NULL);
INSERT INTO `room_image` VALUES (97, 'https://storage.googleapis.com/room_images_bucket/room-image-32-rc-upload-1572917978603-4', 32, NULL, NULL);
INSERT INTO `room_image` VALUES (98, 'https://storage.googleapis.com/room_images_bucket/room-image-35-rc-upload-1572920720905-11', 35, NULL, NULL);
INSERT INTO `room_image` VALUES (99, 'https://storage.googleapis.com/room_images_bucket/room-image-35-rc-upload-1572920720905-13', 35, NULL, NULL);
INSERT INTO `room_image` VALUES (100, 'https://storage.googleapis.com/room_images_bucket/room-image-35-rc-upload-1572920720905-17', 35, NULL, NULL);
INSERT INTO `room_image` VALUES (101, 'https://storage.googleapis.com/room_images_bucket/room-image-35-rc-upload-1572920720905-15', 35, NULL, NULL);
INSERT INTO `room_image` VALUES (102, 'https://storage.googleapis.com/room_images_bucket/room-image-37-rc-upload-1572917978603-17', 37, NULL, NULL);
INSERT INTO `room_image` VALUES (103, 'https://storage.googleapis.com/room_images_bucket/room-image-37-rc-upload-1572917978603-19', 37, NULL, NULL);
INSERT INTO `room_image` VALUES (104, 'https://storage.googleapis.com/room_images_bucket/room-image-37-rc-upload-1572917978603-20', 37, NULL, NULL);
INSERT INTO `room_image` VALUES (105, 'https://storage.googleapis.com/room_images_bucket/room-image-37-rc-upload-1572917978603-21', 37, NULL, NULL);
INSERT INTO `room_image` VALUES (106, 'https://storage.googleapis.com/room_images_bucket/room-image-37-rc-upload-1572917978603-18', 37, NULL, NULL);
INSERT INTO `room_image` VALUES (107, 'https://storage.googleapis.com/room_images_bucket/room-image-38-rc-upload-1572917978603-35', 38, NULL, NULL);
INSERT INTO `room_image` VALUES (108, 'https://storage.googleapis.com/room_images_bucket/room-image-38-rc-upload-1572917978603-33', 38, NULL, NULL);
INSERT INTO `room_image` VALUES (109, 'https://storage.googleapis.com/room_images_bucket/room-image-38-rc-upload-1572917978603-34', 38, NULL, NULL);
INSERT INTO `room_image` VALUES (110, 'https://storage.googleapis.com/room_images_bucket/room-image-38-rc-upload-1572917978603-32', 38, NULL, NULL);
INSERT INTO `room_image` VALUES (111, 'https://storage.googleapis.com/room_images_bucket/room-image-39-rc-upload-1572917978603-38', 39, NULL, NULL);
INSERT INTO `room_image` VALUES (112, 'https://storage.googleapis.com/room_images_bucket/room-image-39-rc-upload-1572917978603-40', 39, NULL, NULL);
INSERT INTO `room_image` VALUES (113, 'https://storage.googleapis.com/room_images_bucket/room-image-39-rc-upload-1572917978603-39', 39, NULL, NULL);
INSERT INTO `room_image` VALUES (114, 'https://storage.googleapis.com/room_images_bucket/room-image-39-rc-upload-1572917978603-37', 39, NULL, NULL);
INSERT INTO `room_image` VALUES (115, 'https://storage.googleapis.com/room_images_bucket/room-image-42-rc-upload-1572917978603-57', 42, NULL, NULL);
INSERT INTO `room_image` VALUES (116, 'https://storage.googleapis.com/room_images_bucket/room-image-42-rc-upload-1572917978603-59', 42, NULL, NULL);
INSERT INTO `room_image` VALUES (117, 'https://storage.googleapis.com/room_images_bucket/room-image-42-rc-upload-1572917978603-60', 42, NULL, NULL);
INSERT INTO `room_image` VALUES (118, 'https://storage.googleapis.com/room_images_bucket/room-image-42-rc-upload-1572917978603-62', 42, NULL, NULL);
INSERT INTO `room_image` VALUES (119, 'https://storage.googleapis.com/room_images_bucket/room-image-42-rc-upload-1572917978603-61', 42, NULL, NULL);
INSERT INTO `room_image` VALUES (120, 'https://storage.googleapis.com/room_images_bucket/room-image-42-rc-upload-1572917978603-63', 42, NULL, NULL);
INSERT INTO `room_image` VALUES (121, 'https://storage.googleapis.com/room_images_bucket/room-image-46-rc-upload-1572917978603-80', 46, NULL, NULL);
INSERT INTO `room_image` VALUES (122, 'https://storage.googleapis.com/room_images_bucket/room-image-46-rc-upload-1572917978603-82', 46, NULL, NULL);
INSERT INTO `room_image` VALUES (123, 'https://storage.googleapis.com/room_images_bucket/room-image-46-rc-upload-1572917978603-81', 46, NULL, NULL);
INSERT INTO `room_image` VALUES (124, 'https://storage.googleapis.com/room_images_bucket/room-image-46-rc-upload-1572917978603-78', 46, NULL, NULL);
INSERT INTO `room_image` VALUES (125, 'https://storage.googleapis.com/room_images_bucket/room-image-46-rc-upload-1572917978603-79', 46, NULL, NULL);
INSERT INTO `room_image` VALUES (126, 'https://storage.googleapis.com/room_images_bucket/room-image-47-rc-upload-1572917978603-86', 47, NULL, NULL);
INSERT INTO `room_image` VALUES (127, 'https://storage.googleapis.com/room_images_bucket/room-image-47-rc-upload-1572917978603-88', 47, NULL, NULL);
INSERT INTO `room_image` VALUES (128, 'https://storage.googleapis.com/room_images_bucket/room-image-47-rc-upload-1572917978603-89', 47, NULL, NULL);
INSERT INTO `room_image` VALUES (129, 'https://storage.googleapis.com/room_images_bucket/room-image-47-rc-upload-1572917978603-87', 47, NULL, NULL);
INSERT INTO `room_image` VALUES (130, 'https://storage.googleapis.com/room_images_bucket/room-image-49-rc-upload-1572920720905-46', 49, NULL, NULL);
INSERT INTO `room_image` VALUES (131, 'https://storage.googleapis.com/room_images_bucket/room-image-49-rc-upload-1572920720905-44', 49, NULL, NULL);
INSERT INTO `room_image` VALUES (132, 'https://storage.googleapis.com/room_images_bucket/room-image-49-rc-upload-1572920720905-45', 49, NULL, NULL);
INSERT INTO `room_image` VALUES (133, 'https://storage.googleapis.com/room_images_bucket/room-image-49-rc-upload-1572920720905-42', 49, NULL, NULL);
INSERT INTO `room_image` VALUES (134, 'https://storage.googleapis.com/room_images_bucket/room-image-51-rc-upload-1572917978603-99', 51, NULL, NULL);
INSERT INTO `room_image` VALUES (135, 'https://storage.googleapis.com/room_images_bucket/room-image-51-rc-upload-1572917978603-102', 51, NULL, NULL);
INSERT INTO `room_image` VALUES (136, 'https://storage.googleapis.com/room_images_bucket/room-image-51-rc-upload-1572917978603-100', 51, NULL, NULL);
INSERT INTO `room_image` VALUES (137, 'https://storage.googleapis.com/room_images_bucket/room-image-51-rc-upload-1572917978603-101', 51, NULL, NULL);
INSERT INTO `room_image` VALUES (138, 'https://storage.googleapis.com/room_images_bucket/room-image-51-rc-upload-1572917978603-103', 51, NULL, NULL);
INSERT INTO `room_image` VALUES (139, 'https://storage.googleapis.com/room_images_bucket/room-image-53-rc-upload-1572923479681-15', 53, NULL, NULL);
INSERT INTO `room_image` VALUES (140, 'https://storage.googleapis.com/room_images_bucket/room-image-53-rc-upload-1572923479681-16', 53, NULL, NULL);
INSERT INTO `room_image` VALUES (141, 'https://storage.googleapis.com/room_images_bucket/room-image-53-rc-upload-1572923479681-18', 53, NULL, NULL);
INSERT INTO `room_image` VALUES (142, 'https://storage.googleapis.com/room_images_bucket/room-image-53-rc-upload-1572923479681-17', 53, NULL, NULL);
INSERT INTO `room_image` VALUES (143, 'https://storage.googleapis.com/room_images_bucket/room-image-59-rc-upload-1572927196707-3', 59, NULL, NULL);
INSERT INTO `room_image` VALUES (144, 'https://storage.googleapis.com/room_images_bucket/room-image-59-rc-upload-1572927196707-4', 59, NULL, NULL);
INSERT INTO `room_image` VALUES (145, 'https://storage.googleapis.com/room_images_bucket/room-image-59-rc-upload-1572927196707-5', 59, NULL, NULL);
INSERT INTO `room_image` VALUES (146, 'https://storage.googleapis.com/room_images_bucket/room-image-59-rc-upload-1572927196707-6', 59, NULL, NULL);
INSERT INTO `room_image` VALUES (147, 'https://storage.googleapis.com/room_images_bucket/room-image-60-rc-upload-1572927196707-9', 60, NULL, NULL);
INSERT INTO `room_image` VALUES (148, 'https://storage.googleapis.com/room_images_bucket/room-image-60-rc-upload-1572927196707-11', 60, NULL, NULL);
INSERT INTO `room_image` VALUES (149, 'https://storage.googleapis.com/room_images_bucket/room-image-60-rc-upload-1572927196707-8', 60, NULL, NULL);
INSERT INTO `room_image` VALUES (150, 'https://storage.googleapis.com/room_images_bucket/room-image-60-rc-upload-1572927196707-10', 60, NULL, NULL);
INSERT INTO `room_image` VALUES (151, 'https://storage.googleapis.com/room_images_bucket/room-image-62-rc-upload-1572928230565-13', 62, NULL, NULL);
INSERT INTO `room_image` VALUES (152, 'https://storage.googleapis.com/room_images_bucket/room-image-62-rc-upload-1572928230565-9', 62, NULL, NULL);
INSERT INTO `room_image` VALUES (153, 'https://storage.googleapis.com/room_images_bucket/room-image-62-rc-upload-1572928230565-11', 62, NULL, NULL);
INSERT INTO `room_image` VALUES (154, 'https://storage.googleapis.com/room_images_bucket/room-image-62-rc-upload-1572928230565-12', 62, NULL, NULL);
INSERT INTO `room_image` VALUES (155, 'https://storage.googleapis.com/room_images_bucket/room-image-65-rc-upload-1572927196707-21', 65, NULL, NULL);
INSERT INTO `room_image` VALUES (156, 'https://storage.googleapis.com/room_images_bucket/room-image-65-rc-upload-1572927196707-22', 65, NULL, NULL);
INSERT INTO `room_image` VALUES (157, 'https://storage.googleapis.com/room_images_bucket/room-image-65-rc-upload-1572927196707-24', 65, NULL, NULL);
INSERT INTO `room_image` VALUES (158, 'https://storage.googleapis.com/room_images_bucket/room-image-65-rc-upload-1572927196707-23', 65, NULL, NULL);
INSERT INTO `room_image` VALUES (159, 'https://storage.googleapis.com/room_images_bucket/room-image-64-rc-upload-1572927196707-27', 64, NULL, NULL);
INSERT INTO `room_image` VALUES (160, 'https://storage.googleapis.com/room_images_bucket/room-image-64-rc-upload-1572927196707-26', 64, NULL, NULL);
INSERT INTO `room_image` VALUES (161, 'https://storage.googleapis.com/room_images_bucket/room-image-64-rc-upload-1572927196707-28', 64, NULL, NULL);
INSERT INTO `room_image` VALUES (162, 'https://storage.googleapis.com/room_images_bucket/room-image-64-rc-upload-1572927196707-29', 64, NULL, NULL);
INSERT INTO `room_image` VALUES (163, 'https://storage.googleapis.com/room_images_bucket/room-image-63-rc-upload-1572927196707-16', 63, NULL, NULL);
INSERT INTO `room_image` VALUES (164, 'https://storage.googleapis.com/room_images_bucket/room-image-63-rc-upload-1572927196707-17', 63, NULL, NULL);
INSERT INTO `room_image` VALUES (165, 'https://storage.googleapis.com/room_images_bucket/room-image-63-rc-upload-1572927196707-18', 63, NULL, NULL);
INSERT INTO `room_image` VALUES (166, 'https://storage.googleapis.com/room_images_bucket/room-image-63-rc-upload-1572927196707-19', 63, NULL, NULL);
INSERT INTO `room_image` VALUES (167, 'https://storage.googleapis.com/room_images_bucket/room-image-66-rc-upload-1572928230565-20', 66, NULL, NULL);
INSERT INTO `room_image` VALUES (168, 'https://storage.googleapis.com/room_images_bucket/room-image-66-rc-upload-1572928230565-17', 66, NULL, NULL);
INSERT INTO `room_image` VALUES (169, 'https://storage.googleapis.com/room_images_bucket/room-image-66-rc-upload-1572928230565-18', 66, NULL, NULL);
INSERT INTO `room_image` VALUES (170, 'https://storage.googleapis.com/room_images_bucket/room-image-66-rc-upload-1572928230565-16', 66, NULL, NULL);
INSERT INTO `room_image` VALUES (171, 'https://storage.googleapis.com/room_images_bucket/room-image-68-rc-upload-1572927196707-41', 68, NULL, NULL);
INSERT INTO `room_image` VALUES (172, 'https://storage.googleapis.com/room_images_bucket/room-image-68-rc-upload-1572927196707-38', 68, NULL, NULL);
INSERT INTO `room_image` VALUES (173, 'https://storage.googleapis.com/room_images_bucket/room-image-68-rc-upload-1572927196707-40', 68, NULL, NULL);
INSERT INTO `room_image` VALUES (174, 'https://storage.googleapis.com/room_images_bucket/room-image-68-rc-upload-1572927196707-39', 68, NULL, NULL);
INSERT INTO `room_image` VALUES (175, 'https://storage.googleapis.com/room_images_bucket/room-image-67-rc-upload-1572927196707-33', 67, NULL, NULL);
INSERT INTO `room_image` VALUES (176, 'https://storage.googleapis.com/room_images_bucket/room-image-67-rc-upload-1572927196707-34', 67, NULL, NULL);
INSERT INTO `room_image` VALUES (177, 'https://storage.googleapis.com/room_images_bucket/room-image-67-rc-upload-1572927196707-35', 67, NULL, NULL);
INSERT INTO `room_image` VALUES (178, 'https://storage.googleapis.com/room_images_bucket/room-image-67-rc-upload-1572927196707-36', 67, NULL, NULL);
INSERT INTO `room_image` VALUES (179, 'https://storage.googleapis.com/room_images_bucket/room-image-69-rc-upload-1572928926180-2', 69, NULL, NULL);
INSERT INTO `room_image` VALUES (180, 'https://storage.googleapis.com/room_images_bucket/room-image-69-rc-upload-1572928926180-4', 69, NULL, NULL);
INSERT INTO `room_image` VALUES (181, 'https://storage.googleapis.com/room_images_bucket/room-image-69-rc-upload-1572928926180-3', 69, NULL, NULL);
INSERT INTO `room_image` VALUES (182, 'https://storage.googleapis.com/room_images_bucket/room-image-69-rc-upload-1572928926180-5', 69, NULL, NULL);
INSERT INTO `room_image` VALUES (183, 'https://storage.googleapis.com/room_images_bucket/room-image-72-rc-upload-1572927196707-56', 72, NULL, NULL);
INSERT INTO `room_image` VALUES (184, 'https://storage.googleapis.com/room_images_bucket/room-image-72-rc-upload-1572927196707-59', 72, NULL, NULL);
INSERT INTO `room_image` VALUES (185, 'https://storage.googleapis.com/room_images_bucket/room-image-72-rc-upload-1572927196707-57', 72, NULL, NULL);
INSERT INTO `room_image` VALUES (186, 'https://storage.googleapis.com/room_images_bucket/room-image-72-rc-upload-1572927196707-58', 72, NULL, NULL);
INSERT INTO `room_image` VALUES (187, 'https://storage.googleapis.com/room_images_bucket/room-image-70-rc-upload-1572927196707-53', 70, NULL, NULL);
INSERT INTO `room_image` VALUES (188, 'https://storage.googleapis.com/room_images_bucket/room-image-70-rc-upload-1572927196707-54', 70, NULL, NULL);
INSERT INTO `room_image` VALUES (189, 'https://storage.googleapis.com/room_images_bucket/room-image-70-rc-upload-1572927196707-51', 70, NULL, NULL);
INSERT INTO `room_image` VALUES (190, 'https://storage.googleapis.com/room_images_bucket/room-image-70-rc-upload-1572927196707-52', 70, NULL, NULL);
INSERT INTO `room_image` VALUES (191, 'https://storage.googleapis.com/room_images_bucket/room-image-71-rc-upload-1572927196707-48', 71, NULL, NULL);
INSERT INTO `room_image` VALUES (192, 'https://storage.googleapis.com/room_images_bucket/room-image-71-rc-upload-1572927196707-47', 71, NULL, NULL);
INSERT INTO `room_image` VALUES (193, 'https://storage.googleapis.com/room_images_bucket/room-image-71-rc-upload-1572927196707-49', 71, NULL, NULL);
INSERT INTO `room_image` VALUES (194, 'https://storage.googleapis.com/room_images_bucket/room-image-71-rc-upload-1572927196707-46', 71, NULL, NULL);
INSERT INTO `room_image` VALUES (195, 'https://storage.googleapis.com/room_images_bucket/room-image-73-rc-upload-1572928230565-24', 73, NULL, NULL);
INSERT INTO `room_image` VALUES (196, 'https://storage.googleapis.com/room_images_bucket/room-image-73-rc-upload-1572928230565-27', 73, NULL, NULL);
INSERT INTO `room_image` VALUES (197, 'https://storage.googleapis.com/room_images_bucket/room-image-73-rc-upload-1572928230565-25', 73, NULL, NULL);
INSERT INTO `room_image` VALUES (198, 'https://storage.googleapis.com/room_images_bucket/room-image-73-rc-upload-1572928230565-26', 73, NULL, NULL);
INSERT INTO `room_image` VALUES (199, 'https://storage.googleapis.com/room_images_bucket/room-image-74-rc-upload-1572928230565-31', 74, NULL, NULL);
INSERT INTO `room_image` VALUES (200, 'https://storage.googleapis.com/room_images_bucket/room-image-74-rc-upload-1572928230565-29', 74, NULL, NULL);
INSERT INTO `room_image` VALUES (201, 'https://storage.googleapis.com/room_images_bucket/room-image-74-rc-upload-1572928230565-30', 74, NULL, NULL);
INSERT INTO `room_image` VALUES (202, 'https://storage.googleapis.com/room_images_bucket/room-image-74-rc-upload-1572928230565-32', 74, NULL, NULL);
INSERT INTO `room_image` VALUES (203, 'https://storage.googleapis.com/room_images_bucket/room-image-75-rc-upload-1572928230565-38', 75, NULL, NULL);
INSERT INTO `room_image` VALUES (204, 'https://storage.googleapis.com/room_images_bucket/room-image-75-rc-upload-1572928230565-35', 75, NULL, NULL);
INSERT INTO `room_image` VALUES (205, 'https://storage.googleapis.com/room_images_bucket/room-image-75-rc-upload-1572928230565-39', 75, NULL, NULL);
INSERT INTO `room_image` VALUES (206, 'https://storage.googleapis.com/room_images_bucket/room-image-75-rc-upload-1572928230565-37', 75, NULL, NULL);
INSERT INTO `room_image` VALUES (207, 'https://storage.googleapis.com/room_images_bucket/room-image-75-rc-upload-1572928230565-36', 75, NULL, NULL);
INSERT INTO `room_image` VALUES (208, 'https://storage.googleapis.com/room_images_bucket/room-image-77-rc-upload-1572930793371-13', 77, NULL, NULL);
INSERT INTO `room_image` VALUES (209, 'https://storage.googleapis.com/room_images_bucket/room-image-77-rc-upload-1572930793371-12', 77, NULL, NULL);
INSERT INTO `room_image` VALUES (210, 'https://storage.googleapis.com/room_images_bucket/room-image-77-rc-upload-1572930793371-15', 77, NULL, NULL);
INSERT INTO `room_image` VALUES (211, 'https://storage.googleapis.com/room_images_bucket/room-image-77-rc-upload-1572930793371-14', 77, NULL, NULL);
INSERT INTO `room_image` VALUES (212, 'https://storage.googleapis.com/room_images_bucket/room-image-81-rc-upload-1572932700986-29', 81, NULL, NULL);
INSERT INTO `room_image` VALUES (213, 'https://storage.googleapis.com/room_images_bucket/room-image-81-rc-upload-1572932700986-31', 81, NULL, NULL);
INSERT INTO `room_image` VALUES (214, 'https://storage.googleapis.com/room_images_bucket/room-image-81-rc-upload-1572932700986-32', 81, NULL, NULL);
INSERT INTO `room_image` VALUES (215, 'https://storage.googleapis.com/room_images_bucket/room-image-81-rc-upload-1572932700986-30', 81, NULL, NULL);
INSERT INTO `room_image` VALUES (216, 'https://storage.googleapis.com/room_images_bucket/room-image-81-rc-upload-1572932700986-33', 81, NULL, NULL);
INSERT INTO `room_image` VALUES (217, 'https://storage.googleapis.com/room_images_bucket/room-image-86-rc-upload-1572932700986-67', 86, NULL, NULL);
INSERT INTO `room_image` VALUES (218, 'https://storage.googleapis.com/room_images_bucket/room-image-86-rc-upload-1572932700986-70', 86, NULL, NULL);
INSERT INTO `room_image` VALUES (219, 'https://storage.googleapis.com/room_images_bucket/room-image-86-rc-upload-1572932700986-68', 86, NULL, NULL);
INSERT INTO `room_image` VALUES (220, 'https://storage.googleapis.com/room_images_bucket/room-image-86-rc-upload-1572932700986-69', 86, NULL, NULL);
INSERT INTO `room_image` VALUES (221, 'https://storage.googleapis.com/room_images_bucket/room-image-86-rc-upload-1572932700986-66', 86, NULL, NULL);
INSERT INTO `room_image` VALUES (222, 'https://storage.googleapis.com/room_images_bucket/room-image-89-rc-upload-1572932700986-87', 89, NULL, NULL);
INSERT INTO `room_image` VALUES (223, 'https://storage.googleapis.com/room_images_bucket/room-image-89-rc-upload-1572932700986-88', 89, NULL, NULL);
INSERT INTO `room_image` VALUES (224, 'https://storage.googleapis.com/room_images_bucket/room-image-89-rc-upload-1572932700986-92', 89, NULL, NULL);
INSERT INTO `room_image` VALUES (225, 'https://storage.googleapis.com/room_images_bucket/room-image-89-rc-upload-1572932700986-91', 89, NULL, NULL);
INSERT INTO `room_image` VALUES (226, 'https://storage.googleapis.com/room_images_bucket/room-image-89-rc-upload-1572932700986-89', 89, NULL, NULL);
INSERT INTO `room_image` VALUES (227, 'https://storage.googleapis.com/room_images_bucket/room-image-90-rc-upload-1572932700986-95', 90, NULL, NULL);
INSERT INTO `room_image` VALUES (228, 'https://storage.googleapis.com/room_images_bucket/room-image-90-rc-upload-1572932700986-98', 90, NULL, NULL);
INSERT INTO `room_image` VALUES (229, 'https://storage.googleapis.com/room_images_bucket/room-image-90-rc-upload-1572932700986-96', 90, NULL, NULL);
INSERT INTO `room_image` VALUES (230, 'https://storage.googleapis.com/room_images_bucket/room-image-90-rc-upload-1572932700986-99', 90, NULL, NULL);
INSERT INTO `room_image` VALUES (231, 'https://storage.googleapis.com/room_images_bucket/room-image-90-rc-upload-1572932700986-97', 90, NULL, NULL);
INSERT INTO `room_image` VALUES (232, 'https://storage.googleapis.com/room_images_bucket/room-image-92-rc-upload-1572932700986-108', 92, NULL, NULL);
INSERT INTO `room_image` VALUES (233, 'https://storage.googleapis.com/room_images_bucket/room-image-92-rc-upload-1572932700986-109', 92, NULL, NULL);
INSERT INTO `room_image` VALUES (234, 'https://storage.googleapis.com/room_images_bucket/room-image-92-rc-upload-1572932700986-110', 92, NULL, NULL);
INSERT INTO `room_image` VALUES (235, 'https://storage.googleapis.com/room_images_bucket/room-image-92-rc-upload-1572932700986-111', 92, NULL, NULL);
INSERT INTO `room_image` VALUES (236, 'https://storage.googleapis.com/room_images_bucket/room-image-94-rc-upload-1572932700986-121', 94, NULL, NULL);
INSERT INTO `room_image` VALUES (237, 'https://storage.googleapis.com/room_images_bucket/room-image-94-rc-upload-1572932700986-123', 94, NULL, NULL);
INSERT INTO `room_image` VALUES (238, 'https://storage.googleapis.com/room_images_bucket/room-image-94-rc-upload-1572932700986-120', 94, NULL, NULL);
INSERT INTO `room_image` VALUES (239, 'https://storage.googleapis.com/room_images_bucket/room-image-94-rc-upload-1572932700986-122', 94, NULL, NULL);
INSERT INTO `room_image` VALUES (240, 'https://storage.googleapis.com/room_images_bucket/room-image-94-rc-upload-1572932700986-124', 94, NULL, NULL);
INSERT INTO `room_image` VALUES (241, 'https://storage.googleapis.com/room_images_bucket/room-image-96-rc-upload-1572959518743-2', 96, NULL, NULL);
INSERT INTO `room_image` VALUES (242, 'https://storage.googleapis.com/room_images_bucket/room-image-96-rc-upload-1572959518743-4', 96, NULL, NULL);
INSERT INTO `room_image` VALUES (243, 'https://storage.googleapis.com/room_images_bucket/room-image-96-rc-upload-1572959518743-3', 96, NULL, NULL);
INSERT INTO `room_image` VALUES (244, 'https://storage.googleapis.com/room_images_bucket/room-image-96-rc-upload-1572959518743-5', 96, NULL, NULL);
INSERT INTO `room_image` VALUES (245, 'https://storage.googleapis.com/room_images_bucket/room-image-97-rc-upload-1572959518743-8', 97, NULL, NULL);
INSERT INTO `room_image` VALUES (246, 'https://storage.googleapis.com/room_images_bucket/room-image-97-rc-upload-1572959518743-11', 97, NULL, NULL);
INSERT INTO `room_image` VALUES (247, 'https://storage.googleapis.com/room_images_bucket/room-image-97-rc-upload-1572959518743-10', 97, NULL, NULL);
INSERT INTO `room_image` VALUES (248, 'https://storage.googleapis.com/room_images_bucket/room-image-97-rc-upload-1572959518743-9', 97, NULL, NULL);
INSERT INTO `room_image` VALUES (249, 'https://storage.googleapis.com/room_images_bucket/room-image-97-rc-upload-1572959518743-12', 97, NULL, NULL);
INSERT INTO `room_image` VALUES (250, 'https://storage.googleapis.com/room_images_bucket/room-image-99-rc-upload-1572960306920-11', 99, NULL, NULL);
INSERT INTO `room_image` VALUES (251, 'https://storage.googleapis.com/room_images_bucket/room-image-99-rc-upload-1572960306920-10', 99, NULL, NULL);
INSERT INTO `room_image` VALUES (252, 'https://storage.googleapis.com/room_images_bucket/room-image-99-rc-upload-1572960306920-13', 99, NULL, NULL);
INSERT INTO `room_image` VALUES (253, 'https://storage.googleapis.com/room_images_bucket/room-image-99-rc-upload-1572960306920-12', 99, NULL, NULL);
INSERT INTO `room_image` VALUES (254, 'https://storage.googleapis.com/room_images_bucket/room-image-100-rc-upload-1572960306920-17', 100, NULL, NULL);
INSERT INTO `room_image` VALUES (255, 'https://storage.googleapis.com/room_images_bucket/room-image-100-rc-upload-1572960306920-19', 100, NULL, NULL);
INSERT INTO `room_image` VALUES (256, 'https://storage.googleapis.com/room_images_bucket/room-image-100-rc-upload-1572960306920-16', 100, NULL, NULL);
INSERT INTO `room_image` VALUES (257, 'https://storage.googleapis.com/room_images_bucket/room-image-100-rc-upload-1572960306920-18', 100, NULL, NULL);
INSERT INTO `room_image` VALUES (258, 'https://storage.googleapis.com/room_images_bucket/room-image-101-rc-upload-1572960306920-22', 101, NULL, NULL);
INSERT INTO `room_image` VALUES (259, 'https://storage.googleapis.com/room_images_bucket/room-image-101-rc-upload-1572960306920-23', 101, NULL, NULL);
INSERT INTO `room_image` VALUES (260, 'https://storage.googleapis.com/room_images_bucket/room-image-101-rc-upload-1572960306920-24', 101, NULL, NULL);
INSERT INTO `room_image` VALUES (261, 'https://storage.googleapis.com/room_images_bucket/room-image-101-rc-upload-1572960306920-26', 101, NULL, NULL);
INSERT INTO `room_image` VALUES (262, 'https://storage.googleapis.com/room_images_bucket/room-image-102-rc-upload-1572960306920-31', 102, NULL, NULL);
INSERT INTO `room_image` VALUES (263, 'https://storage.googleapis.com/room_images_bucket/room-image-102-rc-upload-1572960306920-33', 102, NULL, NULL);
INSERT INTO `room_image` VALUES (264, 'https://storage.googleapis.com/room_images_bucket/room-image-102-rc-upload-1572960306920-29', 102, NULL, NULL);
INSERT INTO `room_image` VALUES (265, 'https://storage.googleapis.com/room_images_bucket/room-image-102-rc-upload-1572960306920-30', 102, NULL, NULL);
INSERT INTO `room_image` VALUES (266, 'https://storage.googleapis.com/room_images_bucket/room-image-104-rc-upload-1572960306920-48', 104, NULL, NULL);
INSERT INTO `room_image` VALUES (267, 'https://storage.googleapis.com/room_images_bucket/room-image-104-rc-upload-1572960306920-43', 104, NULL, NULL);
INSERT INTO `room_image` VALUES (268, 'https://storage.googleapis.com/room_images_bucket/room-image-104-rc-upload-1572960306920-44', 104, NULL, NULL);
INSERT INTO `room_image` VALUES (269, 'https://storage.googleapis.com/room_images_bucket/room-image-104-rc-upload-1572960306920-46', 104, NULL, NULL);
INSERT INTO `room_image` VALUES (270, 'https://storage.googleapis.com/room_images_bucket/room-image-107-rc-upload-1572963153371-4', 107, NULL, NULL);
INSERT INTO `room_image` VALUES (271, 'https://storage.googleapis.com/room_images_bucket/room-image-107-rc-upload-1572963153371-5', 107, NULL, NULL);
INSERT INTO `room_image` VALUES (272, 'https://storage.googleapis.com/room_images_bucket/room-image-107-rc-upload-1572963153371-3', 107, NULL, NULL);
INSERT INTO `room_image` VALUES (273, 'https://storage.googleapis.com/room_images_bucket/room-image-107-rc-upload-1572963153371-2', 107, NULL, NULL);
INSERT INTO `room_image` VALUES (274, 'https://storage.googleapis.com/room_images_bucket/room-image-108-rc-upload-1572963153371-8', 108, NULL, NULL);
INSERT INTO `room_image` VALUES (275, 'https://storage.googleapis.com/room_images_bucket/room-image-108-rc-upload-1572963153371-10', 108, NULL, NULL);
INSERT INTO `room_image` VALUES (276, 'https://storage.googleapis.com/room_images_bucket/room-image-108-rc-upload-1572963153371-9', 108, NULL, NULL);
INSERT INTO `room_image` VALUES (277, 'https://storage.googleapis.com/room_images_bucket/room-image-108-rc-upload-1572963153371-12', 108, NULL, NULL);
INSERT INTO `room_image` VALUES (278, 'https://storage.googleapis.com/room_images_bucket/room-image-108-rc-upload-1572963153371-14', 108, NULL, NULL);
INSERT INTO `room_image` VALUES (279, 'https://storage.googleapis.com/room_images_bucket/room-image-109-rc-upload-1572966954915-4', 109, NULL, NULL);
INSERT INTO `room_image` VALUES (280, 'https://storage.googleapis.com/room_images_bucket/room-image-109-rc-upload-1572966954915-2', 109, NULL, NULL);
INSERT INTO `room_image` VALUES (281, 'https://storage.googleapis.com/room_images_bucket/room-image-109-rc-upload-1572966954915-3', 109, NULL, NULL);
INSERT INTO `room_image` VALUES (282, 'https://storage.googleapis.com/room_images_bucket/room-image-109-rc-upload-1572966954915-6', 109, NULL, NULL);
INSERT INTO `room_image` VALUES (283, 'https://storage.googleapis.com/room_images_bucket/room-image-109-rc-upload-1572966954915-5', 109, NULL, NULL);
INSERT INTO `room_image` VALUES (284, 'https://storage.googleapis.com/room_images_bucket/room-image-110-rc-upload-1572968352759-3', 110, NULL, NULL);
INSERT INTO `room_image` VALUES (285, 'https://storage.googleapis.com/room_images_bucket/room-image-110-rc-upload-1572968352759-6', 110, NULL, NULL);
INSERT INTO `room_image` VALUES (286, 'https://storage.googleapis.com/room_images_bucket/room-image-110-rc-upload-1572968352759-2', 110, NULL, NULL);
INSERT INTO `room_image` VALUES (287, 'https://storage.googleapis.com/room_images_bucket/room-image-110-rc-upload-1572968352759-4', 110, NULL, NULL);
INSERT INTO `room_image` VALUES (288, 'https://storage.googleapis.com/room_images_bucket/room-image-110-rc-upload-1572968352759-5', 110, NULL, NULL);
INSERT INTO `room_image` VALUES (289, 'https://storage.googleapis.com/room_images_bucket/room-image-111-rc-upload-1572968610334-4', 111, NULL, NULL);
INSERT INTO `room_image` VALUES (290, 'https://storage.googleapis.com/room_images_bucket/room-image-111-rc-upload-1572968610334-2', 111, NULL, NULL);
INSERT INTO `room_image` VALUES (291, 'https://storage.googleapis.com/room_images_bucket/room-image-111-rc-upload-1572968610334-3', 111, NULL, NULL);
INSERT INTO `room_image` VALUES (292, 'https://storage.googleapis.com/room_images_bucket/room-image-111-rc-upload-1572968610334-5', 111, NULL, NULL);
INSERT INTO `room_image` VALUES (293, 'https://storage.googleapis.com/room_images_bucket/room-image-112-rc-upload-1572968934797-2', 112, NULL, NULL);
INSERT INTO `room_image` VALUES (294, 'https://storage.googleapis.com/room_images_bucket/room-image-112-rc-upload-1572968934797-4', 112, NULL, NULL);
INSERT INTO `room_image` VALUES (295, 'https://storage.googleapis.com/room_images_bucket/room-image-112-rc-upload-1572968934797-3', 112, NULL, NULL);
INSERT INTO `room_image` VALUES (296, 'https://storage.googleapis.com/room_images_bucket/room-image-112-rc-upload-1572968934797-5', 112, NULL, NULL);
INSERT INTO `room_image` VALUES (297, 'https://storage.googleapis.com/room_images_bucket/room-image-113-rc-upload-1572969536785-3', 113, NULL, NULL);
INSERT INTO `room_image` VALUES (298, 'https://storage.googleapis.com/room_images_bucket/room-image-113-rc-upload-1572969536785-2', 113, NULL, NULL);
INSERT INTO `room_image` VALUES (299, 'https://storage.googleapis.com/room_images_bucket/room-image-113-rc-upload-1572969536785-5', 113, NULL, NULL);
INSERT INTO `room_image` VALUES (300, 'https://storage.googleapis.com/room_images_bucket/room-image-113-rc-upload-1572969536785-4', 113, NULL, NULL);
INSERT INTO `room_image` VALUES (301, 'https://storage.googleapis.com/room_images_bucket/room-image-114-rc-upload-1572969983624-4', 114, NULL, NULL);
INSERT INTO `room_image` VALUES (302, 'https://storage.googleapis.com/room_images_bucket/room-image-114-rc-upload-1572969983624-3', 114, NULL, NULL);
INSERT INTO `room_image` VALUES (303, 'https://storage.googleapis.com/room_images_bucket/room-image-114-rc-upload-1572969983624-6', 114, NULL, NULL);
INSERT INTO `room_image` VALUES (304, 'https://storage.googleapis.com/room_images_bucket/room-image-114-rc-upload-1572969983624-2', 114, NULL, NULL);
INSERT INTO `room_image` VALUES (305, 'https://storage.googleapis.com/room_images_bucket/room-image-114-rc-upload-1572969983624-5', 114, NULL, NULL);
INSERT INTO `room_image` VALUES (306, 'https://storage.googleapis.com/room_images_bucket/room-image-116-rc-upload-1572971137493-3', 116, NULL, NULL);
INSERT INTO `room_image` VALUES (307, 'https://storage.googleapis.com/room_images_bucket/room-image-116-rc-upload-1572971137493-2', 116, NULL, NULL);
INSERT INTO `room_image` VALUES (308, 'https://storage.googleapis.com/room_images_bucket/room-image-116-rc-upload-1572971137493-4', 116, NULL, NULL);
INSERT INTO `room_image` VALUES (309, 'https://storage.googleapis.com/room_images_bucket/room-image-116-rc-upload-1572971137493-5', 116, NULL, NULL);
INSERT INTO `room_image` VALUES (310, 'https://storage.googleapis.com/room_images_bucket/room-image-116-rc-upload-1572971137493-6', 116, NULL, NULL);
INSERT INTO `room_image` VALUES (311, 'https://storage.googleapis.com/room_images_bucket/room-image-116-rc-upload-1572971137493-7', 116, NULL, NULL);
INSERT INTO `room_image` VALUES (312, 'https://storage.googleapis.com/room_images_bucket/room-image-117-rc-upload-1572971650648-3', 117, NULL, NULL);
INSERT INTO `room_image` VALUES (313, 'https://storage.googleapis.com/room_images_bucket/room-image-117-rc-upload-1572971650648-2', 117, NULL, NULL);
INSERT INTO `room_image` VALUES (314, 'https://storage.googleapis.com/room_images_bucket/room-image-117-rc-upload-1572971650648-4', 117, NULL, NULL);
INSERT INTO `room_image` VALUES (315, 'https://storage.googleapis.com/room_images_bucket/room-image-117-rc-upload-1572971650648-5', 117, NULL, NULL);
INSERT INTO `room_image` VALUES (316, 'https://storage.googleapis.com/room_images_bucket/room-image-118-rc-upload-1572970338259-12', 118, NULL, NULL);
INSERT INTO `room_image` VALUES (317, 'https://storage.googleapis.com/room_images_bucket/room-image-118-rc-upload-1572970338259-13', 118, NULL, NULL);
INSERT INTO `room_image` VALUES (318, 'https://storage.googleapis.com/room_images_bucket/room-image-118-rc-upload-1572970338259-15', 118, NULL, NULL);
INSERT INTO `room_image` VALUES (319, 'https://storage.googleapis.com/room_images_bucket/room-image-118-rc-upload-1572970338259-11', 118, NULL, NULL);
INSERT INTO `room_image` VALUES (320, 'https://storage.googleapis.com/room_images_bucket/room-image-119-rc-upload-1572971990585-2', 119, NULL, NULL);
INSERT INTO `room_image` VALUES (321, 'https://storage.googleapis.com/room_images_bucket/room-image-119-rc-upload-1572971990585-4', 119, NULL, NULL);
INSERT INTO `room_image` VALUES (322, 'https://storage.googleapis.com/room_images_bucket/room-image-119-rc-upload-1572971990585-3', 119, NULL, NULL);
INSERT INTO `room_image` VALUES (323, 'https://storage.googleapis.com/room_images_bucket/room-image-119-rc-upload-1572971990585-6', 119, NULL, NULL);
INSERT INTO `room_image` VALUES (324, 'https://storage.googleapis.com/room_images_bucket/room-image-120-rc-upload-1572970338259-19', 120, NULL, NULL);
INSERT INTO `room_image` VALUES (325, 'https://storage.googleapis.com/room_images_bucket/room-image-120-rc-upload-1572970338259-18', 120, NULL, NULL);
INSERT INTO `room_image` VALUES (326, 'https://storage.googleapis.com/room_images_bucket/room-image-120-rc-upload-1572970338259-20', 120, NULL, NULL);
INSERT INTO `room_image` VALUES (327, 'https://storage.googleapis.com/room_images_bucket/room-image-120-rc-upload-1572970338259-22', 120, NULL, NULL);
INSERT INTO `room_image` VALUES (328, 'https://storage.googleapis.com/room_images_bucket/room-image-120-rc-upload-1572970338259-21', 120, NULL, NULL);
INSERT INTO `room_image` VALUES (329, 'https://storage.googleapis.com/room_images_bucket/room-image-121-rc-upload-1572972577854-2', 121, NULL, NULL);
INSERT INTO `room_image` VALUES (330, 'https://storage.googleapis.com/room_images_bucket/room-image-121-rc-upload-1572972577854-4', 121, NULL, NULL);
INSERT INTO `room_image` VALUES (331, 'https://storage.googleapis.com/room_images_bucket/room-image-121-rc-upload-1572972577854-6', 121, NULL, NULL);
INSERT INTO `room_image` VALUES (332, 'https://storage.googleapis.com/room_images_bucket/room-image-121-rc-upload-1572972577854-3', 121, NULL, NULL);
INSERT INTO `room_image` VALUES (333, 'https://storage.googleapis.com/room_images_bucket/room-image-122-rc-upload-1572972806034-4', 122, NULL, NULL);
INSERT INTO `room_image` VALUES (334, 'https://storage.googleapis.com/room_images_bucket/room-image-122-rc-upload-1572972806034-2', 122, NULL, NULL);
INSERT INTO `room_image` VALUES (335, 'https://storage.googleapis.com/room_images_bucket/room-image-122-rc-upload-1572972806034-5', 122, NULL, NULL);
INSERT INTO `room_image` VALUES (336, 'https://storage.googleapis.com/room_images_bucket/room-image-122-rc-upload-1572972806034-6', 122, NULL, NULL);
INSERT INTO `room_image` VALUES (337, 'https://storage.googleapis.com/room_images_bucket/room-image-122-rc-upload-1572972806034-3', 122, NULL, NULL);
INSERT INTO `room_image` VALUES (338, 'https://storage.googleapis.com/room_images_bucket/room-image-123-rc-upload-1572973363801-2', 123, NULL, NULL);
INSERT INTO `room_image` VALUES (339, 'https://storage.googleapis.com/room_images_bucket/room-image-123-rc-upload-1572973363801-3', 123, NULL, NULL);
INSERT INTO `room_image` VALUES (340, 'https://storage.googleapis.com/room_images_bucket/room-image-123-rc-upload-1572973363801-4', 123, NULL, NULL);
INSERT INTO `room_image` VALUES (341, 'https://storage.googleapis.com/room_images_bucket/room-image-123-rc-upload-1572973363801-5', 123, NULL, NULL);
INSERT INTO `room_image` VALUES (342, 'https://storage.googleapis.com/room_images_bucket/room-image-124-rc-upload-1572973731326-2', 124, NULL, NULL);
INSERT INTO `room_image` VALUES (343, 'https://storage.googleapis.com/room_images_bucket/room-image-124-rc-upload-1572973731326-4', 124, NULL, NULL);
INSERT INTO `room_image` VALUES (344, 'https://storage.googleapis.com/room_images_bucket/room-image-124-rc-upload-1572973731326-3', 124, NULL, NULL);
INSERT INTO `room_image` VALUES (345, 'https://storage.googleapis.com/room_images_bucket/room-image-124-rc-upload-1572973731326-6', 124, NULL, NULL);
INSERT INTO `room_image` VALUES (346, 'https://storage.googleapis.com/room_images_bucket/room-image-127-rc-upload-1572974649737-2', 127, NULL, NULL);
INSERT INTO `room_image` VALUES (347, 'https://storage.googleapis.com/room_images_bucket/room-image-127-rc-upload-1572974649737-5', 127, NULL, NULL);
INSERT INTO `room_image` VALUES (348, 'https://storage.googleapis.com/room_images_bucket/room-image-127-rc-upload-1572974649737-4', 127, NULL, NULL);
INSERT INTO `room_image` VALUES (349, 'https://storage.googleapis.com/room_images_bucket/room-image-127-rc-upload-1572974649737-3', 127, NULL, NULL);
INSERT INTO `room_image` VALUES (350, 'https://storage.googleapis.com/room_images_bucket/room-image-128-rc-upload-1572974965588-2', 128, NULL, NULL);
INSERT INTO `room_image` VALUES (351, 'https://storage.googleapis.com/room_images_bucket/room-image-128-rc-upload-1572974965588-4', 128, NULL, NULL);
INSERT INTO `room_image` VALUES (352, 'https://storage.googleapis.com/room_images_bucket/room-image-128-rc-upload-1572974965588-3', 128, NULL, NULL);
INSERT INTO `room_image` VALUES (353, 'https://storage.googleapis.com/room_images_bucket/room-image-128-rc-upload-1572974965588-5', 128, NULL, NULL);
INSERT INTO `room_image` VALUES (354, 'https://storage.googleapis.com/room_images_bucket/room-image-129-rc-upload-1572975797761-2', 129, NULL, NULL);
INSERT INTO `room_image` VALUES (355, 'https://storage.googleapis.com/room_images_bucket/room-image-129-rc-upload-1572975797761-3', 129, NULL, NULL);
INSERT INTO `room_image` VALUES (356, 'https://storage.googleapis.com/room_images_bucket/room-image-129-rc-upload-1572975797761-4', 129, NULL, NULL);
INSERT INTO `room_image` VALUES (357, 'https://storage.googleapis.com/room_images_bucket/room-image-129-rc-upload-1572975797761-5', 129, NULL, NULL);
INSERT INTO `room_image` VALUES (358, 'https://storage.googleapis.com/room_images_bucket/room-image-130-rc-upload-1572976059315-6', 130, NULL, NULL);
INSERT INTO `room_image` VALUES (359, 'https://storage.googleapis.com/room_images_bucket/room-image-130-rc-upload-1572976059315-8', 130, NULL, NULL);
INSERT INTO `room_image` VALUES (360, 'https://storage.googleapis.com/room_images_bucket/room-image-130-rc-upload-1572976059315-2', 130, NULL, NULL);
INSERT INTO `room_image` VALUES (361, 'https://storage.googleapis.com/room_images_bucket/room-image-130-rc-upload-1572976059315-4', 130, NULL, NULL);
INSERT INTO `room_image` VALUES (362, 'https://storage.googleapis.com/room_images_bucket/room-image-130-rc-upload-1572976059315-3', 130, NULL, NULL);
INSERT INTO `room_image` VALUES (363, 'https://storage.googleapis.com/room_images_bucket/room-image-130-rc-upload-1572976059315-5', 130, NULL, NULL);
INSERT INTO `room_image` VALUES (364, 'https://storage.googleapis.com/room_images_bucket/room-image-130-rc-upload-1572976059315-7', 130, NULL, NULL);
INSERT INTO `room_image` VALUES (365, 'https://storage.googleapis.com/room_images_bucket/room-image-131-rc-upload-1572976246629-2', 131, NULL, NULL);
INSERT INTO `room_image` VALUES (366, 'https://storage.googleapis.com/room_images_bucket/room-image-131-rc-upload-1572976246629-4', 131, NULL, NULL);
INSERT INTO `room_image` VALUES (367, 'https://storage.googleapis.com/room_images_bucket/room-image-131-rc-upload-1572976246629-3', 131, NULL, NULL);
INSERT INTO `room_image` VALUES (368, 'https://storage.googleapis.com/room_images_bucket/room-image-131-rc-upload-1572976246629-5', 131, NULL, NULL);
INSERT INTO `room_image` VALUES (369, 'https://storage.googleapis.com/room_images_bucket/room-image-132-rc-upload-1572976550302-4', 132, NULL, NULL);
INSERT INTO `room_image` VALUES (370, 'https://storage.googleapis.com/room_images_bucket/room-image-132-rc-upload-1572976550302-5', 132, NULL, NULL);
INSERT INTO `room_image` VALUES (371, 'https://storage.googleapis.com/room_images_bucket/room-image-132-rc-upload-1572976550302-2', 132, NULL, NULL);
INSERT INTO `room_image` VALUES (372, 'https://storage.googleapis.com/room_images_bucket/room-image-132-rc-upload-1572976550302-3', 132, NULL, NULL);
INSERT INTO `room_image` VALUES (373, 'https://storage.googleapis.com/room_images_bucket/room-image-133-rc-upload-1572976885903-3', 133, NULL, NULL);
INSERT INTO `room_image` VALUES (374, 'https://storage.googleapis.com/room_images_bucket/room-image-133-rc-upload-1572976885903-2', 133, NULL, NULL);
INSERT INTO `room_image` VALUES (375, 'https://storage.googleapis.com/room_images_bucket/room-image-133-rc-upload-1572976885903-4', 133, NULL, NULL);
INSERT INTO `room_image` VALUES (376, 'https://storage.googleapis.com/room_images_bucket/room-image-133-rc-upload-1572976885903-5', 133, NULL, NULL);
INSERT INTO `room_image` VALUES (377, 'https://storage.googleapis.com/room_images_bucket/room-image-134-rc-upload-1572977075599-5', 134, NULL, NULL);
INSERT INTO `room_image` VALUES (378, 'https://storage.googleapis.com/room_images_bucket/room-image-134-rc-upload-1572977075599-3', 134, NULL, NULL);
INSERT INTO `room_image` VALUES (379, 'https://storage.googleapis.com/room_images_bucket/room-image-134-rc-upload-1572977075599-4', 134, NULL, NULL);
INSERT INTO `room_image` VALUES (380, 'https://storage.googleapis.com/room_images_bucket/room-image-134-rc-upload-1572977075599-2', 134, NULL, NULL);
INSERT INTO `room_image` VALUES (381, 'https://storage.googleapis.com/room_images_bucket/room-image-136-rc-upload-1573656387617-9', 136, '2019-11-13 14:50:13.957477', NULL);
INSERT INTO `room_image` VALUES (382, 'https://storage.googleapis.com/room_images_bucket/room-image-136-rc-upload-1573656387617-10', 136, '2019-11-13 14:50:13.958385', NULL);
INSERT INTO `room_image` VALUES (383, 'https://storage.googleapis.com/room_images_bucket/room-image-135-rc-upload-1573656387617-6', 135, '2019-11-13 14:50:13.960786', NULL);
INSERT INTO `room_image` VALUES (384, 'https://storage.googleapis.com/room_images_bucket/room-image-136-rc-upload-1573656387617-8', 136, '2019-11-13 14:50:13.959176', NULL);
INSERT INTO `room_image` VALUES (385, 'https://storage.googleapis.com/room_images_bucket/room-image-135-rc-upload-1573656387617-4', 135, '2019-11-13 14:50:13.960298', NULL);
INSERT INTO `room_image` VALUES (386, 'https://storage.googleapis.com/room_images_bucket/room-image-136-rc-upload-1573656387617-11', 136, '2019-11-13 14:50:13.963386', NULL);
INSERT INTO `room_image` VALUES (387, 'https://storage.googleapis.com/room_images_bucket/room-image-135-rc-upload-1573656387617-5', 135, '2019-11-13 14:50:13.962567', NULL);
INSERT INTO `room_image` VALUES (388, 'https://storage.googleapis.com/room_images_bucket/room-image-135-rc-upload-1573656387617-3', 135, '2019-11-13 14:50:13.964506', NULL);
INSERT INTO `room_image` VALUES (389, 'https://storage.googleapis.com/room_images_bucket/room-image-137-rc-upload-1573656653125-4', 137, '2019-11-13 14:57:24.584180', NULL);
INSERT INTO `room_image` VALUES (390, 'https://storage.googleapis.com/room_images_bucket/room-image-137-rc-upload-1573656653125-6', 137, '2019-11-13 14:57:24.584073', NULL);
INSERT INTO `room_image` VALUES (391, 'https://storage.googleapis.com/room_images_bucket/room-image-137-rc-upload-1573656653125-2', 137, '2019-11-13 14:57:24.586247', NULL);
INSERT INTO `room_image` VALUES (392, 'https://storage.googleapis.com/room_images_bucket/room-image-137-rc-upload-1573656653125-5', 137, '2019-11-13 14:57:24.586818', NULL);
INSERT INTO `room_image` VALUES (393, 'https://storage.googleapis.com/room_images_bucket/room-image-138-rc-upload-1573669523703-5', 138, '2019-11-13 18:27:47.170975', NULL);
INSERT INTO `room_image` VALUES (394, 'https://storage.googleapis.com/room_images_bucket/room-image-138-rc-upload-1573669523703-3', 138, '2019-11-13 18:27:47.170798', NULL);
INSERT INTO `room_image` VALUES (395, 'https://storage.googleapis.com/room_images_bucket/room-image-138-rc-upload-1573669523703-4', 138, '2019-11-13 18:27:47.170766', NULL);
INSERT INTO `room_image` VALUES (396, 'https://storage.googleapis.com/room_images_bucket/room-image-138-rc-upload-1573669523703-2', 138, '2019-11-13 18:27:47.175957', NULL);
INSERT INTO `room_image` VALUES (397, 'https://storage.googleapis.com/room_images_bucket/room-image-139-rc-upload-1573707170100-2', 139, '2019-11-14 04:54:46.993531', NULL);
INSERT INTO `room_image` VALUES (398, 'https://storage.googleapis.com/room_images_bucket/room-image-139-rc-upload-1573707170100-5', 139, '2019-11-14 04:54:46.993416', NULL);
INSERT INTO `room_image` VALUES (399, 'https://storage.googleapis.com/room_images_bucket/room-image-139-rc-upload-1573707170100-4', 139, '2019-11-14 04:54:46.992234', NULL);
INSERT INTO `room_image` VALUES (400, 'https://storage.googleapis.com/room_images_bucket/room-image-139-rc-upload-1573707170100-3', 139, '2019-11-14 04:54:46.992107', NULL);
COMMIT;

-- ----------------------------
-- Table structure for saved_room
-- ----------------------------
DROP TABLE IF EXISTS `saved_room`;
CREATE TABLE `saved_room` (
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who saved the room',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of the saved room group',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`,`room_group_id`) USING BTREE,
  KEY `FK_room_group_saved_room` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group_saved_room` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`),
  CONSTRAINT `FK_user_saved_room` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service` (
  `service_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the service',
  `icon_id` varchar(50) DEFAULT NULL,
  `service_name` varchar(255) DEFAULT NULL COMMENT 'Name of the service',
  `description` text COMMENT 'Description of the service',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of service
-- ----------------------------
BEGIN;
INSERT INTO `service` VALUES (1, '1', 'Wifi', 'Internet access', '2019-10-23 12:18:47.727281', '2019-10-23 12:18:47.727281');
INSERT INTO `service` VALUES (2, '2', 'Điện', 'Giá điện', '2019-10-23 12:18:48.405884', '2019-10-23 12:18:48.405884');
INSERT INTO `service` VALUES (3, '3', 'Nước', 'Giá nước', '2019-10-23 12:18:49.143173', '2019-10-23 12:18:49.143173');
INSERT INTO `service` VALUES (4, '4', 'Bảo vệ', 'Bảo vệ vật tư', '2019-10-23 12:18:50.165008', '2019-10-23 12:18:50.165008');
INSERT INTO `service` VALUES (5, '5', 'Giặt đồ', 'Giặt quần áo', '2019-10-23 12:18:50.828194', '2019-10-23 12:18:50.828194');
INSERT INTO `service` VALUES (6, '6', 'Trông xe', 'Trông xe tại nhà', '2019-10-23 12:18:51.756663', '2019-10-23 12:18:51.756663');
INSERT INTO `service` VALUES (7, '7', 'Dọn vệ sinh', 'Dịch vụ dọn vệ sinh tận phòng', '2019-10-23 12:18:52.902631', '2019-10-23 12:18:52.902631');
COMMIT;

-- ----------------------------
-- Table structure for tenant_review
-- ----------------------------
DROP TABLE IF EXISTS `tenant_review`;
CREATE TABLE `tenant_review` (
  `review_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the review',
  `user_id` int(5) NOT NULL COMMENT 'ID of user who sends the review',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of reviewed room group',
  `comment` text COMMENT 'Content of the review',
  `accuracy_star` int(2) DEFAULT NULL COMMENT 'Rating stars for accuracy',
  `host_star` int(2) DEFAULT NULL COMMENT 'Rating stars for hosting',
  `security_star` int(2) DEFAULT NULL COMMENT 'Rating stars for security',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`review_id`) USING BTREE,
  KEY `FK_user_tenant_review` (`user_id`) USING BTREE,
  KEY `FK_room_group_review` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group_review` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`),
  CONSTRAINT `FK_user_tenant_review` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `transaction_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the transaction',
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who make the transaction',
  `room_id` int(5) NOT NULL COMMENT 'ID of room in the transaction',
  `transaction_status` tinyint(1) DEFAULT NULL COMMENT 'Status code of the transaction',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`transaction_id`) USING BTREE,
  KEY `FK_User_Transaction` (`user_id`) USING BTREE,
  KEY `FK_Room_Transaction` (`room_id`) USING BTREE,
  CONSTRAINT `FK_Room_Transaction` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`),
  CONSTRAINT `FK_User_Transaction` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the user',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'First name of the user',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Last name of the user',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'Phone number of the user',
  `password` varchar(255) DEFAULT NULL COMMENT 'Password of user',
  `role_admin` varchar(255) DEFAULT NULL COMMENT 'Role of account login admin page',
  `gender` bit(1) DEFAULT NULL COMMENT 'Gender of the user',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email of the user',
  `avatar` text COMMENT 'Avatar URL of the user',
  `address` text COMMENT 'Address of the user',
  `is_phone_number_verified` bit(1) DEFAULT NULL COMMENT 'User phone number is verified or not',
  `is_selfie_verified` bit(1) DEFAULT NULL COMMENT 'User selfie image is verified or not',
  `is_government_id_verified` bit(1) DEFAULT NULL COMMENT 'User government id card is verified or not',
  `is_verified` bit(1) DEFAULT NULL COMMENT 'User is verified or not',
  `is_host` bit(1) DEFAULT NULL COMMENT 'User is host or not',
  `is_active` bit(1) DEFAULT b'1' COMMENT 'User is active or not',
  `balance` double(20,0) unsigned DEFAULT '0' COMMENT 'Balance of user in system',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'Nguyễn Như', 'Thưởng', '+84986352227', '$2a$08$bnWk.ogxlGO.px6ohFd1WO0.Cghq2KFQ6GO9Z/5pVzlHdlvMWzVIu', 'admin', NULL, 'your_email_1@example.com', 'https://firebasestorage.googleapis.com/v0/b/hovi-dev.appspot.com/o/default_avatar.png?alt=media&token=ac1a882c-c8ad-47c2-9c2d-f85ab0c1d79b', 'not yet', b'1', NULL, NULL, NULL, NULL, b'1', 0, '2019-11-13 08:31:27.557877', '2019-11-13 14:47:35.380551');
INSERT INTO `user` VALUES (15, 'Nguyễn', 'Hoàng', '+84378666519', '$2a$08$5n3kFshjhI.3PqeusnHksefEJ2XNkNKkopocvmtvitHI2F6YfEAm2', NULL, NULL, 'your_email_303@example.com', 'https://firebasestorage.googleapis.com/v0/b/hovi-dev.appspot.com/o/default_avatar.png?alt=media&token=ac1a882c-c8ad-47c2-9c2d-f85ab0c1d79b', 'not yet', b'1', NULL, NULL, NULL, NULL, b'1', 0, '2019-11-13 15:13:03.579070', '2019-11-13 15:14:31.405148');
INSERT INTO `user` VALUES (16, 'Hoàng Lê Thanh', 'Sơn', '+84982604182', '$2a$08$5I1pVXjFlNiCKwlzMN5HruULi1XEmpThJgueZzKQj/PradYgU.2k6', NULL, NULL, 'your_email_393@example.com', 'https://firebasestorage.googleapis.com/v0/b/hovi-dev.appspot.com/o/default_avatar.png?alt=media&token=ac1a882c-c8ad-47c2-9c2d-f85ab0c1d79b', 'not yet', b'1', NULL, NULL, NULL, NULL, b'1', 0, '2019-11-13 15:16:20.430927', '2019-11-13 15:16:30.640439');
INSERT INTO `user` VALUES (18, 'Phạm Tùng', 'Anh', '+84778364588', '$2a$08$EM2xDcN2PbN61wxkyUiFJuFEhP/r0X01z52/MiShD5TgEfTdafuUK', NULL, NULL, 'your_email_392@example.com', 'https://firebasestorage.googleapis.com/v0/b/hovi-dev.appspot.com/o/default_avatar.png?alt=media&token=ac1a882c-c8ad-47c2-9c2d-f85ab0c1d79b', 'not yet', b'1', NULL, NULL, NULL, NULL, b'1', 0, '2019-11-13 15:19:39.776997', '2019-11-13 15:21:58.822217');
INSERT INTO `user` VALUES (21, 'Đinh Đức', 'Việt', '+84386666428', '$2a$08$InYf4/Fw9SSzuwFZjOZ1PugPRZKzROs3gjN4AQsbMjh4eKS4grXXG', NULL, NULL, 'your_email_21@example.com', 'https://firebasestorage.googleapis.com/v0/b/hovi-dev.appspot.com/o/default_avatar.png?alt=media&token=ac1a882c-c8ad-47c2-9c2d-f85ab0c1d79b', 'not yet', b'1', NULL, NULL, NULL, NULL, b'1', 0, '2019-11-13 15:31:15.343005', '2019-11-13 15:33:26.112185');
INSERT INTO `user` VALUES (22, 'A', 'Hihi', '+84367120251', '$2a$08$75fsq.dStbaxwmV.tZGyb.rfIaWpZxvudsdp9Lvagri3QTbiE0eCm', NULL, NULL, 'your_email_22@example.com', 'https://firebasestorage.googleapis.com/v0/b/hovi-dev.appspot.com/o/default_avatar.png?alt=media&token=ac1a882c-c8ad-47c2-9c2d-f85ab0c1d79b', 'not yet', b'1', NULL, NULL, NULL, NULL, b'1', 0, '2019-11-13 15:32:47.408454', '2019-11-13 15:33:26.702295');
COMMIT;

-- ----------------------------
-- Table structure for user_verification_image
-- ----------------------------
DROP TABLE IF EXISTS `user_verification_image`;
CREATE TABLE `user_verification_image` (
  `card_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the user card',
  `user_id` int(5) NOT NULL COMMENT 'ID of the user',
  `id_card_front_url` text COMMENT 'URL to the front side of the ID Lisence Card image',
  `id_card_back_url` text COMMENT 'URL to the back side of the ID Lisence Card image',
  `selfie_url` text COMMENT 'URL to the selfie image of the user',
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`card_id`) USING BTREE,
  KEY `FK_user_verification` (`user_id`) USING BTREE,
  CONSTRAINT `FK_user_verification` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `before_insert_user`;
delimiter ;;
CREATE TRIGGER `before_insert_user` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
	SET @user_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = "HoviDB" AND TABLE_NAME = "user");
	SET @email = CONCAT('your_email_',@user_id, '@example.com');
	SET new.email = @email;
	SET new.address = 'not yet';
	SET new.avatar = 'https://firebasestorage.googleapis.com/v0/b/hovi-dev.appspot.com/o/default_avatar.png?alt=media&token=ac1a882c-c8ad-47c2-9c2d-f85ab0c1d79b';
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
