CREATE DATABASE `rframework`;
USE `rframework`;

-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 04, 2020 at 10:11 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `omg`
--

-- --------------------------------------------------------

--
-- Table structure for table `player_account`
--

DROP TABLE IF EXISTS `player_account`;
CREATE TABLE IF NOT EXISTS `player_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_first_spawn` varchar(255) NOT NULL DEFAULT 'first_spawn',
  `player_identifier` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `player_health` varchar(255) NOT NULL DEFAULT '200',
  `player_skin` text DEFAULT NULL,
  `player_identity` text DEFAULT NULL,
  `player_position` text DEFAULT NULL,
  `player_group` varchar(50) NOT NULL DEFAULT '0',
  `player_money` int(32) NOT NULL DEFAULT 0,
  `player_bank_balance` int(32) DEFAULT 0,
  `player_dirty_money` double NOT NULL DEFAULT 0,
  `player_job` varchar(50) NOT NULL DEFAULT 'Aucun',
  `player_job_grade` int(32) DEFAULT NULL,
  `player_inv` text DEFAULT NULL,
  `phone_number` varchar(10) DEFAULT NULL COMMENT 'Pour le gcphone',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
COMMIT;


-- --------------------------------------------------------

--
-- Table structure for table `society`
--

DROP TABLE IF EXISTS `society`;
CREATE TABLE IF NOT EXISTS `society` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `society_name` varchar(35) NOT NULL,
  `money` int(32) NOT NULL DEFAULT 0,
  `inventory` text NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `society`
--

INSERT INTO `society` (`id`, `society_name`, `money`, `inventory`) VALUES
(1, 'exemple', 1500, '{}');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
