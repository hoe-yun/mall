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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.customer:~10 rows (대략적) 내보내기
DELETE FROM `customer`;
INSERT INTO `customer` (`customer_no`, `customer_id`, `customer_pw`, `createdate`, `updatedate`, `active`) VALUES
	(1, 'gogeck1', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(2, 'gogeck2', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(3, 'gogeck3', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(4, 'gogeck4', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(5, 'gogeck5', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(6, 'gogeck6', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(7, 'gogeck7', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(8, 'gogeck8', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(9, 'gogeck9', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y'),
	(10, 'gogeck10', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:32', '2023-11-01 16:30:32', 'Y');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.customer_addr:~15 rows (대략적) 내보내기
DELETE FROM `customer_addr`;
INSERT INTO `customer_addr` (`customer_addr_no`, `customer_no`, `address`, `createdate`, `updatedate`) VALUES
	(1, 1, 'juso1', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(2, 2, 'juso2', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(3, 3, 'juso3', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(4, 4, 'juso4', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(5, 5, 'juso5', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(6, 6, 'juso6', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(7, 7, 'juso7', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(8, 8, 'juso8', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(9, 9, 'juso9', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(10, 10, 'juso10', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(11, 1, 'juso11', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(12, 2, 'juso12', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(13, 3, 'juso13', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(14, 4, 'juso14', '2023-11-01 16:30:32', '2023-11-01 16:30:32'),
	(15, 5, 'juso15', '2023-11-01 16:30:32', '2023-11-01 16:30:32');

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

-- 테이블 데이터 mall.customer_detail:~10 rows (대략적) 내보내기
DELETE FROM `customer_detail`;
INSERT INTO `customer_detail` (`customer_no`, `customer_name`, `customer_phone`, `createdate`, `updatedate`) VALUES
	(1, 'cname1', '010-1234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(2, 'cname2', '010-2234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(3, 'cname3', '010-3234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(4, 'cname4', '010-4234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(5, 'cname5', '010-5234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(6, 'cname6', '010-6234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(7, 'cname7', '010-7234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(8, 'cname8', '010-8234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(9, 'cname9', '010-9234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33'),
	(10, 'cname10', '010-0234-1234', '2023-11-01 16:30:33', '2023-11-01 16:30:33');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.customer_pw_history:~10 rows (대략적) 내보내기
DELETE FROM `customer_pw_history`;
INSERT INTO `customer_pw_history` (`customer_pw_history_no`, `customer_no`, `customer_pw`, `createdate`) VALUES
	(1, 1, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(2, 2, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(3, 3, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(4, 4, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(5, 5, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(6, 6, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(7, 7, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(8, 8, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(9, 9, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33'),
	(10, 10, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:30:33');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.goods:~22 rows (대략적) 내보내기
DELETE FROM `goods`;
INSERT INTO `goods` (`goods_no`, `goods_title`, `goods_price`, `soldout`, `goods_memo`, `createdate`, `updatedate`) VALUES
	(1, '에어맥스95', 130000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(2, '에어맥스97', 140000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(3, '에어포스', 120000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(4, '에어조던', 130000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(5, '코르테즈', 110000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(6, '루나글라이드', 120000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(7, '머큐리얼베이퍼', 130000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(8, '업템포', 150000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(9, '인터내셔널리스트', 99000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(10, '프리런', 85000, 'Y', '나이키 에어맥스95', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(11, '베이지자켓', 85000, 'Y', '남성 간절기 자켓', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(12, '브라운 백팩', 55000, 'Y', '공용 브라운 백팩', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(13, '그레이 머플러', 35000, 'Y', '공용 그레이 머플러', '2023-11-01 16:28:37', '2023-11-01 16:28:37'),
	(14, '블랙 단화', 75000, 'Y', '남성 그레이 단화', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(15, '골드이어링', 25000, 'Y', '18K 골드 이어링', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(16, '미니향수', 65000, 'Y', '공용 미니사이즈 향수', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(17, '블랙 반팔', 45000, 'Y', '공용 블랙컬러 반팔', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(18, '카라티셔츠', 65000, 'Y', '남성 카라티셔츠', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(19, '카모 아노락', 85000, 'Y', '공용 카모디자인 아노락', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(20, '플라워 반팔', 55000, 'Y', '공용 플러워 디자인 반팔', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(21, '화이트 백팩', 75000, 'Y', '공용 화이트 백팩', '2023-11-01 16:28:38', '2023-11-01 16:28:38'),
	(22, '블랙 단화', 75000, 'Y', '남성 그레이 단화', '2023-11-01 16:28:38', '2023-11-01 16:28:38');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.manager:~1 rows (대략적) 내보내기
DELETE FROM `manager`;
INSERT INTO `manager` (`manager_no`, `manager_id`, `manager_pw`, `manager_name`, `createdate`, `updatedate`, `active`) VALUES
	(1, 'admin', '*A4B6157319038724E3560894F7F932C8886EBFCF', 'admin', '2023-11-01 16:32:32', '2023-11-01 16:32:32', 'N');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.manager_pw_history:~3 rows (대략적) 내보내기
DELETE FROM `manager_pw_history`;
INSERT INTO `manager_pw_history` (`manager_pw_history_no`, `manager_no`, `manager_pw`, `createdate`) VALUES
	(1, 1, '*97E7471D816A37E38510728AEA47440F9C6E2585', '2023-11-01 16:33:31'),
	(2, 1, '*B4ED24274654A59A9D0C639C4DA9EBA414B887D8', '2023-11-01 16:33:31'),
	(3, 1, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-11-01 16:33:31');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.nostice:~5 rows (대략적) 내보내기
DELETE FROM `nostice`;
INSERT INTO `nostice` (`notice_no`, `manager_no`, `notice_title`, `notice_content`, `createdate`, `updatedate`) VALUES
	(1, 1, 'SHOP OPEN', '여러분들의 성원에 힘입어 저희 쇼핑몰이 성공적으로 오픈하였습니다. 감사합니다.', '2023-11-01 16:34:02', '2023-11-01 16:34:02'),
	(2, 1, 'REVIEW EVENT 공지', '구매하신 상품의 리뷰를 정성스럽게 작성해주신 고객님들 중 추첨을 통해 사은품을 증정하는 이벤트를 진행 중 입니다. 많은 관심 부탁드립니다.', '2023-11-01 16:34:02', '2023-11-01 16:34:02'),
	(3, 1, '서버 점검 공지', '금일 22시 00분 부터 익일 02시 00분까지 서버 점검으로 인해 상품구매가 불가합니다.', '2023-11-01 16:34:02', '2023-11-01 16:34:02'),
	(4, 1, '서버 점검 시간 연장 공지', '서버 점검이 예상보다 길어지고 있습니다. 점검 종료 예정 시간을 03시 30분으로 변경합니다.', '2023-11-01 16:34:02', '2023-11-01 16:34:02'),
	(5, 1, '매진상품 재입고 공지', '현재 매진된 상품의 생산 공장의 문제로 재입고가 지연되고 있습니다. 재입고 시 추가로 공지하겠습니다.', '2023-11-01 16:34:02', '2023-11-01 16:34:02');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.question:~18 rows (대략적) 내보내기
DELETE FROM `question`;
INSERT INTO `question` (`question_no`, `goods_no`, `customer_no`, `question_title`, `question_content`, `createdate`, `updatedate`) VALUES
	(1, 1, 1, '상품 재입고 문의 드립니다.', '언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(2, 1, 1, '재입고 문의요.', '재입고 되긴 하나요??', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(3, 2, 3, '재입고 문의 드립니다.', '언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(4, 3, 8, '문의 드립니다.', '재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(5, 4, 10, '재입고 문의 드립니다.', '에어조던 언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(6, 11, 10, '재입고 문의.', '옷 언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(7, 6, 3, '재입고 문의다.', '되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(8, 15, 7, '재입고 문의 드립니다.', '언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(9, 19, 8, '문의.', '사이즈는 어떻게 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(10, 1, 4, '재입고 문의 드립니다.', '에어맥스95 언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(11, 2, 1, '저기요.', '너무 비싸요 할인 되요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(12, 18, 10, '색상문의.', '갈색 있나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(13, 21, 2, '재입고 문의 드립니다.', '언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(14, 7, 9, '문의 드립니다.', '구매절차가 어떻게 되죠?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(15, 22, 9, '색상문의.', '화이트 백팩 검은색도 있나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(16, 1, 5, '색상문의.', '색이 진한가요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(17, 22, 4, '재입고 문의 드립니다.', '화이트 백팩 언제 재입고 되나요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54'),
	(18, 1, 5, '똑똑.', '정품 맞아요?', '2023-11-01 16:32:54', '2023-11-01 16:32:54');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 mall.question_comment:~18 rows (대략적) 내보내기
DELETE FROM `question_comment`;
INSERT INTO `question_comment` (`question_comment_no`, `question_no`, `manager_no`, `comment`, `createdate`, `updatedate`) VALUES
	(1, 1, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:16', '2023-11-01 16:33:16'),
	(2, 2, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:16', '2023-11-01 16:33:16'),
	(3, 3, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:16', '2023-11-01 16:33:16'),
	(4, 4, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:16', '2023-11-01 16:33:16'),
	(5, 5, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:16', '2023-11-01 16:33:16'),
	(6, 6, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:16', '2023-11-01 16:33:16'),
	(7, 7, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:16', '2023-11-01 16:33:16'),
	(8, 8, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(9, 9, 1, '해당 상품의 사이즈는 단일 사이즈 입니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(10, 10, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(11, 11, 1, '할인 프로모션 진행 예정 없습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(12, 12, 1, '재고 확인해보겠습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(13, 13, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(14, 14, 1, '구매 버튼을 눌러 진행하시면 됩니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(15, 15, 1, '흰색 단일 색상 상품입니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(16, 16, 1, '상품 사진과 같습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(17, 17, 1, '추후에 공지사항에 올리겠습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17'),
	(18, 18, 1, '맞습니다.', '2023-11-01 16:33:17', '2023-11-01 16:33:17');

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
