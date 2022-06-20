-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 09, 2022 at 01:48 PM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `decentralize`
--
CREATE DATABASE IF NOT EXISTS `decentralize` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `decentralize`;

-- --------------------------------------------------------

--
-- Table structure for table `admins_admin`
--

CREATE TABLE IF NOT EXISTS `admins_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admins_admin`
--

INSERT INTO `admins_admin` (`id`, `name`, `email`, `password`) VALUES
(1, 'ADMIN', 'admin@gmail.com', '1111');

-- --------------------------------------------------------

--
-- Table structure for table `admins_auditaccess`
--

CREATE TABLE IF NOT EXISTS `admins_auditaccess` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `auditerid` int(11) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `admins_bankaccess`
--

CREATE TABLE IF NOT EXISTS `admins_bankaccess` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `managerid` int(11) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `admins_useraccess`
--

CREATE TABLE IF NOT EXISTS `admins_useraccess` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audit_audit`
--

CREATE TABLE IF NOT EXISTS `audit_audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `auditerid` int(11) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audit_requiredlist`
--

CREATE TABLE IF NOT EXISTS `audit_requiredlist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(50) DEFAULT NULL,
  `list` longtext NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `key` varchar(50) DEFAULT NULL,
  `access` tinyint(1) DEFAULT NULL,
  `requestid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audit_requirements`
--

CREATE TABLE IF NOT EXISTS `audit_requirements` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `documentname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `audit_requirements`
--

INSERT INTO `audit_requirements` (`id`, `type`, `documentname`) VALUES
(1, 'FINANCIAL AUDIT', 'INCOME STATEMENT'),
(2, 'INTERNAL AUDIT', 'LIST OF ALL BANK ACCOUNT UTILIZED'),
(3, 'FINANCIAL AUDIT', 'CASH FLOW STATEMENT'),
(4, 'INTERNAL AUDIT', 'LIST AND EVIDENCE OF ALL TRANSACTIONS'),
(5, 'INTERNAL AUDIT', 'REPORTS ON PAYROLL'),
(6, 'INTERNAL AUDIT', 'GENERAL LEDGER'),
(7, 'INTERNAL AUDIT', 'TRAIL BALANCE OF COMPANY'),
(8, 'INTERNAL AUDIT', 'COPIES OF LEGAL DOCUMENT'),
(9, 'INTERNAL AUDIT', 'LOAN DOCUMENTS'),
(15, 'FINANCIAL AUDIT', 'BALANCE SHEET');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=97 ;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add admin', 7, 'add_admin'),
(26, 'Can change admin', 7, 'change_admin'),
(27, 'Can delete admin', 7, 'delete_admin'),
(28, 'Can view admin', 7, 'view_admin'),
(29, 'Can add auditaccess', 8, 'add_auditaccess'),
(30, 'Can change auditaccess', 8, 'change_auditaccess'),
(31, 'Can delete auditaccess', 8, 'delete_auditaccess'),
(32, 'Can view auditaccess', 8, 'view_auditaccess'),
(33, 'Can add bankaccess', 9, 'add_bankaccess'),
(34, 'Can change bankaccess', 9, 'change_bankaccess'),
(35, 'Can delete bankaccess', 9, 'delete_bankaccess'),
(36, 'Can view bankaccess', 9, 'view_bankaccess'),
(37, 'Can add useraccess', 10, 'add_useraccess'),
(38, 'Can change useraccess', 10, 'change_useraccess'),
(39, 'Can delete useraccess', 10, 'delete_useraccess'),
(40, 'Can view useraccess', 10, 'view_useraccess'),
(41, 'Can add audit', 11, 'add_audit'),
(42, 'Can change audit', 11, 'change_audit'),
(43, 'Can delete audit', 11, 'delete_audit'),
(44, 'Can view audit', 11, 'view_audit'),
(45, 'Can add requiredlist', 12, 'add_requiredlist'),
(46, 'Can change requiredlist', 12, 'change_requiredlist'),
(47, 'Can delete requiredlist', 12, 'delete_requiredlist'),
(48, 'Can view requiredlist', 12, 'view_requiredlist'),
(49, 'Can add bank', 13, 'add_bank'),
(50, 'Can change bank', 13, 'change_bank'),
(51, 'Can delete bank', 13, 'delete_bank'),
(52, 'Can view bank', 13, 'view_bank'),
(53, 'Can add scheme', 14, 'add_scheme'),
(54, 'Can change scheme', 14, 'change_scheme'),
(55, 'Can delete scheme', 14, 'delete_scheme'),
(56, 'Can view scheme', 14, 'view_scheme'),
(57, 'Can add loan', 15, 'add_loan'),
(58, 'Can change loan', 15, 'change_loan'),
(59, 'Can delete loan', 15, 'delete_loan'),
(60, 'Can view loan', 15, 'view_loan'),
(61, 'Can add schemeupload', 16, 'add_schemeupload'),
(62, 'Can change schemeupload', 16, 'change_schemeupload'),
(63, 'Can delete schemeupload', 16, 'delete_schemeupload'),
(64, 'Can view schemeupload', 16, 'view_schemeupload'),
(65, 'Can add loanupload', 17, 'add_loanupload'),
(66, 'Can change loanupload', 17, 'change_loanupload'),
(67, 'Can delete loanupload', 17, 'delete_loanupload'),
(68, 'Can view loanupload', 17, 'view_loanupload'),
(69, 'Can add user', 18, 'add_user'),
(70, 'Can change user', 18, 'change_user'),
(71, 'Can delete user', 18, 'delete_user'),
(72, 'Can view user', 18, 'view_user'),
(73, 'Can add bankaccount', 19, 'add_bankaccount'),
(74, 'Can change bankaccount', 19, 'change_bankaccount'),
(75, 'Can delete bankaccount', 19, 'delete_bankaccount'),
(76, 'Can view bankaccount', 19, 'view_bankaccount'),
(77, 'Can add node1', 20, 'add_node1'),
(78, 'Can change node1', 20, 'change_node1'),
(79, 'Can delete node1', 20, 'delete_node1'),
(80, 'Can view node1', 20, 'view_node1'),
(81, 'Can add node2', 21, 'add_node2'),
(82, 'Can change node2', 21, 'change_node2'),
(83, 'Can delete node2', 21, 'delete_node2'),
(84, 'Can view node2', 21, 'view_node2'),
(85, 'Can add node3', 22, 'add_node3'),
(86, 'Can change node3', 22, 'change_node3'),
(87, 'Can delete node3', 22, 'delete_node3'),
(88, 'Can view node3', 22, 'view_node3'),
(89, 'Can add node4', 23, 'add_node4'),
(90, 'Can change node4', 23, 'change_node4'),
(91, 'Can delete node4', 23, 'delete_node4'),
(92, 'Can view node4', 23, 'view_node4'),
(93, 'Can add requirements', 24, 'add_requirements'),
(94, 'Can change requirements', 24, 'change_requirements'),
(95, 'Can delete requirements', 24, 'delete_requirements'),
(96, 'Can view requirements', 24, 'view_requirements');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bank_bank`
--

CREATE TABLE IF NOT EXISTS `bank_bank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `managerid` int(11) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bank_loan`
--

CREATE TABLE IF NOT EXISTS `bank_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `definition` longtext,
  `needfilename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `bank_loan`
--

INSERT INTO `bank_loan` (`id`, `type`, `definition`, `needfilename`) VALUES
(1, 'BIKE LOAN', 'HAVE TO SETTLE BIKE', 'RC BOOK FO BIKE'),
(2, 'HOME LOAN', 'NEED  HOME DOCUMENT', 'HOME DOCUMENT'),
(4, 'CAR LOAN', 'UPLOAD CAR RC BOOK TO AVAIL LOAN', 'CAR RC');

-- --------------------------------------------------------

--
-- Table structure for table `bank_loanupload`
--

CREATE TABLE IF NOT EXISTS `bank_loanupload` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loantype` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `dob` date NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `document` varchar(100) NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `uploadid` varchar(50) DEFAULT NULL,
  `access` tinyint(1) DEFAULT NULL,
  `key` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bank_scheme`
--

CREATE TABLE IF NOT EXISTS `bank_scheme` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `definition` longtext NOT NULL,
  `documentneeded` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `bank_scheme`
--

INSERT INTO `bank_scheme` (`id`, `name`, `definition`, `documentneeded`) VALUES
(1, 'YOJANA', 'NEED TO SUBMIT PATTA AND CHITTA. ALSO WILL GET RS.10000', 'PATTA AND CHITTA'),
(2, 'PRADAN MANTRI', 'LAND DOCUMENTS ARE NEED TO BE UPLOADED TO GET 25000', 'PATTA AND CHITTA'),
(4, 'PADMAN YOJA', 'NEED TO UPLOAD ABOVE MENTIONED DOCUMENTS TO GET RUPEES 50000', 'PATTA AND CHITTA');

-- --------------------------------------------------------

--
-- Table structure for table `bank_schemeupload`
--

CREATE TABLE IF NOT EXISTS `bank_schemeupload` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `schemename` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `dob` date NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `patta` varchar(100) NOT NULL,
  `chitta` varchar(100) NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `uploadid` varchar(50) DEFAULT NULL,
  `access` tinyint(1) DEFAULT NULL,
  `chittakey` varchar(50) DEFAULT NULL,
  `pattakey` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'admins', 'admin'),
(8, 'admins', 'auditaccess'),
(9, 'admins', 'bankaccess'),
(10, 'admins', 'useraccess'),
(11, 'audit', 'audit'),
(12, 'audit', 'requiredlist'),
(24, 'audit', 'requirements'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(13, 'bank', 'bank'),
(15, 'bank', 'loan'),
(17, 'bank', 'loanupload'),
(14, 'bank', 'scheme'),
(16, 'bank', 'schemeupload'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(19, 'user', 'bankaccount'),
(20, 'user', 'node1'),
(21, 'user', 'node2'),
(22, 'user', 'node3'),
(23, 'user', 'node4'),
(18, 'user', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=69 ;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-02-24 09:04:00.259579'),
(2, 'auth', '0001_initial', '2022-02-24 09:04:08.294109'),
(3, 'admin', '0001_initial', '2022-02-24 09:04:09.992073'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-02-24 09:04:10.016010'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-02-24 09:04:10.075047'),
(6, 'admins', '0001_initial', '2022-02-24 09:04:10.399988'),
(7, 'admins', '0002_auditaccess_bankaccess', '2022-02-24 09:04:11.399927'),
(8, 'admins', '0003_useraccess', '2022-02-24 09:04:11.923898'),
(9, 'admins', '0004_useraccess_userid', '2022-02-24 09:04:12.433869'),
(10, 'audit', '0001_initial', '2022-02-24 09:04:12.874843'),
(11, 'audit', '0002_rename_audit_id_audit_auditer_id', '2022-02-24 09:04:13.050832'),
(12, 'audit', '0003_rename_auditer_id_audit_auditerid', '2022-02-24 09:04:13.150885'),
(13, 'audit', '0004_requiredlist', '2022-02-24 09:04:13.505806'),
(14, 'audit', '0005_alter_requiredlist_userid', '2022-02-24 09:04:21.496401'),
(15, 'audit', '0006_requiredlist_file', '2022-02-24 09:04:22.158345'),
(16, 'audit', '0007_alter_requiredlist_file', '2022-02-24 09:04:22.251294'),
(17, 'audit', '0008_requiredlist_key', '2022-02-24 09:04:22.916253'),
(18, 'contenttypes', '0002_remove_content_type_name', '2022-02-24 09:04:23.999254'),
(19, 'auth', '0002_alter_permission_name_max_length', '2022-02-24 09:04:24.597158'),
(20, 'auth', '0003_alter_user_email_max_length', '2022-02-24 09:04:25.430106'),
(21, 'auth', '0004_alter_user_username_opts', '2022-02-24 09:04:25.462104'),
(22, 'auth', '0005_alter_user_last_login_null', '2022-02-24 09:04:25.948139'),
(23, 'auth', '0006_require_contenttypes_0002', '2022-02-24 09:04:25.978076'),
(24, 'auth', '0007_alter_validators_add_error_messages', '2022-02-24 09:04:26.021073'),
(25, 'auth', '0008_alter_user_username_max_length', '2022-02-24 09:04:26.585102'),
(26, 'auth', '0009_alter_user_last_name_max_length', '2022-02-24 09:04:27.342994'),
(27, 'auth', '0010_alter_group_name_max_length', '2022-02-24 09:04:27.944962'),
(28, 'auth', '0011_update_proxy_permissions', '2022-02-24 09:04:27.983002'),
(29, 'auth', '0012_alter_user_first_name_max_length', '2022-02-24 09:04:28.535925'),
(30, 'bank', '0001_initial', '2022-02-24 09:04:28.976900'),
(31, 'bank', '0002_scheme', '2022-02-24 09:04:29.235885'),
(32, 'bank', '0003_auto_20211025_1855', '2022-02-24 09:04:29.861848'),
(33, 'bank', '0004_schemeupload', '2022-02-24 09:04:30.109834'),
(34, 'bank', '0005_auto_20211026_1506', '2022-02-24 09:04:30.791842'),
(35, 'bank', '0006_loanupload', '2022-02-24 09:04:31.072781'),
(36, 'bank', '0007_auto_20211026_1656', '2022-02-24 09:04:31.839732'),
(37, 'bank', '0008_auto_20211027_1719', '2022-02-24 09:04:32.712694'),
(38, 'bank', '0009_auto_20211029_1542', '2022-02-24 09:04:34.375583'),
(39, 'bank', '0010_auto_20211029_1547', '2022-02-24 09:04:35.476519'),
(40, 'sessions', '0001_initial', '2022-02-24 09:04:36.090484'),
(41, 'user', '0001_initial', '2022-02-24 09:04:36.947496'),
(42, 'user', '0002_rename_designation_user_area', '2022-02-24 09:04:37.040428'),
(43, 'user', '0003_alter_user_name', '2022-02-24 09:04:37.306413'),
(44, 'user', '0004_alter_user_email', '2022-02-24 09:04:37.522400'),
(45, 'user', '0005_user_userid', '2022-02-24 09:04:37.959374'),
(46, 'user', '0006_user_status', '2022-02-24 09:04:38.356396'),
(47, 'user', '0007_bankaccount', '2022-02-24 09:04:38.624335'),
(48, 'user', '0008_bankaccount_userid', '2022-02-24 09:04:39.008313'),
(49, 'user', '0009_node1_node2_node3_node4', '2022-02-24 09:04:39.999255'),
(50, 'bank', '0011_loan_needfilename_alter_loanupload_userid_and_more', '2022-02-24 12:00:41.640370'),
(51, 'audit', '0009_requiredlist_requestid', '2022-02-28 04:59:52.301791'),
(52, 'bank', '0012_alter_loanupload_userid_alter_schemeupload_time', '2022-02-28 04:59:52.322035'),
(53, 'bank', '0013_alter_loanupload_userid_alter_schemeupload_time', '2022-02-28 06:20:48.523720'),
(54, 'audit', '0010_requirements', '2022-02-28 09:57:58.943183'),
(55, 'bank', '0014_alter_loanupload_userid_alter_schemeupload_time', '2022-02-28 09:57:59.021305'),
(56, 'audit', '0011_requiredlist_access', '2022-02-28 12:11:51.971725'),
(57, 'bank', '0015_alter_loanupload_userid_alter_schemeupload_time', '2022-02-28 12:11:52.003533'),
(58, 'audit', '0012_alter_requiredlist_access', '2022-02-28 12:49:03.821284'),
(59, 'bank', '0016_alter_loanupload_userid_alter_schemeupload_time', '2022-02-28 12:49:03.852515'),
(60, 'bank', '0017_loanupload_uploadid_schemeupload_uploadid_and_more', '2022-03-01 06:54:34.919458'),
(61, 'bank', '0018_remove_loanupload_time_remove_schemeupload_time_and_more', '2022-03-01 09:14:40.899395'),
(62, 'bank', '0019_alter_loanupload_userid', '2022-03-01 09:15:02.072150'),
(63, 'bank', '0020_alter_loanupload_userid', '2022-03-01 09:15:02.117147'),
(64, 'bank', '0021_alter_loanupload_userid', '2022-03-01 09:15:28.258617'),
(65, 'bank', '0022_loanupload_access_schemeupload_access', '2022-03-01 09:48:59.622652'),
(66, 'bank', '0023_schemeupload_chittakey_schemeupload_pattakey', '2022-03-01 11:27:42.853795'),
(67, 'bank', '0024_loanupload_key', '2022-03-01 11:29:13.994682'),
(68, 'user', '0010_bankaccount_aadhaarkey_bankaccount_access_and_more', '2022-03-01 12:04:53.258572');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('3z5mrbpa7ty3s0zyvcebddn3zctxng53', 'e30:1nR7iD:iRylAt0fFK3e7qd-3hewI_99F1tsVEHk1EPTECXtwvE', '2022-03-21 07:23:21.636986'),
('vcptgl1i76spq3w275tf9sccru82oz80', 'eyJhdWRpdCI6IkFMUEhBIiwiYWRtaW4iOiJBRE1JTiJ9:1nNELn:bJN_bgjtVvsK940NfuAiQQqLQqGxVoe73TaH_PCJdkk', '2022-03-10 13:40:07.876199'),
('wlb1zrtcg65qma9lgsxfy6b5mg7m15ma', 'e30:1nRtRd:cUC-plHu1ZIUnXqxJC3LEYoQO-wLdaqZ2L5ozf12Cc0', '2022-03-23 10:21:25.751425'),
('wu1ovykk49d3ik39c6smatdyt9gkgf3d', 'eyJ1c2VyIjoiODI3ODMifQ:1nPL9H:QdsXzaR-qY5Xk0Vdgpte3d0uG9S370YlVtr8BWYHFP4', '2022-03-16 09:19:55.085325'),
('xt2fqui7shcpm08yu26e44pw4ilupifh', 'eyJ1c2VyIjoiNDM3MDUiLCJhdWRpdCI6IkFMUEhBIn0:1nOX2K:e5g7dDGIyNTCAnbOm0328V8LuLvDPKLXIxu6zY3zf9U', '2022-03-14 03:49:24.718105');

-- --------------------------------------------------------

--
-- Table structure for table `user_bankaccount`
--

CREATE TABLE IF NOT EXISTS `user_bankaccount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `fathername` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `contact` bigint(20) DEFAULT NULL,
  `address` longtext NOT NULL,
  `aadhaar` varchar(100) NOT NULL,
  `pancard` varchar(100) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `aadhaarkey` varchar(50) DEFAULT NULL,
  `access` tinyint(1) DEFAULT NULL,
  `pancardkey` varchar(50) DEFAULT NULL,
  `photokey` varchar(50) DEFAULT NULL,
  `uploadid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_node1`
--

CREATE TABLE IF NOT EXISTS `user_node1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL,
  `hashvalue` longtext NOT NULL,
  `filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_node2`
--

CREATE TABLE IF NOT EXISTS `user_node2` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL,
  `hashvalue` longtext NOT NULL,
  `filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_node3`
--

CREATE TABLE IF NOT EXISTS `user_node3` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL,
  `hashvalue` longtext NOT NULL,
  `filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_node4`
--

CREATE TABLE IF NOT EXISTS `user_node4` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL,
  `hashvalue` longtext NOT NULL,
  `filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_user`
--

CREATE TABLE IF NOT EXISTS `user_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
