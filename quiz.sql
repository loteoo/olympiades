-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2018 at 09:55 PM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` int(11) NOT NULL,
  `question_title` varchar(255) NOT NULL,
  `test` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`id`, `question_title`, `test`, `created_at`) VALUES
(1, 'Complètes la suite suivante...', 'sdfsdf', '2018-05-03 17:05:08'),
(2, 'asdf', 'sdffsdaf', '2018-05-03 17:11:30'),
(3, 'asdf', 'asdfasdf', '2018-05-03 17:11:30');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `choices` varchar(255) NOT NULL,
  `answer` int(11) NOT NULL,
  `hint` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `quiz_id`, `question`, `choices`, `answer`, `hint`, `created_at`) VALUES
(11, 1, '38 - 2 - 19 - 9 - 3 - 3 - 40 - 4 - ?', '[36,10,24]', 10, 'La division du premier chiffre par le deuxiÃ¨me te donne le troisiÃ¨me. MÃªme chose pour les trois suivants...', '2018-05-03 15:55:43'),
(12, 1, '9 - 14 - 19 - 24 - 29 - ?', '[34,39,44]', 34, 'La progression est de +5 entre chaque chiffre...', '2018-05-03 15:55:43'),
(13, 1, '5 - 11 - 7 - 13 - 9 - 15 - 11 - ?', '[17,13,15]', 17, 'La progression est de +2 mais sur 1 chiffre sur 2...', '2018-05-03 15:55:43'),
(14, 1, '8 - 10 - 13 - 17 - 22 - ?', '[17,27,28]', 28, 'La progression est de +2,+3,+4,+5,et donc +6...', '2018-05-03 15:55:43'),
(15, 1, '124 - 112 - 101 - 91 - 82 - 74 - ?', '[68,67,64]', 67, 'Il faut enlever -12, puis -11, puis -10, puis -9, etc...', '2018-05-03 15:55:43'),
(16, 1, '42 - 36 - 30 - 24 - 18 - ?', '[12,42,36]', 12, 'On retire 6 Ã  chaque chiffre...', '2018-05-03 15:55:43'),
(17, 1, '24 - 48 - 37 - 74 - 58 - 116 - 41 - ?', '[68,52,82]', 82, 'Les chiffres vont 2 par 2 et pour chaque couple le deuxiÃ¨me est le double du premier...', '2018-05-03 15:55:43'),
(18, 1, '1 - 3 - 5 - 7 - 11 - 13 - ?', '[15,17,21]', 17, 'Ce sont des nombres premiers : divisibles seulement par 1 et par eux mÃªmes...', '2018-05-03 15:55:43'),
(19, 1, '1 - 2 - 2 - 4 - 8 - 32 -  ?', '[256,64,128]', 256, 'Il faut multiplier 1x2, puis 2x2, puis 2x4, puis 4x8, puis 8x32...', '2018-05-03 15:55:43'),
(20, 1, '8 - 2 - 6 - 4 - 7 - 3 - 5 - ?', '[8,5,6]', 5, 'Le total de chaque paire fait 10 : 8+2=10, 6+4=10, 7+3=10, etc...', '2018-05-03 15:55:43');

-- --------------------------------------------------------

--
-- Table structure for table `quizes`
--

CREATE TABLE `quizes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quizes`
--

INSERT INTO `quizes` (`id`, `title`, `created_at`) VALUES
(1, 'Completes la suite suivante...', '2018-05-03 17:26:20');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `total_seconds` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `quiz_results`
--

INSERT INTO `quiz_results` (`id`, `user_id`, `quiz_id`, `total_seconds`, `score`, `created_at`) VALUES
(2, 100, 1, 5, 40, '2018-05-03 19:24:38'),
(4, 107, 1, 4, 20, '2018-05-03 19:52:25'),
(5, 108, 1, 4, 40, '2018-05-03 19:54:59'),
(6, 110, 1, 5, 40, '2018-05-03 19:59:03'),
(7, 109, 1, 10, 20, '2018-05-03 20:01:58'),
(8, 109, 1, 21, 60, '2018-05-03 20:02:24'),
(9, 109, 1, 5, 60, '2018-05-03 20:13:57'),
(10, 109, 1, 3, 20, '2018-05-03 20:14:10'),
(11, 109, 1, 3, 40, '2018-05-03 20:15:19'),
(12, 109, 1, 6, 40, '2018-05-03 20:15:49'),
(13, 109, 1, 4, 60, '2018-05-03 20:18:29'),
(14, 109, 1, 4, 60, '2018-05-03 20:19:11'),
(15, 109, 1, 3, 60, '2018-05-03 20:20:28'),
(16, 109, 1, 4, 20, '2018-05-03 20:20:57'),
(17, 109, 1, 3, 40, '2018-05-03 20:24:29'),
(18, 109, 1, 3, 20, '2018-05-03 20:33:15'),
(19, 109, 1, 7, 40, '2018-05-03 20:43:53'),
(20, 109, 1, 4, 60, '2018-05-03 20:45:25'),
(21, 113, 1, 42, 0, '2018-05-03 20:48:04'),
(22, 109, 1, 5, 60, '2018-05-03 20:51:52'),
(23, 109, 1, 4, 40, '2018-05-03 20:56:13'),
(24, 109, 1, 11, 80, '2018-05-03 20:56:23'),
(26, 109, 1, 4, 40, '2018-05-03 20:57:13'),
(27, 109, 1, 4, 20, '2018-05-03 21:00:02'),
(28, 114, 1, 3, 40, '2018-05-03 21:01:15'),
(29, 114, 1, 9, 40, '2018-05-03 21:01:33'),
(30, 109, 1, 5, 20, '2018-05-03 21:02:23'),
(31, 109, 1, 17, 40, '2018-05-03 21:02:43'),
(32, 109, 1, 126, 40, '2018-05-04 13:13:11'),
(33, 109, 1, 115, 20, '2018-05-04 13:15:10'),
(34, 109, 1, 6, 0, '2018-05-04 13:18:59'),
(35, 109, 1, 3, 60, '2018-05-04 13:19:04'),
(36, 109, 1, 9, 20, '2018-05-04 13:19:27'),
(37, 109, 1, 7, 20, '2018-05-04 13:25:48'),
(38, 109, 1, 5, 0, '2018-05-04 13:26:00'),
(39, 109, 1, 20, 20, '2018-05-04 13:26:25'),
(40, 109, 1, 5, 60, '2018-05-04 13:29:01'),
(41, 109, 1, 4, 20, '2018-05-04 13:29:11'),
(43, 109, 1, 4, 40, '2018-05-04 13:35:40'),
(44, 109, 1, 3, 40, '2018-05-04 13:36:36'),
(45, 109, 1, 3, 20, '2018-05-04 13:38:09'),
(46, 109, 1, 3, 20, '2018-05-04 13:38:24'),
(47, 109, 1, 3, 60, '2018-05-04 13:41:57'),
(48, 109, 1, 43, 0, '2018-05-04 13:42:57'),
(49, 109, 1, 3, 20, '2018-05-04 13:45:17'),
(50, 109, 1, 7, 60, '2018-05-04 13:49:30'),
(51, 109, 1, 5, 40, '2018-05-04 14:01:02'),
(52, 109, 1, 39, 40, '2018-05-04 14:04:26'),
(53, 109, 1, 6, 40, '2018-05-04 14:05:21'),
(55, 109, 1, 5, 40, '2018-05-04 14:11:30'),
(56, 109, 1, 5, 40, '2018-05-04 14:11:50'),
(57, 109, 1, 6, 20, '2018-05-04 14:12:30'),
(58, 109, 1, 5, 20, '2018-05-04 14:13:05'),
(59, 109, 1, 8, 40, '2018-05-04 14:32:11'),
(60, 109, 1, 4, 40, '2018-05-04 14:32:34'),
(61, 109, 1, 7, 40, '2018-05-04 14:42:52'),
(62, 109, 1, 24, 40, '2018-05-04 14:44:14'),
(63, 109, 1, 8, 40, '2018-05-04 15:00:50'),
(64, 109, 1, 11, 40, '2018-05-04 15:19:59'),
(65, 109, 1, 40, 60, '2018-05-04 15:23:45'),
(66, 109, 1, 12, 0, '2018-05-04 15:23:59'),
(67, 109, 1, 92, 0, '2018-05-04 15:36:52'),
(68, 109, 1, 23, 40, '2018-05-04 15:39:43'),
(69, 109, 1, 7, 40, '2018-05-04 15:40:23'),
(70, 109, 1, 25, 60, '2018-05-04 15:55:27'),
(71, 109, 1, 39, 20, '2018-05-04 15:56:07'),
(72, 109, 1, 93, 0, '2018-05-04 15:57:43'),
(73, 109, 1, 10, 40, '2018-05-04 16:05:11'),
(74, 109, 1, 55, 60, '2018-05-04 16:07:42'),
(75, 109, 1, 5, 20, '2018-05-04 16:07:49'),
(76, 109, 1, 23, 60, '2018-05-04 16:08:17'),
(77, 109, 1, 37, 40, '2018-05-04 16:08:59'),
(78, 109, 1, 9, 20, '2018-05-04 16:09:27'),
(79, 109, 1, 9, 40, '2018-05-04 16:10:07'),
(80, 109, 1, 56, 20, '2018-05-04 16:26:52'),
(81, 109, 1, 11, 40, '2018-05-04 16:28:20'),
(82, 109, 1, 21, 20, '2018-05-04 16:29:41'),
(83, 109, 1, 11, 20, '2018-05-04 17:37:57'),
(84, 109, 1, 19, 0, '2018-05-04 17:42:08'),
(86, 109, 1, 14, 0, '2018-05-04 17:46:00'),
(87, 109, 1, 48, 0, '2018-05-04 17:46:52'),
(88, 109, 1, 74, 40, '2018-05-04 17:48:56'),
(89, 109, 1, 15, 20, '2018-05-04 17:49:44'),
(90, 109, 1, 83, 20, '2018-05-04 17:51:12'),
(91, 109, 1, 15, 20, '2018-05-04 17:51:29'),
(92, 109, 1, 21, 20, '2018-05-04 17:54:05'),
(93, 109, 1, 112, 0, '2018-05-04 17:59:50'),
(94, 109, 1, 13, 40, '2018-05-04 18:00:41'),
(95, 109, 1, 11, 0, '2018-05-04 18:01:02'),
(96, 109, 1, 5, 40, '2018-05-04 18:02:33'),
(97, 109, 1, 11, 40, '2018-05-04 18:04:06'),
(99, 109, 1, 5, 20, '2018-05-04 18:14:51'),
(100, 109, 1, 5, 20, '2018-05-04 18:15:23'),
(101, 109, 1, 4, 40, '2018-05-04 18:16:24'),
(102, 109, 1, 4, 20, '2018-05-04 18:17:11'),
(103, 109, 1, 4, 80, '2018-05-04 18:20:33'),
(104, 109, 1, 5, 40, '2018-05-04 18:21:09'),
(105, 109, 1, 5, 40, '2018-05-04 18:23:44'),
(106, 109, 1, 8, 40, '2018-05-04 18:25:18'),
(107, 109, 1, 5, 40, '2018-05-04 18:25:51'),
(108, 109, 1, 4, 40, '2018-05-04 18:27:05'),
(109, 109, 1, 5, 20, '2018-05-04 18:28:39'),
(110, 109, 1, 4, 20, '2018-05-04 18:31:17'),
(112, 121, 1, 5, 80, '2018-05-04 18:32:08'),
(113, 121, 1, 7, 20, '2018-05-04 18:32:22'),
(114, 109, 1, 5, 40, '2018-05-04 18:41:05'),
(116, 109, 1, 4, 60, '2018-05-04 18:46:44'),
(117, 109, 1, 8, 40, '2018-05-04 18:49:23'),
(118, 109, 1, 4, 20, '2018-05-04 19:04:38'),
(119, 109, 1, 4, 20, '2018-05-04 19:06:22'),
(120, 109, 1, 4, 60, '2018-05-04 19:07:50'),
(121, 109, 1, 4, 20, '2018-05-04 19:07:56'),
(122, 109, 1, 5, 40, '2018-05-04 19:09:32'),
(123, 109, 1, 5, 0, '2018-05-04 19:11:00'),
(124, 109, 1, 65, 40, '2018-05-04 19:13:37'),
(125, 109, 1, 135, 40, '2018-05-04 19:17:03'),
(126, 109, 1, 9, 20, '2018-05-04 19:18:16'),
(127, 109, 1, 8, 0, '2018-05-04 19:18:45'),
(128, 109, 1, 7, 60, '2018-05-04 19:19:34'),
(129, 109, 1, 8, 60, '2018-05-04 19:19:55'),
(130, 122, 1, 5, 40, '2018-05-04 19:27:39'),
(131, 122, 1, 5, 0, '2018-05-04 19:28:47'),
(132, 122, 1, 4, 0, '2018-05-04 19:29:35'),
(133, 109, 1, 53, 20, '2018-05-04 19:50:10'),
(134, 109, 1, 7, 40, '2018-05-04 19:50:49'),
(135, 123, 1, 10, 80, '2018-05-04 19:51:23'),
(136, 123, 1, 8, 60, '2018-05-04 19:51:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `best_quiz_result_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `best_quiz_result_id`, `created_at`) VALUES
(108, 'asdfasdf', 5, '2018-05-03 19:54:54'),
(109, 'loteoo', 25, '2018-05-03 19:58:17'),
(110, 'loteoo', 6, '2018-05-03 19:58:57'),
(112, 'esttset', NULL, '2018-05-03 20:46:23'),
(113, 'testst', 21, '2018-05-03 20:47:21'),
(114, 'asdfasd', 28, '2018-05-03 21:01:10'),
(115, 'test', NULL, '2018-05-03 21:04:37'),
(116, 'ltoeoo', NULL, '2018-05-04 14:39:37'),
(117, 'loteo', NULL, '2018-05-04 14:40:54'),
(118, 'asd', NULL, '2018-05-04 15:17:22'),
(119, '`loteoo', NULL, '2018-05-04 15:26:34'),
(120, 'loteo0o', NULL, '2018-05-04 17:55:48'),
(121, 'tsegadfgasdfg', NULL, '2018-05-04 18:31:46'),
(122, 'Test test', NULL, '2018-05-04 19:27:33'),
(123, 'asgdfjkasf', NULL, '2018-05-04 19:51:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quizes`
--
ALTER TABLE `quizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `quizes`
--
ALTER TABLE `quizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
