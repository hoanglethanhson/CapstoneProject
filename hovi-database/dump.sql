/*
 Navicat Premium Data Transfer

 Source Server         : CP_DB_Test
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3308
 Source Schema         : HoviDB_test

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 14/11/2019 15:11:18
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
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction`  (
  `transaction_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the transaction',
  `user_id` int(5) NOT NULL COMMENT 'ID of the user who make the transaction',
  `room_id` int(5) NOT NULL COMMENT 'ID of room in the transaction',
  `transaction_status` tinyint(1) NULL DEFAULT NULL COMMENT 'Status code of the transaction',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`transaction_id`) USING BTREE,
  INDEX `FK_User_Transaction`(`user_id`) USING BTREE,
  INDEX `FK_Room_Transaction`(`room_id`) USING BTREE,
  CONSTRAINT `FK_Room_Transaction` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_User_Transaction` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

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

SET FOREIGN_KEY_CHECKS = 0;
