-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2019 at 03:15 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

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
('147712', '0001', 1200000, '2019-12-10', 1, '872118'),
('297092', '0001', 12000, '2019-12-10', 1, '734298'),
('397469', '00123', 307788000, '2019-12-11', 1, '652316'),
('454743', '0001', 32323, '2019-12-10', 1, '328800'),
('799261', '00123', 600111, '2019-12-11', 1, '652316'),
('816020', '00123', 12000000000, '2019-12-11', 1, '652316'),
('829081', '0001', 3412330, '2019-12-08', 1, '652316'),
('909520', '00123', 240004, '2019-12-11', 1, '652316');

-- --------------------------------------------------------

--
-- Table structure for table `account_has_normal_loan`
--

CREATE TABLE `account_has_normal_loan` (
  `account_num` varchar(10) NOT NULL,
  `loan_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `account_type`
--

CREATE TABLE `account_type` (
  `account_num` varchar(10) NOT NULL,
  `type` varchar(10) NOT NULL,
  `interest_rate` varchar(3) NOT NULL,
  `minimum_val` float(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('0001', 'galle', 'main branch', '0912222222', 'gallebazzar@gmail.com', '0012213344'),
('00123', 'galle', 'bazzar', '0912222222', 'gallebazzar@gmail.com', '0012213344');

-- --------------------------------------------------------

--
-- Table structure for table `branch_has_employee`
--

CREATE TABLE `branch_has_employee` (
  `branch_id` varchar(10) NOT NULL,
  `emp_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Table structure for table `customer_has_account`
--

CREATE TABLE `customer_has_account` (
  `customer_id` varchar(10) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('hichchi', '734298'),
('pasindusudesh', '170138'),
('pathum', '652316'),
('pathumpankaja', '753840'),
('ssss', '328800'),
('suhan', '872118');

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `deposit_amount` float(10,2) NOT NULL,
  `transaction_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deposit`
--

INSERT INTO `deposit` (`deposit_amount`, `transaction_id`) VALUES
(1200000.00, '230814'),
(600000.00, '382727'),
(300000.00, '394984'),
(100000000.00, '695449'),
(10000.00, '750333'),
(300000.00, '886362'),
(120000.00, '904527'),
(120000.00, '939893'),
(1200000.00, '972797');

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
  `age` int(3) NOT NULL,
  `contact_num` varchar(300) NOT NULL,
  `nic` varchar(13) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `branch_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `first_name`, `last_name`, `surname`, `street_num`, `city`, `province`, `date_of_birth`, `age`, `contact_num`, `nic`, `state`, `branch_id`) VALUES
('170096L', 'dilan', 'dashintha', 'edirisooriyapatabendige', 'no.07,mihindu mawatha', 'galle', 'southern', '1996-07-04', 0, '0711810983', '961860741V', 1, '00123');

-- --------------------------------------------------------

--
-- Table structure for table `employee_has_history`
--

CREATE TABLE `employee_has_history` (
  `emp_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('dilangayum', '170096L');

-- --------------------------------------------------------

--
-- Table structure for table `fd_plan`
--

CREATE TABLE `fd_plan` (
  `fd_id` varchar(10) NOT NULL,
  `interest_rate` varchar(3) NOT NULL,
  `plan` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fixed_deposit`
--

CREATE TABLE `fixed_deposit` (
  `fd_id` varchar(10) NOT NULL,
  `num_months` int(4) NOT NULL,
  `start_date` date NOT NULL,
  `amount` float(15,2) NOT NULL,
  `net_interest` varchar(3) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fixed_deposit`
--

INSERT INTO `fixed_deposit` (`fd_id`, `num_months`, `start_date`, `amount`, `net_interest`, `account_num`) VALUES
('725299', 6, '2019-12-11', 8.00, '0', '909520');

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
(100.00, 3.00, 1086.00, '2019-12-18', '2019-12-18', 8914.00, 'nlat', '182269'),
(1000.00, 0.00, 0.00, '0000-00-00', '2019-12-19', 120000.00, '', '285519'),
(1000000.00, 300003.00, 6606003.00, '2019-12-18', '2019-12-18', 2993399808.00, 'nlat', '679112');

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

--
-- Dumping data for table `installement_history`
--

INSERT INTO `installement_history` (`installement_id`, `paied_amount`, `paied_date`, `loan_id`) VALUES
('200441', 6000.00, '2019-12-18', '679112'),
('294193', 3.00, '2019-12-18', '182269'),
('296061', 3.00, '2019-12-18', '182269'),
('375168', 6000000.00, '2019-12-18', '679112'),
('449310', 1000.00, '2019-12-18', '182269'),
('461482', 80.00, '2019-12-18', '182269'),
('734641', 300000.00, '2019-12-18', '679112'),
('747109', 300003.00, '2019-12-18', '679112');

-- --------------------------------------------------------

--
-- Table structure for table `interest`
--

CREATE TABLE `interest` (
  `month` varchar(5) NOT NULL,
  `interest_amount` float(5,3) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('182269', 10000.00, 100.00, 10, '2019-12-18', 1, '397469'),
('285519', 120000.00, 1000.00, 12, '2019-12-19', 1, '909520'),
('523845', 120000.00, 0.00, 12, '2019-12-17', 1, '909520'),
('569479', 600000.00, 10000.00, 6, '2019-12-18', 1, '799261'),
('679112', 300000000.00, 1000000.00, 30, '2019-12-18', 1, '397469'),
('716326', 1200000.00, 10000.00, 12, '2019-12-18', 1, '829081');

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
('dilangayum', '12345678'),
('hichchi', '1234'),
('pasindusudesh', '87654321'),
('pathum', '123'),
('pathumpankaja', 'nimesh123'),
('ssss', 'sss'),
('suhan', 'suhan123');

-- --------------------------------------------------------

--
-- Table structure for table `money_tansfer`
--

CREATE TABLE `money_tansfer` (
  `transfer_id` varchar(15) NOT NULL,
  `transfered_acc` varchar(10) NOT NULL,
  `transferring_acc` varchar(10) NOT NULL,
  `transfered_date` date NOT NULL,
  `trnasfered_time` time NOT NULL,
  `amount` float(5,2) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('182269', '397469', 'undefined', 'undefined', 'tution sir', 100000.00),
('569479', '799261', 'undefined', 'undefined', 'teacher', 500000.00),
('716326', '829081', 'undefined', 'undefined', 'doc', 123456.00),
('285519', '909520', 'undefined', 'undefined', 'teacher', 1200000.00),
('523845', '909520', 'undefined', 'undefined', 'asasas', 100000000.00);

-- --------------------------------------------------------

--
-- Table structure for table `normal_staff`
--

CREATE TABLE `normal_staff` (
  `emp_id` varchar(10) NOT NULL,
  `post` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('1212', 'sathuska', 'suhan', 'wewalwala', '43/7', 'upper dickson road', 'galle', '1996-12-02', '+3144232255382', 'sathuska@123', '872118'),
('212121', 'ddd', 'ddd', 'ddd', 'No.07,mihi', 'mampitiya ,wackwella road', 'galle', '2019-12-07', '0711810983', 'sss', '328800'),
('961234741V', 'Pathum', 'Pankaja', 'dewapura', 'no.2', 'molpe junction', 'moratuwa', '1996-12-19', '0775698752', 'kasundewpura96@gmail.com', '652316'),
('962142471v', 'Pathum', 'Pankaja,dewapura', 'undefined', '45,second ', 'kandewatta lane', 'galle', '1996-09-25', '+94776533802', 'sithcharith@gmail.com', '753840'),
('96323214v', 'sachintha', 'kapuge', 'kapu', 'no.09', 'galle main road', 'galle', '1996-12-12', '07723777772', 'leohichchi@gmail.com', '734298');

-- --------------------------------------------------------

--
-- Table structure for table `saving_account`
--

CREATE TABLE `saving_account` (
  `account_num` varchar(10) NOT NULL,
  `transaction_count` int(10) NOT NULL,
  `balance` float(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saving_account`
--

INSERT INTO `saving_account` (`account_num`, `transaction_count`, `balance`) VALUES
('147712', 0, 1200000.00),
('297092', 0, 12000.00),
('397469', 0, 7777777.00),
('454743', 0, 32323.00),
('799261', 0, 111.00),
('829081', 0, 100000.00),
('909520', 0, 12.00);

-- --------------------------------------------------------

--
-- Table structure for table `saving_account_has_interest`
--

CREATE TABLE `saving_account_has_interest` (
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `saving_account_has_type`
--

CREATE TABLE `saving_account_has_type` (
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` varchar(15) NOT NULL,
  `date` date NOT NULL,
  `time_transaction` time NOT NULL,
  `transaction_type` varchar(10) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `date`, `time_transaction`, `transaction_type`, `account_num`) VALUES
('230814', '2019-12-18', '11:39:42', '', '829081'),
('382727', '2019-12-18', '17:13:35', '', '799261'),
('394984', '2019-12-08', '10:56:05', '', '829081'),
('695449', '2019-12-18', '22:46:23', '', '397469'),
('750333', '2019-12-18', '23:03:35', '', '397469'),
('886362', '2019-12-08', '10:54:51', '', '829081'),
('904527', '2019-12-19', '07:42:14', 'loan', '909520'),
('939893', '2019-12-17', '20:13:46', '', '909520'),
('972797', '2019-12-18', '11:50:27', '', '829081');

-- --------------------------------------------------------

--
-- Table structure for table `transfer_money_account_money_transfer`
--

CREATE TABLE `transfer_money_account_money_transfer` (
  `transfer_id` varchar(15) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw`
--

CREATE TABLE `withdraw` (
  `withdraw_amount` float(10,2) NOT NULL,
  `transaction_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Indexes for table `account_has_normal_loan`
--
ALTER TABLE `account_has_normal_loan`
  ADD KEY `account_num` (`account_num`,`loan_id`);

--
-- Indexes for table `account_type`
--
ALTER TABLE `account_type`
  ADD PRIMARY KEY (`account_num`);

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
-- Indexes for table `branch_has_employee`
--
ALTER TABLE `branch_has_employee`
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `emp_id` (`emp_id`);

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
-- Indexes for table `customer_has_account`
--
ALTER TABLE `customer_has_account`
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `account_num` (`account_num`);

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
-- Indexes for table `employee_has_history`
--
ALTER TABLE `employee_has_history`
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `employee_login`
--
ALTER TABLE `employee_login`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `fd_plan`
--
ALTER TABLE `fd_plan`
  ADD PRIMARY KEY (`fd_id`);

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
-- Indexes for table `money_tansfer`
--
ALTER TABLE `money_tansfer`
  ADD PRIMARY KEY (`transfer_id`),
  ADD KEY `account_num` (`account_num`);

--
-- Indexes for table `normal_loan`
--
ALTER TABLE `normal_loan`
  ADD PRIMARY KEY (`account_num`,`loan_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `normal_staff`
--
ALTER TABLE `normal_staff`
  ADD PRIMARY KEY (`emp_id`);

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
-- Indexes for table `saving_account_has_interest`
--
ALTER TABLE `saving_account_has_interest`
  ADD KEY `account_num` (`account_num`);

--
-- Indexes for table `saving_account_has_type`
--
ALTER TABLE `saving_account_has_type`
  ADD KEY `account_num` (`account_num`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `account_num` (`account_num`);

--
-- Indexes for table `transfer_money_account_money_transfer`
--
ALTER TABLE `transfer_money_account_money_transfer`
  ADD KEY `transfer_id` (`transfer_id`),
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
-- Constraints for table `account_has_normal_loan`
--
ALTER TABLE `account_has_normal_loan`
  ADD CONSTRAINT `account_has_normal_loan_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`),
  ADD CONSTRAINT `account_has_normal_loan_ibfk_2` FOREIGN KEY (`account_num`,`loan_id`) REFERENCES `normal_loan` (`account_num`, `loan_id`);

--
-- Constraints for table `account_type`
--
ALTER TABLE `account_type`
  ADD CONSTRAINT `account_type_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `saving_account` (`account_num`);

--
-- Constraints for table `atm_withdraw`
--
ALTER TABLE `atm_withdraw`
  ADD CONSTRAINT `atm_withdraw_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`);

--
-- Constraints for table `branch_has_employee`
--
ALTER TABLE `branch_has_employee`
  ADD CONSTRAINT `branch_has_employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  ADD CONSTRAINT `branch_has_employee_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

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
-- Constraints for table `customer_has_account`
--
ALTER TABLE `customer_has_account`
  ADD CONSTRAINT `customer_has_account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `customer_has_account_ibfk_2` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

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
-- Constraints for table `employee_has_history`
--
ALTER TABLE `employee_has_history`
  ADD CONSTRAINT `employee_has_history_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

--
-- Constraints for table `employee_login`
--
ALTER TABLE `employee_login`
  ADD CONSTRAINT `employee_login_ibfk_1` FOREIGN KEY (`username`) REFERENCES `login` (`username`),
  ADD CONSTRAINT `employee_login_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

--
-- Constraints for table `fd_plan`
--
ALTER TABLE `fd_plan`
  ADD CONSTRAINT `fd_plan_ibfk_1` FOREIGN KEY (`fd_id`) REFERENCES `fixed_deposit` (`fd_id`);

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
-- Constraints for table `money_tansfer`
--
ALTER TABLE `money_tansfer`
  ADD CONSTRAINT `money_tansfer_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

--
-- Constraints for table `normal_loan`
--
ALTER TABLE `normal_loan`
  ADD CONSTRAINT `normal_loan_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`),
  ADD CONSTRAINT `normal_loan_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`);

--
-- Constraints for table `normal_staff`
--
ALTER TABLE `normal_staff`
  ADD CONSTRAINT `normal_staff_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

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
-- Constraints for table `saving_account_has_interest`
--
ALTER TABLE `saving_account_has_interest`
  ADD CONSTRAINT `saving_account_has_interest_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `saving_account` (`account_num`);

--
-- Constraints for table `saving_account_has_type`
--
ALTER TABLE `saving_account_has_type`
  ADD CONSTRAINT `saving_account_has_type_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `saving_account` (`account_num`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

--
-- Constraints for table `transfer_money_account_money_transfer`
--
ALTER TABLE `transfer_money_account_money_transfer`
  ADD CONSTRAINT `transfer_money_account_money_transfer_ibfk_1` FOREIGN KEY (`transfer_id`) REFERENCES `money_tansfer` (`transfer_id`),
  ADD CONSTRAINT `transfer_money_account_money_transfer_ibfk_2` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);

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

DELIMITER ;
COMMIT;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` EVENT `Account_Interest` ON SCHEDULE EVERY 1 MONTH STARTS '2019-01-01 00:05:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
UPDATE interest SET interest_amount = (balance*0.12) , checked_date = CURRENT_DATE WHERE type='saving' and CURRENT_DATE - checked_date = 0 ;
UPDATE interest SET interest_amount = (balance*0.12) checked_date = CURRENT_DATE where type='FD' and num_months='3' and CURRENT_DATE - checked_date = 0;
UPDATE interest SET interest_amount = (balance*0.14) checked_date = CURRENT_DATE where type='FD' and num_months='6' and CURRENT_DATE - checked_date = 0;
UPDATE interest SET interest_amount = (balance*0.16) checked_date = CURRENT_DATE where type='FD' and num_months='12' and CURRENT_DATE - checked_date = 0;
    

END$$

DELIMITER ;
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
