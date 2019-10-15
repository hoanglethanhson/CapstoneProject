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

 Date: 16/10/2019 00:23:17
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
  `unsuable_name` varchar(255) DEFAULT NULL COMMENT 'Name of amenities when unusable',
  `description` text COMMENT 'Description for amenities',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`amenities_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of amenities
-- ----------------------------
BEGIN;
INSERT INTO `amenities` VALUES (1, 'kitchen', 'no kitchen', 'kitchen', NULL, NULL);
INSERT INTO `amenities` VALUES (2, 'window', 'no window', 'window', NULL, NULL);
INSERT INTO `amenities` VALUES (3, 'door', 'no door', 'door', NULL, NULL);
INSERT INTO `amenities` VALUES (4, 'balcony', 'no balcony', 'balcony', NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of building
-- ----------------------------
BEGIN;
INSERT INTO `building` VALUES (1, 'happy building', 1, b'1', 1, 'Hanoi', 'Thanh Xuan', 'Nhan Chinh', 'Tran Duy Hung', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:21:32.548677', '2019-10-14 07:21:32.548677');
INSERT INTO `building` VALUES (2, 'new building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Trung Liet', 'Nguyen Luong Bang', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:21:53.649250', '2019-10-14 07:21:53.649250');
INSERT INTO `building` VALUES (3, '3rd building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Hao Nam', 'Lang Ha', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:22:13.185435', '2019-10-14 07:22:13.185435');
INSERT INTO `building` VALUES (4, 'demo', 1, NULL, 3, 'Hà Nội', 'Ba Đình', 'Trúc Bạch', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 11:49:01.424403', '2019-10-15 11:49:01.424403');
INSERT INTO `building` VALUES (5, 'lo', 2, NULL, 3, 'default value', NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `building` VALUES (6, 'Chung cu landmark', 1, NULL, 3, 'Hà Nội', 'Hai Bà Trưng', 'Phố Huế', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 15:21:12.370719', '2019-10-15 15:21:12.370719');
INSERT INTO `building` VALUES (7, 'Demo 2', 1, NULL, 3, 'Hà Nội', 'Bắc Từ Liêm', 'Cổ Nhuế 2', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 15:24:05.752396', '2019-10-15 15:24:05.752396');
INSERT INTO `building` VALUES (8, 'demo 3', 1, NULL, 3, 'Hà Nội', 'Thanh Oai', 'Liên Châu', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 15:25:02.013384', '2019-10-15 15:25:02.013384');
INSERT INTO `building` VALUES (9, 'demo 3', 1, NULL, 3, 'Hà Nội', 'Phúc Thọ', 'Phúc Hòa', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 15:30:42.559741', '2019-10-15 15:30:42.559741');
INSERT INTO `building` VALUES (10, 'demo 4', 2, NULL, 3, 'Hà Nội', 'Thanh Oai', 'Liên Châu', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 15:31:34.269000', '2019-10-15 15:31:34.269000');
INSERT INTO `building` VALUES (11, 'Demo 6', 1, NULL, 3, 'Hà Nội', 'Phúc Thọ', 'Liên Hiệp', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 16:43:19.149898', '2019-10-15 16:43:19.149898');
INSERT INTO `building` VALUES (12, 'demo 7', 1, NULL, 3, 'Hà Nội', 'Thanh Oai', 'Tam Hưng', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 16:50:52.396232', '2019-10-15 16:50:52.396232');
INSERT INTO `building` VALUES (13, 'demo 8', 1, NULL, 3, 'Hà Nội', 'Phúc Thọ', 'Phúc Hòa', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 16:53:13.034774', '2019-10-15 16:53:13.034774');
INSERT INTO `building` VALUES (14, 'demo 9', 2, NULL, 3, 'Hà Nội', 'Thanh Oai', 'Tam Hưng', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 16:54:53.389704', '2019-10-15 16:54:53.389704');
INSERT INTO `building` VALUES (15, 'Demo 10', 1, NULL, 3, 'Hà Nội', 'Ứng Hòa', 'Hồng Quang', NULL, '12 giai phong', '20.9714041,105.8409441', 1, NULL, 1, '2019-10-15 17:04:39.600459', '2019-10-15 17:04:39.600459');
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
INSERT INTO `building_service` VALUES (1, 1, 150000, 'alo', '2019-10-14 13:55:46.189840', '2019-10-14 13:55:46.189840');
INSERT INTO `building_service` VALUES (1, 2, 120000, 'cyka', '2019-10-14 13:55:49.733079', '2019-10-14 13:55:49.733079');
INSERT INTO `building_service` VALUES (2, 2, 150000, NULL, '2019-10-10 08:40:30.762407', '2019-10-10 08:40:30.762407');
INSERT INTO `building_service` VALUES (14, 1, 310000, 'hiih1a', '2019-10-15 17:03:45.982000', '2019-10-15 17:03:45.982000');
INSERT INTO `building_service` VALUES (14, 2, 170000, 'dm', '2019-10-15 17:03:33.058000', '2019-10-15 17:03:33.058000');
INSERT INTO `building_service` VALUES (15, 1, 190000, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (15, 2, NULL, NULL, NULL, NULL);
INSERT INTO `building_service` VALUES (15, 3, 100000, 'rẻ nhất thị trường', NULL, NULL);
INSERT INTO `building_service` VALUES (15, 4, 15000, 'có quầy bán hàng', NULL, NULL);
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
INSERT INTO `building_type` VALUES (1, 'Căn hộ chung cư', '2019-10-15 11:48:14.672668', '2019-10-15 11:48:14.672668');
INSERT INTO `building_type` VALUES (2, 'Nhà nguyên căn', NULL, NULL);
INSERT INTO `building_type` VALUES (3, 'Khu nhà trọ', '2019-10-15 11:48:09.937463', '2019-10-15 11:48:09.937463');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room
-- ----------------------------
BEGIN;
INSERT INTO `room` VALUES (1, 5, '104', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
INSERT INTO `room` VALUES (2, 5, '102', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
INSERT INTO `room` VALUES (3, 5, '107', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room_group
-- ----------------------------
BEGIN;
INSERT INTO `room_group` VALUES (2, 1, b'1', 2000000, 100, 1, 1, 1, 'west', b'1', b'1', 1400000, 'Nha tro', 44, 4, 100, 100, b'1', '2019-10-14 07:19:24.327911', '2019-10-14 07:19:24.327911');
INSERT INTO `room_group` VALUES (5, 1, b'1', 2500000, 100, 1, 1, 1, 'east', b'1', b'1', 1400000, 'Nha tro', 44, 4, 100, 100, b'0', '2019-10-14 07:19:25.767869', '2019-10-14 07:19:25.767869');
INSERT INTO `room_group` VALUES (6, 2, b'1', 2500000, 100, 1, 1, 1, 'north', b'1', b'1', 1400000, 'Nha tro 3', 44, 4, 100, 100, b'0', '2019-10-14 07:19:28.656492', '2019-10-14 07:19:28.656492');
INSERT INTO `room_group` VALUES (7, 2, b'1', 2500000, 100, 1, 1, 1, 'south', b'1', b'1', 1400000, 'Nha tro 3', 44, 4, 100, 100, b'0', '2019-10-14 07:19:30.636991', '2019-10-14 07:19:30.636991');
COMMIT;

-- ----------------------------
-- Table structure for room_image
-- ----------------------------
DROP TABLE IF EXISTS `room_image`;
CREATE TABLE `room_image` (
  `image_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the image',
  `room_id` int(11) DEFAULT NULL COMMENT 'ID of the room that the image belongs to',
  `image_url` text COMMENT 'URL of the image',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`image_id`) USING BTREE,
  KEY `FK_room_image` (`room_id`) USING BTREE,
  CONSTRAINT `FK_room_image` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room_image
-- ----------------------------
BEGIN;
INSERT INTO `room_image` VALUES (2, 2, 'update link', '2019-10-08 20:23:40.626000', '2019-10-08 20:23:40.626000');
INSERT INTO `room_image` VALUES (3, 3, 'new image', '2019-10-08 20:23:40.626000', '2019-10-08 20:23:40.626000');
INSERT INTO `room_image` VALUES (5, 2, 'new image new', '2019-10-08 20:23:40.626000', '2019-10-08 20:23:40.626000');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of service
-- ----------------------------
BEGIN;
INSERT INTO `service` VALUES (1, 'Wifi', 'Internet access', NULL, NULL);
INSERT INTO `service` VALUES (2, 'Fan', 'Fan for life', NULL, NULL);
INSERT INTO `service` VALUES (3, 'Water', 'Water for life', NULL, NULL);
INSERT INTO `service` VALUES (4, 'Food', 'Food for life', NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'Son update', 'Hoang', '1234', '1234', 'aa', b'1', 'bb', 'gg', 'email@gmail.com', 'image', 'Hoa Lac', b'1', b'1', b'1', '2019-10-14 14:35:10.245687', '2019-10-14 14:35:10.245687');
INSERT INTO `user` VALUES (2, 'Phong', 'Tran', '111', '1234', 'bb', b'1', 'phongfb', 'phonggg', 'phongemail@gmail.com', 'image', 'Hanoi', b'1', b'1', b'1', '2019-10-14 14:35:12.166768', '2019-10-14 14:35:12.166768');
INSERT INTO `user` VALUES (3, 'Nguyễn Như', 'Thưởng', '+84986352227', '$2a$08$pxnIXujvT3B0stefDO27JeuLLkp/cJUtFjOcoS8adwCFwdUqD8KLa', '', NULL, 'example-facebook-id', 'example-google-id', 'example@homehouse.vn', NULL, 'not yet', NULL, NULL, NULL, '2019-10-15 11:46:56.066184', '2019-10-15 11:46:56.066184');
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
