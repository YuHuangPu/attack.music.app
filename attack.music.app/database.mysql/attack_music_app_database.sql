-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- 主機: 127.0.0.1
-- 產生時間： 2018-05-16 07:15:02
-- 伺服器版本: 10.1.21-MariaDB
-- PHP 版本： 5.6.30

 CREATE USER 'AM.user'@'%' IDENTIFIED BY 'ttg83m4';

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `AM.user`
--
CREATE DATABASE IF NOT EXISTS `attack.music.app.database` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `attack.music.app.database`;


GRANT SELECT, INSERT, UPDATE, DELETE ON `attack.music.app.database`.* 
TO 'AM.user'@'%';

-- --------------------------------------------------------
--
-- 資料庫： `attack.music.app.database`
--

-- --------------------------------------------------------

--
-- 資料表結構 ACCOUNT
--

CREATE TABLE `ACCOUNT` (
  `ID` int(5) NOT NULL,
  `ACCOUNT` varchar(100) NOT NULL,
  `PASSWORD` varchar(100) NOT NULL,
  `STATUS` char(1) NOT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `REMARK` varchar(500) DEFAULT NULL,
  `CREATE_DATE` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `account`
--

INSERT INTO `ACCOUNT` (`ID`, `ACCOUNT`, `PASSWORD`, `STATUS`, `EMAIL`, `REMARK`, `CREATE_DATE`) VALUES
(0, 'Ziv.Huang', '4a7d1ed414474e4033ac29ccb8653d9b', 'S', 's1010447@gmail.com', 'I\'m admin.', '2018-05-07 12:00:00'), 
(1, 'admin', '4a7d1ed414474e4033ac29ccb8653d9b', 'S', 's1010447@gmail.com', 'I\'m admin.', '2018-05-07 12:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `CONSUMER`
--

CREATE TABLE `CONSUMER` (
  `ITEM` int(7) NOT NULL,
  `ID` varchar(20) NOT NULL,
  `STATUS` char(1) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `MOBILE` varchar(20) DEFAULT NULL,
  `REMARK` varchar(500) DEFAULT NULL,
  `CREATE_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CREATE_WHO` int(5) NOT NULL,
  `UPDATE_DATE` timestamp NULL,
  `UPDATE_WHO` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `CONSUMER`
--

INSERT INTO `CONSUMER` (`ITEM`, `ID`, `STATUS`, `NAME`, `MOBILE`, `REMARK`, `CREATE_DATE`, `CREATE_WHO`, `UPDATE_DATE`, `UPDATE_WHO`) VALUES
(0, '.', 'D', '鐵克樂器', NULL, NULL, NOW(), 0, NULL, NULL);

--
-- 觸發器 `CONSUMER`
--
DELIMITER $$
CREATE TRIGGER `tri_Auto_Item` BEFORE INSERT ON `CONSUMER` FOR EACH ROW BEGIN
IF NEW.ITEM = 0 THEN
	SET NEW.ITEM = (SELECT IFNULL(MAX(ITEM) +1, 1) FROM `CONSUMER`);
END IF;
IF NEW.ID = '0' THEN
	SET NEW.ID = (SELECT LPAD( IFNULL(MAX(CAST(ID AS UNSIGNED)) +1, 1), 6 , 0) FROM `CONSUMER`);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 資料表結構 `FACTORY`
--

CREATE TABLE `FACTORY` (
  `ITEM` int(7) NOT NULL,
  `ID` varchar(20) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `STATUS` char(1) NOT NULL,
  `CONTACT` varchar(50) DEFAULT NULL,
  `ADDRESS` varchar(100) DEFAULT NULL,
  `MOBILE` varchar(20) DEFAULT NULL,
  `REMARK` varchar(500) DEFAULT NULL,
  `CREATE_DATE` timestamp NOT NULL,
  `UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `CREATE_WHO` int(5) NOT NULL,
  `UPDATE_WHO` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 觸發器 `FACTORY`
--
DELIMITER $$
CREATE TRIGGER `tri_Factory_Auto_Index` BEFORE INSERT ON `FACTORY` FOR EACH ROW BEGIN
IF NEW.ITEM = 0 THEN
	SET NEW.ITEM = (SELECT IFNULL(MAX(ITEM) +1, 1) FROM `FACTORY`);
END IF;
IF NEW.ID = '0' THEN
	SET NEW.ID = (SELECT LPAD( IFNULL(MAX(CAST(ID AS UNSIGNED)) +1, 1), 6 , 0) FROM `FACTORY`);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 資料表結構 GOODS
--

CREATE TABLE `GOODS` (
  `ITEM` int(7) NOT NULL,
  `ID` varchar(20) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `STATUS` char(1) NOT NULL,
  `RESERVE` int(5) NOT NULL,
  `SELL` int(5) NOT NULL,
  `COST` decimal(7,2) NOT NULL,
  `PRICE` decimal(7,2) NOT NULL,
  `FACTORY` varchar(20) DEFAULT NULL,
  `REMARK` varchar(500) DEFAULT NULL,
  `CREATE_DATE` timestamp NOT NULL,
  `UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `CREATE_WHO` int(5) NOT NULL,
  `UPDATE_WHO` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 觸發器 `GOODS`
--
DELIMITER $$
CREATE TRIGGER `tri_Goods_Auto_Index` BEFORE INSERT ON `GOODS` FOR EACH ROW BEGIN
IF NEW.ITEM = 0 THEN
	SET NEW.ITEM = (SELECT IFNULL(MAX(ITEM) +1, 1)  FROM `GOODS`);
END IF;
IF NEW.ID = '0' THEN
	SET NEW.ID = (SELECT LPAD( IFNULL(MAX(CAST(ID AS UNSIGNED)) +1, 1 ), 12 , 0) FROM `GOODS`);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 資料表結構 `GOODS_DETAIL`
--

CREATE TABLE `GOODS_DETAIL` (
  `ITEM` bigint(30) NOT NULL,
  `GOODS_ID` varchar(20) NOT NULL,
  `CONSUMER_ID` varchar(20) NOT NULL,
  `STATUS` char(1) NOT NULL,
  `AMOUNT` int(5) NOT NULL,
  `PRICE` decimal(10,2) NOT NULL,
  `SELL_DATE` date DEFAULT NULL,
  `REMARK` varchar(500) NOT NULL,
  `CREATE_DATE` timestamp NOT NULL,
  `CREATE_WHO` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 觸發器 `GOODS_DETAIL`
--
DELIMITER $$
CREATE TRIGGER `tri_GoodsDtail_Auto_Index` BEFORE INSERT ON `GOODS_DETAIL` FOR EACH ROW BEGIN
IF NEW.ITEM = 0 THEN
	SET NEW.ITEM = (SELECT IFNULL(MAX(ITEM) +1, 1) FROM `GOODS_DETAIL`);
END IF;
END
$$
DELIMITER ;

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 ACCOUNT
--
ALTER TABLE `ACCOUNT`
  ADD PRIMARY KEY (`ACCOUNT`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- 資料表索引 `CONSUMER`
--
ALTER TABLE `CONSUMER`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ITEM` (`ITEM`);

--
-- 資料表索引 `FACTORY`
--
ALTER TABLE `FACTORY`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ITEM` (`ITEM`),
  ADD KEY `ITEM_2` (`ITEM`),
  ADD KEY `fk_factory_account_id` (`CREATE_WHO`);

--
-- 資料表索引 `GOODS`
--
ALTER TABLE `GOODS`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ITEM` (`ITEM`),
  ADD KEY `fk_goods_factory_id` (`FACTORY`);

--
-- 資料表索引 `GOODS_DETAIL`
--
ALTER TABLE `GOODS_DETAIL`
  ADD PRIMARY KEY (`ITEM`),
  ADD UNIQUE KEY `ITEM` (`ITEM`),
  ADD KEY `fk_goodsDetail_goods_id` (`GOODS_ID`),
  ADD KEY `fk_goodsDetail_consumer_id` (`CONSUMER_ID`);

--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints FACTORY
--
ALTER TABLE `FACTORY`
  ADD CONSTRAINT `fk_factory_account_id` FOREIGN KEY (`CREATE_WHO`) REFERENCES ACCOUNT (`ID`);

--
-- 資料表的 Constraints `GOODS`
--
ALTER TABLE `GOODS`
  ADD CONSTRAINT `fk_goods_factory_id` FOREIGN KEY (`FACTORY`) REFERENCES `FACTORY` (`ID`);

--
-- 資料表的 Constraints `GOODS_DETAIL`
--
ALTER TABLE `GOODS_DETAIL`
  ADD CONSTRAINT `fk_goodsDetail_consumer_id` FOREIGN KEY (`CONSUMER_ID`) REFERENCES `CONSUMER` (`ID`),
  ADD CONSTRAINT `fk_goodsDetail_goods_id` FOREIGN KEY (`GOODS_ID`) REFERENCES `GOODS` (`ID`);

  
  
  
ALTER TABLE `GOODS` ADD `PURCHASE` INT(5) NOT NULL AFTER `RESERVE`;

DELIMITER $$
CREATE TRIGGER `tri_Regain_Goods_Reserve` 
AFTER UPDATE ON `GOODS_DETAIL` 
FOR EACH ROW 
BEGIN 
IF NEW.STATUS = 'N' THEN 
	IF OLD.STATUS ='I' THEN 
		UPDATE `GOODS` SET `RESERVE` = `RESERVE` - OLD.`AMOUNT` ,`PURCHASE` =`PURCHASE` - OLD.`AMOUNT`, `UPDATE_DATE` = NOW(), `UPDATE_WHO` = NEW.CREATE_WHO 
        WHERE `GOODS`.`ID` = OLD.`GOODS_ID`;
	ELSEIF OLD.STATUS = 'O'THEN UPDATE `GOODS` SET `RESERVE` = `RESERVE` + OLD.`AMOUNT` ,`SELL` =`SELL` - OLD.`AMOUNT`, `UPDATE_DATE` = NOW(), `UPDATE_WHO` = NEW.CREATE_WHO 
		WHERE `GOODS`.`ID` = OLD.`GOODS_ID`;
	END IF;
    END IF;
END
$$
DELIMITER ;