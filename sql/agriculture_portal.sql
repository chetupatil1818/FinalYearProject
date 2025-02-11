-- phpMyAdmin SQL Dump
-- version 4.8.5
-- Host: 127.0.0.1
-- Database: `agriculture_portal`

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `agriculture_portal`;
USE `agriculture_portal`;

-- --------------------------------------------------------
-- Table structure for `cart`
-- --------------------------------------------------------

CREATE TABLE `cart` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cropname` VARCHAR(50) NOT NULL UNIQUE,
  `quantity` INT(11) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for `crops`
-- --------------------------------------------------------

CREATE TABLE `crops` (
  `Crop_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Crop_name` VARCHAR(255) NOT NULL,
  `N_value` DOUBLE NOT NULL,
  `P_value` DOUBLE NOT NULL,
  `K_value` DOUBLE NOT NULL,
  PRIMARY KEY (`Crop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insert sample data into `crops`
INSERT INTO `crops` (`Crop_name`, `N_value`, `P_value`, `K_value`) VALUES
('Rice', 20, 25, 25),
('Bajra', 50, 25, 0),
('Maize', 135, 62.5, 50),
('Cotton', 50, 25, 25),
('Soya', 20, 80, 40),
('Moong', 12.5, 25, 12.5),
('Groundnut', 25, 50, 75),
('Sugarcane', 300, 100, 200);

-- --------------------------------------------------------
-- Table structure for `custlogin`
-- --------------------------------------------------------

CREATE TABLE `custlogin` (
  `cust_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cust_name` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `address` TEXT NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `pincode` VARCHAR(10) NOT NULL,
  `state` VARCHAR(100) NOT NULL,
  `phone_no` VARCHAR(20) NOT NULL UNIQUE,
  `otp` INT(6) DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for `farmerlogin`
-- --------------------------------------------------------

CREATE TABLE `farmerlogin` (
  `farmer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `farmer_name` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `phone_no` VARCHAR(20) NOT NULL UNIQUE,
  `F_gender` ENUM('Male', 'Female', 'Other') NOT NULL,
  `F_birthday` DATE NOT NULL,
  `F_State` VARCHAR(100) NOT NULL,
  `F_District` VARCHAR(100) NOT NULL,
  `F_Location` VARCHAR(255) NOT NULL,
  `F_AadharNo` VARCHAR(16) NOT NULL UNIQUE,
  `F_AadharNo_file` VARCHAR(255) NOT NULL,
  `F_Photo_Id_file` VARCHAR(255) NOT NULL,
  `otp` INT(6) DEFAULT NULL,
  PRIMARY KEY (`farmer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Table structure for `farmer_crops_trade`
-- --------------------------------------------------------

CREATE TABLE `farmer_crops_trade` (
  `trade_id` INT(11) NOT NULL AUTO_INCREMENT,
  `farmer_fkid` INT(11) NOT NULL,
  `Trade_crop` VARCHAR(255) NOT NULL,
  `Crop_quantity` DOUBLE NOT NULL,
  `costperkg` DECIMAL(10,2) NOT NULL,
  `msp` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`trade_id`),
  FOREIGN KEY (`farmer_fkid`) REFERENCES `farmerlogin`(`farmer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Table structure for `farmer_history`
-- --------------------------------------------------------

CREATE TABLE `farmer_history` (
  `History_id` INT(11) NOT NULL AUTO_INCREMENT,
  `farmer_id` INT(11) NOT NULL,
  `farmer_crop` VARCHAR(255) NOT NULL,
  `farmer_quantity` INT(11) NOT NULL,
  `farmer_price` DECIMAL(10,2) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`History_id`),
  FOREIGN KEY (`farmer_id`) REFERENCES `farmerlogin`(`farmer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Table structure for `governmentlogin`
-- --------------------------------------------------------

CREATE TABLE `governmentlogin` (
  `GId` INT(11) NOT NULL AUTO_INCREMENT,
  `Admin_name` VARCHAR(255) NOT NULL,
  `Admin_password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`GId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Table structure for `production_approx`
-- --------------------------------------------------------

CREATE TABLE `production_approx` (
  `crop` VARCHAR(50) NOT NULL UNIQUE,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`crop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insert sample data into `production_approx`
INSERT INTO `production_approx` (`crop`, `quantity`) VALUES
('arhar', 10),
('bajra', 176),
('barley', 0),
('cotton', 235),
('gram', 15),
('jowar', 0),
('jute', 0),
('lentil', 377),
('maize', 0),
('moong', 38),
('ragi', 19),
('rice', 0),
('soyabean', 3),
('urad', 0),
('wheat', 21);

-- --------------------------------------------------------
-- Indexes and Constraints
-- --------------------------------------------------------

ALTER TABLE `cart` ADD CONSTRAINT `unique_cropname` UNIQUE (`cropname`);

ALTER TABLE `custlogin`
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_no` (`phone_no`);

ALTER TABLE `farmerlogin`
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_no` (`phone_no`),
  ADD UNIQUE KEY `F_AadharNo` (`F_AadharNo`);

COMMIT;
