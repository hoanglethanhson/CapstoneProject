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

 Date: 04/10/2019 22:49:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for amenities
-- ----------------------------
DROP TABLE IF EXISTS `amenities`;
CREATE TABLE `amenities`  (
  `amenities_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of amenities',
  `usable_name` varchar(1000) CHARACTER SET utf8mb4  NOT NULL COMMENT 'Name of amenities when usable',
  `unsuable_name` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of amenities when unusable',
  `description` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Description for amenities',
  `icon_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL to amenities icon image',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`amenities_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of amenities
-- ----------------------------
INSERT INTO `amenities` VALUES (1, 'kitchen', 'no kitchen', 'kitchen', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAh1BMVEX///8AAAD7+/v+/v78/Pz9/f0BAQEeHh6+vr7MzMz09PSCgoJwcHDCwsI+Pj7c3Ny0tLRra2tWVlbo6OilpaWOjo55eXnIyMgoKCji4uKenp5LS0uWlpbe3t5cXFytra1EREQ3Nzfu7u5iYmIwMDBPT08UFBTT09MqKiqQkJANDQ2FhYUhISGvIRq2AAAVRElEQVR4nO1diXbiuBKVtwQMhBBIWDoJCdk63f3/3/ewVaW1tBmzZM7TOTNxQ9mqa5V0VYsNY65WuA+6yHpEUmQ7q1kUwYNCHvQh2/PlPLL8XxUcVOZBURXWgSVri6TIunSIulxYlsuV/OOilAf4TWUclH3LFpYsC8imdM1ttsr5x0WeF3gAJ+RwiRJEWG7KVj7ZwiFbmrLerlNkDTW5rRZlfC9pAF2yltLUzegE0FSztVm03AsDeMhoi6752KG99g6wk9IuWavrODWZbBc2gsGuU9T8CQA7mejhAL1LWbSJxshe4ggeNAf/b6JJAAv+/SUB7IUmhGzL+GIzdBEm2usctBi/H4DRI3j0OQjbUcn4JwZ49DkoRC4IYK8mKi6XfGY/PHj0Odgd4A/Zql0gQBZuxc8xUQrg63WoZV8dAALjp5/ZO02wf1mwTZPV5OGoqowGKJonbiBF0ubgqgVxBWCuqINpKsAKGD8S4HLQttoPsL5tpSYslSZWLYorD8AWYZqhNd9gWDF85g3vau2dg+WOS/1hqTSxCgJsEHaaSZEA2S9uQmvvHKwA4Yo5ADppYqUCpJFOjwtwjxDG0LfIsFpDmMCDKzEHiXYFK80xAVaI8KnyKl1zhVbxAEEjQDivd7uaN3GQ3/Guv4pjAswFwsKrdM1takUC9HgTsJZmNcMPSnHAngEhfpAAsAgBVG7Eh1hpfK3mk+Y3+aVnq4YId1R8WkeYBLCli9IDcDdZ7ttkMlkOX/nobJf4CXkw4KvC9dD4ZjL370UFQmYDbBEiHyYB5L4v5m/IiOpEn/BXntVAW/bstghs61Z8Au8IgA3CK0SYtOHijF/IXuwzl5rSoeWcFuEHW+b3JjjjZzUBkCPkjJ+2owwDbBES2rtwKQfmB1vmd5dWXLYmAO4RIuN32jL7ADYIEwbOI7tH6NAIuv7NZWvKkXnOgPH7B7hH6DS7FBPda7j1A3z65ChqAiCupZsKo0r9ATRWmthGrTZbQyPNRL/e8KSaWQArRJitbsu+AbKv8QM2cOBmD9425gA/R+bnSzfABh9O3F1l+9qIcC/yuk0EqDM+4dErfuEH72TOvC3nlkkyPmWie/t8Vkd9R8WnnxWL/3fL7DXLDZAzftBLb8/8xRVZg6yjl5oru4oL/BZsqmqfqYyvdP2miXzeFrEAwQOOA9ggbDpZ+2WF9xQRVQP7VEZwNqUAsnrzqc3x92Y+RgCELHfs8vSLK7L2yhYCYdibQHwCIOIj4l31Rl/E3reoeDCF4gRo9SIRerZfpUAYBvisK/22RmWIgF7J8o2+Sn+u4wBii1iehI/vi6oVugfsm4NMAGyuO3sS65oruplvrsWSu/8zDAJU+SLGk0Qfv/CGDTUP2O9NKCM4njKCBy2vrn78lCcNewZYSh/f5yFoHnDAmxC6vj2xKIDNDZS2OjzERKleBELmA8g9YI7QFVVDWdD1bR3qWqfrxz/cVIdRAAv14wDB/OL2t/YCbPnwis9Dn4k2BzAHWWp74Ld6yCJMlK5rc9walfHdofua3+BVRHYJrO0usT3/EwhDAB11ba6xVxjfk5uQfOg3UY4wO6AtmRsgdE3XtTmNW/KhB6CMCIdGUEGY4mdKQlwGAWoBxYhNnuBDD0BlDK3rmgCRD70A3SKcD30mqi2nMbtYGfN2Alwvnt9Bg5vZoPaOtsL48QOnHgz7BigQVi6ll7+MUdnvM83No7L0M4f2scGEoQOgMTuiAeYm45tKD28QnzJXZnPzcgq3ZYe1Zb8jmJuMbwAsH2TXWrxtQQJsrzs9rNVRAIHxo/wQjfENgPNXZ/r2jdnJUp2Q9QNmHLgfrYgw0XBdm3qmyvgGwKlmmgbSm5o5ACZs1SINzQSoMX5wm64wvgFwreF7vXv+eFehvtSnAmjJqowfPlMyvrnZ/icBjie75rt6vsX4WLO31pQ+sFYtBaDK+BFjr2S59Xn1LAD+3Ynr7Uf2Wdjq4zlMVC8aivEkFcbXFNmija6emL7HvRXW+8QuH2ChML6mSI2r6Edt7UWnf8B4P7Cm5YQmmgqQyHJz2XsAeFMX1m1kT7jaTI4N0DuCIZoAEZ3xUZEch3BHeBOQYd2b6h2t9NEBFsD47jOVXjTGF4psYZBuHe7SA+wvyTDr0U3UWddGnqkyvnSBoH7hxuUP7mCMH88xBystyx0ce4XxhSLF/A8OoctOHjjClzPMQT3LHT5TMr4k72LIAX7KhIrJtiCRRT3H2TNAnfGDY/+CqeZCyjJIJ7y5AIrALxbDnM5EUwEOXkDT63u5k654ZO8q+/b08sJFBhcHUBv7aqbspD+/pOyMLz8DTy8PXETPcl+aidYvSlzsioe5uOxMRhRcQadHftL2PACLKIDszayTmaPsjH+z9ETVvrnI9iwmata1Oc681UewXftBZMy/2Xp6AZHbc4ygWdfmOpMITvN1g7G//J8jT4jxH+5MTw9Qz3K7x36JsP5Otjdgqs+AEDZtH0VJmyjDouFsTpSRHNlEzbo2Z7hqBDo2WfaCl0Vk1y1l5MUU9Xcp3Zh429gZAGKo1zjTcoHAqXhsq3fn4NXypCbL//ExfXT1ghvXN3ZyE3UBtHrBxxDAbfrAOkEuAjVQWU4rLTZtsnDv4gAKhLDtekGT5SJDGNMHSumyLHErVPcLsLuJUmfe8WF6aD/5Ao3X6NFfw0JLPiUDay2efAaAwPj+sYdNSRugX//mAN9rfAEMriRUJT1bAECROe4HYNBE6Sy3s5cphszeR28I50EsHExkZCZGLxV4Hvtz//YKMHoEi9i6theb8ZX6M263zT14rNTtBJvP8JvP/DwAzbo219iLuSdD92OmyD6K3dxvWDGbtvuWJw37BBi/iuYa4/vORGsTCN912ZmKffu1q+fDzYdyV7YnBUinEENjf68BfN0Zl0A4dmvO+e4TYLyJJgFUVsx9m9WGbJVjmSiVlt5cBsDg2O/uQelnXgNhyN7TADPuhZx+DqaOIGsfJJsOBoMhBmlMh3e4spzIpt3NzwywID/27YFKqxfUFSuV1WQpxm/6ARivpgTIGT91/SVlS5ZvRbkJn6/L4jwAZTAhUNfmzdrSsvXt31+rz8/P38+PE0wdnI8moNYXh7PbCFoOr9nOOYKaUj0BPH3yJaLrQwBG2Ek8QLuVufFBJzVjz6TmYFDpFICb70fZ2szBHuBW+ezxe+4sqSO7TgMYY6KHjeCntg7Pedf64vzlrAM8fASPPwfxSWfYLuz45T40fhVvb4k3NEdd2+nnYIXPcuN+aMdX+g9tC4hvb4k3Ub2u7YxzsOkaEYKVcr/8Q9vET5PVpOvazkQTK23HBxHmD63icZqsZvONzHKf0UQb2ZW2ZQeEGIvEGG23cQgADG/VegGIb29ZbJu2ABfmtv3X7Q0m2FPmoKMq6vQ0gV2v+Dihd8Zl4QDqHKdUSDa4VCQAdCkdJVu5NWKIMGsR2pcTb/7At7dEbcz9AM/QINRsbtTa9oZjGGoOEy0sgNlFtuAzRMQI6nVtcgSv8Zq+Z1bCIlEPhnSQdXxzzRwAK2teIcLOD3tEiqTIRnR9zUwT5ZsZ6+Um+yG9PolGfd+4a2axmQNgxRFelPYRsnuEuomaKUT14+tAL8H+zzFfAaEjsmJwm6raD2qGiXoANg1e2/KXXXqDih4oJI8GmLMBP3HE8MxDdjJR27qOm6i2FgZLH23ZwtWLgfCCo2oNwitASABsV1Oirq3gCK8A4XG8iX5yEyO+2gxIWT3LrZ854LdmFKn0+ZIvI76cDkhD07LcRi8DfmtGpNIXYKLiZoz4qj8gu9YZXz8T3g44Sgsv9wyQMWFfYmU0RaDqbmD7jqLkhFZ6wG/N6GxzcDf6FDXl/HLLjyz7NTG6VhCmAZRr6QnnoCoL9R9/5OMdAGWsdy0RRgFU3GqBsGefWAS+/ADhJTBZ9pqD0uIhwI1+b3WExN6FBmjy4Xx720/bWu/kplfRR7HjvOVWlP8WbmBdqrIqHxIjCIxPmJ2OUJQJH9w2UQDxAZ19m3ErepKb7K9ClVUREgA541O9aIwvEB7uIRjP57tWUVloNuMSWIycwQuiKMa3p78W8zZu44C7YC3CEhH24Not4mhCvAcM6jab58WxTTVZyfjOujZG2onC+CVW+vbh5y6idjJYoXSFCSfxmqqr7EaXFYxPLeAKQCuiKhm/OXMYOU5hkQX1OnAi1nkHAB9AFswUIVOM72IoRy+C8dtbM1R1PagtWNBEW87Meenmg5QdtrGVz4kx2gJhIkCD8aGa++bxvmv7vkOE4RHkm4Kvx/vHJ1U2v72/v60NWZPxaYBE0N9g/CEfwTHr3hbcyBaxAGXTdyemrOYBR49gZfKhQNh9q7ZRER5aRqIEfjXGtwFCzJs4k+TDcUyMwaH0hq9Di54BqnxIyHrq2lQPWEXYebO9yUTB/wElzbbsiF93QHXtrGtrLq4yvnjyZXzAoz0bwfgHlVNayRfJ+PF1be2ZAx4x1RhfKWA3ACrNZXabDBi/NBeOjg2uonjAFkBVO0sjlfErYHxAaACsB5PJYP9f0waDpQMgPvW9EC+nZXCOONk+GMgDW2RnInS5rQ6NBOO3twYYf0wAVHeMGbyKjnB4JUIRko3YH/haey9LiTAWIA6sZPzmTGD8MQGQzbU92ysNMJcIAWAv72srTcaPBlhKhO2tkYxvz0Exhtwnd4UsND5sLcOlPQWHOBjyBUlj/GgTLQnGzzJgfANgsdb6f3XFZDZcZAEAC/GGVucIugCCyJCvuCrjEwA1xtfWaifjGwDLaq31/8pogBrjc5EAwBDSITMZ3wbo+1UylfELBaEla6w073aqmcsqjA/r+oHuypJvmSXjEztK36+SKR5wYfKhLrsbq78Q8NdMNaOs4ENBXDDlHswfGQi00SsiZICw+deA3DJXYhzt7YTkw+YEHaG3gN0VFxUIxaYYxsK6QqiNW1PFcI3C+K4NF620QNjeGo3xOwV+FcbHkCwgzK1ql8BWDR6uthCmAVT4sDlTZfxukW2T8YtcIjQuZzWDzVqEEHJT+DAA0MoNS4TNmQrjdwzdG4xfIONfZVbXw9cX2W5G1nXHfG0Ztl3bjB8HUOHD9uKS8TvnJjTGb2UBYWl2rYefZxb9jAXjN12bjG90XfCPbaVdjG+/X1QeuL9pDlTGL1TGr7SuS0QoY97mhmuM72Rv763B+CZA7gGbAJtbTjL+89ewa/sayZh3oTF+ZXat/4rWjBkA+VraImxO1RnfAFhpjK+bHcn4hzX0gNGc4ZPKXEW1X9HCqL6cSYhwyZlcesAEQN+vkpGMn755tGQXcr4C41dm10v1coBQXbMQIf9AZXxmynoAkowfm5vgqtHf2IxfmWF+3WDeDKVLN+NbAPUUovGx8IDbWzOMG7iIQRaMX0k+NLqu1+v1vGnN3/XOBKgxvp3lDtW1ieirwvgM+PBwE20RipAsIjQji5jtE+93MthsLD1gO8sdC1DJcrcXHyo6HtYWUmkOXTJ+KKqGakrGt7PcsSZqZbmB8d/Hs65tDK/eW8hRAYSVrlEQoORDkeVOrmuzs9yS8Tu3RSYZn5sdWHFldB2MoUo+NLPcobo2bfvl8vHTtmogC3saZHyQhWlaUZfzAFQQNiJaXZsJ0Pf2Fq2urRAIOwFsD2TMG2VVxo+dg82+VfBhK0LWtWEpFY95F/rHdpa7snz8LoVAwgMWsgrjxwN0M36ors1UWq1rK3UPuFMpl+IBYxgMVtcq9BYnZiz2LsanAWKzlFbq2krdA6aSdHgp/EsUWUmEICIZP8FEm+s6GN9lPPrHgSz3mAKYa7868UT2Ulgxb/ly2lxYURxAP+PHFu6ZdW1KltsaQT2a+I8GmBsx70YR4MPc6No3B9vLSQ9YML7IckcDdGa5CROVMW+I6tPkbWS5S90DjqEJ7FplfCPL3b2uTTC+vchUZlTfkcJWfXyuSCYZP3oOcoQZR9jeA72uzZyD9K+SFZjlphjfWkWLuQqwierTOXqF8UFpyYcxc1AYmoKQsZS6NiNkTNa1jakM71yaaIvQsfSrWW6uiODDWJrgIjYfAuPbsvSvkoGrTNW16a9pQ0XMvAUNUM1ygyICYRJAJ+OT65tsVtCfqmuTWW5VkfmL8sN2HzOrF4vxcX8J96Qkq12cAIsQ44erohgi5CtNaTK+faftRrz3QiAUUXBAmDtfPeUI86uMH1vXRmQWnYyfslVTZD2Mz0zZwMMBCuN3qWsDpZ2M3xGgzfiY5e6Se0LGb7qOqWujEm+eLHe0N6HL2nVtwDFjvc3GofYuf4e0TK5rk0oH6trSH+2x69qyrsEfV5abcKQ9v0rmqGszw2D4+0cilax8o4t4s9wJ4UhxYGW5I+ra1FEh69redvM5RDLxYG4crO2D9v+7b4XxuSLusHFU6NJifMJ4DMbXzE6pa5Mx71Rz0hpG9YU5G99oB+5vhBICYduIujY9hWgF/SXj56KurYMpWbJKXZsJMC3mbDO+K/BAA6Tr2g7RSET1xf4yO6wF6tpCAOm6NkN7FxyPrJrl5onF5RL/LvUPPAeN7LJJaLjr2kIAHXVtWceBkwdqljvUwhLuurYgQJvx+2oLTZH4rRqtZumoaxOXc/4qmcn4w983/bR38+dmorwJF8BGhKprMwBG1LVFmFRK6wugYPxMr2uTGy7Xr5IJxscsd+etGnO6QH7ZhCdx7bo2Rc3KDVDPcnfzJsJK9wDQrmsjKs7IM/W6tiDAg0aw8xzUEbq6dvSi17WdFGDS4/5mXVvsCDLDA2aYqZLBR+GTiKWKlbZsEZItCFn35YiuzSx3JEDBhw81tN0OD2rjYOc56CCbeLn8QWV823gKB0BE2E91wtGbzHJH1rU182oAZ4pLwN8uW7W+ZSmRAQnQ/FUydSkbHFmjVNlQ1wNyLYyoazuaRj3Iat8MyAXcAxD50NGL65vDXKtDZOPr2pDbYC39MY2qa/MC3CO8/kmNqmvzAiycGYkLb863t7g2hBe6VUtQU2f8I72Vq6vn0QtAzvjBUTkIYN/eRILxeOvaQgDje+nVo09T0/xVspPNwVOZaK4xfs8meiyPvlNJXYczz+bRd5kdZwd4vBf4dQf4I2jiqAB7n4MHsFnoV8l+CE145iBd1/bfmYOhXyX78XPQUdf287dq8nJqQPHHzsEINY8B8BJ2MgbA0hxYYhcrjLuMl7VEKilShbqu7K47qAmC6E1ZBxVWBCkHlqwt4pQtIy6X0nVQFgQL10EhDw4QOZZsESPr+ThOkd5lWbqsV+R/U2mOl9/AZ8cAAAAASUVORK5CYII=', NULL, NULL);

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `building_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of building',
  `room_type_id` int(2) NULL DEFAULT NULL COMMENT 'ID of building\'s room type',
  `floor_quantity` int(2) NULL DEFAULT NULL COMMENT 'Number of floors in the building',
  `bedroom_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of  bedrooms in the building',
  `bathroom_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of bathrooms in the building',
  `wc_quantity` int(5) NULL DEFAULT NULL COMMENT 'Number of WCs in the building',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'Building is verified or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`building_id`) USING BTREE,
  INDEX `FK_room_type_building`(`room_type_id`) USING BTREE,
  CONSTRAINT `FK_room_type_building` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES (1, 1, 3, 10, 10, 10, b'1', NULL, NULL);

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

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `feedback_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the feedback',
  `user_id` int(5) NULL DEFAULT NULL COMMENT 'ID of user who sends the feedback',
  `email` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Email of the user who sends feedback',
  `content` varchar(1000) CHARACTER SET utf8mb4  NOT NULL COMMENT 'Content of the feedback',
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
  `comment` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Content of the comment',
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
  `report_content` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Content of the report',
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
  `free_slot` int(5) NULL DEFAULT NULL COMMENT 'Number of free slots in the room',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `FK_room_group`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_room_group` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, 2, 5, NULL, NULL);

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

-- ----------------------------
-- Table structure for room_group
-- ----------------------------
DROP TABLE IF EXISTS `room_group`;
CREATE TABLE `room_group`  (
  `room_group_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room group',
  `building_id` int(5) NULL DEFAULT NULL COMMENT 'ID of the building that the group belongs to',
  `gender` bit(1) NULL DEFAULT NULL COMMENT 'Gender in the group',
  `rent_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Rent price of the room group',
  `general_address` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'General address of the room group',
  `detailed_address` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Detailed address of the room group',
  `location` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Location of the room group',
  `aera` double(10, 0) NULL DEFAULT NULL COMMENT 'Area of the room group',
  `is_available` bit(1) NULL DEFAULT NULL COMMENT 'The group is available or not',
  `deposit_price` double(10, 0) NULL DEFAULT NULL COMMENT 'Deposit price of the room group',
  `description` varchar(10) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Description of the room group',
  `capacity` int(10) NULL DEFAULT NULL COMMENT 'Capacity of the room group',
  `host_id` int(10) NULL DEFAULT NULL COMMENT 'ID of the host of the room group',
  `quantity` int(10) NULL DEFAULT NULL COMMENT 'Number of rooms in the room group',
  `view_amount` int(10) NULL DEFAULT NULL COMMENT 'View amount of the room group',
  `phone_view_amount` int(10) NULL DEFAULT NULL COMMENT 'View via phone amount of the room group',
  `is_sponsored` bit(1) NULL DEFAULT NULL COMMENT 'The room group is sponsored or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`room_group_id`) USING BTREE,
  INDEX `FK_room_group_building`(`building_id`) USING BTREE,
  CONSTRAINT `FK_room_group_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_group
-- ----------------------------
INSERT INTO `room_group` VALUES (2, 1, b'1', 2000000, 'Hanoi', 'detail Hanoi', 'locale Hanoi', 100, b'1', 1400000, 'Nha tro', 44, 1, 4, 100, 100, b'1', NULL, NULL);

-- ----------------------------
-- Table structure for room_image
-- ----------------------------
DROP TABLE IF EXISTS `room_image`;
CREATE TABLE `room_image`  (
  `image_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the image',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of the room group that the image belongs to',
  `image_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL of the image',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`image_id`) USING BTREE,
  INDEX `FK_group_image`(`room_group_id`) USING BTREE,
  CONSTRAINT `FK_group_image` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`room_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_image
-- ----------------------------
INSERT INTO `room_image` VALUES (2, 2, 'data:image/jpeg;base64,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', NULL, NULL);

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `type_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the room type',
  `room_type` varchar(1000) CHARACTER SET utf8mb4  NOT NULL COMMENT 'Name of the type',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time ',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES (1, 'Entire', NULL, NULL);

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
  `service_name` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of the service',
  `description` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Description of the service',
  `icon_url` text CHARACTER SET utf8mb4  NULL COMMENT 'URL to the icon image of the service',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service
-- ----------------------------
INSERT INTO `service` VALUES (1, 'Wifi', 'Internet access', 'data:image/png;base64,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', NULL, NULL);

-- ----------------------------
-- Table structure for tenant_review
-- ----------------------------
DROP TABLE IF EXISTS `tenant_review`;
CREATE TABLE `tenant_review`  (
  `review_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the review',
  `user_id` int(5) NOT NULL COMMENT 'ID of user who sends the review',
  `room_group_id` int(5) NOT NULL COMMENT 'ID of reviewed room group',
  `comment` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Content of the review',
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
INSERT INTO `transaction` VALUES (1, 1, 1, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID of the user',
  `name` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Name of the user',
  `phone` varchar(20) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Phone number of the user',
  `phone_token` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Phone token of the user',
  `gender` bit(1) NULL DEFAULT NULL COMMENT 'Gender of the user',
  `building_id` int(5) NULL DEFAULT NULL COMMENT 'ID of the building where user stays',
  `facebook_id` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Facebook ID of the user',
  `google_id` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Google ID of the user',
  `email` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Email of the user',
  `avatar` text CHARACTER SET utf8mb4  NULL COMMENT 'Avatar URL of the user',
  `address` varchar(1000) CHARACTER SET utf8mb4  NULL DEFAULT NULL COMMENT 'Address of the user',
  `is_verified` bit(1) NULL DEFAULT NULL COMMENT 'User is verified or not',
  `is_host` bit(1) NULL DEFAULT NULL COMMENT 'User is host or not',
  `is_active` bit(1) NULL DEFAULT NULL COMMENT 'User is active or not',
  `created_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record create time',
  `updated_at` timestamp(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6) COMMENT 'Record update time',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `FK_building_user`(`building_id`) USING BTREE,
  CONSTRAINT `FK_building_user` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Le Son', '1234', 'aa', b'1', 1, 'bb', 'gg', 'email@gmail.com', 'image', 'Hoa Lac', b'1', b'1', b'1', NULL, NULL);
INSERT INTO `user` VALUES (2, 'Phong', '111', 'bb', b'1', 1, 'phongfb', 'phonggg', 'phongemail', 'image', 'Hanoi', b'1', b'1', b'1', NULL, NULL);

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
