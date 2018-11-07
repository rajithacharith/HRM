-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2018 at 04:29 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `edbms`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Department_ID` varchar(7) NOT NULL,
  `Department_Name` varchar(20) NOT NULL,
  `Building` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`Department_ID`, `Department_Name`, `Building`, `Description`) VALUES
('100', 'Computer Science', 'Sumanadasa', '128 students per batch'),
('101', 'Electronic', 'Watson', '100 students per batch'),
('102', 'Electrical', 'Sumanadasa', '100 students per batch');

--
-- Triggers `department`
--
DELIMITER $$
CREATE TRIGGER `department_id_validation` BEFORE INSERT ON `department` FOR EACH ROW BEGIN
    IF NEW.Department_ID NOT LIKE "___" THEN
      SIGNAL SQLSTATE VALUE '45001'
        SET MESSAGE_TEXT = 'Invalid department id';
end if;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dependent_info`
--

CREATE TABLE `dependent_info` (
  `Employee_id` varchar(7) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `birthday` date NOT NULL,
  `relationship` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dependent_info`
--

INSERT INTO `dependent_info` (`Employee_id`, `first_name`, `last_name`, `birthday`, `relationship`) VALUES
('10001', 'Kasun', 'Prasad', '2000-11-07', 'Son'),
('10002', 'Maria', 'George', '1974-06-12', 'Wife'),
('10002', 'Mary', 'Jane', '2017-11-23', 'Daughter');

-- --------------------------------------------------------

--
-- Table structure for table `emergency_details`
--

CREATE TABLE `emergency_details` (
  `Employee_id` varchar(7) NOT NULL,
  `contact_no` int(10) NOT NULL,
  `Relationship` varchar(10) DEFAULT NULL,
  `Address` varchar(100) NOT NULL,
  `name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emergency_details`
--

INSERT INTO `emergency_details` (`Employee_id`, `contact_no`, `Relationship`, `Address`, `name`) VALUES
('10001', 774522654, 'Mother', '20/A, Piliyandala', 'Kamala');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `Employee_id` varchar(7) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Middle_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `birthday` date NOT NULL,
  `Marital_Status` enum('Unmarried','Married') NOT NULL,
  `Gender` enum('Male','Female') NOT NULL,
  `supervisor_emp_id` varchar(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`Employee_id`, `First_Name`, `Middle_Name`, `Last_Name`, `birthday`, `Marital_Status`, `Gender`, `supervisor_emp_id`) VALUES
('10001', 'Charith', 'Rajitha', 'Perera', '1964-11-07', 'Married', 'Male', NULL),
('10002', 'Ayesh', 'Malindu', 'Weerasinghe', '2018-11-07', 'Unmarried', 'Male', '10001');

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `employee_validation` BEFORE INSERT ON `employee` FOR EACH ROW BEGIN
    -- checking length of id = 5 or not
    IF NEW.Employee_id NOT LIKE "_____" THEN
      SIGNAL SQLSTATE VALUE '45000'
        SET MESSAGE_TEXT = 'Invalid employee id';

end if;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_leaves`
--

CREATE TABLE `employee_leaves` (
  `Leave_id` varchar(7) NOT NULL,
  `Employee_id` varchar(7) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `Leave_Type` enum('Annual','Casual','Maternity','No-pay') NOT NULL,
  `Reason` varchar(20) NOT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_leaves`
--

INSERT INTO `employee_leaves` (`Leave_id`, `Employee_id`, `start_date`, `end_date`, `Leave_Type`, `Reason`, `status`) VALUES
('1', '10002', '2018-11-13', '2018-11-15', 'Casual', 'Sickness', 'Approved'),
('2', '10001', '2018-11-02', '2018-11-02', 'Casual', 'Personal', 'Approved'),
('3', '10002', '2018-11-08', '2018-11-08', 'Annual', 'Personal', 'Pending'),
('4', '10002', '2018-11-01', '2018-11-01', 'No-pay', 'Sickness', 'Rejected');

-- --------------------------------------------------------

--
-- Table structure for table `employementdetails`
--

CREATE TABLE `employementdetails` (
  `Employee_id` varchar(7) NOT NULL,
  `Employement_status_id` varchar(7) NOT NULL,
  `department_id` varchar(7) NOT NULL,
  `job_id` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employementdetails`
--

INSERT INTO `employementdetails` (`Employee_id`, `Employement_status_id`, `department_id`, `job_id`) VALUES
('10001', '2', '100', '1'),
('10002', '3', '100', '4');

-- --------------------------------------------------------

--
-- Table structure for table `employment_status`
--

CREATE TABLE `employment_status` (
  `Status_ID` varchar(7) NOT NULL,
  `Status_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employment_status`
--

INSERT INTO `employment_status` (`Status_ID`, `Status_name`) VALUES
('1', 'intern'),
('2', 'full time'),
('3', 'part time');

-- --------------------------------------------------------

--
-- Table structure for table `job_titile`
--

CREATE TABLE `job_titile` (
  `Job_ID` varchar(7) NOT NULL,
  `Job_Name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `job_titile`
--

INSERT INTO `job_titile` (`Job_ID`, `Job_Name`) VALUES
('1', 'HR Manager'),
('2', 'Accountant'),
('3', 'Software Engineer'),
('4', 'QA Engineer');

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `Reg_No` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `Address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`Reg_No`, `name`, `Address`) VALUES
(1, 'Jupiter', 'Union Place');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_info`
--

CREATE TABLE `payroll_info` (
  `Employee_id` varchar(7) NOT NULL,
  `pay_grade_id` varchar(7) NOT NULL,
  `epf_no` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payroll_info`
--

INSERT INTO `payroll_info` (`Employee_id`, `pay_grade_id`, `epf_no`) VALUES
('10001', '1', '700239'),
('10002', '2', '800896');

-- --------------------------------------------------------

--
-- Table structure for table `pay_grade`
--

CREATE TABLE `pay_grade` (
  `pay_grade_id` varchar(7) NOT NULL,
  `pay_grade` varchar(20) NOT NULL,
  `Annual_leaves` int(11) NOT NULL,
  `Casual_leaves` int(11) DEFAULT NULL,
  `Maternity_leaves` int(11) NOT NULL,
  `No_pay_leaves` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pay_grade`
--

INSERT INTO `pay_grade` (`pay_grade_id`, `pay_grade`, `Annual_leaves`, `Casual_leaves`, `Maternity_leaves`, `No_pay_leaves`) VALUES
('1', 'level 1', 20, 15, 84, 5),
('2', 'level 2', 15, 10, 84, 3),
('3', 'level 3', 10, 7, 84, 2);

-- --------------------------------------------------------

--
-- Table structure for table `taken_no_of_leaves`
--

CREATE TABLE `taken_no_of_leaves` (
  `Employee_id` varchar(20) NOT NULL,
  `Annual_count` int(11) NOT NULL,
  `casual_count` int(11) NOT NULL,
  `maternity_count` int(11) NOT NULL,
  `no_pay_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `taken_no_of_leaves`
--

INSERT INTO `taken_no_of_leaves` (`Employee_id`, `Annual_count`, `casual_count`, `maternity_count`, `no_pay_count`) VALUES
('10001', 0, 1, 0, 0),
('10002', 1, 3, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` enum('Admin','Employee') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `type`) VALUES
(1, 'Ayesh', 'ayesh123', 'Employee');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Department_ID`);

--
-- Indexes for table `dependent_info`
--
ALTER TABLE `dependent_info`
  ADD PRIMARY KEY (`Employee_id`,`first_name`);

--
-- Indexes for table `emergency_details`
--
ALTER TABLE `emergency_details`
  ADD PRIMARY KEY (`Employee_id`,`name`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`Employee_id`),
  ADD KEY `Employee_Employee_Employee_id_fk` (`supervisor_emp_id`);

--
-- Indexes for table `employee_leaves`
--
ALTER TABLE `employee_leaves`
  ADD PRIMARY KEY (`Leave_id`);

--
-- Indexes for table `employementdetails`
--
ALTER TABLE `employementdetails`
  ADD PRIMARY KEY (`Employee_id`),
  ADD KEY `EmployementDetails_employment_status_Status_ID_fk` (`Employement_status_id`),
  ADD KEY `EmployementDetails_department_Department_ID_fk` (`department_id`),
  ADD KEY `EmployementDetails_job_titile_Job_ID_fk` (`job_id`);

--
-- Indexes for table `employment_status`
--
ALTER TABLE `employment_status`
  ADD PRIMARY KEY (`Status_ID`);

--
-- Indexes for table `job_titile`
--
ALTER TABLE `job_titile`
  ADD PRIMARY KEY (`Job_ID`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`Reg_No`);

--
-- Indexes for table `payroll_info`
--
ALTER TABLE `payroll_info`
  ADD PRIMARY KEY (`Employee_id`),
  ADD KEY `payroll_info_pay_grade_pay_grade_id_fk` (`pay_grade_id`);

--
-- Indexes for table `pay_grade`
--
ALTER TABLE `pay_grade`
  ADD PRIMARY KEY (`pay_grade_id`);

--
-- Indexes for table `taken_no_of_leaves`
--
ALTER TABLE `taken_no_of_leaves`
  ADD PRIMARY KEY (`Employee_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `Reg_No` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dependent_info`
--
ALTER TABLE `dependent_info`
  ADD CONSTRAINT `Dependent_info_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `Employee_Employee_Employee_id_fk` FOREIGN KEY (`supervisor_emp_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employementdetails`
--
ALTER TABLE `employementdetails`
  ADD CONSTRAINT `EmployementDetails_department_Department_ID_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`Department_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EmployementDetails_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EmployementDetails_employment_status_Status_ID_fk` FOREIGN KEY (`Employement_status_id`) REFERENCES `employment_status` (`Status_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EmployementDetails_job_titile_Job_ID_fk` FOREIGN KEY (`job_id`) REFERENCES `job_titile` (`Job_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payroll_info`
--
ALTER TABLE `payroll_info`
  ADD CONSTRAINT `payroll_info_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payroll_info_pay_grade_pay_grade_id_fk` FOREIGN KEY (`pay_grade_id`) REFERENCES `pay_grade` (`pay_grade_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `taken_no_of_leaves`
--
ALTER TABLE `taken_no_of_leaves`
  ADD CONSTRAINT `Taken_no_of_leaves_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
