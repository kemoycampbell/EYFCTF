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
-- Database: online_journal
--
CREATE DATABASE IF NOT EXISTS online_journal;
USE online_journal;

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
(1, 'ritchie', 'e8d6bef289b86a7c0a964e94241b4aed');
COMMIT;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
CREATE TABLE IF NOT EXISTS `entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `entry` text NOT NULL,
  `entry_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
);

--
-- Dumping data for table `entries`
--

INSERT INTO `entries` (`user_id`, `entry`, `entry_date`) VALUES
(1, 'Today was a good day in the jungle. I found a new watering hole near the big oak tree. The water is so clear and refreshing. I even caught a few fish to snack on. Life as a tiger is pretty great sometimes.', '2023-06-10'),
(1, 'The weather has been hot lately, so I’ve been spending a lot of time lounging in the shade. I found a perfect spot under a large rock where the breeze keeps me cool. It’s my new favorite place to relax.', '2023-06-12'),
(1, 'I met a new friend today! A young tiger named Tara. She’s playful and full of energy. We spent the afternoon chasing butterflies and playing in the tall grass. It’s nice to have a friend around.', '2023-06-15'),
(1, 'I’ve been thinking a lot about exploring new territories. The jungle is wonderful, but I feel the call of adventure. I’ve heard tales of a place called Croatia, with beautiful landscapes and plenty of prey. Maybe it’s time for a change.', '2023-06-20'),
(1, 'I had a strange encounter today. A group of humans passed by my favorite hunting grounds. They were carrying strange devices and talking in hushed tones. I stayed hidden, but I couldn’t help but feel curious. What could they be up to?', '2023-06-22'),
(1, 'Today, I caught the biggest deer I’ve ever seen! It was a tough hunt, but the reward was worth it. I shared the feast with Tara and a few other tigers. We had a great time celebrating our successful hunt.', '2023-06-25'),
(1, 'The urge to travel is growing stronger. I’ve started planning a route towards Croatia. It’s a long journey, but I’m excited about the possibilities. I’ve marked a few key locations along the way for rest and hunting.', '2023-06-28'),
(1, 'I’ve decided to leave tomorrow. I’ve gathered enough food for the journey and said my goodbyes to Tara and the others. I’m a bit nervous, but also thrilled about what lies ahead. Croatia, here I come!', '2023-07-01'),
(1, 'The first leg of my journey went smoothly. I traveled through dense forests and open plains, always keeping an eye out for danger. I’ve made good progress and found a nice cave to rest in for the night.', '2023-07-03'),
(1, 'Something feels off. I noticed strange markings on the trees and heard unusual noises at night. I can’t shake the feeling that I’m being followed. I need to stay alert and be cautious. My journey to Croatia might be more dangerous than I anticipated.', '2023-07-05');
COMMIT;
