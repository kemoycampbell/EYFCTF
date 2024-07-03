-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 03, 2024 at 05:56 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: rit_directory
--
CREATE DATABASE IF NOT EXISTS rit_directory;
USE rit_directory;

-- --------------------------------------------------------

--
-- Table structure for table `directory`
--

DROP TABLE IF EXISTS `directory`;
CREATE TABLE IF NOT EXISTS `directory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `home_address` text NOT NULL,
  PRIMARY KEY (`id`)
);

--
-- Dumping data for table `directory`
--

INSERT INTO `directory` (`id`, `user_id`, `first_name`, `last_name`, `home_address`) VALUES
(1, '1', 'Alice', 'Johnson', '123 Apple St, Wonderland, WL 12345'),
(2, '2', 'Bob', 'Smith', '456 Banana Ave, Fruitville, FV 67890'),
(3, '3', 'Ritchie', 'Tiger', '789 Cherry Blvd, Berryland, BL 11223'),
(4, '4', 'Dana', 'Lee', '101 Orange Rd, Citrus City, CC 44556');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'alice123', 'SecurePass1!'),
(2, 'bob_smith', 'MyPassword@2024'),
(3, 'ritchie_da_tiger', 'P@ssw0rd99'),
(4, 'admin', 'aReallyS3curedPasswordShouldNotBreak#1!');
COMMIT;
