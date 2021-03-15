-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: shareddb1a.hosting.stackcp.net
-- Generation Time: Apr 27, 2020 at 07:29 PM
-- Server version: 10.2.26-MariaDB-log
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cl10-freizeit`
--
CREATE DATABASE IF NOT EXISTS `cl10-freizeit` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `cl10-freizeit`;

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `price` float DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `name`, `price`, `active`, `created`, `updated`, `description`) VALUES
(1, 'Pizza selber backen', NULL, 1, '2020-02-18 08:45:13', '2020-01-23 14:54:58', 'Muss noch wegen öäü der Zeichencodierung geschaut werden'),
(2, 'Illusoria-Land', NULL, 1, '2020-01-31 21:41:30', '2020-01-31 17:41:15', ''),
(3, 'Minigolf', NULL, 0, '2020-01-31 17:41:15', '2020-01-31 17:41:15', '');

-- --------------------------------------------------------

--
-- Table structure for table `activity_to_persons`
--

CREATE TABLE `activity_to_persons` (
  `activity_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_to_persons`
--

INSERT INTO `activity_to_persons` (`activity_id`, `person_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 2),
(2, 3),
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `activity_to_regions`
--

CREATE TABLE `activity_to_regions` (
  `activity_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_to_regions`
--

INSERT INTO `activity_to_regions` (`activity_id`, `region_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `activity_to_saisons`
--

CREATE TABLE `activity_to_saisons` (
  `activity_id` int(11) NOT NULL,
  `saison_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_to_saisons`
--

INSERT INTO `activity_to_saisons` (`activity_id`, `saison_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `activity_to_times`
--

CREATE TABLE `activity_to_times` (
  `activity_id` int(11) NOT NULL,
  `time_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_to_times`
--

INSERT INTO `activity_to_times` (`activity_id`, `time_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `activity_to_weather`
--

CREATE TABLE `activity_to_weather` (
  `activity_id` int(11) NOT NULL,
  `weather_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_to_weather`
--

INSERT INTO `activity_to_weather` (`activity_id`, `weather_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(2, 3),
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `activity_to_weekdays`
--

CREATE TABLE `activity_to_weekdays` (
  `activity_id` int(11) NOT NULL,
  `weekday_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_to_weekdays`
--

INSERT INTO `activity_to_weekdays` (`activity_id`, `weekday_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7);

-- --------------------------------------------------------

--
-- Table structure for table `api`
--

CREATE TABLE `api` (
  `id` int(11) NOT NULL,
  `token` varchar(40) NOT NULL,
  `mode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `api`
--

INSERT INTO `api` (`id`, `token`, `mode`) VALUES
(1, 'CbVpLvY30Tajzi3pCBSg8UroxWOMoDUHz1PqAjdk', 'admin'),
(2, 'Ry3pOS1jacotX3QBVhhPaUNXwUFZmx8jiZ39MIzt', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `ausflugszeit`
--

CREATE TABLE `ausflugszeit` (
  `ausflugszeit_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ausflugszeit`
--

INSERT INTO `ausflugszeit` (`ausflugszeit_id`, `name`) VALUES
(1, 'Morgen'),
(2, 'Mittag'),
(3, 'Abend'),
(4, 'Tagesausflug');

-- --------------------------------------------------------

--
-- Table structure for table `freizeit_aktivitaeten`
--

CREATE TABLE `freizeit_aktivitaeten` (
  `id` int(11) NOT NULL COMMENT 'aktivitäts id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'rubrikname',
  `zeitbudget` varchar(255) NOT NULL COMMENT '1=Morgen, 2=Mittag, 3=Abend, 4=Tag',
  `region` varchar(255) NOT NULL COMMENT '1-10 1=Basel, 10=Zürich',
  `personen` varchar(255) NOT NULL COMMENT '1=EP,2=Paar,3=F,4=G',
  `wetter` varchar(255) NOT NULL COMMENT '1=schön,2=bewölkt,3=regen,4=kalt,5=heiss',
  `wochentag` varchar(255) NOT NULL COMMENT 'deaktiviert 1-7 -> montag-sonntag',
  `sommerwinter` varchar(10) NOT NULL DEFAULT '0' COMMENT '1 = Sommer, 2 = Winter',
  `ferien` varchar(255) NOT NULL COMMENT 'deaktiviert',
  `preis` varchar(255) NOT NULL COMMENT 'gratis = sternchen oder Zeichen',
  `freigabe` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'freigabe durch admin'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `freizeit_aktivitaeten`
--

INSERT INTO `freizeit_aktivitaeten` (`id`, `name`, `zeitbudget`, `region`, `personen`, `wetter`, `wochentag`, `sommerwinter`, `ferien`, `preis`, `freigabe`) VALUES
(1, 'Pizza selber backen', '2,3', '1,2,3,4,5,6,7,8,9,10', '1,2,3,4', '1,2,3,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(21, 'Illusoria-Land', '2', '2', '1,2,3,4', '1,2,3,4', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(20, 'Minigolf', '1,2,3', '1,2,3,4,5,6,7,8,9,10', '2,3,4', '1,2,4,5', '1,2,3,4,5,6', '1', '', '', 1),
(19, 'Panoramabr&uuml;cke Sigriswil', '1,2', '2', '1,2,3', '4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(12, 'Solebad Sch&ouml;nb&uuml;hl', '1,2,3', '2', '1,2,3,4', '1,2,3,4', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(22, 'HR Giger Museum', '2', '2', '1,2,4', '1,2,3', '3,4,5,6,7', '1,2', '', '', 1),
(23, 'Schloss Greyerz', '1,2', '2', '1,2,3,4', '1,3', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(24, 'Aareschlucht', '1,2,4', '2', '1,2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(27, 'Alpamare', '1,2,4', '10', '2,3,4', '1,2,3', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(28, 'Verkehrshaus Luzern', '1,2,4', '9', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(29, 'Papiliorama Kerzers', '2,4', '5', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(30, 'Kamblyfabrik Trubschachen', '1,2', '2', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', 'gratis', 1),
(31, 'D&auml;hlh&ouml;lzli', '1,2,4', '2', '1,2,3,4', '1,2', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(32, 'Seeteufel Studen', '1,2,4', '2', '2,3,4', '1,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(37, 'BernAqua Westside', '1,2,3,4', '2', '1,2,3', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(39, 'Spaziergang zum Gantrischsee', '1,2', '2', '2,3', '1,2,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(40, 'Fox Trail Bern', '1,2,4', '2', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(41, 'Fox Trail Luzern', '1,2', '9', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(42, 'Z&uuml;ri Zoo', '1,2,4', '10', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(43, 'Planetenweg Weissenstein', '1,2', '6', '2,3', '1,2,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(44, 'Charmey Aventures', '1,2', '5', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(45, 'Feldschl&ouml;sschen Brauerei', '2', '1', '2,4', '1,2,3,4,5', '1,2,3,4,5', '1,2', '', '', 1),
(46, 'Klettern', '1,2', '1,2,3,4,5,6,7,8,9,10', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(47, 'Nidlenloch Solothurn', '1,2,3,4', '6', '2,3,4', '1,2', '3,4,5,6,7', '1,2', '', '', 1),
(48, 'Bantiger (Aussichtsplattform) ', '1,2,4', '2', '2,3', '1,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(49, 'Go-Kart fahren', '2,3', '1,2,3,4,5,6,7,8,9,10', '3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(50, 'Paintball oder Lasertag', '2,3,4', '1,2,3,4,5,6,7,8,9,10', '3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(51, 'Riesentrottinet in Adelboden', '2,4', '2', '2,3,4', '1,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(53, 'Niederhorn (Beatenberg)', '2,4', '2', '1,2,3,4', '1', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(54, 'Apenzeller Alpenbitter Besichtigung', '2', '9', '4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', 'gratis', 1),
(55, 'Verenaschlucht', '2,3,4', '6', '2,3', '1,5', '1,2,3,4,5,6,7', '1,2', '', 'gratis', 1),
(56, 'Guggersh&ouml;rndli', '1,2,4', '2', '1,2,3,4', '1,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(57, 'Schlittschuhlaufen', '1,2,3', '1,2,3,4,5,6,7,8,9,10', '2,3,4', '1,2,4', '1,2,3,4,5,6,7', '2', '', '', 1),
(58, 'Schwimmen gehen (Hallenbad)', '2,3,4', '1,2,3,4,5,6,7,8,9,10', '2,3,4', '2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(59, 'Kino besuch', '2,3', '1,2,3,4,5,6,7,8,9,10', '2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(61, 'Sportzentrum Zuchwil (Baden, Minigolf)', '2,3,4', '6', '2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(74, 'Brigerbad', '2,3,4', '8', '2,3', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(73, 'Rheinfall', '2,4', '1', '2,3,4', '1,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(72, 'Chutzenturm (Gemeinde Sch&uuml;pfen)', '1,2', '2', '2,3,4', '1,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(71, 'Im Tierheim ein Hund abholen und spazieren gehen', '1,2', '2', '1,2,3', '1,2,4,5', '1,2,3,4,5,6,7', '1,2', '', 'gratis', 1),
(75, 'Swiss Miniatur', '2,4', '7', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(76, 'Vercascatal (Wandern)', '2,4', '7', '2,3', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(77, 'Technorama Winterthur', '1,2,4', '10', '2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(78, 'Aquapark', '1,2,4', '5', '2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(79, 'FIFA World Football Museum', '1,2,4', '10', '1,2,3,4', '1,2,3,4,5', '2,3,4,5,6,7', '1,2', '', '', 1),
(80, 'Sole uno Basel', '1,2,3,4', '1', '2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(81, 'Seilpark Gantrisch', '1,2,4', '2', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(82, 'Seilpark Balmberg', '1,2,4', '6', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(83, 'Seilpark Z&uuml;rich-Kloten', '1,2,4', '10', '2,3,4', '1,4,5', '3,6,7', '1', '', '', 1),
(84, 'Riesentrottinett in Leukerbad', '1,2,4', '8', '2,3,4', '1,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(85, 'E-Bike fahren im Naturpark Gantrisch', '1,2,4', '2', '2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(86, 'Val de Travers (Wandern)', '1,2,3,4', '5', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(87, 'B&auml;renpark', '1,2', '2', '2,3', '1,2,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(88, 'Weissenstein (Wandern, Biken, Fr&uuml;hst&uuml;ck)', '1,2', '6', '1,2,3,4', '1,4,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(90, 'Augusta Raurica', '1,2,4', '1', '1,2,3,4', '1,2,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(91, 'BEO Funpark B&ouml;singen', '1,2,4', '5', '3', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(92, 'Olympisches Museum Lausanne', '1,2,4', '5', '2,3,4', '1,2,3,4,5', '2,3,4,5,6,7', '1,2', '', '', 1),
(93, 'Schifffahrt auf dem Thuner-/Brienzersee', '1,2,3,4', '2', '2,3,4', '1,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(94, 'Schifffahrt auf dem Z&uuml;richsee', '1,2,3,4', '10', '2,3,4', '1,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(95, 'Schifffahrt auf dem Murten-/Bieler-/Neuenburgersee', '1,2,3,4', '2', '2,3,4', '1,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(96, 'Schlittlen in Grindelwald', '1,2,3,4', '2', '2,3,4', '1,2,4', '1,2,3,4,5,6,7', '2', '', '', 1),
(97, 'Naturhistorisches Museum Bern', '1,2,4', '2', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(98, 'Bodyflying R&uuml;mlang', '2,3', '10', '2,3,4', '1,2,3,4,5', '1,5,6,7', '1,2', '', '', 1),
(99, 'Sensorium R&uuml;ttihubelbad, Walkringen', '1,2,3,4', '2', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(100, 'Rolling Rock Skate- und Sportcenter', '2,3', '6', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(101, 'Appenzeller Brauchtumsmuseum in Urn&auml;sch', '1,2', '4', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(102, 'Schlitteln am Kronberg', '1,2', '4', '1,2,3,4', '1,2,3,4', '1,2,3,4,5,6,7', '2', '', '', 1),
(103, 'H&auml;ngebr&uuml;cke Hostalde', '1,2', '2', '1,2,3,4', '1,2,4,5', '2,3,4,5,6,7', '1,2', '', '1.-', 1),
(104, 'Schlitteln auf der Lenzerheide', '1,2', '3', '1,2,3,4', '1,2,3,4', '1,2,3,4,5,6,7', '2', '', '', 1),
(105, 'Schlitteln auf dem Pilatus', '1,2', '9', '1,2,3,4', '1,2,3,4', '1,2,3,4,5,6,7', '2', '', '', 1),
(106, 'Aeschbach Chocolatier Chocowelt', '1,2', '9', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(107, 'H&ouml;henwanderung &uuml;ber die Pilatuskette', '1,2', '9', '1,2,3,4', '1,2,4', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(108, 'Glasi Hergiswil', '1,2', '9', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6', '1,2', '', '', 1),
(109, 'Wilhelm Tell Express Luzern', '1', '9', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(110, 'Skisprung Schnuppertraining in Einsiedeln', '1,2', '9', '1,2,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(111, 'Diorama Bethlehem in Einsiedeln', '2', '9', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(112, 'Museum Haarundkamm in M&uuml;mliswil', '1,2', '6', '1,2,3,4', '1,2,3,4,5', '3,4,5,6,7', '1,2', '', '', 1),
(113, 'Winterspaziergang auf dem Ch&auml;serugg', '1,2', '4', '1,2,3,4', '1,2,4', '1,2,3,4,5,6,7', '2', '', '', 1),
(114, 'PODHouses auf dem Atzm&auml;nnig', '3', '4', '3', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(115, 'Tibetanische Br&uuml;cke Carasc', '1,2', '7', '1,2,3,4', '1,2', '1,2,3,4,5,6,7', '1', '', '', 1),
(116, 'Surselva Run', '1,2', '9', '1,2,3,4', '1,2,3,4', '1,2,3,4,5,6,7', '1', '', '', 1),
(117, 'Landesmuseum Z&uuml;rich', '1,2', '10', '2,3', '1,2,3,4,5', '2,3,4,5,6,7', '1,2', '', '', 1),
(118, 'Kinderhotel Schweizerhof', '2,3', '3', '3', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(119, 'Realfly in Sion', '1,2', '8', '1,2', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(120, 'Kronberg Bobbahn', '1,2', '4', '1,2,3,4', '1,2,4,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(121, 'Leukerbad Therme', '1,2', '8', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(122, 'Toggenburger Klangweg', '1,2', '4', '1,2,3,4', '1,2,4,5', '1,2,3,4,5,6,7', '1', '', '', 1),
(123, 'Greisinger Museum', '1,2', '3', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(125, 'Ovaverva Hallenbad und Spa St. Moritz', '1,2,3', '3', '2,3', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(126, 'Thermalbad Zurzach', '1,2', '10', '2,3,4', '1,2,3', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(127, 'Natur- und Tierpark Goldau', '1,2', '9', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(128, 'Gletschergarten Luzern', '1,2', '9', '1,2,3,4', '1,2,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(129, 'Schloss Chillon', '1,2', '5', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(130, 'Tropenhaus Wolhusen', '1,2', '9', '1,2,3,4', '1,2,3,4,5', '3,4,5,6,7', '1,2', '', '', 1),
(131, 'Walter Zoo Gossau', '1,2', '4', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(132, 'Zoo Basel', '1,2', '1', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(133, 'Aussichtsberg Hoher Kasten', '1,2', '4', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(134, 'Kunstmuseum Bern', '1,2', '2', '1,2,3,4', '1,2,3,4,5', '2,3,4,5,6,7', '1,2', '', '', 1),
(135, 'Westside Shopping- und Erlebniscenter', '1,2,3', '2', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(136, 'Splash e Spa Tamaro', '1,2', '7', '2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(137, 'Aquabasilea Pratteln', '1,2', '1', '1,2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(138, 'Termali Salini ', '1,2', '7', '2,3,4', '1,2,3,4,5', '1,2,3,4,5,6,7', '1,2', '', '', 1),
(139, 'Tropenhaus Frutigen', '1,2', '2', '1,2,3,4', '1,2,3,4,5', '2,3,4,5,6,7', '1,2', '', '', 1),
(140, 'Besuchszentrum Vogelwarte Sempach', '1,2', '9', '1,2,3,4', '1,2,3,4,5', '2,3,4,5,6,7', '1,2', '', '', 1),
(141, 'Sportzentrum Zuchwil (Schlittschuhlaufen)', '1,2', '6', '1,2,3,4', '1,2', '1,2,3,4,5,6,7', '2', '', '', 1),
(142, 'Weissenstein (Schlitteln, Fr&uuml;hst&uuml;ck)', '1,2', '6', '1,2,3,4', '1,2', '1,2,3,4,5,6,7', '2', '', '', 1),
(177, 'Dinosauriermuseum Aathal', '1,2,3,4', '10', '1,2,3,4', '1,2,3', '', '1,2', '', '', 1),
(178, 'Indooranlage Br&uuml;nig', '1,2,4', '2', '1,2,4', '1,2,3', '', '1,2', '', '', 1),
(179, 'Gelmlerbahn', '2,4', '2', '2,3,4', '1', '', '1', '', '', 1),
(180, 'Schynigiplatte', '1,2,4', '2', '2,3,4', '1', '', '1', '', '', 1),
(176, 'Papiermuseum Basel', '1,2', '1', '1,2,3', '1,2,3', '', '1,2', '', '', 1),
(182, 'L&ouml;tschberg S&uuml;drampe (Wandern)', '4', '8', '2,3,4', '1', '', '1', '', '', 1),
(183, 'Thermalbad Leukerbad', '1,2,3,4', '8', '2,3,4', '1,2,3', '', '1,2', '', '', 1),
(184, 'Fondue-Iglu Engstligenalp', '3', '2', '2,3,4', '1,2', '', '2', '', '', 1),
(185, 'Schneeschuhlaufen', '1,2,4', '1,2,3,4,5,6,7,8,9,10', '2,3,4', '1', '', '2', '', '', 1),
(187, 'L&ouml;tschentaler Museum in Kippel', '1,2,3,4', '8', '1,2,3,4', '1,2,3', '', '1,2', '', '', 1),
(188, 'Monte Tamaro', '1,2,4', '7', '2,3,4', '1', '', '1', '', '', 1),
(189, 'Burgen von Bellinzona', '1,2,4', '7', '1,2,3,4', '1', '', '1', '', '', 1),
(190, 'Isole di Brissago', '1,2,4', '7', '1,2,3,4', '1', '', '1,2', '', '', 1),
(191, 'Matterhorn', '1,2,4', '8', '1,2,3,4', '1', '', '1,2', '', '', 1),
(192, 'Aletscharena (Wandern, Skifahren, usw.)', '1,2,3,4', '8', '1,2,3,4', '1', '', '1,2', '', '', 1),
(193, 'Kunstmuseum Thun', '1,2', '2', '1,2,3,4', '1,2,3', '', '1,2', '', '', 1),
(194, 'Historisches Museum Bern', '1,2', '2', '1,2,3,4', '1,2,3', '', '1,2', '', '', 1),
(195, 'Freilichtmuseum Ballenberg', '1,2', '2', '1,2,3,4', '1,2', '', '1', '', '', 1),
(215, 'Falconeria Locarno', '1,2,4', '7', '2,3,4', '1,2', '', '1', '', '', 1),
(216, 'Taminaschlucht', '1,2,4', '3', '2,3,4', '1,2', '', '1', '', '', 1),
(217, 'Hamam Bern', '1,2,3', '2', '1,2', '1,2,3', '', '1,2', '', '', 1),
(218, 'Blausee', '1,2,4', '2', '1,2,3,4', '1', '', '1,2', '', '', 1),
(219, 'Beatush&ouml;hlen', '2,4', '2', '2,3,4', '1,2,3', '', '1', '', '', 1),
(220, 'AQUANTIS Aquarium-Vivarium Lausanne', '1,2,4', '5', '1,2,3,4', '1,2,3', '', '1,2', '', '', 1),
(221, 'M&auml;nziwilegg', '1,2,3', '2', '1,2,3,4', '1,2', '', '1', '', '', 1),
(222, 'GeoCaching', '1,2,3,4', '1,2,3,4,5,6,7,8,9,10', '1,2,3,4', '1,2', '', '1,2', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `person_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`person_id`, `name`) VALUES
(1, 'Einzelperson'),
(2, 'Paar'),
(3, 'Familie');

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `name`) VALUES
(1, 'Einzelperson'),
(2, 'Paar'),
(3, 'Familie'),
(4, 'Gruppe');

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `region_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`region_id`, `name`) VALUES
(1, 'Bernbiet'),
(2, 'Baselbiet'),
(3, 'Graubünden'),
(4, 'Ostschweiz'),
(5, 'Romandie'),
(6, 'Solothurn - Aargau'),
(7, 'Tessin'),
(8, 'Wallis'),
(9, 'Zentralschweiz'),
(10, 'Zürich Region');

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `name`) VALUES
(1, 'Baselbiet'),
(2, 'Bernbiet'),
(3, 'Graubünden'),
(4, 'Ostschweiz'),
(5, 'Romandie'),
(6, 'Solothurn - Argau'),
(7, 'Tessin'),
(8, 'Wallis'),
(9, 'Zentralschweiz'),
(10, 'Zürich Region');

-- --------------------------------------------------------

--
-- Table structure for table `saison`
--

CREATE TABLE `saison` (
  `saison_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saison`
--

INSERT INTO `saison` (`saison_id`, `name`) VALUES
(1, 'Frühling'),
(2, 'Sommer'),
(3, 'Herbst'),
(4, 'Winter');

-- --------------------------------------------------------

--
-- Table structure for table `saisons`
--

CREATE TABLE `saisons` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saisons`
--

INSERT INTO `saisons` (`id`, `name`) VALUES
(1, 'Sommer'),
(2, 'Winter');

-- --------------------------------------------------------

--
-- Table structure for table `support`
--

CREATE TABLE `support` (
  `id` int(11) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  `message` text NOT NULL,
  `readed_user` int(1) NOT NULL DEFAULT 0,
  `readed_admin` int(1) NOT NULL,
  `device` text NOT NULL,
  `deleted_user` date DEFAULT NULL,
  `deleted_admin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `support`
--

INSERT INTO `support` (`id`, `user_id`, `message`, `readed_user`, `readed_admin`, `device`, `deleted_user`, `deleted_admin`) VALUES
(1, '098f6bcd4621d373cade4e832627b4f6', 'Wie wäre es mit einer Sparte für Transportmittel: Zu erreichen mit... Zug Schiff Auto (Parkplätze?) Tram Bus Fernbus Car', 1, 0, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36', NULL, NULL),
(2, '098f6bcd4621d373cade4e832627b4f6', 'Vielen Dank für deine Anfrage. Wir werden dies zur Kenntnis nehmen und bald hinzufügen.\r\nWeiterhin viel Spass mit Freizeit-Aktivitäten', 0, 1, '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `times`
--

CREATE TABLE `times` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `times`
--

INSERT INTO `times` (`id`, `name`) VALUES
(1, 'Vormittag'),
(2, 'Nachmittag'),
(3, 'Abend'),
(4, 'Tagesausflug');

-- --------------------------------------------------------

--
-- Table structure for table `weather`
--

CREATE TABLE `weather` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weather`
--

INSERT INTO `weather` (`id`, `name`) VALUES
(1, 'Schön'),
(2, 'Bewölkt'),
(3, 'Regen'),
(4, 'Kalt'),
(5, 'Heiss');

-- --------------------------------------------------------

--
-- Table structure for table `weekdays`
--

CREATE TABLE `weekdays` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weekdays`
--

INSERT INTO `weekdays` (`id`, `name`) VALUES
(1, 'Montag'),
(2, 'Dienstag'),
(3, 'Mittwoch'),
(4, 'Donnerstag'),
(5, 'Freitag'),
(6, 'Samstag'),
(7, 'Sonntag');

-- --------------------------------------------------------

--
-- Table structure for table `wetter`
--

CREATE TABLE `wetter` (
  `wetter_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wetter`
--

INSERT INTO `wetter` (`wetter_id`, `name`) VALUES
(1, 'Schön'),
(2, 'Bewölkt'),
(3, 'Regen'),
(4, 'Kalt'),
(5, 'Heiss');

-- --------------------------------------------------------

--
-- Table structure for table `wochentag`
--

CREATE TABLE `wochentag` (
  `wochentag_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wochentag`
--

INSERT INTO `wochentag` (`wochentag_id`, `name`) VALUES
(1, 'Montag'),
(2, 'Dienstag'),
(3, 'Mittwoch'),
(4, 'Donnerstag'),
(5, 'Freitag'),
(6, 'Samstag'),
(7, 'Sonntag');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activity_to_persons`
--
ALTER TABLE `activity_to_persons`
  ADD KEY `activity_to_persons` (`activity_id`),
  ADD KEY `persons_to_activity` (`person_id`);

--
-- Indexes for table `activity_to_regions`
--
ALTER TABLE `activity_to_regions`
  ADD KEY `activity_to_regions` (`activity_id`),
  ADD KEY `regions_to_activity` (`region_id`);

--
-- Indexes for table `activity_to_saisons`
--
ALTER TABLE `activity_to_saisons`
  ADD KEY `activity_to_saisons` (`activity_id`),
  ADD KEY `saisons_to_activity` (`saison_id`);

--
-- Indexes for table `activity_to_times`
--
ALTER TABLE `activity_to_times`
  ADD KEY `activity_to_times` (`activity_id`),
  ADD KEY `times_to_activity` (`time_id`);

--
-- Indexes for table `activity_to_weather`
--
ALTER TABLE `activity_to_weather`
  ADD KEY `activity_to_weather` (`activity_id`),
  ADD KEY `weather_to_activity` (`weather_id`);

--
-- Indexes for table `activity_to_weekdays`
--
ALTER TABLE `activity_to_weekdays`
  ADD KEY `activity_to_weekdays` (`activity_id`),
  ADD KEY `weekdays_to_activity` (`weekday_id`);

--
-- Indexes for table `api`
--
ALTER TABLE `api`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ausflugszeit`
--
ALTER TABLE `ausflugszeit`
  ADD PRIMARY KEY (`ausflugszeit_id`);

--
-- Indexes for table `freizeit_aktivitaeten`
--
ALTER TABLE `freizeit_aktivitaeten`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`region_id`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `saison`
--
ALTER TABLE `saison`
  ADD PRIMARY KEY (`saison_id`);

--
-- Indexes for table `saisons`
--
ALTER TABLE `saisons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support`
--
ALTER TABLE `support`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `times`
--
ALTER TABLE `times`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weather`
--
ALTER TABLE `weather`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weekdays`
--
ALTER TABLE `weekdays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wetter`
--
ALTER TABLE `wetter`
  ADD PRIMARY KEY (`wetter_id`);

--
-- Indexes for table `wochentag`
--
ALTER TABLE `wochentag`
  ADD PRIMARY KEY (`wochentag_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `api`
--
ALTER TABLE `api`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ausflugszeit`
--
ALTER TABLE `ausflugszeit`
  MODIFY `ausflugszeit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `freizeit_aktivitaeten`
--
ALTER TABLE `freizeit_aktivitaeten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'aktivitäts id', AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `person_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `region_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `saison`
--
ALTER TABLE `saison`
  MODIFY `saison_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `saisons`
--
ALTER TABLE `saisons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `support`
--
ALTER TABLE `support`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `times`
--
ALTER TABLE `times`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `weather`
--
ALTER TABLE `weather`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `weekdays`
--
ALTER TABLE `weekdays`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `wetter`
--
ALTER TABLE `wetter`
  MODIFY `wetter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `wochentag`
--
ALTER TABLE `wochentag`
  MODIFY `wochentag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_to_persons`
--
ALTER TABLE `activity_to_persons`
  ADD CONSTRAINT `activity_to_persons` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persons_to_activity` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_to_regions`
--
ALTER TABLE `activity_to_regions`
  ADD CONSTRAINT `activity_to_regions` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `regions_to_activity` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_to_saisons`
--
ALTER TABLE `activity_to_saisons`
  ADD CONSTRAINT `activity_to_saisons` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `saisons_to_activity` FOREIGN KEY (`saison_id`) REFERENCES `saisons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_to_times`
--
ALTER TABLE `activity_to_times`
  ADD CONSTRAINT `activity_to_times` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `times_to_activity` FOREIGN KEY (`time_id`) REFERENCES `times` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_to_weather`
--
ALTER TABLE `activity_to_weather`
  ADD CONSTRAINT `activity_to_weather` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `weather_to_activity` FOREIGN KEY (`weather_id`) REFERENCES `weather` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_to_weekdays`
--
ALTER TABLE `activity_to_weekdays`
  ADD CONSTRAINT `activity_to_weekdays` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `weekdays_to_activity` FOREIGN KEY (`weekday_id`) REFERENCES `weekdays` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
