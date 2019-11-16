/*
 Navicat Premium Data Transfer

 Source Server         : CP_DB
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3307
 Source Schema         : HoviDB

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 16/11/2019 20:30:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for amenities
-- ----------------------------
DROP TABLE IF EXISTS `amenities`;
CREATE TABLE `amenities`  (
  `amenities_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of amenities',
  `icon_id` varchar(50) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'id of icon show UI',
  `usable_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of amenities when usable',
  `unusable_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of amenities when unusable',
  `description` text CHARACTER SET utf8mb4  NULL COMMENT 'Description for amenities',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`amenities_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of amenities
-- ----------------------------
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

-- ----------------------------
-- Table structure for bank_transfer_history
-- ----------------------------
DROP TABLE IF EXISTS `bank_transfer_history`;
CREATE TABLE `bank_transfer_history`  (
  `transfer_id` int(4) NOT NULL AUTO_INCREMENT COMMENT 'ID of the bank transferation',
  `sender_user_id` int(5) NULL DEFAULT NULL COMMENT 'Sender user id',
  `sender_bank` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Bank of sender',
  `sender_account_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Sender account number',
  `sender_user_type` tinyint(1) NULL DEFAULT NULL COMMENT 'Sender user type',
  `receiver_user_id` int(5) NULL DEFAULT NULL COMMENT 'Receiver user id',
  `receiver_bank` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Bank of receiver',
  `receiver_account_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Receiver account number',
  `receiver_user_type` tinyint(1) NULL DEFAULT NULL COMMENT 'Receiver user type',
  `transfer_time` timestamp(6) NULL DEFAULT NULL COMMENT 'Time of transferation',
  `money_amount` double(10, 0) NULL DEFAULT NULL COMMENT 'Money amount of the transfer',
  `transfer_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Note of transfer',
  `transfer_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Code of the transfer',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`transfer_id`) USING BTREE,
  INDEX `FK_user_bank_transfer_history-sender_id`(`sender_user_id`) USING BTREE,
  INDEX `FK_user_bank_transfer_history-receiver_id`(`receiver_user_id`) USING BTREE,
  CONSTRAINT `FK_user_bank_transfer_history-receiver_id` FOREIGN KEY (`receiver_user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_bank_transfer_history-sender_id` FOREIGN KEY (`sender_user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bank_transfer_history
-- ----------------------------
INSERT INTO `bank_transfer_history` VALUES (1, 1, 'SGD NHNN VIET NAM', '00000034002', 1, 5, 'TPBank', '02725034001', 3, '2019-03-11 00:00:00.000000', 1500000, 'DATCOC-1', NULL, '2019-11-05 09:46:25.934443', '2019-11-05 09:46:25.934443');
INSERT INTO `bank_transfer_history` VALUES (2, 2, 'SGD NHNN VIET NAM', '00000034005', 1, 5, 'TPBank', '02725034001', 3, '2019-03-11 00:00:00.000000', 1500000, 'DATCOC-3', NULL, '2019-11-05 09:46:33.304627', '2019-11-05 09:46:33.304627');
INSERT INTO `bank_transfer_history` VALUES (7, -1, 'SGD NHNN VIET NAM', '00000034002', 1, 5, 'TPBank', '02725034001', 3, '2019-05-11 00:00:00.000000', 1500000, 'DATCOC.1', NULL, NULL, NULL);
INSERT INTO `bank_transfer_history` VALUES (8, -1, 'SGD NHNN VIET NAM', '00000034002', 1, 5, 'TPBank', '02725034001', 3, '2019-05-11 00:00:00.000000', 1500000, 'DATCOC-100', NULL, NULL, NULL);
INSERT INTO `bank_transfer_history` VALUES (14, -1, 'SGD NHNN VIET NAM', '00000034002', 1, 5, 'TPBank', '02725034001', 3, '2019-09-11 00:00:00.000000', 1500000, 'DATCOC.1', NULL, NULL, NULL);
INSERT INTO `bank_transfer_history` VALUES (15, -1, 'SGD NHNN VIET NAM', '00000034002', 1, 5, 'TPBank', '02725034001', 3, '2019-09-11 00:00:00.000000', 1500000, 'DATCOC-100', NULL, NULL, NULL);
INSERT INTO `bank_transfer_history` VALUES (16, 4, 'SGD NHNN VIET NAM', '00000034002', 1, 5, 'TPBank', '02725034001', 3, '2019-12-11 00:00:00.000000', 5000000, 'DATCOC-17', NULL, NULL, NULL);
INSERT INTO `bank_transfer_history` VALUES (17, -1, 'SGD NHNN VIET NAM', '00000034002', 1, 5, 'TPBank', '02725034001', 3, '2019-12-11 00:00:00.000000', 5000000, 'DATCOC.17', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `building_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of building',
  `building_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'name of the building',
  `building_type_id` int(2) NULL DEFAULT NULL COMMENT 'ID of building type',
  `is_mix_gender` bit(1) NULL DEFAULT NULL COMMENT 'Male and female can stays in the same room or not',
  `host_id` int(11) NULL DEFAULT NULL COMMENT 'ID of host of building',
  `province` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT 'default value' COMMENT 'Province of the building',
  `district` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'District of the building',
  `ward` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Ward of the building',
  `street` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Street of the building',
  `detailed_address` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Detailed address of the building',
  `address_description` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL,
  `location` text CHARACTER SET utf8mb4  NULL COMMENT 'Location of the building',
  `floor_quantity` int(2) NULL DEFAULT NULL COMMENT 'Number of floors in the building',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'Building is verified or not',
  `is_completed` int(1) NULL DEFAULT NULL COMMENT 'Number of completed steps in posting a room',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`building_id`) USING BTREE,
  INDEX `FK_room_type_building`(`building_type_id`) USING BTREE,
  INDEX `FK_user_building`(`host_id`) USING BTREE,
  CONSTRAINT `FK_type_building` FOREIGN KEY (`building_type_id`) REFERENCES `building_type` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_building` FOREIGN KEY (`host_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES (1, 'happy building', 1, b'1', 1, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', 'Tran Duy Hung', 'Detailed Hanoi', NULL, 'Hanoi location', 3, b'1', 0, '2019-11-02 13:54:02.079330', '2019-11-02 13:54:02.079330');
INSERT INTO `building` VALUES (2, 'new building', 1, b'1', 1, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', 'Nguyen Luong Bang', 'Detailed Hanoi', NULL, 'Hanoi location', 3, b'1', 0, '2019-11-02 13:54:03.064471', '2019-11-02 13:54:03.064471');
INSERT INTO `building` VALUES (3, '3rd building', 1, b'1', 1, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', 'Lang Ha', 'Detailed Hanoi', NULL, 'Hanoi location', 3, b'1', 0, '2019-11-02 13:54:03.748599', '2019-11-02 13:54:03.748599');
INSERT INTO `building` VALUES (4, 'Nhà trọ Thành Công', 3, b'1', 1, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', 'Định Công Hạ', '96A Định Công', NULL, '20.98470977059105,105.83861725767213', 4, NULL, 1, '2019-11-02 13:54:04.361796', '2019-11-02 13:54:04.361796');
INSERT INTO `building` VALUES (5, 'Chung cư an khánh', 1, b'1', 4, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', NULL, '12 giai phong', NULL, '20.9714041,105.8409441', NULL, NULL, NULL, '2019-11-02 13:54:05.921972', '2019-11-02 13:54:05.921972');
INSERT INTO `building` VALUES (6, 'Chung cư An Khánh', 1, b'0', 4, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', NULL, '12 quang trung ha dong', NULL, '20.9462691,105.7438515', NULL, NULL, NULL, '2019-11-02 13:54:05.195791', '2019-11-02 13:54:05.195791');
INSERT INTO `building` VALUES (7, 'Chung cư An Nam', 1, NULL, 4, '[\"Hà Nội\",2]', '[\"Bắc Từ Liêm\",27]', '[\"Xuân Đỉnh\",7572]', NULL, '12 giai phong', '', '20.9714041,105.8409441', 23, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (8, 'Chung cư Vincom City', 1, NULL, 4, '[\"Hà Nội\",1]', '[\"Nam Từ Liêm\",18]', '[\"Mỹ Đình 2\",2021]', NULL, '12 mỹ đình', '', '21.0295126,105.7790821', 16, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (9, 'Nhà trọ Thái Luyện', 3, NULL, 4, '[\"Hà Nội\",1]', '[\"Cầu Giấy\",4]', '[\"Mai Dịch\",264]', NULL, '12 nguyen phong sac', '', '21.044239,105.790373', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (10, 'Nhà trọ Định Mệnh', 3, NULL, 4, '[\"Hà Nội\",1]', '[\"Nam Từ Liêm\",18]', '[\"Phú Đô\",2022]', NULL, '12 phu do', '', '21.0079443,105.7667015', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (12, 'Happy House', 1, NULL, 8, '[\"Hà Nội\",1]', '[\"Cầu Giấy\",4]', '[\"Nghĩa Đô\",265]', NULL, 'Quận 9, Hồ Chí Minh, Campuchia', 'Vừng ơi mở ra', '10.8428402,106.8286851', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (13, 'Chung cư Văn Minh', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Trương Định\",1090]', NULL, '78 Trương Định, Hai Bà Trưng, Hà Nội, Việt Nam', 'Nhà mặt đường', '20.993988,105.849651', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (14, 'Happy House', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, '163 Đại La, Đồng Tâm, Hai Bà Trưng, Hà Nội, Việt Nam', 'Rẽ trái cạnh siêu thi Vinmart', '20.9966682,105.8446902', 5, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (15, 'Full House', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Minh Khai\",1081]', NULL, '505 Phố Minh Khai, Vĩnh Phú, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi phố Minh Khai xong rẽ trái vào ngõ', '20.9998197,105.8703171', 6, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (16, 'Chung cư tầng 6 Vincom Bà Triệu', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', NULL, '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Việt Nam', 'Tòa nhà VinCom Bà Triệu', '21.0114461,105.8500128', 6, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (17, 'Chung cư tầng 7 Vincom Bà Triệu', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', NULL, '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Việt Nam', 'Tòa nhà Vincom Bà Triệu', '21.0114461,105.8500128', 7, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (18, 'Chung cư Mới', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Trương Định\",1090]', NULL, '1 Phố Minh Khai, Trương Định, Hai Bà Trưng, Hà Nội, Việt Nam', 'Chung cư mới xây mặt đường Trương Định', '20.9959189,105.8503406', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (19, 'Vintage Building', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Trương Định\",1090]', NULL, '440 Bạch Mai, Trương Định, Hai Bà Trưng, Hà Nội, Việt Nam', 'Tòa nhà kiểu Pháp trên mặt đường Bạch Mai', '20.9985581,105.8501943', 5, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (20, 'Nhà Mới', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bách Khoa\",1073]', NULL, '99 Trần Đại Nghĩa, Bách Khoa, Hai Bà Trưng, Hà Nội, Việt Nam', 'Gần đối diện cổng parabol trường Bách Khoa', '21.0040558,105.8454565', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (21, 'Nhà nguyên căn Trần Đại Nghĩa', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, '2A Trần Đại Nghĩa, Đồng Tâm, Hai Bà Trưng, Hà Nội, Việt Nam', 'Cạnh quán bánh gato trên đường Trần Đại Nghĩa', '21.0035271,105.8446348', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (22, 'Nhà cấp bốn Tạ Quang Bửu', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bách Khoa\",1073]', NULL, 'A15 Tạ Quang Bửu, Bách Khoa, Hai Bà Trưng, Hà Nội, Việt Nam', 'Nhà mặt đường màu xanh', '21.0043602,105.847327', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (23, 'Căn hộ Kim Ngưu', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Vĩnh Tuy\",1091]', NULL, '461 Kim Ngưu, Vĩnh Tuy, Hai Bà Trưng, Hà Nội, Việt Nam', 'Cạnh quán vịt quay Lạng Sơn Kim Ngưu', '21.0007085,105.8620677', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (24, 'Lucky Apts', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', NULL, '221 Thanh Nhàn, Quỳnh Lôi, Hai Bà Trưng, Hà Nội, Việt Nam', 'Như địa chỉ chi tiết', '21.002988,105.8547817', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (25, 'Căn hộ trong ngõ', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', NULL, 'Số 112 Phố Lạc Nghiệp, Thanh Nhàn, Hai Bà Trưng, Hà Nội 100000, Việt Nam', 'Trong ngõ Lạc Nghiệp', '21.0080036,105.8570593', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (26, 'Rental Apartment', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Minh Khai\",1081]', NULL, '545 Phố Minh Khai, Vĩnh Phú, Hai Bà Trưng, Hà Nội, Việt Nam', 'Căn hộ mặt đường', '21.001197,105.8703589', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (27, 'Cozy house', 2, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Vĩnh Tuy\",1091]', NULL, '55 Lạc Trung, Vĩnh Tuy, Hai Bà Trưng, Hà Nội, Việt Nam', '', '21.0028675,105.8664958', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (28, 'Homestay vui vẻ', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Thanh Xuân\",28]', '[\"Nhân Chính\",2631]', NULL, '301d Quan Nhân', 'Cạnh tiệm cắt tóc 301 Quan Nhân', '21.007151,105.811867', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (29, 'Nhà trọ Tây Thiên 1', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', NULL, 'Số 10 ngõ 252 Tây Sơn', 'Gần đại học Thủy Lợi', '21.0080465,105.8225565', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (30, 'Nhà Trọ Tây Thiên 2', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', NULL, 'Số 1/43 ngõ Thanh Miến, Phố Văn Miếu, Phường Văn Miếu, Đống Đa, Hà Nội', '', '21.0294096,105.8375543', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (31, 'Nhà cho hotboy', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Cát Linh\",596]', NULL, 'Ngõ 35 ', 'Đối diện đường ray Cát Linh', '21.0290796,105.8285339', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (32, 'Nhà trọ Tây Thiên 3', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', NULL, 'Số 12  ngõ 7 ngách 25 Thái Hà', '', '21.010993,105.821965', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (33, 'Nhà trọ Tây Thiên 4', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', NULL, 'Số 5 ngõ 3 Thái hà', 'Ngay đầu ngõ', '21.009462,105.8228194', 5, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (34, 'Nhà Trọ Tây Thiên 5', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Trung Liệt\",612]', NULL, 'Sô 5 ngõ 7 Thái Hà', 'Nhà cao nhất ngõ', '21.0102583,105.8222383', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (35, 'Khu trọ FA', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Cát Linh\",596]', NULL, 'ngõ số 6 Hàng Cháo', '', '21.030906,105.834197', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (36, 'Nhà trọ Bắc Môn 1', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', NULL, 'Số 3 ngõ thổ quan  Tôn Đức Thắng ', 'Nhà đẹp nhất ', '21.0207622,105.8301109', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (37, 'Nhà trọ Bắc Môn 2', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'Số 14 ngõ 252 Tây Sơn', '', '21.0080465,105.8225565', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (38, 'Khu trọ zdui vẻ', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Cát Linh\",596]', NULL, 'ngõ số 16 Cát Linh', 'Đến đầu ngõ đi thẳng, rẽ phải đối diện quán bán cháo', '21.0276156,105.8339147', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (39, 'Nhà Trọ Bắc Môn 3', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'Sô 4 ngõ 12/12 Nguyễn Phúc Lai, Đống Đa', '', '21.022445,105.822028', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (40, 'Nhà đẹp sweet home', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Hàng Bột\",597]', NULL, 'Số 36B ngõ Văn Chương', '', '21.0234345,105.8325658', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (41, 'Nhà Trọ Bắc Môn 4', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'số 10, ngách 66, ngõ giếng, phố Đông Các', '', '21.0189275,105.8266735', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (42, 'Khu trọ 4.0', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', NULL, 'Ngõ 1 ', '125', '21.0216972,105.8299504', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (43, 'Nhà trọ bác Kim', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', NULL, 'Phố Khâm Thiên', 'Đối diện Welax', '21.0193276,105.8355011', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (44, 'Nhà trọ chú Sơn', 3, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Lương\",1088]', NULL, '16 Lạc Trung, Thanh Lương, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi vào ngõ hỏi nhà trọ chú Sơn', '21.0031073,105.8619436', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (45, 'Nhà trọ bác Anh', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', NULL, 'Ngõ 42 Vũ Ngọc Phan ', '', '21.0148813,105.8103552', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (46, 'Nhà trọ khu Bách Khoa', 3, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bách Khoa\",1073]', NULL, '14/40 Tạ Quang Bửu, Bách Khoa, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi vào trong ngõ của siêu thị', '21.0040972,105.8471699', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (47, 'Nhà trọ anh Tùng', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', NULL, 'Ngõ 100 phố Vương Thừa Vũ', '', '21.0003741,105.8233757', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (48, 'Nhà trọ Bạch Đằng', 3, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bạch Đằng\",1072]', NULL, '18 Vân Đồn, Bạch Đằng, Hai Bà Trưng, Hà Nội, Việt Nam', 'Đi vào ngõ 18 50m', '21.014458,105.865252', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (49, 'Nhà trọ Tùng Anh', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', NULL, 'ngõ 99 Nguyễn Chí Thanh', '', '21.0173028,105.80798', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (50, 'Nhà trọ Quỳnh Mai', 3, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Mai\",1087]', NULL, '284 Kim Ngưu, Quỳnh Mai, Hai Bà Trưng, Hà Nội, Việt Nam', 'Cạnh chợ Quỳnh Mai', '20.999146,105.86152', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (51, 'Nhà trọ Tùng Sơn', 3, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', NULL, '68 phố Chùa Láng', '', '21.0227154,105.8094064', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (52, 'Chung cư Emperial', 1, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', NULL, 'Sky City Tower 88', '', '21.0124824,105.8112754', 16, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (53, 'Chung cư vip', 1, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Hạ\",601]', NULL, ' Sky City', '', '21.0124824,105.8112754', 23, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (54, 'Nhà 4 tầng ', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ngã Tư Sở\",604]', NULL, 'Ngã tư sở', 'Gần đoạn trường chinh\n', '21.004722,105.8220581', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (55, 'Nhà Trọ Bắc Môn 5', 3, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'Số 5 ngõ 43 Xã Đàn', '', '21.0175738,105.8300282', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (56, 'Chung cơ Lardmark', 1, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, '275 xã đàn', '', '21.0174298,105.8303724', 22, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (57, 'Chung cư Hào Nam 1', 1, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'số 6 ngõ 137, Hào Nam', '', '21.025495,105.8269197', 14, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (58, 'Chung cơ Nam Tiến 1', 1, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'số 224 Mai Anh Tuấn', '', '21.0181412,105.8238215', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (59, 'Chung cư Hào Nam 2', 1, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, '73 nguyễn lương bằng', '', '21.0170574,105.8291695', 8, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (60, 'Chung cư D\'. Le Pont D\'or 1', 1, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, '36 Hoàng Cầu', '', '21.0201135,105.8238057', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (61, 'Chung cư Nam Tiến 2', 1, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, '360 xã đàn', '', '21.0147164,105.8345383', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (62, 'Chung cư Đông Mạc', 1, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, '36 Hoàng Cầu', '', '21.0201135,105.8238057', 18, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (63, 'Nhà Nguyên Căn Chùa Bộc', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'Số 3 ngõ 43 Chùa Bộc', '', '21.006847,105.8297259', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (64, 'Nhà Tôn Thất Tùng', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'CCMN 2A/37 ngõ 72 Tôn Thất Tùng', '', '21.0017883,105.8284159', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (65, 'Nhà Thái Hà', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'Số 35A ngõ 7 Thái Hà', '', '21.0095107,105.8216074', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (66, 'Nhà Nguyên căn Thái Hà', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'số 20 ngõ 252 Tây Sơn', '', '21.0080465,105.8225565', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (67, 'Nhà Nguyên Căn', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'Số 12 ngõ 580 Trường Chinh.', '', '21.0027279,105.822348', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (68, 'Nguyên Căn TTT', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'số 2c/7 ngõ 22 Tôn Thất Tùng', '', '21.0025867,105.8289767', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (69, 'Nguyên Căn', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khâm Thiên\",598]', NULL, 'Ngõ 131B Tôn Đức Thắng', '', '21.026802,105.833911', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (70, 'Nguyên Căn TQ', 2, NULL, 9, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Thổ Quan\",611]', NULL, 'Số 75E ngõ Thổ Quan', '', '21.019053,105.833834', 5, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (71, 'Nhà nguyên căn mặt phố', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, ' Ngõ Thịnh Hào 1', '', '21.023636,105.831766', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (72, 'Chung cư NEU', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, '107-H50, ngách 27 Ngõ 41 Phố Vọng, Đồng Tâm, Hai Bà Trưng, Hà Nội 100000, Việt Nam', 'sau ĐHKTQD', '20.9992372,105.8425979', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (73, 'Chung cư Trường Chinh', 1, NULL, 7, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, 'Ngõ 128C - Đại La, Đồng Tâm, Hai Bà Trưng, Hà Nội, Việt Nam', '', '20.9975923,105.8433884', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (74, 'Chung cư vip Tower City', 1, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, 'Phố Tôn Thất Tùng', '', '21.0032249,105.8306606', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (75, 'Khu chung cư bác Tùng', 1, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Khương Thượng\",599]', NULL, '252 tây sơn', '', '21.0080465,105.8225565', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (76, 'Chung cư mini tiện lợi', 1, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, '23 PHỐ ĐÔNG CÁC', '', '21.0184963,105.8288692', 7, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (77, 'Chung cư siêu siêu cấp', 1, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'Hoàng Cầu SkyLine', '', '21.0185264,105.8241049', 8, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (78, 'Chung cư cho người yêu anime', 1, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'HOÀNG CẦU VÕ VĂN DŨNG', '', '21.016252,105.823067', 5, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (79, 'Nhà tình thương ', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'Mai Anh Tuấn', '', '21.0182026,105.8237164', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (80, 'Nhà nguyên căn chất lượng ', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'Trần Quang Diệu , ngõ 19 ', '', '21.0157618,105.8250225', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (81, 'Nhà nguyên căn Ô chợ dừa', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Ô Chợ Dừa\",605]', NULL, 'ngõ 9 Hoàng Cầu', '', '21.0192007,105.8265637', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (82, 'Nhà nguyên căn 9 tầng Hà Nội', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Thượng\",602]', NULL, 'NGÕ 898 đường láng', '', '21.0211631,105.80173', 9, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (83, 'Nhà đẹp 3 tầng', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Thượng\",602]', NULL, ' 157 Pháo Đài Láng', '', '21.0182122,105.804095', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (84, 'Nhà cho thuê - ĐIểm đến cho cặp vợ chồng mới cưới', 2, NULL, 10, '[\"Hà Nội\",1]', '[\"Đống Đa\",8]', '[\"Láng Thượng\",602]', NULL, 'ngõ 121 Chùa Láng', '', '21.0232387,105.8045483', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (85, 'CHUYÊN CHO THUÊ CĂN HỘ 2,3 ,4 NGỦ TẠI SUNANCORA ', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đống Mác\",1077]', NULL, 'Bạch Đằng, Hai Bà Trưng District, Hanoi, Vietnam', 'Bạch Đằng, Hai Bà Trưng District, Hanoi, Vietnam', '21.0094412,105.8603338', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (86, ' CĂN HỘ 2, 3 PHÒNG NGỦ TẠI IMPERIA SKY GARDEN', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', NULL, 'Tầng 6, Số 101, Mai Hắc Đế, Phường Bùi Thị Xuân, Quận Hai Bà Trưng, Bùi Thị Xuân, Hai Bà Trưng, Hà Nội, Vietnam', 'Tầng 6, Số 101, Mai Hắc Đế, Phường Bùi Thị Xuân, Quận Hai Bà Trưng, Bùi Thị Xuân, Hai Bà Trưng, Hà Nội, Vietnam', '21.014602,105.851067', 6, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (87, 'Chính chủ cho thuê sàn tầng 1 số nhà 249, ngõ Quỳnh, Thanh Nhàn', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bùi Thị Xuân\",1075]', NULL, 'Ngõ Quỳnh, Đường Thanh Nhàn, Phường Quỳnh Lôi, Hai Bà Trưng, Hà Nội', 'Không có nhu cầu sử dụng chính chủ cần cho thuê sàn tầng 1, DT 64m2, chi tiết:\n- Diện tích sử dụng 64 m2, gồm 3 phòng: 1 phòng ngủ, 1 phòng bếp, 1 phòng khách rộng có thể kết hợp thành phòng ngủ, 1 vệ sinh.\n- Nội thất cơ bản: Bếp, nóng lạnh, điều hòa.\n- Đ', '21.0028517,105.8543947', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (88, 'Có phòng cho thuê khép kín giá 3tr - 3,5tr - 4 tr', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Ngô Thì Nhậm\",1082]', NULL, '188 Bà Triệu, Nguyễn Du, Hai Bà Trưng, Hà Nội, Vietnam', '188 Bà Triệu, Nguyễn Du, Hai Bà Trưng, Hà Nội, Vietnam', '21.016055,105.849207', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (89, 'Duplex Lò Đúc 170m² 3 PN', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, '5 Trần Thánh Tông, Bạch Đằng, Hai Bà Trưng, Hà Nội, Vietnam', '5 Trần Thánh Tông, Bạch Đằng, Hai Bà Trưng, Hà Nội, Vietnam', '21.0148919,105.8596521', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (90, 'Căn hộ Quận Hai Bà Trưng 80m² 2PN', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Ngô Thì Nhậm\",1082]', NULL, '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Vietnam', '191 Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội, Vietnam', '21.0114461,105.8500128', 4, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (91, 'Cho sinh viên thuê', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bùi Thị Xuân\",1075]', NULL, '120 Bùi Thị Xuân', '10C ngõ 109, Đường Đê Trần Khát Chân, Phường Thanh Lương, Quận Hai Bà Trưng, Hà Nội', '21.0137487,105.8500528', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (92, 'Tin Môi giới đăng 3 ngày trước CCMN 76B/5 ngõ 209 Bạch Mai 4-5tr Full đồ', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bùi Thị Xuân\",1075]', NULL, '	 76B/5 ngõ 209, Đường Bạch Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '	\n76B/5 ngõ 209, Đường Bạch Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '20.9989516,105.8503348', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (93, 'Căn chung cư Hai Bà Trưng', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Mai\",1087]', NULL, 'phố 8/3, Phường Quỳnh Mai, Quận Hai Bà Trưng, Hà Nội', 'phố 8/3, Phường Quỳnh Mai, Quận Hai Bà Trưng, Hà Nội', '20.9994048,105.8593784', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (94, 'Cho thuê căn hộ tầng 5 tập thể A7', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bạch Mai\",1074]', NULL, '390 Bùi Ngọc Dương', 'Phòng 508 - Tập thể A7, Đường Bùi Ngọc Dương, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '21.002816,105.85383', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (95, 'Bán nhà phố Thanh Nhàn, diện tích 46m2 x 5 tầng', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Nguyễn Du\",1083]', NULL, '370 Trần Khát Chân, Street, Hai Bà Trưng, Hà Nội, Vietnam', '370 Trần Khát Chân, Street, Hai Bà Trưng, Hà Nội, Vietnam', '21.0087535,105.8615518', 2, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (96, 'Cho Thuê Căn Hộ Khu Trần Khát Trân ', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Nhàn\",1089]', NULL, '119 Kim Ngưu', '119, Đường Kim Ngưu, Phường Thanh Nhàn, Quận Hai Bà Trưng, Hà Nội', '21.0068746,105.8614659', 3, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (97, ' (ID:8483504) Phường Thống Nhất, Thành phố Biên Hòa 60 m2 2 2 ₫ 10 triệu Chia sẻ  https://www.muabannhadat.vn/tin-dang/cho-thue-can-ho-2-phong-ngu-thanh-pho-bien-hoa-8483504?utm_source=copy-paste&utm_medium=crm&utm_campaign=share-button THÔNG TIN CƠ BẢN N', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, 'số 55 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội, Vietnam', 'số 55 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội, Vietnam', '21.0033135,105.8433207', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (98, 'BÁN NHÀ HAI BÀ TRƯNG, 65M, NGÕ THÔNG KHẮP NGẢ.', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Thanh Lương\",1088]', NULL, ' Đường Lê Thanh Nghị, Phường Đồng Tâm, Quận Hai Bà Trưng, Hà Nội', '	\nĐường Lê Thanh Nghị, Phường Đồng Tâm, Quận Hai Bà Trưng, Hà Nội', '21.0011348,105.8423124', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (99, 'Đường Thanh Nhàn, Phường Quỳnh Lôi, Quận Hai Bà Trưng, Hà Nội', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, 'Bach Khoa, Hai Bà Trưng District, Hanoi, Vietnam', 'Bach Khoa, Hai Bà Trưng District, Hanoi, Vietnam', '21.0048067,105.8453406', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (100, 'Đẹp ở luôn Minh Khai Hai BàTrưng', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Mai\",1087]', NULL, 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '20.9975552,105.8652828', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (101, 'Phòng ở ghép Trần đại nghĩa, Quận Hai Bà Trưng', 3, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', NULL, '34 Trần đại nghĩa, Phường Đồng Tâm', '34 Trần đại nghĩa, Phường Đồng Tâm', '21.0023697,105.8446542', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (102, 'Phòng cho thuê giá rẻ', 3, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Lê Đại Hành\",1080]', NULL, '	 Đường Lê Thanh Nghị, Phường Bách Khoa, Quận Hai Bà Trưng, Hà Nộ', '	\nĐường Lê Thanh Nghị, Phường Bách Khoa, Quận Hai Bà Trưng, Hà Nộ', '21.0094412,105.8603338', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (103, 'Nhà trọ giá rẻ cho sinh viên Bách khoa', 3, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Nguyễn Du\",1083]', NULL, 'ường Lê Ngọc Hân, Phường Phạm Đình Hổ, Quận Hai Bà Trưng, Hà Nội', 'ường Lê Ngọc Hân, Phường Phạm Đình Hổ, Quận Hai Bà Trưng, Hà Nội', '21.015609,105.855239', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (104, 'Cho thuê căn hộ sang trọng', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đồng Tâm\",1079]', NULL, 'Đường Đê Trần Khát Chân, Phường Phố Huế, Quận Hai Bà Trưng, Hà Nội', 'Đường Đê Trần Khát Chân, Phường Phố Huế, Quận Hai Bà Trưng, Hà Nội', '21.0094412,105.8603338', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (105, 'Cho thuê căn hộ siêu sang -Hai Ba Trưng', 2, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Bạch Đằng\",1072]', NULL, '197, Đường Minh Khai, Phường Thanh Nhàn, Quận Hai Bà Trưng, Hà Nội', '197, Đường Minh Khai, Phường Thanh Nhàn, Quận Hai Bà Trưng, Hà Nội', '20.9955533,105.8596066', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (106, 'Nhà trọ cho sinh viên gần bách khoa', 3, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Nguyễn Du\",1083]', NULL, 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', 'Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '20.9975552,105.8652828', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (107, 'cho thuê chung cư quận Hai bà trưng', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Quỳnh Lôi\",1086]', NULL, '	 Đường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '	\nĐường Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Hà Nội', '20.9975552,105.8652828', 1, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (108, 'Cho thuê chung cư gia đình', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Hai Bà Trưng\",11]', '[\"Đống Mác\",1077]', NULL, 'Đường Hồng Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', 'Đường Hồng Mai, Phường Bạch Mai, Quận Hai Bà Trưng, Hà Nội', '20.9988954,105.8532977', 16, NULL, NULL, NULL, NULL);
INSERT INTO `building` VALUES (109, 'cho thuê căn hộ gần đại học bách khóa', 1, NULL, 11, '[\"Hà Nội\",1]', '[\"Sóc Sơn\",22]', '[\"Phù Linh\",2288]', NULL, '	 Đường Nguyễn An Ninh, Phường Trương Định, Quận Hai Bà Trưng, Hà Nội', '	\nĐường Nguyễn An Ninh, Phường Trương Định, Quận Hai Bà Trưng, Hà Nội', '20.9911093,105.8446343', 34, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for building_service
-- ----------------------------
DROP TABLE IF EXISTS `building_service`;
CREATE TABLE `building_service`  (
  `building_id` int(5) NOT NULL COMMENT 'ID of the building',
  `service_id` int(5) NOT NULL COMMENT 'ID of the service in the building',
  `service_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Price of service',
  `note` text CHARACTER SET utf8mb4  NULL COMMENT 'Note for building service',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`building_id`, `service_id`) USING BTREE,
  INDEX `FK_service`(`service_id`) USING BTREE,
  CONSTRAINT `FK_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building_service
-- ----------------------------
INSERT INTO `building_service` VALUES (1, 1, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (1, 3, 20000, NULL, '2019-10-16 15:59:50.363769', '2019-10-16 15:59:50.363769');
INSERT INTO `building_service` VALUES (1, 5, 30000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (2, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (2, 2, 150000, NULL, '2019-10-16 09:11:41.312164', '2019-10-16 09:11:41.312164');
INSERT INTO `building_service` VALUES (4, 1, 190000, '1 tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (4, 2, 60000, '1 số điện', NULL, NULL);
INSERT INTO `building_service` VALUES (4, 3, 10000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (4, 4, 0, 'Chủ luôn ở nhà', NULL, NULL);
INSERT INTO `building_service` VALUES (5, 1, 200000, 'theo tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (5, 2, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (5, 3, NULL, 'Theo giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (6, 1, 200000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (6, 2, NULL, 'Theo giá nhà nước', NULL, NULL);
INSERT INTO `building_service` VALUES (6, 3, 60000, 'Theo tháng + phụ trội tính thêm', NULL, NULL);
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

-- ----------------------------
-- Table structure for building_type
-- ----------------------------
DROP TABLE IF EXISTS `building_type`;
CREATE TABLE `building_type`  (
  `type_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room type',
  `building_type` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of the type',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time ',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building_type
-- ----------------------------
INSERT INTO `building_type` VALUES (1, 'Căn hộ chung cư', '2019-10-17 04:26:20.980356', '2019-10-17 04:26:20.980356');
INSERT INTO `building_type` VALUES (2, 'Nhà nguyên căn', '2019-10-17 04:26:19.703176', '2019-10-17 04:26:19.703176');
INSERT INTO `building_type` VALUES (3, 'Khu nhà trọ', '2019-10-17 04:26:14.933942', '2019-10-17 04:26:14.933942');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `feedback_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the feedback',
  `user_id` int(5) NULL DEFAULT NULL COMMENT 'ID of user who sends the feedback',
  `email` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Email of the user who sends feedback',
  `content` text CHARACTER SET utf8mb4  NOT NULL COMMENT 'Content of the feedback',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`feedback_id`) USING BTREE,
  INDEX `FK_user_feedback`(`user_id`) USING BTREE,
  CONSTRAINT `FK_user_feedback` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, 1, 'email', 'feedback', NULL, NULL);

-- ----------------------------
-- Table structure for host_review
-- ----------------------------
DROP TABLE IF EXISTS `host_review`;
CREATE TABLE `host_review`  (
  `review_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the review',
  `host_id` int(5) NULL DEFAULT NULL COMMENT 'ID of the host who sends the review',
  `tenant_id` int(5) NULL DEFAULT NULL COMMENT 'ID of targeted tenant of the review',
  `comment` text CHARACTER SET utf8mb4  NULL COMMENT 'Content of the comment',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`review_id`) USING BTREE,
  INDEX `FK_user_host`(`host_id`) USING BTREE,
  INDEX `FK_user_tenant`(`tenant_id`) USING BTREE,
  CONSTRAINT `FK_user_host` FOREIGN KEY (`host_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of host_review
-- ----------------------------
INSERT INTO `host_review` VALUES (1, 1, 2, 'good', NULL, NULL);

-- ----------------------------
-- Table structure for reported_room
-- ----------------------------
DROP TABLE IF EXISTS `reported_room`;
CREATE TABLE `reported_room`  (
  `user_id` int(5) NOT NULL COMMENT 'ID of user who sends the report',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of reported room group',
  `report_content` text CHARACTER SET utf8mb4  NULL COMMENT 'Content of the report',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`, `room_group_id`) USING BTREE,
  INDEX `FK_room_report`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_report` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_report` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reported_room
-- ----------------------------
INSERT INTO `reported_room` VALUES (1, 2, 'messy', NULL, NULL);

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `room_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of group that room belongs to',
  `room_name` text CHARACTER SET utf8mb4  NULL COMMENT 'name of the room',
  `room_status` tinyint(2) NULL DEFAULT NULL COMMENT 'Room status code',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `FK_room_group`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 296 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, 5, '104', 1, '2019-10-29 17:02:11.229066', '2019-10-29 17:02:11.229066');
INSERT INTO `room` VALUES (2, 5, '102', 1, '2019-10-29 17:02:11.561850', '2019-10-29 17:02:11.561850');
INSERT INTO `room` VALUES (3, 5, '107', 1, '2019-10-29 17:02:11.887191', '2019-10-29 17:02:11.887191');
INSERT INTO `room` VALUES (4, 8, '201', 1, '2019-10-29 17:02:12.784098', '2019-10-29 17:02:12.784098');
INSERT INTO `room` VALUES (5, 8, '202', 0, '2019-10-29 17:02:13.164253', '2019-10-29 17:02:13.164253');
INSERT INTO `room` VALUES (6, 8, '301', 1, '2019-10-29 17:02:13.928063', '2019-10-29 17:02:13.928063');
INSERT INTO `room` VALUES (7, 8, '302', 0, '2019-10-29 17:02:14.403061', '2019-10-29 17:02:14.403061');
INSERT INTO `room` VALUES (8, 9, 'Thuê cả nhà', 1, '2019-10-29 17:02:15.185133', '2019-10-29 17:02:15.185133');
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
INSERT INTO `room` VALUES (20, 14, 'Thuê cả nhà', 0, '2019-11-11 17:27:04.116611', '2019-11-11 17:27:04.116611');
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

-- ----------------------------
-- Table structure for room_amenities
-- ----------------------------
DROP TABLE IF EXISTS `room_amenities`;
CREATE TABLE `room_amenities`  (
  `room_group_id` int(5) NOT NULL COMMENT 'ID of the room group',
  `amenities_id` int(5) NOT NULL COMMENT 'ID of amenities in the room group',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_group_id`, `amenities_id`) USING BTREE,
  INDEX `FK_Amenities-Room_Amenities`(`amenities_id`) USING BTREE,
  CONSTRAINT `FK_Amenities-Room_Amenities` FOREIGN KEY (`amenities_id`) REFERENCES `amenities` (`amenities_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Room-Room_Amenities` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_amenities
-- ----------------------------
INSERT INTO `room_amenities` VALUES (1, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (1, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (2, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (2, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (5, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (5, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 8, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 9, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 10, NULL, NULL);
INSERT INTO `room_amenities` VALUES (8, 11, NULL, NULL);
INSERT INTO `room_amenities` VALUES (9, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (9, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (9, 3, NULL, NULL);
INSERT INTO `room_amenities` VALUES (9, 4, NULL, NULL);
INSERT INTO `room_amenities` VALUES (9, 6, NULL, NULL);
INSERT INTO `room_amenities` VALUES (9, 7, NULL, NULL);
INSERT INTO `room_amenities` VALUES (9, 8, NULL, NULL);
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

-- ----------------------------
-- Table structure for room_group
-- ----------------------------
DROP TABLE IF EXISTS `room_group`;
CREATE TABLE `room_group`  (
  `room_group_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room group',
  `building_id` int(5) NULL DEFAULT NULL COMMENT 'ID of the building that the group belongs to',
  `gender` bit(1) NULL DEFAULT NULL COMMENT 'Gender in the group',
  `rent_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Rent price of the room group',
  `min_deposit_period` int(5) NULL DEFAULT NULL COMMENT 'minimun months of deposit',
  `area` double(10, 0) NULL DEFAULT NULL COMMENT 'Area of the room group',
  `bedroom_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of  bedrooms in the building',
  `bathroom_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of bathrooms in the building',
  `wc_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of WCs in the building',
  `direction` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'direction of the room',
  `is_available` bit(1) NULL DEFAULT NULL COMMENT 'The group is available or not',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'Room group is verified or not',
  `deposit_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Deposit price of the room group',
  `description` text CHARACTER SET utf8mb4  NULL COMMENT 'Description of the room group',
  `capacity` int(10) NULL DEFAULT NULL COMMENT 'Capacity of the room group',
  `view_amount` int(10) NULL DEFAULT NULL COMMENT 'View amount of the room group',
  `phone_view_amount` int(10) NULL DEFAULT NULL COMMENT 'View via phone amount of the room group',
  `is_sponsored` bit(1) NULL DEFAULT NULL COMMENT 'The room group is sponsored or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_group_id`) USING BTREE,
  INDEX `FK_room_group_building`(`building_id`) USING BTREE,
  CONSTRAINT `FK_room_group_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 135 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_group
-- ----------------------------
INSERT INTO `room_group` VALUES (1, 9, NULL, 2500000, 1, 150, 1, 1, 1, 'all', NULL, NULL, 1500000, 'Phòng đẹp, sạch sẽ có ban công. Hàng xóm thân thiện', 2, NULL, NULL, NULL, '2019-11-12 14:29:39.169132', '2019-11-12 14:29:39.169132');
INSERT INTO `room_group` VALUES (2, 1, b'1', 2000000, 1, 100, 1, 1, 1, 'west', b'1', b'1', 1400000, 'Nha tro', 44, 100, 100, b'1', '2019-10-31 14:15:49.429576', '2019-10-31 14:15:49.429576');
INSERT INTO `room_group` VALUES (5, 1, b'1', 2500000, 2, 100, 1, 1, 1, 'east', b'1', b'1', 1400000, 'Nha tro', 44, 100, 100, b'0', '2019-10-31 14:15:49.988242', '2019-10-31 14:15:49.988242');
INSERT INTO `room_group` VALUES (6, 2, b'1', 2500000, 1, 100, 1, 1, 1, 'north', b'1', b'1', 1400000, 'Nha tro 3', 44, 100, 100, b'0', '2019-10-31 14:15:50.409346', '2019-10-31 14:15:50.409346');
INSERT INTO `room_group` VALUES (7, 2, b'1', 2500000, 2, 100, 1, 1, 1, 'south', b'1', b'1', 1400000, 'Nha tro 3', 44, 100, 100, b'0', '2019-10-31 14:15:50.999600', '2019-10-31 14:15:50.999600');
INSERT INTO `room_group` VALUES (8, 4, NULL, 1200000, 2, 60, 1, 1, 1, '- Điều hòa, sàn gỗ, giường tủ\n- Gần chợ, ĐH văn hóa, ĐH Mỹ thuật công nghiệp...\n- An ninh tốt, khu dân trí cao', NULL, NULL, 1000000, '', 3, NULL, NULL, NULL, '2019-11-12 14:29:40.794836', '2019-11-12 14:29:40.794836');
INSERT INTO `room_group` VALUES (9, 6, NULL, NULL, 2, 200, 2, 2, 1, '', NULL, NULL, NULL, 'Phòng view đẹp ', 4, NULL, NULL, NULL, '2019-11-12 14:29:42.963909', '2019-11-12 14:29:42.963909');
INSERT INTO `room_group` VALUES (10, 8, NULL, 7500000, 1, 200, 2, 2, 1, 'Đông Bắc', NULL, NULL, 5000000, 'Căn hộ view đẹp, đầy đủ tiện nghi.\nGửi xe tầng hầm miễn phí.\nTest', 4, NULL, NULL, NULL, '2019-11-12 14:29:41.830402', '2019-11-12 14:29:41.830402');
INSERT INTO `room_group` VALUES (11, 9, NULL, 1500000, 1, 100, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng đẹp, sạch sẽ', 2, NULL, NULL, NULL, '2019-11-12 14:29:44.154480', '2019-11-12 14:29:44.154480');
INSERT INTO `room_group` VALUES (12, 10, NULL, 1500000, 1, 100, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng đẹp', 2, NULL, NULL, NULL, '2019-11-12 14:29:45.489791', '2019-11-12 14:29:45.489791');
INSERT INTO `room_group` VALUES (13, 12, NULL, 9999999999, -1, -11, 1, 2, 1, 'Đông Bắc', NULL, NULL, 9999999999, 'Không biết', -11, NULL, NULL, NULL, '2019-11-12 14:29:46.341799', '2019-11-12 14:29:46.341799');
INSERT INTO `room_group` VALUES (14, 13, NULL, 4500000, 1, 80, 1, 1, 1, 'Đông', NULL, NULL, 5000000, 'Nhà rộng rãi, sạch sẽ', 2, NULL, NULL, NULL, '2019-11-12 14:29:47.232590', '2019-11-12 14:29:47.232590');
INSERT INTO `room_group` VALUES (15, 14, NULL, 5500000, 2, 100, 2, 2, 1, 'Đông Nam', NULL, NULL, 4000000, 'Nhà sạch và rộng, mới xây', 3, NULL, NULL, NULL, '2019-11-12 14:29:47.968737', '2019-11-12 14:29:47.968737');
INSERT INTO `room_group` VALUES (16, 15, NULL, 3500000, 1, 60, 1, 1, 1, 'Tây Nam', NULL, NULL, 3000000, 'Thoáng mát, sạch sẽ, tiện nghi', 2, NULL, NULL, NULL, '2019-11-12 14:29:48.627787', '2019-11-12 14:29:48.627787');
INSERT INTO `room_group` VALUES (17, 16, NULL, 6500000, 1, 100, 1, 1, 1, 'Bắc', NULL, NULL, 67000000, 'Nhà mới chung cư Vincom, sôi động', 2, NULL, NULL, NULL, '2019-11-12 14:29:49.280258', '2019-11-12 14:29:49.280258');
INSERT INTO `room_group` VALUES (18, 17, NULL, 5500000, 1, 70, 1, 2, 1, 'Bắc', NULL, NULL, 5000000, 'Nhà Vincom sạch sẽ thoáng mát', 2, NULL, NULL, NULL, '2019-11-12 14:29:50.038672', '2019-11-12 14:29:50.038672');
INSERT INTO `room_group` VALUES (19, 18, NULL, 3500000, 1, 100, 1, 1, 1, 'Nam', NULL, NULL, 3000000, 'Chung cư mới sạch thoáng mát', 2, NULL, NULL, NULL, '2019-11-12 14:29:50.630643', '2019-11-12 14:29:50.630643');
INSERT INTO `room_group` VALUES (20, 19, NULL, 3500000, 2, 30, 1, 1, 1, 'Đông Bắc', NULL, NULL, 43000000, 'Nhà kiến trúc đẹp, phong cách cổ kính nhưng vẫn đầy đủ tiện nghi', 2, NULL, NULL, NULL, '2019-11-12 14:29:51.212074', '2019-11-12 14:29:51.212074');
INSERT INTO `room_group` VALUES (21, 20, NULL, 10500000, 1, 150, 2, 2, 1, 'Đông Nam', NULL, NULL, 10000000, 'Nhà mới xây nhưng không sử dụng nên có nhu cầu cho thuê lại, đồ đạc tiện nghi mới mẻ', 4, NULL, NULL, NULL, '2019-11-12 14:29:51.830736', '2019-11-12 14:29:51.830736');
INSERT INTO `room_group` VALUES (22, 21, NULL, 5500000, 1, 50, 2, 1, 1, 'Đông', NULL, NULL, 5000000, 'Nhà mới xây', 3, NULL, NULL, NULL, '2019-11-12 14:29:52.485618', '2019-11-12 14:29:52.485618');
INSERT INTO `room_group` VALUES (23, 22, NULL, 4500000, 0, 60, 1, 1, 1, 'Bắc', NULL, NULL, 4000000, 'Nhà cấp 4 rộng rãi, thoáng mát', 2, NULL, NULL, NULL, '2019-11-12 14:29:53.168734', '2019-11-12 14:29:53.168734');
INSERT INTO `room_group` VALUES (24, 23, NULL, 7500000, 1, 100, 2, 1, 1, 'Tây Nam', NULL, NULL, 6000000, 'Nhà cho gia đình 4 người ở thoải mái', 4, NULL, NULL, NULL, '2019-11-12 14:29:54.039112', '2019-11-12 14:29:54.039112');
INSERT INTO `room_group` VALUES (25, 24, NULL, 3500000, 1, 120, 2, 1, 1, 'Nam', NULL, NULL, 3000000, 'Mát mẻ vào mùa hè, ấm áp vào mùa đông\n', 3, NULL, NULL, NULL, '2019-11-12 14:29:54.771218', '2019-11-12 14:29:54.771218');
INSERT INTO `room_group` VALUES (26, 25, NULL, 5500000, 1, 40, 1, 1, 1, 'Đông Nam', NULL, NULL, 3000000, 'Căn hộ hợp lý cho sinh viên', 2, NULL, NULL, NULL, '2019-11-12 14:29:55.390511', '2019-11-12 14:29:55.390511');
INSERT INTO `room_group` VALUES (27, 26, NULL, 5000000, 1, 45, 1, 1, 1, 'Tây Bắc', NULL, NULL, 4000000, 'Căn hộ nguyên căn tiện nghi', 2, NULL, NULL, NULL, '2019-11-12 14:29:56.231210', '2019-11-12 14:29:56.231210');
INSERT INTO `room_group` VALUES (28, 27, NULL, 3500000, 1, 50, 1, 1, 1, 'Tây', NULL, NULL, 2000000, 'Nhà đẹp', 2, NULL, NULL, NULL, '2019-11-12 14:29:56.897209', '2019-11-12 14:29:56.897209');
INSERT INTO `room_group` VALUES (29, 28, NULL, 1000000, 1, 30, 1, 1, 1, 'all', NULL, NULL, 1000000, 'gọn gàng sạch sẽ phòng mới xây đầy đủ điều hòa nóng lạnh', 6, NULL, NULL, NULL, '2019-11-12 14:29:57.511629', '2019-11-12 14:29:57.511629');
INSERT INTO `room_group` VALUES (30, 29, NULL, 1800000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Có phòng cho thuê diện tích 15m2 - 25m2.\nGiá 1,8tr/th.\nPhòng to sạch sẽ có nóng lạnh, điều hòa, có ban công cửa sổ thoáng mát, có chỗ để xe và phơi đồ riêng.\nTại địa chỉ ngõ 252 Tây Sơn gần đại học Thủy Lợi - Công Đoàn.\nLiên hệ: Chị Linh 0375147121 (MTG).', 2, NULL, NULL, NULL, '2019-11-12 14:29:59.886023', '2019-11-12 14:29:59.886023');
INSERT INTO `room_group` VALUES (31, 29, NULL, 1500000, 2, 20, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Có phòng cho thuê diện tích 15m2 - 25m2.\nGiá 1,5tr/th và 1,8tr/th.\nPhòng to sạch sẽ có nóng lạnh, điều hòa, có ban công cửa sổ thoáng mát, có chỗ để xe và phơi đồ riêng.\nTại địa chỉ ngõ 252 Tây Sơn gần đại học Thủy Lợi - Công Đoàn.\nLiên hệ: Chị Linh 0375147121 (MTG).', 2, NULL, NULL, NULL, '2019-11-12 14:29:59.061376', '2019-11-12 14:29:59.061376');
INSERT INTO `room_group` VALUES (32, 30, NULL, 2200000, 1, 20, 1, 1, 1, 'all', NULL, NULL, 1000000, '- Phòng 35m2 khép kín có bếp, có nhà WC và một số đồ cơ bản.\n- Địa chỉ tại số 1/43 ngõ Thanh Miến, phố Văn Miếu, Đống Đa, HN.\n- Giá là 3.500.000 vnđ/ tháng ưu tiên gia đình và sinh viên nữ thuê.\n- LH: 0983.027.485.', 2, NULL, NULL, NULL, '2019-11-12 14:30:01.698207', '2019-11-12 14:30:01.698207');
INSERT INTO `room_group` VALUES (33, 30, NULL, 2500000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 1000000, '- Phòng 35m2 khép kín có bếp, có nhà WC và một số đồ cơ bản.\n- Địa chỉ tại số 1/43 ngõ Thanh Miến, phố Văn Miếu, Đống Đa, HN.\n- Giá là 3.500.000 vnđ/ tháng ưu tiên gia đình và sinh viên nữ thuê.\n- LH: 0983.027.485.', 2, NULL, NULL, NULL, '2019-11-12 14:30:10.811667', '2019-11-12 14:30:10.811667');
INSERT INTO `room_group` VALUES (34, 31, b'0', 1500000, 2, 15, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Xanh sạch đẹp.\nChủ nhà thân thiện.\nGiờ giấc thoải mái.\nĐặc biệt trọ chỉ tuyển người đẹp trai vào thuê !!!', 2, NULL, NULL, NULL, '2019-11-12 14:30:12.683829', '2019-11-12 14:30:12.683829');
INSERT INTO `room_group` VALUES (35, 31, b'0', 1200000, 2, 13, 1, 1, 1, 'all', NULL, NULL, 1500000, 'Trọ cho người đẹp trai vừa phải', 1, NULL, NULL, NULL, '2019-11-12 14:30:13.346707', '2019-11-12 14:30:13.346707');
INSERT INTO `room_group` VALUES (36, 32, NULL, 3500000, 1, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2- 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 ( MIỄN TIÊP MÔI GIỚI)', 2, NULL, NULL, NULL, '2019-11-12 14:30:13.992445', '2019-11-12 14:30:13.992445');
INSERT INTO `room_group` VALUES (37, 32, NULL, 2500000, 1, 20, 1, 1, 1, 'all', NULL, NULL, 2500000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2- 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 ( MIỄN TIÊP MÔI GIỚI)', 2, NULL, NULL, NULL, '2019-11-12 14:30:14.683372', '2019-11-12 14:30:14.683372');
INSERT INTO `room_group` VALUES (38, 33, NULL, 2500000, 2, 20, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Chung cư mini 6 tầng còn 5 phòng cho thuê ở ngõ 3 Thái Hà - còn trống trên tầng 2, 3 muốn cho thuê - tầng 1 để xe, có bảo vệ 24/24h an ninh tốt, giờ giấc tự do - phòng khép kín hết, có kệ bếp nấu ăn, có giường, tivi, nóng lạnh, điều hòa, tủ quần áo - ở được 2, 3 bạn sinh viên, hoặc hộ gia đình nhỏ.\nĐiện nước: 3.000/số.\nNước 50.000/người/tháng.\nDiện tích: 25m2 - 30 m2.\nGiá: Từ 2,3tr/th - 2,6tr/th.\nLiên hệ: Anh Nam: 0345.064.289/ chị Linh: 0375.429.239 miễn môi giới làm phiền.\n', 2, NULL, NULL, NULL, '2019-11-12 14:30:15.595827', '2019-11-12 14:30:15.595827');
INSERT INTO `room_group` VALUES (39, 33, NULL, 3500000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Chung cư mini 6 tầng còn 5 phòng cho thuê ở ngõ 3 Thái Hà - còn trống trên tầng 2, 3 muốn cho thuê - tầng 1 để xe, có bảo vệ 24/24h an ninh tốt, giờ giấc tự do - phòng khép kín hết, có kệ bếp nấu ăn, có giường, tivi, nóng lạnh, điều hòa, tủ quần áo - ở được 2, 3 bạn sinh viên, hoặc hộ gia đình nhỏ.\nĐiện nước: 3.000/số.\nNước 50.000/người/tháng.\nDiện tích: 25m2 - 30 m2.\nGiá: Từ 2,3tr/th - 2,6tr/th.\nLiên hệ: Anh Nam: 0345.064.289/ chị Linh: 0375.429.239 miễn môi giới làm phiền.\n', 2, NULL, NULL, NULL, '2019-11-12 14:30:16.312865', '2019-11-12 14:30:16.312865');
INSERT INTO `room_group` VALUES (40, 33, NULL, 1500000, 1, 20, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Chung cư mini 6 tầng còn 5 phòng cho thuê ở ngõ 3 Thái Hà - còn trống trên tầng 2, 3 muốn cho thuê - tầng 1 để xe, có bảo vệ 24/24h an ninh tốt, giờ giấc tự do - phòng khép kín hết, có kệ bếp nấu ăn, có giường, tivi, nóng lạnh, điều hòa, tủ quần áo - ở được 2, 3 bạn sinh viên, hoặc hộ gia đình nhỏ.\nĐiện nước: 3.000/số.\nNước 50.000/người/tháng.\nDiện tích: 25m2 - 30 m2.\nGiá: Từ 2,3tr/th - 2,6tr/th.\nLiên hệ: Anh Nam: 0345.064.289/ chị Linh: 0375.429.239 miễn môi giới làm phiền.\n', 2, NULL, NULL, NULL, '2019-11-12 14:30:16.922331', '2019-11-12 14:30:16.922331');
INSERT INTO `room_group` VALUES (41, 34, NULL, 3200000, 1, 26, 1, 1, 1, 'all', NULL, NULL, 3000000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2 - 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 Chú Dũng 0966.223.091 (MTG).', 2, NULL, NULL, NULL, '2019-11-12 14:30:17.679910', '2019-11-12 14:30:17.679910');
INSERT INTO `room_group` VALUES (42, 34, NULL, 2700000, 2, 22, 1, 1, 1, 'all', NULL, NULL, 3000000, '- Chung cư mini mới xây 9 tầng có thang máy tại ngõ 7 Thái Hà, tầng 1 để xe free, bảo vệ 24/24.\n- Diện tích: 25m2 - 28m2 - 32m2:\n- Giá: 2,5 tr/th - 2,7tr/th - 3 tr/th.\n- Khép kín, kệ bếp nấu ăn trong phòng, nhà sàn đá hoa sạch đẹp, có ban công phơi đồ, cửa sổ thoáng mát,... Đầy đủ điều hòa, nóng lạnh.\n\nLiên hệ: Cô Ngân 0961.085.122 Chú Dũng 0966.223.091 (MTG).', 2, NULL, NULL, NULL, '2019-11-12 14:30:22.883513', '2019-11-12 14:30:22.883513');
INSERT INTO `room_group` VALUES (43, 35, NULL, 2000000, 2, 20, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Nhà đẹp rộng rãi\nĐI lại thoải mái\nTrông xe đảm bảo\nĐIện nước giá dân', 2, NULL, NULL, NULL, '2019-11-12 14:30:25.569678', '2019-11-12 14:30:25.569678');
INSERT INTO `room_group` VALUES (44, 35, b'1', 3000000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp rộng rãi\nĐI lại thoải mái\nTrông xe đảm bảo\nĐIện nước giá dân', 2, NULL, NULL, NULL, '2019-11-12 14:30:24.045774', '2019-11-12 14:30:24.045774');
INSERT INTO `room_group` VALUES (45, 36, NULL, 2100000, 2, 18, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Cho thuê phòng giá rẻ tại Tôn Đức Thắng - Khâm Thiên. Gia: 800 nghìn/th - 1tr - 1,2tr/tháng. Diện tích 14m2 - 15m2 - 17m2. Phòng sạch sẽ thoáng phù hợp để sinh viên hoặc người đi làm. Tiện chợ gần đường lớn, gần các trường đại học. Đóng tiền tháng 1, bạn bè đến chơi thoải mái,', 2, NULL, NULL, NULL, '2019-11-12 14:30:27.533944', '2019-11-12 14:30:27.533944');
INSERT INTO `room_group` VALUES (46, 36, NULL, 2500000, 1, 23, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Cho thuê phòng giá rẻ tại Tôn Đức Thắng - Khâm Thiên. Gia: 800 nghìn/th - 1tr - 1,2tr/tháng. Diện tích 14m2 - 15m2 - 17m2. Phòng sạch sẽ thoáng phù hợp để sinh viên hoặc người đi làm. Tiện chợ gần đường lớn, gần các trường đại học. Đóng tiền tháng 1, bạn bè đến chơi thoải mái,', 2, NULL, NULL, NULL, '2019-11-12 14:30:28.184013', '2019-11-12 14:30:28.184013');
INSERT INTO `room_group` VALUES (47, 37, NULL, 2300000, 2, 23, 1, 1, 1, 'all', NULL, NULL, 2000000, '- Nhà xây kiểu chung cư 6 tầng, phòng khép kín, có nóng lạnh. - Diện tích 18m2 - 20m2 - 25m2. - Giá 1.600.000/th - 1,800,000/th - 2.000.000đ/ tháng.- Phòng thoáng mát sạch sẽ, ban công, cửa sổ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặ', 2, NULL, NULL, NULL, '2019-11-12 14:30:28.827740', '2019-11-12 14:30:28.827740');
INSERT INTO `room_group` VALUES (48, 37, NULL, 3000000, 2, 28, 1, 1, 1, 'all', NULL, NULL, 3000000, '- Nhà xây kiểu chung cư 6 tầng, phòng khép kín, có nóng lạnh. - Diện tích 18m2 - 20m2 - 25m2. - Giá 1.600.000/th - 1,800,000/th - 2.000.000đ/ tháng.- Phòng thoáng mát sạch sẽ, ban công, cửa sổ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặ', 2, NULL, NULL, NULL, '2019-11-12 14:30:29.492290', '2019-11-12 14:30:29.492290');
INSERT INTO `room_group` VALUES (49, 38, b'0', 3000000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp \nThơm tho thoáng mát\nKhông tệ nạn', 2, NULL, NULL, NULL, '2019-11-12 14:30:30.154660', '2019-11-12 14:30:30.154660');
INSERT INTO `room_group` VALUES (50, 39, NULL, 3500000, 2, 26, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Cho thuê phòng, nhà 5 tầng, ngõ 12/12 Nguyễn Phúc Lai, Đống Đa.\nGần hồ Hoàng Cầu, đại học Văn Hóa, học viện Âm Nhạc, Đê La Thành, Giảng Võ. Nhà ô tô vào được. Có máy giặt, điện 3.500 đ/số, nước 70.000 đ/người, nhà còn 01 phòng tầng 4 có Điều Hòa và Nóng Lạnh, phơi quần áo trên tầng 5, tầng 1 để xe, phòng rộng 27m2. Đi lại tự quản. Phòng có 02 cửa sổ nhìn ra ngõ thoáng mát.\nGọi ngay Mr Dũng 0978713456. Giá 2.400.000 đ/th.\nỞ ngay.', 2, NULL, NULL, NULL, '2019-11-12 14:30:30.753993', '2019-11-12 14:30:30.753993');
INSERT INTO `room_group` VALUES (51, 39, NULL, 2500000, 2, 22, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Cho thuê phòng, nhà 5 tầng, ngõ 12/12 Nguyễn Phúc Lai, Đống Đa.\nGần hồ Hoàng Cầu, đại học Văn Hóa, học viện Âm Nhạc, Đê La Thành, Giảng Võ. Nhà ô tô vào được. Có máy giặt, điện 3.500 đ/số, nước 70.000 đ/người, nhà còn 01 phòng tầng 4 có Điều Hòa và Nóng Lạnh, phơi quần áo trên tầng 5, tầng 1 để xe, phòng rộng 27m2. Đi lại tự quản. Phòng có 02 cửa sổ nhìn ra ngõ thoáng mát.\nGọi ngay Mr Dũng 0978713456. Giá 2.400.000 đ/th.\nỞ ngay.', 2, NULL, NULL, NULL, '2019-11-12 14:30:31.360588', '2019-11-12 14:30:31.360588');
INSERT INTO `room_group` VALUES (52, 40, NULL, 4000000, 3, 30, 1, 1, 1, 'all', NULL, NULL, 4000000, 'Phòng Vip cho dân chơi', 2, NULL, NULL, NULL, '2019-11-12 14:30:31.954375', '2019-11-12 14:30:31.954375');
INSERT INTO `room_group` VALUES (53, 40, NULL, 2500000, 3, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Phòng thường cho dân thường', 3, NULL, NULL, NULL, '2019-11-12 14:30:34.701468', '2019-11-12 14:30:34.701468');
INSERT INTO `room_group` VALUES (54, 41, NULL, 2800000, 2, 28, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp dùng để setup khách sạn, nay cho thuê phòng trọ, căn hộ mini cao cấp.\nVị trí gần Hoàng Cầu, Nhạc Viện Hà Nội, Đại Học Thủy Lợi, Đại Học Công Đoàn, Đại Học Ngân Hàng….\nNgõ rộng ô tô vào gần tận nhà, đầy đủ đồ điều hòa, nóng lạnh, máy giặt, giường đệm cao cấp, điện nước giá nhà nước, tự do đi lại không chung chủ.\nĐ/c: Số 10, ngách 66, ngõ giếng, phố Đông Các, Ô Chợ Dừa, Đống Đa, Hà Nội.\nGiá 3,8 tr/tháng, rộng 38m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nGiá 4,5 tr/tháng, rộng 45m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nChú ý: Có wifi, truyền hình cáp full HD, để xe miễn phí, giờ tự do không chung chủ, cho nấu ăn, Mr Đại 0904 5959 62', 2, NULL, NULL, NULL, '2019-11-12 14:30:33.846863', '2019-11-12 14:30:33.846863');
INSERT INTO `room_group` VALUES (55, 41, NULL, 2500000, 2, 22, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp dùng để setup khách sạn, nay cho thuê phòng trọ, căn hộ mini cao cấp.\nVị trí gần Hoàng Cầu, Nhạc Viện Hà Nội, Đại Học Thủy Lợi, Đại Học Công Đoàn, Đại Học Ngân Hàng….\nNgõ rộng ô tô vào gần tận nhà, đầy đủ đồ điều hòa, nóng lạnh, máy giặt, giường đệm cao cấp, điện nước giá nhà nước, tự do đi lại không chung chủ.\nĐ/c: Số 10, ngách 66, ngõ giếng, phố Đông Các, Ô Chợ Dừa, Đống Đa, Hà Nội.\nGiá 3,8 tr/tháng, rộng 38m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nGiá 4,5 tr/tháng, rộng 45m2, đệm, cửa sổ, wc khép kín, nước nóng, điều hòa, ….\nChú ý: Có wifi, truyền hình cáp full HD, để xe miễn phí, giờ tự do không chung chủ, cho nấu ăn, Mr Đại 0904 5959 62', 2, NULL, NULL, NULL, '2019-11-12 14:30:36.368492', '2019-11-12 14:30:36.368492');
INSERT INTO `room_group` VALUES (56, 42, NULL, 4000000, 2, 30, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp\nSạch sẽ\nChủ nhà vui tính', 3, NULL, NULL, NULL, '2019-11-12 14:30:37.068693', '2019-11-12 14:30:37.068693');
INSERT INTO `room_group` VALUES (57, 42, NULL, 3500000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp\nSạch sẽ\nChủ nhà vui tính', 2, NULL, NULL, NULL, '2019-11-12 14:30:37.736380', '2019-11-12 14:30:37.736380');
INSERT INTO `room_group` VALUES (58, 43, NULL, 3500000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp thoáng mát', 2, NULL, NULL, NULL, '2019-11-12 14:30:38.449847', '2019-11-12 14:30:38.449847');
INSERT INTO `room_group` VALUES (59, 44, NULL, 1500000, 1, 25, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng trọ cho sinh viên', 2, NULL, NULL, NULL, '2019-11-12 14:30:39.154222', '2019-11-12 14:30:39.154222');
INSERT INTO `room_group` VALUES (60, 44, NULL, 2500000, 1, 30, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Phòng trọ diện tích rộng cho sinh viên', 2, NULL, NULL, NULL, '2019-11-12 14:30:39.797488', '2019-11-12 14:30:39.797488');
INSERT INTO `room_group` VALUES (61, 45, NULL, 3500000, 2, 30, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Nhà đẹp thoáng mát\n\n\nCực thuận tiện vì gần chợ', 2, NULL, NULL, NULL, '2019-11-12 14:30:40.410675', '2019-11-12 14:30:40.410675');
INSERT INTO `room_group` VALUES (62, 45, NULL, 2500000, 2, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp thoáng mát\n\n\nCực thuận tiện vì gần chợ', 2, NULL, NULL, NULL, '2019-11-12 14:30:40.953665', '2019-11-12 14:30:40.953665');
INSERT INTO `room_group` VALUES (63, 46, NULL, 2000000, 1, 20, 1, 1, 1, 'all', NULL, NULL, 1500000, 'Phòng loại rẻ nhất', 2, NULL, NULL, NULL, '2019-11-12 14:30:41.742964', '2019-11-12 14:30:41.742964');
INSERT INTO `room_group` VALUES (64, 46, NULL, 4000000, 1, 40, 1, 1, 1, 'all', NULL, NULL, 3500000, 'Phòng 40m2 rộng rãi với 2 người, phù hợp cho 3 người ở, tiện nghi hiện đại', 3, NULL, NULL, NULL, '2019-11-12 14:30:42.340088', '2019-11-12 14:30:42.340088');
INSERT INTO `room_group` VALUES (65, 46, NULL, 3500000, 1, 30, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Phòng 30m2 rộng rãi thoải mái', 2, NULL, NULL, NULL, '2019-11-12 14:30:42.966052', '2019-11-12 14:30:42.966052');
INSERT INTO `room_group` VALUES (66, 47, NULL, 2500000, 2, 20, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Nhà sạch đẹp', 2, NULL, NULL, NULL, '2019-11-12 14:30:43.719510', '2019-11-12 14:30:43.719510');
INSERT INTO `room_group` VALUES (67, 48, NULL, 1500000, 1, 20, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng nhỏ loại 1 rẻ', 2, NULL, NULL, NULL, '2019-11-12 14:30:44.301803', '2019-11-12 14:30:44.301803');
INSERT INTO `room_group` VALUES (68, 48, NULL, 2500000, 1, 30, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Phòng lớn loại 2', 2, NULL, NULL, NULL, '2019-11-12 14:30:45.029635', '2019-11-12 14:30:45.029635');
INSERT INTO `room_group` VALUES (69, 49, NULL, 2500000, 2, 100, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Thoáng mát', 3, NULL, NULL, NULL, '2019-11-12 14:30:45.691109', '2019-11-12 14:30:45.691109');
INSERT INTO `room_group` VALUES (70, 50, NULL, 2500000, 1, 25, 1, 1, 1, 'all', NULL, NULL, 2000000, 'Phòng loại 2 có điều hòa', 2, NULL, NULL, NULL, '2019-11-12 14:30:46.329253', '2019-11-12 14:30:46.329253');
INSERT INTO `room_group` VALUES (71, 50, NULL, 1500000, 1, 20, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Phòng loại 1 không điều hòa', 2, NULL, NULL, NULL, '2019-11-12 14:30:47.230871', '2019-11-12 14:30:47.230871');
INSERT INTO `room_group` VALUES (72, 50, NULL, 3500000, 1, 30, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Phòng loại 3 rộng rãi có điều hòa và ban công', 2, NULL, NULL, NULL, '2019-11-12 14:30:47.860410', '2019-11-12 14:30:47.860410');
INSERT INTO `room_group` VALUES (73, 51, b'0', 3500000, 1, 30, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Nhà Đẹp', 2, NULL, NULL, NULL, '2019-11-12 14:30:48.446763', '2019-11-12 14:30:48.446763');
INSERT INTO `room_group` VALUES (74, 51, b'0', 2500000, 2, 20, 1, 1, 1, 'all', NULL, NULL, 3000000, 'Nhà đẹp', 2, NULL, NULL, NULL, '2019-11-12 14:30:49.039676', '2019-11-12 14:30:49.039676');
INSERT INTO `room_group` VALUES (75, 52, NULL, 10000000, 2, 75, 2, 4, 1, 'Nam', NULL, NULL, 5000000, 'Cho người nhiều tiền', 2, NULL, NULL, NULL, '2019-11-12 14:30:49.719913', '2019-11-12 14:30:49.719913');
INSERT INTO `room_group` VALUES (76, 53, NULL, 8500000, 4, 100, 2, 3, 1, 'Tây', NULL, NULL, 2000000, 'Nhà đẹp ', 3, NULL, NULL, NULL, '2019-11-12 14:30:50.389029', '2019-11-12 14:30:50.389029');
INSERT INTO `room_group` VALUES (77, 54, NULL, 7500000, 2, 50, 3, 2, 1, 'Đông', NULL, NULL, 2000000, 'Nhà thích hợp cho trẻ em\n', 6, NULL, NULL, NULL, '2019-11-12 14:30:51.070231', '2019-11-12 14:30:51.070231');
INSERT INTO `room_group` VALUES (78, 55, b'0', 2300000, 1, 20, 1, 1, 1, 'all', NULL, NULL, 3000000, 'òa chung cư mini 7 tầng, tại ngõ 43 Xã Đàn, quận Đống Đa, Hà Nội.\nPhòng nhỏ giá 3tr - 4tr/th.\nPhòng to giá 5tr/th.\n+ Phòng bếp được trang bị điều hòa, nóng lạnh, giường, tủ.\n+ Khu vực nhà vệ sinh được lắp đầy đủ thiết bị hiện đại như chậu rửa mặt, bệt Inax, vòi sen.\n- Tiện ích: Tòa nhà có bảo vệ 24/24, đảm bảo an ninh tuyệt đối, giờ giấc ra vào thoải mái.\nInternet cáp quang,\n- Tòa nhà nằm ở vị trí trung tâm, giao thông thuận tiện, gần đường Đê La Thành, Khâm Thiên, Phạm Ngọc Thạch.\n- Ưu tiên cho hộ gia đình, sinh viên người đi làm hiền lành thuê ở.\n- Chỉ ở từ 2 - 3 người/phòng.\n\nĐịa chỉ: Ngõ 43 Xã Đàn - Ô Chợ Dừa - Đống Đa - Hà Nội.\nLiên hệ: Anh Thành 0936412192 (Liên hệ xem phòng ban ngày từ 8h sáng đến 18h).', 2, NULL, NULL, NULL, '2019-11-12 14:30:53.036498', '2019-11-12 14:30:53.036498');
INSERT INTO `room_group` VALUES (79, 55, b'0', 2800000, 1, 25, 1, 1, 1, 'all', NULL, NULL, 3000000, 'òa chung cư mini 7 tầng, tại ngõ 43 Xã Đàn, quận Đống Đa, Hà Nội.\nPhòng nhỏ giá 3tr - 4tr/th.\nPhòng to giá 5tr/th.\n+ Phòng bếp được trang bị điều hòa, nóng lạnh, giường, tủ.\n+ Khu vực nhà vệ sinh được lắp đầy đủ thiết bị hiện đại như chậu rửa mặt, bệt Inax, vòi sen.\n- Tiện ích: Tòa nhà có bảo vệ 24/24, đảm bảo an ninh tuyệt đối, giờ giấc ra vào thoải mái.\nInternet cáp quang,\n- Tòa nhà nằm ở vị trí trung tâm, giao thông thuận tiện, gần đường Đê La Thành, Khâm Thiên, Phạm Ngọc Thạch.\n- Ưu tiên cho hộ gia đình, sinh viên người đi làm hiền lành thuê ở.\n- Chỉ ở từ 2 - 3 người/phòng.\n\nĐịa chỉ: Ngõ 43 Xã Đàn - Ô Chợ Dừa - Đống Đa - Hà Nội.\nLiên hệ: Anh Thành 0936412192 (Liên hệ xem phòng ban ngày từ 8h sáng đến 18h).', 2, NULL, NULL, NULL, '2019-11-12 14:30:53.857625', '2019-11-12 14:30:53.857625');
INSERT INTO `room_group` VALUES (80, 56, NULL, 15000000, 1, 50, 2, 1, 1, 'Đông Bắc', NULL, NULL, 10000000, 'Căn hộ cao cấp tại Xã Đàn, Ô Chợ Dừa. I, Thiết kế căn hộ. + Diện tích, giá: 25m2-35m2 giá từ 4.5 - 5 - 5.5 tr/th. + Vệ sinh khép kín. + Vị trí: 275 Xã Đàn. + Cách mặt đường lớn ngã 6 Ô Chợ Dừa tầm 50m. II, Tiện ích tòa nhà. - Full đồ.', 4, NULL, NULL, NULL, '2019-11-12 14:30:54.686362', '2019-11-12 14:30:54.686362');
INSERT INTO `room_group` VALUES (81, 57, NULL, 2500000, 1, 80, 2, 2, 1, 'Nam', NULL, NULL, 10000000, 'Hiện tôi còn duy nhất một phòng trọ tầng 3 diện tích 15m2, tại nhà số 6 ngõ 137, Hào Nam, Phường Ô Chợ Dừa, phố Hào Nam, Đống Đa, Hà Nội. Tiện ích: - Gần Nhạc Viện, Đại học Mỹ Thuật, ngõ rộng ô tô đỗ cửa tiện đi lại. - Vệ sinh có bình nóng lạnh, quạt trần, nhà sạch sẽ, an ninh', 5, NULL, NULL, NULL, '2019-11-12 14:30:55.508876', '2019-11-12 14:30:55.508876');
INSERT INTO `room_group` VALUES (82, 58, NULL, 150000000, 1, 70, 2, 1, 1, 'Đông Bắc', NULL, NULL, 12000000, 'LIGOT mái nhà chung của mọi người! Xách đồ ngay tới các địa chỉ của chúng tôi: 1. Căn hộ dịch vụ số 224 Mai Anh Tuấn (vệ hồ Hoàng Cầu). 2. Homestay 73 Nguyên Hồng. 3. Căn hộ 54A Thợ Nhuộm. Đơn vị phát triển: Phi Long DC. Thông tin sản phẩm. - Căn phòng được setup ', 4, NULL, NULL, NULL, '2019-11-12 14:30:56.969034', '2019-11-12 14:30:56.969034');
INSERT INTO `room_group` VALUES (83, 59, NULL, 8500000, 1, 90, 3, 2, 1, '', NULL, NULL, 8000000, 'Diện tích các căn hộ từ 25m2 - 30m2 - 35m2. Với các mức giá cho thuê từ 3.000.000đ/th - 3.500.000/th - đến 5.500.000đ/căn.Các căn hộ bao gồm:+ 1 phòng ngủ riêng biệt có cửa sổ thông thoáng được trang bị điều hòa 2 chiều, giường, tủ quần áo, bàn ăn, bàn trang điểm (tùy căn)', 6, NULL, NULL, NULL, '2019-11-12 14:30:57.573981', '2019-11-12 14:30:57.573981');
INSERT INTO `room_group` VALUES (84, 60, NULL, 24000000, 1, 68, 3, 2, 2, 'Đông Nam', NULL, NULL, 20000000, 'Xem nhà 24/7:\nPhòng kinh doanh quản lý cho thuê các căn hộ tại chung cư cao cấp Tân Hoàng Minh D\'. Le Pont D\'or – 36 Hoàng Cầu giá tốt nhất thị trường, chỉ từ 14 triệu/tháng, diện tích từ 68m2 - 145m2.\nLiên hệ Mr Mạnh: 0936.386.595.\n- Giá cam kết rẻ nhất thị trường.\n- Tư vấn nhiệt tình chính xác nhất.\n- Xem nhà bất kể khi nào 24/7.\n- Ký hợp đồng trực tiếp với chủ nhà.\n- Có ưu đãi cho khách hàng đặt cọc trước.\n- Khách thuê được xem trực tiếp căn hộ, làm việc chính chủ.\n- Hỗ trợ tư vấn về pháp lý và thủ tục trong suốt thời gian thuê nhà.\n- Căn hộ 68m2, 1 phòng ngủ, đầy đủ nội thất thiết kế đẹp mắt ban công view hồ. Giá 14 triệu/tháng.\n- Căn hộ 75m2, 2 phòng ngủ, đầy đủ đồ cao cấp: Sofa, giường, tủ âm tường, tủ tivi, bàn ăn, kệ bếp tủ bếp,... Giá 16 triệu/tháng.\n- Căn hộ 100m2, thiết kết 2 phòng ngủ, đồ cơ bản có điều hòa âm trần, sàn gỗ, nóng lạnh, kệ tủ bếp, giá 16 triệu/tháng.\n- Căn hộ 100m2, thiết kế 2 phòng ngủ, tầng đẹp, đầy đủ nội thất sang trọng. Giá: 18 triệu/tháng.\n- Căn hộ 128m2, thiết kế 3 phòng ngủ, đồ cơ bản: Điều hòa âm trần, sàn gỗ, nóng lạnh, kệ tủ bếp. Giá 18 triệu/tháng.\n- Căn hộ 128m2, thiết kế 3 phòng ngủ, full đồ, nội thất đẹp chỉ việc mang quần áo đến ở. Giá 22 triệu/tháng.\n- Căn hộ 145m2, thiết kế 3 phòng ngủ, full đồ, nội thất sang trọng, chỉ việc mang quần áo đến ở. Giá 25 triệu/tháng.\n\n+ Vị trí: Tòa nhà D. \'Le Pont D\'or 36 Hoàng Cầu chủ đầu tư Tân Hoàng Minh, cạnh hồ Hoàng Cầu giao thông thuận lợi. Tọa lạc tại vị trí đắc địa bậc nhất thủ đô, nằm bên hồ Hoàng Cầu, tòa tháp căn hộ cao cấp D\'. Le Pont D\'or Hoàng Cầu được xây dựng và thiết kế theo phong cách Tân Cổ Điển đã thiết lập tiêu chuẩn mới cho cuộc sống đô thị hiện đại ở Việt Nam.\n+ Tiện ích: Tòa nhà có hệ thống an ninh tốt. Có bể bơi bốn mùa tại tầng 2. Có siêu thị nhà hàng, spa, gym.\nQuý khách hãy liên hệ sớm với chúng tôi để nhanh chóng tìm được căn hộ ưng ý nhất nhé.\nBan Quản Lý tòa nhà : Mr Mạnh.\nMobile: 0936.386.595 or 0974.548.024 ( MTG).\nChân thành cảm ơn quý khách hàng đã quan tâm!', 6, NULL, NULL, NULL, '2019-11-12 14:30:58.509167', '2019-11-12 14:30:58.509167');
INSERT INTO `room_group` VALUES (85, 61, NULL, 7500000, 1, 63, 2, 1, 2, 'Tây Bắc', NULL, NULL, 7000000, 'Cho thuê căn hộ chung cư mini Xã Đàn mới xây Phường Ô chợ Dừa, khu vực dân trí cao, đi lại thuận tiện ô tô đỗ cửa...\nDiện tích từ 26m2 - 35m2,1 phòng ngủ, sàn gỗ, nóng lạnh,điều hòa, tivi, ttur lạnh, máy giặt, có tủ quần áo, giường, có bếp từ, bàn bếp, Tủ bếp hút mùi, truyền hình cáp,internet wifi, điện nước đầy đủ công tơ riêng, tầng hầm để xe, nhà mới sạch sẽ thoáng mát,an ninh tốt,có bảo vệ 24/24 \nphù hợp hộ gia đình trẻ, chìa khóa trao tay,\ngiá 3.5 triệu nội thất cơ bản, 4,5 triệu / tháng đủ đồ tivi, tủ lạnh, máy giặt  ....\n\nliên hệ ngay gặp MR. Hùng 0963 488 688.', 4, NULL, NULL, NULL, '2019-11-12 14:30:59.470461', '2019-11-12 14:30:59.470461');
INSERT INTO `room_group` VALUES (86, 62, NULL, 12500000, 1, 56, 3, 2, 1, 'Đông', NULL, NULL, 10000000, 'BQL cần cho thuê một số căn hộ chung cư tại Hoàng Cầu Skyline, 36 Hoàng Cầu - Dự án của Tân Hoàng Cầu, Đống Đa, Hà Nội giá từ 14 triệu/tháng với diện tích từ 67m2 - 130m2:\n* Căn hộ đồ cơ bản.\n- 130m2: 3 PN, 2 vệ sinh, giá 18 triệu/tháng.\n- 112m2: 3 PN, 2 vệ sinh, giá 17 triệu/tháng.\n- 67m2: 2 PN, 2 vệ sinh, giá 14 triệu/tháng.\n- 85m2: 2 PN, 2 vệ sinh, giá 15 triệu/tháng.\n- 92m2: 2 PN, 2 vệ sinh, giá 16 triệu/tháng.\n\n* Căn hộ đầy đủ đồ: 02 ti vi, đầy đủ giường ngủ, bàn ghế sofa, bàn ghế ăn, bếp từ - Hệ thống tủ bếp hiện đại, máy giặt Electrolux, thiết bị vệ sinh TOTO, bình nóng lạnh, tủ âm tường, tủ quần áo, kệ đầu giường, điều hòa Daikin 2 chiều. Khách chỉ cần mang quần áo đến ở.\n- 130m2: 3 PN, 2 vệ sinh, giá 20 triệu/tháng.\n- 112m2: 3 PN, 2 vệ sinh, giá 19 triệu/tháng.\n- 67m2: 2 PN, 2 vệ sinh, giá 16 triệu/tháng.\n- 85m2: 2 PN, 2 vệ sinh, giá 17 triệu/tháng.\n- 92m2: 2 PN, 2 vệ sinh, giá 18 triệu/tháng.\n\nTiện ích của tòa nhà: Gym, bể bơi, siêu thị Minh Hoa, nhà trẻ quốc tế, hầm để xe rộng rãi, an ninh tốt, bộ phận lễ tân chuyên nghiệp.\n\nXin liên hệ: 0971. 216. 995 gặp Ms Chinh để được tư vấn và xem nhà.\nMiễn phí hoàn toàn cho khách thuê.\nCảm ơn đã đọc tin và MTG.', 4, NULL, NULL, NULL, '2019-11-12 14:31:01.171001', '2019-11-12 14:31:01.171001');
INSERT INTO `room_group` VALUES (87, 63, NULL, 15000000, 1, 100, 3, 3, 1, 'Tây', NULL, NULL, 10000000, 'Có phòng cho thuê chung cư mini 7 tầng, ngõ 43 Chùa Bộc.\n- Diện tích 17m2 - 21m2 - 25m2 khép kín (có điều hòa, nóng lạnh).\n- Giá phòng 1,500,000/th - 1,800,000/th - 2tr/th - 2,500,000/ tháng. (nhà trọ cho thuê).\n- Có phòng to full đồ 3 tr/th và 3,5 triệu/th.\n- Phòng rất gần trường Ngân Hàng, Y, Công Đoàn, Thủy Lợi.\n- Phòng trọ thoáng mát sạch sẽ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặt... ) phục vụ cho các bạn cáp, nét (mạng cáp quang) đầy đủ. Điện nước đầy đủ và được tính theo đồng hồ để cho các bạn yên tâm về số lượng mình dùng. Đặc biệt bảo vệ 24.24 nên an ninh đảm bảo yên tâm 100% nhé.\n- Liên hệ: 0352.761.017 (cô Hoa).', 5, NULL, NULL, NULL, '2019-11-12 14:31:02.000205', '2019-11-12 14:31:02.000205');
INSERT INTO `room_group` VALUES (88, 64, NULL, 15000000, 1, 90, 3, 3, 1, '', NULL, NULL, 10000000, 'Chung cư mini số 22 Tôn Thất Tùng cần cho thuê phòng:\n- Giá cả 2,2 triệu/tháng - 2,3tr/th - 2,5tr/th - 3tr/th.\n- Diện tích 22m2 - 25m2 - 27m2 - 30m2.\n- Tiện nghi các phòng đều khép kín, tùy theo mức giá có nóng lạnh, điều hòa, vòi hoa sen chậu rửa, sàn ốp đá hoa cao cấp, ban công cửa sổ thoáng đãng, nấu ăn trong phòng. Khu dân trí cao an ninh tốt. Có bảo vệ 24/24 tiện chợ, gần đường lớn.\nỞ riêng chủ, bạn bè phụ huynh đến chơi thoải mái.\nƯu tiên sinh viên hoặc người đi làm.\nLiên hệ: Chú Tân (cô Mai) 0375147121 (miễn tiếp trung gian).', 4, NULL, NULL, NULL, '2019-11-12 14:31:48.794297', '2019-11-12 14:31:48.794297');
INSERT INTO `room_group` VALUES (89, 65, NULL, 12500000, 1, 110, 3, 2, 1, '', NULL, NULL, 12000000, 'Địa chỉ: Số 35A ngõ 7 Thái Hà, Hà Nội.\nLH Anh Chiến 0936412192 (xem phòng từ 7h45p - 18h10).\nMình còn 2 loại phòng cho thuê ở được luôn. Rất gần ĐH Công Đoàn, Thủy Lợi, Ngân Hàng, Y Hà Nội.\n- Phòng nhỏ giá: 2.5tr - 3tr/th.\n- Phòng to giá: 3,5tr - 4.5tr/th.\n- An ninh rất tốt, xe để tầng 1.\nƯu tiên sinh viên, người đi làm hiền lành ở.\nPhòng cho thuê gần phố Tây Sơn, Thái Thịnh, Chùa Bộc.', 4, NULL, NULL, NULL, '2019-11-12 14:31:47.923114', '2019-11-12 14:31:47.923114');
INSERT INTO `room_group` VALUES (90, 66, NULL, 25000000, 1, 80, 4, 3, 1, '', NULL, NULL, 20000000, '- Nhà xây kiểu chung cư 6 tầng, phòng khép kín, có nóng lạnh.\n- Diện tích 18m2 - 20m2 - 25m2.\n- Giá 1.600.000/th - 1,800,000/th - 2.000.000đ/ tháng.\n\n- Phòng thoáng mát sạch sẽ, ban công, cửa sổ, có chỗ để xe rộng free, có chỗ nấu ăn và đầy đủ tiện nghi (vòi hoa sen, chậu rửa mặt... ) miễn phí net. Điện 3.500/số, nước 20.000/khối.\n\nLiên hệ: Chị Trang: 0327.946.467. Bác Tuấn BV: 0961.085.122 (MTG).', 4, NULL, NULL, NULL, '2019-11-12 14:31:47.043086', '2019-11-12 14:31:47.043086');
INSERT INTO `room_group` VALUES (91, 67, NULL, 15000000, 1, 67, 3, 3, 1, '', NULL, NULL, 10000000, 'Cho thuê phòng trọ ở ngõ 580 Trường Chinh.\nNhà mình còn 3 phòng trọ khép kín muốn cho sinh viên hoặc người đi làm thuê.\nDT: 15m2 - 18m2 - 22m2.\nGiá 1,5tr/th - 1,8tr/th - 2,2tr/th.\nTrong phòng có nóng lạnh, kệ bếp, bồn rửa sạch sẽ, ban công thoáng mát.\nAi có nhu cầu thuê thì liên hệ: A. Hưng: 0345.064.289/ chị Nhài: 0966.066.281 (miễn trung gian).', 4, NULL, NULL, NULL, '2019-11-12 14:31:46.184506', '2019-11-12 14:31:46.184506');
INSERT INTO `room_group` VALUES (92, 68, NULL, 23000000, 1, 78, 4, 2, 1, '', NULL, NULL, 23000000, 'Chung cư mini thang máy 7 tầng.\nCòn phòng giá 3tr/th - 3,5tr/th - 4tr/th diện tích từ 25m2 đến 40 m2 có đủ điều hòa, nóng lạnh, phòng to có thêm giường, tủ tất cả phòng đều khép kín, kệ bếp, tủ bếp. Phòng thoáng mát, an ninh tốt có bảo vệ trông xe.\nLiên hệ: Chị Hồng: 0961.085.122 anh Minh: 0352.764.159 (MTG).', 5, NULL, NULL, NULL, '2019-11-12 14:31:44.506887', '2019-11-12 14:31:44.506887');
INSERT INTO `room_group` VALUES (93, 69, NULL, 17000000, 1, 102, 3, 3, 1, '', NULL, NULL, 10000000, '- Nhà mình có 4 phòng trọ muốn cho sinh viên và người đi làm thuê.\n- DT: 18m2 - 22m2 - 25m2 - 30m2 - 35m2.\n- Giá: 1,7 tr/th - 2tr/th - 2,2 tr/th - 2,5tr/th - 2,8tr/th - 3,2tr/th là có điều hòa).\n- Trong phòng đã trang bị đầy đủ tiện nghi điều hòa, nóng lạnh, giường, nhà vệ sinh sạch sẽ, có ban công thoáng mát.\n- Địa chỉ: Ngõ 131B Tôn Đức Thắng.\nLiên hệ: Cô Thức 0352761017 (MTG).', 5, NULL, NULL, NULL, '2019-11-12 14:31:45.108384', '2019-11-12 14:31:45.108384');
INSERT INTO `room_group` VALUES (94, 70, NULL, 15000000, 1, 90, 3, 3, 1, '', NULL, NULL, 15000000, 'Nhà 6 tầng, đang còn phòng ở tầng 2, tầng 4.\nNhà sạch sẽ, thoáng mát.\nĐiện nước: Có công tơ riêng.\nPhòng nhỏ giá: 2.5tr/th - 3tr/th.\nPhòng to giá: 4.2tr/th.\nVệ sinh khép kín, có cả nóng lạnh, điều hòa, giường.\nĐịa chỉ: Số 75E ngõ Thổ Quan, Khâm Thiên, Hà Nội (Nhà cho thuê gần phố Xã Đàn, Tôn Đức Thắng, Ô Chợ Dừa).\nChỉ ở 2 người/phòng.\nĐT Anh Tuấn 0936412192 (liên hệ xem phòng báo trước 30p).\nPhòng cho thuê gần trường Bách Khoa, Công Đoàn, Mỹ Thuật, Văn Hóa.', 4, NULL, NULL, NULL, '2019-11-12 14:31:43.086176', '2019-11-12 14:31:43.086176');
INSERT INTO `room_group` VALUES (95, 71, NULL, 5500000, 3, 60, 3, 3, NULL, 'Đông Nam', NULL, NULL, 3000000, 'Nhà to mặt tiền\n', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `room_group` VALUES (96, 72, NULL, 6500000, 1, 120, 2, 2, 1, 'Nam', NULL, NULL, 6000000, 'Nhà đẹp', 4, NULL, NULL, NULL, '2019-11-12 14:31:39.295642', '2019-11-12 14:31:39.295642');
INSERT INTO `room_group` VALUES (97, 73, NULL, 4500000, 1, 100, 2, 1, 1, 'Đông', NULL, NULL, 4000000, 'Nhà mới đẹp tiện nghi', 3, NULL, NULL, NULL, '2019-11-12 14:31:38.251664', '2019-11-12 14:31:38.251664');
INSERT INTO `room_group` VALUES (98, 74, NULL, 8500000, 2, 70, 3, 2, 1, 'Nam', NULL, NULL, 3000000, 'Tầng cao chót vót', 3, NULL, NULL, NULL, '2019-11-12 14:31:37.434822', '2019-11-12 14:31:37.434822');
INSERT INTO `room_group` VALUES (99, 75, NULL, 7500000, 3, 100, 3, 3, 1, 'Tây Bắc', NULL, NULL, 2000000, 'Vip ', 4, NULL, NULL, NULL, '2019-11-12 14:31:35.144927', '2019-11-12 14:31:35.144927');
INSERT INTO `room_group` VALUES (100, 76, NULL, 3500000, 3, 100, 3, 3, 1, 'Đông', NULL, NULL, 2000000, 'Nhà đẹp', 3, NULL, NULL, NULL, '2019-11-12 14:31:35.925827', '2019-11-12 14:31:35.925827');
INSERT INTO `room_group` VALUES (101, 77, NULL, 6500000, 3, 100, 2, 3, 1, 'Nam', NULL, NULL, 7000000, 'Nhà vip', 3, NULL, NULL, NULL, '2019-11-12 14:31:33.253787', '2019-11-12 14:31:33.253787');
INSERT INTO `room_group` VALUES (102, 78, NULL, 7000000, 3, 100, 3, 3, 1, 'Đông', NULL, NULL, 3000000, 'Nhà đẹp', 3, NULL, NULL, NULL, '2019-11-12 14:31:32.494053', '2019-11-12 14:31:32.494053');
INSERT INTO `room_group` VALUES (103, 79, NULL, 5500000, 1, 100, 3, 3, 1, 'Nam', NULL, NULL, 3000000, 'Big house', 3, NULL, NULL, NULL, '2019-11-12 14:31:31.905534', '2019-11-12 14:31:31.905534');
INSERT INTO `room_group` VALUES (104, 80, NULL, 7500000, 3, 60, 2, 2, 1, 'Tây Nam', NULL, NULL, 3000000, 'Nhà nguyên căn giá rẻ', 3, NULL, NULL, NULL, '2019-11-12 14:31:31.155262', '2019-11-12 14:31:31.155262');
INSERT INTO `room_group` VALUES (105, 81, NULL, 5500000, 1, 80, 3, 3, 1, 'Tây', NULL, NULL, 5000000, 'Nhà phong thủy', 4, NULL, NULL, NULL, '2019-11-12 14:31:30.508914', '2019-11-12 14:31:30.508914');
INSERT INTO `room_group` VALUES (106, 82, NULL, 5500000, 2, 50, 3, 2, 1, 'Nam', NULL, NULL, 3000000, 'Nhà super đẹp', 3, NULL, NULL, NULL, '2019-11-12 14:31:28.322703', '2019-11-12 14:31:28.322703');
INSERT INTO `room_group` VALUES (107, 83, NULL, 4500000, 2, 70, 3, 2, 1, 'Đông', NULL, NULL, 4000000, 'Nhà 3 tầng to có bảo vệ', 2, NULL, NULL, NULL, '2019-11-12 14:31:28.970961', '2019-11-12 14:31:28.970961');
INSERT INTO `room_group` VALUES (108, 84, NULL, 5500000, 1, 30, 2, 3, 1, 'Đông', NULL, NULL, 2500000, 'Nhà phù hợp cho vợ chồng mới cưới', 3, NULL, NULL, NULL, '2019-11-12 14:31:26.726773', '2019-11-12 14:31:26.726773');
INSERT INTO `room_group` VALUES (109, 85, NULL, 4500000, 1, 100, 1, 1, 1, 'Đông', NULL, NULL, 2000000, 'chung cư Sunancora đã full đầy đủ các tiện ích của một chung cư 5 sao, ban quản lí căn hộ là đơn vị nước ngoài, là sự lựa chọn của những cư dân hiện đại.', 2, NULL, NULL, NULL, '2019-11-12 14:31:26.077306', '2019-11-12 14:31:26.077306');
INSERT INTO `room_group` VALUES (110, 86, NULL, 6000000, 1, 100, 2, 1, 1, 'Đông Bắc', NULL, NULL, 2000000, '* Căn 90m2 - 115m2, 3PN, 2WC, PK và khu bếp:\nNguyên bản(đã có điều hòa). Giá 13tr/th - 14tr/th.\nLắp thêm đồ cơ bản, full tủ bếp, bình nước nóng. Giá 14tr/th - 15tr/th.\nLắp full đồ chỉ cần xách vali vào ở. Giá 18tr/th - 20tr/th.', 3, NULL, NULL, NULL, '2019-11-12 14:31:25.344166', '2019-11-12 14:31:25.344166');
INSERT INTO `room_group` VALUES (111, 87, NULL, 3500000, 1, 200, 3, 2, 1, 'Tây', NULL, NULL, 2000000, 'Nội thất cơ bản: Bếp, nóng lạnh, điều hòa.', 5, NULL, NULL, NULL, '2019-11-12 14:31:24.476426', '2019-11-12 14:31:24.476426');
INSERT INTO `room_group` VALUES (112, 88, NULL, 7500000, 1, 70, 2, 1, 1, 'Tây Bắc', NULL, NULL, 3000000, 'Nhà còn phòng cho thuê khép kín đủ điều hòa, nóng lạnh, giường, giá 3tr - 3,5tr - 4 tr/th.\nNgay cạnh Bách - Kinh - Xây đi bộ 5p. Nhà riêng chủ, tự do.', 5, NULL, NULL, NULL, '2019-11-12 14:31:23.808997', '2019-11-12 14:31:23.808997');
INSERT INTO `room_group` VALUES (113, 89, NULL, 1500000, 1, 170, 3, 1, 1, 'Tây Bắc', NULL, NULL, 1000000, 'Hiện tôi đang có 2 căn hộ Duplex 2 ngủ và 3 ngủ full đồ mặt phố Thọ Lão, Lò Đúc.\n- Diện tích: 170m2.\n- Nội thất đầy đủ, chỉ việc xách vali vào ở.\n- Có 3 nhà vệ sinh, bếp, phòng khách và ban công rộng.\n- Giá: 21 triệu/tháng.\n- Free: internet, TV, dọn phòng, an ninh, thang máy.', 7, NULL, NULL, NULL, '2019-11-12 14:31:23.185570', '2019-11-12 14:31:23.185570');
INSERT INTO `room_group` VALUES (114, 90, NULL, 5500000, 1, 100, 1, 1, 1, 'Tây', NULL, NULL, 3000000, 'Cho thuê nhà TT ngõ 627 Giải Phóng( cách ĐH Kinh tế 500m),\nTầng 5( tầng trên cùng nhưng không nóng vì nhà 2 mái), DT 80m2, 2PN, 2 ban công, 1 PK, bếp, wc.\nCó chỗ để 2 xe máy riêng của nhà ở tầng 1( tiết kiệm được 500N/tháng)\nĐiện nước tính theo công tơ, ngay cạnh trường ĐH kinh tế quốc dân, ĐH bách khoa, ĐH Xây dựng\nPhù hợp với người đi làm, các bạn sinh viên, hộ GĐ ở\nGiá 5 triệu/tháng\nLH: A Nam Tel\nĐ/c: 627 Giải phóng, Đồng tâm, Hai bà trưng, Hà nội', 2, NULL, NULL, NULL, '2019-11-12 14:31:22.534038', '2019-11-12 14:31:22.534038');
INSERT INTO `room_group` VALUES (115, 91, NULL, 6500000, 2, 100, 4, 3, 1, 'Tây Nam', NULL, NULL, 3000000, 'Chính chủ cho thuê 1 phòng tầng 3 tại Tomhouse khu Đê Trần Khát Chân, Q Hai Bà Trưng\nđiện 2.3K/số, nước 70k/người, mạng 80k/phòng, vệ sinh 20k/phòng. Phòng khép kín gồm điều hoà, bếp, nhà vệ sinh riêng, nóng lạnh, quạt trần, rèm, không chung chủ, ra vào chủ động khoá vân tay, để xe tầng 1. Camera an ninh, khu dân cư gần chợ trường\nGiá 3.6 triệu/tháng, đóng 3T cọc 1 tháng', 5, NULL, NULL, NULL, '2019-11-12 14:31:21.911584', '2019-11-12 14:31:21.911584');
INSERT INTO `room_group` VALUES (116, 92, NULL, 10500000, 1, 100, 1, 1, 1, 'Đông Nam', NULL, NULL, 4000000, 'Cho sinh viên hoặc người đi làm thuê căn hộ mini\nDiện tích 23-30m2\nKhép kín; nội thất đầy đủ chỉ việc xách vali vào ở\ncho cả khách nước ngoài thuê\nđiện nước cáp mạng khỏe.\nGiá thuê từng căn hộ từ 4tr- 5tr/ 1 tháng\ngần ĐH Bách Khoa, Kinh Tế, Xây Dựng... Bệnh viện Bạch Mai, gần chợ Mơ.\nĐịa chỉ: phố Bạch Mai, quận Hai Bà Trưng, Hà Nội.', 2, NULL, NULL, NULL, '2019-11-12 14:31:21.192952', '2019-11-12 14:31:21.192952');
INSERT INTO `room_group` VALUES (117, 93, NULL, 4500000, 1, 60, 2, 1, 1, 'Tây', NULL, NULL, 2000000, 'Tin Môi giới đăng 3 giờ trước\nNhà phố 8/3 dt 30m2 x 4 tầng ,mt 7m\n4.700.000.000 đ- 30 m2\nLưu tin like\nNHÀ ĐẸP –MẶT TIỀN RỘNG – 3 THOÁNG – Ô TÔ TẢI ĐỖ CỬA.\nPhố 8/3 Hai Bà Trưng dt 30m2, 4 tầng mặt tiền 7m giá 4.7 tỷ\n✅Mô tả\n+ Vị trí đẹp từ nhà ra mặt phố chưa đầy 20m, 3 mặt thoáng, ô tô tải đỗ cửa.\n+ Nhà xây 4 tầng sàn - cầu thang ốp gỗ Lim bóng loáng. Mỗi tầng một phòng một phụ khép kín.\n- Tầng 1: p. khách, bếp, ăn, có thêm một diện tích hơn chục m2 làm sàn nước, cơi nới thêm sàn để xe máy ngoài nhà\n- Tầng 2,3: một phòng ngủ rộng + wc.\n- Tầng 4: p.thờ, sân phơi.\n- Các phòng đều có ban công rộng.\n- Nhà phù hợp kinh doanh Vp, TT tiếng anh hoặc gì cũng tốt\n- Sổ chính chủ, pháp lý rõ ràng.\n- Hướng Đông Bắc', 3, NULL, NULL, NULL, '2019-11-12 14:31:20.564254', '2019-11-12 14:31:20.564254');
INSERT INTO `room_group` VALUES (118, 94, NULL, 4000000, 2, 53, 2, 1, 1, 'Tây', NULL, NULL, 1500000, 'Diện tích 53m2: Phòng khách, phòng ngủ, bếp, vệ sinh và ban công (điều hòa, bình nóng lạnh, máy bơm...). Điện nước - Anh ninh tốt. Giá điện nước theo đồng hồ. Nhà ở có lộc, phù hợp gia đình thuê.', 4, NULL, NULL, NULL, '2019-11-12 14:31:19.864429', '2019-11-12 14:31:19.864429');
INSERT INTO `room_group` VALUES (119, 95, NULL, 5500000, 1, 100, 1, 1, 1, 'Đông', NULL, NULL, 3000000, 'Tiêu đề:\n\nBán nhà phố Thanh Nhàn, diện tích 46m2 x 5 tầng x mt 3.4m x giá 4.45 tỷ.\n\n+ Nhà mới xây, chắc chắn, đẹp khung BTCT.\n\n+ Đường trước nhà 2 xe máy tránh, ngõ thông các ngả.\n\n+ Nội thất nhà thiết kế sang trọng, hiện đại toàn đồ ngoại nhập.\n\n+ Tầng 1: Phòng khách + bếp + wc.\n\n+ Tầng 2,3,4: mỗi tầng 2 phòng + wc + giếng trời + 1 ban công.\n\n+ Tầng 5: là 2 sân phơi đã lợp mái tôn chống nóng.\n\n+ Nhà gần trường, bệnh viện, công viên, chợ, tiện ích đầy đủ….. giao thông đi lại cực thuận tiện.\n\n+ Khu dân trí cao, an ninh tốt', 2, NULL, NULL, NULL, '2019-11-12 14:31:19.153478', '2019-11-12 14:31:19.153478');
INSERT INTO `room_group` VALUES (120, 96, NULL, 5000000, 6, 60, 3, 3, 1, 'Đông Nam', NULL, NULL, 2000000, 'Căn hộ ccmini trần khát Chân - lò đúc - Kim Ngư.\nKhu vực giao thông thuận tiện, vào phố rất gần, dân trí cao. nhà có ban công cửa sổ Thoáng mát...\nDiện tích từ 35 - 42m2 + gác sép 18m2.\nCăn hộ khép kín.sàn gỗ, Điều hòa, vệ sinh nóng lạnh giường đệm tủ bàn ghế bếp trạn hút mùi. Đủ đồ vào ở luôn.\n+ phòng ngủ có cửa sổ và ban công thông thoáng.\n+ Phòng bếp được trang bi, bàn bếp, tủ bếp, chậu rửa bát, ….\n+ Khu vực nhà vệ sinh được lắp đầy đủ thiết bị hiện đại như chậu rửa mặt, bệt Inax, vòi sen, bình nóng lạnh...\nNhà để xe thang máy bảo vệ 24/24 an ninh tốt ra vào thoải mái.\nRất phù hợp với hộ gia đình, KD online...\nGiá thuê từ 4 - 5,5tr/th. Liên hệ ngay Mr Hùng', 4, NULL, NULL, NULL, '2019-11-12 14:31:18.547020', '2019-11-12 14:31:18.547020');
INSERT INTO `room_group` VALUES (121, 97, NULL, 12500000, 1, 100, 1, 1, 1, 'Đông Bắc', NULL, NULL, 6000000, 'Cho thuê căn hộ Pegasus full nội thất, đầy đủ tiện nghi\nCho Thuê Căn Hộ Pegasus Cao Cấp Full Nội Thất Giá Rẻ\n- Tòa nhà Pegasus trực thuộc tại vị trí trung tâm đắc địa, kh...', 2, NULL, NULL, NULL, '2019-11-12 14:31:17.854855', '2019-11-12 14:31:17.854855');
INSERT INTO `room_group` VALUES (122, 98, NULL, 6500000, 1, 100, 1, 1, 1, 'Đông', NULL, NULL, 3000000, '+ Mặt tiền: 4m.\n+ Nhà thiết kế 4 tầng, tổng 4 phòng ngủ.\n+ Diện tích cực rộng 65m, chủ mua nguyên bản thiết kế riêng cho ngôi nhà.\n+ Nhà cực gần phố, ngõ thông đường nào ra phố cũng tính bằng giây.\n+ Sổ đỏ chính chủ.\n+ Giá 4.4 tỷ ( có thương lượng).\nLH Mr Đức O971886291 (Tư vấn nhà, đất với 10.000 căn nhà khắp các quận huyện Hà Nội cam kết tìm nhà đúng với nhu cầu và hoàn toàn miễn phí)', 2, NULL, NULL, NULL, '2019-11-12 14:31:17.159629', '2019-11-12 14:31:17.159629');
INSERT INTO `room_group` VALUES (123, 99, NULL, 5500000, 1, 100, 1, 1, 1, 'Tây', NULL, NULL, 3000000, 'Bán nhà phố Thanh Nhàn quận Hai Bà Trưng diện tích rộng chỉ có 2.85 tỷ Quận Hai Bà Trưng\n\n+ Ngõ rộng 3m ra ngõ quỳnh hay phố Thanh Nhàn đều rất gần.\n+ Thiết kế tầng 2 phòng,\n+ Sổ vuông đẹp\n+ An Ninh yên tĩnh, trước nhà thoáng đãng.\n', 2, NULL, NULL, NULL, '2019-11-12 14:31:16.439322', '2019-11-12 14:31:16.439322');
INSERT INTO `room_group` VALUES (124, 100, NULL, 1500000, 1, 100, 1, 1, 1, 'Đông Nam', NULL, NULL, 1000000, '- Nhà 4 Tầng Chủ tự xây kiên cố rất đẹp, nội thất đầy đủ, tất cả các phòng đều có cửa ra ban công hóng gió và cửa sổ đón gió trời.\n+ Vị trí đẹp, khu phố đông đúc, anh sinh rất là tuyệt vời, 20m ra mặt đường ô tô.\n+ Thuận lợi đủ thứ, hưởng trọn mọi tiện ích của khu trung tâm gần Trường, chợ, bệnh viện Bạch Mai, Thanh Nhàn, giao thông thuận tiện đi các hướng gốc đề, Trương Định, Minh Khai, Tam Trinh, Hồ Đền Lừ....\n+ Sổ đỏ chính chủ, pháp lý đầy đủ.\n+ Giá: 2.3 tỷ ( có thương lượng, hỗ trợ vay vốn ngân hàng với lãi suất thấp ).\n- Thông tin chi tiết liên hệ xem nhà Em Lâm:', 2, NULL, NULL, NULL, '2019-11-12 14:31:15.800671', '2019-11-12 14:31:15.800671');
INSERT INTO `room_group` VALUES (125, 101, NULL, 2100000, 1, 15, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Dreamhouse 09 đang có 2 suất nam trống  tại 34 Trần Đại Nghĩa.\n\n????Bách Khoa -- Kinh tế - Xây Dựng????\n???? Nhà 7 tầng . Tầng 1 để xe, tầng 2 phòng bếp,. tầng 7 có ban công phơi đồ.\n\nĐầy đủ tiện nghi, điều hòa nóng lạnh,máy giặt,tủ lạnh,  (chỉ cần xách balo và ở).\n\n????Điện nước giá dân.\n????Giờ giấc thoải mái, không chung chủ.\n????Tham gia các khóa học, clb Tiếng Anh, teambuilding, …\n????Tạo môi trường ???? Rèn thói quen ???? Chắp cánh ước mơ????\n\n☎️Liên hệ  hoặc COMMENT số điện thoại để được tư vấn nhé các bạn.', 2, NULL, NULL, NULL, '2019-11-12 14:31:15.118914', '2019-11-12 14:31:15.118914');
INSERT INTO `room_group` VALUES (126, 101, NULL, 2500000, 1, 100, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Dreamhouse 09 đang có 2 suất nam trống  tại 34 Trần Đại Nghĩa.\n\n????Bách Khoa -- Kinh tế - Xây Dựng????\n???? Nhà 7 tầng . Tầng 1 để xe, tầng 2 phòng bếp,. tầng 7 có ban công phơi đồ.\n\nĐầy đủ tiện nghi, điều hòa nóng lạnh,máy giặt,tủ lạnh,  (chỉ cần xách balo và ở).\n\n????Điện nước giá dân.\n????Giờ giấc thoải mái, không chung chủ.\n????Tham gia các khóa học, clb Tiếng Anh, teambuilding, …\n????Tạo môi trường ???? Rèn thói quen ???? Chắp cánh ước mơ????\n\n☎️Liên hệ  hoặc COMMENT số điện thoại để được tư vấn nhé các bạn.', 2, NULL, NULL, NULL, '2019-11-12 14:31:14.433773', '2019-11-12 14:31:14.433773');
INSERT INTO `room_group` VALUES (127, 102, NULL, 2500000, 1, 100, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Môi trường an ninh, yên tĩnh, trung tâm thành phố. Không nấu ăn trong phòng.', 2, NULL, NULL, NULL, '2019-11-12 14:31:13.722188', '2019-11-12 14:31:13.722188');
INSERT INTO `room_group` VALUES (128, 103, NULL, 1800000, 1, 100, 1, 1, 1, 'all', NULL, NULL, 1000000, 'Nhà trọ giá rẻ, chủ nhà dễ tính, rất mong được đón tiếp các bạn sinh viên', 2, NULL, NULL, NULL, '2019-11-12 14:31:13.065511', '2019-11-12 14:31:13.065511');
INSERT INTO `room_group` VALUES (129, 104, NULL, 7500000, 1, 100, 1, 1, 1, 'Tây', NULL, NULL, 3000000, 'Phòng mới xây, có ban công và cửa sổ nên rất thoáng mát, có bếp, toilet riêng. Nội thất: máy lạnh, máy nước nóng, giường, tủ, nệp, drap.\nHẻm 2 xe hơi tránh nhau', 2, NULL, NULL, NULL, '2019-11-12 14:31:12.366133', '2019-11-12 14:31:12.366133');
INSERT INTO `room_group` VALUES (130, 105, NULL, 12500000, 1, 100, 1, 1, 1, 'Đông Bắc', NULL, NULL, 4000000, 'Gia đình tôi cần bán gấp nhà số 56 ngõ 197 Phố Mai Động, Minh Khai đi vào. Đường vào nhà ôtô chạy thẳng tắp, trước nhà thông rộng, xe bán tải vào nhà.\nDiện tích sổ đỏ 58m2, xây 5 Tầng mới cứng, (tổng DTSD 290m2), nhà nở hậu mở cửa thoáng trước sau. Thiết kế mỗi tầng hai phòng rộng, tầng một Gara ôtô vào nhà và mặt bằng kinh doanh. Gồm 6 phòng ngủ rộng lất gỗ Đức cao cấp, phòng ăn, phòng thờ, sân phơi riêng, 4WC VIP.', 2, NULL, NULL, NULL, '2019-11-12 14:31:11.726555', '2019-11-12 14:31:11.726555');
INSERT INTO `room_group` VALUES (131, 106, NULL, 1500000, 1, 100, 1, 1, 1, 'all', NULL, NULL, 1000000, '+Nhà nằm trong quận Hai Bà Trưng, gần khu đô thị Time CiTy là khu văn minh, giá 1 tỷ 800 triệu quá hiếm, khách cần mua nhà, nhanh tay bấm máy liên hệ đến xem nhà còn kịp mua. Chủ nhà thiện chí đón tiếp (giá thương lượng)', 2, NULL, NULL, NULL, '2019-11-12 14:31:11.055420', '2019-11-12 14:31:11.055420');
INSERT INTO `room_group` VALUES (132, 107, NULL, 8500000, 1, 100, 1, 1, 1, 'Đông Bắc', NULL, NULL, 5000000, 'Nhà gần trường học, gần chợ, gần Trung Tâm Time City, Bệnh viện VinMec Quốc tế, BV Thanh Nhàn, BV Bạch Mai..! 7 phút đi xe máy lên TT phố cổ, TT phố đi bộ Hồ Hoàn Kiếm, ra các ngả phố rất thuận tiện. Gần khu vui chơi giải trí, Vài phút ra các Trường Đại Học danh tiếng ĐH Bách Khoa; ĐH Kinh Tế; ĐH Xây Dựng...!', 2, NULL, NULL, NULL, '2019-11-12 14:31:10.441911', '2019-11-12 14:31:10.441911');
INSERT INTO `room_group` VALUES (133, 108, NULL, 6500000, 1, 100, 1, 1, 1, 'Đông', NULL, NULL, 2000000, ' Nhà gần chợ ô tô tránh nhau, khu vực kinh doanh sầm uất, ban công rộng\n+ Nhà xây chủ tự xây chắc chắn kiên cố, các phòng có anh sáng tự nhiên vào phòng\n+ Khách về chỉ sách va li về ở, nhà hiện đại đẹp lung linh.\n+ Nội thất sang chảnh, cao cấp, đầy đủ tiện nghi\n+ Pháp lý sạch, sổ đỏ đầy đủ, mát mẻ, thoáng, sang tên trong nốt nhạc\n+ Chủ thân thiện cán bộ về hưu, nhiệt tình bán về ở với con, vào việc ngay\n+ Tư vấn nhiệt tình miễn phí thủ tục sang tên, pháp lý và các thủ tục khác\n+ Các bạn môi giới và trung gian vui lòng không làm phiền', 2, NULL, NULL, NULL, '2019-11-12 14:31:09.714720', '2019-11-12 14:31:09.714720');
INSERT INTO `room_group` VALUES (134, 109, NULL, 1500000, 1, 100, 1, 1, 1, 'Đông', NULL, NULL, 1000000, '- Nhà gần chợ, sân bóng, nhà thi đấu Quận.\n- Thiết kế 4 tầng, bếp, khách, ngủ, thờ, sân phơi, xây khung bê tông cốt thép đầy đủ công năng.', 2, NULL, NULL, NULL, '2019-11-12 14:31:08.002714', '2019-11-12 14:31:08.002714');

-- ----------------------------
-- Table structure for room_image
-- ----------------------------
DROP TABLE IF EXISTS `room_image`;
CREATE TABLE `room_image`  (
  `image_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the image',
  `image_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL of the image',
  `room_group_id` int(2) NULL DEFAULT NULL COMMENT 'ID of room group of image',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`image_id`) USING BTREE,
  INDEX `FK_roomGroup_image`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_roomGroup_image` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 381 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_image
-- ----------------------------
INSERT INTO `room_image` VALUES (2, 'https://q-xx.bstatic.com/xdata/images/hotel/840x460/174379346.jpg?k=e7f909825cb86d6cf345cd5b0792257264f620199e384cd325b7457719dd6740&o=', 2, '2019-10-16 13:53:26.619273', '2019-10-16 13:53:26.619273');
INSERT INTO `room_image` VALUES (3, 'https://www.hoteljob.vn/files/Anh-HTJ-Hong/homestay-la-gi.jpg', 5, '2019-10-16 13:53:38.324897', '2019-10-16 13:53:38.324897');
INSERT INTO `room_image` VALUES (5, 'data:image/jpeg;base64,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', 5, '2019-10-16 13:53:45.146095', '2019-10-16 13:53:45.146095');
INSERT INTO `room_image` VALUES (6, 'data:image/jpeg;base64,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', 2, '2019-10-16 13:53:53.428359', '2019-10-16 13:53:53.428359');
INSERT INTO `room_image` VALUES (7, 'data:image/jpeg;base64,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', 2, '2019-10-16 13:56:57.560653', '2019-10-16 13:56:57.560653');
INSERT INTO `room_image` VALUES (8, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaE_E9_cCBiODGGhGC27ghBq6N1E9uMyOHWU1vFFMx-NvAQh5x', 2, NULL, NULL);
INSERT INTO `room_image` VALUES (9, 'https://storage.googleapis.com/room_images_bucket/17-10-2019-8-2.jpg', 8, NULL, NULL);
INSERT INTO `room_image` VALUES (10, 'https://storage.googleapis.com/room_images_bucket/17-10-2019-8-1.jpg', 8, NULL, NULL);
INSERT INTO `room_image` VALUES (11, 'https://storage.googleapis.com/room_images_bucket/17-10-2019-8-3.jpg', 8, NULL, NULL);
INSERT INTO `room_image` VALUES (12, 'https://storage.googleapis.com/room_images_bucket/23-10-2019-9-2.jpg', 9, NULL, NULL);
INSERT INTO `room_image` VALUES (13, 'https://storage.googleapis.com/room_images_bucket/23-10-2019-9-1.jpg', 9, NULL, NULL);
INSERT INTO `room_image` VALUES (14, 'https://storage.googleapis.com/room_images_bucket/23-10-2019-9-3.jpg', 9, NULL, NULL);
INSERT INTO `room_image` VALUES (15, 'https://storage.googleapis.com/room_images_bucket/23-10-2019-9-4.jpg', 9, NULL, NULL);
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

-- ----------------------------
-- Table structure for saved_room
-- ----------------------------
DROP TABLE IF EXISTS `saved_room`;
CREATE TABLE `saved_room`  (
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who saved the room',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of the saved room group',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`, `room_group_id`) USING BTREE,
  INDEX `FK_room_group_saved_room`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group_saved_room` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_saved_room` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of saved_room
-- ----------------------------
INSERT INTO `saved_room` VALUES (1, 2, NULL, NULL);

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service`  (
  `service_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the service',
  `icon_id` varchar(50) CHARACTER SET utf8mb4  NULL DEFAULT NULL,
  `service_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of the service',
  `description` text CHARACTER SET utf8mb4  NULL COMMENT 'Description of the service',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service
-- ----------------------------
INSERT INTO `service` VALUES (1, '1', 'Wifi', 'Internet access', '2019-10-23 12:18:47.727281', '2019-10-23 12:18:47.727281');
INSERT INTO `service` VALUES (2, '2', 'Điện', 'Giá điện', '2019-10-23 12:18:48.405884', '2019-10-23 12:18:48.405884');
INSERT INTO `service` VALUES (3, '3', 'Nước', 'Giá nước', '2019-10-23 12:18:49.143173', '2019-10-23 12:18:49.143173');
INSERT INTO `service` VALUES (4, '4', 'Bảo vệ', 'Bảo vệ vật tư', '2019-10-23 12:18:50.165008', '2019-10-23 12:18:50.165008');
INSERT INTO `service` VALUES (5, '5', 'Giặt đồ', 'Giặt quần áo', '2019-10-23 12:18:50.828194', '2019-10-23 12:18:50.828194');
INSERT INTO `service` VALUES (6, '6', 'Trông xe', 'Trông xe tại nhà', '2019-10-23 12:18:51.756663', '2019-10-23 12:18:51.756663');
INSERT INTO `service` VALUES (7, '7', 'Dọn vệ sinh', 'Dịch vụ dọn vệ sinh tận phòng', '2019-10-23 12:18:52.902631', '2019-10-23 12:18:52.902631');

-- ----------------------------
-- Table structure for tenant_review
-- ----------------------------
DROP TABLE IF EXISTS `tenant_review`;
CREATE TABLE `tenant_review`  (
  `review_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the review',
  `user_id` int(5) NOT NULL COMMENT 'ID of user who sends the review',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of reviewed room group',
  `comment` text CHARACTER SET utf8mb4  NULL COMMENT 'Content of the review',
  `accuracy_star` int(2) NULL DEFAULT NULL COMMENT 'Rating stars for accuracy',
  `host_star` int(2) NULL DEFAULT NULL COMMENT 'Rating stars for hosting',
  `security_star` int(2) NULL DEFAULT NULL COMMENT 'Rating stars for security',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`review_id`) USING BTREE,
  INDEX `FK_user_tenant_review`(`user_id`) USING BTREE,
  INDEX `FK_room_group_review`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group_review` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_tenant_review` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_review
-- ----------------------------
INSERT INTO `tenant_review` VALUES (1, 1, 2, 'good ', 3, 4, 5, NULL, NULL);
INSERT INTO `tenant_review` VALUES (2, 1, 8, 'nice', 4, 5, 4, NULL, NULL);
INSERT INTO `tenant_review` VALUES (3, 2, 8, NULL, 5, 3, 3, NULL, NULL);

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction`  (
  `transaction_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the transaction',
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who make the transaction',
  `room_id` int(5) NOT NULL COMMENT 'ID of room in the transaction',
  `transaction_status` tinyint(1) NULL DEFAULT NULL COMMENT 'Status code of the transaction',
  `start_date` timestamp(6) NULL DEFAULT NULL COMMENT 'Start date of the transaction',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`transaction_id`) USING BTREE,
  INDEX `FK_User_Transaction`(`user_id`) USING BTREE,
  INDEX `FK_Room_Transaction`(`room_id`) USING BTREE,
  CONSTRAINT `FK_Room_Transaction` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_User_Transaction` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction
-- ----------------------------
INSERT INTO `transaction` VALUES (1, 1, 1, 1, NULL, '2019-10-08 21:14:41.938875', '2019-10-08 21:14:41.938875');
INSERT INTO `transaction` VALUES (2, 2, 214, 3, NULL, '2019-11-09 07:30:21.602885', '2019-11-09 07:30:21.602885');
INSERT INTO `transaction` VALUES (3, 2, 216, 2, NULL, '2019-11-09 07:30:23.519146', '2019-11-09 07:30:23.519146');
INSERT INTO `transaction` VALUES (12, 4, 7, 1, NULL, '2019-11-11 10:46:24.183653', '2019-11-11 10:46:24.183653');
INSERT INTO `transaction` VALUES (13, 2, 13, 2, NULL, NULL, NULL);
INSERT INTO `transaction` VALUES (14, 3, 14, 1, NULL, NULL, NULL);
INSERT INTO `transaction` VALUES (15, 5, 15, -1, NULL, NULL, NULL);
INSERT INTO `transaction` VALUES (16, 3, 9, 2, NULL, '2019-11-11 14:18:26.199203', '2019-11-11 14:18:26.000000');
INSERT INTO `transaction` VALUES (17, 4, 20, 2, NULL, '2019-11-11 17:33:13.847169', '2019-11-11 17:33:13.000000');
INSERT INTO `transaction` VALUES (18, 3, 22, 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the user',
  `first_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'First name of the user',
  `last_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Last name of the user',
  `phone_number` varchar(20) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Phone number of the user',
  `password` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Password of user',
  `phone_token` text CHARACTER SET utf8mb4  NULL COMMENT 'Phone token of the user',
  `role_admin` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Role of account login admin page',
  `gender` bit(1) NULL DEFAULT NULL COMMENT 'Gender of the user',
  `facebook_id` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Facebook ID of the user',
  `google_id` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Google ID of the user',
  `email` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Email of the user',
  `avatar` text CHARACTER SET utf8mb4  NULL COMMENT 'Avatar URL of the user',
  `address` text CHARACTER SET utf8mb4  NULL COMMENT 'Address of the user',
  `is_phone_number_verified` bit(1) NULL DEFAULT NULL COMMENT 'User phone number is verified or not',
  `is_selfie_verified` bit(1) NULL DEFAULT NULL COMMENT 'User selfie image is verified or not',
  `is_government_id_verified` bit(1) NULL DEFAULT NULL COMMENT 'User government id card is verified or not',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'User is verified or not',
  `is_host` bit(1) NULL DEFAULT NULL COMMENT 'User is host or not',
  `is_active` bit(1) NULL DEFAULT NULL COMMENT 'User is active or not',
  `balance` double(20, 0) NULL DEFAULT NULL COMMENT 'Balance of user in system',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (-1, 'error', 'error', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (1, 'Son update', 'Hoang', '1234', '1234', 'aa', NULL, b'1', 'bb', 'gg', 'email@gmail.com', 'https://l.messenger.com/l.php?u=https%3A%2F%2Fgw.alipayobjects.com%2Fzos%2Fantfincdn%2FXAosXuNZyF%2FBiazfanxmamNRoxxVxka.png&h=AT0ck4IoHYRmekYmMFJEFOwx820tkxW8yD_kacYFaZRmNu8M_RYFZ69jHKRUPeiy9-Bqq84W9uQEF6f5UPcdKmvmwRB-36RmI3t1DMtNvH8aoScuj-TzfD8zXHxaR1_Du8x9NGQe_bfNyWzWMsrxoQ', 'Hoa Lac', b'1', b'1', b'1', b'1', b'1', b'1', 0, '2019-11-02 05:37:51.457571', '2019-11-02 05:37:51.457571');
INSERT INTO `user` VALUES (2, 'Phong', 'Tran', '111', '1234', 'bb', NULL, b'1', 'phongfb', 'phonggg', 'phongemail@gmail.com', 'https://l.messenger.com/l.php?u=https%3A%2F%2Fgw.alipayobjects.com%2Fzos%2Fantfincdn%2FXAosXuNZyF%2FBiazfanxmamNRoxxVxka.png&h=AT0ck4IoHYRmekYmMFJEFOwx820tkxW8yD_kacYFaZRmNu8M_RYFZ69jHKRUPeiy9-Bqq84W9uQEF6f5UPcdKmvmwRB-36RmI3t1DMtNvH8aoScuj-TzfD8zXHxaR1_Du8x9NGQe_bfNyWzWMsrxoQ', 'Hanoi', b'0', b'1', b'1', b'0', b'1', b'1', 0, '2019-11-02 05:37:51.802284', '2019-11-02 05:37:51.802284');
INSERT INTO `user` VALUES (3, 'Son', 'Hoang', '+84378666520', '$2a$08$GrSTRfHhhDWgw7nfuW79X.cmLFaEBFMEl79VWdI0q6HrybashRy3C', '', NULL, b'1', 'example-facebook-id', 'example-google-id', 'example@homehouse.vn', 'https://l.messenger.com/l.php?u=https%3A%2F%2Fgw.alipayobjects.com%2Fzos%2Fantfincdn%2FXAosXuNZyF%2FBiazfanxmamNRoxxVxka.png&h=AT0ck4IoHYRmekYmMFJEFOwx820tkxW8yD_kacYFaZRmNu8M_RYFZ69jHKRUPeiy9-Bqq84W9uQEF6f5UPcdKmvmwRB-36RmI3t1DMtNvH8aoScuj-TzfD8zXHxaR1_Du8x9NGQe_bfNyWzWMsrxoQ', 'not yet', b'1', b'1', b'0', b'0', NULL, NULL, 0, '2019-11-04 10:55:11.643695', '2019-11-04 10:55:11.643695');
INSERT INTO `user` VALUES (4, 'Nguyễn Như', 'Thưởng', '+84986352227', '$2a$08$pxnIXujvT3B0stefDO27JeuLLkp/cJUtFjOcoS8adwCFwdUqD8KLa', '', NULL, b'1', 'example-facebook-id', 'example-google-id', 'example@homehouse.vn', 'https://l.messenger.com/l.php?u=https%3A%2F%2Fgw.alipayobjects.com%2Fzos%2Fantfincdn%2FXAosXuNZyF%2FBiazfanxmamNRoxxVxka.png&h=AT0ck4IoHYRmekYmMFJEFOwx820tkxW8yD_kacYFaZRmNu8M_RYFZ69jHKRUPeiy9-Bqq84W9uQEF6f5UPcdKmvmwRB-36RmI3t1DMtNvH8aoScuj-TzfD8zXHxaR1_Du8x9NGQe_bfNyWzWMsrxoQ', 'not yet', b'1', b'1', b'1', b'1', NULL, NULL, 500000, '2019-11-11 17:33:13.863559', '2019-11-11 17:33:13.863559');
INSERT INTO `user` VALUES (5, NULL, 'Admin', '+84123456789', '$2a$08$pxnIXujvT3B0stefDO27JeuLLkp/cJUtFjOcoS8adwCFwdUqD8KLa', '', 'admin', b'0', 'example-facebook-id', 'example-google-id', 'example@homohouse.vn', 'https://l.messenger.com/l.php?u=https%3A%2F%2Fgw.alipayobjects.com%2Fzos%2Fantfincdn%2FXAosXuNZyF%2FBiazfanxmamNRoxxVxka.png&h=AT0ck4IoHYRmekYmMFJEFOwx820tkxW8yD_kacYFaZRmNu8M_RYFZ69jHKRUPeiy9-Bqq84W9uQEF6f5UPcdKmvmwRB-36RmI3t1DMtNvH8aoScuj-TzfD8zXHxaR1_Du8x9NGQe_bfNyWzWMsrxoQ', NULL, NULL, NULL, NULL, b'1', NULL, b'1', 0, '2019-11-02 05:37:54.882924', '2019-11-02 05:37:54.882924');
INSERT INTO `user` VALUES (6, 'Son', 'Hoang', '+8484378666519', '$2a$08$Wd8L5dFB5vPt1G.Lonwxb..oGueiatpHMNRvIDkr1R8Yns2n89YiC', NULL, NULL, NULL, 'example-facebook-id', 'example-google-id', 'example@homohouse.vn', NULL, 'not yet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (7, 'Son', 'Hoang', '+84378666519', '$2a$08$4efge.QFugY9.PTlGU3aauRlOk138vl.jfnusfXgsP/BSFKpLcjJO', NULL, NULL, NULL, 'example-facebook-id', 'example-google-id', 'example@homohouse.vn', NULL, 'not yet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (8, 'A', 'Hihi', '+84367120251', '$2a$08$75fsq.dStbaxwmV.tZGyb.rfIaWpZxvudsdp9Lvagri3QTbiE0eCm', NULL, NULL, NULL, 'example-facebook-id', 'example-google-id', 'example@homohouse.vn', NULL, 'not yet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (9, 'Cầm', 'Sơn', '+84982604182', '$2a$08$5DV9nILO1yDpX6MnOiCauO8StcB6IQjNT3tiHnwi9HydZNmWOEX.K', NULL, NULL, NULL, 'example-facebook-id', 'example-google-id', 'example@homohouse.vn', NULL, 'not yet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (10, 'Phạm', 'Anh', '+84778364588', '$2a$08$pxnIXujvT3B0stefDO27JeuLLkp/cJUtFjOcoS8adwCFwdUqD8KLa', NULL, NULL, NULL, 'example-facebook-id', 'example-google-id', 'example@homohouse.vn', NULL, 'not yet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-11-09 08:14:34.620728', '2019-11-09 08:14:34.620728');
INSERT INTO `user` VALUES (11, 'Dinh', 'Viet', '+84386666428', '$2a$08$99JiW7wjIDrt8qNtCVCmheXTlAIGaWKw.i8CVnlaLjSLY0R1nWyKO', NULL, NULL, NULL, 'example-facebook-id', 'example-google-id', 'example@homohouse.vn', NULL, 'not yet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (16, 'alo', 'alo', '1234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user_verification_image
-- ----------------------------
DROP TABLE IF EXISTS `user_verification_image`;
CREATE TABLE `user_verification_image`  (
  `card_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the user card',
  `user_id` int(5) NOT NULL COMMENT 'ID of the user',
  `id_card_front_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL to the front side of the ID Lisence Card image',
  `id_card_back_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL to the back side of the ID Lisence Card image',
  `selfie_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL to the selfie image of the user',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`card_id`) USING BTREE,
  INDEX `FK_user_verification`(`user_id`) USING BTREE,
  CONSTRAINT `FK_user_verification` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_verification_image
-- ----------------------------
INSERT INTO `user_verification_image` VALUES (1, 1, 'front update', 'back', 'selfie', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
