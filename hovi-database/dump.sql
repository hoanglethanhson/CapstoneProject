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

 Date: 14/10/2019 14:31:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for amenities
-- ----------------------------
DROP TABLE IF EXISTS `amenities`;
CREATE TABLE `amenities`  (
  `amenities_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of amenities',
  `usable_name` varchar(255) CHARACTER SET utf8mb4  NOT NULL COMMENT 'Name of amenities when usable',
  `unsuable_name` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of amenities when unusable',
  `description` text CHARACTER SET utf8mb4  NULL COMMENT 'Description for amenities',
  `icon_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL to amenities icon image',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`amenities_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of amenities
-- ----------------------------
INSERT INTO `amenities` VALUES (1, 'kitchen', 'no kitchen', 'kitchen', 'data:image/png;base64,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', NULL, NULL);
INSERT INTO `amenities` VALUES (2, 'window', 'no window', 'window', 'link', NULL, NULL);
INSERT INTO `amenities` VALUES (3, 'door', 'no door', 'door', 'link', NULL, NULL);
INSERT INTO `amenities` VALUES (4, 'balcony', 'no balcony', 'balcony', 'link', NULL, NULL);

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
  `province` varchar(255) CHARACTER SET utf8mb4  NOT NULL COMMENT 'Province of the building',
  `district` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'District of the building',
  `ward` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Ward of the building',
  `street` varchar(255) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Street of the building',
  `detailed_address` text CHARACTER SET utf8mb4  NULL COMMENT 'Detailed address of the building',
  `location` text CHARACTER SET utf8mb4  NULL COMMENT 'Location of the building',
  `floor_quantity` int(2) NULL DEFAULT NULL COMMENT 'Number of floors in the building',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'Building is verified or not',
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
INSERT INTO `building` VALUES (1, 'happy building', 1, b'1', 1, 'Hanoi', 'Thanh Xuan', 'Nhan Chinh', 'Tran Duy Hung', 'Detailed Hanoi', 'Hanoi location', 3, b'1', '2019-10-14 07:21:32.548677', '2019-10-14 07:21:32.548677');
INSERT INTO `building` VALUES (2, 'new building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Trung Liet', 'Nguyen Luong Bang', 'Detailed Hanoi', 'Hanoi location', 3, b'1', '2019-10-14 07:21:53.649250', '2019-10-14 07:21:53.649250');
INSERT INTO `building` VALUES (3, '3rd building', 1, b'1', 1, 'Hanoi', 'Dong Da', 'Hao Nam', 'Lang Ha', 'Detailed Hanoi', 'Hanoi location', 3, b'1', '2019-10-14 07:22:13.185435', '2019-10-14 07:22:13.185435');

-- ----------------------------
-- Table structure for building_service
-- ----------------------------
DROP TABLE IF EXISTS `building_service`;
CREATE TABLE `building_service`  (
  `building_id` int(5) NOT NULL COMMENT 'ID of the building',
  `service_id` int(5) NOT NULL COMMENT 'ID of the service in the building',
  `service_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Price of service',
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
INSERT INTO `building_service` VALUES (1, 1, 150000, NULL, NULL);
INSERT INTO `building_service` VALUES (1, 2, 120000, NULL, NULL);
INSERT INTO `building_service` VALUES (2, 2, 150000, '2019-10-10 08:40:30.762407', '2019-10-10 08:40:30.762407');

-- ----------------------------
-- Table structure for building_type
-- ----------------------------
DROP TABLE IF EXISTS `building_type`;
CREATE TABLE `building_type`  (
  `type_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room type',
  `building_type` varchar(1000) CHARACTER SET utf8mb4  NOT NULL COMMENT 'Name of the type',
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
  `room_id` int(11) NULL DEFAULT NULL COMMENT 'ID of the room that the image belongs to',
  `image_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL of the image',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`image_id`) USING BTREE,
  INDEX `FK_room_image`(`room_id`) USING BTREE,
  CONSTRAINT `FK_room_image` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_image
-- ----------------------------
INSERT INTO `room_image` VALUES (2, 2, 'update link', '2019-10-08 20:23:40.626000', '2019-10-08 20:23:40.626000');
INSERT INTO `room_image` VALUES (3, 3, 'new image', '2019-10-08 20:23:40.626000', '2019-10-08 20:23:40.626000');
INSERT INTO `room_image` VALUES (5, 2, 'new image new', '2019-10-08 20:23:40.626000', '2019-10-08 20:23:40.626000');

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
  `icon_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL to the icon image of the service',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service
-- ----------------------------
INSERT INTO `service` VALUES (1, 'Wifi', 'Internet access', 'data:image/png;base64,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', NULL, NULL);
INSERT INTO `service` VALUES (2, 'Fan', 'Fan for life', 'url', NULL, NULL);
INSERT INTO `service` VALUES (3, 'Water', 'Water for life', 'url', NULL, NULL);
INSERT INTO `service` VALUES (4, 'Food', 'Food for life', 'url', NULL, NULL);

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
INSERT INTO `user` VALUES (1, 'Son', 'Hoang', '1234', 'aa', b'1', 'bb', 'gg', 'email@gmail.com', 'image', 'Hoa Lac', b'1', b'1', b'1', '2019-10-08 21:13:14.783465', '2019-10-08 21:13:14.783465');
INSERT INTO `user` VALUES (2, 'Phong', 'Tran', '111', 'bb', b'1', 'phongfb', 'phonggg', 'phongemail@gmail.com', 'image', 'Hanoi', b'1', b'1', b'1', '2019-10-08 21:13:23.819680', '2019-10-08 21:13:23.819680');

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
INSERT INTO `user_verification_image` VALUES (1, 1, 'front', 'back', 'selfie', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
