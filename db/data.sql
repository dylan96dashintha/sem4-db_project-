

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`account_num`, `branch_id`, `balance`, `start_time`, `state`, `customer_id`) VALUES
('80123', '00001', 25622, '2019-12-03', 1, '777777'),
('80234', '00001', 7973, '2019-12-09', 1, '666666'),
('80345', '00002', 1009, '2019-12-17', 1, '555555'),
('80456', '00002', 1000, '2019-12-03', 1, '888888'),
('80567', '00001', 300, '2019-12-17', 1, '777777'),
('80678', '00002', 1000, '2019-12-24', 1, '777777');

-- --------------------------------------------------------

--
-- Table structure for table `account_has_normal_loan`
--


-- --------------------------------------------------------

--
-- Table structure for table `account_type`
--

CREATE TABLE `account_type` (
  `type_id` int(1) NOT NULL,
  `type` varchar(10) NOT NULL,
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
-- Table structure for table `branch_has_employee`
--

--
-- Table structure for table `branch_manager`
--


-- --------------------------------------------------------

--
-- Table structure for table `current_account`
--

\
--
-- Dumping data for table `current_account`
--

INSERT INTO `current_account` (`account_num`, `balance`) VALUES
('80123', 5622.00),
('80456', 1000.00),
('80678', 1000.00);

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
-- Table structure for table `customer_has_account`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer_login`
--


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


-- --------------------------------------------------------

--
-- Table structure for table `employee`
--


--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `first_name`, `last_name`, `surname`, `street_num`, `city`, `province`, `date_of_birth`, `age`, `contact_num`, `nic`, `state`, `branch_id`) VALUES
('101234', 'Dilan', 'Gayum', 'Dashintha', 'No.12', 'Galle', 'Southern', '1996-08-14', 23, '0762211453', '971254562V', 1, '00001'),
('102345', 'Pasindu', 'Sudesh', 'Dilshan', 'No.19', 'Pilana', 'Southern', '1997-12-15', 22, '0766688725', '9715542586V', 1, '0001'),
('103456', 'Hasini', 'Rangana', 'Weerasooriya', 'No.12', 'Galle', 'Southern', '1996-12-10', 23, '0768899546', '964558456V', 1, '00002'),
('104567', 'Nuwanthika', 'Weihenage', '-', 'No.12', 'GAlle', 'Southern', '1996-09-19', 23, '0765566895', '967885456V', 1, '00002'),
('170096L', 'dilan', 'dashintha', 'edirisooriyapatabendige', 'no.07,mihindu mawatha', 'galle', 'southern', '1996-07-04', 0, '0711810983', '961860741V', 1, '00123'),
('789456', 'Kamal', 'Perera', 'Vithana', 'No.1', 'Pilana', 'Southern', '1990-02-17', 32, '0725698542', '9012245875V', 1, '00001');

-- --------------------------------------------------------

--
-- Table structure for table `employee_has_history`
--

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
DROP TABLE `fd_plan`;

CREATE TABLE `fd_plan` (
  `plan_id` int(1) NOT NULL,
  `plan` varchar(15) NOT NULL,
  `rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fd_plan`
--

INSERT INTO `fd_plan` (`plan_id`, `plan`, `rate`) VALUES
(1, '6 MONTHS', 13),
(2, '1 YEAR', 14),
(2, '3 YEARS', 15);

-- --------------------------------------------------------

--
-- Table structure for table `fixed_deposit`
--
DROP TABLE `fixed_deposit`;

CREATE TABLE `fixed_deposit` (
  `fd_id` varchar(10) NOT NULL,
  `num_months` int(4) NOT NULL,
  `start_date` date NOT NULL,
  `amount` float(15,2) NOT NULL,
  `net_interest` varchar(3) NOT NULL,
  `account_num` varchar(10) NOT NULL,
  `plan_id` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fixed_deposit_has_loan`
--


-- --------------------------------------------------------

--
-- Table structure for table `history`
--

-- --------------------------------------------------------

--
-- Table structure for table `installement`
--

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

--

INSERT INTO `organization` (`reg_num`, `name`, `start_date`, `street_num`, `street`, `city`, `contact_num`, `email_address`, `customer_id`) VALUES
('4587593J1', 'Xyz Company', '2010-12-11', '5', 'Piliyandala Road', 'Piliyandala', '0115566986', 'xyz@gmil.com', '888888'),
('5864587U', 'Abc Company', '2012-12-10', 'No 2', 'Gonamulla Road', 'Gonamulla', '0915486581', 'abc@gmail.com', '666666');

-- --------------------------------------------------------

--
-- Stand-in structure for view `organization_details`
-- (See below for the actual view)
--
\--

INSERT INTO `person` (`nic`, `first_name`, `last_name`, `surname`, `street_num`, `street`, `city`, `dob`, `contact_num`, `email_address`, `customer_id`) VALUES
('961234741V', 'Pathum', 'Pankaja', 'dewapura', 'no.2', 'molpe junction', 'moratuwa', '1996-12-19', '0775698752', 'kasundewpura96@gmail.com', '652316'),
('962142471v', 'Pathum', 'Pankaja,dewapura', 'undefined', '45,second ', 'kandewatta lane', 'galle', '1996-09-25', '+94776533802', 'sithcharith@gmail.com', '753840'),
('967445842V', 'Charitha', 'Nimesh', 'Jayakodi', 'No.2', 'Piyadigama', 'Mahamodara', '1996-12-17', '0768855426', 'nimash@gmail.com', '777777'),
('974558462V', 'Thamesh', 'Deshan', 'Arachchige', 'No.01', 'Pasal Mavatha', 'Dehiattakandiya', '1996-07-17', '0768542958', 'thamesh@gmail.com', '555555');

-- --------------------------------------------------------

--
-- Stand-in structure for view `person_details`
-- (See below for the actual view)

DROP TABLE `saving_account`;

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
('80234', 5, 7973.00, 0),
('80345', 2, 1009.00, 0),
('80567', 2, 300.00, 0)



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
-- Table structure for table `saving_account_has_interest`
--
--
DROP TABLE IF EXISTS `emp_branch`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `emp_branch`  AS  select `employee_login`.`username` AS `username`,`branch`.`name` AS `branch_name`,`branch`.`branch_id` AS `branch_id` from ((`employee_login` join `employee` on((`employee_login`.`emp_id` = `employee`.`emp_id`))) join `branch` on((`employee`.`branch_id` = `branch`.`branch_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `organization_details`
--
DROP TABLE IF EXISTS `organization_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `organization_details`  AS  select `organization`.`reg_num` AS `reg_num`,`organization`.`name` AS `name`,`account`.`account_num` AS `account_num`,`account`.`balance` AS `balance`,`account`.`customer_id` AS `customer_id`,`account`.`state` AS `state`,`branch`.`region` AS `branch_regon`,`branch`.`name` AS `branch_name` from ((`organization` join `account`) join `branch`) where ((`organization`.`customer_id` = `account`.`customer_id`) and (`account`.`branch_id` = `branch`.`branch_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `person_details`
--
DROP TABLE IF EXISTS `person_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `person_details`  AS  select `person`.`nic` AS `nic`,`person`.`first_name` AS `first_name`,`person`.`last_name` AS `last_name`,`account`.`account_num` AS `account_num`,`account`.`balance` AS `balance`,`account`.`customer_id` AS `customer_id`,`account`.`state` AS `state`,`branch`.`region` AS `branch_regon`,`branch`.`name` AS `branch_name` from ((`person` join `account`) join `branch`) where ((`person`.`customer_id` = `account`.`customer_id`) and (`account`.`branch_id` = `branch`.`branch_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
