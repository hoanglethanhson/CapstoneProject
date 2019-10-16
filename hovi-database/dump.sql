/*
 Navicat Premium Data Transfer

 Source Server         : CP_DB
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3307
 Source Schema         : HoviDB

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 15/10/2019 22:10:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for amenities
-- ----------------------------
DROP TABLE IF EXISTS `amenities`;
CREATE TABLE `amenities`  (
  `amenities_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of amenities',
  `usable_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of amenities when usable',
  `unsuable_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of amenities when unusable',
  `description` text CHARACTER SET utf8mb4  NULL COMMENT 'Description for amenities',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`amenities_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of amenities
-- ----------------------------
INSERT INTO `amenities` VALUES (1, 'kitchen', 'no kitchen', 'kitchen', NULL, NULL);
INSERT INTO `amenities` VALUES (2, 'window', 'no window', 'window', NULL, NULL);
INSERT INTO `amenities` VALUES (3, 'door', 'no door', 'door', NULL, NULL);
INSERT INTO `amenities` VALUES (4, 'balcony', 'no balcony', 'balcony', NULL, NULL);

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
  `detailed_address` text CHARACTER SET utf8mb4  NULL COMMENT 'Detailed address of the building',
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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES (1, 'happy building', 1, b'1', 1, 'Hanoi', 'Thanh Xuan', 'Nhan Chinh', 'Tran Duy Hung', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:21:32.548000', '2019-10-14 07:21:32.548000');
INSERT INTO `building` VALUES (2, 'new building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Trung Liet', 'Nguyen Luong Bang', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:21:53.649250', '2019-10-14 07:21:53.649250');
INSERT INTO `building` VALUES (3, '3rd building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Hao Nam', 'Lang Ha', 'Detailed Hanoi', 'Hanoi location', 3, b'1', 0, '2019-10-14 07:22:13.185435', '2019-10-14 07:22:13.185435');

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
INSERT INTO `building_service` VALUES (2, 2, 150000, NULL, '2019-10-10 08:40:30.762407', '2019-10-10 08:40:30.762407');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building_type
-- ----------------------------
INSERT INTO `building_type` VALUES (1, 'Entire', NULL, NULL);

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
  `free_slot` int(5) NULL DEFAULT NULL COMMENT 'Number of free slots in the room',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `FK_room_group`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, 5, '104', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
INSERT INTO `room` VALUES (2, 5, '102', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');
INSERT INTO `room` VALUES (3, 5, '107', 5, '2019-10-08 21:08:23.550000', '2019-10-08 21:08:23.550000');

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
INSERT INTO `room_amenities` VALUES (2, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (2, 2, NULL, NULL);
INSERT INTO `room_amenities` VALUES (5, 1, NULL, NULL);
INSERT INTO `room_amenities` VALUES (5, 3, NULL, NULL);

-- ----------------------------
-- Table structure for room_group
-- ----------------------------
DROP TABLE IF EXISTS `room_group`;
CREATE TABLE `room_group`  (
  `room_group_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room group',
  `building_id` int(5) NULL DEFAULT NULL COMMENT 'ID of the building that the group belongs to',
  `gender` bit(1) NULL DEFAULT NULL COMMENT 'Gender in the group',
  `rent_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Rent price of the room group',
  `aera` double(10, 0) NULL DEFAULT NULL COMMENT 'Area of the room group',
  `bedroom_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of  bedrooms in the building',
  `bathroom_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of bathrooms in the building',
  `wc_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of WCs in the building',
  `direction` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'direction of the room',
  `is_available` bit(1) NULL DEFAULT NULL COMMENT 'The group is available or not',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'Room group is verified or not',
  `deposit_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Deposit price of the room group',
  `description` varchar(10) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Description of the room group',
  `capacity` int(10) NULL DEFAULT NULL COMMENT 'Capacity of the room group',
  `quantity` int(10) NULL DEFAULT NULL COMMENT 'Number of rooms in the room group',
  `view_amount` int(10) NULL DEFAULT NULL COMMENT 'View amount of the room group',
  `phone_view_amount` int(10) NULL DEFAULT NULL COMMENT 'View via phone amount of the room group',
  `is_sponsored` bit(1) NULL DEFAULT NULL COMMENT 'The room group is sponsored or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_group_id`) USING BTREE,
  INDEX `FK_room_group_building`(`building_id`) USING BTREE,
  CONSTRAINT `FK_room_group_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_group
-- ----------------------------
INSERT INTO `room_group` VALUES (2, 1, b'1', 2000000, 100, 1, 1, 1, 'west', b'1', b'1', 1400000, 'Nha tro', 44, 4, 100, 100, b'1', '2019-10-14 07:19:24.327911', '2019-10-14 07:19:24.327911');
INSERT INTO `room_group` VALUES (5, 1, b'1', 2500000, 100, 1, 1, 1, 'east', b'1', b'1', 1400000, 'Nha tro', 44, 4, 100, 100, b'0', '2019-10-14 07:19:25.767869', '2019-10-14 07:19:25.767869');
INSERT INTO `room_group` VALUES (6, 2, b'1', 2500000, 100, 1, 1, 1, 'north', b'1', b'1', 1400000, 'Nha tro 3', 44, 4, 100, 100, b'0', '2019-10-14 07:19:28.656492', '2019-10-14 07:19:28.656492');
INSERT INTO `room_group` VALUES (7, 2, b'1', 2500000, 100, 1, 1, 1, 'south', b'1', b'1', 1400000, 'Nha tro 3', 44, 4, 100, 100, b'0', '2019-10-14 07:19:30.636991', '2019-10-14 07:19:30.636991');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_image
-- ----------------------------
INSERT INTO `room_image` VALUES (2, 'update link', 2, '2019-10-15 15:09:31.140908', '2019-10-15 15:09:31.140908');
INSERT INTO `room_image` VALUES (3, 'new image', 5, '2019-10-15 15:09:32.783061', '2019-10-15 15:09:32.783061');
INSERT INTO `room_image` VALUES (5, 'new image new', 5, '2019-10-15 15:09:34.044811', '2019-10-15 15:09:34.044811');

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
  `service_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of the service',
  `description` text CHARACTER SET utf8mb4  NULL COMMENT 'Description of the service',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service
-- ----------------------------
INSERT INTO `service` VALUES (1, 'Wifi', 'Internet access', NULL, NULL);
INSERT INTO `service` VALUES (2, 'Fan', 'Fan for life', NULL, NULL);
INSERT INTO `service` VALUES (3, 'Water', 'Water for life', NULL, NULL);
INSERT INTO `service` VALUES (4, 'Food', 'Food for life', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_review
-- ----------------------------
INSERT INTO `tenant_review` VALUES (1, 1, 2, 'good ', 3, 4, 5, NULL, NULL);

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction`  (
  `transaction_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the transaction',
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who make the transaction',
  `room_id` int(5) NOT NULL COMMENT 'ID of room in the transaction',
  `is_transited` bit(1) NULL DEFAULT NULL COMMENT 'deposit money transited to host or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`transaction_id`) USING BTREE,
  INDEX `FK_User_Transaction`(`user_id`) USING BTREE,
  INDEX `FK_Room_Transaction`(`room_id`) USING BTREE,
  CONSTRAINT `FK_Room_Transaction` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_User_Transaction` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction
-- ----------------------------
INSERT INTO `transaction` VALUES (1, 1, 1, b'1', '2019-10-08 21:14:41.938875', '2019-10-08 21:14:41.938875');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the user',
  `first_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'First name of the user',
  `last_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Last name of the user',
  `phone` varchar(20) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Phone number of the user',
  `password` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Password of user',
  `phone_token` text CHARACTER SET utf8mb4  NULL COMMENT 'Phone token of the user',
  `gender` bit(1) NULL DEFAULT NULL COMMENT 'Gender of the user',
  `facebook_id` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Facebook ID of the user',
  `google_id` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Google ID of the user',
  `email` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Email of the user',
  `avatar` text CHARACTER SET utf8mb4  NULL COMMENT 'Avatar URL of the user',
  `address` text CHARACTER SET utf8mb4  NULL COMMENT 'Address of the user',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'User is verified or not',
  `is_host` bit(1) NULL DEFAULT NULL COMMENT 'User is host or not',
  `is_active` bit(1) NULL DEFAULT NULL COMMENT 'User is active or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Son update', 'Hoang', '1234', '1234', 'aa', b'1', 'bb', 'gg', 'email@gmail.com', 'image', 'Hoa Lac', b'1', b'1', b'1', '2019-10-14 14:35:10.245687', '2019-10-14 14:35:10.245687');
INSERT INTO `user` VALUES (2, 'Phong', 'Tran', '111', '1234', 'bb', b'1', 'phongfb', 'phonggg', 'phongemail@gmail.com', 'image', 'Hanoi', b'1', b'1', b'1', '2019-10-14 14:35:12.166768', '2019-10-14 14:35:12.166768');

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
