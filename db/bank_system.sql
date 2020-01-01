-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2019 at 01:15 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bank_system`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `lateloanreport` ()  MODIFIES SQL DATA
BEGIN
DROP VIEW IF EXISTS lateloanreport;
CREATE VIEW lateloanreport AS SELECT account.customer_id,account.branch_id, installement.loan_id ,loan.account_num FROM account, loan,installement where installement.late_not_late_state = 'nlat' AND loan.loan_id = installement.loan_id   AND account.account_num = loan.account_num;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `account_num` varchar(20) NOT NULL,
  `branch_id` varchar(10) NOT NULL,
  `balance` float NOT NULL,
  `start_time` date NOT NULL,
  `state` tinyint(1) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`account_num`, `branch_id`, `balance`, `start_time`, `state`, `customer_id`) VALUES
('80123', '00001', 5722, '2019-12-03', 0, '777777'),
('80234', '0001', 8397.62, '2019-12-09', 0, '666666'),
('80345', '00002', 1433.62, '2019-12-17', 1, '555555'),
('80456', '00002', 1000, '2019-12-03', 1, '888888'),
('80567', '00001', 624.62, '2019-12-17', 1, '777777'),
('80678', '00002', 1100, '2019-12-24', 1, '777777');

-- --------------------------------------------------------

--
-- Table structure for table `account_type`
--

CREATE TABLE `account_type` (
  `type_id` int(1) NOT NULL,
  `type` varchar(15) NOT NULL,
  `interest_rate` int(2) NOT NULL,
  `minimum_val` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account_type`
--

INSERT INTO `account_type` (`type_id`, `type`, `interest_rate`, `minimum_val`) VALUES
(1, 'Children', 12, 0),
(2, 'Teen', 10, 500),
(3, 'Adult(18+)', 10, 1000),
(4, 'Senior(60+', 13, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `atm_withdraw`
--

CREATE TABLE `atm_withdraw` (
  `atm_id` varchar(15) NOT NULL,
  `amount` float(5,2) NOT NULL,
  `transaction_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` varchar(10) NOT NULL,
  `region` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `telephone_num` varchar(13) NOT NULL,
  `email_address` varchar(150) NOT NULL,
  `fax_num` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `region`, `name`, `telephone_num`, `email_address`, `fax_num`) VALUES
('00001', 'GALLE', 'GALLE-BAZZAR', '0912546986', 'gallebazzar@ebank.com', '1235975468'),
('00002', 'GALLE', 'GALLE-CITY', '0917845365', 'gallecity@ebank.com', '4598756243'),
('00003', 'Colombo', 'MAIN-BRANCH', '0112255689', 'main@ebank.com', '0112244586'),
('00004', 'Colombo', 'COLOMBO-CITY', '0112244568', 'colombocity@ebank.com', '0112244568'),
('0001', 'galle', 'main branch', '0912222222', 'gallebazzar@gmail.com', '0012213344'),
('00123', 'galle', 'bazzar', '0912222222', 'gallebazzar@gmail.com', '0012213344');

-- --------------------------------------------------------

--
-- Table structure for table `branch_manager`
--

CREATE TABLE `branch_manager` (
  `emp_id` varchar(10) NOT NULL,
  `post` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `current_account`
--

CREATE TABLE `current_account` (
  `account_num` varchar(10) NOT NULL,
  `balance` float(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `current_account`
--

INSERT INTO `current_account` (`account_num`, `balance`) VALUES
('80123', 5722.00),
('80456', 1000.00),
('80678', 1100.00);

--
-- Triggers `current_account`
--
DELIMITER $$
CREATE TRIGGER `bals` AFTER UPDATE ON `current_account` FOR EACH ROW UPDATE account SET balance = new.balance WHERE account_num = new.account_num
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` varchar(10) NOT NULL,
  `branch_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `branch_id`) VALUES
('555555', '00001'),
('666666', '00001'),
('777777', '00002'),
('888888', '00002'),
('328800', '0001'),
('652316', '0001'),
('696716', '0001'),
('734298', '0001'),
('753840', '0001'),
('872118', '0001'),
('926346', '0001'),
('988442', '0001'),
('170138', '00123');

-- --------------------------------------------------------

--
-- Table structure for table `customer_login`
--

CREATE TABLE `customer_login` (
  `username` varchar(150) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_login`
--

INSERT INTO `customer_login` (`username`, `customer_id`) VALUES
('abccompany', '666666'),
('hichchi', '734298'),
('nimash', '777777'),
('pasindusudesh', '170138'),
('pathum', '652316'),
('pathumpankaja', '753840'),
('ssss', '328800'),
('suhan', '872118'),
('thamesh', '555555'),
('xyzcompany', '888888');

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `deposit_amount` float(10,2) NOT NULL,
  `transaction_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deposit`
--

INSERT INTO `deposit` (`deposit_amount`, `transaction_id`) VALUES
(100.00, '20191229222230271'),
(100.00, '201912311127270'),
(25000.00, '213307');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` varchar(10) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `street_num` varchar(50) NOT NULL,
  `city` varchar(100) NOT NULL,
  `province` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `contact_num` varchar(300) NOT NULL,
  `nic` varchar(13) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `branch_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `first_name`, `last_name`, `surname`, `street_num`, `city`, `province`, `date_of_birth`, `contact_num`, `nic`, `state`, `branch_id`) VALUES
('101234', 'Dilan', 'Gayum', 'Dashintha', 'No.12', 'Galle', 'Southern', '1996-08-14', '0762211453', '971254562V', 1, '00001'),
('102345', 'Pasindu', 'Sudesh', 'Dilshan', 'No.19', 'Pilana', 'Southern', '1997-12-15', '0766688725', '9715542586V', 1, '00004'),
('103456', 'Hasini', 'Rangana', 'Weerasooriya', 'No.12', 'Galle', 'Southern', '1996-12-10', '0768899546', '964558456V', 1, '00002'),
('104567', 'Nuwanthika', 'Weihenage', '-', 'No.12', 'GAlle', 'Southern', '1996-09-19', '0765566895', '967885456V', 1, '00002'),
('170096L', 'dilan', 'dashintha', 'edirisooriyapatabendige', 'no.07,mihindu mawatha', 'galle', 'southern', '1996-07-04', '0711810983', '961860741V', 1, '00123'),
('789456', 'Kamal', 'Perera', 'Vithana', 'No.1', 'Pilana', 'Southern', '1990-02-17', '0725698542', '9012245875V', 1, '00001');

-- --------------------------------------------------------

--
-- Table structure for table `employee_login`
--

CREATE TABLE `employee_login` (
  `username` varchar(150) NOT NULL,
  `emp_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_login`
--

INSERT INTO `employee_login` (`username`, `emp_id`) VALUES
('dilan', '101234'),
('dilangayum', '170096L'),
('hasini', '103456'),
('kamalperera', '789456'),
('nuwanthika', '104567'),
('pasindu', '102345');

-- --------------------------------------------------------

--
-- Stand-in structure for view `emp_branch`
-- (See below for the actual view)
--
CREATE TABLE `emp_branch` (
`username` varchar(150)
,`branch_name` varchar(50)
,`branch_id` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `fd_plan`
--

CREATE TABLE `fd_plan` (
  `num_months` int(2) NOT NULL,
  `rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fd_plan`
--

INSERT INTO `fd_plan` (`num_months`, `rate`) VALUES
(6, 13),
(12, 14),
(36, 15);

-- --------------------------------------------------------

--
-- Table structure for table `fixed_deposit`
--

CREATE TABLE `fixed_deposit` (
  `fd_id` varchar(10) NOT NULL,
  `num_months` int(4) NOT NULL,
  `start_date` date NOT NULL,
  `amount` float(15,2) NOT NULL,
  `net_interest` float(5,3) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fixed_deposit`
--

INSERT INTO `fixed_deposit` (`fd_id`, `num_months`, `start_date`, `amount`, `net_interest`, `account_num`) VALUES
('1111', 3, '2019-12-31', 200000.00, 12.000, '80567'),
('2222', 6, '2019-12-31', 500000.00, 12.000, '80234'),
('3333', 12, '2019-12-31', 800000.00, 12.000, '80234');

-- --------------------------------------------------------

--
-- Table structure for table `fixed_deposit_has_loan`
--

CREATE TABLE `fixed_deposit_has_loan` (
  `fd_id` varchar(10) NOT NULL,
  `maximum_amount` float(15,2) NOT NULL,
  `loan_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `start_day` date NOT NULL,
  `last_day` date NOT NULL,
  `working_month` varchar(5) NOT NULL,
  `post` varchar(50) NOT NULL,
  `branch_id` varchar(10) NOT NULL,
  `emp_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `installement`
--

CREATE TABLE `installement` (
  `installement_amount` float(15,2) NOT NULL,
  `monthly_pavement` float(15,2) NOT NULL,
  `paied_amount` float(15,2) NOT NULL,
  `date_pavement` date NOT NULL,
  `checked_date` date NOT NULL,
  `net_loan_amount` float(15,2) NOT NULL,
  `late_not_late_state` varchar(4) NOT NULL,
  `loan_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `installement`
--

INSERT INTO `installement` (`installement_amount`, `monthly_pavement`, `paied_amount`, `date_pavement`, `checked_date`, `net_loan_amount`, `late_not_late_state`, `loan_id`) VALUES
(192.31, 0.00, 0.00, '0000-00-00', '2019-12-29', 25000.00, '', '175838');

-- --------------------------------------------------------

--
-- Table structure for table `installement_history`
--

CREATE TABLE `installement_history` (
  `installement_id` varchar(10) NOT NULL,
  `paied_amount` float(15,2) NOT NULL,
  `paied_date` date NOT NULL,
  `loan_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `interest`
--

CREATE TABLE `interest` (
  `Date` date NOT NULL,
  `interest_amount` float(5,3) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interest`
--

INSERT INTO `interest` (`Date`, `interest_amount`, `account_num`) VALUES
('2019-12-31', 99.999, '80234'),
('2019-12-31', 99.999, '80345');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_id` varchar(10) NOT NULL,
  `loan_amount` float(15,2) NOT NULL,
  `installement_amount` float(15,2) NOT NULL,
  `repayment_period` int(6) NOT NULL,
  `start_date` date NOT NULL,
  `state` tinyint(1) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_id`, `loan_amount`, `installement_amount`, `repayment_period`, `start_date`, `state`, `account_num`) VALUES
('175838', 25000.00, 192.31, 13, '2019-12-29', 1, '80234');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `username` varchar(100) NOT NULL,
  `psw` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`username`, `psw`) VALUES
('abccompany', 'abc@123'),
('dilan', 'dilan123'),
('dilangayum', '12345678'),
('hasini', 'hasini123'),
('hichchi', '1234'),
('kamalperera', 'kamal123'),
('nimash', 'nimesh@123'),
('nuwanthika', 'nuwanthika123'),
('pasindu', 'pasindu123'),
('pasindusudesh', '87654321'),
('pathum', '123'),
('pathumpankaja', 'nimesh123'),
('ssss', 'sss'),
('suhan', 'suhan123'),
('thamesh', 'thamesh@123'),
('xyzcompany', 'xyz@123');

-- --------------------------------------------------------

--
-- Table structure for table `money_transfer`
--

CREATE TABLE `money_transfer` (
  `transfer_id` varchar(20) NOT NULL,
  `transfered_acc` varchar(10) NOT NULL,
  `transfering_acc` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `amount` float(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `money_transfer`
--

INSERT INTO `money_transfer` (`transfer_id`, `transfered_acc`, `transfering_acc`, `date`, `time`, `amount`) VALUES
('6617648393009233920', '80678', '80567', '0000-00-00', '11:02:06', 100.00);

-- --------------------------------------------------------

--
-- Table structure for table `normal_loan`
--

CREATE TABLE `normal_loan` (
  `loan_id` varchar(10) NOT NULL,
  `account_num` varchar(10) NOT NULL,
  `emp_sector` varchar(30) NOT NULL,
  `emp_type` varchar(30) NOT NULL,
  `profession` varchar(50) NOT NULL,
  `total_salary` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `normal_loan`
--

INSERT INTO `normal_loan` (`loan_id`, `account_num`, `emp_sector`, `emp_type`, `profession`, `total_salary`) VALUES
('175838', '80234', 'undefined', 'undefined', 'e3', 250.00);

-- --------------------------------------------------------

--
-- Table structure for table `online_loan_system`
--

CREATE TABLE `online_loan_system` (
  `loan_id` varchar(10) NOT NULL,
  `fd_id` varchar(10) NOT NULL,
  `maximum_amount` float(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `online_transaction`
--

CREATE TABLE `online_transaction` (
  `transaction_id` varchar(15) NOT NULL,
  `amount` float(5,2) NOT NULL,
  `account` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `reg_num` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `start_date` date DEFAULT NULL,
  `street_num` varchar(100) NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `contact_num` varchar(300) NOT NULL,
  `email_address` varchar(150) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`reg_num`, `name`, `start_date`, `street_num`, `street`, `city`, `contact_num`, `email_address`, `customer_id`) VALUES
('4587593J1', 'Xyz Company', '2010-12-11', '5', 'Piliyandala Road', 'Piliyandala', '0115566986', 'xyz@gmil.com', '888888'),
('5864587U', 'Abc Company', '2012-12-10', 'No 2', 'Gonamulla Road', 'Gonamulla', '0915486581', 'abc@gmail.com', '666666');

-- --------------------------------------------------------

--
-- Stand-in structure for view `organization_details`
-- (See below for the actual view)
--
CREATE TABLE `organization_details` (
`reg_num` varchar(10)
,`name` varchar(50)
,`account_num` varchar(20)
,`balance` float
,`customer_id` varchar(10)
,`state` tinyint(1)
,`branch_regon` varchar(50)
,`branch_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `nic` varchar(13) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `surname` varchar(150) NOT NULL,
  `street_num` varchar(10) NOT NULL,
  `street` varchar(200) NOT NULL,
  `city` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `contact_num` varchar(300) NOT NULL,
  `email_address` varchar(150) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`nic`, `first_name`, `last_name`, `surname`, `street_num`, `street`, `city`, `dob`, `contact_num`, `email_address`, `customer_id`) VALUES
('961234741V', 'Pathum', 'Pankaja', 'dewapura', 'no.2', 'molpe junction', 'moratuwa', '1996-12-19', '0775698752', 'kasundewpura96@gmail.com', '652316'),
('962142471v', 'Pathum', 'Pankaja,dewapura', 'undefined', '45,second ', 'kandewatta lane', 'galle', '1996-09-25', '+94776533802', 'sithcharith@gmail.com', '753840'),
('967445842V', 'Charitha', 'Nimesh', 'Jayakodi', 'No.2', 'Piyadigama', 'Mahamodara', '1996-12-17', '0768855426', 'nimash@gmail.com', '777777'),
('974558462V', 'Thamesh', 'Deshan', 'Arachchige', 'No.01', 'Pasal Mavatha', 'Dehiattakandiya', '1996-07-17', '0768542958', 'thamesh@gmail.com', '555555');

-- --------------------------------------------------------

--
-- Stand-in structure for view `person_details`
-- (See below for the actual view)
--
CREATE TABLE `person_details` (
`nic` varchar(13)
,`first_name` varchar(100)
,`last_name` varchar(100)
,`account_num` varchar(20)
,`balance` float
,`customer_id` varchar(10)
,`state` tinyint(1)
,`branch_regon` varchar(50)
,`branch_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `saving_account`
--

CREATE TABLE `saving_account` (
  `account_num` varchar(10) NOT NULL,
  `transaction_count` int(10) NOT NULL,
  `balance` float(15,2) NOT NULL,
  `type_id` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saving_account`
--

INSERT INTO `saving_account` (`account_num`, `transaction_count`, `balance`, `type_id`) VALUES
('80234', 5, 8397.62, 1),
('80345', 2, 1433.62, 2),
('80567', 3, 624.62, 3);

--
-- Triggers `saving_account`
--
DELIMITER $$
CREATE TRIGGER `add` AFTER INSERT ON `saving_account` FOR EACH ROW UPDATE account
    SET balance = new.balance
    WHERE account_num = new.account_num
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `balance_update` AFTER UPDATE ON `saving_account` FOR EACH ROW UPDATE account SET balance = new.balance WHERE account_num = new.account_num
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `time_transaction` time NOT NULL,
  `transaction_type` varchar(30) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `date`, `time_transaction`, `transaction_type`, `account_num`) VALUES
('20191229222230271', '2019-11-29', '22:22:30', 'MONEY-DEPOSIT', '80123'),
('201912311126886', '2019-12-31', '11:02:06', 'ONLINE-MONEY-TRANSFER', '80567'),
('201912311127270', '0000-00-00', '11:02:07', 'ONLINE-MONEY-RECEIVE', '80678'),
('213307', '2019-12-29', '22:44:04', 'loan', '80234');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw`
--

CREATE TABLE `withdraw` (
  `withdraw_amount` float(10,2) NOT NULL,
  `transaction_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `withdraw`
--

INSERT INTO `withdraw` (`withdraw_amount`, `transaction_id`) VALUES
(100.00, '201912311126886');

-- --------------------------------------------------------

--
-- Structure for view `emp_branch`
--
DROP TABLE IF EXISTS `emp_branch`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `emp_branch`  AS  select `employee_login`.`username` AS `username`,`branch`.`name` AS `branch_name`,`branch`.`branch_id` AS `branch_id` from ((`employee_login` join `employee` on(`employee_login`.`emp_id` = `employee`.`emp_id`)) join `branch` on(`employee`.`branch_id` = `branch`.`branch_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `organization_details`
--
DROP TABLE IF EXISTS `organization_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `organization_details`  AS  select `organization`.`reg_num` AS `reg_num`,`organization`.`name` AS `name`,`account`.`account_num` AS `account_num`,`account`.`balance` AS `balance`,`account`.`customer_id` AS `customer_id`,`account`.`state` AS `state`,`branch`.`region` AS `branch_regon`,`branch`.`name` AS `branch_name` from ((`organization` join `account`) join `branch`) where `organization`.`customer_id` = `account`.`customer_id` and `account`.`branch_id` = `branch`.`branch_id` ;

-- --------------------------------------------------------

--
-- Structure for view `person_details`
--
DROP TABLE IF EXISTS `person_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `person_details`  AS  select `person`.`nic` AS `nic`,`person`.`first_name` AS `first_name`,`person`.`last_name` AS `last_name`,`account`.`account_num` AS `account_num`,`account`.`balance` AS `balance`,`account`.`customer_id` AS `customer_id`,`account`.`state` AS `state`,`branch`.`region` AS `branch_regon`,`branch`.`name` AS `branch_name` from ((`person` join `account`) join `branch`) where `person`.`customer_id` = `account`.`customer_id` and `account`.`branch_id` = `branch`.`branch_id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_num`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `atm_withdraw`
--
ALTER TABLE `atm_withdraw`
  ADD PRIMARY KEY (`transaction_id`,`atm_id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `branch_manager`
--
ALTER TABLE `branch_manager`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `current_account`
--
ALTER TABLE `current_account`
  ADD PRIMARY KEY (`account_num`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `customer_login`
--
ALTER TABLE `customer_login`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `deposit`
--
ALTER TABLE `deposit`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `employee_login`
--
ALTER TABLE `employee_login`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `fixed_deposit`
--
ALTER TABLE `fixed_deposit`
  ADD PRIMARY KEY (`fd_id`),
  ADD KEY `account_num` (`account_num`);

--
-- Indexes for table `fixed_deposit_has_loan`
--
ALTER TABLE `fixed_deposit_has_loan`
  ADD KEY `fd_id` (`fd_id`),
  ADD KEY `loan_id` (`loan_id`,`maximum_amount`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `installement`
--
ALTER TABLE `installement`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `installement_history`
--
ALTER TABLE `installement_history`
  ADD PRIMARY KEY (`installement_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `interest`
--
ALTER TABLE `interest`
  ADD PRIMARY KEY (`account_num`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `account_num` (`account_num`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `money_transfer`
--
ALTER TABLE `money_transfer`
  ADD PRIMARY KEY (`transfer_id`);

--
-- Indexes for table `normal_loan`
--
ALTER TABLE `normal_loan`
  ADD PRIMARY KEY (`account_num`,`loan_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `online_loan_system`
--
ALTER TABLE `online_loan_system`
  ADD PRIMARY KEY (`loan_id`,`maximum_amount`),
  ADD KEY `fd_id` (`fd_id`);

--
-- Indexes for table `online_transaction`
--
ALTER TABLE `online_transaction`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`reg_num`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`nic`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `saving_account`
--
ALTER TABLE `saving_account`
  ADD PRIMARY KEY (`account_num`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `account_num` (`account_num`);

--
-- Indexes for table `withdraw`
--
ALTER TABLE `withdraw`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `account_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `customer` (`branch_id`);

--
-- Constraints for table `atm_withdraw`
--
ALTER TABLE `atm_withdraw`
  ADD CONSTRAINT `atm_withdraw_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`);

--
-- Constraints for table `branch_manager`
--
ALTER TABLE `branch_manager`
  ADD CONSTRAINT `branch_manager_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

--
-- Constraints for table `current_account`
--
ALTER TABLE `current_account`
  ADD CONSTRAINT `current_account_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`);

--
-- Constraints for table `customer_login`
--
ALTER TABLE `customer_login`
  ADD CONSTRAINT `customer_login_ibfk_1` FOREIGN KEY (`username`) REFERENCES `login` (`username`),
  ADD CONSTRAINT `customer_login_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `deposit`
--
ALTER TABLE `deposit`
  ADD CONSTRAINT `deposit_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`);

--
-- Constraints for table `employee_login`
--
ALTER TABLE `employee_login`
  ADD CONSTRAINT `employee_login_ibfk_1` FOREIGN KEY (`username`) REFERENCES `login` (`username`),
  ADD CONSTRAINT `employee_login_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

--
-- Constraints for table `fixed_deposit`
--
ALTER TABLE `fixed_deposit`
  ADD CONSTRAINT `fixed_deposit_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `saving_account` (`account_num`);

--
-- Constraints for table `fixed_deposit_has_loan`
--
ALTER TABLE `fixed_deposit_has_loan`
  ADD CONSTRAINT `fixed_deposit_has_loan_ibfk_1` FOREIGN KEY (`fd_id`) REFERENCES `fixed_deposit` (`fd_id`),
  ADD CONSTRAINT `fixed_deposit_has_loan_ibfk_2` FOREIGN KEY (`loan_id`,`maximum_amount`) REFERENCES `online_loan_system` (`loan_id`, `maximum_amount`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`),
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `employee` (`branch_id`);

--
-- Constraints for table `installement`
--
ALTER TABLE `installement`
  ADD CONSTRAINT `installement_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`);

--
-- Constraints for table `installement_history`
--
ALTER TABLE `installement_history`
  ADD CONSTRAINT `installement_history_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `installement` (`loan_id`);

--
-- Constraints for table `interest`
--
ALTER TABLE `interest`
  ADD CONSTRAINT `interest_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `saving_account` (`account_num`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

--
-- Constraints for table `normal_loan`
--
ALTER TABLE `normal_loan`
  ADD CONSTRAINT `normal_loan_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`),
  ADD CONSTRAINT `normal_loan_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`);

--
-- Constraints for table `online_loan_system`
--
ALTER TABLE `online_loan_system`
  ADD CONSTRAINT `online_loan_system_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`),
  ADD CONSTRAINT `online_loan_system_ibfk_2` FOREIGN KEY (`fd_id`) REFERENCES `fixed_deposit` (`fd_id`);

--
-- Constraints for table `online_transaction`
--
ALTER TABLE `online_transaction`
  ADD CONSTRAINT `online_transaction_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`);

--
-- Constraints for table `organization`
--
ALTER TABLE `organization`
  ADD CONSTRAINT `organization_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `person_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `saving_account`
--
ALTER TABLE `saving_account`
  ADD CONSTRAINT `saving_account_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

--
-- Constraints for table `withdraw`
--
ALTER TABLE `withdraw`
  ADD CONSTRAINT `withdraw_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `loan_Installement` ON SCHEDULE EVERY 1 DAY STARTS '2019-01-01 23:05:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
UPDATE installement SET  late_not_late_state = 'late'  , checked_date = CURRENT_DATE  WHERE  (date_pavement - checked_date <0 OR paied_amount - installement_amount <0 ) AND  CURRENT_DATE - checked_date =0 ; 
UPDATE installement SET  late_not_late_state = 'nlate'  , checked_date = CURRENT_DATE  WHERE  date_pavement - checked_date >= 0 AND paied_amount - installement_amount >= 0 AND  CURRENT_DATE - checked_date =0 ; 

END$$

CREATE DEFINER=`root`@`localhost` EVENT `Account_Interest` ON SCHEDULE EVERY 1 DAY STARTS '2019-12-01 00:01:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
UPDATE interest,saving_account,account_type SET interest.interest_amount = (saving_account.balance*0.12), saving_account.balance = saving_account.balance + interest.interest_amount, interest.Date = CURRENT_DATE WHERE account_type.type='Children' and CURRENT_DATE - interest.Date = 30;

UPDATE interest,saving_account,account_type SET interest.interest_amount = (saving_account.balance*0.10), saving_account.balance = saving_account.balance + interest.interest_amount, interest.Date = CURRENT_DATE WHERE account_type.type='Adult(18+)' and CURRENT_DATE - interest.Date = 30;

UPDATE interest,saving_account,account_type SET interest.interest_amount = (saving_account.balance*0.10), saving_account.balance = saving_account.balance + interest.interest_amount, interest.Date = CURRENT_DATE WHERE account_type.type='Teen' and CURRENT_DATE - interest.Date = 30;

UPDATE interest,saving_account,account_type SET interest.interest_amount = (saving_account.balance*0.13), saving_account.balance = saving_account.balance + interest.interest_amount, interest.Date = CURRENT_DATE WHERE account_type.type='Senior(60+' and CURRENT_DATE - interest.Date = 30;

END$$

CREATE DEFINER=`root`@`localhost` EVENT `Account_Interest(FD - 3 Months)` ON SCHEDULE EVERY 1 DAY STARTS '2019-12-01 00:01:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
UPDATE fixed_deposit SET net_interest = (amount*0.12), amount = amount + net_interest, start_date = CURRENT_DATE WHERE num_months = 3 and CURRENT_DATE - start_date = 90 ;
END$$

CREATE DEFINER=`root`@`localhost` EVENT `Account_Interest(FD - 6 Months)` ON SCHEDULE EVERY 1 DAY STARTS '2019-12-01 00:01:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
UPDATE fixed_deposit SET net_interest = (amount*0.16), amount = amount + net_interest, start_date = CURRENT_DATE WHERE num_months = 6 and CURRENT_DATE - start_date = 180 ;
END$$

CREATE DEFINER=`root`@`localhost` EVENT `Account_Interest(FD - 12 Months)` ON SCHEDULE EVERY 1 DAY STARTS '2019-12-01 00:01:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
UPDATE fixed_deposit SET net_interest = (amount*0.18), amount = amount + net_interest, start_date = CURRENT_DATE WHERE num_months = 12 and CURRENT_DATE - start_date = 360 ;
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
