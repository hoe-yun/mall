-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.22-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- mall 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `mall`;
CREATE DATABASE IF NOT EXISTS `mall` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `mall`;

-- 테이블 mall.cart 구조 내보내기
DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_no` int(11) NOT NULL AUTO_INCREMENT,
  `goods_no` int(11) NOT NULL,
  `customer_no` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`cart_no`),
  KEY `FK_cart_goods` (`goods_no`),
  KEY `FK_cart_customer` (`customer_no`),
  CONSTRAINT `FK_cart_customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_cart_goods` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.cart:~0 rows (대략적) 내보내기
DELETE FROM `cart`;

-- 테이블 mall.customer 구조 내보내기
DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(50) NOT NULL,
  `customer_pw` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  `active` enum('Y','N') NOT NULL COMMENT 'Y활서성,N비활성(탈퇴)',
  PRIMARY KEY (`customer_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.customer:~0 rows (대략적) 내보내기
DELETE FROM `customer`;

-- 테이블 mall.customer_addr 구조 내보내기
DROP TABLE IF EXISTS `customer_addr`;
CREATE TABLE IF NOT EXISTS `customer_addr` (
  `customer_addr_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` int(11) NOT NULL,
  `address` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`customer_addr_no`),
  KEY `FK_customer_addr_customer` (`customer_no`),
  CONSTRAINT `FK_customer_addr_customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.customer_addr:~0 rows (대략적) 내보내기
DELETE FROM `customer_addr`;

-- 테이블 mall.customer_detail 구조 내보내기
DROP TABLE IF EXISTS `customer_detail`;
CREATE TABLE IF NOT EXISTS `customer_detail` (
  `customer_no` int(11) NOT NULL,
  `customer_name` varchar(50) NOT NULL,
  `customer_phone` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`customer_no`),
  CONSTRAINT `FK__customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.customer_detail:~0 rows (대략적) 내보내기
DELETE FROM `customer_detail`;

-- 테이블 mall.customer_pw_history 구조 내보내기
DROP TABLE IF EXISTS `customer_pw_history`;
CREATE TABLE IF NOT EXISTS `customer_pw_history` (
  `customer_pw_history_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` int(11) NOT NULL,
  `customer_pw` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`customer_pw_history_no`),
  KEY `FK_customer_pw_history_customer` (`customer_no`),
  CONSTRAINT `FK_customer_pw_history_customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.customer_pw_history:~0 rows (대략적) 내보내기
DELETE FROM `customer_pw_history`;

-- 테이블 mall.goods 구조 내보내기
DROP TABLE IF EXISTS `goods`;
CREATE TABLE IF NOT EXISTS `goods` (
  `goods_no` int(11) NOT NULL AUTO_INCREMENT,
  `goods_title` varchar(50) NOT NULL,
  `goods_price` int(11) NOT NULL,
  `soldout` enum('Y','N') NOT NULL COMMENT 'Y품절, N재고있음',
  `goods_memo` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`goods_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.goods:~0 rows (대략적) 내보내기
DELETE FROM `goods`;

-- 테이블 mall.goods_img 구조 내보내기
DROP TABLE IF EXISTS `goods_img`;
CREATE TABLE IF NOT EXISTS `goods_img` (
  `goods_no` int(11) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `origin_name` varchar(50) NOT NULL,
  `content_type` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`goods_no`),
  CONSTRAINT `FK__goods` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.goods_img:~0 rows (대략적) 내보내기
DELETE FROM `goods_img`;

-- 테이블 mall.manager 구조 내보내기
DROP TABLE IF EXISTS `manager`;
CREATE TABLE IF NOT EXISTS `manager` (
  `manager_no` int(11) NOT NULL AUTO_INCREMENT,
  `manager_id` varchar(50) NOT NULL,
  `manager_pw` varchar(50) NOT NULL,
  `manager_name` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  `active` enum('Y','N') NOT NULL COMMENT 'Y활성화, N비활성환',
  PRIMARY KEY (`manager_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.manager:~0 rows (대략적) 내보내기
DELETE FROM `manager`;

-- 테이블 mall.manager_pw_history 구조 내보내기
DROP TABLE IF EXISTS `manager_pw_history`;
CREATE TABLE IF NOT EXISTS `manager_pw_history` (
  `manager_pw_history_no` int(11) NOT NULL AUTO_INCREMENT,
  `manager_no` int(11) NOT NULL,
  `manager_pw` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`manager_pw_history_no`),
  KEY `FK__manager` (`manager_no`),
  CONSTRAINT `FK__manager` FOREIGN KEY (`manager_no`) REFERENCES `manager` (`manager_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.manager_pw_history:~0 rows (대략적) 내보내기
DELETE FROM `manager_pw_history`;

-- 테이블 mall.nostice 구조 내보내기
DROP TABLE IF EXISTS `nostice`;
CREATE TABLE IF NOT EXISTS `nostice` (
  `notice_no` int(11) NOT NULL AUTO_INCREMENT,
  `manager_no` int(11) NOT NULL,
  `notice_title` text NOT NULL,
  `notice_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`notice_no`),
  KEY `FK_nostice_manager` (`manager_no`),
  CONSTRAINT `FK_nostice_manager` FOREIGN KEY (`manager_no`) REFERENCES `manager` (`manager_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.nostice:~0 rows (대략적) 내보내기
DELETE FROM `nostice`;

-- 테이블 mall.orders 구조 내보내기
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `orders_no` int(11) NOT NULL AUTO_INCREMENT,
  `goods_no` int(11) NOT NULL,
  `customer_no` int(11) NOT NULL,
  `customer_addr_no` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` int(11) NOT NULL,
  `orders_state` enum('주문완료','배송완료') NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`orders_no`),
  KEY `FK_orders_goods` (`goods_no`),
  KEY `FK_orders_customer` (`customer_no`),
  KEY `FK_orders_customer_addr` (`customer_addr_no`),
  CONSTRAINT `FK_orders_customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_orders_customer_addr` FOREIGN KEY (`customer_addr_no`) REFERENCES `customer_addr` (`customer_addr_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_orders_goods` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.orders:~0 rows (대략적) 내보내기
DELETE FROM `orders`;

-- 테이블 mall.question 구조 내보내기
DROP TABLE IF EXISTS `question`;
CREATE TABLE IF NOT EXISTS `question` (
  `question_no` int(11) NOT NULL AUTO_INCREMENT,
  `goods_no` int(11) NOT NULL,
  `customer_no` int(11) NOT NULL,
  `question_title` text NOT NULL,
  `question_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`question_no`),
  KEY `FK_question_goods` (`goods_no`),
  KEY `FK_question_customer` (`customer_no`),
  CONSTRAINT `FK_question_customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_question_goods` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.question:~0 rows (대략적) 내보내기
DELETE FROM `question`;

-- 테이블 mall.question_comment 구조 내보내기
DROP TABLE IF EXISTS `question_comment`;
CREATE TABLE IF NOT EXISTS `question_comment` (
  `question_comment_no` int(11) NOT NULL AUTO_INCREMENT,
  `question_no` int(11) NOT NULL,
  `manager_no` int(11) NOT NULL,
  `comment` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`question_comment_no`),
  KEY `FK_question_comment_question` (`question_no`),
  KEY `FK_question_comment_manager` (`manager_no`),
  CONSTRAINT `FK_question_comment_manager` FOREIGN KEY (`manager_no`) REFERENCES `manager` (`manager_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_question_comment_question` FOREIGN KEY (`question_no`) REFERENCES `question` (`question_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.question_comment:~0 rows (대략적) 내보내기
DELETE FROM `question_comment`;

-- 테이블 mall.review 구조 내보내기
DROP TABLE IF EXISTS `review`;
CREATE TABLE IF NOT EXISTS `review` (
  `review_no` int(11) NOT NULL AUTO_INCREMENT,
  `orders_no` int(11) NOT NULL,
  `review_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`review_no`),
  KEY `FK_review_orders` (`orders_no`),
  CONSTRAINT `FK_review_orders` FOREIGN KEY (`orders_no`) REFERENCES `orders` (`orders_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.review:~0 rows (대략적) 내보내기
DELETE FROM `review`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
