-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2019 at 03:41 PM
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
  `start_time` date NOT NULL,
  `state` tinyint(1) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('753840', '0001'),
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
('pasindusudesh', '170138'),
('pathumpankaja', '753840');

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `deposit_amount` float(10,2) NOT NULL,
  `transaction_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `installement_id` varchar(15) NOT NULL,
  `paied_amount` float(15,2) NOT NULL,
  `date_pavement` date NOT NULL,
  `net_loan_amount` float(15,2) NOT NULL,
  `late_not_late_state` tinyint(1) NOT NULL,
  `loan_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `repayment_period` int(4) NOT NULL,
  `start_date` date NOT NULL,
  `state` tinyint(1) NOT NULL,
  `fd_id` varchar(10) NOT NULL,
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



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
('pasindusudesh', '87654321'),
('pathumpankaja', 'nimesh123');

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
('962142471v', 'Pathum', 'Pankaja,dewapura', 'undefined', '45,second ', 'kandewatta lane', 'galle', '1996-09-25', '+94776533802', 'sithcharith@gmail.com', '753840');

-- --------------------------------------------------------

--
-- Table structure for table `saving_account`
--

CREATE TABLE `saving_account` (
  `account_num` varchar(10) NOT NULL,
  `transaction_count` int(10) NOT NULL,
  `balance` float(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `account_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  ADD KEY `fd_id` (`fd_id`),
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
-- Constraints for table `interest`
--
ALTER TABLE `interest`
  ADD CONSTRAINT `interest_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `saving_account` (`account_num`);

--
-- Constraints for table `interest_rate_has_type`
--
ALTER TABLE `interest_rate_has_type`
  ADD CONSTRAINT `interest_rate_has_type_ibfk_1` FOREIGN KEY (`account_num`) REFERENCES `interest` (`account_num`),
  ADD CONSTRAINT `interest_rate_has_type_ibfk_2` FOREIGN KEY (`account_num`) REFERENCES `account_type` (`account_num`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`fd_id`) REFERENCES `fixed_deposit` (`fd_id`),
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`account_num`) REFERENCES `account` (`account_num`);


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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
