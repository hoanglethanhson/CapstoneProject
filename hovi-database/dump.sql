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

 Date: 17/10/2019 11:37:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for amenities
-- ----------------------------
DROP TABLE IF EXISTS `amenities`;
CREATE TABLE `amenities` (
  `amenities_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of amenities',
  `usable_name` varchar(255) DEFAULT NULL COMMENT 'Name of amenities when usable',
  `unusable_name` varchar(255) DEFAULT NULL COMMENT 'Name of amenities when unusable',
  `description` text COMMENT 'Description for amenities',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`amenities_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of amenities
-- ----------------------------
BEGIN;
INSERT INTO `amenities` VALUES (1, 'Không chung chủ', 'Chung chủ', 'tự do khu nhà ở', '2019-10-17 04:16:34.555033', '2019-10-17 04:16:34.555033');
INSERT INTO `amenities` VALUES (2, 'Khép kín', 'Chung phòng tắm', 'Khu vực ở có khép kín hay k?', '2019-10-17 04:16:41.049699', '2019-10-17 04:16:41.049699');
INSERT INTO `amenities` VALUES (3, 'Ban công', '', 'Ban công phòng', '2019-10-17 04:16:51.958034', '2019-10-17 04:16:51.958034');
INSERT INTO `amenities` VALUES (4, 'Thang máy', '', '', '2019-10-17 04:17:00.315316', '2019-10-17 04:17:00.315316');
INSERT INTO `amenities` VALUES (5, 'Nuôi thú cưng', '', '', '2019-10-17 04:17:11.069493', '2019-10-17 04:17:11.069493');
INSERT INTO `amenities` VALUES (6, 'Nấu ăn', '', NULL, '2019-10-16 14:04:14.868071', '2019-10-16 14:04:14.868071');
INSERT INTO `amenities` VALUES (7, 'Điều hòa', '', NULL, '2019-10-16 14:04:16.611273', '2019-10-16 14:04:16.611273');
INSERT INTO `amenities` VALUES (8, 'Bình nóng lạnh', '', NULL, '2019-10-16 14:04:18.283788', '2019-10-16 14:04:18.283788');
INSERT INTO `amenities` VALUES (9, 'Giường', '', NULL, '2019-10-16 14:04:19.678413', '2019-10-16 14:04:19.678413');
INSERT INTO `amenities` VALUES (10, 'Tủ', '', NULL, '2019-10-16 14:04:21.396454', '2019-10-16 14:04:21.396454');
INSERT INTO `amenities` VALUES (11, 'Bàn ghế', '', NULL, '2019-10-16 14:04:22.829494', '2019-10-16 14:04:22.829494');
COMMIT;

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building` (
  `building_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of building',
  `building_name` varchar(255) DEFAULT NULL COMMENT 'name of the building',
  `building_type_id` int(2) DEFAULT NULL COMMENT 'ID of building type',
  `is_mix_gender` bit(1) DEFAULT NULL COMMENT 'Male and female can stays in the same room or not',
  `host_id` int(11) DEFAULT NULL COMMENT 'ID of host of building',
  `province` varchar(255) DEFAULT 'default value' COMMENT 'Province of the building',
  `district` varchar(255) DEFAULT NULL COMMENT 'District of the building',
  `ward` varchar(255) DEFAULT NULL COMMENT 'Ward of the building',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street of the building',
  `detailed_address` text COMMENT 'Detailed address of the building',
  `location` text COMMENT 'Location of the building',
  `floor_quantity` int(2) DEFAULT NULL COMMENT 'Number of floors in the building',
  `is_verified` bit(1) DEFAULT NULL COMMENT 'Building is verified or not',
  `is_completed` int(1) DEFAULT NULL COMMENT 'Number of completed steps in posting a room',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`building_id`) USING BTREE,
  KEY `FK_room_type_building` (`building_type_id`) USING BTREE,
  KEY `FK_user_building` (`host_id`) USING BTREE,
  CONSTRAINT `FK_type_building` FOREIGN KEY (`building_type_id`) REFERENCES `building_type` (`type_id`),
  CONSTRAINT `FK_user_building` FOREIGN KEY (`host_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of building
-- ----------------------------
BEGIN;
INSERT INTO `building` VALUES (1, 'happy building', 1, b'1', 1, 'Hanoi', 'Thanh Xuan', 'Nhan Chinh', 'Tran Duy Hung', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:21:32.548000', '2019-10-14 07:21:32.548000');
INSERT INTO `building` VALUES (2, 'new building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Trung Liet', 'Nguyen Luong Bang', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:21:53.649250', '2019-10-14 07:21:53.649250');
INSERT INTO `building` VALUES (3, '3rd building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Hao Nam', 'Lang Ha', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:22:13.185435', '2019-10-14 07:22:13.185435');
INSERT INTO `building` VALUES (4, 'Nhà trọ Thành Công', 3, NULL, NULL, 'Hà Nội', 'Hoàng Mai', 'Định Công', 'Định Công Hạ', '96A Định Công', '20.98470977059105,105.83861725767213', 4, NULL, 1, '2019-10-17 04:32:01.263736', '2019-10-17 04:32:01.263736');
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
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
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
INSERT INTO `building_service` VALUES (1, 1, 50000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (1, 3, 20000, NULL, '2019-10-16 15:59:50.363769', '2019-10-16 15:59:50.363769');
INSERT INTO `building_service` VALUES (1, 5, 30000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (2, 1, 100000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (2, 2, 150000, NULL, '2019-10-16 09:11:41.312164', '2019-10-16 09:11:41.312164');
INSERT INTO `building_service` VALUES (4, 1, 190000, '1 tháng', NULL, NULL);
INSERT INTO `building_service` VALUES (4, 2, 60000, '1 số điện', NULL, NULL);
INSERT INTO `building_service` VALUES (4, 3, 10000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (4, 4, 0, 'Chủ luôn ở nhà', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for building_type
-- ----------------------------
DROP TABLE IF EXISTS `building_type`;
CREATE TABLE `building_type` (
  `type_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room type',
  `building_type` varchar(255) DEFAULT NULL COMMENT 'Name of the type',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time ',
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
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`feedback_id`) USING BTREE,
  KEY `FK_user_feedback` (`user_id`) USING BTREE,
  CONSTRAINT `FK_user_feedback` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
BEGIN;
INSERT INTO `feedback` VALUES (1, 1, 'email', 'feedback', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for host_review
-- ----------------------------
DROP TABLE IF EXISTS `host_review`;
CREATE TABLE `host_review` (
  `review_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the review',
  `host_id` int(5) DEFAULT NULL COMMENT 'ID of the host who sends the review',
  `tenant_id` int(5) DEFAULT NULL COMMENT 'ID of targeted tenant of the review',
  `comment` text COMMENT 'Content of the comment',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`review_id`) USING BTREE,
  KEY `FK_user_host` (`host_id`) USING BTREE,
  KEY `FK_user_tenant` (`tenant_id`) USING BTREE,
  CONSTRAINT `FK_user_host` FOREIGN KEY (`host_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK_user_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of host_review
-- ----------------------------
BEGIN;
INSERT INTO `host_review` VALUES (1, 1, 2, 'good', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for reported_room
-- ----------------------------
DROP TABLE IF EXISTS `reported_room`;
CREATE TABLE `reported_room` (
  `user_id` int(5) NOT NULL COMMENT 'ID of user who sends the report',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of reported room group',
  `report_content` text COMMENT 'Content of the report',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`,`room_group_id`) USING BTREE,
  KEY `FK_room_report` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_report` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`),
  CONSTRAINT `FK_user_report` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of reported_room
-- ----------------------------
BEGIN;
INSERT INTO `reported_room` VALUES (1, 2, 'messy', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `room_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of group that room belongs to',
  `room_name` text COMMENT 'name of the room',
  `free_slot` int(5) DEFAULT NULL COMMENT 'Number of free slots in the room',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_id`) USING BTREE,
  KEY `FK_room_group` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room
-- ----------------------------
BEGIN;
INSERT INTO `room` VALUES (1, 5, '104', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
INSERT INTO `room` VALUES (2, 5, '102', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
INSERT INTO `room` VALUES (3, 5, '107', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
INSERT INTO `room` VALUES (4, 8, '201', NULL, NULL, NULL);
INSERT INTO `room` VALUES (5, 8, '202', NULL, NULL, NULL);
INSERT INTO `room` VALUES (6, 8, '301', NULL, NULL, NULL);
INSERT INTO `room` VALUES (7, 8, '302', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for room_amenities
-- ----------------------------
DROP TABLE IF EXISTS `room_amenities`;
CREATE TABLE `room_amenities` (
  `room_group_id` int(5) NOT NULL COMMENT 'ID of the room group',
  `amenities_id` int(5) NOT NULL COMMENT 'ID of amenities in the room group',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
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
  `aera` double(10,0) DEFAULT NULL COMMENT 'Area of the room group',
  `bedroom_quantity` int(5) DEFAULT NULL COMMENT 'Number of  bedrooms in the building',
  `bathroom_quantity` int(5) DEFAULT NULL COMMENT 'Number of bathrooms in the building',
  `wc_quantity` int(5) DEFAULT NULL COMMENT 'Number of WCs in the building',
  `direction` varchar(255) DEFAULT NULL COMMENT 'direction of the room',
  `is_available` bit(1) DEFAULT NULL COMMENT 'The group is available or not',
  `is_verified` bit(1) DEFAULT NULL COMMENT 'Room group is verified or not',
  `deposit_price` double(10,0) DEFAULT NULL COMMENT 'Deposit price of the room group',
  `description` varchar(10) DEFAULT NULL COMMENT 'Description of the room group',
  `capacity` int(10) DEFAULT NULL COMMENT 'Capacity of the room group',
  `quantity` int(10) DEFAULT NULL COMMENT 'Number of rooms in the room group',
  `view_amount` int(10) DEFAULT NULL COMMENT 'View amount of the room group',
  `phone_view_amount` int(10) DEFAULT NULL COMMENT 'View via phone amount of the room group',
  `is_sponsored` bit(1) DEFAULT NULL COMMENT 'The room group is sponsored or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_group_id`) USING BTREE,
  KEY `FK_room_group_building` (`building_id`) USING BTREE,
  CONSTRAINT `FK_room_group_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room_group
-- ----------------------------
BEGIN;
INSERT INTO `room_group` VALUES (2, 1, b'1', 2000000, 100, 1, 1, 1, 'west', b'1', b'1', 1400000, 'Nha tro', 44, 4, 100, 100, b'1', '2019-10-15 15:26:10.044681', '2019-10-15 15:26:10.044681');
INSERT INTO `room_group` VALUES (5, 1, b'1', 2500000, 100, 1, 1, 1, 'east', b'1', b'1', 1400000, 'Nha tro', 44, 4, 100, 100, b'0', '2019-10-15 15:26:17.303083', '2019-10-15 15:26:17.303083');
INSERT INTO `room_group` VALUES (6, 2, b'1', 2500000, 100, 1, 1, 1, 'north', b'1', b'1', 1400000, 'Nha tro 3', 44, 4, 100, 100, b'0', '2019-10-15 15:26:19.469810', '2019-10-15 15:26:19.469810');
INSERT INTO `room_group` VALUES (7, 2, b'1', 2500000, 100, 1, 1, 1, 'south', b'1', b'1', 1400000, 'Nha tro 3', 44, 4, 100, 100, b'0', '2019-10-15 15:26:22.861635', '2019-10-15 15:26:22.861635');
INSERT INTO `room_group` VALUES (8, 4, NULL, 1200000, 60, 1, 1, NULL, '- Điều hòa, sàn gỗ, giường tủ\n- Gần chợ, ĐH văn hóa, ĐH Mỹ thuật công nghiệp...\n- An ninh tốt, khu dân trí cao', NULL, NULL, 1000000, '', 3, 4, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for room_image
-- ----------------------------
DROP TABLE IF EXISTS `room_image`;
CREATE TABLE `room_image` (
  `image_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the image',
  `image_url` text COMMENT 'URL of the image',
  `room_group_id` int(2) DEFAULT NULL COMMENT 'ID of room group of image',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`image_id`) USING BTREE,
  KEY `FK_roomGroup_image` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_roomGroup_image` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room_image
-- ----------------------------
BEGIN;
INSERT INTO `room_image` VALUES (2, 'https://q-xx.bstatic.com/xdata/images/hotel/840x460/174379346.jpg?k=e7f909825cb86d6cf345cd5b0792257264f620199e384cd325b7457719dd6740&o=', 2, '2019-10-16 13:53:26.619273', '2019-10-16 13:53:26.619273');
INSERT INTO `room_image` VALUES (3, 'https://www.hoteljob.vn/files/Anh-HTJ-Hong/homestay-la-gi.jpg', 5, '2019-10-16 13:53:38.324897', '2019-10-16 13:53:38.324897');
INSERT INTO `room_image` VALUES (5, 'data:image/jpeg;base64,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', 5, '2019-10-16 13:53:45.146095', '2019-10-16 13:53:45.146095');
INSERT INTO `room_image` VALUES (6, 'data:image/jpeg;base64,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', 2, '2019-10-16 13:53:53.428359', '2019-10-16 13:53:53.428359');
INSERT INTO `room_image` VALUES (7, 'data:image/jpeg;base64,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', 2, '2019-10-16 13:56:57.560653', '2019-10-16 13:56:57.560653');
INSERT INTO `room_image` VALUES (8, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaE_E9_cCBiODGGhGC27ghBq6N1E9uMyOHWU1vFFMx-NvAQh5x', 2, NULL, NULL);
INSERT INTO `room_image` VALUES (9, 'https://storage.googleapis.com/room_images_bucket/17-10-2019-8-2.jpg', 8, NULL, NULL);
INSERT INTO `room_image` VALUES (10, 'https://storage.googleapis.com/room_images_bucket/17-10-2019-8-1.jpg', 8, NULL, NULL);
INSERT INTO `room_image` VALUES (11, 'https://storage.googleapis.com/room_images_bucket/17-10-2019-8-3.jpg', 8, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for saved_room
-- ----------------------------
DROP TABLE IF EXISTS `saved_room`;
CREATE TABLE `saved_room` (
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who saved the room',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of the saved room group',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`,`room_group_id`) USING BTREE,
  KEY `FK_room_group_saved_room` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group_saved_room` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`),
  CONSTRAINT `FK_user_saved_room` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of saved_room
-- ----------------------------
BEGIN;
INSERT INTO `saved_room` VALUES (1, 2, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service` (
  `service_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the service',
  `service_name` varchar(255) DEFAULT NULL COMMENT 'Name of the service',
  `description` text COMMENT 'Description of the service',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of service
-- ----------------------------
BEGIN;
INSERT INTO `service` VALUES (1, 'Wifi', 'Internet access', NULL, NULL);
INSERT INTO `service` VALUES (2, 'Điện', 'Giá điện', '2019-10-17 04:24:03.564839', '2019-10-17 04:24:03.564839');
INSERT INTO `service` VALUES (3, 'Nước', 'Giá nước', '2019-10-17 04:24:24.991304', '2019-10-17 04:24:24.991304');
INSERT INTO `service` VALUES (4, 'Bảo vệ', 'Bảo vệ vật tư', '2019-10-17 04:24:17.997308', '2019-10-17 04:24:17.997308');
INSERT INTO `service` VALUES (5, 'Giặt đồ', 'Giặt quần áo', '2019-10-17 04:15:54.875660', '2019-10-17 04:15:54.875660');
INSERT INTO `service` VALUES (6, 'Trông xe', 'Trông xe tại nhà', '2019-10-17 04:23:54.188797', '2019-10-17 04:23:54.188797');
INSERT INTO `service` VALUES (7, 'Dọn vệ sinh', 'Dịch vụ dọn vệ sinh tận phòng', '2019-10-17 04:24:12.897467', '2019-10-17 04:24:12.897467');
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
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`review_id`) USING BTREE,
  KEY `FK_user_tenant_review` (`user_id`) USING BTREE,
  KEY `FK_room_group_review` (`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group_review` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`),
  CONSTRAINT `FK_user_tenant_review` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tenant_review
-- ----------------------------
BEGIN;
INSERT INTO `tenant_review` VALUES (1, 1, 2, 'good ', 3, 4, 5, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `transaction_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the transaction',
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who make the transaction',
  `room_id` int(5) NOT NULL COMMENT 'ID of room in the transaction',
  `is_transited` bit(1) DEFAULT NULL COMMENT 'deposit money transited to host or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`transaction_id`) USING BTREE,
  KEY `FK_User_Transaction` (`user_id`) USING BTREE,
  KEY `FK_Room_Transaction` (`room_id`) USING BTREE,
  CONSTRAINT `FK_Room_Transaction` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`),
  CONSTRAINT `FK_User_Transaction` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of transaction
-- ----------------------------
BEGIN;
INSERT INTO `transaction` VALUES (1, 1, 1, b'1', '2019-10-08 21:14:41.938875', '2019-10-08 21:14:41.938875');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the user',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'First name of the user',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Last name of the user',
  `phone` varchar(20) DEFAULT NULL COMMENT 'Phone number of the user',
  `password` varchar(255) DEFAULT NULL COMMENT 'Password of user',
  `phone_token` text COMMENT 'Phone token of the user',
  `gender` bit(1) DEFAULT NULL COMMENT 'Gender of the user',
  `facebook_id` varchar(255) DEFAULT NULL COMMENT 'Facebook ID of the user',
  `google_id` varchar(255) DEFAULT NULL COMMENT 'Google ID of the user',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email of the user',
  `avatar` text COMMENT 'Avatar URL of the user',
  `address` text COMMENT 'Address of the user',
  `is_verified` bit(1) DEFAULT NULL COMMENT 'User is verified or not',
  `is_host` bit(1) DEFAULT NULL COMMENT 'User is host or not',
  `is_active` bit(1) DEFAULT NULL COMMENT 'User is active or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'Son update', 'Hoang', '1234', '1234', 'aa', b'1', 'bb', 'gg', 'email@gmail.com', 'image', 'Hoa Lac', b'1', b'1', b'1', '2019-10-14 14:35:10.245687', '2019-10-14 14:35:10.245687');
INSERT INTO `user` VALUES (2, 'Phong', 'Tran', '111', '1234', 'bb', b'1', 'phongfb', 'phonggg', 'phongemail@gmail.com', 'image', 'Hanoi', b'1', b'1', b'1', '2019-10-14 14:35:12.166768', '2019-10-14 14:35:12.166768');
INSERT INTO `user` VALUES (3, 'Son', 'Hoang', '0378666519', '$2a$08$GrSTRfHhhDWgw7nfuW79X.cmLFaEBFMEl79VWdI0q6HrybashRy3C', '', NULL, 'example-facebook-id', 'example-google-id', 'example@homehouse.vn', NULL, 'not yet', NULL, NULL, NULL, '2019-10-16 14:59:24.194228', '2019-10-16 14:59:24.194228');
INSERT INTO `user` VALUES (4, 'Nguyễn Như', 'Thưởng', '+84986352227', '$2a$08$pxnIXujvT3B0stefDO27JeuLLkp/cJUtFjOcoS8adwCFwdUqD8KLa', '', NULL, 'example-facebook-id', 'example-google-id', 'example@homehouse.vn', NULL, 'not yet', NULL, NULL, NULL, '2019-10-15 11:46:56.066184', '2019-10-15 11:46:56.066184');
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
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`card_id`) USING BTREE,
  KEY `FK_user_verification` (`user_id`) USING BTREE,
  CONSTRAINT `FK_user_verification` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_verification_image
-- ----------------------------
BEGIN;
INSERT INTO `user_verification_image` VALUES (1, 1, 'front update', 'back', 'selfie', NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
